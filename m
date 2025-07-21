Return-Path: <linux-kernel+bounces-738691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC54B0BBFC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 07:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C052188B8E4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 05:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAFB20D500;
	Mon, 21 Jul 2025 05:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mah+Tghr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FCE1D5CE8
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753074548; cv=none; b=KXFbUdzUWPNqPRAf6qXA1Pdbks7rchMNM+KxvxJSMMz+YqqriUVIb8OwK40r04ImJQ6iQpzblmbkTWwEygMatYSrBvDXww+fpYHCSl7IViO3FCQqUjk2RtF8f1JSnc69dbZbpJZ3Nfx8gS8MZFd4+kbiMMjNDexZJezGLYtJdDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753074548; c=relaxed/simple;
	bh=mE6jUqCRnNUpD+/Q0rPego09ThKwPBZs/426+KQcfyw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=evZPhTpxGpOmftgU73cVHHhwZceDVIKaew/tTuktOEMOAxUBATPyvjdCufyVhxqrDpmhY9ZqQp8d+uDGH7nNVmLHEPjfjjttP7oSQnZncMhOlRE79HpCBi3WuqM4epZpDPvBdhWaI4zkRz2Z92g8vdpP/h5U0Wp8OEtDZuHlbaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mah+Tghr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B05C4CEF1
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 05:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753074547;
	bh=mE6jUqCRnNUpD+/Q0rPego09ThKwPBZs/426+KQcfyw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Mah+TghrNtwzwFL2YeU8BYyG7cm4yPMT2oOQaYmoXjilYBCuXMG5hV2sDbjf0QKK9
	 9dAryw9R3Gb9eP5dSQIcOXCX5HawRSSNMa4TbfhjnP2loObF5WavLLquLohDgxP6u8
	 BdhmLfgVoyXCjbVndnLTrGeOObENJSFsDLDYMTX9CknhWsFTM9MFDkfOwYhGCoTzLp
	 s6ILwjcCiahlgKKFvy6b2E07lmRklDOUFC1p9Im76SZEeVd99R9KTN7UNWMKFCV9nt
	 dZr4cXBl+QPlkr5IzuAAf8PgGB5V+QBGSjNpAniQ7EyrCJRifrvSCe6b5SOx3y+R5k
	 4RXTlG+h04/ig==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b7123edb9so39847781fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 22:09:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXXIyqzva1BdMH8uy9bBfi3dY82YfoFi1cecpgWGzDxtuRGjhBPzEKaryUCcQ3pwmfje3/rz3HEf7VbE/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJwZljOmMgtfKjQnJ56qsAv91BclJW1F8brxkUV0mtywYpfb5
	96xSa2E3Wc1wMDl7DaCm8/YDUyelE2e5HOcR8VhFRAYcM2vr6h8sDtDbLay4KoPzQ69qycy0LU1
	hDdaJ/4zggWZyyM20aFJMwA65Tnyclmo=
X-Google-Smtp-Source: AGHT+IFQLtKd8Waolhv9mmK7mca11jQhwiRk4Ud79gugVJQSJ6QSPxdCJsPLq/8Lt/at84+JOinIuRHo2NyRM9eTTq4=
X-Received: by 2002:a05:651c:1488:b0:32b:2ea9:1dcd with SMTP id
 38308e7fff4ca-3308f60eb32mr47084441fa.32.1753074546096; Sun, 20 Jul 2025
 22:09:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250717085723.1875462-1-mawupeng1@huawei.com>
 <aHjQp9zPVPuPyP3B@kernel.org> <9688e968-e9af-4143-b550-16c02a0b4ceb@huawei.com>
 <aHj8mfecDhJJZW1Y@kernel.org> <8d604308-36d3-4b55-8ddb-b33f8b586c1a@huawei.com>
 <aHzjOxg_oPp06blC@kernel.org>
In-Reply-To: <aHzjOxg_oPp06blC@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 21 Jul 2025 15:08:48 +1000
X-Gmail-Original-Message-ID: <CAMj1kXGKGXeKGKWT3VzkBtACtjFyz8ntiyoTU26DA4aR6mi88g@mail.gmail.com>
X-Gm-Features: Ac12FXyjqTH9Bay5BBZMJnmEAkp89_i1OwrVdu4kl7-wlrSbkPihr_WXFGx5kTw
Message-ID: <CAMj1kXGKGXeKGKWT3VzkBtACtjFyz8ntiyoTU26DA4aR6mi88g@mail.gmail.com>
Subject: Re: [PATCH] mm: ignore nomap memory during mirror init
To: Mike Rapoport <rppt@kernel.org>
Cc: mawupeng <mawupeng1@huawei.com>, akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 20 Jul 2025 at 22:38, Mike Rapoport <rppt@kernel.org> wrote:
>
...
>
> > w/o this patch
> > [root@localhost ~]# lsmem --output-all
> > RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> > 0x0000084000000000-0x00000847ffffffff   32G online       yes   67584-67839    0 Movable
> > 0x0000085000000000-0x0000085fffffffff   64G online       yes   68096-68607    0 Movable
> >
> > w/ this patch
> > [root@localhost ~]# lsmem --output-all
> > RANGE                                  SIZE  STATE REMOVABLE         BLOCK NODE   ZONES
> > 0x0000084000000000-0x00000847ffffffff   32G online       yes   8448-8479    0  Normal
> > 0x0000085000000000-0x0000085fffffffff   64G online       yes   8512-8575    0 Movable
>
> As I see the problem, you have a problematic firmware that fails to report
> memory as mirrored because it reserved for firmware own use. This causes
> for non-mirrored memory to appear before mirrored memory. And this breaks
> an assumption in find_zone_movable_pfns_for_nodes() that mirrored memory
> always has lower addresses than non-mirrored memory and you end up wiht
> having all the memory in movable zone.
>

That assumption seems highly problematic to me on non-x86
architectures: why should mirrored (or 'more reliable' in EFI speak)
memory always appear before ordinary memory in the physical memory
map?

> So to workaround this firmware issue you propose a hack that would skip
> NOMAP regions while calculating zone_movable_pfn because your particular
> firmware reports the reserved mirrored memory as NOMAP.
>

NOMAP is a Linux construct - the particular firmware reports a
'reserved' memory region, but other more widely used memory types such
as EfiRuntimeServicesCode or *Data would result in an omitted region
as well, and can appear anywhere in the physical memory map. There is
no requirement for the firmware to do anything here wrt the
MORE_RELIABLE attribute even though such regions may be carved out of
a block of memory that is reported as such to the OS.

So I agree with Wupeng Ma that there is an issue here: reporting it as
mirrored even though it is reserved should not be needed to prevent
the kernel from mishandling it.

