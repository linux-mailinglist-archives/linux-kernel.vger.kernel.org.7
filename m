Return-Path: <linux-kernel+bounces-846834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5141EBC92AE
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 15:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A0D33B2DB0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 13:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B842E2DFA;
	Thu,  9 Oct 2025 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U66bVbG+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97D711713;
	Thu,  9 Oct 2025 13:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760014968; cv=none; b=N4ylLmV19N/J4Ffd2CyzVbp+7BZvanvw1jOvvCKReFPEc2GUoIbRB7R4UYE6j3z92P2HXxfIrztzGdXcFrPVcSglp53qqog72Z9GgERxH1o+ANZvbzi/tbXRvzhZ9KzMS0tHuAYEp21f4wM7NUaPgEHpoJQ30akzl5KgGQqqBL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760014968; c=relaxed/simple;
	bh=PuBhH69ek7xCWvm0d6VlgDo84TLqDlLMyWF4mF3IQws=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=E7PaWS6ZdZNAz2oYtiMg8hTGmuOeIhEQOXZgArLi1s9Ui0AHrCqU5nGimrHNZFpCJcgCyeZU6rbAaMS+n2aJ3GouL2ZOtVPLwN+OJbrj5IqIqTdKitjOgLCrcBCMMgLiwUKCiDBxe86/M0FM+nKYx2mRIV4Lq+oL8LouqFEb+uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U66bVbG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B61CC4CEF5;
	Thu,  9 Oct 2025 13:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760014966;
	bh=PuBhH69ek7xCWvm0d6VlgDo84TLqDlLMyWF4mF3IQws=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=U66bVbG+u9ZGnv56xEL2UQJ9Tl/4GNHCEj+Mqn80qMl6u9YpHbHHwbLkJqIiiPnEk
	 lgex3EvWzBOUt2UBiZ+zZTgSvL3x6OFmKMs/BLkJ+lQ2uCfye6y1ks+CoM1fc0PZsy
	 7CSCR2AKg6/RSufXN1Id4LxgRJ8quweikpk2FFbqYnrIVpM7+kAQzzaA5r9dmEkAfo
	 Av3xe7vwtYVfUWcvGcmwcaMTqMQUWeJoWUe8EpPIU8eF+eYW0gK9cy3v0XiiQkdECY
	 vscTpXwzqBp3P1M7QC/W830ChoVgOg536Rsq4B9iJ2gSGwLt2mKm81pdNZSXYm3PFn
	 VPxBVMjj0sS6A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Oct 2025 15:02:39 +0200
Message-Id: <DDDT8EEG7E8B.27YT6QAFIS9GK@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v6 0/5] Introduce bitfield and move register macro to
 rust/kernel/
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Yury Norov"
 <yury.norov@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "Alistair Popple" <apopple@nvidia.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>,
 "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 "bjorn3_gh@protonmail.com" <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime Ripard"
 <mripard@kernel.org>, "Thomas Zimmermann" <tzimmermann@suse.de>, "John
 Hubbard" <jhubbard@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "joel@joelfernandes.org" <joel@joelfernandes.org>, "Elle Rhumsaa"
 <elle@weathered-steel.dev>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Andrea Righi" <arighi@nvidia.com>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
References: <695CCDCE-A205-4557-AA15-6F102B8CCF0C@nvidia.com>
 <DDCV84IJHUML.126CB1CT0XMX5@kernel.org>
 <22e8c33c-b444-4f58-b7ec-6374475e05be@nvidia.com>
In-Reply-To: <22e8c33c-b444-4f58-b7ec-6374475e05be@nvidia.com>

On Thu Oct 9, 2025 at 2:24 AM CEST, Joel Fernandes wrote:
> On 10/8/2025 6:23 AM, Danilo Krummrich wrote:
>> On Wed Oct 8, 2025 at 1:37 AM CEST, Joel Fernandes wrote:
>>> The Nvidia GPU architecture is little-endian (including MMU structures =
in VRAM).
>>=20
>> Yes, I'm aware (and I'd assume that there is no reason to ever change th=
at).
>>=20
>> Just for the complete picture, there's also some endianness switch in th=
e
>> NV_PMC_BOOT_1 register I think?
>
> You are referring to old GPUs. NV_PMC_BOOT_1 does not have endianness swi=
tch for
> Turing and later.

Ok, then there's no point in considering big-endian CPUs.

> If we want to add a Kconfig patch enabling Nova only on x86/ARM, that'll =
be Ok
> with me.

I don't see why we'd constrain it to x86 and ARM, but we should indeed cons=
train
it to little-endian architectures.

