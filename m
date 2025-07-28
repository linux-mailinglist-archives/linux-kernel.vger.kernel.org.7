Return-Path: <linux-kernel+bounces-747366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE2EB13304
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F0683B5E89
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 02:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBFC320E715;
	Mon, 28 Jul 2025 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tt3la7QN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220FC1F8AC5;
	Mon, 28 Jul 2025 02:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753670252; cv=none; b=aEpv43GekJ514MBhxnW3YIh2e6pqi0MuD5NSO7qI7DXbbm9nhaZYe/UQFLjomyOK8OXTay/PGucbivtaaQDLqsaNMlngm8lbmMK3ZX7GpYS0MgJ3O24qeAeZWkpr/5vU6Bpkh+EEyuUe9D7eEXZglcZbqLIObNelVflY8K7tOfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753670252; c=relaxed/simple;
	bh=5xfcQXrUfe+3RqbHXQi/TD0lFGPbnFhFFoVtZxgd9J4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i1Z94/vMyZ7Os9lXacoMQ9g4Ae8IHM80/ry/de4s7DRu+tO3yf8rJE0ZiMjzqwxgAHPYzHFVkE9jfLRB3YnvfPisTgrwumzuRcnZmNPrvr4dkG0GHCJZ3vY2xJmUCsoMTE8PCGBiPAu+a5ZOYAgE25xL/PreD8HpMKTVs6Ek3xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tt3la7QN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 942AAC4CEF7;
	Mon, 28 Jul 2025 02:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753670251;
	bh=5xfcQXrUfe+3RqbHXQi/TD0lFGPbnFhFFoVtZxgd9J4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tt3la7QNRBK+0z98vAee1AtCiVMJjkKyqGeKN0Vvg8T1x1uTNM0iwUVWY98+kaEVP
	 1t58AqVE8Er1vDUiCkADoJOCl7F0CFPr2bcwD6cdlJs1/tcxGrhoBMqXi5ePv1asZE
	 zg6ASD/95EhdH4tFeJIP5V4in3oBu6wOyyVr/5nTN7bofFEAJm4T2gPwCrUVSt1NPi
	 LNiK/ps7/oHSKW9i3bM0R+XjXWwNu18YAfsnKszcWPrOOzEDuwYpeePXC4ikqCyVbm
	 /GXxKygUn15kN5AIYmnjRS372j+JK+cnDjZni4JhIIrMlwA13KH46QgHwo5SZs5qMz
	 FZMZvvIaUnecA==
Date: Sun, 27 Jul 2025 19:37:31 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 1/4] agents: add unified agent coding assistant
 configuration
Message-ID: <202507271934.68E1F0C728@keescook>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250727195802.2222764-2-sashal@kernel.org>

On Sun, Jul 27, 2025 at 03:57:59PM -0400, Sasha Levin wrote:
> Create a single source of truth for agent instructions in
> Documentation/AI/main.md with symlinks for all major coding
> agents:
> - CLAUDE.md (Claude Code)
> - .github/copilot-instructions.md (GitHub Copilot)
> - .cursorrules (Cursor)
> - .codeium/instructions.md (Codeium)
> - .continue/context.md (Continue)
> - .windsurfrules (Windsurf)
> - .aider.conf.yml (Aider)

I *really* don't like this. I use the CLAUDE.md file as my instructions
for my agent. I think all of these should be .gitignore entries.

> diff --git a/Documentation/agents/index.rst b/Documentation/agents/index.rst
> new file mode 100644
> index 000000000000..109266ca91ec
> --- /dev/null
> +++ b/Documentation/agents/index.rst
> @@ -0,0 +1,10 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +======
> +Agents
> +======
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   main
> \ No newline at end of file
> diff --git a/Documentation/agents/main.rst b/Documentation/agents/main.rst
> new file mode 100644
> index 000000000000..98aa8250be9d
> --- /dev/null
> +++ b/Documentation/agents/main.rst
> @@ -0,0 +1,7 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=====================================
> +Linux Kernel Development Agent Instructions
> +=====================================
> +
> +This is the Linux kernel repository. When working with this codebase, you must follow the Linux kernel development processes and coding standards.

And now I start my "this is redundant, why do we have to repeat it in a
new place?" part of my review comments. :)

I *really* think Agent instructions should only be about stuff specific
to the agent. It is _supposed_ to be able to find the rest of it on its
own.

-- 
Kees Cook

