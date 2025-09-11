Return-Path: <linux-kernel+bounces-812259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4D5B53528
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 16:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39CEA5A4358
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 14:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB36326D53;
	Thu, 11 Sep 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zy6KhP1F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34801314A8D;
	Thu, 11 Sep 2025 14:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757600537; cv=none; b=OeDTDVJOJRHY3+YtxZVHlF4TsNAHYBsvKcwAYbn36UbnYCu6tKGKrnhzYvOEqCZ1tC8p4hhr7S4PLBC47oyCXnkFhnedhWvJcFI8b/U2W31l73JHTmsoQ7wYS+G3dbTxa/plNklTNXc67vOga0oEqJv0qL0lH2mlN1OuptL1i60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757600537; c=relaxed/simple;
	bh=QDhJAvOCsdIistqI6MMfn2o6fnfPXYWO+sHhpw1GRlc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Z2bz9h21NLS58W14eDWZxap049XTBOGtmtSIg64J+oe2eKHYI8ZP9sdn/QG1j8yzBtm257RZNqhL4ZHbtZvJ/KoDjDPlgxgYPcjL3kTMIbJRhwaN7UnR/SUlCdqz9KEIVLPoYheMIeADKHg50VbrZROZlA/imknZpN2fIwKhPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zy6KhP1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66722C4CEF0;
	Thu, 11 Sep 2025 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757600537;
	bh=QDhJAvOCsdIistqI6MMfn2o6fnfPXYWO+sHhpw1GRlc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Zy6KhP1FnUJTnzjCHupiTfOJwHSAYTIDPqfAwBq8VYvdzx1OXLc18f56+UCnfxQD9
	 XGwy+ZmE9vqRsAKOiobewyrq+pscXpqdpCCwAx++nKOHqzTuUILVFAAP9ZW6Vvucca
	 Lj0zqKc1ikv4Vl8ysOK/ApMD8IIU8dXafI2Va93U3rkT9ZeQeCibTmQOLafOE+6FbN
	 T4uQ/0aNcpoAA5toexNdZsiYW2Wl8Sg1AwnbxHhmgzbl4G/jQcC4K3nVh/UGxPQ8O5
	 KDOs2sQQ6M6MluaNqdw2hvZt/Oyg+8GuWjqcZtgHXlt4FJmDQ6Loa0Bk20+aaAdiiK
	 MHS209o1ofCpQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 11 Sep 2025 16:22:06 +0200
Message-Id: <DCQ1DZAVH3CG.REFX5C8FMNJ5@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "David Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v5 02/12] gpu: nova-core: move GSP boot code to a
 dedicated method
From: "Benno Lossin" <lossin@kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.21.0
References: <20250911-nova_firmware-v5-0-5a8a33bddca1@nvidia.com>
 <20250911-nova_firmware-v5-2-5a8a33bddca1@nvidia.com>
 <e1755470-587b-4a43-8171-3d031b7fb4f4@kernel.org>
 <DCPYQNZG1OJK.2EE4JWJAROK57@nvidia.com>
 <ce74db34-77bc-4207-94c8-6e0580189448@kernel.org>
 <DCQ074EMFNIK.1OJLWJXWZLDXZ@nvidia.com>
In-Reply-To: <DCQ074EMFNIK.1OJLWJXWZLDXZ@nvidia.com>

On Thu Sep 11, 2025 at 3:26 PM CEST, Alexandre Courbot wrote:
> On Thu Sep 11, 2025 at 9:46 PM JST, Danilo Krummrich wrote:
>> On 9/11/25 2:17 PM, Alexandre Courbot wrote:
>>> You can see the whole process on [1]. `libos` is the object that is
>>> returned (although its name and type will change). All the rest it
>>> loading, preparing and running firmware, and that is done on the GPU. I
>>> think it would be very out of place in the GSP module.
>>>=20
>>> It is also very step-by-step: run this firmware, wait for it to
>>> complete, run another one, wait for a specific message from the GSP, ru=
n
>>> the sequencer, etc. And most of this stuff is thrown away once the GSP
>>> is running. That's where the limits of what we can do with `pin_init!`
>>> are reached, and the GSP object doesn't need to be pinned anyway.
>>
>> I don't see that, in the code you linked you have a bunch of calls that =
don't
>> return anything that needs to survive, this can be in an initializer blo=
ck.
>>
>> And then you have
>>
>> let mut libos =3D gsp::GspMemObjects::new(pdev, bar)?;
>>
>> which only needs the device reference and the bar reference.
>>
>> So you can easily write this as:
>>
>> try_pin_init!(Self {
>>    _: {
>>       // all the throw-away stuff from above
>>    },
>>    libos <- gsp::GspMemObjects::new(pdev, bar),
>>    _: {
>>       libos.do_some_stuff_mutable()?;
>>    }
>> })
>
> Can the second initializer block access variables created in the first?

No, that's not yet possible :( but I'll make it work next cycle.

---
Cheers,
Benno

