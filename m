Return-Path: <linux-kernel+bounces-872228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1E3C0FA06
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D8BB04E951B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D833B31618E;
	Mon, 27 Oct 2025 17:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="FDgk9zr8"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4A43161A5;
	Mon, 27 Oct 2025 17:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761586027; cv=none; b=pYnQAS2/9eEUUbS370o3wzWbkpHeZHQBsbWSFgNW5mGyx2hM460+dRIOOB6E1bPyz0DGcuwbYaWv7z1HLF1hqsKCuJoRTlcc1eD+Pp8YZxCERFyUiPdRB/7NuOloPw3RTU5JpRhhcj9M8XCpgsnbVlx57/LfITxqK88ZBqWBg3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761586027; c=relaxed/simple;
	bh=0cWFS/aHvcf6zGPoUr9HGepAntK8bTSB3I4wKAoK1Hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sq1sJYpQkdXQXs68OFUWD70GBofGnGktAvKXZgImnm6R2mkfhtyw1SCGN5cHTHi1cq5Z8JvYEV+dG065rf1N6WBYC3Z/Mu1ttD7hN5Ajy7nVuxhDXwuZD6RcB0W+zAL9kelEHCN7qKKn+SgYe4Y24Y4JP1lGFfPUBA87DcCBv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=FDgk9zr8; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net CFC35406FB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1761586025; bh=7M4hB0gT8f5ZWd0pSPRtSbMpf9vqmrkcHvnua6p+fBs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FDgk9zr8hgNZBzf91L7NWjqOhK5QzZhW2xhypC3RxH8Hk13A16klh+m+mWsy6NWFG
	 b5DB31H4/RY5Ve2B7+Acm97xSst9+4TQlwFosLzR6rGSiE4Bz02OyxOxfud3DqZFGS
	 LmokGpD+KAG4EDx/pu5aPzNv4OLZXg1ZXTlOp2loq6BNrGbSZeWx5znB02QYKrLQV6
	 jUjyFd9WLM1rxjbVMUpqDBw2JXndYwpozr6ICkWR97hk0upoYfAGhcRmJEELY7AClp
	 goLYtqJSIQalwnRT19e2t9l+ONyu9kJAm6ToOKNuP2VGS/T0P2YDdSzMDy2ZTkVqQW
	 mIXWgR0ChYk7A==
Received: from localhost (c-73-14-55-248.hsd1.co.comcast.net [73.14.55.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id CFC35406FB;
	Mon, 27 Oct 2025 17:27:04 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/30] docs: reporting-issues: tweak the reference
 section intro
In-Reply-To: <d94aa32d4a1ed5ef9d0f768d05e64987f4a1ae69.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
 <d94aa32d4a1ed5ef9d0f768d05e64987f4a1ae69.1761481839.git.linux@leemhuis.info>
Date: Mon, 27 Oct 2025 11:27:04 -0600
Message-ID: <87qzuontlj.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thorsten Leemhuis <linux@leemhuis.info> writes:

> Small improvements to the intro of the reference section.

That's a bit uninformative ... what is the purpose of these
improvements?  That information would be especially helpful in a patch
that simply replaces that section altogether.

> Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
> ---
>  .../admin-guide/reporting-issues.rst          | 67 +++++++++----------
>  1 file changed, 31 insertions(+), 36 deletions(-)
>
> diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
> index 3bc47afaf85ea0..90b50c27c0d2b6 100644
> --- a/Documentation/admin-guide/reporting-issues.rst
> +++ b/Documentation/admin-guide/reporting-issues.rst
> @@ -244,42 +244,37 @@ The reference section below explains each of these steps in more detail.

[...]

> +The step-by-step guide above outlines all the major steps in brief fashion,
> +which usually covers everything required. But even experienced users will
> +sometimes wonder how to actually realize some of those steps or why they are
> +needed; there are also corner cases the guide ignores for readability. That is
> +what the entries in this reference section are for, which provide additional
> +information for each of the steps in the detailed guide.
> +
> +A few words of general advice:
> +
> +* The Linux kernel developers are well aware that reporting bugs to them is
> +  more complicated and demanding than in other FLOSS projects. Quite a few
> +  would love to make it simpler. But that would require convincing a lot of
> +  developers to change their habits; it, furthermore, would require improvements
> +  on several technical fronts and people that constantly take care of various
> +  things. Nobody has stepped up to do or fund that work.

This paragraph ... essentially says "we're making it hard on you because
kernel developers can't be bothered to work on GitHub".  But a lot of
the complexity, as reflected in this guide, has to do with properly
gathering the information that is needed to have a hope at tracking a
problem down.  I'm not sure this paragraph is needed at all but, if
you're going to keep it, have it at least reflect that the complexity of
problem reporting has a lot to do with the complexity of the problem
domain rather than developers who are stuck in their habits.

Otherwise seems OK.

Thanks,

jon

