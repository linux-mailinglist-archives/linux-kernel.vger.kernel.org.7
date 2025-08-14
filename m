Return-Path: <linux-kernel+bounces-767973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2412B25B64
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4D51887CCB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 05:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421A62264B1;
	Thu, 14 Aug 2025 05:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gvZSt9+G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6521DE4F6;
	Thu, 14 Aug 2025 05:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755150979; cv=none; b=A5ez+IwJJbk9UDgHLYvHzvEzUAPm1l8xlLmeGGpX3YcVRlnuDblesT2xTdAXZ8vnmGIsxj4pgjnayiqaD2n7kZPfVilGJqJe18t3LRIKJqdReNYNHOI4iv+B46NqxcTwJeiBzCh2PLyDHtcY7adbZu1QWwe9aoSV2V16eaez0ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755150979; c=relaxed/simple;
	bh=NK79IvW2jnUm7SuTk5S6mHgygB+AOQGAUoMR8qBGjhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gBk2P3rVEXP9+chkbP/B7c5Z4eXiLt6Hfa4wZFlgIH+SSsgQW1aMnVaGW5gdS2TtFKts27iyvRPcHyMuJYJSZOzGJN2IhGZcsdyRXxoC3RpsWCD0otFHPKDtSvl/g7IZrHQKgl1zniWljL0pUAXF7X8l9RjkHzn4nUgcAGPGFks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gvZSt9+G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D850FC4CEEF;
	Thu, 14 Aug 2025 05:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755150977;
	bh=NK79IvW2jnUm7SuTk5S6mHgygB+AOQGAUoMR8qBGjhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gvZSt9+GoP68whFeUZPAh4QQLr/vlm+Ms/jGGfeIgA0jt+hD9PZwRdWZFqnY6ggaT
	 XWBxEu5B+mEAiYzU0cWvuVCiahOfZJgvLqSAYHvn1PctpHBayfERI/65C9TzAkYMXB
	 CQl8kCjDybtx/EJ45+XOs8n+X07Fo5X2VmObbcXy/WM+hMVxDnOa0lM6GbDNAgc1wU
	 UN+z3GITcXfyjbnJr1F/25GTlmRGv6XI6zf9cYgJ8EzUaJyIlbhSimEcfKAlGLDwsb
	 f5aJhHzKf+8Np25er9+PLQEWDv1OwYmRSvGJqGVk46dQ8GaKIU8C8gKso14nAPu2Td
	 tH5Z576YIqx5Q==
Date: Thu, 14 Aug 2025 07:56:12 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 01/13] docs: Move the "features" tools to tools/doc
Message-ID: <20250814075612.30ca0050@foz.lan>
In-Reply-To: <a18c897e-8679-4155-932e-4bdb9e37f25c@infradead.org>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-2-corbet@lwn.net>
	<20250814013817.249eb3c5@foz.lan>
	<a18c897e-8679-4155-932e-4bdb9e37f25c@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 13 Aug 2025 16:42:42 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 8/13/25 4:38 PM, Mauro Carvalho Chehab wrote:
> > Em Wed, 13 Aug 2025 15:32:00 -0600
> > Jonathan Corbet <corbet@lwn.net> escreveu:
> >   
> >> The scripts for managing the features docs are found in three different
> >> directories; unite them all under tools/doc and update references as
> >> needed.
> >>
> >> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> >> ---
> >>  Documentation/sphinx/kernel_feat.py                           | 4 ++--
> >>  .../features/scripts => tools/doc}/features-refresh.sh        | 0
> >>  {scripts => tools/doc}/get_feat.pl                            | 2 +-  
> > 
> > This one is the next on my list to convert to Python, but I didn't
> > do any changes on it yet.  
> 
> Just curious, why does it need to be converted from shell to Python?
> I'm sure you will explain that in the patch description (or cover letter).

The rationale is the same as kernel-doc and get-abi: there is a Sphinx
extension that executes it. By converting it into Python and splitting
the code into an exec and a library, we can use the library directly at
the extension.

Besides that, the code in Python, specially after using modules and 
classes, become IMO clearer, making easier to maintain, specially if
we avoid functions inside functions, complex class inheritance, lamba
functions and multiple statements on a single line.

Thanks,
Mauro

