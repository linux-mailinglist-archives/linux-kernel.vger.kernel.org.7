Return-Path: <linux-kernel+bounces-750872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2BFB16216
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED12B7B43CD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EB52D9EEA;
	Wed, 30 Jul 2025 13:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="YnR/a8gj"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E742D97AA;
	Wed, 30 Jul 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753883847; cv=pass; b=WKSN4RMZnTyuxqFUks6MWtoa2zqSxM4dC6z+gYpkFQfBVtNN/+hOm6kqavc5SXZilAOUszRwQC5J9rLOaW+DwKpwWchMxsz5vB+io16y5ouPSznxyhHdqdNz5LcSO+vjaIDvGoBu8OdbFZAAX3SZJxaG3hctM/FUA9zJwSezzHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753883847; c=relaxed/simple;
	bh=/1Z0B86lIfaqQpoJGmWBnivyAyNad2J3d1f8p5NY6ew=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=g1TIPc2H1dYJPTC6w5N6t8E4pzrhfakYUIpuDeYQ1m850muuLwAnVFEhItV9VDgf4nFUjiEhoSc90umo5a5RPwNiqjUIvLqF6a3NQf0ypUyCKbeGOKkiAD0JujE8fsaZtR0mTZ9SGj+POJHY7ALCq2wDqeuD1LU1OG0ir1jmpLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=YnR/a8gj; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753883815; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZLiYjS3NO9RNSSID4MHQqwWKu2i6um9uJemRNiKCozfx5bbBiyCIun+qKGlUKR6x/pWVWHRyq0MjLPFO1IShS9K1IhmBOTY6xrt0USzf8JJM7W5ZlphCdNqpf33NL2oKq8jELpjnKGyTMRWV5yh0eNO6zgDWZ1ZU2531EyXYih4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753883815; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=/1Z0B86lIfaqQpoJGmWBnivyAyNad2J3d1f8p5NY6ew=; 
	b=lNTecuHWedTV0yOHGAOceTbaCly4NHPWnJs34+FgqVdPuuRx7hqPkmzbaL3QQQuQAc1hEy95MyphSUbceK5kixqPKiOaBn5GbaUSfIMwvsQ1Igx8dLtI7etytgr+WAVLo3HD6nA9oVAvfTKODdEiXDXJe+uKGouova2YoLHkxrY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753883815;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=/1Z0B86lIfaqQpoJGmWBnivyAyNad2J3d1f8p5NY6ew=;
	b=YnR/a8gjq+Hjp5hCY2bMW0gHUEkleJZxXu6ELOJgXVQT0ivi5HCV0wjKM0Cfl7/Q
	VykfymdVr56cCibViUsCi8NVVaeNUW35TXWRqtaW2CVPiZgrE7PguGeiX4OXh9wPz5k
	BBz+w15lXqrVc1/HAnXAT5YyXJ3rRDtJ6Y3jPZcQ=
Received: by mx.zohomail.com with SMTPS id 1753883811262351.39162426409564;
	Wed, 30 Jul 2025 06:56:51 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2] rust: update error.rs documentation
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250730120459.15607-1-work@onurozkan.dev>
Date: Wed, 30 Jul 2025 10:56:35 -0300
Cc: rust-for-linux@vger.kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 dakr@kernel.org,
 me@kloenk.dev,
 felipe_life@live.com,
 abdiel.janulgue@gmail.com,
 dirk.behme@de.bosch.com,
 daniel@sedlak.dev,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <69315F62-A882-4622-B967-CCE206013C41@collabora.com>
References: <20250730120459.15607-1-work@onurozkan.dev>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Onur,

> On 30 Jul 2025, at 09:04, Onur =C3=96zkan <work@onurozkan.dev> wrote:
>=20
> Adds missing header links.
>=20
> Signed-off-by: Onur =C3=96zkan <work@onurozkan.dev>

This is a v2 but there is no changelog.

Could you let us know what changed in future iterations, if any?

> ---
> rust/kernel/error.rs | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 3dee3139fcd4..dd3e4224218d 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -2,6 +2,8 @@
>=20
> //! Kernel errors.
> //!
> +//! C header: =
[`arch/mips/include/uapi/asm/errno.h`](srctree/arch/mips/include/uapi/asm/=
errno.h)

Why is this mips file being referenced here? :)

> +//! C header: =
[`include/linux/errno.h`](srctree/include/linux/errno.h)
> //! C header: =
[`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic=
/errno-base.h)
>=20
> use crate::{
> --
> 2.50.0
>=20
>=20

=E2=80=94 Daniel




