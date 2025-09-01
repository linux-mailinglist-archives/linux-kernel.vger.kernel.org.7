Return-Path: <linux-kernel+bounces-794541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B794CB3E30A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E5E16F7B0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0092A3431F8;
	Mon,  1 Sep 2025 12:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="dWXv28ky"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2300833EAEA;
	Mon,  1 Sep 2025 12:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729790; cv=pass; b=t9DYDBe3GPwjmBQcTYsSyvWx9H2Ge8chhmnJVtLasiD5BjPR6FfWl4vL2pP+LmT5pln2ImlaN4anhUatLHve+s7cSYXWYlHHz5qKTjXo9WCuk2O/Mucx31VvnSkiu7zMOf/bXZL4XaIphmzv6NK38pRzYrkgS4c5BU2LJXqWS8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729790; c=relaxed/simple;
	bh=h8hniokqQ25rxbar5awSPBoUt0GLx5mZgOWctI2hRjE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Yr3GwG4adCv7cFy1nuzOFvlQ8yhlsquFgxib7YfsMR6QyIjQDxvJHV2Ucfz5Qq97EqWbT9pmfeaZpyOOjIlcS5oJvy62XOcSgo4BIzNotJO4Nsjyce/vnA07Dk9U7GZAjbijyrlSbaipf/lAMKGDuJb6Wv8jYNBRMvwBKnSwffE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=dWXv28ky; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756729754; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Z3aKpyKDqfxKrfWeDRBk1GxjNk/eN9j/s6Bi50tnQVCIBAnt++NR8PNReAo5kNLcnJN4/UHBu+sZGzNaJQ3Up/42+bKWuCX4tYD48or6h/zJeyRRwwma5LZ+OLP3GSPVfSWQpNOynVgg/jbilJCB5BxMcyId90LPrX3mZaDM0w8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756729754; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XY7DtFoMUvZIhJ48QUbI65xkpXr06MMQAtbKMR4MNcs=; 
	b=Qtj3tS/XaNhUc6JYnptH30LD9idyg/+a7Cc+XnMceylxRjbRWzucaDkb9FCnNHf74uQ1wTyo76zd+sJ3cOcBzBKvVtbh3D6DpRE+qqc0LQX18wtjVuZPpZikhrBNVDXasJ4ou2dm+25xD38u8vXknMTv8GpHMhj83MLraPo0pIM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756729754;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=XY7DtFoMUvZIhJ48QUbI65xkpXr06MMQAtbKMR4MNcs=;
	b=dWXv28kypEru0Rcy6xrba+p8D/nsQkXdRfPEo8/G/FPx2qzUhElBBuo5MxM6+hsW
	JmM19wNJTCe0TIY9oVohTjyE2wH0XiG2ZkAxV1+NwoJ4fRuS+KJBPHZUXLWl+J1YtSt
	tkY7ecSSaLgpQA9jiUStBOPHscNDV9wsc7hHTIQE=
Received: by mx.zohomail.com with SMTPS id 1756729751046231.62047757400296;
	Mon, 1 Sep 2025 05:29:11 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v5 0/3] rust: add `ww_mutex` support
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250901130542.32b051bc@nimda.home>
Date: Mon, 1 Sep 2025 09:28:53 -0300
Cc: Benno Lossin <lossin@kernel.org>,
 Lyude Paul <lyude@redhat.com>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 ojeda@kernel.org,
 alex.gaynor@gmail.com,
 boqun.feng@gmail.com,
 gary@garyguo.net,
 a.hindborg@kernel.org,
 aliceryhl@google.com,
 tmgross@umich.edu,
 dakr@kernel.org,
 peterz@infradead.org,
 mingo@redhat.com,
 will@kernel.org,
 longman@redhat.com,
 felipe_life@live.com,
 daniel@sedlak.dev,
 bjorn3_gh@protonmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <F833F678-85FD-4674-B8A8-9AC9AF0746C1@collabora.com>
References: <20250621184454.8354-1-work@onurozkan.dev>
 <20250724165351.509cff53@nimda.home>
 <ec32fc5f5a8658c084f96540bd41f5462fa5c182.camel@gmail.com>
 <20250806085702.5bf600a3@nimda.home>
 <539d3e0da773c32a42b4ab5c9d4aa90383481ff6.camel@redhat.com>
 <DBVLEGFYBWKE.2RW8J853CJHTY@kernel.org> <20250814141302.1eabda12@nimda.home>
 <76D4D052-79B6-4D3F-AAA1-164FF7A41284@collabora.com>
 <20250814185622.468aad30@nimda.home>
 <182E916F-3B59-4721-B415-81C3CF175DA7@collabora.com>
 <20250818155628.1b39d511@nimda.home> <20250901130542.32b051bc@nimda.home>
To: =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External

Hi Onur,

> Hi,
>=20
> How should the modules be structured? I am thinking something like:
>=20
>    rust/kernel/sync/lock/ww_mutex/mod.rs
>    rust/kernel/sync/lock/ww_mutex/core.rs
>    rust/kernel/sync/lock/ww_mutex/ww_exec.rs
>=20
> In core, I would include only the essential parts (e.g., wrapper types
> and associated functions) and in ww_exec, I would provide a =
higher-level
> API similar to drm_exec (more idiomatic rusty version).
>=20
> Does this make sense?
>=20
>=20
> -Onur

That works, but let's not use the name "ww_exec". We don't need the "ww" =
prefix
given the locking hierarchy. I think it's fine to keep the "exec" =
nomenclature
for now, but someone else will probably chime in with a better name in =
the
future.


