Return-Path: <linux-kernel+bounces-800245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03C9FB43527
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 10:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9691C831CD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 08:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1522C21C1;
	Thu,  4 Sep 2025 08:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9MHf8o/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1817D2C1780
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 08:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756973506; cv=none; b=W1P+zB1wbJojkv3rsZ5KJ01qUQzjxN/4UBrAXPowiBXOdWplzNgjmX7nN81Uh00j2tFVeh3zZMuaWwr1U+lBBePtuQxz6tBT7jMK5KtcugOSX/vVX7Zxrp3neTzf5RO1L9JOcO7Q29tZRHMwKadmrQAgvToMDQnFg6EfB5BNxK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756973506; c=relaxed/simple;
	bh=rZv5jTtV+6DuCu6PNjdInkrZVuE6fTKPHabmd22S5JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtwzalJ+a4XAQQ1g5nfvvy5UAGTlBJCL+YFFu5c9CfBbbQxk/8VaCtRRp0JNMLQfrWmYWXd3y7mF53r6BjfzLL8kyklBJdWu063zfVaNQsEJwO5apJ/wmi+tgunyF63BBz9lYrNz7YjD0+W65Fl57YtWssL2TcAXwUX/1O28h7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9MHf8o/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756973503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pr0Y4bkCbfd3itfrxpuVGdfdmmRa0XxzBqHDc5t+1Us=;
	b=P9MHf8o/gOpaCqB3CEzTEUx3pO6vaTuiMuzqHB4lmPV6A79mjRlScQHI4t2CJsFNB+QZ80
	GRo6Qf8Z371CHLciIT9OEzMsjl+jZ+qEErxnxDiOp48QZCicWP/Dx0m8bERzxwPdrSEk86
	UGMR3z2mE3t5s0obokC8XH7VGyFgEpU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-502-44yZFtgQN2Gh_XbvPEWQXg-1; Thu,
 04 Sep 2025 04:11:41 -0400
X-MC-Unique: 44yZFtgQN2Gh_XbvPEWQXg-1
X-Mimecast-MFC-AGG-ID: 44yZFtgQN2Gh_XbvPEWQXg_1756973499
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF26F180034D;
	Thu,  4 Sep 2025 08:11:38 +0000 (UTC)
Received: from localhost (unknown [10.72.112.19])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5AD32180035E;
	Thu,  4 Sep 2025 08:11:36 +0000 (UTC)
Date: Thu, 4 Sep 2025 16:11:33 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: glider@google.com, dvyukov@google.com, elver@google.com,
	linux-mm@kvack.org, ryabinin.a.a@gmail.com,
	vincenzo.frascino@arm.com, akpm@linux-foundation.org,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, sj@kernel.org,
	lorenzo.stoakes@oracle.com, snovitoll@gmail.com,
	christophe.leroy@csgroup.eu
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
References: <20250820053459.164825-1-bhe@redhat.com>
 <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 09/03/25 at 03:22pm, Andrey Konovalov wrote:
> On Wed, Aug 20, 2025 at 7:35 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > Currently only hw_tags mode of kasan can be enabled or disabled with
> > kernel parameter kasan=on|off for built kernel. For kasan generic and
> > sw_tags mode, there's no way to disable them once kernel is built.
> > This is not convenient sometime, e.g in system kdump is configured.
> > When the 1st kernel has KASAN enabled and crash triggered to switch to
> > kdump kernel, the generic or sw_tags mode will cost much extra memory
> > for kasan shadow while in fact it's meaningless to have kasan in kdump
> > kernel.
> >
> > So this patchset moves the kasan=on|off out of hw_tags scope and into
> > common code to make it visible in generic and sw_tags mode too. Then we
> > can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
> > kasan.
> 
> Continuing the discussion on the previous version: so the unwanted
> extra memory usage is caused by the shadow memory for vmalloc
> allocations (as they get freed lazily)? This needs to be explained in
> the commit message.

Hmm, up to now, there are two parts of big amount of memory requiring
for kernel as I observed. One is the direct memory mapping shadow of
kasan, which is 1/8 of system RAM in generic mode and 1/16 of system
RAM in sw_tags mode; the other is the shadow meomry for vmalloc which
causes meomry big meomry usage in kdump kernel because of lazy vmap
freeing. By introducing "kasan=off|on", if we specify 'kasan=off', the
former is avoided by skipping the kasan_init(), and the latter is avoided
by not build the vmalloc shadow for vmalloc.

Yes, I totally agree with you, I should have put this in cover letter
and the main patch log to explain it better.

> 
> If so, would it help if we make the kasan.vmalloc command-line
> parameter work with the non-HW_TAGS modes (and make it do the same
> thing as disabling CONFIG_KASAN_VMALLOC)?
> 
> What I don't like about introducing kasan=off for non-HW_TAGS modes is
> that this parameter does not actually disable KASAN. It just
> suppresses KASAN code for mapping proper shadow memory. But the
> compiler-added instrumentation is still executing (and I suspect this
> might break the inline instrumentation mode).

I may not follow your saying it doesn't disable KASAN. In this patchset,
not only do I disable the code for mapping shadow memory, but also I
skip any KASAN checking. Please see change of check_region_inline() in
mm/kasan/generic.c and kasan_check_range() in mm/kasan/sw_tags.c. It
will skip any KASAN checking when accessing memory.

Yeah, the compiler added instrumentation will be called, but the if
(!kasan_enabled()) checking will decide if going further into KASAN code
or just return directly. I tried inline mode on x86_64 and arm64, it
works well when one reviewer said inline mode could cost much more
memory, I don't see any breakage w or w/o kasan=off when this patchset
applied..

> 
> Perhaps, we could instead add a new kasan.shadow=on/off parameter to
> make it more explicit that KASAN is not off, it's just that it stops
> mapping shadow memory.

Hmm, as I explained at above, kasan=off will stop mapping shadow memory,
and also stop executing KASAN code to poison/unpoison memory and check the
shadow. It may be inappropriate to say it only stops mapping shadow.

> 
> Dmitry, Alexander, Marco, do you have any opinion on kasan=off for
> non-HW_TAGS modes?
> 
> On a side note, this series will need to be rebased onto Sabyrzhan's
> patches [1] - those are close to being ready. But perhaps let's wait
> for v7 first.

I replied to Sabyrzhan's patchset, on top of this patchset, it's much
easier and cleaner to remove kasan_arch_is_ready(). We don't need
introduce CONFIG_ARCH_DEFER_KASAN. Please see below patchset which is
based on this patchset introducing 'kasan=off|on' to genric|sw_tags
mode.

[PATCH 0/4] mm/kasan: remove kasan_arch_is_ready()
https://lore.kernel.org/all/20250812130933.71593-1-bhe@redhat.com/T/#u

> 
> [1] https://lore.kernel.org/all/20250810125746.1105476-1-snovitoll@gmail.com/
> 

Thanks a lot for reviewing and feedback.


