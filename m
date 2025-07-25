Return-Path: <linux-kernel+bounces-746378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B164FB125F1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 23:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B823AA2F29
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 21:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4B323D2A4;
	Fri, 25 Jul 2025 21:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1h8GthS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793B919F420;
	Fri, 25 Jul 2025 21:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753477405; cv=none; b=r9/M3/D/gsXl4rE7WzPBUTpyYCCnQrQlMMOr1xMpcPPHyVAOZJ0dtlqKocNAgQzz/p3oC/Yj5WrvpT01dZrijZu1x2hUGViizaLMHGc/uRxUAsY7mhQfuOEUWFS/iuVFMzIYgBL8V2oY+IfNSGuf9GeyRFVKhjD+q2WBpUQctLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753477405; c=relaxed/simple;
	bh=FOsCdWH83QAeAkOi+QOm2qqQc5GML3+sqhLFW2F3bHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7UJvQ99zGVx3qrmGyKrwAgQddThK1+5HUkzrjTSzUdaJv88nkzjF4V4P+seoTRcw3nkABaDoGEWbcFze9ucoSlFsj5RpwW+/YwOqUd4joVarp3+DwUT4+4k93ykR/6QzSQLKwvioGkIEIgNNxscrHleZoUFYpiLZiqn6ODKLXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1h8GthS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F6EC4CEE7;
	Fri, 25 Jul 2025 21:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753477405;
	bh=FOsCdWH83QAeAkOi+QOm2qqQc5GML3+sqhLFW2F3bHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y1h8GthSlD0MRBG8SoVg+DcqqFGP1J1x1zE4lXjVgiVHI6/s9BR6JlzV5TvOGbP+x
	 2guHLZEosNxeQXAT7Hsuw3qHhGlXo9D1v4uP1OpF68xMTkwruELXSUMbscw7l+5wPu
	 Z1AMmO7WB3GsZYd6UVX0FeC1PErKDKLyC9S8u7nIsQ+c07T9WlHvQWvNo9z0Ek2m8F
	 pUgxXBbgvrNk/YDNLCgLJaU5ja5D7/u1mCMjRF6UEm9NSOjDYQpPtP5y/uBFouh0xW
	 9/FcuwtJ/2NJFo4hsjkzipyJj5gqxG8PVwASVemj/p5p7YJyaTazwlfp43xrefv99f
	 velleq08wXz4w==
Date: Fri, 25 Jul 2025 14:03:24 -0700
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, konstantin@linuxfoundation.org,
	corbet@lwn.net, josh@joshtriplett.org
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
Message-ID: <202507251356.4396F1F@keescook>
References: <20250725175358.1989323-1-sashal@kernel.org>
 <20250725114114.3b13e7b1@kernel.org>
 <20250725150046.3adb556c@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725150046.3adb556c@gandalf.local.home>

On Fri, Jul 25, 2025 at 03:00:46PM -0400, Steven Rostedt wrote:
> Also, I would argue that it would be useful in the change log as if there's
> a bug in the generated code, you know who or *what* to blame. Especially if
> there is a pattern to be found.

Yeah, this is where I feel like it's the most potentially useful. Since
they are distinctly code-generators, we should include the info to
identify it. We include version numbers and such the compilers and
linkers, though they are only informally included in commit logs when
dealing with specific problems.

Having had to do "find all commits from [set of authors]" research for
security audits, I would be very unhappy if I had to do this again in
the future for a specific Agent (used any author), and had to loop lore
into the process. Yes, it's *doable*, but it'd be very annoying.

-- 
Kees Cook

