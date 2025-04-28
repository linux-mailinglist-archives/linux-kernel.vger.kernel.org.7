Return-Path: <linux-kernel+bounces-622330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14676A9E5C9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 03:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D09D3B0857
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Apr 2025 01:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4068E145B16;
	Mon, 28 Apr 2025 01:35:10 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066A1A945;
	Mon, 28 Apr 2025 01:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745804109; cv=none; b=AV9L+eIy0/do8HhCCk1ljQ42L5bwiwNsEk8HNawFAC/cKQLLzoEQ1Fxal33RfHkpZPb0xZjeDu1DH6Jh2iAPlTvpJI4sguzcwibbpYHSFeb/zbjVDp7ycIJ3yzJ4nZa2UhVDrLB1p1FTY3HCy+HGfIM+z2Aa7wCxXkrI8WQTGZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745804109; c=relaxed/simple;
	bh=Ebz/VBsEcgu0lcMVIMIt7JjmA5z1W8cu8ILvrlaK9zw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=C42/fcdOWVoPxHIVzNJBLesRd4X6BBiJbwJFLP3SQAanPR6/zXElSgdWJ5KNnLCZ0NwJ7Fl+WFP/LXmKOoSdKGkehg5GeBiscLsPFUPDk+EdeYbWZkeM8V43IrLnJ6HX9gVFDbG/vKuClWF8w+gNdlgIawi/8NkB5yzgjcz+KTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 6A1B492009E; Mon, 28 Apr 2025 03:35:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 63AF092009D;
	Mon, 28 Apr 2025 02:35:05 +0100 (BST)
Date: Mon, 28 Apr 2025 02:35:05 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thorsten Blum <thorsten.blum@linux.dev>
cc: Oleg Nesterov <oleg@redhat.com>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] MIPS: Fix MAX_REG_OFFSET
In-Reply-To: <20250427113423.67040-2-thorsten.blum@linux.dev>
Message-ID: <alpine.DEB.2.21.2504280233460.31828@angie.orcam.me.uk>
References: <20250427113423.67040-2-thorsten.blum@linux.dev>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 27 Apr 2025, Thorsten Blum wrote:

> Fix MAX_REG_OFFSET to point to the last register in 'pt_regs' and not to
> the marker itself, which could allow regs_get_register() to return an
> invalid offset.
> 
> Fixes: 40e084a506eb ("MIPS: Add uprobes support.")
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
> Compile-tested only.
> 
> Changes in v2:
> - Fix MAX_REG_OFFSET as suggested by Maciej (thanks!)

 You're welcome; please add a `Suggested-by' tag accordingly.

  Maciej

