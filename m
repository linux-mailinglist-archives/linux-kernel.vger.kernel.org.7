Return-Path: <linux-kernel+bounces-768331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A28B25FEB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254A4A212AB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48AC62E11BF;
	Thu, 14 Aug 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4OQ+arh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC95218EBA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755161779; cv=none; b=rIBtRWd4sZ4Fl/WzFqkwmG2pN/S9E/wENQu5GokxUQnBluGBT5TQuyu6qdjNA5n+q4KTEgHMfst9/54eYaTPZdeATK510HT5eNsdJiMLhmy654kiHDPoBUOSZr/Ztk4TBdw/gP48Qxd1q5yr5+VBBHFEM78LNOS7IVro3c6leIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755161779; c=relaxed/simple;
	bh=oA6DFuwSDR1lvLdNB7PUbC9G4+RmgttBhAkFkDxQrZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+ADS9HdzI7BXn90f8/0yhKcBKUF1V2q51ZacR0qaLN8wlNNhBmL4J7+RVIMzYUq2ZuNaoi98GP97DmOEbH+vUdVFqAviNc2hOTCIJoC4dGDL9qPAozFyo/QdOkpmWFFyynqrbhMHjA3osw0WtYX/TcBU25iBHhiEPV9+SzhdW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4OQ+arh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755161776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e46B2FI/PagtxjUFemCdMQXhTSnu4yC2Ildyjyftxdo=;
	b=F4OQ+arhHwmD/4IZeBI4RKgdsf2c9nXSrmqt0tDLYaNCNVtIoTWUB688ltG4JkP96Mth1v
	ICZjVTvlU8lJhNN4Xhz9dOIjYm7x225Nuf076k87XbV25XzVphM+zCIjVtTq4CSWenB07b
	vAibJ+BcOdiE893+nqCXun2caT6GVOQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-3SOjFLgDMcqA9Xa_jao8Yg-1; Thu,
 14 Aug 2025 04:56:13 -0400
X-MC-Unique: 3SOjFLgDMcqA9Xa_jao8Yg-1
X-Mimecast-MFC-AGG-ID: 3SOjFLgDMcqA9Xa_jao8Yg_1755161771
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EEB141956060;
	Thu, 14 Aug 2025 08:56:10 +0000 (UTC)
Received: from localhost (unknown [10.72.112.89])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B73811800446;
	Thu, 14 Aug 2025 08:56:08 +0000 (UTC)
Date: Thu, 14 Aug 2025 16:56:04 +0800
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
Message-ID: <aJ2kpEVB4Anyyo/K@MiWiFi-R3L-srv>
References: <20250812124941.69508-1-bhe@redhat.com>
 <CA+fCnZcAa62uXqnUwxFmDYh1xPqKBOQqOT55kU8iY_pgQg2+NA@mail.gmail.com>
 <CA+fCnZdKy-AQr+L3w=gfaw9EnFvKd0Gz4LtAZciYDP_SiWrL2A@mail.gmail.com>
 <aJxzehJYKez5Q1v2@MiWiFi-R3L-srv>
 <CA+fCnZfv9sbHuRVy8G9QdbKaaeO-Vguf7b2Atc5WXEs+uJx0YQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZfv9sbHuRVy8G9QdbKaaeO-Vguf7b2Atc5WXEs+uJx0YQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 08/14/25 at 07:23am, Andrey Konovalov wrote:
> On Wed, Aug 13, 2025 at 1:14 PM 'Baoquan He' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
> >
> > > I'm not familiar with the internals of kdump, but would it be
> > > possible/reasonable to teach kdump to ignore the KASAN shadow region?
> >
> > Yes, we can teach kdump to do that. Then people may hate those conditional
> > check "if (is_kdump_kernel())" being added in kasan code. E.g even
> > though we skip kasan_init(), we still need to check is_kdump_kernel()
> > in kasan_populate_vmalloc(), right?
> >
> > Combined with the existing kasan_arch_is_ready(), it will make kasan code
> > ugly. I planned to add kasan_enabled() via static key
> > kasan_flag_enabled, then it can also easily remove kasan_arch_is_ready()
> > cleanly.
> 
> What I had in mind was something different: into the kdump code, we
> add a check whether the region of memory it's trying to dump is the
> KASAN shadow, and make kdump not to dump this region.

Ah, I got what you mean. We probably are saying different things.

In order to record memory content of a corrupted kernel, we need reserve
a memory region during bootup of a normal kernel (usually called 1st
kernel) via kernel parameter crashkernel=nMB in advance. Then load
kernel into the crashkernel memory region, that means the region is not
usable for 1st kernel. When 1st kernel collapsed, we stop the 1st kernel
cpu/irq and warmly switch to the loaded kernel in the crashkernel memory
region (usually called kdump kernel). In kdump kernel, it boots up and
enable necessary features to read out the 1st kernel's memory content,
we usually use user space tool like makeudmpfile to filter out unwanted
memory content.

So this patchset intends to disable KASAN to decrease the crashkernel
meomry value because crashkernel is not usable for 1st kernel. As for
shadow memory of 1st kernel, we need recognize it and filter it away
in makedumpfile. 

> 
> Would this work? Would this help with the issue you have?
> 
> (I assume the problem is with the virtual region that is the shadow
> memory, as kdump would dump all RAM either way? If not, please clarify
> what how does the "heavy burden" that the shadow memory causes
> manifests.)
> 
> Thank you!
> 


