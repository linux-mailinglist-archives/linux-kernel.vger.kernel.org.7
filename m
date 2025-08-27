Return-Path: <linux-kernel+bounces-787457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BB7B376B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 03:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD4B2A645A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 01:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F244728E00;
	Wed, 27 Aug 2025 01:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aUJYYuwf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDE7134AB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756257522; cv=none; b=RvVE9jey3+o6Q8zmaGoK3g2Qt9I381102k2biihDJiu4sWbG7WFcx2WyvVQo+wH3z5CTFMmbOomR/jxEkaKCGAGTJiGjEupZ4mqCgJH5I2CbRP1/4rR9EFtZKvIfcRCVgXljPRZNxc7p5oDp3XiHntSHyjxxM236l8X1Ttl9/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756257522; c=relaxed/simple;
	bh=fHA3mzUAXqJvLfjfjKK/r45B7b0zgHidGy9xFM6J7NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2UCBVvTqrELGvWlbF0KcJBZorqd5V8k5y9DYZOhuLMS5wJFrXBGyr3LHVjlMOWax6IeJgWSO3YO0WnsA37v/dkeZ79ceA39GS72B2RoTVmR6m44Nrae1RRB+1VfSBZCneASVep9v2FfAtovqUoTuTSgL6Em/eIj+QUdyxIFKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aUJYYuwf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QKs9VZ007038
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Bx+duUP1GALERBeSBTVPOrXM
	scOH+ezdQWGpYAtJpSQ=; b=aUJYYuwfAjFvp98BcSfP9wgOvviNGgAb3iP/Uyeh
	bBZajVeViijgS9PvK0tayRC8E663JaLFc1TW2wc9yW9NTzWdct/Ktwu3WYaahJ7a
	CvaB67tBd/ERl/Q5BxfuMavD009wwGPSnkVDuyQAEB9IukNJsbkOWYv0z4LUo4r/
	ETVF0iTRrWZ5FJN0tPoYoVPgJdCXJyerzFruYWehFJaX+uj+qX7sNb+RplTrQFic
	qgBjzpoA0uHMBSZbp4yLslNTFpbAYK6w2WN0hkhTWxz6T2mLvvPUmO+v+GsPw6NM
	mNcQd+1Wq4b0NXFQCZ0JtdXRj8rd1v5wi+Zek7+UNZDhLg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5umb0bw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 01:18:40 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b10946ab41so13818101cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 18:18:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756257519; x=1756862319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bx+duUP1GALERBeSBTVPOrXMscOH+ezdQWGpYAtJpSQ=;
        b=gotltJASmY5PCB+MbAnyeNka046ammR98uXJyEicR5K/4jqbj4/exephmHGr7lJcXE
         Mesb0xkufy496mMzgjdxH2NNVg35wKoudR0tbH9MZpoEUuea/gxfYgr+vOFcANkTL/Hw
         uYaMagmMfHRVzK0DKN/yIp17K5AMvUtgnmAjjHWE+fAiQMgULflcgDE6c10ndNMzuMHP
         XObqkG5dFBKT9rJ6TxMqFKIuSLUiaf7CO3VBbRuRB7S5upHVKeh3xaOFnPms2ULNMdZG
         KeFOZmknZf73suu+QhmGGshkmHKcFFlqf7SczSvIKR3abNnpp2d6OEq832GzRdgzs6G2
         IDmg==
X-Forwarded-Encrypted: i=1; AJvYcCU7/3ImZR4CLqSIl87fICjzieVCuivbcOqpnYwjsYhP9c+XefrH8dTUrEq6p7IRW2SwWWqlho4ydzGmBrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGCPknFaBBdnv2kUNp9MqShi1Cl9KRa+QFHLsroEwb+M68vLhk
	yjfEODpAhV+HQHsZ7l4FSYX8yNKLmU+/pqp02mfbxlQV4th5DmrMa/fr2/ZsHR/rCeeh/3vNk7T
	y7kurKdcW1zvvHUTZwFZ5dtJzIZHDzGBS3aSSf8GcAaxp8v215C6F8izTkxBJ/2tzm64=
X-Gm-Gg: ASbGncsN2xZpQ+mlRjKhML4aNDGKoGpck9c2/Sn4IOmHMpRF3lOiep2XDkwud3YFEfa
	kV61sTQJSEcEcM/VqljhZh3g8rdcZXtTIjrWa7EgQkV/3usACSD6+BJYE6UX9VKapj3GQqSfUI1
	3ouYzh/lfJcnqulsTLc8XfKqBWy0MVqWuaQAdP/f6Aig1YV7TICQkJ194E2qQD+n1i1chXAN3qr
	qtcJmE28dfMoTaDWoVZ1EPNRlfImYst6u3dSpyXMK0EvK9QpI0fkkAM3TG0WTxMhJTBkj10Fkcb
	aXX4WgmPSdvnONx7KWS95PNDnEUDLXQ2BLHqRkD8VjWIDAp2ngnwjO4SncNh0gFzGmT2SlV96B0
	4IO05n6+7kCXEqufLwv23cTZHrVbLhJyhcsey0RjuFqjqifXIxgOF
X-Received: by 2002:a05:622a:5c0e:b0:4b2:9b79:e6ff with SMTP id d75a77b69052e-4b2e76f6c24mr36188141cf.7.1756257518810;
        Tue, 26 Aug 2025 18:18:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlWgyLt/FiqiOWOJS0LqGdTAYap/k8kB9YXuoapGqnOCEle6fLztfOxdXwebefsByFu+0ZLg==
X-Received: by 2002:a05:622a:5c0e:b0:4b2:9b79:e6ff with SMTP id d75a77b69052e-4b2e76f6c24mr36188011cf.7.1756257518351;
        Tue, 26 Aug 2025 18:18:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f35c02020sm2529995e87.29.2025.08.26.18.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 18:18:37 -0700 (PDT)
Date: Wed, 27 Aug 2025 04:18:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: Re: [PATCH v3 37/38] drm/msm/dp: fix the intf_type of MST interfaces
Message-ID: <pp7s4wyvchoe2en6xqtow7cw3wfjfgnb5lu2l4f26azwssolpk@ydjm2ezqumu5>
References: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
 <20250825-msm-dp-mst-v3-37-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-msm-dp-mst-v3-37-01faacfcdedd@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68ae5cf0 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=ELchz9PJ39Up9ouDmgAA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX51/4i3PDI2KR
 IBQpxUFGAQs1NCZ/6mr+PCvLJbQb54he10/ph5umIpGxq8jHLmf9TzY0reBk/J12s2NtHpFdJ82
 DJKvcqc54x7Hfr2Jytj+wB90Wk7PW0JbnDcE8d11PS3AnzPuk4PIfq5p0mDh60cmKojnMT3KjRm
 dFh7LIdoRdSOBNQdtE757KnkHhSjTqslrlaeIWrrQ4CXfpVPalp4qSBjFFs4kFiCSW0cvIvt5EZ
 N8/waWK0dCVbWMNt8TsbxEqJfPecQa0kycWXWhnBCLkfb0EebFo8WHZBnPZpeFX9yIdc0rQDEgK
 O6kckUmvohuA4G2jQ+k6AW27k/dusRo95/8HY98etdsox5CU1XquFwLL4hR7wMjX+AKq8YHDWWq
 80bT9dnw
X-Proofpoint-GUID: LzFWnQELRE5p-bNP3do6ak_j8m_YHj0o
X-Proofpoint-ORIG-GUID: LzFWnQELRE5p-bNP3do6ak_j8m_YHj0o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032

On Mon, Aug 25, 2025 at 10:16:23PM +0800, Yongxing Mou wrote:
> From: Abhinav Kumar <quic_abhinavk@quicinc.com>
> 
> Interface type of MST interfaces is currently INTF_NONE. Update this to
> INTF_DP. And correct the intf_6 intr_underrun/intr_vsync index for
> dpu_8_4_sa8775p.
> 
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h |  6 +++---
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h  | 12 ++++++------
>  drivers/gpu/drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h |  6 +++---

Also, as far as I remember, INTF_3 is not a DP1, but DP0 MST on the following platforms:
- 4.0, SDM845
- 5.0, SM8150
- 5.2, SM7150
- 5.3, SM6150
- 6.0, SM8250
- 7.0, SM8350
- 8.1, SM8450
- 9.0, SM8550
- 9.1, SAR2130P
- 10.0, SM8650

Please update them them as a separate patch.

For this patch:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry

