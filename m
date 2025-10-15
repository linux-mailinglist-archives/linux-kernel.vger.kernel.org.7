Return-Path: <linux-kernel+bounces-855191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 02001BE07E3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 21:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4D90503F99
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 19:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D16306D40;
	Wed, 15 Oct 2025 19:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nHQPBky1"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD6E3074B2
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760557220; cv=none; b=MTVysgvNbE4MQamBhpVsk38CfU0b6+Mzo484hhptGx0UxkytvWPBPH6TU8Y/9Rd0b19P5YvYxlr5EvWHwFeo5BPo7qDQJofqsBc4o13adjKF6t4uTNaTGbs0UVebfFp0GWAg00Vsdny3XgBiGScWtWmq+thhB9LU4fUqpTsO01c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760557220; c=relaxed/simple;
	bh=bzqLL6LV4LnMHW1geHAKoiyaDMPMaVwQi72OHHT1iMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dicdr4FuGvLQW2jARjIMus1fL5gQX2fBcsFL5Jsq4yxwcwJgaNPZn4Na06XX5CSEbqCvGFApIBfIAGs7eC00PsYtRRWoBoy9fmpTSfDfK5k4PD3A1CtZ/okDAPDGMIitjU3KhAyiep14M7DjPEwRfMQFvBrprLI0vsFFlIyJ8dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nHQPBky1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so39192b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 12:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760557216; x=1761162016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2B7iTsVB7GEx2Of+aKeJEBybsUXUvHeB6wQfPC3f1gY=;
        b=nHQPBky1Yz+RIDAX2XMFbzmosQhYoJF1KLpUZZTvavEfiYE44iLxV/RCPCXYl4lQca
         HBQ6D33nNCR3BHo5YkqQ8LdTMHC23hWxJtDLbM9jPUyC1STmugpgF7TgwGrMDOBzeVEG
         A4sJUt0gbnNnU1gBaeCYjB35vbQ9Ni4ZUX3bUrBZ3SyO19mAK/PP+YX5axhhlm2fldSE
         NjV6aCayRZGNt1byzAKtLz4G84PAKOJk/J5F9Kh5TuT9WNBztVVAeEI3PUWDokiwAhUs
         aseNoTuNB+IX6DoIwxnd1MyWhlSm1FzxNVu/xpzkVqIXVxmxWXN5BM9fuhjP4HL5azUK
         ffYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760557216; x=1761162016;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2B7iTsVB7GEx2Of+aKeJEBybsUXUvHeB6wQfPC3f1gY=;
        b=fjKUXzKGQdcXDAjO0NRZzfKU4oXOjMKeB/1WPOwdXXRYbCQ3nCXFdO9E2BKj6hHxnG
         nopEYY39efVKfAdX0LIY9b1aSUaGuncuMm+P/SCWlNDKouI6GJTHD5actE/QU2OCj4Lt
         HFiMkJTCO7EFaCzc7FQ+S4OBEVTO5+JCNOWDHrYYZsvFJ+Nuw6k5g0WERMRzdljxZoCr
         IVeGgb+QwvardVpvdGM4d4770xBNiyrDUObiTdQTDnXCDlAQ3asrG74KTXBv6id7X21B
         ut7JYioPma+7TjyLHMsuXTaZuUOrYMcpOoKZQ37AnLr/lItOBL4IuwcsKQPxty1yzZaK
         QBXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/SuO09R2GYJo56M5yUUCcTwAfpvYfcfFCQ17GLfMpFTmouOhRhO0Ms7t7+eCKITjvglSsJx1ebqJcy34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGFd2cK5SYRsFBA3bdIRmARIJNu0H5LgZDD/pMjG1USQ7SJu1a
	qvgivHs8/AIb1L/da8sDUZCy+ZVLf1NEzTNzU1k029g4Mg8kqpfPZtWQ
X-Gm-Gg: ASbGncuCY3ap4XoFHBTK5cQVduLUsUoWKtbQCk5uzWzKquQ9HBUOOeyTlAWzVwLrZ52
	lgz8xTpmKliOskhg+rhTxEf3LFnRmYmxVBJDsDqn5Wy1TQYd6zjJkOvGhDAA6ywCf3x1vEPnr8P
	1nP/DXFS9RMJLFTyOtqiiIJMtxbH8YW/Uk4SkClY3mTqtdlHVr4KXI+d0H3sgue8FioyNjnYLvG
	2SotC1LyDqHEsv8lv6mBWsvsSxVgOBKVxydYlfeHGqTXVRuzCAnaqAn8CRC679KsclKV57MnqHv
	O3oJtI7HtCCZZ9vKuUgfeu2/N8iq5BQoHFTZsSQJKqphlsj311h1GraKDrWK9Bg6WweLY1bCstM
	wtcvhtGL4uedN8R6daoNkdADyyQ6bvfhQitg9FLIxJcN73PsCwSCrDvONnzk+JdB1q7x+wDdmB3
	y1Z3zdKDg/SWRFYKFC4WX+sV51
X-Google-Smtp-Source: AGHT+IEYVhSJeg88tn8s3G2SwhNE8qS9A78XmG3fg72FfPaBP2dMO5dNN93aY73KHz6WzzjaXrlxgw==
X-Received: by 2002:a05:6a00:9292:b0:781:2401:74f5 with SMTP id d2e1a72fcca58-79387e0501fmr37129738b3a.29.1760557216186;
        Wed, 15 Oct 2025 12:40:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d6aca6asm19715694b3a.70.2025.10.15.12.40.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Oct 2025 12:40:15 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e4515d96-f25b-4cf5-8dd8-f75c21b51bdc@roeck-us.net>
Date: Wed, 15 Oct 2025 12:40:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux 6.18-rc1
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Feng Chen <feng.chen@amlogic.com>, Matthew Wilcox <willy@infradead.org>,
 Jeff Layton <jlayton@kernel.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Tao Ren <rentao.bupt@gmail.com>, Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
References: <CAHk-=whPJTtX5u1m47fPUD2g2Dc=Did_6OqCVj6OQPKFgfKn9g@mail.gmail.com>
 <f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net>
 <c45a8502-3af2-4d5c-a660-2922b4e040bb@roeck-us.net>
 <68841c19-c54e-4837-80bf-d180f2c35499@roeck-us.net>
 <3exillpepa4jjxsjkp5vgn4347tsvt7q22m75tp3ncavkyzgl7@juvt3p4h53km>
 <81c865ca-a9d2-413e-b43d-eedd7e4e88a1@roeck-us.net>
 <b74ike3nxjmhjsfdwq4b3732sgyojdfy5mwt2hflkc7aaqalnf@iclsvge73ibh>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <b74ike3nxjmhjsfdwq4b3732sgyojdfy5mwt2hflkc7aaqalnf@iclsvge73ibh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/25 11:33, Liam R. Howlett wrote:
> * Guenter Roeck <linux@roeck-us.net> [251015 13:48]:
>> On 10/15/25 10:28, Liam R. Howlett wrote:
>>> + Cc Vlastimil, as you are indicating the slab merge.
>>>
>>>
>>> * Guenter Roeck <linux@roeck-us.net> [251015 06:02]:
>>>> On Mon, Oct 13, 2025 at 09:46:44PM -0700, Guenter Roeck wrote:
>>>>> On Mon, Oct 13, 2025 at 10:08:26AM -0700, Guenter Roeck wrote:
>>>>>> On Sun, Oct 12, 2025 at 02:04:32PM -0700, Linus Torvalds wrote:
>>>>>>> Two weeks have passed, and 6.18-rc1 has been tagged and pushed out.
>>>>>>>
>>>>>>> Things look fairly normal: size-wise this is pretty much right in the
>>>>>>> middle of the pack, and nothing particular stands out in the shortlog
>>>>>>> of merges this merge window appended below. About half the diff is
>>>>>>> drivers, with the res being all over: vfs and filesystems, arch
>>>>>>> updates (although much of that is actually devicetree stuff, so it's
>>>>>>> arguably more driver-related), tooling, rust support etc etc.
>>>>>>>
>>>>>>> This was one of the good merge windows where I didn't end up having to
>>>>>>> bisect any particular problem on nay of the machines I was testing.
>>>>>>> Let's hope that success mostly translates to the bigger picture too.
>>>>>>>
>>>>>>
>>>>>> Test results don't look that good, unfortunately.:
>>>>>>
>>>>> ...
>>>>>> Qemu test results:
>>>>>> 	total: 609 pass: 581 fail: 28
>>>>>> Failed tests:
>>>> ...
>>>>>> 	sheb:rts7751r2dplus_defconfig:initrd
>>>>>> 	sheb:rts7751r2dplus_defconfig:ata:ext2
>>>>>> 	sheb:rts7751r2dplus_defconfig:usb:ext2
>>>>>> Unit test results:
>>>>>> 	pass: 655208 fail: 0
>>>>>>
>>>>>
>>>>
>>>> Update on the sheb (SH4 big endian) failures below.
>>>
>>> What is the qemu line you use and the memory configuration of that qemu,
>>> or is this real hardware?
>>>
>> qemu. I tried 6.2.0, 10.0.5, and 10.1.1. Sample command line:
>>
>> qemu-system-sh4eb -M r2d -kernel arch/sh/boot/zImage \
>> 	-append "console=ttySC1,115200 noiotrap" \
>> 	-serial null -serial stdio -monitor null -nographic -no-reboot
>>
>> initrd or root file system doesn't really matter because qemu exits
>> almost immediately.
>>
>>> Are there sh4 configs that pass?
>>>
>>
>> little endian - all
>> big endian - none
> 
> Do other big endian targets work?
> 
The ones I am testing, yes.

>>
>>> It's a bit odd it says "fail: 0" here, Is this message about something
>>> else?
>>
>> This are unit (KUNIT) test results. All 655208 executed unit tests passed.
>> Unit tests not executed because the image crashed or because qemu died are not
>> counted as failed.
> 
> Thanks.
> 
> ...
> 
>>
>> I checked out a test branch at 24d9e8b3c9c, rebased it on top of
>> 24d9e8b3c9c8a6~1 (07fdad3a93756b8), and ran another bisect. Results:
>>
>> # bad: [c5e19dc4c1db098456ee6a924e276a26e692f26c] slab: Introduce kmalloc_nolock() and kfree_nolock().
>> # good: [07fdad3a93756b872da7b53647715c48d0f4a2d0] Merge tag 'net-next-6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next
>> git bisect start 'HEAD' '07fdad3a93756b872da7b53647715c48d0f4a2d0'
>> # good: [10f17a5a3befa328bd9a78ca6b799dd1933f108b] maple_tree: remove redundant __GFP_NOWARN
>> git bisect good 10f17a5a3befa328bd9a78ca6b799dd1933f108b
>> # good: [f97515baad5efa6e1963abd37188fad42515edc8] maple_tree: Replace mt_free_one() with kfree()
>> git bisect good f97515baad5efa6e1963abd37188fad42515edc8
>> # bad: [4df642aa2128c2c346f9c945bddbae37c59bba82] locking/local_lock: Introduce local_lock_is_locked().
>> git bisect bad 4df642aa2128c2c346f9c945bddbae37c59bba82
>> # good: [a20be9b8014abfe68acc2efd81bfb5d2dd4eaf34] maple_tree: Prefilled sheaf conversion and testing
>> git bisect good a20be9b8014abfe68acc2efd81bfb5d2dd4eaf34
>> # bad: [40696586bc008ad34db8135c35ec4b459691af3c] maple_tree: Convert forking to use the sheaf interface
>> git bisect bad 40696586bc008ad34db8135c35ec4b459691af3c
>> # good: [8387347ae261c5e74e9db3f73b91d47f11f8d6f8] maple_tree: Add single node allocation support to maple state
>> git bisect good 8387347ae261c5e74e9db3f73b91d47f11f8d6f8
>> # first bad commit: [40696586bc008ad34db8135c35ec4b459691af3c] maple_tree: Convert forking to use the sheaf interface
>>
>> Reverting just 40696586bc008 in that branch didn't help. So I reverted "slab: Introduce
>> kmalloc_nolock() and kfree_nolock()" in that branch as well, and the image started
>> passing.
> 
> This does not make sense to me.  The first bad commit being reverted and
> it does not work means that it's not to do with that patch..?
> 
> I'm not saying this patch is fine, but surely it indicates a previous
> problem and potentially (most likely?) an intermittent failure?
> 
> Is the failure consistently reproduced?
> 
Yes.

> 
>> In mainline, 719a42e563bb ("maple_tree: Convert forking to use the sheaf interface")
>> can be reverted, but trying to revert af92793e52c3 results in:
>> CONFLICT (content): Merge conflict in mm/slub.c
> 
> Forking shouldn't be running so early that the console output is
> affected, so I'm not sure how this change would cause what you are
> describing.
> 

I did some more digging and found that the following reverts on top of mainline
are clean.

d0e0bf7519b7 (HEAD -> master) Revert "maple_tree: Convert forking to use the sheaf interface"
9807b6d44849 Revert "slab: Introduce kmalloc_nolock() and kfree_nolock()."
036271875f62 Revert "slab: Fix using this_cpu_ptr() in preemptible context"

But that doesn't fix the problem. I then switched the gcc version from 14.3 to 13.4.
And everything starts working, even without reverts.

So, you are correct. This is not a code problem. It maybe something like crossing
a page boundary which isn't handled correctly by qemu; we had this before.

Sorry for the noise :-(.

Guenter


