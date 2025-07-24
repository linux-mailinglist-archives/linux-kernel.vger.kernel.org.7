Return-Path: <linux-kernel+bounces-744960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88491B112FB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 23:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF7DA7B802C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 21:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C002EE280;
	Thu, 24 Jul 2025 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOE7cNJS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF7E26C383;
	Thu, 24 Jul 2025 21:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753392004; cv=none; b=bXt6YqjEaU9b+FjeHJUMV1lCnIuIF040u21SLEfAI+ZDDRNB94MyxeP9qq7p9+ku14C6pCBQ6MfiROkSVkzDz+8VdnQz9cMqGF1J1TOlGBWM4UHpLp+BDeITnfUnXMLneVdHpUkKkCFQ3ZT7JWiuXaCCTFM1qrSL50uZ5vmLWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753392004; c=relaxed/simple;
	bh=PniT8X6QlDli8/aYoKXipWUCBCYW/1wxM2BF6jvNYZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1BCaOcQyyz+z7hYQ9XEpyfu3dWs6n+HgV4eU6Fu8xsi7+55SO2aV9HjDSSoc2894DVfvAGIiN/vWqQnycVYuLpKJOeiKMPor3tYwdpw8knEz4d7PhAIGyZqm8P71KeV2DevDWvgiD4JtvzB63NH5sbgpsWyzznPOZ8StcanMZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOE7cNJS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D80DC4CEED;
	Thu, 24 Jul 2025 21:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753392004;
	bh=PniT8X6QlDli8/aYoKXipWUCBCYW/1wxM2BF6jvNYZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NOE7cNJSP4uCgeLiwk9sgv3i1Ux9XkcwZU2827QiPDBRZ1CC+D23xGq+v13qAj5on
	 RkiMqdRJgQVGY/gaeMP+UoIM657Br8oO8c4cB9mRLw8P8zy7qkM2Q5l5z4+noizmK3
	 0gXkOcarc4euV13laRLekrvzn6RRIBvNNdES/DIpbKJtG16D5spclht5SM8AtJtUXG
	 oLktFmuiEk66juRB30wMu1zCeok/+hV8UclVvx0l0zq59wk/MXbUWIozKfa2C0aMfl
	 z4c5IOWiVdk2SJkkJzZp5jLACdbQTwGLn/984GJnyIu1ZWIa/2QPzAWLF6SvRlVGHn
	 D/R48tBz6hwZQ==
Date: Thu, 24 Jul 2025 14:20:03 -0700
From: Kees Cook <kees@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>, corbet@lwn.net,
	workflows@vger.kernel.org, josh@joshtriplett.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] docs: submitting-patches: (AI?) Tool disclosure tag
Message-ID: <202507241418.34AFD28C@keescook>
References: <20250724175439.76962-1-linux@treblig.org>
 <20250724-alluring-fuzzy-tanuki-6e8282@lemur>
 <202507241337.F9595E1D@keescook>
 <aIKhvubVqgeXIlrj@gallifrey>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIKhvubVqgeXIlrj@gallifrey>

On Thu, Jul 24, 2025 at 09:12:30PM +0000, Dr. David Alan Gilbert wrote:
> * Kees Cook (kees@kernel.org) wrote:
> > [...]
> > do for Coccinelle or other scripts. It's a bit buried in the Researcher
> > Guidelines[1], but we have explicitly asked for details about tooling:
> > 
> >   When sending patches produced from research, the commit logs should
> >   contain at least the following details, so that developers have
> >   appropriate context for understanding the contribution.
> >   ...
> >   Specifically include details about any testing, static or dynamic
> >   analysis programs, and any other tools or methods used to perform the
> >   work.
> > 
> > Maybe that needs to be repeated in SubmittingPatches?
> 
> 'produced from research' is narrowing things down a bit too much I think
> when it's people using the tools as their normal way of working.

Right -- as currently written we have the explicit guideline for
"produced from research" and kind of an unwritten rule to detail any
complex tools involved for regular development (e.g. Coccinelle,
syzkaller, etc). We could generalize the existing statement and repeat
it in a better location?

-- 
Kees Cook

