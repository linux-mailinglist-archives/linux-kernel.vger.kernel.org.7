Return-Path: <linux-kernel+bounces-788446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06079B38481
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF0A17A6AF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D022D35AAAA;
	Wed, 27 Aug 2025 14:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eBTlEXbU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8EB35A2B5;
	Wed, 27 Aug 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303856; cv=none; b=axFUgSgeUAxrvlr/ZBc/QT58OoqrEY4tGFediFpEsL6L1km2+QbgAuHhx/+gmvP7Eujwts3fYvySojLuTFpcoNudFU+1V8w4BZnXf2DngccgOVjEZE/M8cB903SPyTBopzbPQttHjGcnf68Vek8z0e567PF+ePCy2/Pmn30lLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303856; c=relaxed/simple;
	bh=oz41WPwpJoJ+70OHjuwxvat5SN3gLfK76dk6ijB59a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkBLT9csJZyI7FEyklmDay/NFywZao8CLCt/9nfWPKizQXAFBaA2EACSxRdLz3+/O1KjYJPtip7EIBWrwY8/m4UuIYEBq6jy71hNIYl9+TYfrcoPsOR1E90DbaVRiu1/mW5ckBgcBaloe+KeDaOT5yciQL0rar0ihhSmXfKQxO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eBTlEXbU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A560C4AF09;
	Wed, 27 Aug 2025 14:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756303855;
	bh=oz41WPwpJoJ+70OHjuwxvat5SN3gLfK76dk6ijB59a4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eBTlEXbUBXGEPWR7h2GnUM9TkYBn6HZSfIsZZqKmFRGNhJ+0Yg1sfRfn/ELZKdbvp
	 J6qacbpVIy8uEmYg1gFDiifgGOW9ggJM+wygFUnVycpz9n1sS0th3AbpbJMQHZeqtw
	 Ggh8D4M87H/QY4QZfDr5SFZlfuRNAtuP+bUQtSuWqltAKKuSK2/Gpf9Np7KbYI9QJD
	 BMCcjK+8gIlwiLivO011MF3pld7NLCWzl8Qu7uEzP4mtDLQXn7jfrqSIN6ZQoSzkQu
	 hHqtPIpQFWXzadScRIRXk1McNzFl80VkpTKvEPSPIVcM1yzbq7TgpedaOTcbzEU52H
	 gcJypYRikQd7g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1urGrV-000000015gH-2MAE;
	Wed, 27 Aug 2025 16:10:53 +0200
Date: Wed, 27 Aug 2025 16:10:53 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Linux Kernel Workflows <workflows@vger.kernel.org>, 
	Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, Fox Foster <fox@tardis.ed.ac.uk>, 
	Federico Vaga <federico.vaga@vaga.pv.it>, Randy Dunlap <rdunlap@infradead.org>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] Documentation: management-style: Reword "had better
 known the details" phrase
Message-ID: <iv5v3ahnukjpndei6sufrkwuquddwh3fi2lcd2wl44vtnm32xk@2m7ay3k4phrn>
References: <20250827044848.17374-1-bagasdotme@gmail.com>
 <87wm6p9v8l.fsf@trenco.lwn.net>
 <20250827113312.62162725@foz.lan>
 <877byp9f63.fsf@trenco.lwn.net>
 <20250827144757.26599d50@foz.lan>
 <87tt1s9ap4.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tt1s9ap4.fsf@trenco.lwn.net>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Wed, Aug 27, 2025 at 07:05:27AM -0600, Jonathan Corbet wrote:
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

> We can tweak it, but I'd rather not change the meaning, and, more to the
> point, that document needs significant work rather than low-level
> tweaking.

On a better look on the entire document, I woudn't change a single
word... IMO, this is a masterpiece where any changes would damage
it... Every time I read this, it makes me laugh so hard that tears
roll down my face :-D

While it brings some real tips, it was written to be annedotical.

So, from my side, I would just keep it as-is, even if someone
write another document better describing Kernel management
style.

-- 
Thanks,
Mauro

