Return-Path: <linux-kernel+bounces-748403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A55B140B6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBB6418C2BA5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 16:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36A6C274B42;
	Mon, 28 Jul 2025 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHn2ima8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AB921018A;
	Mon, 28 Jul 2025 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753721376; cv=none; b=OwX0bnNR9/C7X+tPIflZouTl6Zp1/CU8Nj0oK+Mt6mbPYCN4c8wTldRKsp5Q4eO25sw92BjKiAb4AbMpNTr0lQDdleQHCktBKjZxXUZFxCLM3BXDU3/UGw5Yr1WG7OmOXBaEeh8c/ztpm9zi9lghRS9YLpeq0QW5c9xLslc/w4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753721376; c=relaxed/simple;
	bh=q9X9ksDvvUYxp7F6PEdRJ7WHwUbgNaMldSVXYEIOOck=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qt4+DvToc+Dvi0Vw/Yc6uXe093I4u1EYaXXF2W7RrQ6dzErvW0XR154CzPwDI5Ghb4KHjIpBc0upw9wpEbk9wXA57+vzUef6i/WrUmnAYb3UKyIU2XVeqjUJCnPIwz6imzfSY+9eQvKMmmNGljs0C2cKYKPCYv/yAo5Mz6lJJ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHn2ima8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B58C4CEE7;
	Mon, 28 Jul 2025 16:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753721376;
	bh=q9X9ksDvvUYxp7F6PEdRJ7WHwUbgNaMldSVXYEIOOck=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WHn2ima8ccHSUuZKdt0XvL66OnZOjf2ahyxUYeEQSdHfAEZmsWDsIdMszO2sZLrRu
	 r/78WOVHliN7JHhO15vGGufcPP4rRDCuebEw07nlMR2n5+YmrxiCUyuBQqC2RS5wdA
	 AJ+MSi3wmxso8ySpt+DnpBVknewQOEWeD5Yw4HU7rL1SrZWahqhTMDCW0dwithtM7d
	 K9BSYMShKXZcCFvJ2kyQ5ys5W5Vob1brHsRGg9wgnu6AmkXRhX2QhSKq3ce0mg7R3M
	 9+Y3Jfo3x/m7757B9zyK8IybIEMImdAOXYs7YdBr5Q1HMA5Sz4OuMv7mb81gdiMFM2
	 u8V+UWwm4duvw==
Date: Mon, 28 Jul 2025 18:49:31 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org, kees@kernel.org,
 konstantin@linuxfoundation.org, corbet@lwn.net, josh@joshtriplett.org
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
Message-ID: <20250728184931.4b26e95f@foz.lan>
In-Reply-To: <20250725175358.1989323-1-sashal@kernel.org>
References: <20250725175358.1989323-1-sashal@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 25 Jul 2025 13:53:56 -0400
Sasha Levin <sashal@kernel.org> escreveu:

> This patch series adds unified configuration and documentation for AI
> coding assistants working with the Linux kernel codebase. As AI tools
> become increasingly common in software development, it's important to
> establish clear guidelines for their use in kernel development.
...

> The series consists of two patches:
> 
> 1. The first patch adds unified configuration files for various AI
> coding assistants (Claude, GitHub Copilot, Cursor, Codeium, Continue,
> Windsurf, and Aider). These are all symlinked to a central documentation
> file to ensure consistency across tools.

Agreed with the goal, however people may be using other LLM tools, 
like chatgpt and deepseek, as a development aid tool, but not directly
writing patches from it.

Some LLM tools can be very useful when handling some bugs that may
require seeking the web for some possible alternatives. On
such kind of usage, it is not different of using a search
engine like duckduckgo, google, yahoo,...

LLMs can also be used to write unit tests/functional tests,
where the actual patch can be independent of any LLM coding,
if the testing toolchain is not submitted.

> 2. The second patch adds the actual rules and documentation that guide
> AI assistants on Linux kernel development practices, including:
>    - Following kernel coding standards
>    - Respecting the development process
>    - Properly attributing AI-generated contributions
>    - Understanding licensing requirements
> 
> The examples below demonstrate how these guidelines work in practice, showing
> proper AI attribution in commits and the assistant's understanding of kernel
> documentation requirements.
> 
> All AI assistants are required to identify themselves in commits using
> Co-developed-by tags, ensuring full transparency about AI involvement in
> code development.
> 
> "Hello world" test:
> 
> 	$ claude -p "do you need to attribute your commits?"
> 	Yes, according to the CLAUDE.md file in this Linux kernel repository, I must identify myself as an AI assistant in commits by including:
> 
> 	```
> 	Co-developed-by: Claude claude-opus-4-20250514

Due to the above, I don't think that Co-developed-by is the best 
tag here, nor if we want a tag or some text written at the patch
description describing how AI was used.

For instance, on your example:

> 	-        /* dont operate on the pointer.. just do a sanity check.. */
> 	+        /* don't operate on the pointer.. just do a sanity check.. */

LLM is not developing anything. It is just doing what any other
spellchecker tool would do. We don't have any tags to document
that, although we sometimes add comment saying that we used
cocci or some other tool to identify (and/or autocorrect) the
coding style and/or grammar/syntax issues.

Thanks,
Mauro

