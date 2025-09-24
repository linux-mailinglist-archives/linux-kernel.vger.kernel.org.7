Return-Path: <linux-kernel+bounces-829861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA283B9813D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18346189EE4F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52661F09A8;
	Wed, 24 Sep 2025 02:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHQFiypz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CD71FC0EA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758681317; cv=none; b=WfOfj0VFejqfLuAMDmjxwtPm70dP5wxi23sWLunW7UVH8SBOkHyv7S6rv/awWmj51vonEtkFu0pEn34xRnr64XJhCqkIEFp+lyOkVOqOTWmRgFmyMeVuBNVcDR64tkITbO499BB1FZeeJrBtA9I1pocdejf2iypZUkzYBeXnAkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758681317; c=relaxed/simple;
	bh=l6mzHrh3DHwqDqhN4KRNV2GU6Fo1OTXQ0leBHA0ZE64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbbnb5LqbtmUjReSLrEOnzTxso2o/fYgI1T186V45a97elzjD3cudQGcAlR9F0rnaurh6WfZFmtChiNPrh/+9IYqdKNM1QFXLh97DCqToiGG5gW+l2EU3xqbsGtgxpJ8LFJ5Sp8Ap0HJZfG+uHAlhsaDxkXojoJwyRAqV/SydcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHQFiypz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758681313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r8pUVu7ebrm0X4wJheoYfCWuw4PuHNLvghKI3Pai2MA=;
	b=ZHQFiypz6QRpCuNpKx3PvVK/yXKnjgy0IYqI0n+GEFES0Inh+d3nAm7PZ2u+3jenYBpVku
	s2JwPBQhjEWFFgKt/8xo6q1RoNVRQVyyOrmZBoOhXHh3JPY1GAXOWZXvtoGUz6nSNkQoBX
	bv4TQwSg9eZhi6iU19Uj53OlHo2voFs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-MVxsJoxEMu6l8sCFbwGk7g-1; Tue,
 23 Sep 2025 22:35:09 -0400
X-MC-Unique: MVxsJoxEMu6l8sCFbwGk7g-1
X-Mimecast-MFC-AGG-ID: MVxsJoxEMu6l8sCFbwGk7g_1758681307
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 006D61956096;
	Wed, 24 Sep 2025 02:35:07 +0000 (UTC)
Received: from localhost (unknown [10.72.112.54])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 06F6B1800446;
	Wed, 24 Sep 2025 02:35:04 +0000 (UTC)
Date: Wed, 24 Sep 2025 10:35:00 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrey Konovalov <andreyknvl@gmail.com>, snovitoll@gmail.com
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, glider@google.com,
	dvyukov@google.com, elver@google.com, linux-mm@kvack.org,
	vincenzo.frascino@arm.com, akpm@linux-foundation.org,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, sj@kernel.org,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aNNY1AzfGua3Kk3S@MiWiFi-R3L-srv>
References: <20250820053459.164825-1-bhe@redhat.com>
 <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
 <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
 <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
 <aMfWz4gwFNMx7x82@MiWiFi-R3L-srv>
 <CA+fCnZcWEuBerMeS4RCXQtged06MJhY=55KsYeJEOJn3K0psXQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZcWEuBerMeS4RCXQtged06MJhY=55KsYeJEOJn3K0psXQ@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/23/25 at 07:49pm, Andrey Konovalov wrote:
> On Mon, Sep 15, 2025 at 11:05 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > > If you feel strongly that the ~1/8th RAM overhead (coming from the
> > > physmap shadow and the slab redzones) is still unacceptable for your
> > > use case (noting that the performance overhead (and the constant
> > > silent detection of false-positive bugs) would still be there), I
> > > think you can proceed with your series (unless someone else is
> > > against).
> >
> > Yeah, that would be great if we can also avoid any not needed memory
> > consumption for kdump.
> 
> Ack. Let's add support for kasan=off then.

Thanks.
> 
> But please describe it in detail in the KASAN documentation.

Will do in next round.

> 
> [...]
> 
> > When I made patch and posted, I didn't see Sabyrzhan's patches because I
> > usually don't go through mm mailing list. If I saw his patch earlier, I
> > would have suggested him to solve this at the same time.
> >
> > About Sabyrzhan's patch sereis, I have picked up part of his patches and
> > credit the author to Sabyrzhan in below patchset.
> >
> > [PATCH 0/4] mm/kasan: remove kasan_arch_is_ready()
> > https://lore.kernel.org/all/20250812130933.71593-1-bhe@redhat.com/T/#u
> >
> > About reposting of this series, do you think which one is preferred:
> >
> > 1) Firstly merge Sabyrzhan's patch series, I reverted them and apply for
> >    my patchset.
> >
> > 2) Credit the author of patch 1,2,3 of this patch series to Sabyrzhan
> >    too as below, because Sabyrzhan do the unification of the static keys
> >    usage and the KASAN initialization calls earlier:
> 
> Since the Sabyrzhan's patches are already in mm-stable (and I assume
> will be merged during the next merge window), just rebase your changes
> on top.

That's fine, I will rebase.

> 
> But also note that Sabyrzhan is planning to move out the
> kasan_enabled() checks into include/linux/kasan.h (which is a clean-up
> I would have also asked you to do with the kasan=off patches), so
> maybe you should sync up with him wrt these changes.

Hi Sabyrzhan,

What's your thought? You want to do the cleanup after my rebasing on
your merged patches or you prefer to do it ahead of time? Please let me
know so that I can adjust my posting accordingly. Thanks.

Thanks
Baoquan


