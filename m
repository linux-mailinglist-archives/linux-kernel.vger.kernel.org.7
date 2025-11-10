Return-Path: <linux-kernel+bounces-892293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9DFC44C93
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9774D4E3583
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4D21F16B;
	Mon, 10 Nov 2025 02:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ku5wY8+B";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GjoFKyRV"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A353219F11E
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762742547; cv=none; b=bQWL3r54svTnlDwaWDKkQccV/pMHtwq7rmSuBHp+Q4MhH2vSViWR3hgAp8HNiC5yuMFWr+3oI0BkAXBwDDl4CO40eL9+XlXIr4vOj9oj5mMS4vrMvncOz8RjyqVrufCD8XrsCoz0Cq0F8xQOqI12hxSLTbYqI5217y389lWDwfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762742547; c=relaxed/simple;
	bh=jUY2UWKqbgiaiqlTpfs14wF15mfVG1aRriGhhiH8ST0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dI1fr8ef9zPFyLMVfhtDBBbPzrq3vPkRbyLZfmqSkHFMwF1efXU+MAf9HZlDpVErCGqklWSvRVOW91SOebl7imDvW8reeH20tO9p4TQngQYM2PYGXUYe3KBoPiVPsL1y3qxFRDD2gduLzzpplTrpk+NMP/ZWcpxF3eHl8CAZHCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ku5wY8+B; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GjoFKyRV; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A9LToBd1661915
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:42:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lsW9bulkHJOywC2vSc0zo/W2H3K/TyzL35br8IJ+ghE=; b=Ku5wY8+BGMALbOHr
	IrFXDYaZQTwqNWl0rNbFmXBx2CICaPKs56QkhacrXlnQTU5uthXGxE/pIW2htvtr
	m8OW19m37e84rtsTLKLJq9cl4GH3wxkECkyNxoB5fIF0kwY8Eij7N4lWaZajZlQj
	l+WCAxArmlQDGYxrMza34QHtTTcssTR7t/9QJOfF53mh6eAc3RoWGLJkxRhyMwnz
	F4o2cWxe9SAKdMqHXR8qWmqOqU/Z4jC4SKYkEuEAHGIRChCLSM5IyRORGiMmeQ3V
	6ouA5Gz4N+p/iecfkRfe9L5rclZWsX8f917X5QYQ5DTkcc5XLNoHOUxNQtjHw20P
	OK2VRQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a9xu2u4cy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:42:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2982dec5ccbso3336195ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 18:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762742543; x=1763347343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lsW9bulkHJOywC2vSc0zo/W2H3K/TyzL35br8IJ+ghE=;
        b=GjoFKyRV6az0IvPTu39Aklc/gCvsBCrweH2TZzH+6EQla2gxytJXzGLJhOtqn4aBet
         18img9JSvvEPXPl/3YDIV+nRfkuuPQKnfBv5YRE0mZMmkE7mOqa+xJv+fjZYei2LLIt4
         qqu1TtyW4GWdJsu6vvW49j7MHL20DXMRPQmBTFOEP9kVKqUF3kzjxKhYVaiU7sFI5kO/
         kXqn9j1k33hyk4LkoyFmi7kUgFtpa3bLtF/iV4bHEwhwork6djoyOtXrv+mlt8S/DDEX
         OK1nNIr+pUsAQGsFPq6JrTbaZVn5j7egXC84SjCUjUjUt1F3OdU7whKMbu+TksLlopEk
         ibLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762742543; x=1763347343;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lsW9bulkHJOywC2vSc0zo/W2H3K/TyzL35br8IJ+ghE=;
        b=b2p0hS2QkvZxbeSTqibyL25tnAgvvTPGpNs7AyOj6BtvSlRE9sVzhee5y6LiTmQodv
         jKa9dlTEms325i+uIuD8DwZuOktc8Jun+fK0gJ+91A4OtewxcCx5AiQAy0WR47uGHu1g
         eC+kWvyXRY1nI+QmtBktX83iZ59yFaKXd0wkQOthcXUkglUc7G7f6hggUFzZslCbt27D
         cfeBOYiiwVP1HhtP+7964cC9hPeL+7cbpfyF1rcoPBpRUTmGR7oarYOMJ/yD5pe/Qjjj
         s6SnlUyjWACRS49bGU8NG0vmahBcyirj2EBTUZgMiNsCp0WYUBLoZFatzyvOmuRjYrbF
         gQDw==
X-Forwarded-Encrypted: i=1; AJvYcCWSOu8cafA8grr4l6Mc4R8IFcAYX7Xu5D5MwiehiFnFxwJAlC0NVpkwcJhPEauMN/rrDEpx0Sunsn/lFRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxXTemS+oX5IPOEq+VOGp1QmnkgxCa3wYztXcKXXYekGyqo3H2
	90wKZX9pYFb74HPD+VRrZ9HmUbHRvDjLNOUWZsgHhpxtmKA+aScAe36weutXBX6+grq9ip+24la
	QYfgAkt71gBLYh8L2LlElEjHHWNKC5me5MFJVAtPBDUzesYbln9o/MTw8c7H/x8gB/4U=
X-Gm-Gg: ASbGncsojqLOuFV7BcW4UV+60ffgllA9V4lQoumcJ4uUZ6B1ipZ8DI3TK9gxQmLWWab
	ViOWdDrNUgLb5jm/qBT9KaeLVceVakkxeumFKFGDsrus0zAj8jdhDG3/kWcTOpkOww9IDSMqabi
	c78KOc2UM8ZI3crdw7cjCJVvXAup7Hma9IOsIqOQgOoHUqhTGXMzLrWLvJjDnCQ0xW1VTRsyrFP
	AeE7hzLB7GIAs1POSzxfgdME/xXKF/pVM53ylv8NrmCDeqrTug57sxgD0/0NqQRrSDcFWjO6ck2
	vC3GqrNiDRjXnU03c5QgTHs/c7gku6dZ5Kx4D8y5tni9pVkw5rWYxy/B7YsCHBP+lfPslRtYT+4
	gOUjaxw0xA8/34PbC4k4XA5/ZatqqDJ7i63EHfNahkl0S84AzH2fAxVh3iU4VVPUK
X-Received: by 2002:a17:902:d485:b0:294:fd3c:6de2 with SMTP id d9443c01a7336-297e5408d00mr89906525ad.12.1762742543488;
        Sun, 09 Nov 2025 18:42:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2NVHwCXqcL83f9zw0coAZMOtqfj0Uy6PSoNGjLNcOLPwcx3nLqWE6a1Jjg4u4EQJp4JwPEA==
X-Received: by 2002:a17:902:d485:b0:294:fd3c:6de2 with SMTP id d9443c01a7336-297e5408d00mr89906185ad.12.1762742542978;
        Sun, 09 Nov 2025 18:42:22 -0800 (PST)
Received: from [10.133.33.229] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-297ddde1e7esm66639765ad.77.2025.11.09.18.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 18:42:22 -0800 (PST)
Message-ID: <30cc9d63-72a2-4dbd-89c5-d3a84e5a36de@oss.qualcomm.com>
Date: Mon, 10 Nov 2025 10:42:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/9] coresight: ctcu: Enable byte-cntr function for TMC
 ETR
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>,
        Mao Jinlong <jinlong.mao@oss.qualcomm.com>,
        Jie Gan
 <quic_jiegan@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
References: <20251013-enable-byte-cntr-for-ctcu-v7-0-e1e8f41e15dd@oss.qualcomm.com>
Content-Language: en-US
From: Jie Gan <jie.gan@oss.qualcomm.com>
In-Reply-To: <20251013-enable-byte-cntr-for-ctcu-v7-0-e1e8f41e15dd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dMWrWeZb c=1 sm=1 tr=0 ts=69115110 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=DxhRIveLkXWR0EuVxScA:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 6SZbWs59PT0RPmrAdl7ISn8EKm8hSt3Q
X-Proofpoint-ORIG-GUID: 6SZbWs59PT0RPmrAdl7ISn8EKm8hSt3Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEwMDAyMCBTYWx0ZWRfX9I3OVTEOT7fD
 rT0QnhVSPuNqpxxBFlZb4AfjfueEXR2aPaq+390uPvxzW3q+vGWkLj6SbWeApXnfJcmDBIIFMV9
 xFranKTyUHVfcxK6GwNYd2s00YQBRJJT7kwbVsLhKUt4XR4nUTvOyd51xxGpHm0wCs6DfwWAprS
 u/OSvcylIIyeSUcSiYT4wrqWUxSZotVLUuNirEi+yCpuf7lo3MArEcxCe8Ufik0h5E1BguGTyk3
 afHY5IaBKmOMkfyvgOemy1ICUmhdiraXXZZd0Wic5vgIENnQi9WdczlFPA2h48s15IIXO1RUWa3
 GxNKSqQdseaU/rXNBzXu6zChp3qA9htEPseMJmID5yHNwSrAberwkBzIqfJzqPx+e2Ggk81g7BA
 wsXbPA6h6AaMpILRzc/2e291kFwIeQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-10_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511100020



On 10/13/2025 1:49 PM, Jie Gan wrote:
> The byte-cntr function provided by the CTCU device is used to count the
> trace data entering the ETR. An interrupt is triggered if the data size
> exceeds the threshold set in the BYTECNTRVAL register. The interrupt
> handler counts the number of triggered interruptions.
> 

<...>

> Enable both ETR0 and ETR1:
> echo 0x10000 0x10000 > /sys/bus/coresight/devices/ctcu0/irq_threshold
> 
> Reset the BYTECNTR register for etr0:
> echo 0 > /sys/bus/coresight/devices/ctcu0/irq_threshold
> 

Gentle reminder.

> Changes in V7:
> 1. rebased on tag next-20251010
> 2. updated info for sysfs node document
> Link to V6 - https://lore.kernel.org/all/20250908-enable-byte-cntr-for-tmc-v6-0-1db9e621441a@oss.qualcomm.com/
> 
<...>

