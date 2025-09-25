Return-Path: <linux-kernel+bounces-832463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 449F2B9F62D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A204F4E2574
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17CF1E3DCD;
	Thu, 25 Sep 2025 12:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Aj9J+Xks"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789A710A1E;
	Thu, 25 Sep 2025 12:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758805146; cv=pass; b=CRzsQV9s5GF8FwN9f9XyGy0OZteTIrFtbliji8tg7QtuaTCqBVqu8NKadk6to0j+jao2GOOGEvxpe1Doe0WPtCz7UCcYxoLnMhNOk9cXN5c+sgZlCNJ+1BnOFeHUT1GW8jkCAKKDEs9B6RZo5ZmZxdnyABxSHVpSRRzLqYVFmgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758805146; c=relaxed/simple;
	bh=pe7uLpLfrv8qZmxrWSyaDUw3DPQQ5kwO99XSS/bG4ag=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NjGaySvecrZ4o/jjkXXz+flFHw6eInBto6wz+amUQX+dbQWono4mYjdn7zrvmhap2jMjw+Nj9x7IcR9VLqhb8zPeHqUBJv7MC1gK3DiRw8t9h8fLvxgJ2fba2EIR7+3lzsALwFWunpg5Oe1xrHexyhLr09ulevgWnW+IoPziUqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Aj9J+Xks; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1758805128; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=If21BxmUnzHXdMFSvlHZj1ai7WhNgtqkF0u9LVlX/GiaXlx0SwIqgi5gWbLimKeUsQsbZ8dGCXL7yCwdYtrY7SIRs/EZv2FW9QgIVyO4auHaIMjADV0mIAUhqwmsAWbAH9Q1aIRd/RP63J0Q0tFNqBlFcbrjjNfM23oYOVrBhqo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1758805128; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pe7uLpLfrv8qZmxrWSyaDUw3DPQQ5kwO99XSS/bG4ag=; 
	b=mzre+WLtB55nZG35e20x0Y80IBchEWZjLxPzrZgX7vVxyEEHKYnuOpc3Th3ThgnKKMic43XextV6vJM4Xt6wSLegbHGps8GSiR/D5etkDWj0AQOO6hR0+KKy3OVElgrJgu4mz9qMvnE6ORbBw9VH2anuJBn11976DPVyw7JZrE0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1758805128;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=pe7uLpLfrv8qZmxrWSyaDUw3DPQQ5kwO99XSS/bG4ag=;
	b=Aj9J+XksjTB0WAtT5Xg1c8zO09TG0u7YG6PUiPV2AiPyZaWgcKnndVipYpBrZkZ8
	nlDj1YEcyRsRgE+eAtLSIGzElR6nWywNz8qBLa8efKV5G8GE14sxG5/Ws3KN/mXiGjr
	GrIqmSGCA2PA52K2n5gk07mAJFaIsVoFzKgkJrtQ=
Received: by mx.zohomail.com with SMTPS id 1758805124843808.1481254020882;
	Thu, 25 Sep 2025 05:58:44 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 0/2] rust: usb: add initial USB abstractions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <2025092520-sharply-everyone-4a5d@gregkh>
Date: Thu, 25 Sep 2025 14:58:30 +0200
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
Message-Id: <DE1DF8C3-B4D6-4392-A4A7-E324CFDCCD3A@collabora.com>
References: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
 <2025092520-sharply-everyone-4a5d@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Greg,

> On 25 Sep 2025, at 14:52, Greg Kroah-Hartman =
<gregkh@linuxfoundation.org> wrote:
>=20
> On Mon, Aug 25, 2025 at 03:18:04PM -0300, Daniel Almeida wrote:
>> This adds initial support for USB Rust drivers, not only because I =
see a
>> widespread use of module_usb_driver() in media (which is a subsystem =
I
>> aim to support) but also because I want to learn about USB in general
>> and this is a nice opportunity to start doing so.
>>=20
>> I tried to keep things as consistent with pci.rs and platform.rs as
>> possible and tested it by manually binding a device (i.e.: my =
Logitech
>> mouse) to the sample driver via:
>>=20
>> /sys/bus/usb/drivers/rust_driver_usb/new_id
>>=20
>> This initial patch is therefore comprised of the same patterns that =
are
>> known to work for pci and platform already.
>>=20
>> Physically disconnecting the device also worked, i.e.: nothing bad
>> showed up in dmesg.
>>=20
>> Note that I did not touch MAINTAINERS at all. The objective is to
>> kickstart the discussion of what to do there here in v1.
>=20
> Ok, as this seems to now be at least building properly for me, I have
> taken it into my char-misc branch for the next -rc1 merge window.
>=20
> BUT it has shown that it still needs some work to get "correct" and it
> really doesn't do much quite yet, so I have applied the patch below to
> pretty much just "disable" it entirely from the build at this point in
> time.
>=20
> I'll go and revert this commit after -rc1 is out, in my usb-next =
branch,
> so that we can start to build on top of it and ensure that it doesn't
> break, but for 6.18, I don't think it's quite ready to be there.

Cool,

I=E2=80=99ll follow up with the fixes required, and slowly build the =
features
needed for usb-skeleton as we discussed.

Give me a couple of weeks though, I need to get myself out of conference
hell first :)

Btw, thanks for the reviews, Danilo!

=E2=80=94 Daniel=

