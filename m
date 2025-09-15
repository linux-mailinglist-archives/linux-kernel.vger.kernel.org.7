Return-Path: <linux-kernel+bounces-816120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3A98B56FC1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F38F3B854D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 05:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB4626F2AB;
	Mon, 15 Sep 2025 05:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FfZYjYkr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9A14207F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 05:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757914661; cv=none; b=KLnPyZapzo5bVBlRC+sbv5N6JhgAKuV9KJOQ1EyDvmGTSt7xQd3yWt4yYRhdtW3eECoN5GXeqOhTcLYO8UYD70CxCiMX6hZgv0TnXxaJ4QOeQqdYZ0OcoFXzLDZRdjmI0bfYdnKdyz+Zw2BpGJbRuo4VUB8lfhKY8jySP1s5AbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757914661; c=relaxed/simple;
	bh=7FaPHvaHboKYorbJVbz1FyZQBQKlAOrD2rb4iU3osNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Slb+ZobYEb+WddGt08G4uyFlk8np6MCTrVpMTHScpSvLdbWlEXJZUrGdqaJIoiNel94Dzw+Wc9n6mbpxIEe4o02KfiOcEsutSo5OigJGO29tsjFx+h/sojdjtt2YtuBiYQCUnv0dGS1ianMBIdgr87eAP6yTMVx/yXkkR6VGkdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FfZYjYkr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757914658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rR4nvuLB68PWeoEq6OrLbNMctFC5H6hheeaS39RYv7Q=;
	b=FfZYjYkrYJa9rito3bV+9Z+JVNM5hiVoLtHRNt7kD5j2htro7rIThQBVp9RyKxR6hOZ8/q
	Qnbd5O8NO2HS6Y1E+zQmCDKSzVzHRDjdaPjC7TkMmORLKWWh19IhqXMPqEU1KWtPYxGmNK
	S1P3S4WMgBFY98RY/uaBcwMmCQk6LD0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-595-j2IEoyyDO9S2fP4RaYfzeA-1; Mon,
 15 Sep 2025 01:37:32 -0400
X-MC-Unique: j2IEoyyDO9S2fP4RaYfzeA-1
X-Mimecast-MFC-AGG-ID: j2IEoyyDO9S2fP4RaYfzeA_1757914650
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 52736195609F;
	Mon, 15 Sep 2025 05:37:30 +0000 (UTC)
Received: from localhost (unknown [10.72.112.195])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CC8901800446;
	Mon, 15 Sep 2025 05:37:28 +0000 (UTC)
Date: Mon, 15 Sep 2025 13:37:24 +0800
From: Baoquan He <bhe@redhat.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: glider@google.com, dvyukov@google.com, elver@google.com,
	linux-mm@kvack.org, vincenzo.frascino@arm.com,
	akpm@linux-foundation.org, kasan-dev@googlegroups.com,
	linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
	sj@kernel.org, lorenzo.stoakes@oracle.com,
	christophe.leroy@csgroup.eu,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, snovitoll@gmail.com
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aMemFIM+T7PBrx1G@MiWiFi-R3L-srv>
References: <20250820053459.164825-1-bhe@redhat.com>
 <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
 <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
 <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
 <CA+fCnZf0z526E31AN_NUM-ioaGm+YF2kn02NwGU6-fmki-tkCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+fCnZf0z526E31AN_NUM-ioaGm+YF2kn02NwGU6-fmki-tkCg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 09/06/25 at 03:25pm, Andrey Konovalov wrote:
> On Fri, Sep 5, 2025 at 10:34 PM Andrey Konovalov <andreyknvl@gmail.com> wrote:
> >
> > Baoquan, I'd be in favor of implementing kasan.vmalloc=off instead of
> > kasan=off. This seems to both (almost) solve the RAM overhead problem
> > you're having (AFAIU) and also seems like a useful feature on its own
> > (similar to CONFIG_KASAN_VMALLOC=n but via command-line). The patches
> > to support kasan.vmalloc=off should also be orthogonal to the
> > Sabyrzhan's series.
> >
> > If you feel strongly that the ~1/8th RAM overhead (coming from the
> > physmap shadow and the slab redzones) is still unacceptable for your
> > use case (noting that the performance overhead (and the constant
> > silent detection of false-positive bugs) would still be there), I
> > think you can proceed with your series (unless someone else is
> > against).
> 
> Hm, just realized that kasan.vmalloc=off would probably break if
> CONFIG_VMAP_STACK is enabled: read-only shadow for vmalloc =>
> read-only shadow for stacks => stack instrumentation will try writing
> into read-only shadow and crash.
> 
> So I wonder if there's a way to avoid the lazy vmap freeing to deal
> with the RAM overhead.

That's a very key feature of vmalloc, lazy vmap freeing not only
integrate the virtual area freeing on one cpu at one time, but also
merge the areas and flush tlb at one time too. Please see
__purge_vmap_area_lazy() for the details. This can avoid performance
degradation when many vfree() are called.


