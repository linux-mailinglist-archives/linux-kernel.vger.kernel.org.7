Return-Path: <linux-kernel+bounces-606360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC998A8AE34
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 04:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CDAB1904103
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 02:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B9C1A83F5;
	Wed, 16 Apr 2025 02:33:37 +0000 (UTC)
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6A92557C;
	Wed, 16 Apr 2025 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744770816; cv=none; b=jPAwofN1ET+D8yf7z/xVgdAEdhvpyzf8V3dhm8Y6vx8gfwuXdnCi9F6K4i/L6/rjuTvEgd0SJWqm7fWnwWbiqB73DNyZy6C9R2N3WQpuTZyTKfFOnQIC4pi0XsSUq5qyLwSaZVg6/b3rfoFMQDeRBQdGH2/gP/BvoWgpVUe1nuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744770816; c=relaxed/simple;
	bh=sEE5PshcelJJaFGKDPuzbvle24oUMU811EChpZs83YM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=dA2AQoyqbEqAU8aMof8YQQARWQupz6ojMBKqT/tbKaBacm7rtGu9npYE7klQ7bPCPdyfcjBwwovd+hyHsvf/1Tw+0KJZAA3p+NYMn3LH9JcPwn53l1wtcnI1q8nXGOpDCc8G1GzNoTjxaGcl9Rb+MzuFuqoHSCdbcZ3Jh/SrM6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 72A1892009C; Wed, 16 Apr 2025 04:33:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 70FE292009B;
	Wed, 16 Apr 2025 03:33:25 +0100 (BST)
Date: Wed, 16 Apr 2025 03:33:25 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thorsten Blum <thorsten.blum@linux.dev>
cc: Oleg Nesterov <oleg@redhat.com>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Remove unnecessary zero-length struct member
In-Reply-To: <20250411090032.7844-1-thorsten.blum@linux.dev>
Message-ID: <alpine.DEB.2.21.2504160321210.23090@angie.orcam.me.uk>
References: <20250411090032.7844-1-thorsten.blum@linux.dev>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 11 Apr 2025, Thorsten Blum wrote:

> Remove the zero-length struct member '__last' and use sizeof() to
> calculate the value for MAX_REG_OFFSET.
> 
> No functional changes intended.

 Have you verified that there's no change except for timestamp data in 
(non-debug) `vmlinux' produced with and w/o the patch applied?

 Also this is broken anyway: if you use MAX_REG_OFFSET for `offset' passed 
to `regs_get_register', then data past the end of `regs' will be accessed.

  Maciej

