Return-Path: <linux-kernel+bounces-721676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620CFAFCC57
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CA227A9980
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 13:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69552DCF74;
	Tue,  8 Jul 2025 13:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PHRTauG6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F57126CE02;
	Tue,  8 Jul 2025 13:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751982095; cv=none; b=Hq14DkcI/wvXK7zyhNWFrRfmv2hyNA2s6ROut1nfOwWBUUFXyJO7H26Vh/a/jIzn3ON+kNRCCU7AVITxn1nKtbEb2IcPVFu3BSiw7SwTpGLHPbiTk8MNz98mmjK9OM8JZ7QSg9jrFAVvQYZwwfegdCLL/1z6konUd138UHPvYXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751982095; c=relaxed/simple;
	bh=lQ+lFAMmkEa2z0Mr2+RjJhawqs2r65qSuiDH/oxq0cs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=kShbeHPMnJdpBRDvtit1bP5WzFI86dZhvQqPF0FJMiKsPnJ1MHTlZ9Xkm8zsewk4HPcF24M2Jy44jfHh93dCzFKvg22kVSEd//lVIyUQ6bmdjoQ2wJ/k09MTbSLKcrPFLQ1oyYB04q36tDXUCzXVua7q8FrzQCkiKjQo7/QFh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PHRTauG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE109C4CEED;
	Tue,  8 Jul 2025 13:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751982094;
	bh=lQ+lFAMmkEa2z0Mr2+RjJhawqs2r65qSuiDH/oxq0cs=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=PHRTauG6I9s0l5DAhv3NTmrlI3xWnX3hXzoBcm9i6vLM70lEpXtmUiqZMy7i98F92
	 ZvQaRw6iV82rlgGXkCT0vBbHCpPgcViJd4OWUHuJJzBrdkDhyNu8XQ9dmsu8F+vP6e
	 LU3fhKzYhg6d24RMcrXIBBURVkpgZ/DpVJ97Q4SwgCcDjo4yTUneT+0QRaakQkgElY
	 zcBAqR4EsDnZL/aaQAiHtJnDEDw/nqphmC1tDRqpdAYioKLhsGeulSGxoGAXP0Y04H
	 9AGZeqtubsw4MmrgIm2FUe5FOx8PRl8BMfStKdTwuVRAuDWLUJhrXOztUXk/BCaqE7
	 m/m9GTcbXUR0Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 15:41:31 +0200
Message-Id: <DB6PTHLBMET8.2TN916HUP10X9@kernel.org>
Cc: "Vitaly Wool" <vitaly.wool@konsulko.se>, <linux-mm@kvack.org>,
 <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Vlastimil
 Babka" <vbabka@suse.cz>, <rust-for-linux@vger.kernel.org>, "Liam Howlett"
 <liam.howlett@oracle.com>
To: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v11 0/4] support large align and nid in Rust allocators
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <824065ea-1f5c-4cd4-9917-4b7a91882af8@lucifer.local>
 <aG0HJte0Xw55z_y4@pollux>
 <8a08931c-ce54-4e96-9e99-e7c696389dc3@lucifer.local>
In-Reply-To: <8a08931c-ce54-4e96-9e99-e7c696389dc3@lucifer.local>

On Tue Jul 8, 2025 at 2:36 PM CEST, Lorenzo Stoakes wrote:
> TL;DR - the real issue here is not cc'ing the right people (Vlastimil was
> not cc'd until v11 for instance).

Since Andrew was Cc'd and also did reply, but didn't mention anything about
missing receipients on the -mm side of things, I did not see a reason to br=
ing
anything up regarding this from my end.

Thanks for bringing this up.

> On Tue, Jul 08, 2025 at 01:55:18PM +0200, Danilo Krummrich wrote:
>> On Tue, Jul 08, 2025 at 11:58:06AM +0100, Lorenzo Stoakes wrote:
>> > +cc Liam
>> >
>> > Hi guys,
>> >
>> > We have a section in MAINTAINERS for mm rust (MEMORY MANAGEMENT - RUST=
), so
>> > it's slightly concerning to find a series (at v11!) like this that cha=
nges
>> > mm-related stuff and it involves files not listed there and nobody bot=
hered
>> > to cc- the people listed there.
>>
>> What files are you referring to? Are you referring to:
>>
>> 	rust/kernel/alloc.rs
>> 	rust/kernel/alloc/*
>
> this ---> rust/helpers/slab.c            | 10 +++---
> this ---> rust/helpers/vmalloc.c         |  5 +--

So, your concern is about those?

> These are clearly specifically related to mm no?

Yes, and if the maintainers of slab and vmalloc agree we can add them there=
.

But again, they're just re-exporting inline functions and macros from heade=
r
files, which bindgen does not pick up automatically. They do not carry any =
logic
and purely are a workaround for bindgen.

For instance,

void * __must_check __realloc_size(2)
	rust_helper_vrealloc(const void *p, size_t size, gfp_t flags)
	{
	        return vrealloc(p, size, flags);
	}

works around bindgen not picking up the vrealloc() macro.

