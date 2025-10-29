Return-Path: <linux-kernel+bounces-875612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C2BC1970C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9982460BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617F632A3FB;
	Wed, 29 Oct 2025 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SOXIJ5X7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IFIuuh/w"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43430329C5D
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730611; cv=none; b=sZRcO2XHyi42SlaHvzxpZPzKqYvSlTGlXXCAYQAngKBunNc/CAarddzSSLUzNRJ1rrFXG52egWhuhSniq8gvfrX7/gnQw6gz9bFKkx5cVpigZRtECO9blOq56Hlv3DNjAeVe4eoDAejKGt6ZyzZfrbl+QNc8z2hFM6fE57FaX+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730611; c=relaxed/simple;
	bh=mUVFVXyWIuUdZYclv/LiD9nnidNGrwpodmI4ocApS6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j9ZXdyR9QUZFwto8wC67HFTuuZH9hT/nziUFYthA8ylPMc576jiL7/EdSh56qoraO6J3txGTNNjtAPHFFtKrSigykCUsI1sArZjqossgiAJ/StEWa3edc8HmFEhEsvja7KReXIxjDsx3fI+hOXnYt0DB0clwfdXmfT0rnqJO2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SOXIJ5X7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IFIuuh/w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4uovo3720135
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZX+z0zuBmZ1IF/kipaR4w1lPQN0bglI+X/qgX7JeaWQ=; b=SOXIJ5X7NyS/x87f
	PCygJAZQV6pkM1a8VGccHJAhdgp1in90HTaJRBWqEjzQhVW+9TGIf/dr8ZqW9AHs
	NAdE9bkucW9GwfYl78PjR4oLHz3DtK4GaiRXwZJwtl5VyEFJnaUlCdxO7SDGXLLK
	B562o2Z7YIIAF2K7bQQTBf1Xnho3iXJChdZ3Xmlni0yyWK6ZqNEU2q/2+EAxzjmF
	5GI/r/xZXeb+LWgfBtgxSaggeWxNc5mZwcoGH8p7aixiuUoNDq3ROqEBPigWAifm
	pXs30nEKYoPnNq+bi2wkinBmZxutW4De8LPfD2c+mOMsW2JqjayOS22Q6OZkC5Cs
	bg2U+Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a2221r-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:36:49 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ecf5ea6669so8441271cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 02:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761730609; x=1762335409; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZX+z0zuBmZ1IF/kipaR4w1lPQN0bglI+X/qgX7JeaWQ=;
        b=IFIuuh/wh0MLjc3u4WqzR/DnAXWmVQsGXILjvzakprgParaRMu1BYbRYXMEENRQQXl
         MWwzzTESHWgOMsoLjnZtB/FQjmUEdBRuiu2lwHCSVwnkPF8Chlf5pItfSCsoHdHrAZPi
         tFeDmecRX2o9jXIxbi38XaACjCUyZWmuM6Kue7e8t3nTMY/jkoqcfZjU9l6yo3ozO3bC
         p7A4csU0A6XqESEVHSDcNjcRr2HOAfB1XYyYTask2MAxB6bBFhg3W3ssYxgtvo0DMAby
         D8Kg2kxiuc2wMi0Q8rhBHuM+MHwIMCjkbpxW1KiJfdCTKtOFR7NiPdLhQMRB0NYYHfgb
         R5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761730609; x=1762335409;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZX+z0zuBmZ1IF/kipaR4w1lPQN0bglI+X/qgX7JeaWQ=;
        b=DHeoRhMZDNP9C/HGk9N/Adq/8Iu5XDFUxGpDlWRCcTdo92+H2EFWkWntwZsGQm63IA
         xTX50c3nu9Vm3AfkggWYg1WUjX3IacCmXy7v4Y7rrOpnTdlwGxYzB8TdgpNHLb4/mUwf
         PnOCKqtSaJPbTnIquzX4oiPkZqozI/pExNawhVyfWeCGPN21BIAWlVmSaVz87lhU3RZY
         AOMWgObJiwsfLie3ztXkQGRxUCv0LzCFm+xkC8lMUf2jDkEcQo2qwbIxDnjcyhEEf4q+
         2myF46zUggw3QsXNWkPhiYzHdvBjUPkfC+PSy1Y0VQgRjiAylLmtjUsygk0LDQq5Jvmw
         8u6g==
X-Forwarded-Encrypted: i=1; AJvYcCXlnvvWkixCTSlSpos6ccdDrH4jeOjso/6x8235nFEMiI2kBTr33SyUkU4z7qjDk4GD0YnM+ZF/ozll7Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy70foJqdiGrHxKRwjbD6BMRjqC/p/6KWh9AEGcKKR7W7GQRXQp
	Jxu5E4PmJS5aKjuv+/1yJzlDZfDQgj+nCYjvk4hMFCgf0YFmFY3I9YHdCo6mm26TbKOVisSIoIx
	cc0zXGEoT81MBav9Hn53sW+HI5xmI/s/9QGKDS5MmwxLW51MbamKiZ1zrnIp4r+PC4+4=
X-Gm-Gg: ASbGncu9qzY0tPOD2pu3MtjI8aTBScgG3XawVrX1SJgPUmfvzpEEbYB4QiU+cyzwhTr
	Ra3hAvApQ4S73kGI+BaleYfGHtGz2bw45yzH/MJFVrIWWttaCPTfJK3DndGHTzHPBSgPfas1yaT
	mBqGIMnUCaFF4wVl/zBvw4Xxy1glHAcxevyyL9CPEjDRExDSqGI+Nxk7P+yd1iCMnjzFc8MdjwO
	SsLFxme8NEv/fe7PtjHUsJW2z4B/UBqWRryDgpyv50sTI5ToVDmIPLEb/cnVrDcH39jYeZW02XV
	ZJNd6fqoMI5b35GyUKoW7wik1Sk9JU9/MtjB+xWZbwasC9A27+7oDe2TQ/VG3aRwwzBzKn/CsT+
	eX7J5DrRvrjhv9T6JYpn6S5BPKU321e+ohvIsHENxtme32T7Hc354WACi
X-Received: by 2002:ac8:7fc8:0:b0:4e8:9ed2:78fa with SMTP id d75a77b69052e-4ed15b7550amr17762791cf.1.1761730608693;
        Wed, 29 Oct 2025 02:36:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiuuYOYZ78vOwZJBF8pnhsLeaffastPxwg51v90izy5tvj931KhAwTG4MlABhwJ5UScWforA==
X-Received: by 2002:ac8:7fc8:0:b0:4e8:9ed2:78fa with SMTP id d75a77b69052e-4ed15b7550amr17762601cf.1.1761730608194;
        Wed, 29 Oct 2025 02:36:48 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8530905dsm1366152566b.6.2025.10.29.02.36.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Oct 2025 02:36:47 -0700 (PDT)
Message-ID: <289d000a-b142-46cf-ad15-07ab8ed377c9@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 10:36:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] arm64: dts: qcom: cleanup GPU's zap-shader node
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20251028-dt-zap-shader-v1-0-7eccb823b986@oss.qualcomm.com>
 <c83079bd-ebd2-49fc-ab62-1fba08276cc4@oss.qualcomm.com>
 <51f10d4e-3962-4c20-9d5f-afd0ac3f598e@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <51f10d4e-3962-4c20-9d5f-afd0ac3f598e@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA3MiBTYWx0ZWRfXwI8vdnxWnlYR
 5j8DxgYT0/di6WpyOS2M1ofNNKff+GSknDUCVbepR1vzkZfhdnnKRGsMmOjNGzLAvo5JPLAmAJc
 Uh8UpldJ3UtAdxrMEy8imlJooUha+dwnoZ27ezw2ivkO/jbZoBzIgd8zq4z1YSO8R0isd1Clszv
 FVRUmOkC3Cc3cA0253k/3v4TlezOGEB5mb5C3Z5GcvBUO4oex/l8yA9/Co6zYNSY5PIdsYI8QE9
 ip/QWHeSRNv0XJULDz1Uz0iM/mmwrThCCTgcBJHh6Pjg1LKOhxTklHZ5pP0pdiv9JkhLijAx8wx
 CqDoUTIX5eOWIl78el2DJcANin2BoEqHyxdTJY8+oixL1RxYUsDcJV7MMDzbu/RBWG3DlMmV4Rh
 avh6B+LZzawUiDTtC67JPYoO1I4A/Q==
X-Authority-Analysis: v=2.4 cv=V5ZwEOni c=1 sm=1 tr=0 ts=6901e031 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=AlufK8GOJj28j8g1HjIA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: 7B7Eiy0dI4XAuRZwgbr6h1sKeOZFxrL8
X-Proofpoint-ORIG-GUID: 7B7Eiy0dI4XAuRZwgbr6h1sKeOZFxrL8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510290072

On 10/29/25 10:35 AM, Dmitry Baryshkov wrote:
> On 29/10/2025 11:33, Konrad Dybcio wrote:
>> On 10/28/25 9:59 PM, Dmitry Baryshkov wrote:
>>> Historically all devices manually defined GPU zap-shader node in their
>>> board DT files. This practice is frowned upon. Add the zap-shader node
>>> on all platforms, define a label for it and use the label in order to
>>> patch the node with the firmware name.
>>
>> I'm not sure this is much of an improvement, since at the end of the
>> series, boards still have a &gpu { zap-shader {} } section, with the
>> inner one not being referred to through a label, which reduces
>> duplication in the single LoC used to assign memory-region, but
>> doesn't e.g. prevent typos in the zap-shader node name
> 
> By the end of the series the boards don't have zap-shader{}. They use &gpu_zap_shader { firmware-name = "something" ; };

/me wipes glasses

You're right, I skipped over the last patch

Konrad

