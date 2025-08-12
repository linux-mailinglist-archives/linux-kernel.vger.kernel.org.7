Return-Path: <linux-kernel+bounces-764947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02433B22964
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 15:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B148E58448C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 13:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECD6286D69;
	Tue, 12 Aug 2025 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSbN2h0f"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865722868A1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755005970; cv=none; b=QljL8ReeVwz1MoIWO5xsg1ZlKBZZBgiUFQDG3hlUFIifa51gWpqlr8PxCmmGs+0teaPNz7SCe6FhnzW6fk/TgRYPgDLU1xp5UK/6nryX7zxvfZQ1ECtL3FpeLqDjEWkHqtx55BO1QrsaUvVL6ZTPT/QuY9opbyDKX7FH5/q1WTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755005970; c=relaxed/simple;
	bh=v3lEPLSOgQrqB4nhnBSAczkf4aDGSxez+os4FxE4r6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgCUuPFIjtNu4lreR8ZWBXEjb7UlNxHzpMzH3MPKgjMlnXIgsalEEAOCiRNSf1D1nA6wnVhX/u9yM2fOMx1ZOZL0NmnzGIaSk8pu2PmnIo5ofmsiSgJWGzA4bIk4uSQ3JGQFq4FYy42Q5z2KR2Dl9kFPvDMgM2YNnq+iVCw5cwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSbN2h0f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755005967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=DxjcecEI7phcRYjWyLkZSnGEJwCBjNTRZZccT/msDU8=;
	b=CSbN2h0fI9Kos09cBO41J8Qz4DVKdz+JQ27gZuMLeGKKbJ/JNzqUj+WpZe5rNGKohK52yi
	owFJFj61YYDKUJncYXm8+z3YYOAwAsSqTAHlJ9q7035Pw+LgwW99CKA3/63or1wRs2kzdM
	8fv4iOhMbIdQQ/9I34TY/NVOC3idF88=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-FY5fxrhNOyqPzbOI5L33kw-1; Tue,
 12 Aug 2025 09:39:22 -0400
X-MC-Unique: FY5fxrhNOyqPzbOI5L33kw-1
X-Mimecast-MFC-AGG-ID: FY5fxrhNOyqPzbOI5L33kw_1755005958
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5149919560B3;
	Tue, 12 Aug 2025 13:39:17 +0000 (UTC)
Received: from localhost (unknown [10.72.112.156])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F8A819560AB;
	Tue, 12 Aug 2025 13:39:15 +0000 (UTC)
Date: Tue, 12 Aug 2025 21:39:11 +0800
From: Baoquan He <bhe@redhat.com>
To: linux-mm@kvack.org, alexghiti@rivosinc.com, agordeev@linux.ibm.com,
	linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, christophe.leroy@csgroup.eu,
	x86@kernel.org, chris@zankel.net, jcmvbkbc@gmail.com,
	linux-um@lists.infradead.org
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	sj@kernel.org, lorenzo.stoakes@oracle.com, elver@google.com,
	snovitoll@gmail.com
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aJtD/8beAEHtm2/6@MiWiFi-R3L-srv>
References: <20250812124941.69508-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812124941.69508-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Forgot adding related ARCH mailing list or people to CC, add them.

On 08/12/25 at 08:49pm, Baoquan He wrote:
> Currently only hw_tags mode of kasan can be enabled or disabled with
> kernel parameter kasan=on|off for built kernel. For kasan generic and
> sw_tags mode, there's no way to disable them once kernel is built.
> This is not convenient sometime, e.g in system kdump is configured.
> When the 1st kernel has KASAN enabled and crash triggered to switch to
> kdump kernel, the generic or sw_tags mode will cost much extra memory
> for kasan shadow while in fact it's meaningless to have kasan in kdump
> kernel.
> 
> So this patchset moves the kasan=on|off out of hw_tags scope and into
> common code to make it visible in generic and sw_tags mode too. Then we
> can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
> kasan.
> 
> Changelog:
> ====
> v1->v2:
> - Add __ro_after_init for __ro_after_init, and remove redundant blank
>   lines in mm/kasan/common.c. Thanks to Marco.
> - Fix a code bug in <linux/kasan-enabled.h> when CONFIG_KASAN is unset,
>   this is found out by SeongJae and Lorenzo, and also reported by LKP
>   report, thanks to them.
> - Add a missing kasan_enabled() checking in kasan_report(). This will
>   cause below KASAN report info even though kasan=off is set:
>      ==================================================================
>      BUG: KASAN: stack-out-of-bounds in tick_program_event+0x130/0x150
>      Read of size 4 at addr ffff00005f747778 by task swapper/0/1
>      
>      CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.16.0+ #8 PREEMPT(voluntary) 
>      Hardware name: GIGABYTE R272-P30-JG/MP32-AR0-JG, BIOS F31n (SCP: 2.10.20220810) 09/30/2022
>      Call trace:
>       show_stack+0x30/0x90 (C)
>       dump_stack_lvl+0x7c/0xa0
>       print_address_description.constprop.0+0x90/0x310
>       print_report+0x104/0x1f0
>       kasan_report+0xc8/0x110
>       __asan_report_load4_noabort+0x20/0x30
>       tick_program_event+0x130/0x150
>       ......snip...
>      ==================================================================
> 
> - Add jump_label_init() calling before kasan_init() in setup_arch() in these
>   architectures: xtensa, arm. Because they currenly rely on
>   jump_label_init() in main() which is a little late. Then the early static
>   key kasan_flag_enabled in kasan_init() won't work.
> 
> - In UML architecture, change to enable kasan_flag_enabled in arch_mm_preinit()
>   because kasan_init() is enabled before main(), there's no chance to operate
>   on static key in kasan_init().
> 
> Test:
> =====
> In v1, I took test on x86_64 for generic mode, and on arm64 for
> generic, sw_tags and hw_tags mode. All of them works well.
> 
> In v2, I only tested on arm64 for generic, sw_tags and hw_tags mode, it
> works. For powerpc, I got a BOOK3S/64 machine, while it says
> 'KASAN not enabled as it requires radix' and KASAN is disabled. Will
> look for other POWER machine to test this.
> ====
> 
> Baoquan He (12):
>   mm/kasan: add conditional checks in functions to return directly if
>     kasan is disabled
>   mm/kasan: move kasan= code to common place
>   mm/kasan/sw_tags: don't initialize kasan if it's disabled
>   arch/arm: don't initialize kasan if it's disabled
>   arch/arm64: don't initialize kasan if it's disabled
>   arch/loongarch: don't initialize kasan if it's disabled
>   arch/powerpc: don't initialize kasan if it's disabled
>   arch/riscv: don't initialize kasan if it's disabled
>   arch/x86: don't initialize kasan if it's disabled
>   arch/xtensa: don't initialize kasan if it's disabled
>   arch/um: don't initialize kasan if it's disabled
>   mm/kasan: make kasan=on|off take effect for all three modes
> 
>  arch/arm/kernel/setup.c                |  6 +++++
>  arch/arm/mm/kasan_init.c               |  6 +++++
>  arch/arm64/mm/kasan_init.c             |  7 ++++++
>  arch/loongarch/mm/kasan_init.c         |  5 ++++
>  arch/powerpc/mm/kasan/init_32.c        |  8 +++++-
>  arch/powerpc/mm/kasan/init_book3e_64.c |  6 +++++
>  arch/powerpc/mm/kasan/init_book3s_64.c |  6 +++++
>  arch/riscv/mm/kasan_init.c             |  6 +++++
>  arch/um/kernel/mem.c                   |  6 +++++
>  arch/x86/mm/kasan_init_64.c            |  6 +++++
>  arch/xtensa/kernel/setup.c             |  1 +
>  arch/xtensa/mm/kasan_init.c            |  6 +++++
>  include/linux/kasan-enabled.h          | 18 ++++++-------
>  mm/kasan/common.c                      | 25 ++++++++++++++++++
>  mm/kasan/generic.c                     | 20 +++++++++++++--
>  mm/kasan/hw_tags.c                     | 35 ++------------------------
>  mm/kasan/init.c                        |  6 +++++
>  mm/kasan/quarantine.c                  |  3 +++
>  mm/kasan/report.c                      |  4 ++-
>  mm/kasan/shadow.c                      | 23 ++++++++++++++++-
>  mm/kasan/sw_tags.c                     |  9 +++++++
>  21 files changed, 165 insertions(+), 47 deletions(-)
> 
> -- 
> 2.41.0
> 


