Return-Path: <linux-kernel+bounces-726550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 367E7B00E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B35C254742A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0513295DB4;
	Thu, 10 Jul 2025 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTY+X/YS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745523506E;
	Thu, 10 Jul 2025 22:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752185592; cv=none; b=AiJmBL/g6M03CqXXwlf/vQsm6T8aXZcMiyxDE7/6+8J6R569YUw69FvGz6Scm5hkO2B2gky63VD/ZyyDl1Nptf4HnEaNyoaRHCmfr6XM+9tJfViCPJjGYENPrL6eaUsUOVlxbJhNrF6fRWTbhGdCsAlDf3AEV/5e79Uffqjn43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752185592; c=relaxed/simple;
	bh=fyoMo5wfynJmNzRvUzmJpYBJv2MEGDBldYoG/RP3DM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QNmIIXoxDgjVnBKwVHJ8AxAl06QjtCIfSjQAiRcgfadVYCezd8L1fC/Yn+VwATOje/kVTIE0WkAo7NTfmhyE6WnrQQtm1/I0MtITerekijd2A3SEKtdoZA3CQk4+ppeZ6QMn7RUTas6scuer/HD/d5+NFJfZ9L7T7jmBZmMlI94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTY+X/YS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8C9DC4CEE3;
	Thu, 10 Jul 2025 22:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752185591;
	bh=fyoMo5wfynJmNzRvUzmJpYBJv2MEGDBldYoG/RP3DM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WTY+X/YStdBvEF9OFoh2EgSnxisjHbh6MPwLV73umnOmm8u1VJnmVIIYiyP96Yj3/
	 86HVQmpHUPPBYVfYnC2rY52/EfaIoBDrlrgQar0POYLCxvOt1JM0Mv6YJsp9e+LQ7l
	 7CmiU0R+U31krqiG8Lbx3Fcw411K6ZrEYXS9IraYUeK+Raetl9FNvXUOORluK2ql78
	 CzHp/8BxcamYkcjZSKwc1FZp9OeTLCaas9xFTwWLnWl+GjsVJV3FZZMXNsneLTIutJ
	 qhtpss8ZBNl4ZsPddedKVgUmiCWAAbBeuSQRYhBb3GSBauuQliubuv4QFyH6JWTRUN
	 pjc+9Lg+73YkQ==
Date: Fri, 11 Jul 2025 00:13:07 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 09/12] docs: kdoc: straighten up dump_declaration()
Message-ID: <20250711001307.5b5279ce@foz.lan>
In-Reply-To: <87frf4yy50.fsf@trenco.lwn.net>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-10-corbet@lwn.net>
	<20250710082556.35a909b2@foz.lan>
	<87frf4yy50.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 10 Jul 2025 07:27:07 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Em Wed,  2 Jul 2025 16:35:21 -0600
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> >  
> >> Get rid of the excess "return" statements in dump_declaration(), along with
> >> a line of never-executed dead code.
> >> 
> >> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> >> ---
> >>  scripts/lib/kdoc/kdoc_parser.py | 15 +++++----------
> >>  1 file changed, 5 insertions(+), 10 deletions(-)
> >> 
> >> diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
> >> index 6e35e508608b..7191fa94e17a 100644
> >> --- a/scripts/lib/kdoc/kdoc_parser.py
> >> +++ b/scripts/lib/kdoc/kdoc_parser.py
> >> @@ -878,18 +878,13 @@ class KernelDoc:
> >>  
> >>          if self.entry.decl_type == "enum":
> >>              self.dump_enum(ln, prototype)
> >> -            return
> >> -
> >> -        if self.entry.decl_type == "typedef":
> >> +        elif self.entry.decl_type == "typedef":
> >>              self.dump_typedef(ln, prototype)
> >> -            return
> >> -
> >> -        if self.entry.decl_type in ["union", "struct"]:
> >> +        elif self.entry.decl_type in ["union", "struct"]:
> >>              self.dump_struct(ln, prototype)
> >> -            return
> >> -  
> >
> > The above LGTM.
> >  
> >> -        self.output_declaration(self.entry.decl_type, prototype,
> >> -                                entry=self.entry)
> >> +        else:
> >> +            # This would be a bug
> >> +            self.emit_message(ln, f'Unknown declaration type: {self.entry.decl_type}')  
> >
> > Hmm... Are you sure about that? If I'm not mistaken, this was used for
> > other types of arguments, like DOC: tags.  
> 
> DOC tags are handled in a different path entirely.  I did ensure that
> the code in question was never executed ... but then left the message in
> place just in case.

OK.


If the output didn't change neither for ReST nor for man, that's fine
for me. Besides being a port from Perl, I'm almost sure I hit this
code before during the conversion, but it it is now a dead code,
your approach is better ;-)

While I didn't test, I trust you. So feel free to add:

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks,
Mauro

