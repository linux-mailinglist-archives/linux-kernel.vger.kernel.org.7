Return-Path: <linux-kernel+bounces-820921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24552B7FA8A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289DF5857CA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 13:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F4033C76E;
	Wed, 17 Sep 2025 13:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GmusjpdG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD252C0276
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117558; cv=none; b=gAFG2rz1sk23Fo9ZAmH0fZXysPE3ol3KKkWeun8UwoSZl1De9+8qvtJqTnYxrRioDogJY1iVQoXACbHG+1m9keCz78/BgCKvOHRVDPDh2Shx87SU4DI6ln4lJiB1f3JZhrGD1cPZIJBzhJQP3XC4huTVUy2xgzB0ZLlsiSHi+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117558; c=relaxed/simple;
	bh=lyGb1aFoYsF+raAKp8sU36n+AGvzU8VFUBNR24jkqzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsLvF3XHdklAx++eC6A/u8+DFjaV1H+QVJ+TIZ72b8e6FBppNBC08fLor528wQfwcDx37qqjuVQlZpzbPnj6xSwzZBLxPyGRBOxLeWg+lK2NwoMHx3sObzMojhLL7fs6xX4SVCWaaitsWgB8w6WbZPU/L8KssdiUMkAkFkAHnZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GmusjpdG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58H8XaZI029609
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:59:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uiv/XsSJSXK2+dr1Alsnv4ajZiNrr6ESJ9d7QQbgOeM=; b=GmusjpdGWf2ntEuN
	yKa8qCfbKl/RpVTJVVX4qC7wlSFDnSXYYpAlMOT665oYDxcgHFCAPo94gap3cs1g
	HEHutbKCNyXeh1pr6wTzKJ8bmzbLh3hSfg5AJUCvVTBXkXt7ASZSeafScMixmaRX
	9U1Qtoy9rqDjd9IDQSbIKRCdKG5KcI90JyzbW7Ts0pgB2YM8pU65kFgNBPtaRY2/
	ffKZRIHvflq5j9I3YBjEmToNuL7gupmIjwaXZi9h+DROeu1pRr4Sv1x/f+nSFb9K
	Fro7xJP687mno1TBMVJ1brL7purdc2tffvT7isnM1RQsPA0SXnMZC9ObTg3PNDVN
	hIiRIQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 497fy0tkcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 13:59:15 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b822016cd2so5457021cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758117554; x=1758722354;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uiv/XsSJSXK2+dr1Alsnv4ajZiNrr6ESJ9d7QQbgOeM=;
        b=Br4g5ZcZ375u98eKKtF8FL/E7fPoWQ1LylEombmm+MRFj8xF+Hmj/87BJWGmeAi4X3
         R+BhND0meYZtoKzL/+qnviIaaNiTeozxGYgZZTkDaM/0xSO68cIShmPq9a0kvDqWPnyF
         MMYRWoA4gdWTF5Vt/pRhD11g4lwKkA/Xs0gUadU5q982UEfbMIwSQBrnWwpGBf+xYpLc
         blsx179XIcTGufKfBdIu+K/aML4iG+EeMq3ugC3IVzXsY3hSKxtFcWoC0d1x60remN3i
         Up79lQkpUyFIY945LxcW9PGxmJlvkzIpbJ4sOMgRvbBBU9PVuqPLsKrCixmFW+Yx9DAR
         WljQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkwtx5wNdj+JAoFGAs7l+9uxCOPBVFCS6ty35RM0XcqzKPFkI88UtzqCDy8K8h24iUPA54GQmzITZRGaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2NpVx7+xlt1CKXLTF1hYIk6FIg7jX6zDDSQuN+SkvGOp6/tZx
	MyrB8rSALvKwQlLBdRLdEdteaEx/qlxcY18sSvTAytLYNZI1UU/meC6gktZcWCHpz6w6Rm8viq0
	R+rLXLtG4/3pCB8RYMzlxRoAFpOUNs2UWbB5QlTM9hiFQVi0oJfcQMNVHRGwAT5ZXXuM=
X-Gm-Gg: ASbGncuOb54e+oyFWL5D30vPh81a+DB4Qt5ZaFWXWINoJhT6nTyNjR+RzpWHV3z5tTM
	hJT13fP6zbOWS4wu9e/PQQkv0Eewh/+0MYhEicF7EbyyZIsLi8HirzAISoKN2xEicwZCGG5r3c+
	jdy2GvU/dSEMjkJTfR6Kyn3uw5IOBDanUbeM6S5lOQzvzgw783wJIyQO5tK78Ke4n/6/lvAM21C
	XqHL8tJK5NyjZ4Em73zyAF77Swh1UpCj1YJtiMk0yMuq87TX7VS8nKlgvcCmoNrIKyaC1IrQcjo
	/xc2dgxQMYV+MCre8xGGkrfP+rqm5R+PqBwDXoeZVzxf90c3jQk2dz1xyuGRSyOvSRnp7MH6CTJ
	Jki1GxvHRwB4hnp/L9IOBVQ==
X-Received: by 2002:a05:622a:10b:b0:4b7:a308:b5aa with SMTP id d75a77b69052e-4ba68901f95mr17460061cf.7.1758117554328;
        Wed, 17 Sep 2025 06:59:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXXp9M/NfwdwYTCoRDI+XQGNkB750ohCjW9JwuICJtNf50OfYIZe+NpGOz7kkOSn2YvOjDsQ==
X-Received: by 2002:a05:622a:10b:b0:4b7:a308:b5aa with SMTP id d75a77b69052e-4ba68901f95mr17459721cf.7.1758117553734;
        Wed, 17 Sep 2025 06:59:13 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07dbf5dbf5sm1019452566b.79.2025.09.17.06.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 06:59:13 -0700 (PDT)
Message-ID: <de1a7ecb-924d-4ed2-8034-721b8dce69d4@oss.qualcomm.com>
Date: Wed, 17 Sep 2025 15:59:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/13] arm64: dts: qcom: sdm845-lg-judyln: Add fb_panel
 dimensions
To: Paul Sajna <sajattack@postmarketos.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, David Heidelberg <david@ixit.cz>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        Amir Dahan <system64fumo@protonmail.com>,
        Christopher Brown <crispybrown@gmail.com>
References: <20250916-judyln-dts-v2-0-5e16e60263af@postmarketos.org>
 <20250916-judyln-dts-v2-9-5e16e60263af@postmarketos.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250916-judyln-dts-v2-9-5e16e60263af@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: E3LZvCLQ-1jrcveF7d6BvxSI5hMfbJFk
X-Authority-Analysis: v=2.4 cv=btZMBFai c=1 sm=1 tr=0 ts=68cabeb3 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=Gbw9aFdXAAAA:8 a=H5uZHoPd_HLTupC0YvAA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=9vIz8raoGPyDa4jBFAYH:22
X-Proofpoint-GUID: E3LZvCLQ-1jrcveF7d6BvxSI5hMfbJFk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX4jwnQIm1mQDV
 sS7Y4EN+vPEC/BxiOVJWBu3c0A8kp+sw+muQV0k/itRbxYWoHZwKZHfBJnjnX8RFFri/OEC4X0e
 UOqOfcAVD5UX30uDQg9r3AIdCFN4py3enVijQkNw6jlGvW7TYzG65JT3w/w3iD/CiLSyLtI3MXb
 IArbZU/TXUyTbxeBHdLbcUQcGY5ON5PfBAmots+SsZzMseAOudqWTDq33kQkpX1BlSunQOnTK/0
 0izorgKlDwNA+i7Jkt3gZ45friDGY5jfBcxUfMWkWcSnQDf2+7RSLJD7MrrB1Z22I5q2WYsHmJW
 uoVvqpGW3DX+GpEJbJa2fDkmLn30o9Vn9zjtFzMMuaUTYO/TnLaS2Gf6xAV5JA4OEC8mCj9SJ6h
 OCBJuLTg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-17_01,2025-09-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0
 spamscore=0 adultscore=0 phishscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509160202

On 9/17/25 3:09 AM, Paul Sajna wrote:
> Add display dimensions for proper scaling
> 
> Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
> ---
>  arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> index e84b45ed82fd13850ea7ec1f34ddac5b59fc1434..8c1692f86e6ceea7b718361965e78f95d39373bb 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> +++ b/arch/arm64/boot/dts/qcom/sdm845-lg-judyln.dts
> @@ -23,6 +23,13 @@ framebuffer@9d400000 {
>  			format = "a8r8g8b8";
>  			lab-supply = <&lab>;
>  			ibb-supply = <&ibb>;
> +
> +			panel = <&fb_panel>;
> +
> +			fb_panel: fb-panel {
> +				width-mm = <65>;
> +				height-mm = <140>;

It'd be nicer if you moved these properties to the actual panel
node (the DSI one) and referenced that one instead (I think that
should work)

Konrad

