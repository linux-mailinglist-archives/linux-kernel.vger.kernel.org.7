Return-Path: <linux-kernel+bounces-874748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38300C16FE8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 22:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0697B405E9B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 21:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95619357710;
	Tue, 28 Oct 2025 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TnggW4ue";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Hrp0wkCj"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BBC3570D9
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761686743; cv=none; b=GPd0awcevpx7j45fyDFGD4xlB0GocLxPSxmZpEzTLRDPEOvuTjM9IBPeiIMYs6rnrAlRP/qbOGe+W94v1IUY7IdOp5R2PvsiZXWYmBJNTYk3j+ibcdn2svNLXX1U+pCW33F3tEx9tV30phiFlu0qCRDWs2IU9IwC4cbUEx4UmbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761686743; c=relaxed/simple;
	bh=6tzdUMnBDLHcEGBxx0GStn+k3emUYjHawO50lSO9HWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPD2LFlYmrOE6dNbLnzqyz++hHcDFsTnN/+5I801zBOg7zJx9Yg6u8c1aai2wmYnRJ7EbOet4+4OuuYfCXggspvXjqhHESqpZTMXxs2CH6yA9so78pfMxknbRuaUVPErOvCk/9fb92ODghhKs73oZod4WVhHqIaf8LziEy1xOzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TnggW4ue; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Hrp0wkCj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59SJlZ9d2575817
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=buWf0Ypb6OYJRaVhj46HKhwl
	jA+c0LfBLxaOuJMXUF4=; b=TnggW4ueFlJVAw+iErtFvrfcjR0uJa/t/JJVhDMZ
	4i/rjpK4ZspqGXiWtLGp/TfOOLVY1C3+NE1PZRE3NnruanL2pn8JIacL4LPK8QyL
	NhhAE5P8Ji1VbYZL42ORQYoxc6bVtaGuAm3zd/s0EL6NBY8zE984xqQUHABe9Wxl
	7iIrHlHtzdUXjts02Pt2pke/uGNjmt+s8XDbp6IP6ZtY87yJ04FFRJhR70QtBowe
	95RGCM+0wS6cxqQrFPOT3EHTn03vA16oUf3Lcr30YyazdTPFoGh5fE2nrauwbf9d
	XwbAP0LSfhvV1vYrMEy8aUqgqNVPLuRKGbBPmCOGbfP1Jw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a207ku-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 21:25:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8a4ef35cc93so814191485a.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 14:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761686740; x=1762291540; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=buWf0Ypb6OYJRaVhj46HKhwljA+c0LfBLxaOuJMXUF4=;
        b=Hrp0wkCjYiI/m5aij9hL0wb8WhKpV9SZgndri9DP9ySopGEo1MEx+bV0Ny7YaLfoW8
         HRfSv+F0RssYFAgVoLzPqFTV2phrhO+Fkiziz8P5QitmcQRtNsxkA8Lh1PtNMFd49qGX
         sCqMdSA/K+X7zSYDUfsSoC/ZxCJgNz7ukZozPG0X/Oa93d8SpOmPSYKoUC5xa6lmBY7k
         DQyphQ4olo0Eq/2VCzhaySBEm5AXwa5nKvu4DoOuyiRUzaMCezc8V+4JLkOWY6V8tQR4
         H6FMYflZmaXDh/ckC8K72ZZfgYTHUOQWUP9KG1mN/Dhg065mt+4BTJNm1EV67P4z6/7p
         gpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761686740; x=1762291540;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buWf0Ypb6OYJRaVhj46HKhwljA+c0LfBLxaOuJMXUF4=;
        b=geFvSYTyCyI86or7M2vpyLGf+580RSzYg+fyr6VYDrQzj4xcmYh2ULkIjDRVQdC5Fx
         3mM6kWaHWNU5g2Np5fvRHGzakmkQbwTHFfutnpy1RCUeVIcznipIUcCpqygpo++jLqvs
         lwiIEiX4q/wLp1wprj25XSyxLIPrOwFXhOsTPPqvOcNhwSERprbVp+FmtofJkN5tbn1T
         eJYmHarKIoJ1bxs/oxX6F4XcqVYRuTFBAmBi3wj5qZl1kmpaHWn/uZTCwtDll0OzMce/
         hwpp1zkJXbY78Fz8tWZdKwyyAY5cM/YYYsjIm62eXDTIiHtbYWGyWBdMF9paJ2/wxi4t
         z6vw==
X-Forwarded-Encrypted: i=1; AJvYcCW0SiBjio1pm9YQWnCW22GWlP7RA699JvbuQ4fy3Ttxa3iUhzr/BZAWV1b2HlEJ/7jXPPG+BXtmh/DwdDI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAdlHtImcsxM1zH9m/SRIejASTShle5sR8zmzAZYVs0h4UQS6E
	cBWgRhtnIvoqhz/KdhRu1qUobyBbt+18UOs8DCJlx0igTNpcwlR7YS3t6kZ51J3p9FdUuiesEyF
	d/OAJiK/ThAIjn6OHrjv15OiUoLBICay8nm4KWuhpewjXh975PrAB+sa5HbGBHiithUM=
X-Gm-Gg: ASbGncsSoNWb3hpDClnqO6KqnGPcrM4SkhKQrOROlqARcHcYl19247+6+wxYd4QOPxM
	RSCofp43UemAyrjj45UlmVUU22f0ObNXBUSoI5mUR0K8L9r8BHIHtqSVEQaw4pCKG9vXZsNePgo
	P1c45WFiN0rRMwZgRj070E7Vt9rIZ3aN1up+L3ocqQUmuYd6xXDnaQ73GoHAs0b6NypTSUEN9ai
	VOELRWoo8yHS8PDoJgshVq1zq6RDGctNS1/wZ0ffFUHSapUKvio9sFpyH3hTKuarRluYuomt3xl
	DwusFGemW+flOMIlx+DXUbTx5LQEGUuDIcQichBa2n/rRR6/0yZitLOS+73IsRkpdjSK/+D6UHb
	/h0kpaNoipDMX5PxmHxHOLgkt7oALOCChQfJCNo3NwsOjFcxCaE4Pa9r52bUAmtO2BpN+UxvMiV
	zrV2UngIiQYSzu
X-Received: by 2002:ac8:6909:0:b0:4e8:a560:d96b with SMTP id d75a77b69052e-4ed15c020b2mr10948401cf.41.1761686740425;
        Tue, 28 Oct 2025 14:25:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO5pCJUeWKODo7AqcDXtB24CKjFMyBTZ3ZE99nuuxHRCx3zn3Hq6WfRARXUseSiFF6FSGTDQ==
X-Received: by 2002:ac8:6909:0:b0:4e8:a560:d96b with SMTP id d75a77b69052e-4ed15c020b2mr10948011cf.41.1761686739982;
        Tue, 28 Oct 2025 14:25:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f8471csm3295318e87.106.2025.10.28.14.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 14:25:39 -0700 (PDT)
Date: Tue, 28 Oct 2025 23:25:35 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Lypak <vladimir.lypak@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Kalyan Thota <quic_kalyant@quicinc.com>,
        Vinod Polimera <quic_vpolimer@quicinc.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        =?utf-8?B?QmFybmFiw6FzIEN6w6ltw6Fu?= <barnabas.czeman@mainlining.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] drm/msm/dpu: Disable scaling for unsupported scaler
 types
Message-ID: <a56tw3xxxn5u54hs4pt64b5ljlp26x23lvftu2tblwpvuzx5xh@quyr7xyn7sn6>
References: <20251017-b4-dpu-fixes-v1-0-40ce5993eeb6@gmail.com>
 <20251017-b4-dpu-fixes-v1-3-40ce5993eeb6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-b4-dpu-fixes-v1-3-40ce5993eeb6@gmail.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE4MCBTYWx0ZWRfX4rexGX1kqNjl
 4bHzPKFnRvlSuo0Mw2Pd5xgJOCEd65JBnSL8Tfg0DrnM3bLzIuFA/SI4cRPJkdYKslo4cBZJUeq
 U3CxIz0uyHDFwtTX5m9atPbcsxUJzVbLJ7P78yPjdbWR0t2aug9u6UjDAfgX17oOtSyTrmqpE4Q
 urzFE741tfRJ++WhIi1ti+a1O2BytUNt1QQ34PhNljqx7YNDwAdG81UzXINO0L3hlony14YkrpL
 V2HfbXbeALLQsIbEH1ZAwy5tLK8+gPEqcbVXg7ciXLaYMuM4mhOdqgvCeD0nxh/MaFDd+ya3EgM
 jAkZwTg83G73IVcuyXF2PGP3bSzTdfqPmP1Msb7vswXY//6UxWGwUlrahATLcL3U7zaC8QRPJON
 e4hE6pViRwdPlUpxaR6S3+fv9nlueQ==
X-Authority-Analysis: v=2.4 cv=V5ZwEOni c=1 sm=1 tr=0 ts=690134d5 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=LqUZSzWJFxV8yDGbkgcA:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: iMp7vSnTnGeXeg4ucxYlDlgpQzNYBhdY
X-Proofpoint-ORIG-GUID: iMp7vSnTnGeXeg4ucxYlDlgpQzNYBhdY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510280180

On Fri, Oct 17, 2025 at 07:58:37PM +0000, Vladimir Lypak wrote:
> Scaling is not implemented for some type of scalers (QSEED2 and RGB) but
> it was unintentionally re-enabled with change below. The remaining
> condition in dpu_plane_atomic_check_pipe is not enough because it only
> checks for length of scaler block (which is present). This patch adds a
> additional check for setup_scaler operation.

Nit: in future please refrain from using constructions like 'This patch
makes foo' (see Documentation/process/submitting-patches.rst).

For this patch:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


> 
> Fixes: 8f15005783b8 ("drm/msm/dpu: move scaling limitations out of the hw_catalog")
> Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_plane.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

-- 
With best wishes
Dmitry

