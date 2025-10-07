Return-Path: <linux-kernel+bounces-844292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 51790BC1785
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CC96B34F38C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8672E0938;
	Tue,  7 Oct 2025 13:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QbpAp+MI"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA0525486D
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843162; cv=none; b=JhX0ss1wj1+WEOS+79CYgGydaZgKHGc4cOLgLtJorMW8p0ZqjGTM0Kw2mT7EFkqUs9Yk12kJT2OLGHZVO4LLTRtOenLv7EG/Cezb/sGGFJXaaFO3mpZlJEUeLoX34gvz6jEi2cJ7PGudCtfRrKiIlUlgJIC6meqU658wAnxlhww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843162; c=relaxed/simple;
	bh=LnAHJdfLE8ObSWvVmW7FhZfRtelieJ3PBtAew1HGBgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fl56Jz7aodBSutMv9HG6hhh1yUTA242b3RrNe6PH3gmnPbuSALzvHXK9lldNbaLB5XAm23yx3DIM7JTIBktzlBIAlx/ll2pUkkFDTMh5lSuILPMlR5JFB6Tu+MoJpdDJUanPI07YKBFzxR2XRjjpAN5tVIo87YD4z25PP3fsDA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QbpAp+MI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597Cl2tC019416
	for <linux-kernel@vger.kernel.org>; Tue, 7 Oct 2025 13:19:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zDMLEOsZqI7VKYWstweTCTb87X62RrcGaFnWA3/+hWk=; b=QbpAp+MI7xUz/fOg
	3iiwHwfmofszZ6uUvzFeWdiG2oZVlhmgKaiIxep0GNjFDq/qdOroV7IqbQwL4SNB
	JJdLhSBFZIf14r1wuL8CtT0fdWdWsqjRzFY+Cya832F1iFBvSLUrUGXes/JJFHcU
	futz7zi6UaMygj9EDJY2oqO45tdLXThKm5JXpXMlg/CdkvAJ1naAuTas/1QyU5ow
	r7w3a9ZIBcpIUQlwvngr/C6mkofSiuZI7EAGlNWva7aLScmtaI3+yGpRbLHFBo+3
	1gwV6cs9G6jjrUBBaoe0JxvTvCR58Lmpw0kfgJLeUmhvPwa6heJfS27Sl4wbeCmH
	n2oiqw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49jtwgqbde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 13:19:19 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-826b30ed087so16439156d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759843158; x=1760447958;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zDMLEOsZqI7VKYWstweTCTb87X62RrcGaFnWA3/+hWk=;
        b=m6LtI7Xw94oGdjkAkAoNsPPVPpsoPGewYEWAeuT5g642y1w4T4zhj3S9o0H6Wkk+al
         JUxBstHekfWY1H8kv1hCGfeO6+EeUCkosU/9n1MXESKs9Zq5UNhw4RCbtPW5u5MkAHxB
         zMcoPtyfS1dG4ymeuN/dJFJMU0SPYAdceZC8I2SRJAJWI2aoa/u2hLhpFp7u/DEM6/uh
         q+y+LSWC14pjrcLvidmP8sRX3NTE0X8fv4oPTIfYDykkWdrtqwfEozAVLYOWEH6FDuTK
         d6UdqaTbZ80ueQnQ7gcLBCi3/2Glfw7jHOifwRevj/faBsBrtkQdZlHkhyNPLf3B3IwN
         41GQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2DpXVejXdKMob5j2eKodlG1k1OQi2m+0BHd/eX01iLTc0B4Cyn8OU5jSRwBJhjmNfkDoabH1sGKhmTQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdgXw8zP0Ob09ywysAIgLUrb5TkALmddXxnzLQSsgl7xpf+GpT
	dQ7zlXV20dW6Mkn1k9FsMMNq5sroU1sNeHQLvE+QH9WvFIqNxnsfhYe+u8N/TbSQh2gqeTGTZlT
	qYAP3eWR5Bh2YDlACLqB5RGp0ZGTD5ayGbTil3SXqlpOHGLwyGuHhNvT23Ma2b4PQGbU=
X-Gm-Gg: ASbGncvzVvJkeVWq11j88AadhPfnLBozq8pgbbLHZajMZJzOWG/gGGSgQYv2UiOERcr
	ffKNPj1GR9KLaDwVNyn6KzNaoo1ir30O4dC7ZD+oboec1UvOBg+770atZQYODi8bVeTm3t5wHxU
	NH4UQ078JRzjSQpFuT0nQ8nk8grphmVpBjUxeKrBUgTgpxH5fxaWU+3SA69eb4owQppI27mGO3D
	Fqoxtm/C9NcByD5+R5JsaUzxN0TqhBwPmhMr0f8Fweyc9kEg/1VoMbGGs3oPdvb3QPBc3FuSCQJ
	Bvaefey0yF4wttE5EmPCYxrQPOZ4bUNb9L/e53Al9PX5xUyAhGQ7CDrWDeuONnj5vzHaX/cklEQ
	s4hxHi279DzQepZYcOeUsaSnf/kw=
X-Received: by 2002:ac8:5f91:0:b0:4b7:aa56:c0f8 with SMTP id d75a77b69052e-4e576a4b14emr132692771cf.4.1759843158031;
        Tue, 07 Oct 2025 06:19:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/NXeouDxTbHwgWa2d0D7fBgPvLyWgqaq7L3tSbrQ2CaTdY9AOHfPVIWwQCrEHUSq2nA0hqg==
X-Received: by 2002:ac8:5f91:0:b0:4b7:aa56:c0f8 with SMTP id d75a77b69052e-4e576a4b14emr132692161cf.4.1759843157313;
        Tue, 07 Oct 2025 06:19:17 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970a4bdsm1396017166b.49.2025.10.07.06.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 06:19:16 -0700 (PDT)
Message-ID: <1cd3fdd3-af27-48e8-8bcc-aad7262b139e@oss.qualcomm.com>
Date: Tue, 7 Oct 2025 15:19:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: qcom: pmi8950: Fix VADC channel scaling
 factors
To: Antony Kurniawan Soemardi <linux@smankusors.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251004-fix-pmi8950-vadc-v1-0-3143ecab99e9@smankusors.com>
 <20251004-fix-pmi8950-vadc-v1-2-3143ecab99e9@smankusors.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20251004-fix-pmi8950-vadc-v1-2-3143ecab99e9@smankusors.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOSBTYWx0ZWRfX4cxXFOhWJ7rP
 vsdYiHUfwPIPVpxN9y7DS8gnecA+KWhHiTi2p4evWGDsrtBf+MwSm4pms1cjinUzoaBx/Bj2eje
 +vrOXyTRJg76VYLwbCjUuaE3Pb0w2gmAnjYgnbwdx/wBcgixVKoRGso2cmEjiZiQzLmZ7WZY3oA
 pqpr7q/njR43sQE3QCJmxe9ugdJ/yyXq6/AcVkgtgW+gY2KBRE6vsLVQKPu8vO6UyN4dfTjTjLs
 KtQYAyme75OTuvAWHnxXeXFxahWwphMX9yadiFoW8aWl6+Neh0hmNkZL3YL61tcVUMf1gZFVSso
 JD3jMUn1XfpQXcz4OeAbc9iorhRBgKWRIcPeZIKLQ55doRN8hECI6bxVlSTHC7UXmFzxTDt9v1k
 vYanMpuy0ujtcnZWBYI8AIOaEZfEGA==
X-Authority-Analysis: v=2.4 cv=B6O0EetM c=1 sm=1 tr=0 ts=68e51357 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=NEAV23lmAAAA:8 a=wxLWbCv9AAAA:8
 a=EUspDBNiAAAA:8 a=jy5Z_zf4QHJ3AEBhBnAA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=QJY96suAAestDpCc5Gi9:22
X-Proofpoint-GUID: CPz-B0n_Iv9UoxTrYlTwveLTNh08AIPm
X-Proofpoint-ORIG-GUID: CPz-B0n_Iv9UoxTrYlTwveLTNh08AIPm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2510040019

On 10/4/25 3:12 PM, Antony Kurniawan Soemardi wrote:
> Fix USBIN/DCIN scaling to match the downstream implementation [1].
> 
> Downstream defines the following scaling mappings [2], corresponding
> to mainline pre-scaling values:
> 
>   <4>  ->  <1 20>
>   <1>  ->  <1 3>
> 
> [1] https://github.com/LineageOS/android_kernel_qcom_msm8953/blob/e6b46fc6f52e754eef5ce6265c7d82a3622e0b0f/arch/arm64/boot/dts/qcom/pmi8950.dtsi#L55-L86
> [2] https://github.com/LineageOS/android_kernel_qcom_msm8953/blob/e6b46fc6f52e754eef5ce6265c7d82a3622e0b0f/include/linux/qpnp/qpnp-adc.h#L342-L357
> 
> Signed-off-by: Antony Kurniawan Soemardi <linux@smankusors.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad

