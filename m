Return-Path: <linux-kernel+bounces-804215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86ACB46CF8
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 14:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67C76A46777
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 12:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965D62E9EC1;
	Sat,  6 Sep 2025 12:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="ktQDE/DP"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35334289E07;
	Sat,  6 Sep 2025 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757162513; cv=pass; b=nLuoQ8GlImy9K0z+Tmfi/mQntbWOwh6RNw+swGjurTlO/N1pczvzm2/sqLLA2ilTJtNTxJAb8AOa+lk43JWn8ytBY1jBIUx9aU7+oERz2j4+W9KakXmeR9vf7SDtR8GkWnB+PWOLDujPN3GHEjwDW+RP/5rFgSSNjpL4faNQosU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757162513; c=relaxed/simple;
	bh=+eqeUrynzQyETIKqPK5kWdB5I+zyHoqmenioXoReh5U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cp0kwl0PcczPeECAstCjloi2qksosTYksNbEf5UUcHmU1l10eMiOZ8z6WTRVdRe60rRwLtzsRrtE87+Zy+o+Cu2Azoph7V+YMYZ3WgshUdgiah+DZMLScf+jAgamQ5TgjjtsOsZmqbA2SF6bqpODW5+0tObthCiSijEzWvi3E+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=ktQDE/DP; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757162494; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=QOnfWk4m4j7fpjBWdqk0hMHsSHbVAlxZu1w7RVdhw6lt6oY0+BmBvJHwV+m3GL2+Y+w7i9CUm5CrviDIFj3S999aETwDWarETnLxA9sXNXQc2ZguWv/iutv093jKcBwHXPDLlsApc5VhBROGnuzzDs4jx3Dw9iK2NuOraa0j0kE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757162494; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vb8MLbau1tNKQMfwbKPgSSgl5gQ2XVqDf0CiTm+vxpA=; 
	b=NSjHh3RGtNul/0g7fkyh4fdMw18+UQo//Qak3ELI9OKoRuoGoxtyAPLTIrtgHJ7N7ApheFYWhRrcEHuPHWV/8xhqXulgCKCw23aqnh5aWzNNq92iGNR9SdsEzv8UKgHVB2c0Va+EVewKeo7okJKSmajjDuZhPyrIKuiPf/QzNv0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757162494;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=vb8MLbau1tNKQMfwbKPgSSgl5gQ2XVqDf0CiTm+vxpA=;
	b=ktQDE/DP8rnsRJQbqtCtTlK+WiT3gPXETnFSIFS4sqDG73Ebr3wz/QWUP30piBpO
	xjfY4A0nJ8cp+ODUh/wt6B+l68enxTdfzAr5v3NIrUmtbJ0itWPCSc3iOqLtB6pWAP6
	rV0j9cEE7L0cSCEp01ukCIYGTtbee61TLxN1UFGI=
Received: by mx.zohomail.com with SMTPS id 1757162492631331.60289813179213;
	Sat, 6 Sep 2025 05:41:32 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 2/2] samples: rust: add a USB driver sample
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <2025090601-iron-glitter-c77d@gregkh>
Date: Sat, 6 Sep 2025 09:41:16 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-usb@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <831C4AE2-6964-4699-9E74-E4B721B87B17@collabora.com>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <20250825-b4-usb-v1-2-7aa024de7ae8@collabora.com>
 <2025090618-smudgy-cringing-a7a4@gregkh>
 <D8EAF874-4FED-42EE-8FD8-E89B6CB0086A@collabora.com>
 <2025090601-iron-glitter-c77d@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



>>=20
>> I thought that an iterative approach would work here, i.e.: merge =
this, then
>> URBs, then more stuff, etc.
>=20
> Ah, that makes sense, I didn't realize you want that here.  What USB
> device do you want to write a rust driver for?  Are you going to need
> bindings to the usb major number, or is it going to talk to some other
> subsystem instead?
>=20
> Right now, these bindings don't really do anything USB specific at all
> except allow a driver to bind to a device.
>=20
> thanks,
>=20
> greg k-h

To be honest, I'm trying to pave the way for others.

I often hear people saying that they would look into Rust drivers if =
only they
did not have to write all the surrounding infrastructure themselves. On =
the
other hand, there is no infrastructure because there are no drivers. =
It's a
chicken and egg problem that I am trying to solve.

It's also a cool opportunity to learn about USB, but I don't have any =
plans
for a driver at the moment other than a instructional sample driver in =
Rust.

Give me a few more weeks and I'll come up with the code for the other =
things
you've pointed out.

By the way, I wonder how testing would work. I tested this by plugging =
in my
mouse and fiddling around with =
/sys/bus/usb/drivers/rust_driver_usb/new_id. I
am not sure how this is going to work once I start looking into data =
transfer
and etc. Perhaps there's a simple device out there that I should target? =
Or
maybe there's a way to "fake" a USB device that would work with the =
sample
driver for demonstration purposes.

-- Daniel=

