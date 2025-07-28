Return-Path: <linux-kernel+bounces-747460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33645B13419
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 07:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C7CF189076C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 05:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF8A21ABD5;
	Mon, 28 Jul 2025 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcQ3ZzV0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E4829405;
	Mon, 28 Jul 2025 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753680101; cv=none; b=rL1vRa42/+Ziu6JHw6FDNYjGhAcfs8c0nC09koOTkwRQ0cBquNUc3dMpP7QNLS9x6BcQQdPv2cYNhIva/FvvzOeu3do+cMbAqU83P5qERTsAQWTe0ZqgjC9+YSKYLyIbu/XRh19jWAa/KoAmOVNd9KcYnIaU4WnDhDo0/85ze84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753680101; c=relaxed/simple;
	bh=zKqo6s0uP0m/eJSU28JeyvlFsZxsc++2K/tJff8xD4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeX5o5SxaqSJ5kDumFq7SoRjJdglki9AYKlNw3Sl/wozLe1UIDocUoCECE08z3e1JpNAgcGMP+93WI43n72BcNwelM0W4OrBha5rFJFAPybgq0Y5DKes+aybGX0HcgHyHlTgeRncOT1IOCnnYuj5/a9v77duPh+qBvJkBOK0n08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcQ3ZzV0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DD6C4CEE7;
	Mon, 28 Jul 2025 05:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753680100;
	bh=zKqo6s0uP0m/eJSU28JeyvlFsZxsc++2K/tJff8xD4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XcQ3ZzV0mutTxCY3Hl1kk/5AFyx6wDjq0/dAT/Juq4NjhuaLgaJwHL6RXe6zLtn5r
	 X63V3kB9rL/v06jd1gZpvTV9eCWAxZNoDuQSNVzZC0KmGTIOFyWJ5Tl5JkHx0kMl0B
	 xoOTdh8TtU1hhcybVQzsntU71Rm4x0U/kY52p1WYDARe6zPuhqi5X8ICd1V13S6UmR
	 DDyTLxaCuP7VkYv8CGq2OXH1Q8AbYxWt/kaPFhvlvWgQeYlzLgwLz6mjnGcSsGlbui
	 8hMjJtRYKmvDwqQmkYIq/wkcXP4TfXBi/1DtsiLZg65jJDsUS+aTKPsXA5quhDuBpF
	 +TRqIrHIUj7zg==
Date: Sun, 27 Jul 2025 22:21:40 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 3/4] agents: add coding style documentation and rules
Message-ID: <202507272219.4BF02B6@keescook>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-4-sashal@kernel.org>
 <202507271939.D78EC559@keescook>
 <aIcGQR8tjmjr8dlb@lappy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIcGQR8tjmjr8dlb@lappy>

On Mon, Jul 28, 2025 at 01:10:25AM -0400, Sasha Levin wrote:
> On Sun, Jul 27, 2025 at 07:40:36PM -0700, Kees Cook wrote:
> > On Sun, Jul 27, 2025 at 03:58:01PM -0400, Sasha Levin wrote:
> > > +**80 character line limit**
> > > +  The preferred limit on the length of a single line is 80 columns.
>
> Hrm, it is?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/coding-style.rst#n104
> claims:
> 
> 	The preferred limit on the length of a single line is 80 columns.
> 
> 	Statements longer than 80 columns should be broken into sensible chunks,
> 	unless exceeding 80 columns significantly increases readability and does
> 	not hide information.

That's true, it's not called out well enough. 80 is "preferred
limit" but not the hard limit, which is 100. See commit bdc48fa11e46
("checkpatch/coding-style: deprecate 80-column warning")

-Kees

-- 
Kees Cook

