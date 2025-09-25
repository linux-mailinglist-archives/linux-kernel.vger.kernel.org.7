Return-Path: <linux-kernel+bounces-831799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AAFB9D939
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 229374A39FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 06:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C4E2E7F3C;
	Thu, 25 Sep 2025 06:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IcscfQRV"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABAD72610
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781262; cv=none; b=psaXjYZOcg3J9RLofzGRNLCdLc7pWgZ3brci3AdLqs77h5Nh2SetJkC1EV+9vq9O+vhyWM/Tm85JML2/vDAG+7AHDHZbbePxc1SdPtrmp8waW7PKtPqXMb6crFUK3criKNP4dmKagU7+aB52wwQxJkJH1rc3dHTksBQVsTyR4lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781262; c=relaxed/simple;
	bh=wOHBU2s/vt6iN7xnomSQcL4QI9civikg/ACO2kHF3YM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLaCJEoEegf9+7o4QZB8TaPI2gzFkH046S7NzS4vCIBJ92czfd0eyUBUKpv8VW+dKW5viy41ESxgIiQOUHdlT37Vj74fs5LaF841s3SkPnX1HbIKc39ivELJk7UQb4NnXq2tPxQLwha4reuF6XuOGkhM+vwMUqBTsXbRCiMLOJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IcscfQRV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758781259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MWVGs+PYKtMTbMr9CAqyDAMYWhTG9d/QRFnGi6Yteos=;
	b=IcscfQRV6LdTFAE7i+GZCLlD+y1HonBC+sVAOWMjYLJgXwKOx0Sft3V4y2rzUK89zh6KCl
	TrOOF2W5vzpac69OHci6yQqb7uL4Np093FhOx711CtSB8M8w+FaMfmLis1zXfS7pW1EQEI
	/b2K2g+k4AP4O/l2EGoSRKi+VJTIjLQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-x8b2H0wSP5im0fP7tXEa7Q-1; Thu,
 25 Sep 2025 02:20:55 -0400
X-MC-Unique: x8b2H0wSP5im0fP7tXEa7Q-1
X-Mimecast-MFC-AGG-ID: x8b2H0wSP5im0fP7tXEa7Q_1758781253
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F1E711955F45;
	Thu, 25 Sep 2025 06:20:52 +0000 (UTC)
Received: from localhost (unknown [10.72.112.12])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E97CE19560B1;
	Thu, 25 Sep 2025 06:20:50 +0000 (UTC)
Date: Thu, 25 Sep 2025 14:20:46 +0800
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
Message-ID: <aNTfPjS2buXMI46D@MiWiFi-R3L-srv>
References: <20250820053459.164825-1-bhe@redhat.com>
 <CA+fCnZdfv+D7sfRtWgbbFAmWExggzC2by8sDaK7hXfTS7viY8w@mail.gmail.com>
 <aLlJtTeNMdtZAA9B@MiWiFi-R3L-srv>
 <CA+fCnZf2fGTQ6PpoKxDqkOtwcdwyPYx2cFwQw+3xAjOVxjoh6w@mail.gmail.com>
 <75a2eb31-3636-44d4-b2c9-3a24646499a4@gmail.com>
 <CA+fCnZf7jYPUyqHqonWhDKVi9eeN6aaaByMTBYCQrv2-8+hngQ@mail.gmail.com>
 <aMfWz4gwFNMx7x82@MiWiFi-R3L-srv>
 <CA+fCnZcWEuBerMeS4RCXQtged06MJhY=55KsYeJEOJn3K0psXQ@mail.gmail.com>
 <aNNY1AzfGua3Kk3S@MiWiFi-R3L-srv>
 <CACzwLxh10=H5LE0p86xKqfvObqq+6ZN5Cs0hJ9i1MKJHWnNx2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACzwLxh10=H5LE0p86xKqfvObqq+6ZN5Cs0hJ9i1MKJHWnNx2w@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/25/25 at 12:07am, Sabyrzhan Tasbolatov wrote:
> On Wed, Sep 24, 2025 at 5:35 AM Baoquan He <bhe@redhat.com> wrote:
> >
> > On 09/23/25 at 07:49pm, Andrey Konovalov wrote:
> > > Since the Sabyrzhan's patches are already in mm-stable (and I assume
> > > will be merged during the next merge window), just rebase your changes
> > > on top.
> >
> > That's fine, I will rebase.
> >
> > >
> > > But also note that Sabyrzhan is planning to move out the
> > > kasan_enabled() checks into include/linux/kasan.h (which is a clean-up
> > > I would have also asked you to do with the kasan=off patches), so
> > > maybe you should sync up with him wrt these changes.
> >
> > Hi Sabyrzhan,
> >
> > What's your thought? You want to do the cleanup after my rebasing on
> > your merged patches or you prefer to do it ahead of time? Please let me
> > know so that I can adjust my posting accordingly. Thanks.
> >
> 
> Hello,
> 
> I can make all necessary changes only next week. Currently, traveling.
> I will send the fix-up patch Andrey has described somewhere next week.
> Please let me know if it's ok.

Please take it easy, today is Thursday, I will wait for your clean up
patch next week and post. I can do some preparation work for rebasing on
your merged patches. Thanks.

> 
> > Thanks
> > Baoquan
> >
> 


