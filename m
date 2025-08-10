Return-Path: <linux-kernel+bounces-761505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D089B1FB0B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 18:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B613B86F3
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1022023D2A0;
	Sun, 10 Aug 2025 16:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNnTk0W+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ABE1862;
	Sun, 10 Aug 2025 16:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754844378; cv=none; b=GC2ffQ1wliBhB7wCCZBvLc2W5VQyZy3StufS2us65IVajxj2XrdHwCBSzA9OWbVSkByZ2V3CaROSUi/W3eAEU7zDXykQtoE9BLwMeSDOrimfXyILKQfx6HWEDwW2pXtagWvMO2R+v4f4s2JPrIRMb2AVArpMA7fnQpH9zDGqIfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754844378; c=relaxed/simple;
	bh=ai/WZNXb7mWpRQ0BTif+yKDZ2Yq4O7BpGse2n+jB/JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4reDpk1n41p9/c24qWYKxyNroQzZh0swwUUolJxXlBAKDRHkw+xK3LW5YJ/6PLIDdV+o3PDlO6O2GiXTTHi4OVsdDXhzbkHh44vTb2wNsQFaMldTvomuudlwwgCeMMCV63unGflNXECDLWwdT0ZJMKBaQzvzNUkcoavquY+8bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNnTk0W+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62E2C4CEEB;
	Sun, 10 Aug 2025 16:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754844377;
	bh=ai/WZNXb7mWpRQ0BTif+yKDZ2Yq4O7BpGse2n+jB/JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VNnTk0W+V54KQpFvSHE9sRsG5SmUjHZQZPWp4hddlLBZHlKpJ6kBPF903Qz+nAx3n
	 1/RRZmJzpZYSJRaB3u916QPRLC5D//lPVULm1syWN1/QZpwdrbyRT0niZSGkKuM4x3
	 jxsldc1QCufWqvTTtF1sUuDcWpEflLlgFrfj6BeqJTCUJ3jc6qwFglbluQJSM9jBGv
	 XphD0tTIqKuT3q4CqhYcotmQIn4oRuJsi1b2X0UvjGkKXeDVtDo6BiRN+z3wfZvIOC
	 SjgUFBBXCffST+qcQRQBo7lLh97L8fwcXuLEs4dQ/NsRitYXC+JJ5Fur12MxZl/B9n
	 pZJ+Y9gNP+HLA==
Date: Sun, 10 Aug 2025 12:46:14 -0400
From: Sasha Levin <sashal@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: corbet@lwn.net, josh@joshtriplett.org, kees@kernel.org,
	konstantin@linuxfoundation.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, rostedt@goodmis.org,
	workflows@vger.kernel.org
Subject: Re: [PATCH v2 1/2] README: restructure with role-based documentation
 and guidelines
Message-ID: <aJjM1oF8hJJrqDhN@lappy>
References: <20250809234008.1540324-1-sashal@kernel.org>
 <20250809234008.1540324-2-sashal@kernel.org>
 <bee3cea19d9fc1c97b1816f516fdd5283cebc1e1.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <bee3cea19d9fc1c97b1816f516fdd5283cebc1e1.camel@perches.com>

On Sun, Aug 10, 2025 at 08:44:58AM -0700, Joe Perches wrote:
>On Sat, 2025-08-09 at 19:40 -0400, Sasha Levin wrote:
>> Reorganize README to provide targeted documentation paths for different
>> user roles including developers, researchers, security experts,
>> maintainers, and AI coding assistants. Add quick start section and
>> essential docs links.
>>
>> Include proper attribution requirements for AI-assisted contributions
>> using Assisted-by tags with agent details and tools used.
>
>Nicely done.

Thanks Joe!

>Perhaps the 'Assisted-by:' tag should not be limited to AI
>assistance but could also be used when accepted notes were
>given on any revised patch submission.

The suggestions from the previous patches around expanding this to be a
list of tools rather than just "AI" made sense, this is the example I
gave in the cover letter:

	Assisted-by: Claude-claude-3-opus-20240229 checkpatch

I find something like that useful because it tells me from the get-go
that the submitter ran checkpatch on it (without having to spend a line
in the commit message saying the same).

I'm not sure about mixing human feedback into this, it might be
difficult to interpert it later.

It might work more naturally as an extension of Reviewed-by?

	Reviewed-by: Developer A <a@b.c> # Improved the XYZ algorithm

>Oh, and maybe a checkpatch update like this?
>---
> scripts/checkpatch.pl | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
>index e722dd6fa8ef3..d17661141da79 100755
>--- a/scripts/checkpatch.pl
>+++ b/scripts/checkpatch.pl
>@@ -641,6 +641,7 @@ our $signature_tags = qr{(?xi:
> 	Reviewed-by:|
> 	Reported-by:|
> 	Suggested-by:|
>+	Assisted-by:|
> 	To:|
> 	Cc:
> )};

Yup, makes sense! I'll start including checkpatch updates going forward.

-- 
Thanks,
Sasha

