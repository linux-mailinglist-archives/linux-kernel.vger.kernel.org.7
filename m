Return-Path: <linux-kernel+bounces-879281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3F2C22BC7
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 00:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B31323AAA24
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 23:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457C333F39A;
	Thu, 30 Oct 2025 23:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ZEwa7ojE"
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A7133E355
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761867772; cv=none; b=tZzUXfW47efeR1WTVzjyRMnp4HyyoSUh4ihUrBMfVMg3WNPR6yLm6FgFZl0YtVR5gdX80St6x+diw+uVBJU9a0KpiV2O74SviKgmA3Xqq8TJbd+U/hzHbEoAtOKAsFQhcNgCB6MJ/afxCjKk0Xnzb3XKEntMzP1B9aVJ8mo2lGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761867772; c=relaxed/simple;
	bh=nkfYFXJwYLkDxQAM+J3yvHwlLGq7CnLEUoPw1DWa5F0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=JQLC2zVHQH4tWxwzj0X3v2S6C4yeuMcvGLlpV83+DYMMfo3ufZ+a5vmeS4L6xW7EDF9Q34WXvYy9WkLX0Rb9I7MLkHfmucZpoay1DubqW4znEVb7q1/jYxisI0zHQZUJPFetTE8QCbWJ9+zL7c8O7Q5jsfdikrU05rji5fBb5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ZEwa7ojE; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
X-KPN-MessageId: 52d8f39b-b5ea-11f0-9e68-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 52d8f39b-b5ea-11f0-9e68-005056994fde;
	Fri, 31 Oct 2025 00:44:06 +0100 (CET)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 24468cc8-b5ea-11f0-99be-0050569977a2;
	Fri, 31 Oct 2025 00:42:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=YNH9qr385z7prnfO/J9QCbJW8LGnn4eD5DHAOV/HtOw=;
	b=ZEwa7ojE+tGwtpEzT0VX9ENZC+6JWG00tQKIFHqN3lHx/OG6PJVKGj77SqoXZupG/i4TVOEawxR8v
	 GdXvviK3StbOuNhKuU011ERN6sZeBSq3imfOL1BIrSJ5U1us+h9z0AW1d29xrNe6Tl8uxnidLwF0pT
	 1uc5GdfskejpcR2LYQhodTUtdXPBBDCBeuvuMCTgc10I5n/tSWzWPJlCON+Are3uhi4pQbAf0QYx4c
	 xfIFwS4buIrr4VPlCGtU8fbW3Lw0f6LbxsmbJIlQp5Y8Re6wzzIJVBd0r1xDfmertUAN9WStR1Ond7
	 GmCnh5fdNDQEX8apq8EYTXulTDM59Nw==
X-KPN-MID: 33|KzXuCSdk2oQCotu/rg9R75nPeYijkUWpv5rYNvsrlM9t6tTXAAdNk06gOX+E3RF
 PG90DfV4X+ZwJ/NCON7xKZvbKFDCZl0E6V0+7erKGNaE=
X-CMASSUN: 33|SPMP6fo5NCWd0iqNF86h/IGpzJ8RFWiRG4QMLJClWpjo6j0fn5M1YfrlIEzCgDr
 T9bxrp2E1DSnaImp+Aptr2Q==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 243ede69-b5ea-11f0-b8d7-005056995d6c;
	Fri, 31 Oct 2025 00:42:48 +0100 (CET)
Date: Fri, 31 Oct 2025 00:42:48 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
	Khalid Aziz <khalid@kernel.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Taotao Chen <chentaotao@didiglobal.com>, NeilBrown <neil@brown.name>,
	linux-kernel@vger.kernel.org,
	syzbot+4e49728ec1cbaf3b91d2@syzkaller.appspotmail.com
Message-ID: <1767594126.3216238.1761867768351@kpc.webmail.kpnmail.nl>
In-Reply-To: <tnofelm75pbsccdkulwpq7lkfz6wjmg4acrrvinkn6zzrkdxqi@dppnd4fge2tu>
References: <20251028205857.386719-1-jkoolstra@xs4all.nl>
 <su4qka5wugz3asm3sakmptgeeogx6duj6kc7doom5r4fhdwdcv@ogp4lz5gxn7x>
 <792975039.3142581.1761826973320@kpc.webmail.kpnmail.nl>
 <1697efab0661c4c80831544f84c9e520f33962e7.camel@kernel.org>
 <1979215152.3123282.1761831106100@kpc.webmail.kpnmail.nl>
 <a2954b90bda141e71da6a4aeb4767d4821abad03.camel@kernel.org>
 <90143686.3161766.1761833369803@kpc.webmail.kpnmail.nl>
 <1ed30710481dd6739e6e9b4bd6f57c7c9d7e7de3.camel@kernel.org>
 <tnofelm75pbsccdkulwpq7lkfz6wjmg4acrrvinkn6zzrkdxqi@dppnd4fge2tu>
Subject: Re: [PATCH] Add error handling to minix filesystem similar to ext4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> 
> Yes, I kind of like that idea too. I think we could maybe take the existing
> in-kernel minix driver and morph it into a FUSE driver which would deal
> with the licensing as well.
> 

By now I am quite comfortable with the in-kernel implementation as it exists.
The parts that I understand less are about how exactly the data from the
device ends up in the right place in memory and how address_space and folios
are built up for it. But these are precisely the parts that are not too
relevant for a userspace driver. So, I would be very happy to work on a GPL
FUSE driver for minix and get it to functional parity for all versions v1-v3.
After that, and when all the available tests run well, we can start the
deprecation process.

I think this would be a great opportunity for me to learn and contribute
something non-trivial, but that is still within my current level of ability.
Shuah has also encouraged me to proceed on this track. However, since this
is more than a couple of days work for me (for one I have to study the FUSE
API), it would be helpful if I can get a sense of whether there is a
reasonable chance for such work to be eventually included upstream. Of
course, only IF it functions according to the criteria set out. I am not
looking for guarantees, because I understand that is not how Linux
development works, but just a sense of how the community feels about this.
So far I have seen quite favorable responses, but I am too unfamiliar with
the development process to understand how this may play out.

Thanks again Jan and Jeff for your patient replies.

Jori

