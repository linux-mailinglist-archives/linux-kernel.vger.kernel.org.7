Return-Path: <linux-kernel+bounces-844084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5DABC0F59
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 12:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5A77B4F41BA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 10:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38C82D7D35;
	Tue,  7 Oct 2025 10:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kQzXMFq3"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CFB1494A8
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759831477; cv=none; b=SJ5vd+2rhaidNrAdh5aAd3b7aMaItHXmQ0Vc4/WwmTHUOsnw0BHgqWob92R6fZKwCd/iSpMcJWYwmPtb4vU+CMC77az3aYHEqBnz6fwlCdgvsWLyF6Upbh+WNFRIosGDFyGHjZ4lGoeXLIxRmDIH9gcioDXYMoroE3x+7jyqsAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759831477; c=relaxed/simple;
	bh=syP41pd5R9Uci+nN7DevDmDEh8xWqwmT9OEsz3zK+k8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mVcDd/IIGm9aFC3+0Su/ZBI6pHx0WoguuxGLOHTcQzheLDqp2eX5+V2U/rf7A2PDSsOCQTd5B5I5wGFzUKcjMAt0yHSwZh+ugeIRrvGl/fzqtUFqqZQRJ8J2h95ZKMnD3mOJfiB2QcTgL40AedW/f/7lKv6PLFSjcMAi+MI8Rp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kQzXMFq3; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5973LoZG020954
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 10:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UVqmNkVuyqg9n+wG3FSRNwGdnQf4FyV3jtMEgH1StCc=; b=kQzXMFq3dERTPmJR
	i3tyTvk7Qkt7984vJW+dXREFf6N0AEzJqZRFzLCx1jHzwMyGu7h4XDjnHv4Rxb9I
	YPFowLoQ8cwKkyQYS49ELr6a8eZQf9KIlJEwqlezEGztQPfABLJhh609toKvQ2Je
	XrZChq57p+bQtZdX8WbDTnmv3Pg/aEt4sbeCkrYFBbDYCs8Gi+4p1G3QHSAju9Je
	FRV6sZL/cgJIosLS0q2G5UdMKSCtmTNFxdrvluAMyDnTD4mg3PYlH+IbMvIjSrD+
	pHDh15VEWEVjz8evWxOg8yEXMhUeZABWg3h59UuBbEs4FW2ZzULmnrAu/GMpsnaS
	x650ig==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jrxn757w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:04:34 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4d8c35f814eso13719501cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 03:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759831474; x=1760436274;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UVqmNkVuyqg9n+wG3FSRNwGdnQf4FyV3jtMEgH1StCc=;
        b=W1ww9BVWtAn5Hi+GlgOH2ypg/PhfduzI5/QHz816OqEi0vjM+SZL6PVF0pokhnOSaW
         blXg1SiGNBXf5l5UO2OpB1rmpXI/C0n4w2AXxb8WPQLLIMn7EDo72gCIFYimo7zP4yvW
         tAxQVdV2ZHHocOLhd2duMTyL0/0GXEMk+zgPQ0twVojU8ZIhc9TPSos8xW8qmg5MH8Yw
         N5cV1fk6pgwUZzJis/XwdcVHpPpvHW8ieWoWXPxw5oo1d5g1nmBU9fwjXU90DsdwEXja
         8fB/LqnLkyf8w9RtVXc5KfJimmKif2S3JxvgEGfaPx8Hlf6brkF5NtDv3orsiGN/sNBo
         I6IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVI4AiCJPYILieJx5VuAnHxs1EqNQ7a1/xZ0uPgPUInQ4T9OVMuXKlm+Kv1mWRKvINGXrIPUBBEX/fp56Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwEGxcxEvapjO+46lKznv0GFp9gr49ZRmovUonZLz/hVL6zlS3
	L4awDYeKUHflRkrkItPwYyC3L9tjK3PXr4dWEffQ2ujexHqsNTVZo2/pY+cWh7hGeFEthirTq6V
	hiMg1MunYOTWYgbSWJM0Ue9hlk1kQ3gUFZcXsRn7QtmbHGfz8tQrVVkv4zFZkXzEKENQ=
X-Gm-Gg: ASbGncv9Hp+1067KPzkrtL2AAPPSTlkThSD5Q4C4Mw6GBeXG7aCGsKBtfT4DZRUaTkW
	hD76/VHy8Cg3o/ms+zC8m5/DAmeddFOtdv5ph2Ty4tZOReJVFPFD93lkiMVZXlqLQct4+gyFcwe
	p5x+yCfLChWiyAeRIVrEJqVo7ffB2l+5V765DjmqlodExHk8YWym1a2CThydDGSRWM3+Q1hp3Qk
	bIsEE8Hb6ii/6ddup7T9peYZdb9Yt6oAbdXTWZY8rSzbzZP8vRNWJfM92aJcqE/KYuak1bhdB3r
	V/hlnRZ/i/jG6EfJ/W/oLCWp/Fb3/Wltp/WMwZULB65pvRCLzE3SME8qrb5d2atsmYMAUM6eROD
	yrn5makHBjBmZxuQ+g8gRgK2apNA=
X-Received: by 2002:a05:622a:11cd:b0:4d8:85db:314 with SMTP id d75a77b69052e-4e576b0937emr121120071cf.11.1759831473613;
        Tue, 07 Oct 2025 03:04:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNIWw2SAUTUQLNb+7LVAsg57ghgAbUy9HBwlXY4iZKFwFCHllk7t4lrcnif05kVwqiugILGQ==
X-Received: by 2002:a05:622a:11cd:b0:4d8:85db:314 with SMTP id d75a77b69052e-4e576b0937emr121119701cf.11.1759831473052;
        Tue, 07 Oct 2025 03:04:33 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3b70aesm12333222a12.17.2025.10.07.03.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 03:04:32 -0700 (PDT)
Message-ID: <5a9a2ed9-9e95-4bb0-b5b9-e4e0edcfa8d8@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 12:04:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ARM: dts: qcom: msm8974pro-htc-m8: add touchscreen
To: alex@me.ssier.org, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Luca Weiss <luca@lucaweiss.eu>, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251007-m8-dts-additions-v1-0-53d7ab3594e7@me.ssier.org>
 <20251007-m8-dts-additions-v1-4-53d7ab3594e7@me.ssier.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251007-m8-dts-additions-v1-4-53d7ab3594e7@me.ssier.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAwMSBTYWx0ZWRfX2hP6VteRMI3T
 0G77dAQGEgMhT5rpJR1FHCGpd8ceKYotv+xKlkeqKhwzOSjmLNTOpGrL4QbjpcdJS0Bv9KMFpno
 TIu/e10WYjKBhr4e+ShG4QPOr2OQhaGrD0h0Lz5jNh5+Wv4VLYMYz3WbP+VPjrdySbk0hrmqlBt
 eOjqeV7NDoq+lc2DT3k5THhRKVeU5rGRBmkqHB99+LzKrbnW6Eocb1QvaAgCEPGSUx1oSY0hfkT
 ONKiv+oer/u8Adh1euGO0v/pYUbcFmc9QzhQua8E0k4TmbvDHQQySRaGABqUvoJSkRmzTNbRafp
 +VyKGas4gVuAe923Ign/4c6r00wk7EEx2sZ4TbdzkXrPrwfeCfka89+0ALxh+ewyOrSxExgT5Y6
 5LAh6xo70o/MDhKASRou87sNmFB4/Q==
X-Proofpoint-GUID: U9DVy7FDa0qj0CtcvT5rgKNvqmLtmuPb
X-Proofpoint-ORIG-GUID: U9DVy7FDa0qj0CtcvT5rgKNvqmLtmuPb
X-Authority-Analysis: v=2.4 cv=EqnfbCcA c=1 sm=1 tr=0 ts=68e4e5b2 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=8poMKPHdAAAA:8 a=2dNuJvzwNQBdB-WvFZIA:9
 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22 a=fyZPtLC9JlAwSkJ5-iUD:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_07,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040001

On 10/7/25 7:55 AM, Alexandre Messier via B4 Relay wrote:
> From: Alexandre Messier <alex@me.ssier.org>
> 
> Add the touchscreen device node for the HTC One (M8).
> 
> Signed-off-by: Alexandre Messier <alex@me.ssier.org>
> ---
>  arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts | 36 +++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts b/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts
> index 36eb42f0f3d9..040a256f9465 100644
> --- a/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts
> +++ b/arch/arm/boot/dts/qcom/qcom-msm8974pro-htc-m8.dts
> @@ -65,6 +65,35 @@ vreg_vph_pwr: vreg-vph-pwr {
>  	};
>  };
>  
> +&blsp1_i2c2 {
> +	clock-frequency = <384000>;

This is not a valid I2C frequency

You're looking for 100/400/1000 kHz

Konrad



