Return-Path: <linux-kernel+bounces-762363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7224B2058C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 12:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2C3317EED6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 10:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2C326A0E0;
	Mon, 11 Aug 2025 10:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WMyw98jp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039DD23D2A0
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908430; cv=none; b=Sggmprnd1j4wLyN2mCwmL5ypR51O7twazfTXzSfzKMHimAT/FcFNE0ZPPQc2+jYky3IDPDv5SgN4pKpogTEjCB9PY3qvT6P822GeXXRVd47qcpXh6Owysar9Cco9hSXSzHvSRD25JJ8qMIkMOSeEkFXkVDKSLTyoqm540YhK9+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908430; c=relaxed/simple;
	bh=n6bYWBbuvYgd7Of4AkNGNr2HVdrMAtKaVoR0TN1D2LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gUJRGXKYccj2HXMjMOzbeHcZJdcDX3tDkQA/jpDfjUZq+gx9UuUrU1lfynOPIfgy1v0OzkOtaC/OGG4zqPQoErJ2nRsW1Y3+dKtbSJSnSaB+kIM3uTAP+w1CRZdJHNmYskz+no4SVHC6gaqAS2UX9wcdZJPwFycsSoCcQhCI790=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WMyw98jp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B9dC67019164
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	wsD7GGJiNnfcvjretasZ/pNIYgJDbc71adqR86O7WrU=; b=WMyw98jpN7dFuV9+
	Yu15OlRj+5Qv7PUFwt0BSU+6s6tZycYVWK/ruJYvkkNgbufHn3KH8UK/yMdoMt/F
	YQLO6mOKbEqbCWadvtBiTKhka5XR0Ad6e1evnoPxHSInZd/l/gb/TUroqcK0T8lt
	vuZn5C7x+86jxq+biDBWIlpqjHsgoKlEwbA8hRSDwnlrOt5XKc764sYiXru2E6BH
	OGzNVvMvQlxPQnYbD8jedvQDZgiwrEri2wLw8Qx8u3XXteytA3tFBgN2F7tosxQq
	CJ+4SnwmZM32zOuMBzpllDQWfMExHL1HZ32Fwcv8fwwOp8t3RFq+NpPwyMCguUp0
	UurXzg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxduv0gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 10:33:47 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4b071271e3eso10786091cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 03:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754908427; x=1755513227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wsD7GGJiNnfcvjretasZ/pNIYgJDbc71adqR86O7WrU=;
        b=a490g+FYBNvN4o4NU/pylJMANwDiPFf2m2XimM7W6GVxHTWlQp4eCka+HO/06nCKW4
         pu4zNmCl6w8ETqrosFiAN++CYrCNQhGkdBr16cT9oXIOpSTWqdLhS10uWQGxCz7qpPaT
         jBz0bxzvCyqRD1w3sSjy5yp4tpsCDEId//CT/ndBdM3sxJHnnc6uvBMh5ws3Kmgtoyhb
         1D1EgHRZFwHnPiIYUbg9W1T3e3IkSBlPinK+I04sP/yLaW3AuO7kJ8yr5ug4tbcgJbCP
         u3F/f8yxuGHElYSg9XAc+dkeyFTPjwnIYTFWw9HgvwR48kR7Co1jZHXJqSoUHX20niFY
         VVEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBEFXdpOpFVSQN+T7nnBH4hdOT/OaChkSkp+THj6A1fPuyNCIY394VJP3Q3X6gu36Je4KiiAyJsFbdWN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbWrqnbT8T3GrG5KjkLCO33XemFTdTOc2+XLqoRudFa4XeqQ4c
	17XqGzywq1+q8M+8X3m1zZ8nbWCc1SYsSxAaQ0Jea+v+rsZNUaxEcuOC2s7Ih010h37XVe3Apim
	NR8NnxdrtsD5qKtkxqXBpt70QuAkD4UIYG8HqqFAInSwwFNEQe7CbMVnYT4nVXhVYrdU=
X-Gm-Gg: ASbGncsuHcxuYgSiX9j8Bwch15zHcxsdLq+1mguclzYT4U/K8CTDB+IUtDhYnsOWJeq
	daHZQlH1r170a445gX1UHSq4lOdp9TPNqpantMQbIpRk2YhZUN7GBtYLnZfw2CREvRafiA9cfWX
	guqE2K/VGGngO0+hVaZmWvk1u50l5pHIwVdRgdeKI1SNtlswhzprA1bprq2cb1c4vm+w9MIzIEM
	GHPIgtjsXahD5dnQv3liftMk1ZiT8SUMntEFsQUMaf7pn5M0lmjgM97EcLxntcASekKnjY0msVR
	KSj4+1AYx4DfWixvV3Jirp2gldNeTHlNM9FL7IyfJqTCJkO9hRgxaYYTcDh+a+KYefAUy1XC2wE
	TrgNP/VWa7UpbsVP14A==
X-Received: by 2002:a05:622a:cb:b0:4ab:6d02:c061 with SMTP id d75a77b69052e-4b0bec78c73mr59284241cf.6.1754908426863;
        Mon, 11 Aug 2025 03:33:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7IhssFNIcGhOq/EGToUOu4T70RVm2dw0NQGyrObWdTLIgVbBy5n+ITh6LfbnZCeVTNL5pEw==
X-Received: by 2002:a05:622a:cb:b0:4ab:6d02:c061 with SMTP id d75a77b69052e-4b0bec78c73mr59284121cf.6.1754908426385;
        Mon, 11 Aug 2025 03:33:46 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8eff60esm18546387a12.13.2025.08.11.03.33.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Aug 2025 03:33:45 -0700 (PDT)
Message-ID: <727350ad-720f-4751-8348-15914072ddfa@oss.qualcomm.com>
Date: Mon, 11 Aug 2025 12:33:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/7] drm/msm/hdmi_phy_8996: convert from round_rate()
 to determine_rate()
To: Brian Masney <bmasney@redhat.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov
 <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Maxime Ripard <mripard@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20250810-drm-msm-phy-clk-round-rate-v2-0-0fd1f7979c83@redhat.com>
 <20250810-drm-msm-phy-clk-round-rate-v2-6-0fd1f7979c83@redhat.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250810-drm-msm-phy-clk-round-rate-v2-6-0fd1f7979c83@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=6899c70b cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8
 a=aS93HcZ8ji4XsMPHnqgA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 2MZChPRj5XXHbJQjw8Xbny5tdmtLICzA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfXzHytcBM4CI2I
 qvhh7r0d26CyyQq+EvjEdvUUO2SC0hzfxEtfhZD5SfZNRwzSaHkb54JlTdRRrRtB/OgjjKzLnRj
 yqiVvUe0w5yniQCi+LAfb8mbbYugZ0GVJRlEVIQcNP38XYJ478oTWr1X/BSA7NoGPmt4Mnut/D9
 AqMGewvv4WFJHRrvl2aLH/njYMaPLUfnAwuSIEUEp+Eyl+VkPBy06uyo1YIa50ZE6KR11WYP7T5
 wIM1AGGYO4vSoLsfKsBNRGfHg7qzuxUzVB6wdJ/HMluTDMbu+7f1EvRzOleuxkj6bMR/sXrK1yG
 4TLPD2UU0WBDE4pSRJuyal8tTSgiZP2qohEk2p3Lrv2TA+2EaJTuV0e4W0j8Hg28Rnw+N3SvVwC
 IaxPdEFL
X-Proofpoint-GUID: 2MZChPRj5XXHbJQjw8Xbny5tdmtLICzA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

On 8/11/25 12:57 AM, Brian Masney wrote:
> The round_rate() clk ops is deprecated, so migrate this driver from
> round_rate() to determine_rate() using the Coccinelle semantic patch
> on the cover letter of this series. The change to use clamp_t() was
> done manually.
> 
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

