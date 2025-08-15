Return-Path: <linux-kernel+bounces-770215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E193B27884
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86328AC100A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 05:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E466A2BDC3D;
	Fri, 15 Aug 2025 05:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b2uQ4AlC"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EC928724C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755235984; cv=none; b=DE5TXe+17+O7utY+q7cI4HVkCO/U3ksm//96WbeI7Hc9Mz6rYzbSXH4Q/BNaeLiHYk40vBWm7mfcB4p8WzoAxQ9yKCsOjDbzYioBj6uRYbR1jrw0V2rL7cq8cyKhqYzZsMyhXVAOa6OIPswad9thhjzz3v4P7Nv86T5oLqrIcHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755235984; c=relaxed/simple;
	bh=URdpp/WxyhUfI/Ae6q8F7A21mqxWZYGH4gH7+ePLRoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHbU6BCBSHocI6MFbjMoClG4zy/Z6/bFlreK7I4KRS0FfE/KRJ1NurjxmM3BeNweEhdxOJ7CPw0WLSDoUfj4yHwfdwNyk4n0NeORubDW/xVaicMce6UOQhfMFdCORgduefJ1H6fQUYV2D6LBdNfBZyxu6iVoc8+WJdWEN9CM4ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b2uQ4AlC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EHYHuh002802
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ovqL3ACv+kUZfn7O+wK3v6Lc3iCZ+BawVyVb9IBebzo=; b=b2uQ4AlCYcKxl4lY
	zTEMrPcXuNqswTaxa89jZcOvtvEzi1+asa5ZPT1z8Y3TYlnWxnVqpMI8ozzqVbR3
	ayEY9QMAHQRZOcyzvXpMnTj9O3PGswsNZ64VN/ylRiZCmyLTFqCHvwe4qOW8yDsF
	KOOgCJPlED5sajWGkoupvW77S/mqEbEYvgyFRscuazYbRb0xU8xWPItKyrUm4GtD
	EoMItrk+OGhgFi1eE4TDQKU9SVQUtBVqbkJS1HWemvxoij5Y7acT7/G2UazGwXFv
	3MhfJaMO1pNX+sEyQsoQuoG6zzksNpXNkPbFNFZRtFY5mhVe6STW3jcD69zC1cDF
	1lT03A==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48dxdva3b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 05:33:01 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70a88daeb18so37695866d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 22:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755235980; x=1755840780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ovqL3ACv+kUZfn7O+wK3v6Lc3iCZ+BawVyVb9IBebzo=;
        b=ZrghpArqVOe6G++7qt1SuPSYILlw1095SVUuGdjSNRWNMmKzxxxnj9loaOuXyNdues
         BLV7dAWPlb2ZHcvraLixNN5REEzMqhhHaXwXbjotHVRL4/9RIQ/isdCI928WMp44WTEK
         Vc3au1R91o1W8YqzBLaCOPxz1i3+ALm9oXm6G3x7wWjxWlEax8/D9i7bx8KZxWx1fYo5
         alknurUxs1VMr0zZJdGYOXfJvfLD/V3pKUmt9em6qBAK5tYwfSzWYfmb7w6CsjMeS8Zi
         zZSzOqadEWzktIAaa+XvI+4MsypHB9aeorhBILaIBbV5IxUrm9Q0tZ/lSYIgcy8LLhuY
         AL8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUMK+ckBQih+SPsoFv+I8VaY00iVGof7NGRhsTw8Sq3lg3+EIjalqlTe6fIc7a89rKrdGL9usG1VZ7RN6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/FyvufcZDHXiEe4wQQG+tvCWwEhqEycgaU3NVjJ8JJGiiWacu
	/c3hMPSQzYr/igdDKUNsnpPlFgexV53ldBVoDbp0ZEc4rBm3HLOgx2nPBaFKl8cypMlCpE/C2av
	0HF0hNsO/P1keKnpxJ2e0nJw12ZN6dSTqQGvrB6XeeJrQSUftKhn1GmmmdoUI6Yop9GA2jVufmd
	o=
X-Gm-Gg: ASbGncsy99j/1UEfZa2j9jrXlWqbGhuLDFcxx8VhPxg2W1IwdAz9ZB3LYUQcfETT7Iq
	90ZcXkEHf+Eu0qgpEfZtDcYuIBP82i5oPyaTLervw43e11BVdZvI8h8MC4IiHtRwbKgVO645Nki
	hp4NWLinKOAkndROp/zXdjtLGW0d5icaXeTZh+j+FMFs17bqpYN8baz34HYViX2syZ7Otjmd/HR
	ZJ46K94ZRqq4zkOrR5xQTGuUij8+L7LDI11HhHFHY/ZvakSlwvtXar/Zi2F2ZHxb0+U/Vp8skV6
	/CcYBjDl+jkQ5X69THgiqz/t9ItAlr0DGbRulR0pqV/9PW+/fy7o7RQFnTzm/cg8yvI=
X-Received: by 2002:a05:6214:2465:b0:709:f4f6:7efc with SMTP id 6a1803df08f44-70ba7c0d99emr5540356d6.29.1755235980546;
        Thu, 14 Aug 2025 22:33:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxfir1wXxaU83tmZ/aq1nahL0CTNuUHTP9k/Q8uSYSN41izFNRaLdK4c1petYIvpY4X2AnhA==
X-Received: by 2002:a05:6214:2465:b0:709:f4f6:7efc with SMTP id 6a1803df08f44-70ba7c0d99emr5540206d6.29.1755235980122;
        Thu, 14 Aug 2025 22:33:00 -0700 (PDT)
Received: from [192.168.68.118] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3bb652f90casm635115f8f.26.2025.08.14.22.32.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 22:32:59 -0700 (PDT)
Message-ID: <19494b00-a5b9-4490-bddb-48f48e73b0ac@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 06:32:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] ASoC: codecs: wcd937x/8x/9x: cleanup
To: vkoul@kernel.org, broonie@kernel.org
Cc: yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20250704121218.1225806-1-srinivas.kandagatla@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
In-Reply-To: <20250704121218.1225806-1-srinivas.kandagatla@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=IuYecK/g c=1 sm=1 tr=0 ts=689ec68d cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=me_V05VD0Eq9TF5rt4AA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: dgbv2jqTP6_l6celcVMGhHJG061x5hTj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA5MDAyNSBTYWx0ZWRfXzgGNZQkQhxhQ
 NmTE98yKG5jnCVp+eVUlGiHTAQAV6WjpoOeWvoc4QcMJn6sewPIEAQlIbmQNP2LMoRdR7Ibug9b
 fadIxcaCJPgyzvN6OcW6tNArEnXflvbuCtKNXoMtX/vYrYoNIYG9I18qYVls+yMiwkoNWCfz1zI
 qvv4D46McFcvcmtm+z//Ea1EPTEhqioLY6Y1V5sPhYtgIHGzCjMiv344a88VrKRuIZZjiMlANer
 Ps9DGGd0/CZ0PrioKSOvjmvR1dLQxkcmNmbKx3+g3WiXoxe2Q95i6b+K2MFqyXqrteGF0PH1w86
 3wQNtskbEIsRRonXWCz4nGoYkAn2VxTFASre+h2qH1hm56nbzlY+5f/IFN/MQfHXT9uAytq0ljV
 EFHy3v8p
X-Proofpoint-GUID: dgbv2jqTP6_l6celcVMGhHJG061x5hTj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508090025

Hi Vinod,
On 7/4/25 1:12 PM, srinivas.kandagatla@oss.qualcomm.com wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> 
> All these 3 codecs have been duplicating two of the soundwire
> functions. Noticed another new driver starting to do the same, its time
> to make some helpers so that we do not duplicate these functions.
> 
> I have added two helpers of_sdw_find_device_by_node() and
> sdw_slave_get_current_bank() in soundwire layer for the codecs to use them.
> 
> Changes since v1:
> 	- updated sdw_slave_get_current_bank do error checks on read
> 
> Srinivas Kandagatla (4):
>   soundwire: bus: add of_sdw_find_device_by_node helper
>   soundwire: bus: add sdw_slave_get_current_bank helper


Do you have any comments these two soundwire patches in this series?

--srini

>   ASoC: codecs: wcdxxxx: use of_sdw_find_device_by_node helper
>   ASoC: codecs: wcdxxxx: use sdw_slave_get_current_bank helper
> 
>  drivers/soundwire/bus.c        | 12 ++++++++++++
>  drivers/soundwire/slave.c      |  6 ++++++
>  include/linux/soundwire/sdw.h  | 17 +++++++++++++++++
>  sound/soc/codecs/wcd937x-sdw.c |  6 ------
>  sound/soc/codecs/wcd937x.c     |  4 ++--
>  sound/soc/codecs/wcd937x.h     |  2 --
>  sound/soc/codecs/wcd938x-sdw.c | 17 -----------------
>  sound/soc/codecs/wcd938x.c     |  7 +++----
>  sound/soc/codecs/wcd938x.h     | 13 -------------
>  sound/soc/codecs/wcd939x-sdw.c | 13 -------------
>  sound/soc/codecs/wcd939x.c     |  6 +++---
>  sound/soc/codecs/wcd939x.h     | 13 -------------
>  12 files changed, 43 insertions(+), 73 deletions(-)
> 


