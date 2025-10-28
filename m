Return-Path: <linux-kernel+bounces-872929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 274DFC12A46
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 03:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505AA1A636D3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 02:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1611D2F42;
	Tue, 28 Oct 2025 02:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="l9Asc189"
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AFD13D8B1
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 02:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761617661; cv=none; b=h+gJQMtfu6Gss3pWsjlY5tWJUVPA1Lq3wbRAKmEePBMcfsvDd4pUaH275lkPcFIe1N/jGn5IsFlqycqP/zNwnsxr3d2SzuaglAuPkE2FDYaFN19vvJc56p/RBL5Z91JQY4sceTjf9b7JGLBunvZFJdBYvUJk8Cf8OME/A7T4L68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761617661; c=relaxed/simple;
	bh=/PaFBHy64rGgMWUqpYePTksCWVabf6Q+9Js0kI2d4iE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E3BOnlSP2SGThnzBJSdFgr8WfV8QCSpc0NB5yJohlhSkvJMsgnuuCk/yCaBgnTNsrtXuvLkG6DBA+KQHP0mPpIyPTRWrcnCroB8ye2sUJGER+lcspIrNtV9KKqfRpjD2pZn4/5voJKb1AlFZpvRUac9C1FpYMK6UcfWW0oL3bFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=l9Asc189; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1761617614;
	bh=VlK3t/Xv5LLzjE0dV2jWA+/0FZqLNmRlJr1ryxluhxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=l9Asc189MsUIXp3YcocZgX0MJUNFhVSjcAmrnULyelgwlqPyauzdbLxfwRw1iUIIi
	 7QLu8lp+oJwytjidsrFn0T6bEgEdSBfh1aUInPSLZJNytuXQ2467U0yNmJbP3nFXYq
	 yXKTCTWvu5P5FV5w8OstKMKICtaHS64Z+Oh3agCc=
X-QQ-mid: zesmtpgz3t1761617612t81c82363
X-QQ-Originating-IP: yLxr9FRtgkzgVlTzQxP8lK0+u8/dw0HzEMeRuqlfjhY=
Received: from [198.18.0.1] ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Oct 2025 10:13:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 17129082983056919779
Message-ID: <2F51425F3E6D2182+7c76e5f7-bb24-4d39-aa00-33e486ff4cd9@uniontech.com>
Date: Tue, 28 Oct 2025 10:13:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: drivers/hwmon/gpd-fan.c:231:9: error: implicit declaration of
 function 'outb'
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
References: <202510240817.vt3eQ3qL-lkp@intel.com>
 <265B8FE9306198E5+0131c750-3995-4158-84e7-ad73792e6934@uniontech.com>
 <CAMuHMdUeE3xQKkyLWDxoaA_E=cukZSz6UvvjJF0vsbRtt0fVgw@mail.gmail.com>
Content-Language: en-US
From: Cryolitia PukNgae <cryolitia@uniontech.com>
In-Reply-To: <CAMuHMdUeE3xQKkyLWDxoaA_E=cukZSz6UvvjJF0vsbRtt0fVgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NlWvLSkfVnGcWADTzbisGq6LfrQdYuhnI3Da359ZRVDa/pqlyUJY2vsR
	L95ATwmckqwMNe+SnuYG2B20g+BK/9C4m7aYI2zjW9ceQ0TGwcgHhfB4patGV2ATG050ssM
	SiPrLsl1f6Yu2MpW8RKUv/K1L/kPIAEL16melHa2p4nG0PlVq+cWdXialIk5lcfs69UMkjh
	fN78WIWFwCgIFjtjMbrvQXldeiugp99KVAKdcpQ8dYoBQhs/bt2G5q5UeQd34qAGpw9dpia
	2dgqLKzpBPPgPie9zPS4RjwPspHUMHUCrSZW2jWMsQffDtYWgYosUBZ7bdXR1QaMu307UEu
	jQpHGsFuKCEfZZhJGhK6aD2URNV9uPx/WwMHUQAOJYkw5B8tVmKs7TAIAycHp7PFbrJegWS
	wBP+eNmqy0U+UOHKg/ZwvJvqLgXxStf2jatiiEfik3VvbT+dZLlKMSQ7TuazYKmKJzFCKM1
	JqJ0vSSQxWLsE4U50kwXNZyNoNEbMbc0vnDtNGZLKAXYkh50CPtCwGGcDO8HEa7trLCrCF8
	D2q/cGTeTe+ImqkhyVnNm13/DfI2j3NdcWnwPoGRIaJ3Dopv2lo4RB06VQLUyODvTYdx5Ni
	jrLs/Uc60V1V0K2fS5If3gyI8R/lsI2DXL1veoPlAe0AwBQEgsodqjfwYyl8wQ7SVWe9KVS
	mgpIqbwdzm25/FsPbMdHizjqLAKFc+dxWkiY077FwC7zzjO86fGXm9Ou4zAWdt4hMqWh0JE
	H5wOjhrmteo7FgsYBuOKLwHRPDocltLvxlO8HU4ztnJFOdEtMvzKc35ri9+c2sKOS0tr0wL
	kd4Keybc2Ny0CeIj10tzK2hhnw2WqXX7l9LPVrs7h0WUfVGuOS+Ld7TsR1JiC9mgrVVRPEd
	xchNC9TrfMUrwjDL94RAyOfRtVZOExcRlYEZ/o6oPh5PWiTvzWpwfX+cTrd649Gyo2FtEYk
	udwu335jwoHRE+SsYXHijg4TJ3qW2+OKjZH4Z+SXf+EsTqSGSQ6HGFGzoTqZ7v3pbS+iD2w
	cKmM2Pm4vvj/0fzN67q/ZAurfBByVZmpTuUS5HwQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

> Hi Cryolitia,
> 
> On Sat, 25 Oct 2025 at 15:49, Cryolitia PukNgae <cryolitia@uniontech.com> wrote:
>>> FYI, the error/warning still remains.
>>>
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   266ee584e55eed108583ab4f45b5de734522502d
>>> commit: 0ab88e2394392f475b8857ac82c0c987841217f8 hwmon: add GPD devices sensor driver
>>> date:   6 weeks ago
>>> config: i386-buildonly-randconfig-002-20251024 (https://download.01.org/0day-ci/archive/20251024/202510240817.vt3eQ3qL-lkp@intel.com/config)
>>> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
>>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251024/202510240817.vt3eQ3qL-lkp@intel.com/reproduce)
>>>
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202510240817.vt3eQ3qL-lkp@intel.com/
>>>
>>> All errors (new ones prefixed by >>):
>>>
>>>    drivers/hwmon/gpd-fan.c: In function 'gpd_ecram_read':
>>>>> drivers/hwmon/gpd-fan.c:231:9: error: implicit declaration of function 'outb' [-Wimplicit-function-declaration]
>>>      231 |         outb(0x2E, addr_port);
>>>          |         ^~~~
>>>>> drivers/hwmon/gpd-fan.c:244:16: error: implicit declaration of function 'inb' [-Wimplicit-function-declaration]
>>>      244 |         *val = inb(data_port);
>>>          |                ^~~
>>>
>>
>> I don't understand...... I have already added CONFIG_HAS_IOPORT to depends. If this is not enough, what else should I do?
> 
> Missing #include <linux/io.h>?
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 

It has been fixed[1] a little earlier, thanks for your help

1. https://lore.kernel.org/all/20251024202042.752160-1-krishnagopi487@gmail.com/

Greetings,
Cryolitia


