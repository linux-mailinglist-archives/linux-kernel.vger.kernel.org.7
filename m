Return-Path: <linux-kernel+bounces-770267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B50B2791B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F3971893DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 06:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A129CB45;
	Fri, 15 Aug 2025 06:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojiR1jSF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539141EE03B;
	Fri, 15 Aug 2025 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755239009; cv=none; b=F6T4gAVUtKg9UhfQqxV0N0ojCMZo+chZo01Eyb1jcCkvTUxYriSzD8s+8G+SN7mzD0n9gBhP7xjJJar6RTsVZNthi4vsaZZSCttoje6QBFSpa3Wcl/isWQb2R/8oH7jViaKovMqaUAjwRvf6N0UzcM4pSl6TjmLyCappkCQiKrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755239009; c=relaxed/simple;
	bh=BzekQKui7rH093j6tftYWuBYdHIb8PYzFZJth+6yQIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XY3ctSHHDkNXV40h1iRCIEH/VFxyEmqmALwwggnUEVm+0xoIaHYt1wyqrbicMH/BMcQyAQBMvQc9+ELkUq9m83c9knwWek6V0CQqRuWUyegQ2DC3qKjVvobrITyLL7lgunD+ODFZyyq/EHjM7hVKnPLEBdO/Ljda1kYil7Vg+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojiR1jSF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7602C4CEEB;
	Fri, 15 Aug 2025 06:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755239008;
	bh=BzekQKui7rH093j6tftYWuBYdHIb8PYzFZJth+6yQIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojiR1jSFrV6yLTp2cJo+HnsAAjnBBU64Sciysd4qvve4/0sZ6HytP6JVbU6aRu8Em
	 uS5ZBL3ZqCrTdJG1hRVds0d13eGRHC+rERZYRMyBC9m8tfNzNMzv0mxTrAmF7kiKWN
	 6OKs5GDIbwak2cEx4zAcbL7ihLjFByzmlv8/hb/kKlAdX29l/mdo9CDFbJtZoGdyby
	 /SF6v3NI7ve3K2CRaRoNqsOlnsX9lLdqPm2ltbdHx1gDeovniMSA1GfvulHamEJA49
	 Lmd/ENddvcUJ8/d9de0GmRMmilW89gb2qg6Lie+Xj7cn6mkiqVyFG5mCQ1GNiJK9b+
	 QWYTHbxA/yGZQ==
Date: Thu, 14 Aug 2025 23:23:28 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	rostedt@goodmis.org, workflows@vger.kernel.org
Subject: Re: [PATCH v2 2/2] agents: add unified agent coding assistant
 configuration
Message-ID: <202508142320.60015E6@keescook>
References: <20250809234008.1540324-1-sashal@kernel.org>
 <20250809234008.1540324-3-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250809234008.1540324-3-sashal@kernel.org>

On Sat, Aug 09, 2025 at 07:40:08PM -0400, Sasha Levin wrote:
> Create a single source of truth for agent instructions with
> symlinks for all major coding agents:
> - CLAUDE.md (Claude Code)
> - .github/copilot-instructions.md (GitHub Copilot)
> - .cursorrules (Cursor)
> - .codeium/instructions.md (Codeium)
> - .continue/context.md (Continue)
> - .windsurfrules (Windsurf)
> - GEMINI.md (Gemini)
>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Still a big NAK from me for this for at least CLAUDE.md and GEMINI.md. I
don't know about the other agents, but at least these two belong in
.gitignore because they are files used for _personalized_ project
management of the agent by the developer. Both Agents will find README
automatically.

Please, just add to .gitignore:

CLAUDE.md
.claude/

etc...

This is exactly the same reason that debian/ is listed in .gitignore.

--
Kees Cook

