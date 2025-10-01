Return-Path: <linux-kernel+bounces-838675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C480BBAFE63
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 11:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F5FD16A842
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 09:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC75B2D9EFF;
	Wed,  1 Oct 2025 09:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l4Byabdp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14BB1804A
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 09:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759311689; cv=none; b=bYIAl2XdAQV3KNwawSnEAZFGnFGRkc0kbauz1qlZcWsDVmqAa1N8K7FXCSTqbQMTXGAO81xV5HILWVOgzHpWYJTM+ERJ/ZbEVcmRPV8qzJatOgqNMM+blxZOPwLoNIcGzgwNw6y+uf6wTbbUXB3v+klSqv4RLE8wPTJOhu2AnCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759311689; c=relaxed/simple;
	bh=3J/3C9/qAuc3jy5xtNGYDipuOtbWzZ9YafcLRq0pjfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLjww72bv+1YuZNSYb1Xs2yCBhCAGSf1jcxSCWh7/clh0j+WxxvQr/etoH1D3qgDfOm3AiHqoACMzG67Y21/YTzzJBwP5SYj64RwFO9vCBk1kN4RsuZCfzpC/0QU8L8sGppy1ZQDdLfDs8SeRkAI4BkIo5VLExbBkxwkqdi7lxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l4Byabdp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 591951TX012468
	for <linux-kernel@vger.kernel.org>; Wed, 1 Oct 2025 09:41:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	XMACI507iNq+HH50Spkbf83wGYWWaPzjK+BT3qk0pyA=; b=l4ByabdpJrErpzYr
	fBw8oGJHql7bQRmgvqOqrwLDmhXaZWCeL44ZfTN6uNWKsXOj6sb8FLIZrT1Wd1Kn
	HGKhkzno1McspJUDOKRiL/6Wg7KYGerScJboDgZ8dVpHXwfKqV4urBEX9Mq60v7s
	LS24IpgBqsM6LTcg+oV9AUuWKA0NpsfiPP6UBj5ILzqQ9Xz2U6yqrTyYLI0Y8zN5
	Ohu5EUxat1ZbfV6TM3lu71knywb6xzV+oqTfJA5gFXohXnxBowz4Njn5hnyqUlmH
	YFBJtaQ5OcppjFvR+HvSikO1TqCX9J5s8nQW/oM2qLZs4nfgNIWoqcpYNYuyC51j
	rQNdxQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e8a64396-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:41:26 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-826b30ed087so8249416d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 02:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759311686; x=1759916486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XMACI507iNq+HH50Spkbf83wGYWWaPzjK+BT3qk0pyA=;
        b=pUDKsn19jaheEtGdcvX3au5cRpXNDDdtQZoUnEJLWGDTtf1USQUJre0dFb7jZsh/m5
         DrMhhJKSm8xj0GNER4H58vJunvCnLih5cEt7zH1ytEYjkZK+2L7WRg6gLfj2MeUC6vsx
         PdyJW6XLuV6Sz9wPZVOsdDtjdqWdkF9ERpejDJBTdgxT4UiWemnElG+TEr9QWhrwl6AW
         qqx127q3JAKe/C2D7h9eNNSDDJtPey4yYMvs9wZ5U1C3TzWxkI+lml6p7q4jX8toEZCH
         cw829g1oM7TFgQhmYv/oD+N7eD7liNiXB9IokZgervC1f5VSi40mPaF/b+YpApZTLH2/
         Rpzg==
X-Forwarded-Encrypted: i=1; AJvYcCWRhWfGpCqOfV90OOOkRS2tCOMYGfTQnlmh8we1/9GwTtqqV7Zd5vzfgoyjru8FYR4EBPXMOCNbx1xWFdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL6pOOxs8/i6FviquPBAtADvDF5q1G7oKgnoZwktzavq06CNNt
	V0EF1a7+5NRiTJJU1RWxAqFRcoeVEXAVcZw24/Vq2okAJVqjQrLNaFVkCjtxkEk93vXjbit1Izy
	hhbpteAiyy/8HQSAQ7HiD6Ocgz1oZC4zgibryYmKnFAq0PDWuey3ovYGD42gOSzex/Mg=
X-Gm-Gg: ASbGnctVz5A/TqydNEeJPG0pIvMtCi+DspmZv/4b3n+tttRCdv7VilbchWqT9IPUti7
	Io+gD68q9xE9WI1N2am+FxeyzA4jkUyud6T0OIxf1qMutx5ePMXmpdbGLCxmgO4WF1N4B7pCH8d
	6Vx9NxjnYvO8JYxcJKIz9Oij94lEqp2iyyZ4oc+tB9vZbI3Tt9+IdDsz/mxtu5BjKUwE87+bC1g
	w6tQbY3t7sfHgM18JIjfo0DYdS0FqFd4h3K3R140rCTyFBHU4bHmGDy8rSYHYUFZq42waMB9p7G
	/uOKqnIXIXtqFOBax4utvFUGPhhWyMX+dhmmHdlRe7xQeyUpJpJ631oXJdFv+KZn2cMpcdS7uzk
	8YB/HgB+tTMHiXqr8hukjpLuoY3k=
X-Received: by 2002:a05:6214:5901:b0:876:2e1a:e77b with SMTP id 6a1803df08f44-8762e1aea08mr9576076d6.7.1759311685719;
        Wed, 01 Oct 2025 02:41:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH91KYJMcHd4nXItFYbdscjiAMA6CT2dkzCKpFdliLag2sdxHLuQD82pLNUht/6WuFnNRwYMw==
X-Received: by 2002:a05:6214:5901:b0:876:2e1a:e77b with SMTP id 6a1803df08f44-8762e1aea08mr9575846d6.7.1759311685090;
        Wed, 01 Oct 2025 02:41:25 -0700 (PDT)
Received: from [192.168.149.223] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634d8beedf1sm8022837a12.26.2025.10.01.02.41.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 02:41:23 -0700 (PDT)
Message-ID: <45d20c2d-aba3-4822-8965-a7a05096860c@oss.qualcomm.com>
Date: Wed, 1 Oct 2025 11:41:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] phy: qualcomm: qmp-combo: Update QMP PHY with
 Glymur settings
To: Wesley Cheng <wesley.cheng@oss.qualcomm.com>, krzk+dt@kernel.org,
        conor+dt@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
        kishon@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org,
        robh@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250925022850.4133013-1-wesley.cheng@oss.qualcomm.com>
 <20250925022850.4133013-8-wesley.cheng@oss.qualcomm.com>
 <bc866f21-9b41-43dc-b450-59a25d547b88@oss.qualcomm.com>
 <297ee4ab-73f3-60d5-8e16-8830135603f1@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <297ee4ab-73f3-60d5-8e16-8830135603f1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RZKdyltv c=1 sm=1 tr=0 ts=68dcf746 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=fy7xcfgtcmc-wzi9Pt0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: Z8IzcgIOeWHC9sNGxisvUex_oLWS1xif
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAzMyBTYWx0ZWRfX4AXG4trGN5mZ
 ygBETcU0RWJAwLfS+E/mStC7rYJMt66CvrNo0VW46/ZMdj5jDQsOBpFDv+VSh0PR3cPzgYAQ4YI
 FGeQMFahXYtx9N/W70PDV1qPWKMdQpe9Fd6XDO1SULOQGjJKo5qAlj7hO5Q4FL9a+C2PYG4igbe
 LzDvwb/Q++/HqvK3t0WssLWtGUBvy9HuUv6NwBfWbv6u0br3NPHxJhU4apsqxGLI5CSTdsRj/fr
 RIFnRnxSoOLdRVGzQhBfiYMj6kHJ3j4twTmJaFRMUHfYftMrREVjgnH7lRbkHXmKD3ioYjWyyry
 DbYiD3pGnVO597hYXaeTw1SdxJiaPKjKelIsZ9VoqOEbcuJ2N5BLbKqnehmqBKdqKKb/XnQZTgQ
 IK942YfO77PcATN8b4VB64Xw79IJWA==
X-Proofpoint-ORIG-GUID: Z8IzcgIOeWHC9sNGxisvUex_oLWS1xif
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-01_02,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270033

On 9/26/25 1:03 AM, Wesley Cheng wrote:
> 
> 
> On 9/25/2025 3:43 AM, Konrad Dybcio wrote:
>> On 9/25/25 4:28 AM, Wesley Cheng wrote:
>>> For SuperSpeed USB to work properly, there is a set of HW settings that
>>> need to be programmed into the USB blocks within the QMP PHY.  Ensure that
>>> these settings follow the latest settings mentioned in the HW programming
>>> guide.  The QMP USB PHY on Glymur is a USB43 based PHY that will have some
>>> new ways to define certain registers, such as the replacement of TXA/RXA
>>> and TXB/RXB register sets.  This was replaced with the LALB register set.
>>
>> [...]
>>
>>> +    /* override hardware control for reset of qmp phy */
>>> +    if (pcs_aon && cfg->regs[QPHY_AON_TOGGLE_ENABLE])
>>> +        qphy_clrbits(pcs_aon, cfg->regs[QPHY_AON_TOGGLE_ENABLE], 0x1);
>>
>> Clearing this field is going to prevent the PHY from ever going offline
>>
>> The HPG says this should only be necessary for keeping the phy active
>> during MX retention (and the listed usecases are USB4 wakeup clock
>> generation via a respective _USB4 register and/or USB3 autonomous mode
>> operation), both of which are currently unsupported.
>>
>> Are you sure it's necessary / desired?
>>
> 
> Hi Konrad,
> 
> At least on the PHY HSR, its mentioned as required, and if I remember correctly, if this wasn't done, I'd see QMP PHY init timeout.

Hm, the wording in the docs is a little ambiguous to whether
this is really needed, but let's roll with it for now

Konrad

