Return-Path: <linux-kernel+bounces-768003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2554B25BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B39A9E2357
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C50242D65;
	Thu, 14 Aug 2025 06:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXFNqxKG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC5D2417F2;
	Thu, 14 Aug 2025 06:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755152499; cv=none; b=i2vy6f8LIW5nXtWJRflzrpHPmtzt5KMG0RWyB+/YhjFNnt33vwOky+zu7X5L0AUdq6czmDNltj1eLrD3jUXaNinCBhn96a5VJhb8WyXcI044JWM5HhgYV4g9jy708PjubI1eyTSqR0gaqUR/VsuXNAuaRmPXOI5BOZpQkgQOGSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755152499; c=relaxed/simple;
	bh=ad0ESFomXR6hzJsoqncZBBl8RJZ2v1U0lsN4nBWb8Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+OicCABW00wJovF7oomYfQ5Dy/tly8s6ykkrZ3sltCarEOJ1O6Jy0LpsY26AisdkGtsWuVuBRU/bJvBELxTi4p687o0Ep3CChcYFZfumoH9Hb5S0WLLATBvCEdsW2h+TyMvuMvDNVs0vHFsj+kPGuFb2z5KnDUqzzE1eSbReXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXFNqxKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F8CC4CEEF;
	Thu, 14 Aug 2025 06:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755152499;
	bh=ad0ESFomXR6hzJsoqncZBBl8RJZ2v1U0lsN4nBWb8Ss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XXFNqxKG2mC81Go6GBQqab31AUbWe57gS4SVHRcMI8rTcN/DCaCmYrnDfgeB6iADP
	 F8t5s+XETAXnIycnQh+UpNDHiy+RSprZZj16GjCIMj+xLzM5xlqiDIZBAHewZIxq6f
	 MaZhy/jTjg8lbyEZBcaX1HfeJuEQ8RdsYj2IxVYDRWU2d4QvOQHJRspX/Ppj9n2IL9
	 L28dJDJ09wVdST0UF/+PIqVHtsajFPdo3COcPnnZfcjsXXMQthqdurIhVA5WQTWs1v
	 ehj2Ye18st1MbY1hYMiif8HbdjyUL63WvWIiXxkloXbEibE1vuRA2+hPu3S2PdYtfG
	 398U0wfSi/fCQ==
Date: Thu, 14 Aug 2025 08:21:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 07/13] docs: move sphinx-pre-install to tools/doc
Message-ID: <20250814080539.2218eb4e@foz.lan>
In-Reply-To: <871ppehcod.fsf@trenco.lwn.net>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-8-corbet@lwn.net>
	<20250814013600.5aec0521@foz.lan>
	<871ppehcod.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 13 Aug 2025 20:14:42 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Em Wed, 13 Aug 2025 15:32:06 -0600
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> >  
> >> Put this tool with the other documentation-related scripts.  
> >
> > This one will be painful, as it will cause conflicts with my series
> > that clean up the docs Makefile.  
> 
> Just in general ... I'm more than happy to put this whole series on the
> back burner until we've gotten that other stuff merged ... it's an RFC
> after all, and there's no urgency here.

Ok, thanks! Yeah, this would help avoiding conflicts with the patches
I have piled here.

Btw, as I said I have a /51 patch series focused on parse-headers.pl
and kernel_include.py, which is currently used only by media docs.

For those who don't know, this was added at the very beginning of
Sphinx adoption, and had its own particular way to create *.rst
files from source code with cross references, via an specially crafted
Makefile that runs before Sphinx. This was written as a way to detect
uAPI documentation gaps, producing warnings for unsolved cross references.
Recent Sphinx versions broke it by disabling cross-reference warnings.

This series is big (51 patches) because it needs to fix thousands of
broken cross references on media. I may end splitting it on two series
to make easier for review, one for the script and another for media doc
fixes.

Such series affect this RFC as it is creating a tools/docs and placing 
there the parse-headers.py code as:

	 tools/docs/lib/parse_data_structs.py                                  |  230 +++++++++++++++--------------------
	 tools/docs/parse-headers.py                                           |    5 

Now, if you prefer tools/doc instead and/or place the libs elsewhere,
we have a couple of options:

1. rebase my series to do the changes. I suspect that there won't
   be much conflicts, but this may delay a little bit sending you
   what I have;

2. add a patch at the end moving stuff elsewhere;

3. on your series, move them elsewhere.

What do you prefer?

Thanks,
Mauro

