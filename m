Return-Path: <linux-kernel+bounces-823502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A76F6B86AAE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA2417BA70F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE802D3EC7;
	Thu, 18 Sep 2025 19:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A82j2rd3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EF92D248F;
	Thu, 18 Sep 2025 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223389; cv=none; b=U7vZmdChGVpNLB07p9TIk5x9XwlHW0/1RDkLZZnFsXi4DKc/eCQq3tvBoHAmuRVY+8MnZyUs6EmKeJ3Po+BpFO+lVMAp9DA/xu0egGexqToJThYKRelysSO3Bxf/92XzWYqoc7+5AYQ67Srls3UDgOkPe0/SM8BCoIg6I4Gu330=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223389; c=relaxed/simple;
	bh=EUKz/tMwLw6tu55uyU72O2QeH0G3Sj5LFwFa+PycQcU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BdE0MJkvRoTUELTgEkz+wht1iwuDhfKC1kizwT31Csv/sQ8B7zjAI3Jw5NyaWrjU7x+SClKLe6syJSwOg+vptFGtgdBhhkGXPNDjOx9e/LSM+Wf1S9ESl4HtpS2ef2ufJF3RgX9eE+30t4QxxPaOTx6Msbi3/gDDLHJW46QN1Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A82j2rd3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BD7C4CEE7;
	Thu, 18 Sep 2025 19:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758223388;
	bh=EUKz/tMwLw6tu55uyU72O2QeH0G3Sj5LFwFa+PycQcU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A82j2rd3KLAvyrYHjTowDxJkQy57fOVK/YzAYt2fjMR8MwFD3IcEIkTZgf+oXS4mI
	 BufH5pvloxnm2YCHxy3nQpZsh9hGBPsSrDR6H96FBkM9Oxf84WQtHG/jBksPkZM7Sl
	 3oLNsXC/USYbIrFXqQnY/+7Rb0e/PT6+KJeazQI1TtWN25WNN8MKaloXJA0IoflX3f
	 j+E7uDvosFDkkXL8W5/jwj2E/GA1kqPQFQ87IwUCw8fNU6v08YN7Tlc4N49k6Lz2mR
	 sF5PqVuS4k/YpO5wfmtHi66d1go+Jz1alB5NOmo2wEl5IRrK85gdh4Z3jrykHRuZ6G
	 VoZl5ICmC2B+g==
Date: Thu, 18 Sep 2025 21:23:04 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH v8 00/24] Split sphinx call logic from docs Makefile
Message-ID: <20250918212304.0efa2847@foz.lan>
In-Reply-To: <87ldmb7iuo.fsf@trenco.lwn.net>
References: <cover.1758196090.git.mchehab+huawei@kernel.org>
	<87ldmb7iuo.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 18 Sep 2025 11:47:59 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Hi Jon,
> >
> > v8 contains a bug fix for ./tools/docs/check-variable-fonts.py command
> > line together with a new --deny-vf argument to it, plus addresses
> > a couple checkpatch warnings. Only 4 patches changed: patches 1, 2, 4
> > and 5.  
> 
> OK.  I have applied this to a branch called build-script in my tree.

Thanks!

> Applying it to current docs-mw (or docs-next) was a bit of a challenge,
> due to merge conflicts with the makefiles, but I got there.
> 
> This work is now merged in docs-next (and will thus show in linux-next),
> but it's not yet in docs-mw, so we're not committed to putting it into
> 6.18.  My current thinking, if all goes well, is to shift it to docs-mw
> just after the merge window.

Sounds like a plan.

> It all seems to work for me, with one little oddity: the "Indices"
> section in Documentation/rust/index.rst (which is protected by the usual
> ".. only::" block) is being included in the htmldocs build, leading to a
> spurious "Indices" entry in the left column.  Something about the way
> the rust directory is being build sets "subproject" maybe?  

The only differences with rust is that:

1) it calls sphinx-build with:

       if rustdoc:
            args.extend(["-t", "rustdoc"])
	
   where -t is:

	  --tag, -t TAG         define tag: include "only" blocks with TAG

2) it calls rust makefile at the end of the build with:

        if rustdoc:
            if "MAKE" in self.env:
                cmd = [self.env["MAKE"]]
            else:
                cmd = ["make", "LLVM=1"]

            cmd += [ "rustdoc"]
            if self.verbose:
                print(" ".join(cmd))

            try:
                subprocess.run(cmd, check=True)
            except subprocess.CalledProcessError as e:
                print(f"Ignored errors when building rustdoc: {e}. Is RUST enabled?",
                      file=sys.stderr)

Both are there to mimic the original behavior, but maybe we need to
use cwd=<some_dir> to simulate the exact makefile behavior (although,
on my tests, not setting it seems to be the right choice, due
to O=build_dir).

> I haven't
> had the time to figure it out.

I don't remember anymore what "subproject" really means inside
".. only::", block, but I guess it is meant to be used when one
passes SPHINXDIRS.

Anyway, if I have to guess, I would try commenting out the "-t"
logic and see how it affects the output. If nobody steps up, I'll
try to do it probably next week, as I'm a little busy tomorrow.

Thanks,
Mauro

