Return-Path: <linux-kernel+bounces-766560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC707B24826
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D39F1BC3C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B8E2F6578;
	Wed, 13 Aug 2025 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CEOLR16n"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0601E1A9F9E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083661; cv=none; b=KyfZoDoTDcK2YYVEzIbOOM2CO7LBYLvVXcXbLIodjUJbTLc/iX7RtIw2jUMF3OpuUn5BDoVI99/qSgw0vV+3PErMTUBWfAjB5Rf7Jv2zFVqubFJJ5s0NjPWG+WMExZPrTyFRtnSE2T+Bb7pCTV9/INDZJJsx2+vEI6hfTZkvJE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083661; c=relaxed/simple;
	bh=jJ8Z6o7SASBnxW1/g8l1fDZr1YOffQeae3dgbacleoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S94i2TUOlwJjYoUmZlSYYUfj6/jdUxwXCncCvS6Nzqkbg0KyDTnEURYdJgNRPkBq1elaGPQLCI/haYIGGdOHEkruB9wOrx5q91uuRrtilpldmmyh/hDAUSeU2ojmXORVP5ipsbQOonzhRijVJRdARGu8sBX4I8jl14fSWcV7CRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CEOLR16n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755083658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yNVE6wsMC8x7hacYqMkArJqlP3u73DUjInfZebo80YI=;
	b=CEOLR16nXv4mgE6fBUEAJaRWek/R/JjWq9rf9IDDV1KSxcPUM0fXyxdMMw1VqWaGopK0CD
	pe3x6DWDkXm/DUZKSEhKg362crVYxHXn9/qNXISUX5GrynzXOwV3ErYfKBtNKDhf+LeXkm
	4ets82YC404NkZ1Tt8GMVk+NEtqShrE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-4Pp8IIsdO9WiKTWHKKqYIA-1; Wed,
 13 Aug 2025 07:14:12 -0400
X-MC-Unique: 4Pp8IIsdO9WiKTWHKKqYIA-1
X-Mimecast-MFC-AGG-ID: 4Pp8IIsdO9WiKTWHKKqYIA_1755083650
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1FC61800291;
	Wed, 13 Aug 2025 11:14:09 +0000 (UTC)
Received: from localhost (unknown [10.72.112.177])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0043630001A1;
	Wed, 13 Aug 2025 11:14:07 +0000 (UTC)
Date: Wed, 13 Aug 2025 19:14:02 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: linux-mm@kvack.org, ryabinin.a.a@gmail.com, glider@google.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	sj@kernel.org, lorenzo.stoakes@oracle.com, elver@google.com,
	snovitoll@gmail.com
Subject: Re: [PATCH v2 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aJxzehJYKez5Q1v2@MiWiFi-R3L-srv>
References: <20250812124941.69508-1-bhe@redhat.com>
 <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
 <CA+fCnZdKy-AQr+L3w=gfaw9EnFvKd0Gz4LtAZciYDP_SiWrL2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZdKy-AQr+L3w=gfaw9EnFvKd0Gz4LtAZciYDP_SiWrL2A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 08/12/25 at 07:14pm, Andrey Konovalov wrote:
> On Tue, Aug 12, 2025 at 6:57 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> >
> > On Tue, Aug 12, 2025 at 2:49 PM Baoquan He <bhe@redhat.com> wrote:
> > >
> > > Currently only hw_tags mode of kasan can be enabled or disabled with
> > > kernel parameter kasan=on|off for built kernel. For kasan generic and
> > > sw_tags mode, there's no way to disable them once kernel is built.
> > > This is not convenient sometime, e.g in system kdump is configured.
> > > When the 1st kernel has KASAN enabled and crash triggered to switch to
> > > kdump kernel, the generic or sw_tags mode will cost much extra memory
> > > for kasan shadow while in fact it's meaningless to have kasan in kdump
> > > kernel.
> > >
> > > So this patchset moves the kasan=on|off out of hw_tags scope and into
> > > common code to make it visible in generic and sw_tags mode too. Then we
> > > can add kasan=off in kdump kernel to reduce the unneeded meomry cost for
> > > kasan.
> >
> > Hi Baoquan,
> >
> > Could you clarify what are you trying to achieve by disabling
> > Generic/SW_TAGS KASAN via command-line? Do you want not to see any
> > KASAN reports produced? Or gain back the performance?
> >
> > Because for the no reports goal, it would be much easier to add a
> > command-line parameter to silent the reports.
> >
> > And the performance goal can only be partially achieved, as you cannot
> > remove the compiler instrumentation without rebuilding the kernel.
> > (What are the boot times for KASAN_GENERIC=n vs KASAN_GENERIC=y +
> > kasan=off vs KASAN_GENERIC=y btw?)
> >

Thanks a lot for checking this.

> 
> Ah, you don't want the shadow memory for kdump, sorry, I somehow missed that.

Yeah, for kdump kernel, the shadow is a heavy burden, and most
importantly kasan is useless for kdump. We don't want to capture a
kernel memory bug through kdump kernel running becuase kdump is a
debugging mechanism.

> 
> I'm not familiar with the internals of kdump, but would it be
> possible/reasonable to teach kdump to ignore the KASAN shadow region?

Yes, we can teach kdump to do that. Then people may hate those conditional
check "if (is_kdump_kernel())" being added in kasan code. E.g even
though we skip kasan_init(), we still need to check is_kdump_kernel()
in kasan_populate_vmalloc(), right? 

Combined with the existing kasan_arch_is_ready(), it will make kasan code
ugly. I planned to add kasan_enabled() via static key
kasan_flag_enabled, then it can also easily remove kasan_arch_is_ready()
cleanly.


