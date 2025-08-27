Return-Path: <linux-kernel+bounces-788894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D27B38C01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 00:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B666C203FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 22:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D57E2DA746;
	Wed, 27 Aug 2025 22:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qotr//af"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057FB1A9FB0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 22:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756332158; cv=none; b=ResFsU840z3OfQxq3Px33qX4K2b9mpwpkuUQ8An/X7Awv0GNUsAjyrA1PpOqcsUWxAeiKXf3n28PguJ4HGehF8UFZ6wu8/VOcv19dUs6mnsp4XxQUskmcSU9phK9N/mF2iD++oU8OVvKWvVX3V79haUs0YYN/RQCAoEJUMyUx4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756332158; c=relaxed/simple;
	bh=nQYP93js/pw0jrB86UsyLE4CL68ji+oy9CjDEnyRjl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcMuPrTw0qYNSk1hD3k0IrS5VcdzH3arZ9ikwNfOkfwPaf7SZYqaeBJoUgglPsQQjUNZAEjB0ryf1d4kszqkcHfGCO9hRiosfGdZ4ukvCGhcH2KSsIt7zlD+BDRV7iOSnzIJWWqWqHBYR1Ibck1PgDc+870TGmlal8X4buPbPL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qotr//af; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F54FC4CEF7;
	Wed, 27 Aug 2025 22:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756332157;
	bh=nQYP93js/pw0jrB86UsyLE4CL68ji+oy9CjDEnyRjl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qotr//af3VS+uKpH/6hWCbMNDCNf3DCTce0aTxVIgxOi0UX4vu6Mhb158vSfuG/Be
	 SQDwc0KE5fHUGbXedYzSSnGJWNPLSStqW+7fk83PbHe0hOf4AmRdIDEfzvvQtLXrEB
	 ZhkmmWZYQ7u5wIVj6EjJLinpc1a+7hFdCBrHhggq8m4XPziGNvJpJjZ3XRlrzimcYI
	 w6s3YUatmq8ohV2pL9DtQdBNQfDnP8+I9qy1lYQq2tXQZpIkpXKg+9VtS8ZH6DkLpl
	 dGUI83yr4QAId8NsyyX2SrbZteQYe+RalkP6yV+dhGWAwjSY+s1pblvYqSjl1uLNTC
	 BUk41jG4YT/Ow==
Date: Wed, 27 Aug 2025 15:02:35 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: David Kaplan <david.kaplan@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, 
	Peter Zijlstra <peterz@infradead.org>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] x86/bugs: Simplify SSB cmdline parsing
Message-ID: <46yv33pq5ilwi6kylrxuciyg2gdqbdj4zdpcnqf6bbp2b3xcnt@raah6px5gzlg>
References: <20250819192200.2003074-1-david.kaplan@amd.com>
 <20250819192200.2003074-4-david.kaplan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250819192200.2003074-4-david.kaplan@amd.com>

On Tue, Aug 19, 2025 at 02:21:58PM -0500, David Kaplan wrote:
> +static int __init ssb_parse_cmdline(char *str)
> +{
> +	if (!str)
> +		return -EINVAL;
>  
> -		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
> -			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
> -				continue;
> +	if (!IS_ENABLED(CONFIG_MITIGATION_SSB))
> +		return 0;

Similar to elsewhere, I think we want to be consistent and allow
overriding the compile time default.

-- 
Josh

