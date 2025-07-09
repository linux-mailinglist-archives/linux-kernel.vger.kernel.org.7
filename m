Return-Path: <linux-kernel+bounces-724116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A82AFEECF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 18:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CA091C802D7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C3D20C010;
	Wed,  9 Jul 2025 16:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvsmipTg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6033F1F8EFF;
	Wed,  9 Jul 2025 16:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752078105; cv=none; b=QDU3z4JHa5r7/oavaJ28S17u0GBZZj/ELJ9qp9vK69QRvHhPJvxRrqkhGfcnx78fS2+de2lN2L7AXZGTq8g1ViYEOtXs9+DgDR0NSEpu4xUpm55nVHRhmiCLSLJZ/7YLvtYzRPjthaSr2LIxcXJqc577Ol+Nv8p4R9aj2LAtN0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752078105; c=relaxed/simple;
	bh=mn8Di1LqckWD1U8ihxspuXcRxANQNqwmyXe7kFO30HI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eprSdUUMcFI97mSJbvAFuaNY/JEwlEZ2dndltxNirJWGtJ6FamT9oc1y25KY0mLGSKw5YZjotyT1kBndHvcOe7xyEnuLt6Hf2wFf4BLOTWozmYD9n4NNKM41lWKlYzrrCfTZsG9H5606uiy9imEsZ5us1pFwiuPFVV0J/APPNPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvsmipTg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF2AC4CEEF;
	Wed,  9 Jul 2025 16:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752078104;
	bh=mn8Di1LqckWD1U8ihxspuXcRxANQNqwmyXe7kFO30HI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kvsmipTgsZjwnKNnzQ/7pWyDzraXldK3A852muhqu7e4CXPgwskGF1gI9mpkrUVaU
	 7F8VHVCbheJ2GuzI/FSI7lLHMlJVYF/pf6kh0aIKBOUh3sPZOJnzMds6FpeLnFqMYj
	 fdUXUOXxJsshkkXRwC1xlGKTpVwxwofRgdMUi/V8z7Yk/JvOdqgwd9KQBUrZ2+5qBp
	 jXBfRdrHAzJ7ILi1ws+EuMOf0y80cYc26sIyzBwQyZig1iwNFz2sjU5126vmikG3L0
	 K/ntSmWVxMAyUF+XHZsMmTEurnIFnzmhBv+sHwM3gpPgjoEB0tZAXoJb6tiXgoTcQH
	 o9ILRYB4ZGiDg==
Date: Wed, 9 Jul 2025 18:21:40 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 00/12] [PATCH 00/11] Thrash up the parser/output
 interface
Message-ID: <20250709182140.2aab448e@foz.lan>
In-Reply-To: <87cya92xif.fsf@trenco.lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
	<87cya92xif.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 09 Jul 2025 09:29:28 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Jonathan Corbet <corbet@lwn.net> writes:
> 
> > [I'll slow down soon, honest - real work is piling up...]
> >
> > The kerneldoc parsing phase gathers all of the information about the
> > declarations of interest, then passes it through to the output phase as a
> > dict that is an unstructured blob of information; this organization has its
> > origins in the Perl version of the program.  It results in an interface
> > that is difficult to reason about, dozen-parameter function calls, and
> > other ills.
> >
> > Introduce a new class (KdocItem) to carry this information between the
> > parser and the output modules, and, step by step, modify the system to use
> > this class in a more structured way.  This could be taken further by
> > creating a subclass of KdocItem for each declaration type (function,
> > struct, ...), but that is probably more structure than we need.
> >
> > As a final step, add some structure for the accumulation of the output
> > text.
> >
> > The result is (I hope) clearer code, the removal of a bunch of boilerplate,
> > and no changes to the generated output.  
> 
> Has anybody else had a chance to look at this?  Or should I assume it's
> perfect? :)

I didn't look on it yet. I'll try to look it along the week.

Regards,
Mauro

