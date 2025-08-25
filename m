Return-Path: <linux-kernel+bounces-785260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84558B34843
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 19:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF33E163EEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CA4301033;
	Mon, 25 Aug 2025 17:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DCiS2xVR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370FA10E0;
	Mon, 25 Aug 2025 17:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141881; cv=none; b=l/brquQkftt6xsXfs9Wa8JEiOar3ZCjswnLV0UPqiPn999fBe/RnL8E2GhikW3xebOn5/Skub1FqFrMBdZ/DZTlnQdd+rzgRzl6tT4qRjSbapeXcVINaiZRtU63/W/OF1FN+JuBaHcSUPJesBLqxZkdmBCi69tHmaQzFztEMI+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141881; c=relaxed/simple;
	bh=hdIIENtH9zqyZlc++8vJ+/B9EbVP4xLHuAD418TQ2dw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3joC5NPzZfZ8iaFEWMZ5dJI6dXer7pTeM0oPukks8zZmgMeIS6yXcrTiwoJrm+eYzgpcI+qUAtfsHG2XrEuamjwJBhntD7DUM2VtJCtcXWs4z18yirc9Hj23i4VwWE4Rn7EQ/0fSsXHbcCp3lzzpt/FntJqQ6Uq2ltGiIZ+7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DCiS2xVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A76B5C4CEED;
	Mon, 25 Aug 2025 17:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756141878;
	bh=hdIIENtH9zqyZlc++8vJ+/B9EbVP4xLHuAD418TQ2dw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DCiS2xVRUGv441ZdLRsWvgP4DOb6rhxXAG4ji/M+nUwAPG61cSaxkbEjjfRHpJS6E
	 T8nzFmoomysuUaOIIBkDR5hra1jmtNNLh65YtRsSxWmx+xppGDlBqXLfBaHUeLQzIB
	 um9EoHn9XcJKq0LnS6xdlj7A62y9OyUkG5aEbvRXmkpY/dtrTX8O8K633LUAgmoUf9
	 FYdZW8mCdiHGpX71dAKO4iEWw1rTTsuSENlqKX86yVMhAEI6sFjDexNt88ioGWk1j+
	 HYlO9hBn3anZdhRr2onBNDixlVVYT1UC+ZNdHtDxYEPryLPGq4kW+BPAPYVcuxNaZJ
	 zO78MOZYGzrbA==
Date: Mon, 25 Aug 2025 19:11:14 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/14] docs: conf.py: extra cleanups and fixes
Message-ID: <20250825191114.705deebf@foz.lan>
In-Reply-To: <87ldn7d2bu.fsf@trenco.lwn.net>
References: <08d16c2ad817910eb5606842f776d3f77d83282f.1755763127.git.mchehab+huawei@kernel.org>
	<f5d4804c-9a51-443a-a73e-d9c043673cbc@gmail.com>
	<fa7rreuvodpe673lwcwlj6kddkpnmkoxlz4y5mythgntkmveey@m5fqvtsuel6l>
	<87sehjdlz5.fsf@trenco.lwn.net>
	<20250825140719.18ba8459@foz.lan>
	<87ldn7d2bu.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 25 Aug 2025 06:15:49 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Em Fri, 22 Aug 2025 16:34:38 -0600
> > Jonathan Corbet <corbet@lwn.net> escreveu:  
> >> Can we try to get a handle on that and, if it's truly needed, document
> >> why?  I will confess that I'm confused by it:
> >>   
> >> > \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}    
> >> 
> >> As I understand it, the arguments are {options}{package}, right?  so I'm
> >> not sure how this would work...?  
> >
> > Heh, you're right: the argument is reversed. Also, I repeated the
> > tests here, and were unable to reproduce the issue I had with xindy.  
> 
> Just to get the credit where it is due, it's Akira who first pointed
> this out.

Yes, I know: by you, I mean you both ;-)

Feel free to add a reported-by at the actual patch... I ended 
forgetting about that.

> 
> > So, let's just drop it. If we needed, we can re-add, reverting the
> > parameter order there. Patch is at:
> >
> > 	https://lore.kernel.org/linux-doc/83068bc31839e7095f1f408e49658362d467797e.1756123459.git.mchehab+huawei@kernel.org/T/#u  
> 
> OK I'll get there.

Thanks!

Thanks,
Mauro

