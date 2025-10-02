Return-Path: <linux-kernel+bounces-839759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BBBBB2571
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 04:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82C4188BFDC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 02:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816FF1624C0;
	Thu,  2 Oct 2025 02:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TvRi8Txb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2EB126F0A
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370778; cv=none; b=Zir+P5RKp0JJjt5Y+Lh3Dzs/jkGRyMfPJNaCnjTjML0/1WtZXmpeRILokdPanlnPWEahDdlRezeDp5Q5CeITui2RDPRQKeZQ76nQHoyrchqFnjcWVDuOaHQP7H6xlVcst7wXYmRxvyAPDfDG2EiQZ5jl5BazS+QiULZvqF+gs0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370778; c=relaxed/simple;
	bh=xhmmYS8ldwgF9fQ7gsr60vedDHtDIGYmWzukO0O0yUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c6dIIDNFNhyJT0IKSGupraNkGFIP00hpu6Ab4m4gmFEN8JKrlOPhivA2ExG8wuLFtSrADWp6edbv5CZD3RrV/D9WS+YwvNsSiOQAqer8A+LXQMxSNhU01/rw7PqrfVTSYTqnyS7U8Fhaac/Sx/D3yfyxe6CmbPqNLWWlj/CcjdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TvRi8Txb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591IcGi5023847
	for <linux-kernel@vger.kernel.org>; Thu, 2 Oct 2025 02:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NlrjA10uPReWQuwGTVDaUugX
	z53bpDjEyE/kchavb4E=; b=TvRi8TxbgWvgUo1WWy2/Rvo+DOvuAqmh5Vbudg+n
	vwQueuWQM0xHvxK3pIciNagT63m1Ela/+i5u3YBwLtZPijpF8DFXgqgZUrKBFfVu
	CCdu9K8spiW2Tt4gj+y8jzNzGr4WUHA9wPhHPXIYvLAvCmLgELAc9yzS9FWtfThd
	9FMCSRLIAepxmYa7svw+AJpEs/u8y12Y8vz2+spJ1KnjZIxjeA7bXZ0idK8mJ5oq
	nLI56sCsrE5h+CDlO23shFhJzBE947oYglpWgmxV/QHqd7M0u1/ZOz81KKnQmBpn
	2JO4Ov6V+k5ZFEU2AvWP+G16JjMgT1vI+YacIFhVodSRDA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a66ejb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 02:06:16 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e1015c48c8so32590791cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759370776; x=1759975576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NlrjA10uPReWQuwGTVDaUugXz53bpDjEyE/kchavb4E=;
        b=AYHAYUkZ7CzcdnK2nM7fhPazrNhREJdeDz9rRCfFuedHJBrEzI8zczeNmrrnCficIE
         1IQ/XQCQe2gII1+6qDsvEzLpehSZT7D2pQPTg06YGRVFMhpRwE3MUAzdjUSK2otHeejF
         +ESb2Q4KieVLfLQ1yAkpuZm8X0d12vr+Wge1NtR6snOkhx0kP1b/7nEhh6s8LxR7lYqA
         LZlXf9pdlhjKRPH1UQo4x9rlsPjwl2YsQj5SLcu8jyCBzqXeZJkFsEyp3dRrSG2a5uHU
         M+VhgbGuqdXi/BgZw8m0xtVIyXBB+zfotHXcMzVQOu8PvzCyRpMP3YWgti5dBmPn54bs
         K3VA==
X-Forwarded-Encrypted: i=1; AJvYcCWgbqfUmm7DoZ6KLD8IselK4RQRICaibhkN7eGs4OWTHR4f+qgZMZ91KvKFpP9aPZ5ogC0KmmqMLNiVazw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDs/6oBRUWlT7JbgUVpDIvIAcIl9/t9cp9rpMXlrd3vjLG1Kjk
	aSMF8t8nkVRCSS8RLKgI2PgS2Sg5YlPe8A0d4qc2xjgiUVnuzXcGTIRVoXKW0l9oHoH4/xLvDwC
	rvcOf3mC8XalcGsmYZLswU97knB4vuY/di7PNNSTU5gvI+07DTWnx+Z/FVkxDqihzCp4=
X-Gm-Gg: ASbGncvQ0gP2/+kgw+URq7P//ggD4RAy1pmov9MXW2Xp+lTSoiwxfaRPiozQ2RhjSaN
	QimWRQOF4fvzB+kTBp1DYP+ocOLT8ohbnrQAXeyWlWeEfzQ3HJvUZ9+eBtQ01TWWVtNNOgk9yu0
	+rMUn2udQsWGvTLWpXALvRKVtZp/3LVmlYudto43nTeHW8D7R4Ion6Va6ECE9z1jT8qWEZ+kFy4
	MXz0/SlePIhLcaC62uCV9L6KyxL61DXhfGMd8MdEfBuL+jlzcKENgQ/B9SYG9JIH6FPtHOBCZiY
	4JZ51o5gLoJIhRZ/DpNMcmNKGSwlWOW4Gd7/S4mlJ5iHZ6HzECUkkZYC5Y00hBjQcOjiG5pf4TS
	SgEuFm3K1yVgsIufLqyf3QgGB7nr4zjUON78d2zHaU5dVqgGMhOOUr6/idA==
X-Received: by 2002:a05:622a:288:b0:4b2:8ac4:f097 with SMTP id d75a77b69052e-4e56385cc7fmr27596571cf.33.1759370775637;
        Wed, 01 Oct 2025 19:06:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnmEEod2O1/0uzDDtH9aXoT0ph1E9BnSq1tEA93bbQlG57iNx6XpWIS3N1TkSkZ765Y5FXUQ==
X-Received: by 2002:a05:622a:288:b0:4b2:8ac4:f097 with SMTP id d75a77b69052e-4e56385cc7fmr27596291cf.33.1759370775171;
        Wed, 01 Oct 2025 19:06:15 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d3e6sm364500e87.63.2025.10.01.19.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:06:13 -0700 (PDT)
Date: Thu, 2 Oct 2025 05:06:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: george.moussalem@outlook.com
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Baruch Siach <baruch@tkos.co.il>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v16 7/9] arm64: dts: qcom: ipq5018: add pwm node
Message-ID: <ya7h4l2cf3mx2to5pyw6ap642xvqjbhwv3ugcqqp55gaq736tx@ksnzcbeb7bvv>
References: <20251001-ipq-pwm-v16-0-300f237e0e68@outlook.com>
 <20251001-ipq-pwm-v16-7-300f237e0e68@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-ipq-pwm-v16-7-300f237e0e68@outlook.com>
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68ddde18 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=UqCG9HQmAAAA:8 a=EUspDBNiAAAA:8 a=pgNS_SGoCABwbyoThYAA:9
 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: rVGjoMACGKjA3svadP8Dutl60y4cenHW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX3brQUley1QE3
 f+MSwxiKOghg4mhT0FATfa7OSfAmbkyjnZdO3F2FksmDX0j9/KJkjowNvpm/QRBHsLP7JXmaBrf
 CEl4ctzL4gualtEUlB5UUjc4doU1246+ckq4y3MZA2Rn1xNc3WH93AuglS3mBJ88KQxoz2p6fJe
 08VUeAfJFrm3cr4xJIgrKixbOulMP17k7DnYx5djG3OQ2pJZf6HgbwLQ9F/NJ9IVelO2GIm/iq7
 ZblgZrjHatH29D1Vn9biHDt7PuAe/IHwerWyN+Ir7ZkUT22LnG701wy6rpCCPBRXZfzjr+kwNkC
 l6GpTBuOvnjnRfxN6XDEiuqQ1QbSLR+WnDAHN+IxXGQ38+PfbO3E4StqaxWDll6AcqlMmjfOt56
 6BFBpBWaZ/F52rndYWvyW0PG0gWVEQ==
X-Proofpoint-ORIG-GUID: rVGjoMACGKjA3svadP8Dutl60y4cenHW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-02_01,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

On Wed, Oct 01, 2025 at 06:04:23PM +0400, George Moussalem via B4 Relay wrote:
> From: George Moussalem <george.moussalem@outlook.com>
> 
> Describe the PWM block on IPQ5018.
> 
> Although PWM is in the TCSR area, make pwm its own node as simple-mfd
> has been removed from the bindings and as such hardware components
> should have its own node.
> 
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  arch/arm64/boot/dts/qcom/ipq5018.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry

