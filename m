Return-Path: <linux-kernel+bounces-721138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 190C8AFC528
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 10:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 686FB3B7171
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 08:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C6629B220;
	Tue,  8 Jul 2025 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dde973UF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066E229E0E5;
	Tue,  8 Jul 2025 08:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962390; cv=none; b=qfuKmvwifpi8TGL5fCsFNCXyfySm4SVr8h/NuHVGc9NR5PLD2muBEZVjuBTYwPoDI1r6IFSFejd+oI9Vibdrow3+kh1xyDDpWPLN0elNukt3PV9o93bHSxmbVbnZxkqt7OR47cF1J0rZJx2STJv+h79Gmbv4UjvNRxnw4IbsKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962390; c=relaxed/simple;
	bh=Xes195SfGlKZ98aeHgcfxHWznK0T9TsIdckDbctLdK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CmqMS2VIfTN4euOwimPCNr8l3qIPc0iEJCiKY2z3GE4XqzA31EF7++SDgnnNvwI8gkB7S+qIvNFfBTplKD8neN5WLGfzj3/NmVvyu8npNhR49Jm3UU+Rk0Pdxp29ai/5EcM9y0/beJ3P1G4SyG6mfzlWEunVZ+xMc/JLEGlCUGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dde973UF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78B6DC4CEF0;
	Tue,  8 Jul 2025 08:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751962389;
	bh=Xes195SfGlKZ98aeHgcfxHWznK0T9TsIdckDbctLdK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dde973UFmjftsphWT6dZMGYI3VIRe0ThEgZ9sBID/D8aR7ZnYI2cCcRnMpE/Ff+vY
	 6JkguvsLyECsmGhQRTADjbyWsUGqCBGdKJvuDg45xJJZFveik7fB+YF/oby8hqiVwp
	 rfN/qG8sRo/SMbmY/YkT8D0Iq4bpSxGyvck9df9JfnoQEDdQ5OA3nR2Fi67k0F2QSd
	 5ipE1AHRsGQtk/GZilW8ejbe8HT6ff45yH4mWsc0qgEdQIWvVA47151PSQnKrswW6L
	 /l5SblUqAVRMNjsomDtlRp/gsbaklk24HsSSmOE/SV8cby0Pruf+ds6hrzsRt1DAY2
	 M0txE0uMerHIQ==
Date: Tue, 8 Jul 2025 10:13:03 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH v2 2/7] docs: kdoc: micro-optimize KernRe
Message-ID: <20250708101303.142ea3ee@foz.lan>
In-Reply-To: <87a55kj926.fsf@trenco.lwn.net>
References: <20250703184403.274408-1-corbet@lwn.net>
	<20250703184403.274408-3-corbet@lwn.net>
	<20250704003146.118f5799@foz.lan>
	<87ms9kkfb2.fsf@trenco.lwn.net>
	<20250704080140.136b0b38@foz.lan>
	<87a55kj926.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 04 Jul 2025 08:59:45 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Em Thu, 03 Jul 2025 17:47:13 -0600
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> >  
> >> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> >>   
> >> > Em Thu,  3 Jul 2025 12:43:58 -0600
> >> > Jonathan Corbet <corbet@lwn.net> escreveu:
> >> >    
> >> >> Rework _add_regex() to avoid doing the lookup twice for the (hopefully
> >> >> common) cache-hit case.
> >> >> 
> >> >> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> >> >> ---
> >> >>  scripts/lib/kdoc/kdoc_re.py | 7 ++-----
> >> >>  1 file changed, 2 insertions(+), 5 deletions(-)
> >> >> 
> >> >> diff --git a/scripts/lib/kdoc/kdoc_re.py b/scripts/lib/kdoc/kdoc_re.py
> >> >> index e81695b273bf..612223e1e723 100644
> >> >> --- a/scripts/lib/kdoc/kdoc_re.py
> >> >> +++ b/scripts/lib/kdoc/kdoc_re.py
> >> >> @@ -29,12 +29,9 @@ class KernRe:
> >> >>          """
> >> >>          Adds a new regex or re-use it from the cache.
> >> >>          """
> >> >> -
> >> >> -        if string in re_cache:
> >> >> -            self.regex = re_cache[string]
> >> >> -        else:
> >> >> +        self.regex = re_cache.get(string, None)    
> >> >
> >> > With get, None is default...
> >> >    
> >> >> +        if not self.regex:
> >> >>              self.regex = re.compile(string, flags=flags)    
> >> >
> >> > ... yet, as you're using get, better to code it as:
> >> >
> >> > 	self.regex = re_cache.get(string, re.compile(string, flags=flags))    
> >> 
> >> ...but that will recompile the regex each time, defeating the purpose of
> >> the cache, no?  
> >
> > No. It should do exactly like the previous code:
> >
> > - if re_cache[string] exists, it returns it. 
> > - Otherwise, it returns re.compile(string, flags=flags).
> >
> > https://www.w3schools.com/python/ref_dictionary_get.asp  
> 
> The re.compile() call is evaluated before the call to get() - just like
> it would be in C.  This is easy enough to prove to yourself in the REPL
> if you doubt me...

You're right!

Tested with the small code snippet:

	# test.py
	inner called
	Inner will be called: True
	inner called
	Inner should  not be called: False

I guess I expected too much from python's optimizer ;-) My fault.

Your patch looks OK to me.

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

-

As reference, this was the test code

#!/usr/bin/env python3

def inner():
   print("inner called")

   return True

c = {}

print(f"Inner will be called: {c.get('a', inner())}")

c = { "a": "False"}

print(f"Inner should  not be called: {c.get('a', inner())}")




Thanks,
Mauro

