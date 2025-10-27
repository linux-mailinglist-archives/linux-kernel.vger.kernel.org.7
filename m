Return-Path: <linux-kernel+bounces-872036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40B0C0F2AD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DC4F4677E4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4C0324B09;
	Mon, 27 Oct 2025 15:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mgORrcLr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B4322A27
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761580053; cv=none; b=rDoDiI3KSbDnIX49MiBL00T5B6UDeBOwiLTWB88hHifyNHBIgaYCY05YgbvDbjGFqPo8Fs638BD+aKalvLxkz3rsAckOoM7jjBhFfbATdygXEbes6woaL4CC61Ws7s+Ag17Jl95KBuG45huIVX7LYqb3e9aMZrIBA//PdKs75ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761580053; c=relaxed/simple;
	bh=tQL6TIWCl8aDOrH0GaFalhGYJg12eSESkwTpBcEYy4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VU9uUFQJWwiq0xUOGERbc6QcP6lliF+/wJWUSv7G8qdYb9hL8elunuhwI8u+r3QHtXGWaecpZC3rgkHFimKsf/+PwZ4E1gHfFyGJgI1551FO6OOTpFNquITU6MqOlVAe9KAypHETIwmpuuHkEzAK3SzyH/zd+Zu6D4JzQHEKN+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mgORrcLr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RE4R6N3018086
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:47:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zaCZneb5YWhjC19k4/2yPgAXlS8d0rH/p95cOFgMm+o=; b=mgORrcLra9bOxg7T
	BMlgLI0vpCS8JfbfdZmTNX0ukmVnYaCpmYmWzEf9SWuwytvlRiEBXxsUP1r73M+k
	i3KI+Eu/H0GFZOTcH+H/5CeDEas0/dg7o3H4THI/rBwGZ7r5jOsQ4V+NwlZg2MJM
	IIyhvpaN633LsfXiXUC1MCdII7Ta3e5eBfYYfC9unGEVgNuCQ3mSpcp1Rzagoclo
	PkfAPKz8DXlp7lVLNVocXSQlSwcKAE86x+cDI5YzTuc2hVU+yKcMnHe7/ytKyoIo
	R4O1TVc8gtDAN8msWB7dFgrhVUEbmIAqpsDfz3YlSCHK9gIDS2w0urzi6wlAHZwD
	veOKWw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2a6a8dgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:47:30 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ecf8fad13dso3338881cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761580049; x=1762184849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zaCZneb5YWhjC19k4/2yPgAXlS8d0rH/p95cOFgMm+o=;
        b=ozpUlHvaYtxCQX0u+BMj9G0PvYHGeBJZ+MWGgjHE45/uyMLA//F6r9BK8N7690TEQs
         geTcevn2uWzoy3ZYH+1Y6YNQ3gZV2WTNc3DOANGlhOL5My8ULoM9ouNNRZMes8wIM0Gn
         sTyrTO/SWrTbRK4pdH71evxg0g3vKwlmwxUFiEwhZnuGC9SP7s96yU03FH9ZFVXaXgJz
         4R0KNW/SyX/igD8yotPWvSECV+MrcmmoKEigh0u2U17W0B55oc8IC1hj3Dyy4uLjXsRY
         JrLPnU97IykagqUx/90aZGA6Qxrxry2+DLJpmNBY5QSm+Tl1SWy1zDanhf/UPnNnMw4g
         1XFw==
X-Forwarded-Encrypted: i=1; AJvYcCUfN/xvgDKLrNUMNIWz03lpet9RXazICaPWLyfTbL4Lfb4U0avuC/F5HTS1lZxYlNBuJ4MKSVjyMElZCKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYP21gS4R8+T1xYiJPvsWibcWsFm8sHdTZo4M+c+HhjgKEhApY
	UIpJSLGYs8jCUoxJlRQr/Ye8yqzkgM2/tOzY6ZfpBjXR8xPWudMksNJg0TlfuZpvGud6OWcLQ7o
	oREt6K1uHcpBpc9mzBRVml1kALfopwM7kWBOgNeEMOM6VnUYKhJsZjCmXuX6ozLfuaeU=
X-Gm-Gg: ASbGncsNo+5PuY6b/uZkx5yBdwy4EG9eZsd6WU/WUqqPEIvDLUx+EwMkESuM3GoNyu4
	AJ1c1Gkw5GjT7t/Sr7KUdGYjLbwoL53Mq31gVYpeepxZrmEOLunpS2f9FNRaOH0f8H35voLH+Z+
	MvtMJX2ZaC4Bg6xJT+U6YXdcfRs3h4N0hksUl7NjoUMnUluoPsunPyxk2S4TlmuLEPbqO44pxeW
	4mAkPKEMhijTKm66ez169GNvTbCc3GZgHv7VgJs0rJN8dW2pjRLxbxuzdbEpahcTtTxSbq2n0AJ
	GZRHs/CGQHDPjRqHpfRwxXfiZn789GULNoHV12lggCOLd3MTzGPmewgGVC8lYDpDyWhWm8weVqn
	WImW0h6b3uJy/+szh5UqLtoPS+/KmUUVUAeITUx7fJlODmZOLfAPix5fO
X-Received: by 2002:a05:622a:15c2:b0:4ec:f075:50cb with SMTP id d75a77b69052e-4ed07425e39mr4975221cf.2.1761580049431;
        Mon, 27 Oct 2025 08:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGIgcSp0xCZswOedEYchtLWxCtcXToz2VeG+CLk8VsDBcRyNSlY/6wzGEsHr6w4SRPPrVI0GQ==
X-Received: by 2002:a05:622a:15c2:b0:4ec:f075:50cb with SMTP id d75a77b69052e-4ed07425e39mr4974841cf.2.1761580048893;
        Mon, 27 Oct 2025 08:47:28 -0700 (PDT)
Received: from [192.168.119.202] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d85413b88sm778566566b.55.2025.10.27.08.47.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:47:28 -0700 (PDT)
Message-ID: <7b68381a-0f7f-43ff-b934-9db5d9b2e69f@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 16:47:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] soc: qcom: rpmh: Add support to read back resource
 settings
To: Neil Armstrong <neil.armstrong@linaro.org>,
        "Maulik Shah (mkshah)" <maulik.shah@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251022-add-rpmh-read-support-v2-0-5c7a8e4df601@oss.qualcomm.com>
 <20251022-add-rpmh-read-support-v2-2-5c7a8e4df601@oss.qualcomm.com>
 <litd6qcxuios7uwwcrz55ea24kj26onrjo2aekouynsce6wslj@vatjbulg64mb>
 <4831d12b-a42a-464a-a70f-e0e40cf4ae4b@oss.qualcomm.com>
 <5c0b4712-4a54-4a1a-ad73-dc3bdb21a0ff@oss.qualcomm.com>
 <cb361d77-6845-45c9-b418-67649880495e@oss.qualcomm.com>
 <ef247fe6-6d9c-4a74-b3f8-a56857332758@oss.qualcomm.com>
 <9a227c15-dc60-4086-8d81-f80e3398a083@oss.qualcomm.com>
 <18e8d5db-e32a-4893-9d1f-5003670cedeb@oss.qualcomm.com>
 <7656e8f6-e281-4f7b-9ff4-1b2722234091@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <7656e8f6-e281-4f7b-9ff4-1b2722234091@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDE0NyBTYWx0ZWRfXxXKotcUtFAi6
 oOkoiTNZu7mcKl9jadJLxx4Tozoo2+61aSJSamx9oACc8/UZIQCJ7QVk9HxD/T7FAejpYC5T2Hu
 EG7aJTZmUbc0YQhKZqHO7F2YHRj9TuNa8rvOIIP3ewTTnmmsvwvJi/BzZakXNna0WL6UA0kx6j0
 z0X+KgLPyfrHUrDohXdLWM0fjb3qC3tzVQO4J9Azq91egXunDmjpRENE4HbjS3E66BF8qqNTev3
 kZrFyqlE6OyvCUddpWuvHZm3V16NG16nnrnrU2P/nfbtj86BNL9e0XGx8fAuuEBt/tn0tBCF4/S
 oj93ypKhEcnWve56Vt77JZpUYZEqKP70tO5+f/6PE1uZ5tDuBN7WrHbKfrGJxPZ+9r9qxG/5wqM
 Dyy1thMPDIMqJWjEeqDuuQWDDGOpQQ==
X-Proofpoint-ORIG-GUID: Fe1CijrEr9T7NqR0cd7pwWCedyKWt8SS
X-Proofpoint-GUID: Fe1CijrEr9T7NqR0cd7pwWCedyKWt8SS
X-Authority-Analysis: v=2.4 cv=A6Jh/qWG c=1 sm=1 tr=0 ts=68ff9412 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=gzx7cS8GTzoW4zH438oA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270147

On 10/27/25 3:38 PM, Neil Armstrong wrote:
> On 10/27/25 14:29, Konrad Dybcio wrote:
>> On 10/23/25 11:46 AM, Maulik Shah (mkshah) wrote:
>>>
>>>
>>> On 10/23/2025 2:39 PM, Konrad Dybcio wrote:
>>>> On 10/23/25 10:57 AM, Maulik Shah (mkshah) wrote:
>>>>>
>>>>>
>>>>> On 10/23/2025 1:47 PM, Konrad Dybcio wrote:
>>>>>> On 10/23/25 6:46 AM, Maulik Shah (mkshah) wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 10/23/2025 2:51 AM, Bjorn Andersson wrote:
>>>>>>>> On Wed, Oct 22, 2025 at 02:38:54AM +0530, Kamal Wadhwa wrote:
>>>>>>>>> From: Maulik Shah <maulik.shah@oss.qualcomm.com>
>>>>>>>>>
>>>>>>>>> All rpmh_*() APIs so far have supported placing votes for various
>>>>>>>>> resource settings but the H/W also have option to read resource
>>>>>>>>> settings.
>>>>>>>>>
>>>>>>>>> This change adds a new rpmh_read() API to allow clients
>>>>>>>>> to read back resource setting from H/W. This will be useful for
>>>>>>>>> clients like regulators, which currently don't have a way to know
>>>>>>>>> the settings applied during bootloader stage.
>>>>>>>>>
>>>>>>>>
>>>>>>>> Allow me to express my disappointment over the fact that you sat on this
>>>>>>>> for 7 years!
>>>>>>>
>>>>>>> This was a dead API (even in downstream) with no user since SDM845/ 7 years.
>>>>>>> Read support was eventually removed from downstream driver too for the same reason.
>>>>>>> There were early discussions to remove read support from RSC H/W, due to lack of users.
>>>>>>> Its not realized yet and all SoCs still supports read.
>>>>>>
>>>>>> Can we read BCM states from HLOS this way too?
>>>>>
>>>>> Yes, Any of ARC/BCM/VRM can be read to get HLOS/DRV2 votes.
>>>>
>>>> Wow this is amazing..
>>>>
>>>> Do you have code for this already, or should I hack on it?
>>>
>>> No, it won't be of much help, as i said above it gets HLOS/DRV2 votes only for a given resource.
>>> More specifically, the read does not give the aggregated vote result across all the DRVs.
>>
>> Hm, perhaps it could still be of *some* use
>>
>> But maybe reading back rpmhpd and rpmhcc states would be of more
>> use!
> 
> The interconnect core definitely supports reading back the state at boot.

Maulik probably isn't impressed with us only being able to provide
information about HLOS votes, as e.g. ADSP could be voting on the same
bus in parallel.

I suppose the very same applies to what I suggested with clk and rpmhpd
although probably it's less of a problem there

Konrad

