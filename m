Return-Path: <linux-kernel+bounces-730655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38048B047A6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A33B07AFD44
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1D4276058;
	Mon, 14 Jul 2025 18:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="QoqbvCKw"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D484225D6;
	Mon, 14 Jul 2025 18:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519598; cv=pass; b=ElsfNT4v26QMDL34KPvBBsX2njESquLfRPsr8R9Y4TJjDmpJdn0s7HhVqhArn/0hl8ouGhWCMyuEVebC6Co5J0l4ycigySrg3RsDFZXZspiAyVpxdVX9ZtJo+lrIyMrwLHccCv6jRDgk8+ICOqIxv11OLyhrEhLyma2GGURlqig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519598; c=relaxed/simple;
	bh=38mkXnq+GQi2cp1lObcn7RjfpS8eQBOP4ZN0QSiZR/E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UTL/QKfwQH2oBx7qC6fx6ObEL+FDvWe7rExVYfVs5uoqOs+TDak8lid5R/Gs+DHS8tNSU0zLR3S9CgMiooMT/mxQmfMtrRZOGUcQ0XqAQDyASE4hEtZX8DmesX13q5nVsPnqGGz65sx171EgwQEoAA2f20cX2AjdyYdDCpjhUkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=QoqbvCKw; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752519580; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hxs/i5XFPAyLTm2xAL+SWvivVdOgHG716PjBUfKetBVlHMEmoR0adKcPF0BtahvCsKSkIh9JstsSNVivtYEABchumS/2eCwQN5/GPZMT0VvocNsSvVaRnAoHZ4RKRV8l8y7j1lbw6md++YVZHRSksLE1M1a+nUdhK1gofVL1TFY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752519580; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=38mkXnq+GQi2cp1lObcn7RjfpS8eQBOP4ZN0QSiZR/E=; 
	b=NhycM1gm1jkd/h16kSc2EufNPLWhPvpLKYXTY/MdCo9NJNNGYaM/mTiaDajkscZBj6t0eIstnkJVrzkM6wgwzdPY+VaN+G57eyj7hym6LhmLnXHhWjQtt3S4kd9Cvizc8f9ZAst0MUmnWZyEoThbmRXWrm22C+Xvo4RaR26DS3I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752519580;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=38mkXnq+GQi2cp1lObcn7RjfpS8eQBOP4ZN0QSiZR/E=;
	b=QoqbvCKwwySEdzM5+mRD24dISOLWAUNeuzETVhcUKyGDS6XPW0wgOjnggDKj/L/y
	YoBjZ7cqkujfCTOq6bW/6GailjVNR7IY4e7W8omWVN4EXxviFwJkYrm2+9s/vT3ZvWS
	XICl1UPJAcnFfOJi91c/i4qgx7EIIZ7n1pVGFSzE=
Received: by mx.zohomail.com with SMTPS id 1752519579138441.8147836702417;
	Mon, 14 Jul 2025 11:59:39 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v8 0/2] Add a bare-minimum Regulator abstraction
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250714-topics-tyr-regulator2-v8-0-c7ab3955d524@collabora.com>
Date: Mon, 14 Jul 2025 15:59:23 -0300
Cc: linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 Alexandre Courbot <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A9FBBE84-DB81-4245-9FA9-8EEDBE391522@collabora.com>
References: <20250714-topics-tyr-regulator2-v8-0-c7ab3955d524@collabora.com>
To: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Mark, this looks like a good candidate for merging, how do you want to =
go about
this?

I believe that this should go through the regulator tree, but I guess it =
can go
through the Rust tree if you give your acked-by.

-- Daniel=

