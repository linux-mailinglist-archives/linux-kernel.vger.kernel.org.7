Return-Path: <linux-kernel+bounces-860703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E1FBF0BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 13:07:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332A61892285
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 11:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81C62F616B;
	Mon, 20 Oct 2025 11:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HUEhM1CI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF69C248F66
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760958426; cv=none; b=ZQ35BIGGB0Vvstf2S+nlXsUOkR6F5aA0uormst4kNgD1mUT7PK8L80fH7r5TCC9axh034HWj+Z5rzk8zIZ629WZQZlvooIYE1CeIN50QHgn8nTsLFioZy7owS0fqR6jX/VoE4jxqP7odSH3RTGgtzzzkIrBsYH+NfDvp9EDAfqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760958426; c=relaxed/simple;
	bh=gnjYFPak0EJqXOMJIeFPWg6gTRvFdpKtV12xixzFsEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srrYiFvbsBtRbJ8cYKyEVPfHHPkPWldzSi95uDXarI1Mtf/CIY6fcSZmP5ZD197UtSJSP9y3MPsMaOFihakMqo471jFVBEL0QwcnvNsQEKyhQalTN923B2A+tsF4kfNrdHqJWNKnICpZ5k92c3iBLLIKYSgqpf5nUtYUzrhdp3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HUEhM1CI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59JLjEjQ009293
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=QwARkMhltT677TdXPdgdzsla
	GT8f6DdXmqDptEd8yFs=; b=HUEhM1CITXNSzgZSNTvZk88Lf1OMEyCK4UjBkM9I
	r+CJR9t6zTVN9jLM7pjIWbLhmbF5urUlyJpQl/nEnyO7PE0z63QO7VD0lQffU16R
	gIdXEK7lMVY6wv99FjoVyLq056HuOsjqNSxG5E7ANSQwsZNra+5WbwyV/LoKCuQ4
	F7RJB2RfFG6SLU/kmzF1fJObkCak51ulr3KaNvkXPd44RYbOIUMiFKJVCi6HAAF0
	D8YA/EqCQ1kDoRhwlX/VZbfD0JlNepXBZqcB6JIdFVlWzkf8wrAOrpxWwmW/dR/a
	8cEE/ziyPWDnsWN8tfK/Juvt5witnHgn9fJtE7DE1TvnIQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v0kfcsq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 11:07:03 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-87c2085ff29so149665126d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 04:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760958422; x=1761563222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwARkMhltT677TdXPdgdzslaGT8f6DdXmqDptEd8yFs=;
        b=BnI7c5nTVMBo+hTJmJWVfdt8YyP0QoDNF+i+4v0wr2iFfzM+jdBgxpdSDVUB8EuudP
         ykJITvVdKVzDMzMtF76TUMfiPe/f1FTIIodlhbyfhk4UtE/EF2nAPKKP6Y7NNMXYUSMN
         +YVv6RK8fNSlPozLd7n7TGpfBozhwzzrG98qqBVQ28q7x3zre9F1Re5RSg27oeAG9ysI
         vkGAvtRazts2igdQghe7Q5L5W3UZEBn55g6cfpMyRRvlbBE75hwHPIVjQq43ZoyHH0RN
         +raPGiAA3crq6BGAKNYohSGQP6M9lo5Ummxy5OX1YsAhC1MrJpiasDYfSUrq+EmciU0Y
         GxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDGb9JmToYJ8BpxU/CMggRXAH6q920GPdd+nx/3VvbaEhP9YjgZgc5St35AkjT217Lo+MsCdEgsxlSwWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEU6UxQomxhrZDPmOmseodj/7Rh7hjjwtZxh3QvKfb3VZXn8a4
	oqVIXnvuAOVRec6C9lUFKJ6kIWWR2tefErbvOEO/uOyZlX/dsv7rSeb4HwHC8URqvC1NHkg9JSh
	mi+xNLyz0Je+9weUGLtx/bYEJlwW12OhgDN53Lv/3W87bJGOvj23/bx8KDtJdVMdfgKU=
X-Gm-Gg: ASbGncuvFodO67yru6P5CxvGir0sl8UV8DKWZI36xN8CmrrZktbb7mJjyvk+FGXN1bL
	prc9MFYFYOi2hiBkGaE1/x2VWt8ZXvsrANe2x2XO94UzrSxSw82S4eA03xE5p5fmDXz63tDm00Q
	MOmMuvkYJgxYIkwQSFEs5aofSPc9Z4NlFb3+wptXKwnn9x4zO1CgKTIkfKi/RbmISNT/pmUS37O
	rxZTKEJ5VkUqByDHNwYhuhwWoyd3BENJaoiyuSWmgVWX5FcMAnx2ZMdCMZxJR0IcBUpAugimQkk
	xHGHlfKBD4Si3D47Iw26JZGsKLRjE2jtgRZXcE/JNoA1YbaLA73HFqUinhX4ep4rF7RiSnh0g9o
	V9LCwGju83CIkwjww+Ul0B79s0ymalNv+7f27k6abtao/BfKAlvQRWLMNlQgw8GwvdE0SNKu0os
	oYEjv73vHAQug=
X-Received: by 2002:a05:622a:84:b0:4e8:b270:aeb1 with SMTP id d75a77b69052e-4e8b270df4fmr81413321cf.52.1760958421850;
        Mon, 20 Oct 2025 04:07:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECGSfBuSQKnPmaCRmRZAaNbAZ4uXKdc3BnEN3QaNW/fLebd3lRA2J85RGIO1q+4dVSjU4yrg==
X-Received: by 2002:a05:622a:84:b0:4e8:b270:aeb1 with SMTP id d75a77b69052e-4e8b270df4fmr81412931cf.52.1760958421385;
        Mon, 20 Oct 2025 04:07:01 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a921e3c0sm19964621fa.23.2025.10.20.04.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 04:07:00 -0700 (PDT)
Date: Mon, 20 Oct 2025 14:06:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH] arm64: dts: qcom: lemans: Align ethernet
 interconnect-names with schema
Message-ID: <ew3x5kajsb4keyj7umnzsid7ltdveumsafl72vt53iaa6rz7rs@sdqy6pmfigzy>
References: <20251020-topic-lemans_eth_dt-v1-1-25f4532addb2@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020-topic-lemans_eth_dt-v1-1-25f4532addb2@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=E6LAZKdl c=1 sm=1 tr=0 ts=68f617d7 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=RIJzAXRtEeeaT4_sP-YA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: T-DwHOK7wmivdxD39COGz-77eIE1qVSo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAwMiBTYWx0ZWRfX/oapc7Ymx0ng
 H+J1QhPxq5d04wxodgOQvZia63eKB/1MEtt3MFCOS3Vnlu1oLzto+yw7uJ4vvdTUZ4/qhVuspMW
 F4e/JNYX8JOgtrsk2+swES66BHQGHbcRKfDMfPPsf781h7iZu+buxn0MKmKDXP+nWcp5I48683s
 P/3q16ugPgoWsaJUnxNq6FtgKQwf9rMSfLHkZmmxBBlFqlOsl2CECF3Jb4QmI7GZFRFYnxkLK8K
 0Wg92yvYmiaqld/582nvWW0OAW4YqmGsqVju2E68QRtSQQjjkfGRxW3gLNdR0m638aoADKj1t4X
 2To0TUAkN/Wi70q4lTLFm74TBsQqkRbqzQo8BeFuKIa2vQT2EmI5Bdzdb11/SNuwXPrpapeAB9u
 IdTVprRLVBnXC8skbGwNAvCL9JGsHw==
X-Proofpoint-GUID: T-DwHOK7wmivdxD39COGz-77eIE1qVSo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180002

On Mon, Oct 20, 2025 at 10:31:22AM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Reshuffle the entries to match the expected order.
> 
> Fixes the following warnings:
> 
> (qcom,sa8775p-ethqos): interconnect-names:0: 'cpu-mac' was expected
> (qcom,sa8775p-ethqos): interconnect-names:1: 'mac-mem' was expected
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/lemans.dtsi | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

