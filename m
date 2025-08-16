Return-Path: <linux-kernel+bounces-771878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EECB28C7A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 11:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD2281C85B69
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 09:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F6314A60C;
	Sat, 16 Aug 2025 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmKYzO4V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214E24468A;
	Sat, 16 Aug 2025 09:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755336848; cv=none; b=fVhoFd2GqUQQj3d00m0ept5IUseanBiHBIlHPbhXSi031DLLkGXK2dy1W+CgX43s6ug99wDozkDCVKIyXuZKAAZnwT72PzzQ0heDFN68+diXRtLJM0fVV8E9Wsv/RvW7ku4g3ENbuM53AOL+dAJUo/9OlsCSnuztoPLMSl6ibng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755336848; c=relaxed/simple;
	bh=9ZlrH42z0Rt9bcphqirSlhUb+yVIM+a1mGgShto9/20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fQQVwzQ/md2eYz0Gi6igW7A9+czPG8c54QJyxVu6pCyyqkN3C2Gmx57LGmgH2EZ/TRD6KU2a8XijJ07XkQzJGb83CJtdhwQtAi89Xlalae9ooL/zWf8cwx+QswE3u95uHkniUAac+fsKLe1YlPdp2H5e91N67u3MusYh6qPPqN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmKYzO4V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E6DC4CEEF;
	Sat, 16 Aug 2025 09:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755336847;
	bh=9ZlrH42z0Rt9bcphqirSlhUb+yVIM+a1mGgShto9/20=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cmKYzO4VC/MrLptj0vOekkPqwjfN856SyYBvuWvqyhJ9gGxIfs2hzYPnm3Umofb1l
	 S5Wmzs/q9CEkcjOCit1AnuKjcoAYbXXRpRX+Ky2dJaJ21i2eDDGnIr/cPnr9XF/zNZ
	 RqAB6AB7ftYBm55i0iaEhKeGlXzQ5lw7f3nmnvuzQnoejIlFxZ3J+8V4cP+Omuqlyv
	 phR1kYIg79nRR0U/6gZVNKFu3BUtn68rjvXgs9dNOkdaFYdyAJjh4p2gZE5EbMO2Qa
	 BBWP+gRA5uEijMpYXII+8deKkZz1utTJHxkMUjWiRI9efRaAD4MLSbghYMtfl/LGLQ
	 CJ+rU+2EKX4CA==
Date: Sat, 16 Aug 2025 11:34:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 07/13] docs: move sphinx-pre-install to tools/doc
Message-ID: <20250816113403.4e007b62@foz.lan>
In-Reply-To: <87ms80crfi.fsf@trenco.lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-8-corbet@lwn.net>
	<20250814013600.5aec0521@foz.lan>
	<871ppehcod.fsf@trenco.lwn.net>
	<20250814080539.2218eb4e@foz.lan>
	<87wm76f1t5.fsf@trenco.lwn.net>
	<20250815071829.3d5163fc@foz.lan>
	<87sehsen9g.fsf@trenco.lwn.net>
	<20250815171342.3006f30a@sal.lan>
	<87ms80crfi.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 15 Aug 2025 13:31:45 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> >> I'm not sure we need the common/docs intermediate directory.
> >> 
> >> Meanwhile, I had a related, possibly unpopular idea...  Start with
> >> .../tools/python/kernel and put a basic __init__.py file there;
> >> everything else would go into that directory or before.  The imports
> >> would then read something like:
> >> 
> >>   from kernel import abi_parser  
> >
> > Not against something similar to it, but IMO "kernel" is a bad
> > name as it sounds something that runs in kernel stace or for Kernel
> > build. It could be, instead:
> >
> > 	from lib import abi_parser  
> 
> Part of my purpose was to make it clear that the import was coming from
> our own library - to distinguish it from all of the other imports that
> these programs have.  "Kernel" seems good to me, but we could call it
> "kernel_lib" or some such if we really want.  "lib" seems too generic.

Ok. let's stick with "Kernel" then.

> > Yet, I guess it may still need to add something at PATH, depending from
> > where current working dir the script was called (but tests required).  
> 
> That seems hard to avoid, yes.
> 
> Of course, we could require that all kernel tools run in a special
> virtualenv :)

No need. Yet, if you look at sphinx-build-wrapper, it has a "-V"
command line. If used, it will either pick a venv name or seek for
sphinx_latest and run from there. I wrote it mainly to help me
on my main devel machine, where I opted to have several different
venvs instead of installing via OS.

I was tempted of making the tool autodetect venv, if sphinx-build
is not found. I opted to not do it for now, but keeping it in mind
for a possible future change. There is also a code that detect if
Python is too old, running a newer version of it if found at the
system if required by the tool to run. 

Maybe we can place both logic into a library and let most tools
use it, adjusting the main function call to something like:

	MIN_PYTHON_VERSION = (3, x, y)

	def main(...):
	   ...

	if __name__ == "__main__":
	     run_on_version(MIN_PYTHON_VERSION, run, use_venv_if_available=True)

> > Btw, nothing prevents moving extensions from Documentation/sphinx
> > into tools/sphinx_extensions. We just need to add the path insert
> > at conf.py.  
> 
> I feel less of a need to do that; it seems that the Sphinx-specific
> stuff can stay where it is.  Though I guess I wouldn't scream too loud
> if people really wanted to do that move.

Ok. As on extensions we always have srctree set (sphinx-build-wrapper
warrants that), the PATH will always be relative to the kernel
directory, e.g.:

	srctree = os.path.abspath(os.environ["srctree"])
	sys.path.insert(0, os.path.join(srctree, "tools/python"))

	from Kernel import abi_parser

The only advantage of moving them to tools/python would be to remove
the need of "srctree" env, using instead os.path.dirname(__file__), 
e.g.:

	sys.path.insert(0, os.path.dirname(os.path.realpath(__file__)))
	from Kernel import abi_parser
	
but still at lease some extensions still need srctree anyway. So,
not really necessary.

So, let's not touch it then.

Thanks,
Mauro

