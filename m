Return-Path: <linux-kernel+bounces-745870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EACBB11FD5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 16:12:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40AE017F7DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 14:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F9D2441A0;
	Fri, 25 Jul 2025 14:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="DuaQElRh"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B35224113D;
	Fri, 25 Jul 2025 14:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753452728; cv=pass; b=TENbaD72a1K3+iBX1H3yuG/X+Sbubrk1C/DpK5rBL0FEaoZvwtpVWT4m2akO00uSSpvOQuSIdwBWgw4rn5BLh2DdoKecWnCYW0T6o+4MH+guUR/Apit60kJ4LFG4yI3BIVb9EATmLTZA5n6qtsT/+89Vqk2bFPBQUcceI8J4KFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753452728; c=relaxed/simple;
	bh=YeTj+YW6w9bQywA5OZClqs+uucHXH7cd3EgxRqxiGJ4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=lu/XXCc9v4WDY8bVFfrfG3/mzmeK2Jtoe4xgD/4enzKOcRfY2jrfHJdMm2gevitk1BLN+uCUNjio73smEVPYA7PELGNZ1PdIx4QDkWO/k69Cop2E5GD4AWXcDFOhX7VhDasLwqoFuy0O+CfbtxptCo5ueNyb7OunAQfCY31IGGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=DuaQElRh; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753452687; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=oJHxeyhUFkNnA+kTj4JHoa0RjBusxedCEUJL71oIOuhmyFImzC4qeYwrt3Vc2rkIq1o0QYfuGhX+5RoM7+C73kXVtz/snh/YLGbuDGnw1NIUPlkSBr+jEmyoDwILs/Xptld051AwxyVRKpmcKioOGdkSwE8DCBJwzQtjtH3LNjU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753452687; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=b6vZSmaipPpaQ40c+a24U3D4pklSo6qkSSQtDCDRTxY=; 
	b=S0aREpd6FGA20JDu+dF/EhoTMLi2WJRM02ZmypP0J3Pxq7YIst96eQVY473eF/UfXXYW8SaIH7LKbpRMj5sV3fzmNFANKIB05fcNO4prvRayLfgvHyJ3zDUMQNLjE+Z+ksHOuorcEbRm1aMX93F5IFxTGstbncqAWgX7EkI9MdA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753452687;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=b6vZSmaipPpaQ40c+a24U3D4pklSo6qkSSQtDCDRTxY=;
	b=DuaQElRhSGHQ12DpxRWXX5zRiXNznOpuhA1VQQbszUjzXtWPfFbRyqiOgmty1d7l
	xpjHliC6y/vdOcridgquAWKrS5SvrjZf1eCFHLeitOlHwYEce1TSn2HkIbdNuykFNwp
	z7n2karj2i3SWgplDNsUng7I/UGf0eE/AsWJ8q+E=
Received: by mx.zohomail.com with SMTPS id 1753452684492985.4734408640252;
	Fri, 25 Jul 2025 07:11:24 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v6 0/7] rust/hrtimer: Various hrtimer + time additions
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250724185236.556482-1-lyude@redhat.com>
Date: Fri, 25 Jul 2025 11:11:09 -0300
Cc: rust-for-linux@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org,
 Andreas Hindborg <a.hindborg@kernel.org>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <71C2DE74-1BB7-4AC0-83BD-2CC8B871B078@collabora.com>
References: <20250724185236.556482-1-lyude@redhat.com>
To: Lyude Paul <lyude@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Lyude,

> On 24 Jul 2025, at 15:49, Lyude Paul <lyude@redhat.com> wrote:
>=20
> This is a collection of various bindings that I added to hrtimer when =
I
> was originally getting it ready to be used in rvkms. I've mostly been
> waiting for Andreas's hrtimer series to go upstream before submitting
> these.
>=20
> All of these are currently being used within rvkms for vblank =
emulation.
>=20
> Previous versions:
>  Version 1: https://lkml.org/lkml/2025/4/2/1474
>  Version 2: https://lkml.org/lkml/2025/4/15/1750
>  Version 3 (only a revision of one patch): =
https://lkml.org/lkml/2025/4/15/1780
>  Version 4: https://lkml.org/lkml/2025/4/29/1715
>  Version 5: https://lkml.org/lkml/2025/6/13/1785
>=20
> Usage example:
> (keep in mind, I haven't rebased the example entirely - but the only
>  differences there is a few comments)
>=20
>  =
https://gitlab.freedesktop.org/lyudess/linux/-/tree/rvkms-slim/rust/kernel=
?ref_type=3Dheads
>=20
> Lyude Paul (7):
>  rust: hrtimer: Document the return value for HrTimerHandle::cancel()
>  rust: hrtimer: Add HrTimerInstant
>  rust: hrtimer: Add HrTimer::raw_forward() and forward()
>  rust: hrtimer: Add HrTimerCallbackContext and ::forward()
>  rust: hrtimer: Add forward_now() to HrTimer and =
HrTimerCallbackContext
>  rust: time: Add Instant::from_nanos()
>  rust: hrtimer: Add HrTimer::expires()
>=20
> rust/kernel/time.rs                 |  22 ++++
> rust/kernel/time/hrtimer.rs         | 152 +++++++++++++++++++++++++++-
> rust/kernel/time/hrtimer/arc.rs     |   9 +-
> rust/kernel/time/hrtimer/pin.rs     |   9 +-
> rust/kernel/time/hrtimer/pin_mut.rs |  12 ++-
> rust/kernel/time/hrtimer/tbox.rs    |   9 +-
> 6 files changed, 204 insertions(+), 9 deletions(-)
>=20
>=20
> base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
> --=20
> 2.50.0
>=20
>=20


Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

A few very minor nits will follow.

=E2=80=94 Daniel


