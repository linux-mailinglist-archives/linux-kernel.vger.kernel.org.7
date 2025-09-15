Return-Path: <linux-kernel+bounces-817266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF54B57FEB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07FE93A4334
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483D832A83C;
	Mon, 15 Sep 2025 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb2eGxQr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945083002A3;
	Mon, 15 Sep 2025 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948745; cv=none; b=F4OlY9yhKcYowK+z21wzJpAGypIQULvH4EPHpa3vH81bQ7YXKMBueOSGvcLXFXoeG5mCb9673UmR+7VH83Jzm/wCNe+STfeKUQ3HyNPDuwX+zqtVjcgsy1UrlJaPBdDaZPVwMyUPFfj9rgvvXLLZ3rUREsyaABz9O8z0x2wAacU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948745; c=relaxed/simple;
	bh=47i5pQEkkKKiG7KfLTvsZvpIllcI7jHYYFbj/kGs428=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XhmDo6MtzKYtV/OEeGEurBvJC5BCLY/LmpQhmLMRkuHhrLuF0OTeWU239YWTCSvD35r54xWGsE0h+U9DaeQr/zN8BPxEC1jP62dSwBM4zZJX5qp0anPcWMoosq0iu62pJZX0cnlZHrmy8Fymm99SVaPjMuAHQpKcbBqo8HlZEKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb2eGxQr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E80C4CEF7;
	Mon, 15 Sep 2025 15:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757948745;
	bh=47i5pQEkkKKiG7KfLTvsZvpIllcI7jHYYFbj/kGs428=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zb2eGxQrYnBRkE6RANwOXCecEibXSFVooOaNiz8HzGwmH22yIQMA3ufQNc5sKyelg
	 qWgvafQv8YwlhHlffvLO42P2F4SVRHKDnUESejPS85K0XzwbfU3uSolps9/moLVjAL
	 C0N2w7hZfhDEqeCFo6z0pzqVWDycV0XC+1POpD03msrhX+awl0hlCvixxtpYCK9yJP
	 7txzcicgyd+mbg0X5e5yuNdLdiSXCsyPYpwfyPR/fiUN9dHrULXiPdHUCu2eGOuwdb
	 tqMbtwNl0QV8gfhJtt4tJyOo61tscek729Kz+0m5ySg9o2h3GpR33Ac1QCeQFZldSi
	 fp6kpnP9xgnLg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uyAlz-0000000ALQK-05Rc;
	Mon, 15 Sep 2025 17:05:43 +0200
Date: Mon, 15 Sep 2025 17:05:42 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Akira Yokosawa <akiyks@gmail.com>, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v4 08/19] tools/docs: sphinx-build-wrapper: add a wrapper
 for sphinx-build
Message-ID: <mfbjzrac7q2vmvieudwagi4n6ozxl5b5ey2vy3z34bjuyweblp@s7gnmdche5cq>
References: <20250910153334.0b3e1440@foz.lan>
 <28c45f53-a3ff-428f-ba99-ebb09e0581d3@gmail.com>
 <20250912130420.6c14dbbd@foz.lan>
 <f3d142be-3980-4d4e-9d66-c03276694bf9@gmail.com>
 <6hhhn5go2yb7ecdrqtuti23i6pfgckqbdk5nhuhn2ijrhmvvmw@awswbm3tvmwp>
 <aa2aa8d2-f7f1-4f04-a9b0-f08160f9ea81@gmail.com>
 <20250915125805.25b48d09@foz.lan>
 <803501857ad28fc9635c84b7db08250dc4b9a451@intel.com>
 <s5gyu27qlfg7frb4v3ssqms6inqammtakwchgl635r3ahooj5n@vhw5tnyti7nd>
 <750e7225a88b7eb81c8f084477ebad66734c4dd7@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <750e7225a88b7eb81c8f084477ebad66734c4dd7@intel.com>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Mon, Sep 15, 2025 at 05:33:37PM +0300, Jani Nikula wrote:
> On Mon, 15 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > On Mon, Sep 15, 2025 at 03:54:26PM +0300, Jani Nikula wrote:
> >> On Mon, 15 Sep 2025, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >> > IMHO, long term solution is to change SPHINXDIRS into something
> >> > like:
> >> >
> >> > 	make O=doc_build SPHINXTITLE="Media docs" SPHINXDIRS="admin-guide/media userspace-api/media driver-api/media/"
> >> >
> >> > would create something similar to this(*):
> >> >
> >> > 	doc_build/sphindirs/
> >> > 		|
> >> > 		+--> index.rst
> >> > 		+--> admin-guide -> {srcdir}/Documentation/admin-guide/media/
> >> > 		+--> usespace-api -> {srcdir}/Documentation/admin-guide/media/
> >> > 		\--> driver-api -> {srcdir}/Documentation/admin-guide/media/
> >> 
> >> So you're basically suggesting the documentation build should support
> >> cherry-picking parts of the documentation with categories different from
> >> what the upstream documentation has? 
> >
> > No. I'm saying that, if we want to have a single build process
> > for multiple sphinxdirs, that sounds to be the better way to do it
> > to override sphinx-build limitation of having single source directory.
> >
> > The advantages is that:
> >     - brings more performance, as a single build would be enough;
> >     - cross-references between them will be properly solved.
> >
> > The disadvantages are:
> >     - it would very likely need to create copies (or hard symlinks)
> >       at the build dir, which may reduce performance;
> >     - yet-another-hack;
> >     - increased build complexity.
> >
> > I'm not convinced myself about doing it or not. I didn't like when
> > I had to do that after the media book was split on 3 books. If one thinks
> > that having for loops to build targets is a problem, we need a separate
> > discussion about how to avoid it. Also, this is outside of the scope of
> > this series.
> 
> I honestly don't even understand what you're saying above

Perhaps it is due to the lack of context. I was replying some comments
from Akira where he mentioned about cherry-picking *.tex files after
sphinx build, and do some tricks to build all of them altogether.

My reply to his comments is that, if we're willing to cherry-pick things,
it is better/cleaner/safer to do it at the beginning, before even running
sphinx-build, ensuring no conflicts at the filename mapping.

Yet, analyzing the alternative I proposed, I see both pros and cons - up
to the point that I'm not convinced myself if it is worth doing such
changes upstream or not.

> and how it
> contradicts with what I said about cherry-picking the documentation to
> build.

It doesn't.
 
-- 
Thanks,
Mauro

