Return-Path: <linux-kernel+bounces-770165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29638B277DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 903B9A20969
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 04:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0BD1E1DE3;
	Fri, 15 Aug 2025 04:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ja5lO8Jz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05D2374C4;
	Fri, 15 Aug 2025 04:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755233149; cv=none; b=JC2e7pxNYlZrAfYtZ0wmTw88ozI2x5AqTM/2v3rq47IO+0U/Q0Ehks4zQn1XRM5iZFm+IwkjxtU5BlR2RgQlZUH0uonFKKAgXCzEGepm1r4TJLJ4aPTJbqLL44Hd4PCAdU89a635r7BFLdZGwoC4JkEvNuUFGdyPcxIiJv4jLKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755233149; c=relaxed/simple;
	bh=5518tGIAJHriIerFhh+G7NKWa5HclOb4NT2OtCVz8Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKMsqG3YUbP6qC0NPXNdV/UVnFAImc+3HyOXgEXnw3Vsn5FKc9OVyLKMSSojBY2Xfb/blF9mUJ0XPLH+Kj2EN6lNm4nByH701V0ln/B7MV17n8afqRLMEErx8Rj8Z4ej7JeJ8F49oOiBm2M+B2+Epw8ps1eB35Z8NCb53Ikxs5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ja5lO8Jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9A6C4CEEB;
	Fri, 15 Aug 2025 04:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755233149;
	bh=5518tGIAJHriIerFhh+G7NKWa5HclOb4NT2OtCVz8Pk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ja5lO8JzDJeoq7q4/PtzaZG74reCmx24SH+XJoBXyBhOkhTXHMpnti58r6M7Vi0jN
	 K0pB3X41vvPEoJp6H9I89vxwvRRsPvAMfKjDwlAln4zKC6Qt2lI8EK1bzJfcxaZvWG
	 KOABNpEgg9m3Dp/ofocg4ZXooPv3gEbzI1jmqQ/9VB6Ds5FzeCXZYI10TwtjaogWAa
	 7oUwCl+PvF2S+aQhlC88Fsg7WwxH5oqaIQAVTi41CgBT/NX7tyBOcV2lvklCEgC/Ca
	 Y1nc/I04kQqIwsJy8iaaM4ucx4Jhz3csIUdF1sYUPySglve+KCv5qH563tTQiP5suJ
	 VDg4v9gjWmcVA==
Date: Fri, 15 Aug 2025 06:45:45 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 13/13] docs: remove kernel-doc.pl
Message-ID: <20250815064545.392a4fee@foz.lan>
In-Reply-To: <1c04bed1-64aa-478d-a9ea-e54c335b3a1f@infradead.org>
References: <20250813213218.198582-1-corbet@lwn.net>
	<20250813213218.198582-14-corbet@lwn.net>
	<1c04bed1-64aa-478d-a9ea-e54c335b3a1f@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 14 Aug 2025 19:43:38 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 8/13/25 2:32 PM, Jonathan Corbet wrote:
> > We've been using the Python version and nobody has missed this one.  All
> > credit goes to Mauro Carvalho Chehab for creating the replacement.  
> 
> Thanks, Mauro. I certainly won't miss kernel-doc.pl.

Anytime. I'm very glad to see that the Python version have been work
nicely, and having you, Jon and others looking on its code. My feeling
is that it will be easier to maintain.
> 
> > Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> > ---
> >  scripts/kernel-doc.pl | 2439 -----------------------------------------
> >  1 file changed, 2439 deletions(-)
> >  delete mode 100755 scripts/kernel-doc.pl  
> 



Thanks,
Mauro

