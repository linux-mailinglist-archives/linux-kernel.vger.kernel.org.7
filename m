Return-Path: <linux-kernel+bounces-738291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 668A6B0B6D0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D246D7AC761
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0B421CC71;
	Sun, 20 Jul 2025 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="V5yWvYoH"
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8141C33EC;
	Sun, 20 Jul 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753027086; cv=pass; b=FiWS8sgH8HA3TF7DHPzRgjiE4XMFDL5Pj9D3MlU3495M73ySHTl0O/5C8ehL3080MmGepEha8UPyQWlU5nrG3eWlmp7DqJ1V06dXd+r6c4kQwJw6NnC0K91WOSSiGjFvVnPtmqqv7x1g4YhBYLPR7MDePUF9JK20gdE8keS3bFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753027086; c=relaxed/simple;
	bh=C33JyrZ8qJl/+xZ7qldoQZL3cIHjbVwBfVLAKleuybE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=GB4Xb2J2BWKN9DmFa0Uot1RKoqeBGSxvgkadA8L6iJsam4j1YpFH74eLP5GFtFwgwGGmWWw5XEUsa4BGV/UFzo5J0uOsa9gAoG9NegfMGvbOb0jdCyOYdPfX03yWVmRmQu/H1f0rsIJzZDBqR9ORyhOTs3+wMemMA+TSRxAKm2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=V5yWvYoH; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753027071; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ayHo4Mk9uUuyrK0r3FEU1eAlHwEbDDYjq/FJryh5bW79phAqe4DPEnktRggxesdEGy/zvthr5/PVPJ5Lm8z3P4g/k/M6wBsfeH1AhcG9HNwiwjuJ9nPaO+tCLbMIoA/M/Hdr9h7mnCkM2piMnwTjPK6LFqeqzlYLzEb0gE7SBiI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753027071; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=C33JyrZ8qJl/+xZ7qldoQZL3cIHjbVwBfVLAKleuybE=; 
	b=SU1kAifHeiFe1vyer/8JdWxiFM0Kt7Mrh+VexNvbqM0tj0uSxLfElf5mMMkNlhVYgjCyAHHKFoiV0nEk05nSyk3JZaAuKFaEOf9/RjyUGZ3ZzvpmoO5eeLjAQ30MOXpPU0COG8Q1oXYaUu/1fBpwS2+prx0uJbNVB9LiKwb587U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753027071;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=C33JyrZ8qJl/+xZ7qldoQZL3cIHjbVwBfVLAKleuybE=;
	b=V5yWvYoHSK8s9KVaybq4OaO5hYKkauI3avvWWeDKLNhqoq953LPjm3H8OMWW9K4b
	Q2DasfGpwR5hg2SAm3exaQoF00p09ozh5EcZ1ftYVC1eQUuDhGca1BSLzYLkM5CwA4z
	uF5zaUVh/hFzm8YkR5ld2m9Y11Z3mIIt5BZKutRY=
Received: by mx.zohomail.com with SMTPS id 1753027069575217.87290204128726;
	Sun, 20 Jul 2025 08:57:49 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 3/3] driver: rust: expand documentation for driver
 infrastructure
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250717224806.54763-4-dakr@kernel.org>
Date: Sun, 20 Jul 2025 12:57:33 -0300
Cc: gregkh@linuxfoundation.org,
 rafael@kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 bjorn3_gh@protonmail.com,
 lossin@kernel.org,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5A1A13D0-9990-41F2-9F3F-280A126512A1@collabora.com>
References: <20250717224806.54763-1-dakr@kernel.org>
 <20250717224806.54763-4-dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

This also looks good to me.

> On 17 Jul 2025, at 19:45, Danilo Krummrich <dakr@kernel.org> wrote:
>=20
> Add documentation about generic driver infrastructure, representing a
> guideline on how the generic driver infrastructure is intended to be
> used to implement bus specific driver APIs.
>=20
> This covers aspects such as the bus specific driver trait, adapter
> implementation, driver registration and custom device ID types.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

=E2=80=94 Daniel=

