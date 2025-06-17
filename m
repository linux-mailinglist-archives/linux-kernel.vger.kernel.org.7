Return-Path: <linux-kernel+bounces-690851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6843ADDD08
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 22:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B450B7A3C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 20:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F1D2EFD9E;
	Tue, 17 Jun 2025 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/ViDK5R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A34F2EFD83;
	Tue, 17 Jun 2025 20:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750191253; cv=none; b=r8HAK2PjjYPEY9PBF/MFG+gOCQvQtM5wbcRnWG0WnDkfxH16V8wQ6kKavVGYOJucPhtbY/tD7xcLPZY9825sbSwronREB24gCYSXp8y2p4CBQ5Hdprd8HwkmYu7KOIOxb4TJKfh4MQjtktEwxs4/xLUgo/Bc4xLdtjISkEJvbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750191253; c=relaxed/simple;
	bh=oLvbT+kATQP0niwsl8Ion+MRezBTBGDHphjSJvl1ykY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzU4iYfXcevn3gVSaFvcJNSQMJJSvEow4yAylwCNE9kRWwGq9kqL6hoM2yeCn2AKB8Z6E07L/2c5IkwvlNmuAv3oJE2RiSOgYONGxfnsKRgGCRRwCRpQ0lEUS1uvOjqDwyY61arLRANMdohsi5WRLtEBTT7D7pyKq23utJNtzjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/ViDK5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BBC7C4CEE3;
	Tue, 17 Jun 2025 20:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750191252;
	bh=oLvbT+kATQP0niwsl8Ion+MRezBTBGDHphjSJvl1ykY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S/ViDK5R04yKbjdvPIPz4/BNAf4yzkDlToY5S8CwWpHwbVWDHzCK7ZAe4tJnURvr0
	 hc4QS5ZPDiWFMK6ZLA2fCwKb5EZvmgftWSgtQfSWND9d5fQzMXCP23ffUMbVaQNjxl
	 mh7AuPF3M5CYBbZQTApdJ3HFvcRXvSCfmfdSh2S+/Yz0csJJJLP0FdI69cHs/DsmDl
	 AktoECLMXQrAhCD1PQ1BYBrYdxD9PMqmS1DKajFz8/qhaC9TVy4dGfttH7hfbUr4of
	 zM1sI/P5V5Ze5oIhU3z9Ayj+MKPcyZaiKZ+J80LXdYYrZ7hhkMNW5Tm+o9N4z9D21m
	 gUAR1B/HPXD0g==
Date: Tue, 17 Jun 2025 22:14:04 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Benno Lossin <lossin@kernel.org>,
	John Hubbard <jhubbard@nvidia.com>, Ben Skeggs <bskeggs@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Timur Tabi <ttabi@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	Lyude Paul <lyude@redhat.com>,
	Shirish Baskaran <sbaskaran@nvidia.com>
Subject: Re: [PATCH v5 00/23] nova-core: run FWSEC-FRTS to perform first
 stage of GSP initialization
Message-ID: <aFHMjEt7KrjClom_@pollux>
References: <20250612-nova-frts-v5-0-14ba7eaf166b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250612-nova-frts-v5-0-14ba7eaf166b@nvidia.com>

On Thu, Jun 12, 2025 at 11:01:28PM +0900, Alexandre Courbot wrote:
> Hi everyone,
> 
> The feedback on v4 has been (hopefully) addressed. I guess the main
> remaining unknown is the direction of the `num` module ; for this
> iteration, following the received feedback I have eschewed the extension
> trait and implemented the alignment functions as methods of the new
> `PowerOfTwo` type. This has the benefit of making it impossible to call
> them with undesirable (i.e. non-power of two) values. The `fls` function
> is now provided as a series of const functions for each supported type,
> generated by a macro.
> 
> It feels like the `num` module could be its own series though, so if
> there is still discussion about it, I can also extract it and implement
> the functionality we need in nova-core as local helper functions until
> it gets merged at its own pace.
> 
> As previously, this series only successfully probes Ampere GPUs, but
> support for other generations is on the way.
> 
> Upon successful probe, the driver will display the range of the WPR2
> region constructed by FWSEC-FRTS with debug priority:
> 
>   [   95.436000] NovaCore 0000:01:00.0: WPR2: 0xffc00000-0xffce0000
>   [   95.436002] NovaCore 0000:01:00.0: GPU instance built
> 
> This series is based on v6.16-rc1 with no other dependencies.
> 
> There are bits of documentation still missing, these are addressed by
> Joel in his own documentation patch series [1]. I'll also double-check
> and send follow-up patches if anything is still missing after that.
> 
> [1] https://lore.kernel.org/rust-for-linux/20250503040802.1411285-1-joelagnelf@nvidia.com/

I think this series collected quite a few TODOs to follow up on once the
corresponding abstractions are in place, etc. This is fine and expected.

However, I think we should list those things in a central place, e.g. our TODO
list, in order to make it easier to follow up.

Additionally, it might get us more contributors who might be interested in
following up on those things.

@Alex: Can you please add such a list?

