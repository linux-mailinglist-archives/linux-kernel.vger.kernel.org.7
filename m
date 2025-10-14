Return-Path: <linux-kernel+bounces-852183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E705BD8604
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:15:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D49F406906
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BBA2DEA8E;
	Tue, 14 Oct 2025 09:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxQdAUj3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589662E7F17
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760433310; cv=none; b=syFGLgcfhqB8qEdTnifPOmR3KCBfD3hyUO9/6Yxb88uWcHuIsiqcfocqaFRegn+0BLMnyZlcWG2Dxg0u+4AP2Rw4RGOhXx3/ybxMoiq1zb/R26AV55hyQJJew/3uqFPvs3rvr6FzooVMgmREMcoZW7mpqMjwvxGzwKJfWlmcCxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760433310; c=relaxed/simple;
	bh=dUf3SgvGYlHaEs4USw9N4nJWZh+DpSXufR90IS9NURs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HF92vTy/eNetEOEAYgkqZ6Thiq5vxBDiG/rtSjNmw+FpblJsimw6Wtuv43Wbd348ysPuu2SOCmERTOke+cAyAGON2TMIZ28eMAqIUmt5PQi/KFSVNx5MXtKq+zn5i5QSVQd1IL8xPzcS5ItdqfSD45XAMmd1Oq8T7D5wPhBjiNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cxQdAUj3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760433306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=84qLuulQEWfDvvAd6y1sTa13pyZb7pX9XGxQ88tYQoo=;
	b=cxQdAUj3nBFm0Mz1tUoPiBi9NsjkDbMhqNzlIVx0xNkju7vp3GxlQzwmqL4F1laiqzupn7
	8KiGZcZTW63OrrZsg9O//GH2wPGat1wgzgzQ1+m1OwM6RjB2FE+nk/2Q8u3I84144N1r1P
	hjkjAe2L9O2IRZhPmhsQZM8iZDIJs14=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-habP5WxuNy6IzIfoPvjpwQ-1; Tue,
 14 Oct 2025 05:15:03 -0400
X-MC-Unique: habP5WxuNy6IzIfoPvjpwQ-1
X-Mimecast-MFC-AGG-ID: habP5WxuNy6IzIfoPvjpwQ_1760433299
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 08D5B18002CD;
	Tue, 14 Oct 2025 09:14:59 +0000 (UTC)
Received: from localhost (unknown [10.72.112.12])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8DCFA1800283;
	Tue, 14 Oct 2025 09:14:57 +0000 (UTC)
Date: Tue, 14 Oct 2025 17:14:53 +0800
From: Baoquan He <bhe@redhat.com>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, glider@google.com,
	dvyukov@google.com, elver@google.com, linux-mm@kvack.org,
	vincenzo.frascino@arm.com, akpm@linux-foundation.org,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org, sj@kernel.org,
	lorenzo.stoakes@oracle.com, christophe.leroy@csgroup.eu
Subject: Re: [PATCH v3 00/12] mm/kasan: make kasan=on|off work for all three
 modes
Message-ID: <aO4UjVmGkYg5Nyf6@MiWiFi-R3L-srv>
References: <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
 <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
 <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
 <aMfWz4gwFNMx7x82@MiWiFi-R3L-srv>
 <CA+fCnZcWEuBerMeS4RCXQtged06MJhY=55KsYeJEOJn3K0psXQ@mail.gmail.com>
 <aNNY1AzfGua3Kk3S@MiWiFi-R3L-srv>
 <CACzwLxh10=H5LE0p86xKqfvObqq+6ZN5Cs0hJ9i1MKJHWnNx2w@mail.gmail.com>
 <aNTfPjS2buXMI46D@MiWiFi-R3L-srv>
 <CACzwLxiJ0pGur42Vigq=JnYecyZn-Z5BC3VcqxSUttT54kEusA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzwLxiJ0pGur42Vigq=JnYecyZn-Z5BC3VcqxSUttT54kEusA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 10/14/25 at 10:27am, Sabyrzhan Tasbolatov wrote:
> On Thu, Sep 25, 2025 at 11:21 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 09/25/25 at 12:07am, Sabyrzhan Tasbolatov wrote:
> > > On Wed, Sep 24, 2025 at 5:35 AM Baoquan He <bhe@redhat.com> wrote:
> > > >
> > > > On 09/23/25 at 07:49pm, Andrey Konovalov wrote:
> > > > > Since the Sabyrzhan's patches are already in mm-stable (and I assume
> > > > > will be merged during the next merge window), just rebase your changes
> > > > > on top.
> > > >
> > > > That's fine, I will rebase.
> > > >
> > > > >
> > > > > But also note that Sabyrzhan is planning to move out the
> > > > > kasan_enabled() checks into include/linux/kasan.h (which is a clean-up
> > > > > I would have also asked you to do with the kasan=off patches), so
> > > > > maybe you should sync up with him wrt these changes.
> > > >
> > > > Hi Sabyrzhan,
> > > >
> > > > What's your thought? You want to do the cleanup after my rebasing on
> > > > your merged patches or you prefer to do it ahead of time? Please let me
> > > > know so that I can adjust my posting accordingly. Thanks.
> > > >
> > >
> > > Hello,
> > >
> > > I can make all necessary changes only next week. Currently, traveling.
> > > I will send the fix-up patch Andrey has described somewhere next week.
> > > Please let me know if it's ok.
> >
> > Please take it easy, today is Thursday, I will wait for your clean up
> > patch next week and post. I can do some preparation work for rebasing on
> > your merged patches. Thanks.
> 
> Hello,
> 
> Just heads up that I've already sent cleanup patches [1] and
> Andrew has merged them into mm-new tree.
> Hopefully, one week's delay wasn't a problem.

Thanks for telling. I planned to rebase on top of that and repost in
one week or two weeks. I am doing some patch back porting for RHEL.

> 
> [1] https://lore.kernel.org/all/20251009155403.1379150-1-snovitoll@gmail.com/
> 


