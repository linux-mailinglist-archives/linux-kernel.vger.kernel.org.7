Return-Path: <linux-kernel+bounces-761353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF188B1F8B2
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 09:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4CB1189A06D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 07:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBBE22F77B;
	Sun, 10 Aug 2025 07:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eAH+Dunv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEA728DB3;
	Sun, 10 Aug 2025 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754809264; cv=none; b=iGyvzf7woVD/lxBJ4yNBdvrZqqIpHDc1NVPjWw/rAxjskPE7XKFXNROGsIeZkMmpdz+5A29KV0PQQ5oD29HSx0ZzExmmxaW6/hGpOmkGPcvnP0OfQs2AMAcRU14BKJBwB9m+MIUPDjrY79Ccfge5KiTwgkA7Bqh5y7G6As3YwO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754809264; c=relaxed/simple;
	bh=FxogHXorMPaYiG70MeaplwIPWAFMg2TKk2C7T0NeXLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+mjFovZliAsOE91iOGsKiYWJLdTnyyjsCy1mOABoZhpnUScJ8bRxU2cAwvmyMJ5UjqgXNa5X6fUsf/EmNsCtkCaeK2N1WWWNKXZQr/Z2JdaEEhEurRg1Ai2R1wXhLv0ciwkkry/IldquAkOGnlt+fFYwyPcKN5xn9+lWlN7ztU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eAH+Dunv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01869C4CEEB;
	Sun, 10 Aug 2025 07:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754809263;
	bh=FxogHXorMPaYiG70MeaplwIPWAFMg2TKk2C7T0NeXLY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eAH+DunvbVDm6W4ae0E+5SFj1zGSWyPbIDhuAHnYYFgDpRYoOLAuVCihU5zZmU7YE
	 /I0auZJvaTtX7tkuX5g4JcGfzOJgT2ipSQmnkpHFSBR71HgN8xrAp7Bw+A5oBSadMF
	 tMfkc/tKr5MYuzJucv458RSc6xpL6eushn/MltYQ=
Date: Sun, 10 Aug 2025 09:01:00 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	workflows@vger.kernel.org
Subject: Re: [PATCH v2 2/2] agents: add unified agent coding assistant
 configuration
Message-ID: <2025081040-armchair-although-8bf1@gregkh>
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

Having these non-dot-files in the root directory for just specific
closed source tools feels a bit wrong to me.  I thought all of these
tools were standardizing on "use README" and didn't need these extra
helpers?  The fact that most of them just contain README seems like
that's the case, they just need to work it out somehow?

Anyway, I'd not like this patch to be added (patch 1/2 is great), as it
feels like these agents need to get their act together in ways to not
need these, we shouldn't be forced to deal with their inefficiencies.

thanks,

greg k-h

