Return-Path: <linux-kernel+bounces-763150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07B3B21113
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 18:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9141D3E7FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FE329BDBC;
	Mon, 11 Aug 2025 15:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DkKBeFf1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D22E2DC1;
	Mon, 11 Aug 2025 15:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754927286; cv=none; b=U9hROXLGcMAKrkgwauLjIXpVnV9f+zL7VcHsleVTIQ3MF4xIKicyPgM0wYSpegUVjH72jfQgzn5hfrDbjs58hhwSVkeYAFyghgrO/Y65DTHaQePQSiO5nTA4C8Py7jh2Q5/uBNoUjyRq5TnvzRvoqcYOpBUxYABaEHubgI0DZwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754927286; c=relaxed/simple;
	bh=8gmWeKWrJeK2Xkqz/8/mh/JFMl+WMCygehd7PMn2K1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsVRxXcCr41ULSWxc7xmD8mnp6rOBSv4y1Y+9BIjuP7YBZ0vjpUPeVzNVgFHuIqNaPDEkyDKDzvn9IMPlVh2LMLOq/TZuJb5UvryQXdj4TVXv3+roIE08GVHKzoWiP9XcGo55i5Ap/Qko7CB4fI7aTDezGxSf7pdATxQt5xaSnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DkKBeFf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61320C4CEED;
	Mon, 11 Aug 2025 15:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754927285;
	bh=8gmWeKWrJeK2Xkqz/8/mh/JFMl+WMCygehd7PMn2K1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DkKBeFf1TXwV2F0ZOL9ioAkAZlbyz1mBR7cI5v4XGX1SgG96WAhj7uO1wVK5vWPft
	 mvhSF68zCaiZv0e/313lzJq2fXxZjisu9w00pKKCcyjmg8c3YiJ2FL8+O3z+lL5E8w
	 avSOcY74Ui7UIInfSSPhyarl/DuXEweNKo+8+aDCRQXPY6+AB9FzVuY1Ki3p/d0ziM
	 e9AOS+GvjD8JNJK/74LHXkqL3sJZSs0Mf+APtWUp1D22vWYSrZoXYWgND19fjrE8xi
	 kdx4GxBIRT2s/5uVUMUTTGFolE5AiukVGp9PQGCtgVczj/2/vXp0MGSvLwRsq+riBS
	 AF7fCp/sKxsIA==
Date: Mon, 11 Aug 2025 11:48:03 -0400
From: Sasha Levin <sashal@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: corbet@lwn.net, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	workflows@vger.kernel.org
Subject: Re: [PATCH v2 1/2] README: restructure with role-based documentation
 and guidelines
Message-ID: <aJoQs_5Mp7-LAtTS@lappy>
References: <20250809234008.1540324-1-sashal@kernel.org>
 <20250809234008.1540324-2-sashal@kernel.org>
 <CAMuHMdWaVvAfm6LMxSpPuz3yZ7FDAexbUTOXrg58TqoWbce5ag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMuHMdWaVvAfm6LMxSpPuz3yZ7FDAexbUTOXrg58TqoWbce5ag@mail.gmail.com>

On Mon, Aug 11, 2025 at 10:22:34AM +0200, Geert Uytterhoeven wrote:
>Hi Sasha,
>
>On Sun, 10 Aug 2025 at 10:09, Sasha Levin <sashal@kernel.org> wrote:
>> Reorganize README to provide targeted documentation paths for different
>> user roles including developers, researchers, security experts,
>> maintainers, and AI coding assistants. Add quick start section and
>> essential docs links.
>>
>> Include proper attribution requirements for AI-assisted contributions
>> using Assisted-by tags with agent details and tools used.
>>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Thanks for your patch!
>
>> --- a/README
>> +++ b/README
>
>> +Who Are You?
>> +============
>> +
>> +Find your role below:
>> +
>> +* New Kernel Developer - Getting started with kernel development
>> +* Academic Researcher - Studying kernel internals and architecture
>> +* Security Expert - Hardening and vulnerability analysis
>> +* Backport/Maintenance Engineer - Maintaining stable kernels
>> +* System Administrator - Configuring and troubleshooting
>> +* Maintainer - Leading subsystems and reviewing patches
>
>Kernel Maintainer?
>Driver/Subsystem Maintainer?

I tried to use similar terms to the ones used by the rest of our docs.
In this case, the CoC interpertation actually defines this term :)

	The Code of Conduct uses the term "maintainers" numerous times.
	In the kernel community, a "maintainer" is anyone who is
	responsible for a subsystem, driver, or file, and is listed in
	the MAINTAINERS file in the kernel source tree.

So I just went with "Maintainer".

>> +* Hardware Vendor - Writing drivers for new hardware
>> +* Distribution Maintainer - Packaging kernels for distros
>> +* Agentic Coding - AI assistants working with kernel code
>
>Given the extensive split, what about normal (existing) kernel
>developers?

Those people don't read the docs anyway :p

How about something like:

Existing Kernel Developer
-------------------------

Continue advancing your kernel development expertise:

* Locking and Concurrency: Documentation/locking/index.rst
* RCU (Read-Copy Update): Documentation/RCU/index.rst
* Subsystem APIs: Documentation/driver-api/index.rst
* Performance Analysis: Documentation/trace/index.rst
* Testing Infrastructure: Documentation/dev-tools/testing-overview.rst
* Patch Series Management: Documentation/process/5.Posting.rst
* Maintainer Handbooks: Documentation/process/maintainer-handbooks.rst
* Cross-Architecture Development: Documentation/arch/index.rst
* Kernel Debugging: Documentation/process/debugging/kgdb.rst

-- 
Thanks,
Sasha

