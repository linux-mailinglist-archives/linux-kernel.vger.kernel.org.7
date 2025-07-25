Return-Path: <linux-kernel+bounces-746358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DE6B125C0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 22:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DB8BB4056E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA40E25A33E;
	Fri, 25 Jul 2025 20:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cm4ejvCp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E89823F421;
	Fri, 25 Jul 2025 20:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753476056; cv=none; b=HxRR3wj1OrmM+F/i1Cuub1KdKHVcfrcOddz73lJDVc6lNpovPDp+SWfus5U2aLLFpqgBots3yYNADPzJh8rt6VG812P7nHTSqlP6DY/Mw5iX6nkeDine0PmhCQXvVGb1QDqrH/Db9FFl2lY58qnHhdwVZF2EfMMC5KolmnZ4ils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753476056; c=relaxed/simple;
	bh=Nu1Z50NZksVVq2NipEzkL6myYqvsLEvOKvKIx7CB3jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdGbAOi71smVvNXwffUPgeN9Mhp7C+8G+MsBz9REKPcm3OaiErpEdmVFJ3c+yZYFO9Q/kvXrow3DADXFHEn78AM1X9IuNsm5YxYubo8ByX0I0ALab4Mfy+egjWpoSOeJ/4Nt6O2JtCqaSwoeqcHzwgjKM2t97tnXqQChdcK5w8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm4ejvCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5D1AC4CEE7;
	Fri, 25 Jul 2025 20:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753476055;
	bh=Nu1Z50NZksVVq2NipEzkL6myYqvsLEvOKvKIx7CB3jY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cm4ejvCpraD95R9IqmO4BTZ3em/rOCRlGc2q7A0VWQKzxyhVLgBBXEix4t+5eHJxB
	 /+eqbk6le7mYDkhHFNVZXDTfRpiVKKmu7Fiv91dL55DrzLC4XvjfzTqR3Kn8/nLitS
	 NNMUIfRrFXysp2BvELEI4uwLy8wrur+r/WDU3Clj4d1MHsRZqc6iEI3JzJh5X+7yxP
	 GUTdrn6LzbSX/P0IOykZJNBDR/PCAWBGCjROtpjI3Jn7+XHPokKpiMhyTCehss4xZK
	 hd50FLDKtzTQpGMLXTBsgErCcKstv0C7TFqyr7k7fW2V9NjTrwLHpdzwdU7+3nK0y+
	 XbEKxbguvnX0g==
Date: Fri, 25 Jul 2025 13:40:55 -0700
From: Kees Cook <kees@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	konstantin@linuxfoundation.org, corbet@lwn.net,
	josh@joshtriplett.org
Subject: Re: [RFC 1/2] AI: Add unified AI coding assistant configuration
Message-ID: <202507251329.8DC1ED1@keescook>
References: <20250725175358.1989323-1-sashal@kernel.org>
 <20250725175358.1989323-2-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725175358.1989323-2-sashal@kernel.org>

On Fri, Jul 25, 2025 at 01:53:57PM -0400, Sasha Levin wrote:
> Create a single source of truth for AI instructions in
> Documentation/AI/main.md with symlinks for all major AI coding
> assistants:
> - CLAUDE.md (Claude Code)
> - .github/copilot-instructions.md (GitHub Copilot)
> - .cursorrules (Cursor)
> - .codeium/instructions.md (Codeium)
> - .continue/context.md (Continue)
> - .windsurfrules (Windsurf)
> - Documentation/AIder.conf.yml (Aider)

I do like the idea of having a standard baseline for agentic
development, but:

- This clobbers per-project information storage for the agents, which
  the dev may want to be adjusting locally. I would strongly prefer
  adding all of those files to .gitignore instead.

- Documentation/ should not start getting filled with stuff to be
  exclusively consumed by agents. Instead, I recommend a top-level
  .md file that agents can discover that contains very simple
  non-specific prompts about what they can find in Documentation/,
  and drop a reference to the file in, say, Makefile to be discovered
  during the agent's scrape of the project.

I'd recommend something very simple like:

diff --git a/Makefile b/Makefile
index e05bd43f93bd..998b037e6d4d 100644
--- a/Makefile
+++ b/Makefile
@@ -7,6 +7,7 @@ NAME = Baby Opossum Posse
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
+# AI agents and LLMs should read ./AGENTS.md
 # More info can be located in ./README
 # Comments in this file are targeted only to the developer, do not
 # expect to learn how to build the kernel reading this file.
diff --git a/AGENTS.md b/AGENTS.md
new file mode 100644
index 000000000000..3df98f0cc667
--- /dev/null
+++ b/AGENTS.md
@@ -0,0 +1,3 @@
+To work on the Linux kernel, please see Makefile for details on how to
+perform builds and testing. Find and read the Submitting Patches and
+Coding Style rules in Documentation/.


Now if we wanted to write up a human-readable .rst file about the
expectations of what we expect from Agents, let's do that, but I
would like to focus on putting the burden of understanding on the
Agents, not the humans.

-Kees

-- 
Kees Cook

