Return-Path: <linux-kernel+bounces-840626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3B5BB4D7C
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 20:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D5B3A98FC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 18:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AF62750F6;
	Thu,  2 Oct 2025 18:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="MjR4iaCF"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564057D07D
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 18:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759428575; cv=none; b=MXp5b1lGJxv6IambOUm6ZMy4HWl+SA3cnnLirQaHKLOGylf/M1Kn6J/fY3OnGnJz5RUmFcf98e6ZkpYZikHSq/ER51qBL46OT1/CxUYmrMXHVUmssmhcFdGyHs+8JSrQrALA1Wg9UjVxH8cnU1SN56Uw2Ae1zKPiAwKL7mym0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759428575; c=relaxed/simple;
	bh=jP0bOCpHts1cYQ6QPHXz3k1015xmQOGYCIqVVNlGNUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAw068/h0N3zmNAFZJiGTq0BLnwfj4OKj1mAx1hw12TXdivqRKScoBEk1bWUzUyIW2aAlBhhLbpMobWldkeo9tPwW/yC7YNLxrE/W4lQUffk69CFOmYKYXSJSy5EOuPuanRXCkfFVJGrJIlDWfLavnxrWqpq0CLHswF9oNJ8nT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=MjR4iaCF; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-189.bstnma.fios.verizon.net [173.48.113.189])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 592I8v8J032183
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 Oct 2025 14:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1759428540; bh=azyzB4IWARU4Sm+tCHrW1KeNNkSgcOf/KRtTdLleI/8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=MjR4iaCFRxhcC8Eov3sP97hRfzDj45cFSTQXys99vQ1hEYIN95HJG6hHD6wduuAZo
	 uFTLP/wS//CqdFc0sVvvUsqiOh40POgJLuxVOdfWCKstl0fqEu1TJB/B7FFvFaMPO2
	 cwcgl3nkOkDNcTieqNLLDmdPyaZTnEr/ngXa6ZG8RuJlTEtzXp6NObC8XmyCaw2kmw
	 NcHiVGECdGGkGKdSP741gd+Xiz7iPNc5AEFoB2eXHMQcyEg86X1BpgDdGWzukpT/gn
	 ixnC3BuP/iw6viwYsI6KI4CmteqrHKcadlx9QIu54W/supqRWxUdvC1QMOSC55qX9R
	 dobFeAUicW/kg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 835F92E00D9; Thu, 02 Oct 2025 14:08:57 -0400 (EDT)
Date: Thu, 2 Oct 2025 14:08:57 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Walmsley <pjw@kernel.org>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] RISC-V updates for v6.18-rc1
Message-ID: <20251002180857.GA354523@mit.edu>
References: <2c804359-3d43-0fba-7173-a87f9aec4bd2@kernel.org>
 <066d70c7-b0a7-45e5-9337-17901bc95664@codethink.co.uk>
 <CAHk-=wgfpswvq0TypePyjv3dofO5YaUC_fSd_MjzY7jogCUnCg@mail.gmail.com>
 <3c9d9f92-aaf8-4d4d-a2d9-8d6a410edc30@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c9d9f92-aaf8-4d4d-a2d9-8d6a410edc30@codethink.co.uk>

On Thu, Oct 02, 2025 at 01:48:47PM +0100, Ben Dooks wrote:
> 
> We first tackled big-endian support on ARM32 nearly 15 years ago, and
> drawing on that experience, we saw value in doing the same work on RISC-V as
> a way for newer engineers to gain hands-on experience contributing in the
> open.

Given the cost to the Linux kernel ecosystem as a whole, is giving
newer engineers "practice" really worth it?  I'm not convinced it is.

> > RISC-V is enough of a mess with the millions of silly configuration
> > issues already. Don't make it even worse.
> 
> This feels like the price you pay for making a flexible and free ecosystem
> to build cores.

Just because the RISC-V ecosystem wants to have a flexible ecosystem
doesn't mean that Linux kernel ecosystem is obliged to be just as
flexible, no?

					- Ted

