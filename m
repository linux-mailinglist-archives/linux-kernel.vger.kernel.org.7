Return-Path: <linux-kernel+bounces-884774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 530E8C3116E
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 13:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 025A04ED0CE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 12:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F81B2ED141;
	Tue,  4 Nov 2025 12:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bYplMoCe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UtSiet9q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261BC2DA759
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260865; cv=none; b=aiGn97bVxzXX4FSTBxvv53sN1i4pFyxtusLBNIikfVeyrT/yv0S/+ra2JdiWkHl2UWNzpOh178as5PW9G8lHg6fMjoS2EmE04JtHSr5pupgcbAKxYZ6MvZtEzvHTVLFz955azMNOMWKrdQmmU+9G3f22DI4eD13kGHqBYHmCP4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260865; c=relaxed/simple;
	bh=41LD9HFDKqJ12cp5GkMWyqtawGPQsTFhNagLQBs6VzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DZbHIyh9Q574Mr8rPXx2AS0NyEphhCm1gnoU1VUZAwdWNZEV/+ueQLPgxFx8yRbkLkhbeDn7XBNU9WvGdVhjxv3iZpl3LXhDJDC9v+GwqiOn1InBhdokGlrVaRq07lAnq4jAGvZZ+bwbjY0g41sYTb/qsv19+2tJuqFQ2b38WUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bYplMoCe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UtSiet9q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A4Cfb9W2042745
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 12:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rEo2tbdcNqznwgRyt5JQUX43AUUKO8HAkqP13xq8tkM=; b=bYplMoCe01iaUrnL
	DYuPT9RTqvBygrhXPg38ugTjkoVDk1gOFxjLNtfdwJfWUhAjdOGcnucOqQOUlN3r
	mV/n+AjHvTvmOe+HumdFPfa+mAw0NLwrZ5FLer/pEi2+Kk8+1VwdSQ/Mv47IQLCz
	RaerM3SW3ZQm4MN17R/MjO/O5yj7AjWDF9SO76rgyEZ//ipIGgKCNPiuyqfktWi5
	td6SO3a5rCgmnsmIkV5oZeAPpgum98ilNn2IrXMA7lk2mBzC1UJobE4U/dCEEMnb
	HV7Co0LwFL1PwctoBIA4iwp0A8oC+S27VMUKUPlrqLMHkS+HM2zTyPvlZzEaS34S
	+s0QlA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a7fgrgc8b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 12:54:22 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-87dfd456d01so18754966d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 04:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762260862; x=1762865662; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEo2tbdcNqznwgRyt5JQUX43AUUKO8HAkqP13xq8tkM=;
        b=UtSiet9qraXl999hBvwO76I8n6nq5Y6ple/4JkfkzUi2tUyVK+StatmFnD+0vWMUmb
         ZeD4It6qSNNAZq4lMVlyaySL8/ctye/x+ow9kSHJuC7y6tpk9zA/m5gQ8lILwXop/jHO
         2N33tftXOSt7EkYRkzX56LpxjDxRYDIcYlv/rNswWgr4XLjDs2n1qBhCi8IPRsi0DUrq
         Phe4qbo7JnsqY/zC9VGd9kzww7Xp9TNbrsvXd1KKgnHkJNGYUrCmzObM48XmVXXhsOwm
         0wzxuq3CYVcpvSS6DGwG8S/jZolhIvSivdP1XMJqvSP1HhZiNXk/b9KP45tGqFz50K+T
         OJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762260862; x=1762865662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEo2tbdcNqznwgRyt5JQUX43AUUKO8HAkqP13xq8tkM=;
        b=lhtN7OJR2xpS51y5mF/OeFs0Fsb0EovoFDGsLMne5WHX5ng4bth9aMv716KkSxdkv5
         vzza57SGmW44tQeCW5i3Pj35AKf+5FkPotdQ1Vws0w793ApGc29n2Jv0HbJd+khmKMcV
         To4QUmAg1/OHIroh4+wZSJUbGQK9Ao4h8KuH3pwRxkBYts3wBiUbOhTPM5apccPo/2BI
         4Th+64JE3ObPlCPVpLBftGnkMgKLK2dYtdifgG8UsRGhSnbtnklX3oNlL4hBwOFc5Fd7
         aZDXjIDh1V3F6kgRLlLFk0dnccUQLNJG3wvR4k6IkEqWD5BDZwLKPUsQ02xZXx3XWVkV
         f2Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWl6WET+481dfAG0i+He+FB5x3afC8ne7sJkk9OOBLZuubjkTSD/qUe2TqHgDHWY1ypLctClxbWPk4K2BI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyik0sFZgjM5SG8O4wV2MaPzapB2/SVB7br04TLTex21b+bA5Vv
	oP7Ey7V3YP8osCKI+JWVcb94TkWbYhvpE688CQY3qvVioz2MKF7UOkrrLJUnAJyLZtsoLy00ok8
	4XnXdEK2cHu/5Iy3mvA6hHJPYzdtUWrm2rs0Ffg52xeyzdkYf9nMWTTdAx9jNFAezsOPl4BTeDr
	4=
X-Gm-Gg: ASbGncv7EdAjUW3GBWyxyTC+iOzh87Ub6HhHrZC4sZCY53+FknFjfH1IX81HvLjVm+C
	8UqPIhzRnHk44+JFKs/tyjO9oX9J96FbwZacwNUNObSkMBuSRPvgt7VjwK8SI7X4zupLPynVvM+
	k2Eu7xeTBzQlNAPZHYhP6zaK9vZEP9jmEJ+a+oAMLJR4ONSxQEvAyg2vZZTOrUohd6T2taw2D7/
	4e9AEi9mGs9uAhXVXvRcRDFK149GztvJ8h4Im6H98GkaGKK9wR1JE0f2RNrpjYrzRU28JiujqyL
	Zc+Orc6ZMzCoooeq1xzHFhzMQCBdtexRBnZMdr3WVi5TCOEzd9DwN7TiqVL0ZGlCk6YJWJjzhDV
	5IRHKxAwqHQdqw3cKnQ4fqGlqkQHhInlL8bKtTwRSPSl5BdPZyxV9wVOp
X-Received: by 2002:a05:622a:2cb:b0:4ed:7ca:5f33 with SMTP id d75a77b69052e-4ed30db06fbmr139568921cf.5.1762260861968;
        Tue, 04 Nov 2025 04:54:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGK0IbjPUvHe3l3ozGTecxSQwsr6r+/J1IxFgsa8xYns7z0AuB79NiObo9bKa9x+fbBgHArrw==
X-Received: by 2002:a05:622a:2cb:b0:4ed:7ca:5f33 with SMTP id d75a77b69052e-4ed30db06fbmr139568721cf.5.1762260861475;
        Tue, 04 Nov 2025 04:54:21 -0800 (PST)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723fe38a4esm201555966b.62.2025.11.04.04.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 04:54:20 -0800 (PST)
Message-ID: <7f8aa7b5-40b6-456d-8b33-0cd505a6bc3c@oss.qualcomm.com>
Date: Tue, 4 Nov 2025 13:54:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] arm64: dts: qcom: Introduce Kaanapali SoC
To: Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Tengfei Fan <tengfei.fan@oss.qualcomm.com>
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-2-3fdbc4b9e1b1@oss.qualcomm.com>
 <36fcea98-06a6-4ca7-a378-77b44b196a9d@oss.qualcomm.com>
 <7fc6ab09-44c9-434c-ab19-764c74b1176b@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7fc6ab09-44c9-434c-ab19-764c74b1176b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rX2F0TP4SB3xfBA5iyORrTCbFb8EPgUZ
X-Proofpoint-GUID: rX2F0TP4SB3xfBA5iyORrTCbFb8EPgUZ
X-Authority-Analysis: v=2.4 cv=b7O/I9Gx c=1 sm=1 tr=0 ts=6909f77e cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iCe_EFKcJ4jOResAbxEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDEwNyBTYWx0ZWRfX3Gmvi3U7qTv6
 yK5o5sQnpYNmzhmQEfpGqHVBK2Rk1H5aLUwfprKXAjzkDMwWCE2tc+qy7mjD+WDnipFq5sRuhNg
 Y8WumTZDlDkHcu8Jeh8QWEsTAI+Ldaer5QwcK0Okr7yOeMOupAKhA40QqO6fIkalZdNQfWUGNZx
 0P6BN8qlBdO4YtSr+KUjfNujq1EC6wnflY1DQcQE1OE5GWdjOUf/O0HyY9R4kzBUA0ECbBDD5/d
 Vnvx1WrKWAyo8DYTCIWVUEf3WJy32bTivpgixeXFM321NQ56wc0/S2ro0XRjsgyryniDSjU6cYm
 h0Zu8mHAl0vMNPuh3gs4+WJ1gz3HQx1+09NVtvChDOzeWOzp1QdQJ/fOW7RXyydTAtoEfB/8W2N
 jH88SMVDcIFaLLDqFUSUJXRGvwJvog==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-04_01,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040107

On 11/4/25 10:04 AM, Jingyi Wang wrote:
> 
> 
> On 10/14/2025 7:46 PM, Akhil P Oommen wrote:
>>
>>
>> On 9/25/2025 5:47 AM, Jingyi Wang wrote:
>>> Kaanapali is Snapdragon SoC from Qualcomm.
>>>
> <...>
>>> +
>>> +    reserved-memory {
>>> +        #address-cells = <2>;
>>> +        #size-cells = <2>;
>>> +        ranges;
>>> +
>>
>> This is missing a bunch of reserved regions which causes device crash when you stress memory allocation.
>>
>> -Akhil.
>>
> 
> Hi Akhil,
> 
> We will not add all the reserved-memory in dts, other regions are designed to
> be added in bootloader.

If what Akhil says is true and Linux is crashing, something must be
wrong..

Konrad

