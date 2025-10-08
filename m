Return-Path: <linux-kernel+bounces-845431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DA2BC4E22
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 14:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 841F84EB03D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 12:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13C124EAB2;
	Wed,  8 Oct 2025 12:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CfU0F376"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1FD248F77
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 12:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759927251; cv=none; b=GFv4Andoo/Oie49aJh/K+ydWvjJ9IwRgJy74qW7s/N5sygmW6mF2tzOZFSu8MUADyteiCoXYinF5pcXk8P0eaboQXvie9spX9/OjiChhJKuY6GikXjYQlLbZGwarAbV3lTXR0L5xs3pVRlF0lYawOITfWYtPRv3EkVWCGhrXdt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759927251; c=relaxed/simple;
	bh=ScMSz4dASWHUMNw3VMR5HsvVzsipH3DOHnYd9nCasRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lnlgpjwWAZev0Vv+pswoT01Rg8aXaMX4/pFJegnrtcCr27sp1SZbXV1h9fr2QQ8bgPkqEJCZIzxlkuLbUgnM6OZf29OhgYOxVW8LiwtlW+99mgALqefZqp+jnwwN3xF0ZzXkFZD9Dhxq9izLo92KppNl1OfnOQNeESdDfIlhXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CfU0F376; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEFBC4CEF4;
	Wed,  8 Oct 2025 12:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759927250;
	bh=ScMSz4dASWHUMNw3VMR5HsvVzsipH3DOHnYd9nCasRY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=CfU0F376MJf5m4TlX85hI6/0B4baf0AA6sM8NcaosCKppQUqeyigqH5Hj8nBSzTYP
	 rCxb3+Hkn0ZoPV0GYWc0XWS9+BQ+L6CXWdtukRSo38N3yGfFHSMzxLcc2Qc7cJj2O2
	 tUCBKpTkMqvbhpxPZNDMAX3wgDLZssPOyJv1V14oaNLoj8aMALyGb7NQZZyiyUOMoX
	 qWe4JwDqddCSmU15PCtP9dmXaNDOxBUo3Wwa2ix9HAubCm9Tn+ru/Q1lUpXFIhPlmk
	 iky8HbbHJpb0VCgTlyT+kUec2ULq7M3GLxyspFSi21wKh83/ScvXOBfa5PsgmUjf1U
	 wYe/OOkG7/IZw==
From: Pratyush Yadav <pratyush@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Sean Anderson <sean.anderson@linux.dev>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Michael Walle <mwalle@kernel.org>,
  linux-mtd@lists.infradead.org,  Richard Weinberger <richard@nod.at>,
  linux-kernel@vger.kernel.org,  Miquel Raynal <miquel.raynal@bootlin.com>,
  Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: Enable locking for n25q00a
In-Reply-To: <mafs05xcpo9sz.fsf@kernel.org> (Pratyush Yadav's message of "Wed,
	08 Oct 2025 14:30:20 +0200")
References: <20251006223409.3475001-1-sean.anderson@linux.dev>
	<mafs0ecreontu.fsf@kernel.org>
	<4888cefa-e8be-4f0d-9d4a-c82f9ff6cda0@linux.dev>
	<mafs05xcpo9sz.fsf@kernel.org>
Date: Wed, 08 Oct 2025 14:40:48 +0200
Message-ID: <mafs0wm55mur3.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 08 2025, Pratyush Yadav wrote:

> On Tue, Oct 07 2025, Sean Anderson wrote:
>
[...]
>>>> Tested with a mt25qu01gbbb, which shares the same flash ID.
>>> 
>>> Ughh, is this another case of flash ID reuse? Do mt25qu and n25q00a
>>> flashes behave exactly the same and only have two names? If not, then
>>> how do you know if n25q00a will also work with these changes?
>>
>> I examined the datasheet for the n25q00a and determined that it has the
>> same status register layout.
>
> Can you share the links to the datasheets?
>
> Also, test logs would be nice to have.
>
>>
>> In fact, every n25q and mt25q flash has the same status register layout,
>> which (as noted above) is necessary to support capacities greater than 8
>> MiB (and all flashes in this series have such capacity).
>
> Do they behave the same? If not, do you know how they differ? If they

To clarify, I mean behave the same in things other than the status
register.

> behave differently, we might need to have some code that detects which
> one is running. Not necessarily as part of this patch though.
[...]

-- 
Regards,
Pratyush Yadav

