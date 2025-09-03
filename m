Return-Path: <linux-kernel+bounces-799479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C496B42C4D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 23:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9738B7B8E5A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A2F2BEC20;
	Wed,  3 Sep 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="DuzAzvK4"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3132E8E01;
	Wed,  3 Sep 2025 21:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936643; cv=pass; b=i8ileVPnCKIlIvfngIChE9sxOydbkb0Swj9SswmU4DlyAjSiVEIxEfo6PJkXBN6X5nAL1SyVliXtDt9T4ACSP24Or70CrkmMaOgwRea0fpmsbvm09LcMz275SqGtp3k8Af4PO3w+0L4I+GuR7O6l47UaD/qepUt8k4kkkEJUCyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936643; c=relaxed/simple;
	bh=eRSHk19O9P9uZz9jbqWTX9Uo09EOtyCrNtWCAMSYISk=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Pa+FdDyFuj1G7WmjwmXipuc+FVs+iENAKo6e1PuBJ+9NGd+4xEjNRdqsEPzAco8LMNvFYRZlHIie69YYz+OmsgRKp8VmGRs+vBMaJZMI4zgdTaOOI/2UlrUJsDq4RY+3Dfc/KliOThjoIMmvcoBH3/pFD2i+MVI5rg9ppXLFwsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=DuzAzvK4; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756936613; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=GM6nLjyZuteRAkN8U4nk4u1gh2FKLfMYsSMI7biJiaEucMgIFRquZunhe2tqEpVmJbdeCuWYXp1z1LZm4ufUfyB8Y+TggKdEzgTkqKklnLEeVmlOPhYbqLiFLMex4BsThLuefu7gHY9WgE+R9nYSts1HACcgQzLCTDG1z8i/OxE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756936613; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eRSHk19O9P9uZz9jbqWTX9Uo09EOtyCrNtWCAMSYISk=; 
	b=aVtFcIrN1vri+jfsDVMQTzLE9C320uJxGeVgi9B37mQDcBnYSFf+3AyOOXrQdJcxIAKzYJVezb6j1txchFW3D8mBgfG/my/5ywAEJ9m57ti+8Ly/BVGl+atiWq8Ub3FxpDu7YQ2buJgeIdWHIbvsqgMdypEPOaq82kjHv188t/U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756936613;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=eRSHk19O9P9uZz9jbqWTX9Uo09EOtyCrNtWCAMSYISk=;
	b=DuzAzvK44DyI2ix0R1iXUwaXHcislnnMs3w5olZ0Xs4ml7EK2KLYrdfraL4khiGk
	p29WX4r0AZif5qNTqnjc8ijTHS2rJNcr/cvItkth81u42dGh8YXWZQVuaUJvNzSUs46
	C6gQyk9D88C/DOez2utBOQOdQgoxUnAUvENS6U+s=
Received: by mx.zohomail.com with SMTPS id 1756936610577726.5474529471205;
	Wed, 3 Sep 2025 14:56:50 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 4/4] rust: Move register and bitstruct macros out of
 Nova
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250903215428.1296517-5-joelagnelf@nvidia.com>
Date: Wed, 3 Sep 2025 18:56:31 -0300
Cc: linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org,
 dakr@kernel.org,
 acourbot@nvidia.com,
 Alistair Popple <apopple@nvidia.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 bjorn3_gh@protonmail.com,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 John Hubbard <jhubbard@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>,
 joel@joelfernandes.org,
 Elle Rhumsaa <elle@weathered-steel.dev>,
 nouveau@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2B8C8645-206C-4BDD-8EE0-07E79A78E3F1@collabora.com>
References: <20250903215428.1296517-1-joelagnelf@nvidia.com>
 <20250903215428.1296517-5-joelagnelf@nvidia.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 3 Sep 2025, at 18:54, Joel Fernandes <joelagnelf@nvidia.com> wrote:
>=20
> Out of broad need for these macros in Rust, move them out. Several =
folks
> have shown interest (Nova, Tyr GPU drivers).
>=20
> bitstruct - defines bitfields in Rust structs similar to C.
> register - support for defining hardware registers and accessors.
>=20
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>

Thanks a lot Joel, I will pick this up on Tyr and let you know how it =
went.

Expect a Tested-by tag in the coming days.

=E2=80=94 Daniel=

