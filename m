Return-Path: <linux-kernel+bounces-842799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22009BBDA36
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 12:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E348D18968FB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EC42248B0;
	Mon,  6 Oct 2025 10:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LvzBBO7T"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694D7221D87
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759745560; cv=none; b=QXPr4rBcltiS6sPSOSzq3UL+wJTgRYLI1gYP7Je19cnnDMCytwTVf0Hzg4OvnyS3wZc1scDna0cYs53PCFx7qVCE9EXiXieCrUUM+YElm/q9CGs9zG6J9urFek0xbF+JoqanvLA4c4VK230qlauLZ+BrfKmdoPZVpkR1wfwUFoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759745560; c=relaxed/simple;
	bh=yC8qDztRmXd2wzVFIUgYhjND7TqP1DFur68MAZODzUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPfdtOuZNsz0t7Y4tjsFsRXc30kGnO+smNPxlroGRKvFBqxLaJ0SuuoH5aNwp5dWiWamlWocqfTvH4Y0WBm9HxjFCH2KWx3i3bmTcJTlKfNn9HPU2sDI/eynpTKK5TmDjsLXHsK6NtbYmMKzHmk3trLzv/Y0LEK8+bO1Ghy/dQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LvzBBO7T; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 595NKPA3011762
	for <linux-kernel@vger.kernel.org>; Mon, 6 Oct 2025 10:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9DjbUCmcg5sdBYa+VdHMlxmG
	F69VZ4TGKs8z0vOln+c=; b=LvzBBO7Tq6twkF4N9J/m+/YuUV4rwSzLlYC/Ifla
	9RZ4gWdS6Kg+7bQar5P2YZmvUZgOzJE82hLZi0lVm5i6oM76F2LamB+hvpcgazMp
	E5GA1m/kZEVrdKXlQC1naEH7QLGgNCvvmfkMthYsMh9wVmdm5IKB0KMuqCq44HcM
	FJctnQqcBCbrgCTjD77fd5C3SctiSipcXD2jly3UBsea0OpYS/0RAkJ0TqgVDk/9
	iYEY/eZFWZfXtOiTp1de9j7E/TOtlc53XbdadMLJ6S8iP8VlLfIiYrpDKeD3zduT
	ZbXovSucBY2cWrjowhyY5g96rXsgFSJyVwlmJSSj9Ra4rQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49js9durb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 10:12:37 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4df7cdf22cbso144644341cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 03:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759745556; x=1760350356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DjbUCmcg5sdBYa+VdHMlxmGF69VZ4TGKs8z0vOln+c=;
        b=AC0Lzj0pgEiPoHx8UcUxtf3ty3pyCDZNHF/w8wwm0RzKd0S4agOCWdjBgieNy/QEjY
         RRXgFrI2WxCR7na65ERkMHXwuJK3nvGkG6MGxvbq0O75UYmYqfuR/TxJwpW4da7/wjun
         0LZrVTN/TaSEu9A2uEqw4xSBX2QRJ71l1lGAjpUtObhjn4LDT5mzhv0KMaqYevDzLj3v
         tbTz+WRuG3deflQW6DQ08Qn4NY8L0u2uORjLcy10d6dxrahiwycM26iE1Y5KmSqU8Cen
         PKa+YoQTHWKkJI8yXGbxMbya4lA9uEb6NG9mOD/xY8SU4fmFDRzm5E0QBM37/eQMtTbz
         SEWA==
X-Forwarded-Encrypted: i=1; AJvYcCVnPzyUtAX1OuUrEqeiywpuobsnRC7At52YkQ0PNY/Bol8b6GuUZ7hv0Jn6VTpFv2SN6YPh3Pc3kaaq64Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV7LLfdbH8D3W7UBiWhWXn8Y6AsUF35Ar4WdnSCi3Jg2UDBEQf
	vM/xuTm38ZZFx3UKXd/o/QrI7nsZggDQQyq75xMjGCn+IDUGXzCDMuBeooAQwTb21TXACCuY5xl
	Hb+x9XYkksWzCPSp+kZMIDqW+c+RFtJD4M8AB6d3Y1VCoHzuiaZ/EV75pbFPmpu0zVMg=
X-Gm-Gg: ASbGncven0rlTqWk0bFyxbC09mJFwYjPSZqdqOWFRDOXmlSyBfZr8gKnhCw7pGhfBLm
	HvFQ2JpTbac+R8bhNjWEu7rb4umYTtVI8+xm/o0YShiE6AuZi2CMI/Ls93X6IZf9ajqYOV2+LBR
	NE5qwjf3acfYAD5LUqUkfPBMT8DVhnw2yZGz9cLdsAiRuhG7MXGgm+bHwZajUnVV/wv2Om6W9IR
	VulmG8agbrFd3deKp5/XgBkc5D6QInu0PZImc0DLjoWRYce/V4CYk9idwLmcZKrYvcRVcvLaq0j
	0bsDmTJfdblhRw6oqeOl775m9WGIznY3QBh8Je+de0MK64RJQo0scczW/LJAd6c3feHLMvLMyUn
	nfb0G1eo5eHF6rZA2ePumbmyD+BTTbSb5Iv9VQJI1exZDD1lrOoTo9MCfyQ==
X-Received: by 2002:a05:622a:130e:b0:4b5:d6db:eea1 with SMTP id d75a77b69052e-4e563c5da0fmr209850521cf.39.1759745556287;
        Mon, 06 Oct 2025 03:12:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVYsEsv3GQHoe9XDvDjqIIC4TE7FK2OBx7RMlbBeqiTU7xwK2kdO72i5DVh/m7khG5Kv9KDw==
X-Received: by 2002:a05:622a:130e:b0:4b5:d6db:eea1 with SMTP id d75a77b69052e-4e563c5da0fmr209850151cf.39.1759745555626;
        Mon, 06 Oct 2025 03:12:35 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-373ba44441dsm42561471fa.37.2025.10.06.03.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 03:12:34 -0700 (PDT)
Date: Mon, 6 Oct 2025 13:12:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Ayushi Makhija <quic_amakhija@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robdclark@gmail.com, sean@poorly.run,
        marijn.suijten@somainline.org, andersson@kernel.org, robh@kernel.org,
        robh+dt@kernel.org, krzk+dt@kernel.org, konradybcio@kernel.org,
        conor+dt@kernel.org, andrzej.hajda@intel.com,
        neil.armstrong@linaro.org, rfoss@kernel.org,
        Laurent.pinchart@ideasonboard.com, jonathan@marek.ca, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, quic_rajeevny@quicinc.com,
        quic_vproddut@quicinc.com
Subject: Re: [PATCH v2 4/7] drm/msm/dsi: add DSI PHY configuration on QCS8300
Message-ID: <knlsejrmxfzgb7qdy5hpiawuxfg6b5hltjpweope2hl3dm6liy@y5yop35p5afe>
References: <20251006013924.1114833-1-quic_amakhija@quicinc.com>
 <20251006013924.1114833-5-quic_amakhija@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006013924.1114833-5-quic_amakhija@quicinc.com>
X-Authority-Analysis: v=2.4 cv=Hrl72kTS c=1 sm=1 tr=0 ts=68e39615 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=COk6AnOGAAAA:8 a=tMqVXGxUZ0RuQ0S_Ei8A:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: -iqPtm0ujpIZoDbWmby-JIa5sYhxYJ4C
X-Proofpoint-ORIG-GUID: -iqPtm0ujpIZoDbWmby-JIa5sYhxYJ4C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwNCBTYWx0ZWRfX15EaamAcMLvI
 EuKIruJ70i12oq7p7A3NBGw1chly7BJpESsC7PNuOAtpLH54AF6ioXXiSVCKxkh8ypHDf+BlSHv
 ocsmP7HAM1zSU6ndshNSKGZ5IK7jetQnNN6brS8onpyHnzjUaV6NFYt3GmwOngjd5QbzT4gPxRj
 WRPXbheW5Li8vwa06aI5LPWxvH2AxeRvq/RG/g5I4gWO+bNgKslvY1m6+OKH978Ya5+F2PA55rH
 Q4mNT34TGwygaOoW9movRVg5igkPWvdeQEu5oYNLAwDmxNihDK15S5YjFyPSSL7cw139BEe0h1T
 Y6L/xsvcbV2Z6larKScpFP/kXNnqW+uPf8ohAy7EYLlWRGOgg3KbakuUTMDjnNYwLd2MIfS74Aa
 4nWUyMb9B9eC9i7FPo2D0KQyHEwEYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040004

On Mon, Oct 06, 2025 at 07:09:21AM +0530, Ayushi Makhija wrote:
> The QCS8300 SoC uses the 5nm (v4.2) DSI PHY driver.
> 
> Signed-off-by: Ayushi Makhija <quic_amakhija@quicinc.com>
> ---
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.c     |  2 ++
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 +
>  drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 23 +++++++++++++++++++++++
>  3 files changed, 26 insertions(+)
> 

The whole point of having the compat fallbacks is to remove the need to
modify the driver. Please review how platform bus handles binding to OF
devices.

-- 
With best wishes
Dmitry

