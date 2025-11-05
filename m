Return-Path: <linux-kernel+bounces-886228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5967C35096
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49F03467313
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185A22BEC27;
	Wed,  5 Nov 2025 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEEheCSj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7385724A046
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762337176; cv=none; b=X3akPRNaufpaYOmb+/jXMryZAYirO3XJucbLq1TK6BF98oarPMrjmTTPj1go3yTJU02hacha2zW2+MTbEAgwQnri9W37lIn/SAi9N7W0azgyOQ9zP3vBAO+0/43n8/lCSiZ5d5ae2TkJGZxAyNUDoczm7GgVg9cKK08G7Eq0f38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762337176; c=relaxed/simple;
	bh=7xelL80uD+mmTJR2hN24e9Ymu3C2gxHRvhahEaLbF7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ieY7CaCDI9lCps6pe625PbqPlIRVihJgZpzjfvLCby4aaIX5K5Jmay92HX2vSgAA+U8JHkG0mXr4iFzYwmSus1uxhOQxLnqsj7YZOWs1/PBFyK5D0Y3+f9qluA5VmO9i09HCVRIkqWK5C0Z4BCWp6m9g1eBxlInxJ2hT+ak1kIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEEheCSj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F501C116D0;
	Wed,  5 Nov 2025 10:06:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762337176;
	bh=7xelL80uD+mmTJR2hN24e9Ymu3C2gxHRvhahEaLbF7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=XEEheCSjZlHYcaoorplt0rQp5cepQJdG9XPrkjpeRyZZNwsZTULh6DAKX/St3FlgR
	 05qjxYR5hoyxzpKI0tkyeXyoPLZOrMLelfjfvga4J+Wqzgw9+cKAso7+9avEAGSqEo
	 KwP5hf+BMCbGBeTb8892UAId7TL283+yLGI68VNqK/1GeUG4WGOWlqf9LDaY04j6sM
	 CvUJKAjPFgu0qIvUzjbO/q0itD0EEx29Z/BxgZED0mPeUpbmjzPQFhZYsEphXtB1if
	 qoWBeQ6ISiFlZQMOvlya8ylHlu4VKKSo1zn5sT4Q6NX2PB4OAbv9nx4dPoCIIqvRrU
	 Ie9jRbkH4fySg==
From: Pratyush Yadav <pratyush@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Pratyush Yadav <pratyush@kernel.org>,  Baoquan He <bhe@redhat.com>,
  Alexander Graf <graf@amazon.com>,  Mike Rapoport <rppt@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  kexec@lists.infradead.org,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kho: misc fixes
In-Reply-To: <20251103172321.689294e48c2fae795e114ce6@linux-foundation.org>
	(Andrew Morton's message of "Mon, 3 Nov 2025 17:23:21 -0800")
References: <20251103180235.71409-1-pratyush@kernel.org>
	<20251103162020.ac696dbc695f9341e7a267f7@linux-foundation.org>
	<20251103172321.689294e48c2fae795e114ce6@linux-foundation.org>
Date: Wed, 05 Nov 2025 11:06:13 +0100
Message-ID: <mafs0tsz8bxpm.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Nov 03 2025, Andrew Morton wrote:

> On Mon, 3 Nov 2025 16:20:20 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
>
>> On Mon,  3 Nov 2025 19:02:30 +0100 Pratyush Yadav <pratyush@kernel.org> wrote:
>> 
>> > This series has a couple of misc fixes for KHO I discovered during code
>> > review and testing.
>> > 
>> > The series is based on top of [0] which has another fix for the function
>> > touched by patch 1. I spotted these two after sending the patch. If that
>> > one needs a reroll, I can combine the three into a series.
>> >
>> 
>> Things appear to be misordered here.
>> 
>> [1/2] "kho: fix unpreservation of higher-order vmalloc preservations"
>> 	fixes a667300bd53f2, so it's wanted in 6.18-rcX
>> 
>> [2/2] "kho: warn and exit when unpreserved page wasn't preserved"
>> 	fixes fc33e4b44b271, so it's wanted in 6.16+
>> 
>> So can we please have [2/2] as a standalone fix against latest -linus,
>> with a cc:stable?
>> 
>> And then [1/2] as a standalone fix against latest -linus without a
>> cc:stable.
>> 
>
> OK, I think I figured it out.
>
> In mm-hotfixes-unstable I have
>
> kho-fix-out-of-bounds-access-of-vmalloc-chunk.patch
> kho-fix-unpreservation-of-higher-order-vmalloc-preservations.patch
> kho-warn-and-exit-when-unpreserved-page-wasnt-preserved.patch
>
> The first two are applicable to 6.18-rcX and the third is applicable to
> 6.18-rcX, with a cc:stable for backporting.

Right. Sorry for the confusion. I see that on mm-hotfixes-unstable you
already updated the third patch with Cc: stable. Thanks.

-- 
Regards,
Pratyush Yadav

