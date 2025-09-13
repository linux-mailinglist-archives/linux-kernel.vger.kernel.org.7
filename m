Return-Path: <linux-kernel+bounces-814994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0CBB55D9B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 03:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 787531D61849
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1429A1684B0;
	Sat, 13 Sep 2025 01:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qpu05onl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA7F8C11
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 01:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757727183; cv=none; b=myKILzPKEhCLcwRyI5hSA2yr2SjOnbShVb1/V+KrjJXGVn/I9HvjR6Rz1WRRxxT9UDU6JCee96xEMJQFZdFRIq8Ug8aiZKEStCk3Ujks1iaKKPE3rnTogKsG+G2dGa8B/fmi0ffAv10YYiB7h0j0hV0SACP4er5+pG/PCwcK/YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757727183; c=relaxed/simple;
	bh=IqZUTYDCDExdCes1X4lQ7ydsqNneBWR5IpoqupMGbNs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dnSBO3FoQykEnVBbUwBgKO1fNuLy1hXFo2VVH2wM20Mo0PxmaTPakRLNHr18HVDzI6Z3tCZUlsEykR2eNab4UZuZEu1T+0J1jE5hJDGooJ3j6cLsH/Xc1OIFbJX16q4Ei1DzgURfAgoO0uyY76OBRZMs5FMLEAcacIZ6WFBiYuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qpu05onl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5035AC4CEF1;
	Sat, 13 Sep 2025 01:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757727181;
	bh=IqZUTYDCDExdCes1X4lQ7ydsqNneBWR5IpoqupMGbNs=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=Qpu05onlK2q/MU9rBbJIndls8nGyLETDwt1GRtvkHWPA2IgG/K+06vGIdfcsg+Q9J
	 ubXJusqfM6/7z0Z3qKmDNCLUndy+7cBZzH6Ku7a20A+GXMw4Q3vG2gmyAmH8YYP9bV
	 dDrkwV/fZoRy2nr2PNfMa2gMAVhepO+yfoV/9XH6TK3EuvySQU1d3NPRTTbZBvk0bo
	 hLywNNUNa44nKb5TBfZWxOXgtcARoHc6y4JzHRB6uR3/vYVQN4jMDpdULm5krbsBOS
	 r4L14Cj+8cNLtMEVeA5XyGZx5hBdrq7Qp4fmsBRP0EceBRob//tf2fDwDNSz05bGsT
	 ZJ/Zo/uiIMEEA==
Date: Fri, 12 Sep 2025 19:33:00 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Thomas Huth <thuth@redhat.com>
cc: Alexandre Ghiti <alexghiti@rivosinc.com>, linux-riscv@lists.infradead.org, 
    paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
    alex@ghiti.fr, atish.patra@linux.dev, anup@brainfault.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] riscv: Replace __ASSEMBLY__ with __ASSEMBLER__
 in header files
In-Reply-To: <d1fe7fdf-b3da-4c53-8a5a-a87acd38d525@redhat.com>
Message-ID: <d34c4b47-4acd-fd68-4cdf-b9cfaf022a32@kernel.org>
References: <20250606070952.498274-1-thuth@redhat.com> <175450055499.2863135.2738368758577957268.git-patchwork-notify@kernel.org> <d1fe7fdf-b3da-4c53-8a5a-a87acd38d525@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Thomas,

On Mon, 18 Aug 2025, Thomas Huth wrote:

> On 06/08/2025 19.15, patchwork-bot+linux-riscv@kernel.org wrote:
> > Hello:
> > 
> > This series was applied to riscv/linux.git (for-next)
> > by Alexandre Ghiti <alexghiti@rivosinc.com>:
> 
>  Hi Alexandre,
> 
> I can't see the patches in the for-next branch ... have they been dropped
> again? Was there an issue with the patches?

No issues with your patches; we just had some trouble getting the 
arch/riscv PR merged during the last merge window.  I've queued both of 
your patches for v6.18.  They should show up in for-next in a few days.  
Thanks,

- Paul

