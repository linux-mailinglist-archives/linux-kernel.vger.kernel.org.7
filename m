Return-Path: <linux-kernel+bounces-808820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BA0B5051D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA74F1C24009
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A80C32CF83;
	Tue,  9 Sep 2025 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y7F9GJIh"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36BA274B29;
	Tue,  9 Sep 2025 18:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757442034; cv=none; b=nb6W5yeq51JhbePXqoRBI5HHLsmjg4J7w//XMj0fUKUbClgr5VJ1kmTqNI6dd9BzXDMmlYcamFItCN0wjYQ8twcYHaolhwtYBC3AxUNVQegyr9Lh+pfHddXwIK2qB898utqN2XJvKJQhxZm/o1aGwQxLxqNY7GCvu0NkOU3ReiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757442034; c=relaxed/simple;
	bh=EEYG45gijjRGvOSYGpqLG6Y9Zbs6PwkA46bjC2TTvuo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gSqmsfDWMWDGrsJXGjYijcUFLozqhLAS/Bv0eY8IHC+2nhPiqygO/Hhnz+Wcy3d/7sbdKi/0edW5ZtkJ8/R2wrYMRybdSUsHSKjpoXjkJLjFQIx1HetyU5TCOSSNw0cbd76KjB5V6YLn3JpxXWKwHleXbw9ovYwgoXNOG9BBmwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y7F9GJIh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=CD7GEp9XI03L1lNv52VF1EIcwO0JLIbCqydOPPEhf9k=; b=Y7F9GJIhyXfr9NbD5SzFet2iKG
	4hj+xQPYl7m8E+BCjwet0LE5Sg8QvU4k/i2dznNU6AA9hqrWx7FHXqJbt6oCd0+y4/JKxQGA8e4y8
	S/MJzB3YoN75T0ElCbE0tLR0Q4q2DBy7ITDUOrRPtrf9zSCiWlws4tH8NfUicb1u1W5ip0bZTrXEg
	HEJ2Guu5oa2wtiJt/MmOreBOrqmPLz2NM8cZEbmFt1ZbwE8YHHCWHM1RI8i5fsxw5tsd6l6s/uhMr
	vOUQcCGfCelx8OzttsujJtxWPFXTI9IbAn9MoDFDFbfWtIKkPylr8osjI8fG3/c1GKmj2lmQwWQ55
	9tQlU7hw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uw2xD-00000009NiV-2X6E;
	Tue, 09 Sep 2025 18:20:31 +0000
Message-ID: <d73e68e9-321e-4685-b4fe-633cd282f526@infradead.org>
Date: Tue, 9 Sep 2025 11:20:31 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] kernel-doc: add support for handling global variables
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
References: <80f85eacc306e62de8c9c68712c653ba290c2ff2.1757262141.git.mchehab+huawei@kernel.org>
 <d85e3f24-dbcd-4f28-b31f-a77661fc66fb@infradead.org>
 <c26160b1-f1fb-41d3-a8fe-acf589ad9f7f@infradead.org>
 <aelqggrynl7acn54tqm5ntqsynghprqtzmbkhvgf7khlbmmq6v@tf4gdfh2fvla>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aelqggrynl7acn54tqm5ntqsynghprqtzmbkhvgf7khlbmmq6v@tf4gdfh2fvla>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/9/25 9:18 AM, Mauro Carvalho Chehab wrote:
> On Tue, Sep 09, 2025 at 08:57:07AM -0700, Randy Dunlap wrote:
>> Hi Mauro,
>>
>> On 9/9/25 12:27 AM, Randy Dunlap wrote:
>>> Hi Mauro,
>>>
>>> I have a few patch nits below, then some testing info.
>>>
>>>
>>> On 9/7/25 9:22 AM, Mauro Carvalho Chehab wrote:
>>>> Specially on kAPI, sometimes it is desirable to be able to
>>>> describe global variables that are part of kAPI.
>>>>
>>>> Documenting vars with Sphinx is simple, as we don't need
>>>> to parse a data struct. All we need is the variable
>>>> declaration and use natice C domain ::c:var: to format it
>>>> for us.
>>>>
>>>> Add support for it.
>>>>
>>>> Link: https://lore.kernel.org/linux-doc/491c3022-cef8-4860-a945-c9c4a3b63c09@infradead.org/T/#m947c25d95cb1d96a394410ab1131dc8e9e5013f1
>>>> Suggested-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>>>> ---
>>>>  scripts/lib/kdoc/kdoc_output.py | 31 +++++++++++++++++++++++++++++++
>>>>  scripts/lib/kdoc/kdoc_parser.py | 25 ++++++++++++++++++++++++-
>>>>  2 files changed, 55 insertions(+), 1 deletion(-)
>>>>
>>
>>
>>> So, I grabbed some global data from 6-8 places in the kernel and put them intoinit/kdoc-globals-test.c. Then I modified Documentation/core-api/kernel-api.rst
>>> like this at the end of that file:
>>>
>>> +
>>> +Kernel Globals
>>> +==========================
>>> +
>>> +.. kernel-doc:: init/kdoc-globals-test.c
>>> +   :identifiers:
>>>
>>> The html output says
>>> "Kernel Globals"
>>> but nothing else.
>>>
>>> My test files are attached. I dumbed down (simplified) a few
>>> of the globals from fancy types to just unsigned long, but that
>>> didn't help the output results any.
>>>
>>> What's happening?
>>> Thanks.
>>>
>>
>> My problems here could be from a patch mis-merge.
>> Maybe your patch was against a tree or previous patches that I don't have.
>>
>> You could supply an updated patch or I can just wait until all
>> the patches are synchronized for further testing.
>> Or you could just take my sample and keep testing it.
> 
> I applied it after my sphinx-build-wrapper patch series,
> but it doesn't touch kernel-doc. I did a rebase just to make
> sure, on the top of docs-next branch from Jon's tree, e.g. 
> on the top of:
> 
>     git://git.lwn.net/linux.git docs-next
> 
> e.g. applying it after:
> 
>     7e5a0fe4e8ae ("doc: filesystems: proc: remove stale information from intro")
> 
> Patch applied cleanly.
> 
> Notice that it probably depends on some changes that Jon
> applied for kernel-doc after -rc1.
> 
> If you prefer, the patch is here at global_vars branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-docs.git/log/?h=global_vars

Yes, this is much better.

For the simplified global data, it's very good. It produces
2 complaints but the html output is still good:

linux-next-20250909/Documentation/core-api/kernel-api:435: ../init/kdoc-globals-test.c:10: WARNING: Invalid C declaration: Expected end of definition. [error at 32]
  enum system_states system_state __read_mostly;
  --------------------------------^
linux-next-20250909/Documentation/core-api/kernel-api:435: ../init/kdoc-globals-test.c:20: WARNING: Invalid C declaration: Expected end of definition. [error at 25]
  char *saved_command_line __ro_after_init;
  -------------------------^

I suspect that this is not a surprise to you.

For the non-simplified global data, a few of the global items are
completely omitted from the html output. This is the html production:

Kernel Globals
dev_t ROOT_DEV;
system root device

enum system_states system_state __read_mostly;
system state used during boot or suspend/hibernate/resume

char *saved_command_line __ro_after_init;
kernel’s command line, saved from use at any later time in the kernel.

unsigned long preset_lpj;
lpj (loops per jiffy) value set from kernel command line using “lpj=VALUE”

static atomic64_t diskseq;
unique sequence number for block device instances


so these are completely missing/dropped: (they have
initializers or use DEFINE_MUTEX())

/**
 * global loop_per_jiffy - calculated loop count needed to consume one jiffy
 * of time
 */
unsigned long loops_per_jiffy = (1<<12);

// from init/version.c:
/**
 * global linux_proc_banner - text used from /proc/version file
 *
 * * first %s is sysname (e.g., "Linux")
 * * second %s is release
 * * third %s is version
 */
const char linux_proc_banner[] =
	"%s version %s"
	" (" LINUX_COMPILE_BY "@" LINUX_COMPILE_HOST ")"
	" (" LINUX_COMPILER ") %s\n";
//char linux_proc_banner[];

// from init/version-timestamp.c:
/**
 * global linux_banner - Linux boot banner, usually printed at boot time
 */
const char linux_banner[] =
	"Linux version " UTS_RELEASE " (" LINUX_COMPILE_BY "@"
	LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION "\n";
//const char linux_banner[];

// from net/core/rtnetlink.c:
/**
 * global rtnl_mutex - historical global lock for networking control operations.
 *
 * @rtnl_mutex is used to serialize rtnetlink requests
 * and protect all kernel internal data structures related to networking.
 *
 * See Documentation/networking/netdevices.rst for details.
 * Often known as the rtnl_lock, although rtnl_lock is a kernel function.
 */
static DEFINE_MUTEX(rtnl_mutex);


It's looking good. Thanks.

-- 
~Randy


