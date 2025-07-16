Return-Path: <linux-kernel+bounces-732979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C023AB06E64
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 09:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0D605028F8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 07:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F86289377;
	Wed, 16 Jul 2025 07:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsYC/tu0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE64286D46
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 07:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752649271; cv=none; b=n987OSq0ANXE8qnXWySXZxwGWI8IBWDaAZg18Mc6QOodh96Uvn6Qkjqr3JgJ8MJBwla/drDzYTWxtmeaEQfm5UhIy7mnFyfDW8LE9Us32C7QZMw5IEHxBvcbPQgOJTwcVbl0LdqL7jCBhbZK8yDgPWYkSgDD+eCbZsN1wmE84tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752649271; c=relaxed/simple;
	bh=gibYJRAEGcG17h7YF4mYBLpDulc5AmLjWzwDgOANDOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiBWVQLxxiOdjtkEaznxi0pCFuoKrpN8WQCYojUhfO3cMUDICf2DiINn63+Boge767H2scHsNCCSqQjA7G0JNe4ZUd1MxQdSbr3/mK/OAK3F0FeaGUY+jePPviyOJroTK1xZ80qy5d8PvjBHy9Hlo9VHODjsbMOZ2mUSH0eewME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsYC/tu0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752649269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P3AUeB5zKzLtO+orAl/mtwdxHdQgBluYhKSJJpXA5pc=;
	b=dsYC/tu0kwAVGdI9kdcIuYSizwmv0QEKJk6XDPjVeUxCfk+ZQOCPhZSkwhPa2/BNZs+LvD
	W+9VcjN61wgrrhknjSDY4Sv/8KLTVUhoYO+zfacqpBz2rrPQ+s99aSX0/ZjwBLKl0ekPG4
	hrnr5aY/IAvRqNK5y/429TTuwog9CvY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-BL5TaZCFOHCmi349vO3ZCQ-1; Wed, 16 Jul 2025 03:01:07 -0400
X-MC-Unique: BL5TaZCFOHCmi349vO3ZCQ-1
X-Mimecast-MFC-AGG-ID: BL5TaZCFOHCmi349vO3ZCQ_1752649266
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45597cc95d5so25457455e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 00:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752649266; x=1753254066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3AUeB5zKzLtO+orAl/mtwdxHdQgBluYhKSJJpXA5pc=;
        b=Pfah9uuS8EonlIz0CTfLeSsX/YCDD3rne/WWNSqyOiFfhi6q6AFWZG3Vqs58NS3du+
         hlkic1Mml5/9BFyQo6ZuCyUGVdtr1CoF5+mZxOkNsezddotQROGmyew05gNuBRTpYyu0
         7igaortuvZdnGw/V5xa6SUn5qjlJSF6h1fK0HbCZeP2LK1Ev3sqiaQALzsc6fKpN6sEO
         zxXKStOuELS0M/Qv0X0tCmguG5RyKkhDbK+yJIsXzGG0kNV+4grTz4o7TUjoEUedjVDk
         +XeLa7w4wUWMMyo7mSqOWMAKB6B2VEkQM2CAMBXloO3XEpkD3uEEdytPw9h0mgjB5/89
         xEMA==
X-Forwarded-Encrypted: i=1; AJvYcCWCC0aDUP9IZaRGuv06X3woLKlwj6qFNbJKOYt/W3yDEG/EMLwIqAzxI33QTWiueVuPX09idbY0qB56IDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwopnqA0dhsdsOh9RsvSynpteoOLiFSiM2eWb5igSUU972Gntwl
	aAmZndcyPfWcdGdHwJ4ip+bJqtKtpZi9ZIDQPWBPlTDITlaj5YFUxp3vCCiz3h3rvGVTACkxFG+
	e3f0brv/98VPiBjBJcf7Lp8S4KcSSjOdHvKyk5GK/COelfJYUdSQ3dLQcX/thYz0UeQ==
X-Gm-Gg: ASbGnctkBfpizcxut3Kqq9ddeq19wZJpYgiQJnGst2SVZWfLIuZ1k1Pd54LXLkk040p
	5HPCpyRLtesu1iQGLEditvWiz9J8zDwt1ZYq3yjdsoI0bP/suEezmVA310x+oIOiTle4ipwQYfT
	mXwEKPZb+YK0Rc7B2SqDVas1mAZ7xyPIjpP3iUN2ItiHTwBTJfZDV/bfA0lllhQ9ZDQctRIjOrZ
	Vx4DHlZF98OXr0MKB5BFNmINgQ/UcCNZN7g714jpzcI14e9V3nSJabhSPko4ZVl8Zf2CXL53K1b
	wJycxiV27AwAppcOZigjCxDlZ7fzQKoi
X-Received: by 2002:a05:600c:8b2f:b0:456:27a4:50ad with SMTP id 5b1f17b1804b1-4562e3a222cmr11904775e9.33.1752649266256;
        Wed, 16 Jul 2025 00:01:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYSFsbElxZnORXSiqQIoPepQ7xnDr+y5vC+zWHhu4yMUCmvO2Fn7tVx5T9nx+faMjH/PtPcA==
X-Received: by 2002:a05:600c:8b2f:b0:456:27a4:50ad with SMTP id 5b1f17b1804b1-4562e3a222cmr11904415e9.33.1752649265837;
        Wed, 16 Jul 2025 00:01:05 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e802afasm11616785e9.12.2025.07.16.00.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 00:01:05 -0700 (PDT)
Date: Wed, 16 Jul 2025 03:01:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
	kvm@vger.kernel.org, Cleber Rosa <crosa@redhat.com>,
	Eduardo Habkost <eduardo@habkost.net>,
	Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Markus Armbruster <armbru@redhat.com>,
	Michael Roth <michael.roth@amd.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 (RESEND) 00/20] Change ghes to use HEST-based offsets
 and add support for error inject
Message-ID: <20250716025618-mutt-send-email-mst@kernel.org>
References: <cover.1749741085.git.mchehab+huawei@kernel.org>
 <20250715133423-mutt-send-email-mst@kernel.org>
 <20250716081117.4b89570a@foz.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716081117.4b89570a@foz.lan>

On Wed, Jul 16, 2025 at 08:11:17AM +0200, Mauro Carvalho Chehab wrote:
> Em Tue, 15 Jul 2025 13:36:26 -0400
> "Michael S. Tsirkin" <mst@redhat.com> escreveu:
> 
> > On Thu, Jun 12, 2025 at 05:17:24PM +0200, Mauro Carvalho Chehab wrote:
> > > Hi Michael,
> > > 
> > > This is v10 of the patch series, rebased to apply after release
> > > 10.0. The only difference against v9 is a minor confict resolution.  
> > 
> > Unfortunately, this needs a rebase on top of latest PCIHP
> > changes in my tree.  The changes are non trivial, too.
> > I should have let you know more early, sorry :(
> 
> If you still accept merging it, I can quickly rebase and send you.
> Just let me know about what branch you want the rebase.
> 
> Regards,
> Mauro

Well we are in freeze from yesterday, but if you feel any part of this
can be classified as a bugfix, I can merge that.  You can rebase on my
for_upstream tag.


-- 
MST


