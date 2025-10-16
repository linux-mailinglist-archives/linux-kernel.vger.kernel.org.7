Return-Path: <linux-kernel+bounces-857049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85AA4BE5C4E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460C63AA102
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660DD2E6106;
	Thu, 16 Oct 2025 23:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kxi83S+L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3C226FDA9;
	Thu, 16 Oct 2025 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760656289; cv=none; b=ZV77yPz+P7jx7XmcGUvIyeyO4E980ZccAF0WfaLj2ACX9oH7nF5TPEPk/4t9oXQ8bUmgNrI3GViHTfmd3D+k3iNxFZplX6J4lFquGc3KO6ky3OCa5ws0g9zR8FSxXnnfXOCgfQ6WltkEIFx/FfJWgfmD2v72NCcyXGfj8bnkk30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760656289; c=relaxed/simple;
	bh=DhmOkJFUmVAYNN2dhznrvUOEoR1lqllzHqc00HdNTHY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=avlYiqNFfGoB59h60YcnVMMcY1LowPN2DG9gacYefGW26dqv9gVW2yaAwD3xi8k9pZdDhaSlNG+F3h6nuqDyswlPPnzbJ/iqonUZ8J7XN7X7Kt+gocrJqexiAVdVxyQFU0pIAwDJW0yJPeNFyUZBOuLUTTEISOAJOxhYgWp63yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kxi83S+L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0351EC4CEF1;
	Thu, 16 Oct 2025 23:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760656289;
	bh=DhmOkJFUmVAYNN2dhznrvUOEoR1lqllzHqc00HdNTHY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Kxi83S+Lgv8Hr7J61WS+2pdtWMAXY1zuvGuPEW1NW7TvZ3pVazoyfryIJ1lUWtAnz
	 CI8Nko+75+oNrEWPXWeiF9Y0FMB2HaGZcOoZgQSIBqd0c0w2KUalqdhr8qAfVsmLd0
	 HBcT3hY1hlMJYmxx94nXhEC1Z7ePFvMlpAApPYi0f4kLKgwWqAkV53jSbFnPRLeCRb
	 TB3fevVCWEVb4dTuzZoNjgpXH9TYWkohIda3SeV/dqaCF7oPrlBQu8xkaoby8AkEJa
	 OQxk/utu53CxUb/HB8fsTsc4jGWre5+iwWAKww4Xfga9rvDXxMjNTyCwYJ+Y+20D9U
	 As6a+PhaL38iQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 01:11:23 +0200
Message-Id: <DDK4KADWJHMG.1FUPL3SDR26XF@kernel.org>
Subject: Re: [PATCH v5 03/14] gpu: nova-core: gsp: Create wpr metadata
Cc: "Alexandre Courbot" <acourbot@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes" <joelagnelf@nvidia.com>,
 "Timur Tabi" <ttabi@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>
To: "Alistair Popple" <apopple@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251013062041.1639529-1-apopple@nvidia.com>
 <20251013062041.1639529-4-apopple@nvidia.com>
 <DDJJ4ECCSE2I.1EUAJRU9JBGNI@nvidia.com>
 <zwaefk62to77b5nyakeiboyj53fge3lysc3z7arp54tyyherdo@nsqhuig7bmbc>
In-Reply-To: <zwaefk62to77b5nyakeiboyj53fge3lysc3z7arp54tyyherdo@nsqhuig7bmbc>

On Fri Oct 17, 2025 at 1:03 AM CEST, Alistair Popple wrote:
> On 2025-10-16 at 17:23 +1100, Alexandre Courbot <acourbot@nvidia.com> wro=
te...
>> On Mon Oct 13, 2025 at 3:20 PM JST, Alistair Popple wrote:
>> > +impl GspFwWprMeta {
>> > +    pub(crate) fn new(gsp_firmware: &GspFirmware, fb_layout: &FbLayou=
t) -> Self {
>> > +        Self(bindings::GspFwWprMeta {
>> > +            magic: r570_144::GSP_FW_WPR_META_MAGIC as u64,
>> > +            revision: u64::from(r570_144::GSP_FW_WPR_META_REVISION),
>> > +            sysmemAddrOfRadix3Elf: gsp_firmware.radix3_dma_handle(),
>> > +            sizeOfRadix3Elf: gsp_firmware.size as u64,
>>=20
>> Very unfortunately I'm afraid we will need to replace the `as` in this
>> method with `u64::try_from` and make it return a `Result` for now.
>
> And presumably most of the other `as` keywords in this function dealing w=
ith
> usize as well? Have made the change but would you mind quickly explaining
> why this is needed? Is the concern that usize might be more than 64 bits =
or
> something?

Since nova-core depends on CONFIG_64BIT, I think we want a helper function =
that
converts usize to u64 infallibly.

This helper function can simply generate a compile time error, when
!CONFIG_64BIT, etc.

We can do this locally in nova-core, but it could also find it's place in t=
he
generic infrastructure. nova-core clearly won't be the last driver running =
into
this inconvinience.

