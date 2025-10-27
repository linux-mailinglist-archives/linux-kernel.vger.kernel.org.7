Return-Path: <linux-kernel+bounces-872068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C10C0F3B3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE4B856608A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA2F3311975;
	Mon, 27 Oct 2025 16:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mcGpyXKe"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B793101AD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761581336; cv=none; b=jfVJ9vQ9oVMv5dEZYSDOrI7ashvkoOR4H9altjVlI9p6JMM3Kf+9Ua8BepHkmRdhYxqhPj6RCwMWngXz/F91wrBnvUa8vQ79XlvOO+wT9hEk8ZcHi9qC2y//u6iBqQJ8fL+BN4Cjz5LCn0kA16GOIvku2APY3DxgVx6EnM8twl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761581336; c=relaxed/simple;
	bh=uzC1MIwCWLUYwFvOfQujj7KX1k+1FpE+mz/zZk2ENgE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=r63gJZFyQDrbBJuf6BqBaEw7edP6izk3ZB2baviJqz09CdvJHsuYuF44+XizlfCJpByM695nx2Vera9P0tDKbOE7PCzqXnEOCIQPboYCTgGUL14aEK8MZ0qI5BNtCKStfz2QofCqZzW/EbfVMd9N8SXorI7/awIJbvKsOe+Gmec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mcGpyXKe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RG3CXb3207235
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KgRMpIuzEklhMyLqeSgTqelB6K/jP1FY8xNuF/F7waE=; b=mcGpyXKeJIl3if0g
	BTHBHMbOb5aFzf8YLocOxs83v1pY7wAmIyfj/BIAB05engfqIrH8DQ7Dze48c6V5
	jUkJSqKFQihpS/LuCSe55d0lqn4kiJO6svl7GdaUM3r77/bQcB04FoBJTPxYiiVV
	oa/EVozhJoNDzSGj+gguASqcrQZDUEkNHgfvcB5ZJqk8Adqtwcz9E3Q0j8pfWibY
	iPs8skpBVponxxBsg4fBAE3GYhx/gSSrArMH39KJtG3WfN2viTmYsO3KA6PPIHGi
	YUREWHeHZGQPrTYgWB5VJ+9meKoTXlHnMNzARJM7e3FHDOpd9fG2H7pXlOtQ39QB
	+Fc7Mg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a2bwtg0qc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:08:53 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7a2878dca50so5822329b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:08:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761581332; x=1762186132;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KgRMpIuzEklhMyLqeSgTqelB6K/jP1FY8xNuF/F7waE=;
        b=SttCqdka91lbnHkFcnTnIs9rmtg4hhrx0LA5RKdegJTKtxHw02SDqu4thpX0z0Hhyb
         FN5rXnj79J82WQI4HOpZgqLcvZTPsvsX3AmPnbxqTaXaiIarL58ewzqNxRObnLf7TwaH
         HyvmUxdIqvZCzap7uAXD7lKmkmdCM4u4pobDSPBG5sJNs0dbwGVJHkcOIH9TxY3uT4sW
         YNTIYG3wJUs8DXYgF/Vpj+4BFFqwqpDp4VNze56KB4nGyRQHvj1dvZbW78zDQBotanY/
         rX2xmtVIrkFvSNeRnCxq9wPzgKCxzB6QXPk/9t0OYVD6Nfxv2HRV9R5356miFtInfNDf
         Z7ig==
X-Forwarded-Encrypted: i=1; AJvYcCULzsmDRBZbu1de5TPkZ7GGFFy8nfIbmKk/Qlf8Sv25VpQeo8ZymrjJQ28gS7hmN8N43gEERm2I/NhLg7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvpYibhtL2DPdOylDAsQi1+kmUCzRGeS7M/a2x6pL+CNzuP+hS
	mrtzy03GXBA18//3rfod+yZZgby/iuMGw8RIA5BAUFCGVJzUwDjw8/g3bSF/k/HvhG3WDChM4vQ
	w9zen2VrntKn532t1Xo1HNZX8FjoBtEXQ3upbadfOrlvTGohB412cPMYPAWOgvGWt15w=
X-Gm-Gg: ASbGncvUbaTn32CHzAfyLG/ed2nVKK8/Jgb43/sn7F3QQCNr6wSINCJy3yojZHuggsC
	GHpIPPyCOg3X17p359srSLXigNb9i3s2iINCm2nmxMukUAYdvmc+/fTPBM2Ueff9pUiSxXEG1uJ
	pJUatFqtGPoR2NCVXu8DinO5i90l5Y0bN+CHcXN9HdQoA+Tl4mFArODyZkBvQgaE0y1fi6UYfwF
	gYDRcMoldovOt0OCrH19jTRon6uP81SW1P3uZHm4Bkto2sKT5vYygZwdhJRJSY7voJPSwKdu8mC
	yPVhNkr0AokDlBmpCGLdqdF57VGp/r0LAYOkj++gXsuKXVqg/Hd0mIePgLpHPr8e6W9fXfVdD3x
	LS4ge/uuK5Sm9ykI/d0kPjJHbUCQaMMgf5kbgU/WDSJpZI/G9u+q7mwA3SZU=
X-Received: by 2002:a05:6a00:b42:b0:7a2:8201:e35a with SMTP id d2e1a72fcca58-7a441c377b7mr521887b3a.19.1761581332076;
        Mon, 27 Oct 2025 09:08:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7riuKLotC98dQqIszw6mdR718UOVWaI+4GmJRuMzQgpAmf75t39TRUDzdW3vneRdu0UeB2Q==
X-Received: by 2002:a05:6a00:b42:b0:7a2:8201:e35a with SMTP id d2e1a72fcca58-7a441c377b7mr521838b3a.19.1761581331421;
        Mon, 27 Oct 2025 09:08:51 -0700 (PDT)
Received: from [10.227.110.203] (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049c01sm8540758b3a.37.2025.10.27.09.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:08:50 -0700 (PDT)
Message-ID: <b002e4e7-fb35-4c2b-8414-b26aa7f71f25@oss.qualcomm.com>
Date: Mon, 27 Oct 2025 09:08:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/21] Docs: add Functions parameters order section
To: Jani Nikula <jani.nikula@intel.com>,
        "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>, Lee Jones <lee@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20251025162858.305236-1-yury.norov@gmail.com>
 <20251025163305.306787-14-yury.norov@gmail.com>
 <723c936f92352352c3b1a84b858d684f5b7a0834@intel.com>
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <723c936f92352352c3b1a84b858d684f5b7a0834@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=L40QguT8 c=1 sm=1 tr=0 ts=68ff9915 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=9sl_EADGoQNm_DCWk-wA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: kwcL3b5BoBcSaqLWZuMOlBeqj7AuxeTL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDE1MCBTYWx0ZWRfX0yu0gQxYsFod
 II6t/5X8zPbpcdJ5Jtd6neal2jqG0Q6oQXwbCATSqJWpTasCgLBMQTuqzKLAwSKxrpuztrStMCk
 jAIjla1Njh0atuHlChMVsWu/LH1rLymFAePMS18tpMov0arGC/2tTtYHJozJBc6Mbz0dlzhX1kX
 efshLihCks5n8fJw3N8fjgcAQnacb7FxwznuOkHwsemhWJcRUhxm7yI3MD/30FocUMysQ6WBJu9
 ZBXhaOMUNauRJWBV7rOjMSFiBcgykQOqabiVcg4E8YuNwQYzDiWJeXrL4ELiT8fMQ5UrPdIRJNQ
 d2obMU4eUoeb3x5lpciQIYKHBrR7aymzoA6uGqaYm52UulspodjdfUJEQzRy4eKkyQlaxI7fodF
 bf0A7XnvnDLTrRVyD1riyq4GAbrCFw==
X-Proofpoint-ORIG-GUID: kwcL3b5BoBcSaqLWZuMOlBeqj7AuxeTL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_06,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270150

On 10/27/2025 2:02 AM, Jani Nikula wrote:
> On Sat, 25 Oct 2025, "Yury Norov (NVIDIA)" <yury.norov@gmail.com> wrote:
>> Standardize parameters ordering in some typical cases to minimize
>> confusion.
>>
>> Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
>> ---
>>  Documentation/process/coding-style.rst | 48 ++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>
>> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
>> index d1a8e5465ed9..dde24148305c 100644
>> --- a/Documentation/process/coding-style.rst
>> +++ b/Documentation/process/coding-style.rst
>> @@ -523,6 +523,54 @@ below, compared to the **declaration** example above)::
>>  	...
>>   }
>>  
>> +6.2) Function parameters order
>> +------------------------------
>> +
>> +The order of parameters is important both for code generation and readability.
>> +Passing parameters in an unusual order is a common source of bugs. Listing
>> +them in standard widely adopted order helps to avoid confusion.
>> +
>> +Many ABIs put first function parameter and return value in R0. If your
>> +function returns one of its parameters, passing it at the very beginning
>> +would lead to a better code generation. For example::
>> +
>> +        void *memset64(uint64_t *s, uint64_t v, size_t count);
>> +        void *memcpy(void *dest, const void *src, size_t count);
>> +
>> +If your function doesn't propagate a parameter, but has a meaning of copying
>> +and/or processing data, the best practice is following the traditional order:
>> +destination, source, options, flags.
>> +
>> +for_each()-like iterators should take an enumerator the first. For example::
>> +
>> +        for_each_set_bit(bit, mask, nbits);
>> +                do_something(bit);
>> +
>> +        list_for_each_entry(pos, head, member);
>> +                do_something(pos);
>> +
>> +If function operates on a range or ranges of data, corresponding parameters
>> +may be described as ``start - end`` or ``start - size`` pairs. In both cases,
>> +the parameters should follow each other. For example::
>> +
>> +        int
>> +        check_range(unsigned long vstart, unsigned long vend,
>> +                    unsigned long kstart, unsigned long kend);
>> +
>> +        static inline void flush_icache_range(unsigned long start, unsigned long end);
>> +
>> +        static inline void flush_icache_user_page(struct vm_area_struct *vma,
>> +                                            struct page *page,
>> +                                            unsigned long addr, int len);
>> +
>> +Both ``start`` and ``end`` of the interval are inclusive.
>> +
>> +Describing intervals in order ``end - start`` is unfavorable. One notable
>> +example is the ``GENMASK(high, low)`` macro. While such a notation is popular
>> +in hardware context, particularly to describe registers structure, in context
>> +of software development it looks counter intuitive and confusing. Please switch
>> +to an equivalent ``BITS(low, high)`` version.
>> +
> 
> GENMASK when used for defining hardware registers is completely fine,
> and *much* easier to deal with when you cross check against the specs
> that almost invariably define high:low.

Not only that, there is no common definition of BITS

Defined in 7 files as a macro:
arch/arc/include/asm/disasm.h, line 32 (as a macro)
drivers/mfd/db8500-prcmu-regs.h, line 15 (as a macro)
drivers/net/wireless/intel/iwlwifi/fw/api/coex.h, line 14 (as a macro)
fs/select.c, line 415 (as a macro)
lib/zlib_inflate/inflate.c, line 232 (as a macro)
sound/core/oss/rate.c, line 28 (as a macro)
tools/perf/dlfilters/dlfilter-show-cycles.c, line 22 (as a macro)

Most of these do NOT have a (low, high) signature.

And GENMASK will throw a compile error if you swap the high and low:
#define GENMASK_INPUT_CHECK(h, l) BUILD_BUG_ON_ZERO(const_true((l) > (h)))

IMO the real confusion with GENMASK(), which would be the same with the
proposed BITS(), is that without knowledge of the implementation, when looking
at an instance of usage you can't tell if the parameters are two bit numbers
or a start bit and number of bits.

/jeff

