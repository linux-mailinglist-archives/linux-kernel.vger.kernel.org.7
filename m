Return-Path: <linux-kernel+bounces-742419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42AAB0F173
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 309CF563982
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C042E4272;
	Wed, 23 Jul 2025 11:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bEGV6vIJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518D728A706
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270836; cv=none; b=GqCERWuQW0gfQRTWA201Tu7/WvunHGYjtMzMuBwvihTQ+HmW8Jk0HCNLRItNrW8R6Mk9SA69nI9UpmRJArsukY8BbOBf9hvpnoPHpxAJAiz828zHgJTDiuojbxaKllE2+XeLlI01KBDqLiUqois0Y/2lrdLnMmysnd2VzEJp8xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270836; c=relaxed/simple;
	bh=zxEqXYU184o0NEWEyl3/b8vley0hDm5uiksijtgyxZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=moUpPaWM4EkCciyduDhmX7I1qtnjpq1T8o/v6AMHA1QZJFJZpi3VG/ThOjBScP9T2kZF2e0t8z+0i4Cx9qXsuFLIemmDoB4/JIIooXE3b+mKWKOPxPNipr/wUXJPhVLqL6p/0+efNgNgHrNM7498nKvjHiKBmQvODF80cnE0zRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bEGV6vIJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56N97W6J027886
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:40:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LtBv+dCZU3MXTFg6yWzYJnNxDj6mZzTLopQbFf0I66k=; b=bEGV6vIJZ/WxzI75
	kX3+NLMErVDAVinAiLPX3VhuvMAgH8i2WNBphYP3K3EJjq2sthu6AJ+QSTxH5zUB
	c4uw4z76EpSzHTJonIfAG27cY/Djl3MnuJkehk3WLyeOWt1bKIV3oQS4bSKMVg1f
	MpIWfDsE8YgKmv81JEf365deK3vXP/N2iPhkIC/hQKeG4sg5YOBw7GX3qI1hWmdg
	x3eVs127j7Q+Vy4Z4r/nx9cGMlvV7OqM7M+erpwrHa/DNMI65ttQCWDVf85m7ktD
	ypAs9lfuldSUiQhBjRBv1bj+u6a6RiO8Itkdd9Dgl5BlGWIDGF9EXi5tNFNmzhUr
	2dudBA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048s50hg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 11:40:29 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ab3ab7f74bso22567901cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 04:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753270828; x=1753875628;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LtBv+dCZU3MXTFg6yWzYJnNxDj6mZzTLopQbFf0I66k=;
        b=rdhbtsBK0YRJxabMSnBCsHL72RNMNx5bLuO9Op7igmR2EsYytdBextFUo9PAGPdxWi
         fV10kMFB2WPi6VSSmSu1eSz+irTdamo3s+kqONQDgv8Hxl9ezMWgocuRz0YLLi1XkGHQ
         L73clO7pR08A2CHExEqUkTmpJEF8NCWFAdZfj8gI6BmgUfDVsQSWIuitI2yytaE48elm
         2jvREuwMneq4dT4VnARkUC7LkfOEpz6rMzrRcAVSLy0XkI2Dd4osLTPxN6/YMeeB935r
         Up92Nmc2fhz7Tufcj2MCrZ1KnCNE/p8q1pAJnUCxDIhX7M0DJgF2JsADbvsTZCWxNKbp
         i8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8NRTuThSi8hCWOyMEDQSw3gxORkVjz/mryyLllc9DeUECYSKjKxwILQfOs6kxgka+r3oIjlVoF0vGQt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbE+zLF4mzqxXay8EgfmoJS4/lOiaS6wlKEhOhB22fR7pOTdbF
	qHLR6/NPLBTauwYQjsC8Aw2JwdJ07UpaXhyv2tozfuP3VrOkk88d6aPrMcC4KxUPniX8PMr0V+l
	r8YY5J5mAeWGGedwMVcJtgja24ypN6GSjAQga9bgvRydep11mMMlUEa1UqZGvQ9jU9dg=
X-Gm-Gg: ASbGnctX2VkYcdwb5M93gZP0eA1GUbyn1MxWKwJoxCPEGt5Ryau5F7MHpgKtZ0gtL1j
	h4aCKoI63zxN6L+KNPmBgj1FX1GW5JIl3zaWf40RfUU/v7yw6Zkd1TtcPCbj5PpFnx54EG/8QqO
	yNsapkmdZj3MYIMojmYOVxqXsV0+Js5PYyjgly9M36/9N9r52t2VqqQ5B4famsBB2WXpALbbhnv
	qZOiDqLs6PP/OJQOAEcx0V5r7VUayudbQ0zX302j1SiIXonDunpRJyybYwgkpdvm3JXcRj/dutR
	ZBiVRLm03TaycDqvKzQwMWfl8Z8nUa/guI8UWgUG/LKqWJHtg409A3GMFID1tF6vsysISTY6PIm
	x8I9fuYIsgEc10/dpRg==
X-Received: by 2002:a05:622a:1b21:b0:472:2122:5a37 with SMTP id d75a77b69052e-4ae6de5bfb6mr14172241cf.4.1753270828290;
        Wed, 23 Jul 2025 04:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFp928hZJ9EbJ+TeXWHb9YaHxKY/0cu/xA0W1wmCQOKT9wQ1BXC6xBmFULU4vRxTLsQq3PrOQ==
X-Received: by 2002:a05:622a:1b21:b0:472:2122:5a37 with SMTP id d75a77b69052e-4ae6de5bfb6mr14172051cf.4.1753270827690;
        Wed, 23 Jul 2025 04:40:27 -0700 (PDT)
Received: from [192.168.43.16] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f36ff1sm8509328a12.26.2025.07.23.04.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 04:40:27 -0700 (PDT)
Message-ID: <70277682-94e7-4905-823d-25ae76f72ee2@oss.qualcomm.com>
Date: Wed, 23 Jul 2025 13:40:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add Glymur pinctrl
 bindings
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>, andersson@kernel.org,
        linus.walleij@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, quic_rjendra@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723103644.4058213-1-pankaj.patil@oss.qualcomm.com>
 <20250723103644.4058213-2-pankaj.patil@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20250723103644.4058213-2-pankaj.patil@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIzMDA5OSBTYWx0ZWRfX1BYejeM72F33
 042pQkw1DWR+U515CSgKVTrjZcQSTWLRkHOMmpOQXngYEVkB/kQnIqUzpJtcY15rvDTFrR+2Qt4
 0Gk6sfGgo3+n2JREv0/a3JpKbkKpfxwRgwbNyAm+UC3Z/KZCVDuK9DhwuYMAuf30UuahsSvucY4
 cuD7x1Wb8uPQjrDpKdRXFEvjyQFb1Piq0ftN3pn9uDxVlKFeiMSSH4lkUia2yr74RiyA7FpZav4
 WUm9oJVtne047RLSQJPzw8vDRPVNP8JIzhoIE0Hu/o9E1Wuh8EYG1T83vnF42t71k5KGdBvuZ2t
 Va6OZaMfRGNQPlmhnqJa8ZbxVhtKO26cdBt6/Z93cXqJDzYBnwaMhQ/WPYPhZR1xRw67fz6RsjA
 IJikgmNvkQnNp2fcJCTcxv0cultx+IsAvanxYmQtUGx4Yz/huSb+vJsuVzP7mBnfLczBPVNU
X-Proofpoint-ORIG-GUID: GAG-a8w3ln0wgY-w8cewCEa3qnP9ZwXK
X-Proofpoint-GUID: GAG-a8w3ln0wgY-w8cewCEa3qnP9ZwXK
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=6880ca2d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=0A8kWLnl_qBNfi7CqYEA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-23_02,2025-07-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=923 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507230099

On 7/23/25 12:36 PM, Pankaj Patil wrote:
> Add DeviceTree binding for Glymur SoC TLMM block
> 
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---

[...]

> +      function:
> +        description:
> +          Specify the alternative function to be configured for the specified
> +          pins.
> +        enum: [ gpio, RESOUT_GPIO_N, aoss_cti, asc_cci, atest_char, atest_usb,

Any reason for           /\ to be uppercase?

Konrad


