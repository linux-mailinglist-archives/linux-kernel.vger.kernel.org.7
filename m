Return-Path: <linux-kernel+bounces-725076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26704AFFA8B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 09:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06103585C40
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 07:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA312882A6;
	Thu, 10 Jul 2025 07:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fc7C7KAk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F442882B4;
	Thu, 10 Jul 2025 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752131636; cv=none; b=rxbTZQQTWgzLoRKXfvXuUziJwnvZZAAUhXdvU5VmG2QgaJBQBa5JSKHIxS/belsrho6uCARktZlhBdaQFCzeZR4/9tuv23VjzlpJYZpR5lbFPHTuLVpSpGUqLCpbW5TFUaeo1hYEmrItjCF592cK6DrGh7H2ump84wJ5/i4STIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752131636; c=relaxed/simple;
	bh=hdRfm4Bc1vo7jizqAwjuIhPIxmBfBrVaGeZdSTTpIE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=otWxAMVSoPpfHYw/qjHtu48VWBpnyopRcqS2yOngJPiyi0r7VgKo0ACCFamWJUPjSNC/4C6oA3DAx0UFEn9RUiYzLNXNDf5Fm7A57s/6RBvaGEdKdYQyhRL7yABXEjox9SKltxczx7wx+hyLokx8uY/1UzIxHdPfBE+Dy+AuKJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fc7C7KAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7FCC4CEF4;
	Thu, 10 Jul 2025 07:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752131636;
	bh=hdRfm4Bc1vo7jizqAwjuIhPIxmBfBrVaGeZdSTTpIE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fc7C7KAkt5khRYDnQJRF9/sU7prycldCaPx23orPVkvSvZvxhm3BHLmMaBiMXSUh2
	 eBsJHM9xyUaCFmAU/waTqF4HD7KoCCyg36KDbgvNFJiHWgMs7/xwYCjvLz9+UeAdlU
	 EJgLjrZ/Ld6gF1SK5ntCOeTagF4dKQMzFPgeKGWXG3G1fAQFrTje5vV9uXG1wzaMQn
	 RGCgfipRjPo8dfzBEBxZdmPUOXwKg/BSdC0X48w0ot4TmwmvnK/lRxr0+iVIRBuv45
	 v0yBeAazIFyYCYy+2Dzp7kj3tAzV2xsbSgnjVczLraeOri3lZqMIWpWdXo3fZWuCu4
	 kWngY0pupAw+g==
Date: Thu, 10 Jul 2025 09:13:52 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 12/12] docs: kdoc: Improve the output text accumulation
Message-ID: <20250710091352.4ae01211@foz.lan>
In-Reply-To: <20250710084119.3e5c1ced@foz.lan>
References: <20250702223524.231794-1-corbet@lwn.net>
	<20250702223524.231794-13-corbet@lwn.net>
	<20250710084119.3e5c1ced@foz.lan>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 10 Jul 2025 08:41:19 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> escreveu:

> Em Wed,  2 Jul 2025 16:35:24 -0600
> Jonathan Corbet <corbet@lwn.net> escreveu:
> 
> > Building strings with repeated concatenation is somewhat inefficient in
> > Python; it is better to make a list and glom them all together at the end.
> > Add a small set of methods to the OutputFormat superclass to manage the
> > output string, and use them throughout.
> > 
> > Signed-off-by: Jonathan Corbet <corbet@lwn.net>  
> 
> The patch looks good to me. Just a minor nit below.
> 
> > ---
> >  scripts/lib/kdoc/kdoc_output.py | 185 +++++++++++++++++---------------
> >  1 file changed, 98 insertions(+), 87 deletions(-)
> > 
> > diff --git a/scripts/lib/kdoc/kdoc_output.py b/scripts/lib/kdoc/kdoc_output.py
> > index ea8914537ba0..d4aabdaa9c51 100644
> > --- a/scripts/lib/kdoc/kdoc_output.py
> > +++ b/scripts/lib/kdoc/kdoc_output.py
> > @@ -73,7 +73,19 @@ class OutputFormat:
> >          self.config = None
> >          self.no_doc_sections = False
> >  
> > -        self.data = ""
> > +    #
> > +    # Accumulation and management of the output text.
> > +    #
> > +    def reset_output(self):
> > +        self._output = []
> > +
> > +    def emit(self, text):
> > +        """Add a string to out output text"""
> > +        self._output.append(text)
> > +
> > +    def output(self):
> > +        """Obtain the accumulated output text"""
> > +        return ''.join(self._output)  
> 
> I would prefer to use a more Pythonic name for this function:
> 
> 	def __str__(self)
> 
> This way, all it takes to get the final string is to use str():
> 
> 	out_str = str(out)
> 
> With that:
> 
> Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>


Hmm... actually, I would code it on a different way, using something like:

class OutputString:
    def __init__(self):
	"""Initialize internal list"""
        self._output = []
    
    # Probably not needed - The code can simply do, instead:
    # a = OutputString() to create a new string.
    def reset(self):
        """Reset the output text"""
        self._output = []
    
    def __add__(self, text):
	"""Add a string to out output text"""
        if not isinstance(text, str):
            raise TypeError("Can only append strings")
        self._output.append(text)
        return self

    def __str__(self):
        return ''.join(self._output)
    
    # and, if needed, add a getter/setter:

    @property
    def data(self):
        """Getter for the current output"""
        return ''.join(self._output)

    @data.setter
    def data(self, new_value):
        if isinstance(new_value, str):
	    self._output = [new_value]
	elif isinstance(new_value, list):
            self._output = new_value
        else:
            raise TypeError("Value should be either list or string")

That would allow things like:

	out = OutputString()
	out = out + "Foo" + " " + "Bar"
	print(out)

	out = OutputString()
	out += "Foo"
	out += " "
	out += "Bar"
	return(str(out))

and won't require much changes at the output logic, and IMO will
provide a cleaner code.

Thanks,
Mauro

