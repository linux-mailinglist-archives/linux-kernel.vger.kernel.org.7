Return-Path: <linux-kernel+bounces-747431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 086E7B133C0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 06:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE121896571
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 04:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19246217719;
	Mon, 28 Jul 2025 04:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kom+2/9V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFDD7DA73;
	Mon, 28 Jul 2025 04:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753677836; cv=none; b=HVDx3qUKHMRxgVvLM8JaDI8i5VhfdjzpI24dixCW+w5yz1UDliByvq9IQ9OXg1hBwNzYc9yuYHK9QUVZqyGdnvMaL6O+/btmpSyj/Ly0etjN15szcKJLzju5+vcmhWPZNPg8qZC8fwy4Eta8C9cOVdHG6yv9T8nZgatPgiZVFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753677836; c=relaxed/simple;
	bh=mUCxvSTRCDEpiiql5k4HQsjRgZR5GnyT10fpLFbTvw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxrwZPHqnH5h19qi2HWPXYf3tTiy964r1QYhVdrhE/8lTbOWW1dtD64xrI2sCp24FjK26qnqdzg8/APilcsFVS2CMGuVPVaNE6rpphbPhvE1Ccl82fsej8Pkd2moUVixehEguTS9wwtngUdutb88FkNb7X1sg8jTV21e2hwJJ2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kom+2/9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8460FC4CEE7;
	Mon, 28 Jul 2025 04:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753677834;
	bh=mUCxvSTRCDEpiiql5k4HQsjRgZR5GnyT10fpLFbTvw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kom+2/9VLWh+L8XRpkBzEyshQoDtImaEas94vLO9SdTDAeWCzJA2GHFvx2hqA7c8O
	 AUVNj/y89fXViIRqmZDLwnewPpqAuPxVBQ71S8vCc3zdoEO/NYIrrMxq0bWh/4rmzE
	 xsdzoqIZbZCXZTq2m1NAU9gU2xR2HVKhIyXMwGVkvZdnbG3hzN+5D2OYqwJym62TK8
	 qRm6DNWvSEn0kX2BTES4WpLIqExwRtfuXRBUsuTy1MhllogUkxb+PI/4Ve9nLMPs9B
	 /qNYf0lCtbtTtWAmPm9jpvaZwD//0y/kcSztcIxQBccC/JJoCazOlD6p/83KmWBcyH
	 oupPUoiWlkkGA==
Date: Mon, 28 Jul 2025 00:43:52 -0400
From: Sasha Levin <sashal@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
	josh@joshtriplett.org, konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH 1/4] agents: add unified agent coding assistant
 configuration
Message-ID: <aIcACJhaU-NElyHC@lappy>
References: <20250727195802.2222764-1-sashal@kernel.org>
 <20250727195802.2222764-2-sashal@kernel.org>
 <202507271934.68E1F0C728@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <202507271934.68E1F0C728@keescook>

On Sun, Jul 27, 2025 at 07:37:31PM -0700, Kees Cook wrote:
>On Sun, Jul 27, 2025 at 03:57:59PM -0400, Sasha Levin wrote:
>> Create a single source of truth for agent instructions in
>> Documentation/AI/main.md with symlinks for all major coding
>> agents:
>> - CLAUDE.md (Claude Code)
>> - .github/copilot-instructions.md (GitHub Copilot)
>> - .cursorrules (Cursor)
>> - .codeium/instructions.md (Codeium)
>> - .continue/context.md (Continue)
>> - .windsurfrules (Windsurf)
>> - .aider.conf.yml (Aider)
>
>I *really* don't like this. I use the CLAUDE.md file as my instructions
>for my agent. I think all of these should be .gitignore entries.

Sorry, I might have misunderstood you: how does it play out if we add
these to .gitignore?

The tool will just end replacing whatever we put in there with something
customized that doesn't necessarily correspond to what the community
will consider a "standard" set of rules for agents?

>> diff --git a/Documentation/agents/index.rst b/Documentation/agents/index.rst
>> new file mode 100644
>> index 000000000000..109266ca91ec
>> --- /dev/null
>> +++ b/Documentation/agents/index.rst
>> @@ -0,0 +1,10 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +======
>> +Agents
>> +======
>> +
>> +.. toctree::
>> +   :maxdepth: 1
>> +
>> +   main
>> \ No newline at end of file
>> diff --git a/Documentation/agents/main.rst b/Documentation/agents/main.rst
>> new file mode 100644
>> index 000000000000..98aa8250be9d
>> --- /dev/null
>> +++ b/Documentation/agents/main.rst
>> @@ -0,0 +1,7 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=====================================
>> +Linux Kernel Development Agent Instructions
>> +=====================================
>> +
>> +This is the Linux kernel repository. When working with this codebase, you must follow the Linux kernel development processes and coding standards.
>
>And now I start my "this is redundant, why do we have to repeat it in a
>new place?" part of my review comments. :)
>
>I *really* think Agent instructions should only be about stuff specific
>to the agent. It is _supposed_ to be able to find the rest of it on its
>own.

Right - I trimmed down most of these specific callouts, but I left a few
that I found necessary since in my testing the agent would sometime
forget about those. I'll comment more on the rest of your review.

-- 
Thanks,
Sasha

