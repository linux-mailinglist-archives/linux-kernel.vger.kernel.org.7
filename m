Return-Path: <linux-kernel+bounces-856354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB10BE3F5C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 02CCF4FFCC0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E2033EAFD;
	Thu, 16 Oct 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HsMRAjXx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730081FE44B
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625579; cv=none; b=aEH/wzd1AYuwhQ1ItF3o6iEtxEqob/SJfeDeZO6Pljna2RfQllY9LCp+U0SdS+M8hFzwvR0JHmHTRMw6J42mljt638ArhgTU0Wq5tSIoLwEvj1bi1ehUvmGfj/+QC5DH5RdZhMHQmTqjQYdyXm4XG+HmMBcHqm5AEH7Smz2G0B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625579; c=relaxed/simple;
	bh=oAFOf0C7FHbG2dP8F5Uk3uZewMXJkblvCyuuZPnvJXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MhvnoHE//UiV3Y+/7WrBBXzyEmY+qW4KHlOnzaKFhvbIGNy40tP5wsl+diKkXO5Xv5oJqOANkdbAQdir80arhlEolhj0lFngTQdW1Ze8UOJQCTojP9ch/yAiBJ/YtEvZr34DD0ikMpjq2zkCyn12m2ziHn8LHRCCE6wWQU5vP0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HsMRAjXx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760625576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AtluYhVLkbO8u0oWJsyCOzeQxxX6dgreB/25XigeFbM=;
	b=HsMRAjXxdMNcqaN1aD7osO5UxUS0vcWINeJ5vrdN/r/Fo5XJ8fkSKjwU4UbpoywUpq6qds
	kv38VB3Vu6Y5DR4qMpS4LiPaUvdztSL7EXjUdQ+9BUd7gdQPKRTY8uWxITJ1W7EanCqOH/
	axcK2VrQt2md5A0VRLEk6fOFIsi8ouI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-QFA7pJqxMWqgCWycwV73vw-1; Thu, 16 Oct 2025 10:39:35 -0400
X-MC-Unique: QFA7pJqxMWqgCWycwV73vw-1
X-Mimecast-MFC-AGG-ID: QFA7pJqxMWqgCWycwV73vw_1760625574
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-28c58e009d1so16366725ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760625574; x=1761230374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AtluYhVLkbO8u0oWJsyCOzeQxxX6dgreB/25XigeFbM=;
        b=hchSIY29eahjxqr/NhnPheJs9vtlJlpnVD0eRh/stDW5yEbP5Q33VBNgK7vFmfr/es
         lK5+xC7VUaorTGxM7c7xiT8Hgk4OnbNtVYERCzHBkSZHXVo+sgtZt5sSsmo7WTx94f9E
         GIkHRq7FRli1wAW9522bi6pW/So1rQiu//vRBxdJejjs4jvUZnMla/w+9/7nlSp0OECs
         xw6/LkIFhWOI31ZGjFrfBf495arRCZTUOQXNv70n7/s2PBfnH6Gtx4YfDpM54cjRawt1
         xvQgwvuU4nv9H9QOy04R00XfLI2+d+ZxDutn7B3gWwWBNxirGlW2QqzuDP3kfdK1Rfs7
         Ancw==
X-Forwarded-Encrypted: i=1; AJvYcCViTWwwo40S6G5QRTsqQcmdF75bu7qP+1mLvUqtdJU3NjLSTfjVWOfDhf3IObf5rHzUCOvabGSW1OXlKrA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBh+8+MbcVmI2Sj3tzquOXq37meBp86JS4SEe5r2Bpjs2sQlIC
	hD2OM/r9uPPJHJuYw+R+BA1U+OO8HDUiiXHytwZXeaPOg89cO0Z5oTT9RTIP//jHqP73RWA/Lne
	kQ8pr/o+lurMVFYhYd0VPpvXKxEhb3NWXtwPjb9V6+/1yJmyTPbHt3zDV0zrbqpMlmw==
X-Gm-Gg: ASbGnctR9UVyVCkwXSiJC5Aj9BOdCFTbnvXVt2M27aAsDf+a+ZUtVvoFQsdNr+nfu8R
	Fnd1usYnyl7swBPllKjzPFS5+9FAS5pfRfbCQwnBlpIahWSUcGAmYZzK5f8BcG3YD+jdTA4N0qW
	NVec/imWcB53vrD7gdTl0jR/ARnLdzJYDWfTiFWS7oqPqIyWy0Dzlu8yVkMOh6lWF9mTDuhHIcp
	aPRVwqJ57Zu8rW+MiPt8kyCVf/GD72RabfQA0ahEP50pM16J6mOvNN17Wpf9ukV/ErePuKwiUpM
	B7J4XAB9hm4gXIO7wQF3wyjc8ryeWa78KvdXEDGzV6S1MRt0py5Oopw9RhjEUBctOnHxUA==
X-Received: by 2002:a17:903:1a0b:b0:290:b14c:4f37 with SMTP id d9443c01a7336-290cb9475cfmr2113335ad.30.1760625574007;
        Thu, 16 Oct 2025 07:39:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoR3sOX166Tcf7MLH16gWKdUAYv0AI7cWSg6pn0j1tfmbyKX2QRAiCoA7ig0qK9oVKh4us1Q==
X-Received: by 2002:a17:903:1a0b:b0:290:b14c:4f37 with SMTP id d9443c01a7336-290cb9475cfmr2112865ad.30.1760625573497;
        Thu, 16 Oct 2025 07:39:33 -0700 (PDT)
Received: from zeus ([2405:6580:83a0:7600:6e93:a15a:9134:ae1f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099a7cec6sm32751745ad.55.2025.10.16.07.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 07:39:32 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:39:28 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, dakr@kernel.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH rust-next v2 0/3] rust: miscdevice: add llseek support
Message-ID: <aPEDoAXCqGxwPM5D@zeus>
References: <20251015040246.151141-1-ryasuoka@redhat.com>
 <2025101544-stopper-rifling-00e0@gregkh>
 <aPDGxz04OQgzRQqL@zeus>
 <2025101610-detention-dangle-cef6@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101610-detention-dangle-cef6@gregkh>

On Thu, Oct 16, 2025 at 01:24:12PM +0200, Greg KH wrote:
> On Thu, Oct 16, 2025 at 07:19:51PM +0900, Ryosuke Yasuoka wrote:
> > On Wed, Oct 15, 2025 at 07:40:12AM +0200, Greg KH wrote:
> > > On Wed, Oct 15, 2025 at 01:02:40PM +0900, Ryosuke Yasuoka wrote:
> > > > Hi all,
> > > > 
> > > > This patch series add support for the llseek file operation to misc
> > > > devices written in Rust.
> > > 
> > > Cool, but what miscdevice driver needs llseek support?  Do you have a
> > > real user for this that we can see as well?
> > 
> > Currently no. Because lseek is one of fundamental functions for device
> > driver, I think it's valuable to add support. I believe we'll have real
> > users based on read, write, and this lseek support.
> 
> Char devices that use lseek are "odd", don't you agree?  There are no
> such current users under drivers/misc/ and only a rare few under
> drivers/char/ (the huge user of that is mem.c but we aren't going to be
> reimplementing that in rust any time soon...)
> 
> So without a real user of this api, I suggest we hold-off on adding it.
> Let's not add it until someone comes up with a very valid reason for it.

Thank you for your review and clear explanation.

I understand your point. It makes sense not to add this without real
user. I'll hold off on this and will revisit it if a concrete use case
emerges.

Best regards,
Ryosuke

> thanks,
> 
> greg k-h
> 


