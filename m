Return-Path: <linux-kernel+bounces-738987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A79EB0C019
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:22:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26CAA18C1011
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 09:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F09C28B507;
	Mon, 21 Jul 2025 09:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f0+bl1hs"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CB9288C97
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753089706; cv=none; b=iKbifULrfhtAkGtfXbsioC8De20Us4myx3Bd0MWe+aBOjkH1ua4GwPp9Gv581iJ/SbxkRGImT3hy44rkPK1HGofPvLtBeV/pDBZn2TelANg8q3nibvjAcD/biLEV+IUYXPelhAaZ1PmfSkPibu8usVwOjlMQZKr52TiU69HkS2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753089706; c=relaxed/simple;
	bh=RhP7CgPJWuXWazu2ieMATKdgzpZnkmY0/qua2/d0FmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tMTq5ktnQcrdfT55bPHu6gExnnPGGFBjc4km6HWAVyE+Lo+uK+UGJli5rnWAzu+MhBCIJhtDwggUbyVNEXPwo0C51z7XW1pP98WQMSyaRP10eB26LvLBm/CDs+b692P4o7h0HAYPliUP/RZkcFRQM1v2NYh8Xi71G5OFEQO2ovE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f0+bl1hs; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae0dd7ac1f5so734704366b.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 02:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1753089702; x=1753694502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L1Th2tPSSojsnumFzHAfZ9R36o8NbqGCC5Gi+YtQXlo=;
        b=f0+bl1hsJJWvqnPF1ytmuN7TtU3Z4K80XTr2D1JKCME6D26yJTVnv1dIhrtMm5ooGc
         Gl8dyEXsVhQ+Fr7UvtE9iNZtCSTDyI9+N+OQT6wkU8C09KJ1tmToMsbki+4RxzCRBgKB
         WuLf5V/3+RPaj5RcveJxbTI/CoJA6SE5vzwNzrOf71wdNdeZpxxv4eInH22cIv1Puqgr
         By+ooVdVMqCDdmyOAudpoU66L7ED7tXJTJn15nENleo4fWULTSgRBFrCClOgAMR+9dwb
         pbCDjkKBANjQVFM0WBEdI449pdcddcobZK0oKviiITK3cs/jz4S3doGdH/TZ/BIbZq/g
         VpGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753089702; x=1753694502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1Th2tPSSojsnumFzHAfZ9R36o8NbqGCC5Gi+YtQXlo=;
        b=wYRtQVBMpVN0kwyM0BPlU0adD1hHJz1u492uHQQfmppjWJ0nfMZT1PovsqG5+r7IgC
         1xVUdRKDmOY2Ax0s/ZeykHCPUUN71VCMhc6oSwSJ4l6CanEGlGlIcfmkJhfKTWL0Jlln
         6vxW4tWTk6H7BusGvqfx05F/zTRDRzMkqJb6pzMcMwllyfx4LwnErPf3A0vZM7HWc65H
         tikPhJlPSaazTrs42pAEINNj1CXqlKaMI5TTi5pk86trKw/KlnjDrdl/2tfuWcVzJWGl
         2Zsy+tS+HaCzTvdCeJt1OOvD+juzB7++RIIBFPQjeh/VC5YHbLH4Xfq/+ivJi3AtP0Ip
         nFIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXX3UzeobxbLBJVn7WZnUscq5/OL4/vJqG7XT58mVWLtSI5/X+u95FgOVqNMTEZYaOx+lfzSEIR9QQkzNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnwLmjFKOczJbmV5FcR1aaM4aNkuZN+6a/5zuc0/M3zpMd3RH0
	C076O9WPdIO/QbijB2AOPFu5sDK+GIZgeC5D6on5mGJWep9AyPPchRamm+BiD9viXWc=
X-Gm-Gg: ASbGncvrJFonZ7LLbzLORDNBelxr4ps364wkROT4XJUL+rXaBSnAalt7H2oA49UXkwJ
	67KXH8B17I8MlJrqE+4O5rRKJ1zpcnRzgkqVwxX5lrcIHJPkNwkCtWjKuB5IYna5Vi0LQNVWLZw
	U5XB3HLYHBmzH2ouB/ecAZRtboC8OdGh0QhG3Wn2Fd73Hsq/mHPZbkte3e75J6Oq6B8mSnkwH49
	hGs0/T/HDDOrK5PxaT4zIBMeHwcZ1PzebwPLp7MTu3l6Ad5HeA0lzlKPukVF9QOl56WfSkgo8aA
	+c3joSqzr/nGWjMMH6Lm4rg2ljlRYXN0bBxgHw2PGc+EO6W6HqnrAsmYNCpYtvmNV6TytimG/Yb
	3Yubk6xNUhP/llX5dYFN3VDPFzknqnDNw8YoiAHuBHVQ=
X-Google-Smtp-Source: AGHT+IGWlQPKjmMAkrs6jYpIEeaJ7EPZSlgjxs7E2ZjdUx6LDd8jWSkVV7Ei3B5/ualnx6LC3e/mUw==
X-Received: by 2002:a17:906:c114:b0:ae3:e378:159e with SMTP id a640c23a62f3a-aec6a528140mr1159108566b.26.1753089702031;
        Mon, 21 Jul 2025 02:21:42 -0700 (PDT)
Received: from [10.100.51.209] (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca7e0b1sm641619466b.117.2025.07.21.02.21.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 02:21:41 -0700 (PDT)
Message-ID: <264b23ee-7046-4be9-8e01-d79a517e6256@suse.com>
Date: Mon, 21 Jul 2025 11:21:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] module: Restore the moduleparam prefix length check
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez
 <da.gomez@samsung.com>, linux-modules@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250630143535.267745-1-petr.pavlu@suse.com>
 <20250630143535.267745-4-petr.pavlu@suse.com>
 <15f52f4c-7809-46ab-9e13-bd487f35a80c@kernel.org>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <15f52f4c-7809-46ab-9e13-bd487f35a80c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/17/25 9:23 PM, Daniel Gomez wrote:
> On 30/06/2025 16.32, Petr Pavlu wrote:
>> The moduleparam code allows modules to provide their own definition of
>> MODULE_PARAM_PREFIX, instead of using the default KBUILD_MODNAME ".".
>>
>> Commit 730b69d22525 ("module: check kernel param length at compile time,
>> not runtime") added a check to ensure the prefix doesn't exceed
>> MODULE_NAME_LEN, as this is what param_sysfs_builtin() expects.
>>
>> Later, commit 58f86cc89c33 ("VERIFY_OCTAL_PERMISSIONS: stricter checking
>> for sysfs perms.") removed this check, but there is no indication this was
>> intentional.
>>
>> Since the check is still useful for param_sysfs_builtin() to function
>> properly, reintroduce it in __module_param_call(), but in a modernized form
>> using static_assert().
>>
>> While here, clean up the __module_param_call() comments. In particular,
>> remove the comment "Default value instead of permissions?", which comes
>> from commit 9774a1f54f17 ("[PATCH] Compile-time check re world-writeable
>> module params"). This comment was related to the test variable
>> __param_perm_check_##name, which was removed in the previously mentioned
>> commit 58f86cc89c33.
>>
>> Fixes: 58f86cc89c33 ("VERIFY_OCTAL_PERMISSIONS: stricter checking for sysfs perms.")
>> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
>> ---
>>  include/linux/moduleparam.h | 5 ++---
>>  1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
>> index bfb85fd13e1f..110e9d09de24 100644
>> --- a/include/linux/moduleparam.h
>> +++ b/include/linux/moduleparam.h
>> @@ -282,10 +282,9 @@ struct kparam_array
>>  #define __moduleparam_const const
>>  #endif
>>  
>> -/* This is the fundamental function for registering boot/module
>> -   parameters. */
>> +/* This is the fundamental function for registering boot/module parameters. */
>>  #define __module_param_call(prefix, name, ops, arg, perm, level, flags)	\
>> -	/* Default value instead of permissions? */			\
>> +	static_assert(sizeof(""prefix) - 1 <= MAX_PARAM_PREFIX_LEN);	\
> 
> Can you clarify if -1 to remove the dot from prefix?
> 
> Final code 
> 	static_assert(sizeof(""prefix) - 1 <= __MODULE_NAME_LEN);	\
> 
> with __MODULE_NAME_LEN being:
> 
> #define __MODULE_NAME_LEN (64 - sizeof(unsigned long))

Correct, -1 is to account for the dot at the end of the prefix.

I actually also wanted to assert that the prefix ends with a dot, but
unfortunately prefix[sizeof(prefix)-2] (with prefix being a string
literal) is not a constant expression in C.

-- 
Thanks,
Petr

