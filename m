Return-Path: <linux-kernel+bounces-727956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23164B021BF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCE34A47036
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:28:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E90A2EF2BF;
	Fri, 11 Jul 2025 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5mgXTrr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FA32EF2A4;
	Fri, 11 Jul 2025 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752251331; cv=none; b=djlD9QbH5AP1wAeE1koWZVE8Zyjvwvch5hknWphQD0JhjAh79yTzloaGg+wjD0paEbY6oVGLpxeea9OImE7fIywjL1JxyLGUNM9ZoufsVvxuEdAVlY6r5iHoe0jLxrFJCIwTX8u4H5OXrMz/8G0VPpb1IFyI3dddfaptpiaWmQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752251331; c=relaxed/simple;
	bh=EzWhlAF2VGLQuGQjva6ZmyCufDGYOPCqsDUysRHteQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAk5WQHxLGzGMQB094QxZKhTtmzqffPaYPLHNTZMHS/MKJrlIgEvw12pD7yAAe5a0Bl4pR32zkSDL3BijX+0PAb6hAv/EphkzOhzxCpidu8au5TDET9TdkHQISfYnWz5u0xTEk4MJQeoXQ8oqgGDY+mlN5tpuB4xFo4mf73ov4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5mgXTrr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BE1C4CEED;
	Fri, 11 Jul 2025 16:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752251330;
	bh=EzWhlAF2VGLQuGQjva6ZmyCufDGYOPCqsDUysRHteQ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O5mgXTrrDyrA+wBdsclgce+hF3ChbEIUtEzx6m2RgO3SQdjGfOb3gfzbuGTq7xQOF
	 KGMn/DEMyMuMczZrMiczpGvf4bU49xZF4D3vCKD4/lWk/Q4TUfzzOyflw6xVu6LtnD
	 nMMPdIoQ9WG1dBtImgQEx/A7rggPyOCrStKn8Xa0scj5GyCf42+X2bTayxVjzCfmtx
	 /8iuWQdzUm2b+mBHbJrLjbozCQT34RrWzc2oB2oMLAmfj64zh9Mj7ntEZTkHbIuuPt
	 OOZgpxaP+OR1NxG3AS4neTNr4oO0tYQfrzP5AU4AovzUMoYj4pIZkXE/T6s1nuee54
	 NwGrfZCd8Tjvg==
Date: Fri, 11 Jul 2025 18:28:42 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 12/12] docs: kdoc: Improve the output text accumulation
Message-ID: <20250711182842.691bc43c@sal.lan>
In-Reply-To: <87y0sux57t.fsf@trenco.lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-13-corbet@lwn.net>
	<20250710084119.3e5c1ced@foz.lan>
	<20250710091352.4ae01211@foz.lan>
	<20250710101931.202953d1@foz.lan>
	<87bjpry67n.fsf@trenco.lwn.net>
	<20250711081400.78731086@foz.lan>
	<87y0sux57t.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 11 Jul 2025 06:49:26 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Em Thu, 10 Jul 2025 17:30:20 -0600
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> >  
> >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> >>   
> >> > With that, I would just drop this patch, as the performance is
> >> > almost identical, and using "emit()" instead of "+=" IMO makes
> >> > the code less clear.    
> >> 
> >> I've dropped the patch - for now - but I really disagree with the latter
> >> part of that sentence.  It is far better, IMO, to encapsulate the
> >> construction of our output rather than spreading vast numbers of direct
> >> string concatenations throughout the code.  So this one will likely be
> >> back in a different form :)  
> >
> > The main concern was related to performance penalty - as based on
> > the latest test results, Pyhon currently handles very poorly list
> > concat (30% to 200% slower at the latest test results).  
> 
> Yes, I understood that part
> 
> > Yet, at least for me with my C-trained brain parsing, I find "=+" a
> > lot easier to understand than some_function().
> >
> > Btw, IMHO Python is not particularly great with names for concat/accumulate
> > commands. For list, it is append(), for set it is add(). Yet, "+=" is almost
> > universal (from standard types, only sets don't accept it, using, 
> > instead, "|=", which kind of makes sense).
> >
> > Adding a function naming emit() - at least for me - requires an extra brain 
> > processing time to remember that emit is actually a function that doesn't
> > produce any emission: it just stores data for a future output - that may 
> > even not happen if one calls the script with "--none".  
> 
> OK, I'll ponder on a different name :)

I'm fine with that.

> Perhaps the new not_emit() could even be aware of --none and just drop
> the data on the floor.

The code already does that on a much more optimized way. This
is actually one of the improvements over the Perl version: we
don't need to implement anything special for none.

When --none is passed, the code sets out_style = OutputFormat(), 
which is pretty much an abstract class that doesn't do any output 
at all, and from where the ManOutput and Restformat classes
are inherited.

It only does two things:

- Applying filters, in order to filter-out warnings from things
  according with --import/--internal/--function arguments;

- print warnings for symbols after filtering them, with:

    def out_warnings(self, args):
        """
        Output warnings for identifiers that will be displayed.
        """

        warnings = args.get('warnings', [])

        for log_msg in warnings:
            self.config.warning(log_msg)

So, there's no emit()/no_emit()/print()... there. All output
types do nothing:

    # Virtual methods to be overridden by inherited classes
    # At the base class, those do nothing.
    def out_doc(self, fname, name, args):
        """Outputs a DOC block"""

    def out_function(self, fname, name, args):
        """Outputs a function"""

    def out_enum(self, fname, name, args):
        """Outputs an enum"""

    def out_typedef(self, fname, name, args):
        """Outputs a typedef"""

    def out_struct(self, fname, name, args):
        """Outputs a struct"""

Regards,
Mauro


