Return-Path: <linux-kernel+bounces-845323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F1CBC46ED
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 12:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E829188C058
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 10:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598532F6178;
	Wed,  8 Oct 2025 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="T9ihapaF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jm0Y3uQH"
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541912F60AD;
	Wed,  8 Oct 2025 10:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759920434; cv=none; b=u4r7fx1/QLWThAaQ5qmUtmWEw02pbimLDICiPq+kvcolhQP1sxoN9ceArYAPNF5GHWeUHmnK8XxtM+mbeRTk3nuRfihGx16/lLphu8IbzJFX6NWntJIUHseT3P3Ri2/Z3K1Oz8DvyuZrh8RY8yKX/508S2++Rx++f0yQZ+rYAQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759920434; c=relaxed/simple;
	bh=zeBFuoiMP111c2JRQQR6i6BXLXgsed7WGl2Grlpaed0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLQ6XFxWpym+YrOCNdVAQi48po/WP+cY73c22Enq1AlUlkMNEgaeLLCdfSLP5lcBzJZAGy/fauzd1ffp4Svw+j4lS0at5o8piMabpKCxyrO19UxV1sDd7NJInHABwsbb7PHR53IAsuo+imtrX9z0VFwkud5DjBgMH/BHxvFNFQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=T9ihapaF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jm0Y3uQH; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 4804613801F3;
	Wed,  8 Oct 2025 06:47:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 08 Oct 2025 06:47:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759920430; x=1759927630; bh=KodlDpmgfd
	X2u40mEiJbkv3Ym8M9RKnA7qbONd4olzE=; b=T9ihapaFrBFuoNcy7SFER+1K0q
	LHqIui2qpBKHuyGRIYPlI3RsM1km+jzO2Kh5zgUvou7k6JrZZCVtW5ou0gVOQC+P
	kjS170htgm4KMAXqvUDXr2d6RoYFsK9SDwqA7yGQLJQr85TSjiCZeDhorteKMXhW
	SWl2+BWBwIDJ+/rdm6Wx3eOFv9dCEcSJr0qoqGBA1YCmAm7j79nDCok1/MF6dHoS
	LKdUUrnUZ2Vz78KMlIVV8tOxJfwddwxj0dzjKZj8iiEy2NrfEeG7rkYtXpIXcDqV
	GtRwwQJn+eSJ1K54Njxe1hcbGE8x0kvMQN3mJU8vVLZ+AS5EoBIKQZoaYbhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759920430; x=1759927630; bh=KodlDpmgfdX2u40mEiJbkv3Ym8M9RKnA7qb
	ONd4olzE=; b=jm0Y3uQHebcIFICXNQ2+s/gyPQ1Fal0dXHaTv2jNga2iKWbAZtX
	AlF5nPjbt9nfqOCfxKyNxr3Z79bWoAY6+YjjK7vwEb7ebHo4LtA2cquP4omW8CnA
	rbnZwAkWVMVaYOqma3U0Rrcq+LDvYgXekiQ9QEKHUIe9GXFXMxmpwns+ky8v0zsi
	y+0lAL4/BSyhz6AmXZzMYlQksJHe+c8LyT0X+dc6mwrJRuG68GSdOw8PpAnsmYjM
	ZYYY61z3UHe53BP1kyJyUhP4RD6D/jL8BLPdw2HrjmTy6nJD73uto2gwQ9o3gtyN
	+v6fkTYxeY0icBH3ZDIMSufb3fRKpJxyxCw==
X-ME-Sender: <xms:LUHmaO5X62s-G3c_2_hisaMjNwilA8ldv9WWRcBGUO2aNLXCWghUNQ>
    <xme:LUHmaFfZIcuqwZgX2OuSxV0Xgn0FotxNOW990p3mZL4y7niKK4aJvK64DMy_y3x9X
    R5nz8-MuOcH5SrOy_29HIRHQLWhxpw_clZXi-eNbPBy9oCKUQ>
X-ME-Received: <xmr:LUHmaGesQ4KpOhlAVa2CA5SPoiiVmgDv3aepNuMMizBAwTD8MWoADYQf-6M6qyrkNDi9M-tkU6PbPLRxGH0sz4U2p-PWeIzRw63mbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghgucfm
    jfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepgfejjefhje
    ffieevjeeuveegledtheefjeevffevhffftefgtdfhjeefleejheetnecuffhomhgrihhn
    pehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtohhmpdhnsggprhgtphhtthho
    peehkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgtohhmpdhr
    tghpthhtoheprggtohhurhgsohhtsehnvhhiughirgdrtghomhdprhgtphhtthhopeihuh
    hrhidrnhhorhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorh
    dqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurhhiqdgu
    vghvvghlsehlihhsthhsrdhfrhgvvgguvghskhhtohhprdhorhhgpdhrtghpthhtoheprg
    hpohhpphhlvgesnhhvihguihgrrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:LUHmaGDOywgI6IcKUOsyKHV9KDLCIXAw0wBxxvVhxeSzeBLofaFWuw>
    <xmx:LUHmaMkxxlwWQ2LDk_2QfAmCsFnq7sfC_1GakeNzJg4RkfFYAfQwAA>
    <xmx:LUHmaC_PBvKESOKj888waQ-abh5Fk2MgCU3swJME0mxJXBDfBekiBw>
    <xmx:LUHmaM9H9q_26icMYoRuM24GbDROwzUCdA4_OLb8kRP8MvpOmDIcMw>
    <xmx:LkHmaK_X7I47nfM_zLbe0I6OCLk4Aznxs-PFqy01kte5KzhJ89kvuE7M>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 06:47:08 -0400 (EDT)
Date: Wed, 8 Oct 2025 12:47:06 +0200
From: Greg KH <greg@kroah.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	Alistair Popple <apopple@nvidia.com>,	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,	Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
	"bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	John Hubbard <jhubbard@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
	"joel@joelfernandes.org" <joel@joelfernandes.org>,
	Elle Rhumsaa <elle@weathered-steel.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Andrea Righi <arighi@nvidia.com>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>
Subject: Re: [PATCH v6 0/5] Introduce bitfield and move register macro to
 rust/kernel/
Message-ID: <2025100808-unpadded-unsubtle-1053@gregkh>
References: <695CCDCE-A205-4557-AA15-6F102B8CCF0C@nvidia.com>
 <DDCV84IJHUML.126CB1CT0XMX5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDCV84IJHUML.126CB1CT0XMX5@kernel.org>

On Wed, Oct 08, 2025 at 12:23:40PM +0200, Danilo Krummrich wrote:
> On Wed Oct 8, 2025 at 1:37 AM CEST, Joel Fernandes wrote:
> > The Nvidia GPU architecture is little-endian (including MMU structures in VRAM).
> 
> Yes, I'm aware (and I'd assume that there is no reason to ever change that).
> 
> Just for the complete picture, there's also some endianness switch in the
> NV_PMC_BOOT_1 register I think?
> 
> > All the CPU architectures our drivers support are expected to be little-endian.
> 
> Technically, all Rust supported architectures are indeed little-endian.

s390x is supported by rust as a tier2 output:
	https://doc.rust-lang.org/beta/rustc/platform-support/s390x-unknown-linux-gnu.html

so there really shouldn't be any reason why that platform couldn't add
rust support today, right?

thanks,

greg k-h

