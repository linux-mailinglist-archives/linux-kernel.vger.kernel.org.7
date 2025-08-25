Return-Path: <linux-kernel+bounces-784634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 604FCB33ED2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9261A841A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0801A2EE60B;
	Mon, 25 Aug 2025 12:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ed5AOFjk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F982EF66E;
	Mon, 25 Aug 2025 12:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123645; cv=none; b=DJL7zGTZSsnhM6QyZcAFMj4MH+ouNBBRHVvxt4uAyM6jjmGFJsPcAfaTlwuQAzm7KsqGle1rO6rIm+L4yp05LFoLM54tYa/UT+kdOf2wA8LYiF3K7hUqJpAjO0szkvQi55WHoo0xDZ/eT9jR6ntqBIr1VPbyIhcNuTRL5XIuMd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123645; c=relaxed/simple;
	bh=F/5K4bMoblHsxI330SNs3Rq5PcPR+MST4mCPPpaDFwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+AWtJuWWIM6WWbFpB1BJ6kCkJgLZbBB81E4ht3rajZtvuFxkhFoXAf0W9DC9xxehcp2pE0mqj2ZyYQdPDSJicaVmfT/mVbXUO4uazW3Qks7hAtCgrrm6iBAD3kLqca1RdFplRLK895t8YYyREoM6bCorkjSLk8W0Jyo4iBYAEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ed5AOFjk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B8F9C19421;
	Mon, 25 Aug 2025 12:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756123644;
	bh=F/5K4bMoblHsxI330SNs3Rq5PcPR+MST4mCPPpaDFwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ed5AOFjkRXXho4jcdJZSkmSXZQk50JS7AcOFODLlsY97LEHVAIe2ZjbMzBQiOCyKw
	 y5WgH2TeOxOILBIgzS2aknkD4HmLnRvGVfsIPRASynvBtwjudT1f9XC6E+BQCQXW2B
	 FFesU/aTkSRBP27qifk+COqGry8Nuy3R6AijAWn6wL+hGkaGP+vnR2KdY3hyKyaBjy
	 RxbeWbxco65UF5SligN5fgggydDn0XAt+Y1eo0I2j3jeP9NifNHl6+Kmgzo1xOj39e
	 9fN5s9N8tEkkbEOcLdSh7RVo5P2ofE/nU1L85iODhvZCCAPWc5WWtxzJik/ZC+CBxj
	 3E8DdO0Y3yeSA==
Date: Mon, 25 Aug 2025 14:07:19 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] docs: conf.py: extra cleanups and fixes
Message-ID: <20250825140719.18ba8459@foz.lan>
In-Reply-To: <87sehjdlz5.fsf@trenco.lwn.net>
References: <08d16c2ad817910eb5606842f776d3f77d83282f.1755763127.git.mchehab+huawei@kernel.org>
	<f5d4804c-9a51-443a-a73e-d9c043673cbc@gmail.com>
	<fa7rreuvodpe673lwcwlj6kddkpnmkoxlz4y5mythgntkmveey@m5fqvtsuel6l>
	<87sehjdlz5.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 22 Aug 2025 16:34:38 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> > On Fri, Aug 22, 2025 at 09:01:03PM +0900, Akira Yokosawa wrote:  
> 
> >> > 3) I got a corner case on one of the distros was using xindy to produce
> >> >    indexes. This ended causing the build logic to incorretly try to use
> >> >    T1 fontenc, which is not UTF-8 compatible.
> >> > 
> >> >    This patch adds:
> >> > 
> >> >         \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}
> >> > 
> >> >    to cover such case. It should be noticed that, as the config doesn't
> >> >    have \usepackage{xindy}, this will be used only if latexmk ends
> >> >    using xindy.  
> >> 
> >> But I can't see how this macro (executed by XeTeX engine) would have any
> >> effect on xindy (command) invoked from latexmk.
> >> 
> >> Can you elaborate on your theory of how it works?
> >> And which distro runs xindy?  
> >
> > I can't remember on what distro I saw the issue, but I got it during
> > my builds, where, instead of running makeindex, it tried to run xindy,
> > with failed because of utf-8 fonts.
> >
> > My theory is that, on one of the ditros, there is a /etc/latexmk
> > or similar containing instructions to use xindy instead of makeindex.
> >
> > In any case, this rule is harmless on setups that use makeindex:
> > it only affect setups where there is a latexmk or .latexmk file
> > setting xindy as the default index builder: if this is used, 
> > xindy will use utf-8 fonts instead of Type 1.  
> 
> Can we try to get a handle on that and, if it's truly needed, document
> why?  I will confess that I'm confused by it:
> 
> > \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}  
> 
> As I understand it, the arguments are {options}{package}, right?  so I'm
> not sure how this would work...?

Heh, you're right: the argument is reversed. Also, I repeated the
tests here, and were unable to reproduce the issue I had with xindy.

So, let's just drop it. If we needed, we can re-add, reverting the
parameter order there. Patch is at:

	https://lore.kernel.org/linux-doc/83068bc31839e7095f1f408e49658362d467797e.1756123459.git.mchehab+huawei@kernel.org/T/#u

> 
> jon  (who will be traveling and slow to respond for a bit)

Thanks,
Mauro

