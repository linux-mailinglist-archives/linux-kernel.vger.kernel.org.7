Return-Path: <linux-kernel+bounces-780530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C37CAB3031D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 21:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D586C725BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 19:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F9534DCC7;
	Thu, 21 Aug 2025 19:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMRNMWwS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48AE236A8B;
	Thu, 21 Aug 2025 19:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755805394; cv=none; b=AEEMbpGlYFYnJXpDuvsjsZxLYQgiiBpPS49Dg1c/SGbnvZiVPX5K/Icua6EvFtzt8GuGSxzO1EbmB60uE0eCbuT/gzeVQX8pc5dIU35Scwjj2Z4LkeCJA2Mf16d0l2SUpuFQYmyWywuZ+zssaHjh/7CyjqAk9Eubxq1uHBmE7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755805394; c=relaxed/simple;
	bh=L23/zroN9JWTfTEUYJJ/Vts5g9sDCzITtZ0DooFjYgI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hf1wkVfc3bQQhqF37tyIN6MGLxWp8vyr9oiUw2ugqlONyMERQY08kyK9/EZOnbB2J9LIST1CVQ9eQm2U3DxWVEU+XKoUVu5ioni4VYDEOV40Fqq3N1gYFucTwu6mj+z6QFVHiowOdfU6gMlnuG7xbxcR6vf/l2JdsZeAX343TjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMRNMWwS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD5CC4CEEB;
	Thu, 21 Aug 2025 19:43:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755805394;
	bh=L23/zroN9JWTfTEUYJJ/Vts5g9sDCzITtZ0DooFjYgI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kMRNMWwSoVySP9oED/kxQSOMkcCwS8ZzIocI3YiKLXRkd5GsZDGVEd3TB9gjxC/mi
	 ttRYs64uA0GkBYy9TT5c+B/gU3Tn/xttobcikaVQaxQZJvomEZTXeQURNtXrk/WmID
	 MsxPZxPN8DFoV0ZTSq5WwT6cDYatJ9S7+j0l1V63oio4sAuUiqOcfRj1ZWr1kmhJL+
	 z1q87R9Z3No4qEacrax0B/db/LsBrjRuxJt8sa6kraQx294vhlMvzH/Va7260bfGxV
	 YFvGRo+h1tu43U6r0u+TPIgTFu3tZYsfshh4LefBW7y/ZrtMEYcI4gkKRQZaMIWpLY
	 2yDOJKJYSNwSg==
Date: Thu, 21 Aug 2025 21:43:08 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, =?UTF-8?B?QmrDtnJu?=
 Roy Baron <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary
 Guo <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 04/11] scripts: sphinx-build-wrapper: add a wrapper for
 sphinx-build
Message-ID: <20250821214308.08835b9f@foz.lan>
In-Reply-To: <87v7mg5ux3.fsf@trenco.lwn.net>
References: <cover.1755258303.git.mchehab+huawei@kernel.org>
	<88a95c7f6996cafb247d6706060173b17a46d570.1755258303.git.mchehab+huawei@kernel.org>
	<87v7mg5ux3.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 21 Aug 2025 13:36:24 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > There are too much magic inside docs Makefile to properly run
> > sphinx-build. Create an ancillary script that contains all
> > kernel-related sphinx-build call logic currently at Makefile.  
> 
> So I am just now looking at the script and seeking to understand it, but
> one thing has jumped at me that I wanted to toss out there...
> 
> > +# Minimal supported Python version needed by Sphinx and its extensions
> > +MIN_PYTHON_VERSION = parse_version("3.7")
> > +
> > +# Default value for --venv parameter
> > +VENV_DEFAULT = "sphinx_latest"
> > +
> > +# List of make targets and its corresponding builder and output directory
> > +TARGETS = {  
> 
> We don't at this point have a formal coding standard for Python code,
> but I do think that we should, to the extent possible, stick to the
> rules that have been established for C code.  One thing I would really
> like to see is in the comment style; our rules want:
> 
>     /*
>      * ...C comments spread out with the markers on separate lines
>      * like this...
>      */
> 
> so can we do something similar for Python?
> 
>     #
>     # Markers above and below
>     #
> 
> I will confess that this matches my personal subject preference, but it
> also brings us closer to what our C code looks like.

Fine for me. Can I do such changes on a patch at the end of the series
to prevent rebase conflicts?

> (I don't know that I would push to redo everything to match that style,
> but instead to move that way going forward).
> 
> Thanks,
> 
> jon



Thanks,
Mauro

