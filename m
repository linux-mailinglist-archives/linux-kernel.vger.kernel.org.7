Return-Path: <linux-kernel+bounces-816463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45312B57414
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 001573A818F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0022F1FF5;
	Mon, 15 Sep 2025 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="igzH1Bbc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7902ECEB8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 09:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757927133; cv=none; b=sXxeVqup8lvtnxXm/nXiVlacQGcF/+v/1SegiicpU4jhWrAo6PRC+mKQPXVfosJ73rLhzKjGu9MnXDgyQqAY13/9BhH+8Dek7+I28tL0Sa9kTUMg/sh7S9K3gQn1Rl2u9hMsCiYGevV/jQrqZKkXKQloffkHGpL65QSBQ5V+KDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757927133; c=relaxed/simple;
	bh=pWd0dNe5mp7OhnAPu0LhAn/FzzY2MspInIEbKkbhz9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khkiyuTmnU11IOJw5JGZ9cU+ZF3TXckZJ6WAIWQI4Qab3T/xxXT4/VSRaFeElLcKfviOEnNGIRuaggfDNc5Ms06+uaiSaets3NY2+QAx2TKeicuNmNc6Qy9S6VkK7h52Ho9GDpzNmTxBZdO9/G5Z7gx3QCYfj+HX+uMra2ttd2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=igzH1Bbc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757927130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvJ9L1p3rbhqt/V3V+FfG1d8fzkSxXKReu1b/znpF7c=;
	b=igzH1Bbc24wb6TZ37WDweIaEsJ9KGwrYL0MukgDKsyJ+gcZFJLQj03adxtPS2Cm/OQAwmS
	Iz1qdtt+ZaIkHNlhrI9zEycSvobQHwZJKAf2/116SMa24UJn1jKhacm8XZrrgpp/rvS9Z8
	pCqVrq+EUa1/1xIViMdU12wXsKfDoKw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-88ufwEDMO5aVH_vHDZb24g-1; Mon,
 15 Sep 2025 05:05:29 -0400
X-MC-Unique: 88ufwEDMO5aVH_vHDZb24g-1
X-Mimecast-MFC-AGG-ID: 88ufwEDMO5aVH_vHDZb24g_1757927127
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CF3DC18002CA;
	Mon, 15 Sep 2025 09:05:26 +0000 (UTC)
Received: from localhost (unknown [10.72.112.195])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BA10719560A2;
	Mon, 15 Sep 2025 09:05:24 +0000 (UTC)
Date: Mon, 15 Sep 2025 17:05:19 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, snovitoll@gmail.com,
	glider@google.com, dvyukov@google.com, elver@google.com,
	linux-mm@kvack.org, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	sj@kernel.org, lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aMfWz4gwFNMx7x82@MiWiFi-R3L-srv>
References: <20250820053459.164825-1-bhe@redhat.com>
 <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
 <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
 <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/05/25 at 10:34pm, Andrey Konovalov wrote:
> On Fri, Sep 5, 2025 at 7:12 PM Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
> >
> > > But have you tried running kasan=off + CONFIG_KASAN_STACK=y +
> > > CONFIG_VMAP_STACK=y (+ CONFIG_KASAN_VMALLOC=y)? I would expect this
> > > should causes crashes, as the early shadow is mapped as read-only and
> > > the inline stack instrumentation will try writing into it (or do the
> > > writes into the early shadow somehow get ignored?..).
> >
> > It's not read-only, otherwise we would crash very early before full shadow
> > setup and won't be able to boot at all. So writes still happen, and shadow
> > checked, but reports are disabled.
> >
> > So the patchset should work, but it's a little bit odd feature. With kasan=off we still
> > pay x2-x3 performance penalty of compiler instrumentation and get nothing in return.
> > So the usecase for this is if you don't want to compile and manage additional kernel binary
> > (with CONFIG_KASAN=n) and don't care about performance at all.

Thanks a lot for your careful reviewing, and sorry for late reply.

About kasan=off, we use static key to detect that, wondering if we will
have x2-x3 performance penalty. Not only can kdump get the benefit, but I
can think of one case where people may use kasan enabled kernel to detect
MM issues, while use kasan=off to make sure kasan code itself won't make
trouble. E.g you tested a normal kernel and it has no problem, while
kasan enabled kernel will trigger issue, sometime do we doubt kasan
code? In this case, kasan=off can prove its inonence?

This could be trivial, while I don't see much kasan=off introducing will
impact the old kasan performance and stir the current kasan implementation
code. We have got the kasan_arch_is_ready() anyway.


> 
> Ack. So kasan=off would work but it's only benefit would be to avoid
> the RAM overhead.

Right, I built kernel with below configs on, kasan=off|on works very
well.

=====
CONFIG_KASAN=y
CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
CONFIG_KASAN_GENERIC=y
CONFIG_KASAN_INLINE=y
CONFIG_KASAN_STACK=y
CONFIG_KASAN_VMALLOC=y
CONFIG_KASAN_KUNIT_TEST=m
...
CONFIG_VMAP_STACK=y
=====

> 
> Baoquan, I'd be in favor of implementing kasan.vmalloc=off instead of
> kasan=off. This seems to both (almost) solve the RAM overhead problem
> you're having (AFAIU) and also seems like a useful feature on its own
> (similar to CONFIG_KASAN_VMALLOC=n but via command-line). The patches
> to support kasan.vmalloc=off should also be orthogonal to the
> Sabyrzhan's series.
> 
> If you feel strongly that the ~1/8th RAM overhead (coming from the
> physmap shadow and the slab redzones) is still unacceptable for your
> use case (noting that the performance overhead (and the constant
> silent detection of false-positive bugs) would still be there), I
> think you can proceed with your series (unless someone else is
> against).

Yeah, that would be great if we can also avoid any not needed memory
consumption for kdump.

> 
> I also now get what you meant that with your patches for the kasan=off
> support, Sabyrzhan's CONFIG_ARCH_DEFER_KASAN would not be required
> anymore: as every architecture would need a kasan_enabled() check,
> every architecture would effectively need the CONFIG_ARCH_DEFER_KASAN
> functionality (i.e. the static key to switch off KASAN).

Exactly. In this case, the code with the static key enabling or
disabling is clearer than CONFIG_ARCH_DEFER_KASAN setting or not.

> 
> Nevertheless, I still like the unification of the static keys usage
> and the KASAN initialization calls that the Sabyrzhan's series
> introduces, so I would propose to rebase your patches on top of his
> (even though you would remove CONFIG_ARCH_DEFER_KASAN, but that seems
> like a simple change) or pick out the related parts from his patches
> (but this might not be the best approach in case someone discovers a
> reason why kasan=off is a bad idea and we need to abandon the
> kasan=off series).

Here I understand your reviewing policy. While I would like to explain a
little about my posting. I planned to do this job in 2023, made draft
patches on x86 for generic kasan, I dind't go further to try sw_tags
mode on arm64 because other things interrupted me. This year, I made
plan to disable some kernel features not necessary for kdump kernel,
mainly by adding kernel parameter like ima= I made, and later the
kasan=off.

aa9bb1b32594 ima: add a knob ima= to allow disabling IMA in kdump kernel

When I made patch and posted, I didn't see Sabyrzhan's patches because I
usually don't go through mm mailing list. If I saw his patch earlier, I
would have suggested him to solve this at the same time.

About Sabyrzhan's patch sereis, I have picked up part of his patches and
credit the author to Sabyrzhan in below patchset.

[PATCH 0/4] mm/kasan: remove kasan_arch_is_ready()
https://lore.kernel.org/all/20250812130933.71593-1-bhe@redhat.com/T/#u

About reposting of this series, do you think which one is preferred:

1) Firstly merge Sabyrzhan's patch series, I reverted them and apply for
   my patchset.

2) Credit the author of patch 1,2,3 of this patch series to Sabyrzhan
   too as below, because Sabyrzhan do the unification of the static keys
   usage and the KASAN initialization calls earlier:

[PATCH v3 01/12] mm/kasan: add conditional checks in functions to return directly if kasan is disabled
[PATCH v3 02/12] mm/kasan: move kasan= code to common place
[PATCH v3 03/12] mm/kasan/sw_tags: don't initialize kasan if it's disabled

commit ac4004af0e1e8798d11c9310e500a88116d90271
Author: Baoquan He <bhe@redhat.com>
Date:   Mon Jan 2 08:58:36 2023 +0800

    x86/kasan: check if kasan is available

commit cddd343bdbf5d0331695da8100380fc4b8b47464
Author: Baoquan He <bhe@redhat.com>
Date:   Sun Jan 1 20:57:51 2023 +0800

    mm/kasan: allow generic and sw_tags to be set in kernel cmdline
    
    Signed-off-by: Baoquan He <bhe@redhat.com>

commit b149886995ecb2e464fee0cdd3a814035fc87226
Author: Baoquan He <bhe@redhat.com>
Date:   Sun Jan 1 21:07:29 2023 +0800

    x86/kasan: allow to disable kasan during boot time


