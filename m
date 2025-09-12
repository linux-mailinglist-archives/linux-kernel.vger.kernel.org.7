Return-Path: <linux-kernel+bounces-814006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C38B6B54E2A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CACC17A4AF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDED126561D;
	Fri, 12 Sep 2025 12:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bi95CEmk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E33C15E5D4;
	Fri, 12 Sep 2025 12:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757680459; cv=none; b=WxE8gHTekmnFP8JsHHFE1stuRLvTjILRkjf1dnnRteT55PA5doOsObN84U+Qtza+To6rhaJiBgyl4zQ+gkVX4Cqtl2gAbYLI/J1t6dUq/CeV9BceZ9c+gDTy09G6RU2GmoXXtZo4V5jM6qAi6KWGuA93jcxhY7EeuD/inkhDFSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757680459; c=relaxed/simple;
	bh=Tjc4aRuxymCZ05qVsiyWO+INl0NvIFXtmcqG+Mtz0Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyogaJzftVWj6btrRWGQlxI64R7w/uqeknlGPGx7vXHpENMqSPf9Vo0AP/i7p7qs5f0boPQn0uExtkXcble8x1hu+dDMYS6JbmVWX4R37aBokLrBmmp8kBWGvEnjZ19gA5s6NIqkm7BWIPKHpFlJs+d9OIWsUoY2i/JgovsN0OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bi95CEmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88714C4CEF1;
	Fri, 12 Sep 2025 12:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757680458;
	bh=Tjc4aRuxymCZ05qVsiyWO+INl0NvIFXtmcqG+Mtz0Pw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bi95CEmk0eoYHVzLCN/iS98WPmbwI1N+juNar8iZb3wxG3aZRNtHqniXL+qRHnXtb
	 S8+W8qXaODY3RL7D/BIZnhqocVB7jhGlEQvfz5Rb8Q0nF38ehB2+++t86IvrBZ86JX
	 Z6Kdld8IIJi9+a2uPHEeFtsZCYHZBYLkr3BjVSqZMqjd5KrvK0UjwiGMDBsQfdkrOs
	 Tx7HY9l8oicrlNRFNUpU6GqqCHfdnoNWt5ouRFmmuvetb8MVgVDZxsSWICAlOgN4ot
	 BKUoDWxJzI8erAVkfzOebTBvuIjZQYOpSNeX9PpLeq5vIqkHC6J3gqHAL7w4SRnBUF
	 crIg9Xf6QLApg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ux2ym-00000008T70-2e5O;
	Fri, 12 Sep 2025 14:34:16 +0200
Date: Fri, 12 Sep 2025 14:34:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/19] tools/docs: sphinx-build-wrapper: add support
 to run inside venv
Message-ID: <tarfb5x6kg6s3q3yboep6obfvi4s6ahbj2pkcyvgbyvcwrrfxw@v4pnnpjivwwx>
References: <cover.1756969623.git.mchehab+huawei@kernel.org>
 <2158cc4cf1f9bcf4c191f8031c1fb717cb989f7f.1756969623.git.mchehab+huawei@kernel.org>
 <b76575eab805884ee5227ae6f1aded505df4ec56@intel.com>
 <20250912104639.4781b638@foz.lan>
 <4d7acb77be634212056426aee139496da42dc520@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d7acb77be634212056426aee139496da42dc520@intel.com>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Fri, Sep 12, 2025 at 12:22:42PM +0300, Jani Nikula wrote:
> On Fri, 12 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > Em Wed, 10 Sep 2025 13:51:40 +0300
> > Jani Nikula <jani.nikula@linux.intel.com> escreveu:
> >
> >> On Thu, 04 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >> > Sometimes, it is desired to run Sphinx from a virtual environment.
> >> > Add a command line parameter to automatically build Sphinx from
> >> > such environment.  
> >> 
> >> Why?
> >
> > In my case, to be able to test build with different Sphinx versions.
> > On some distros, only venv works.
> 
> I mean why add the complexity of running inside a venv in the wrapper.

I don't think it venv support is complex.

> 
> >> If you want Sphinx from a virtual environment, you enter the
> >> environment, and run the regular build, with sphinx-build from the PATH
> >> that points at the venv.
> >
> > when you do that, ./scripts/spdxcheck.py breaks, affecting checkpatch.
> 
> Then you could turn the whole argument around, and say spdxcheck.py
> should jump through venv and dependency hoops instead of the docs build.

Neither spdxcheck.py nor checkpatch recommends venv; make docs targets do.

> The point is, it should be the user's responsibility to deal with the
> environment and the dependencies.
> 
> If they're setting up a virtual environment, and it affects checkpatch,
> then they should also include the spdxcheck.py dependencies in the
> virtual environment.

They are because we're recommending it.

> This feels like reinventing pipx in a Sphinx wrapper.
> 
> We should *reduce* the complexity, not increase it.

Complexity is not the issue: There are several things a the Kernel
tree that are complex. Here, the entire wrapper script (not counting
blank lines/comments) is not more than ~300 lines of code, splitted
on multiple functions. This is not complex.

The big issue is what we have now where docs makefile is full of
hacks:

    - scripts to workaround issues;
    - "|| exit" to fix broken latexmk/xelatex error outputs;
    - "+" to use GNU make parallelism;
    - complex call macros;
    - ...

None of those documented.

Liking or not, this series as a whole makes a lot clearer what
is done to build preparation, Sphinx build and post-build steps
that are required to produce Kernel docs. Also, almost half of
it is documentation. IMHO, a lot better from what we have so
far.

-- 
Thanks,
Mauro

