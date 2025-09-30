Return-Path: <linux-kernel+bounces-837840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F482BAD6F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44AEC4A32F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805933064A2;
	Tue, 30 Sep 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWX083xp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DBE1B4236;
	Tue, 30 Sep 2025 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759244396; cv=none; b=qjapmpGShyBMt35OhAoelxDqvhL1Mx19njzyXGKX+zXQMyGq9+N7r50m8KpoybGBRY0PsgOxT4bB9iZmOXdzDHDhiHtsbFuHBzOtJNC1Kd8tRbHPTJ0vd3UflWuHageCF6Z4MvNaEFN/NsAtcslcP6eJQHPO8wlVXjrIGGXebxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759244396; c=relaxed/simple;
	bh=eKTCzwwSiclQiPU8+Nvb7gObW3o8iQE5kD4iOP/svKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XO4UcdSYCphY6SOGW8kYXv87oCC+7Y+ZznIyrR9asG0LKILqsG+XAYEV9Ml1AESIymTiS0mlB8Hysd6/MUMCtICWXwQ7XwYQNi0QpgdXGk55ZFvYYnZ6oN/mbpl/xUF3UljUe2ew+9e4jY1sPhQtHz0i+SPVNSD0DHeq8dahK4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWX083xp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B148BC116B1;
	Tue, 30 Sep 2025 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759244396;
	bh=eKTCzwwSiclQiPU8+Nvb7gObW3o8iQE5kD4iOP/svKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OWX083xpsoBN2xoXE1IcNkccQlPXjXqjhgwn48VYlCuAHNe5sEynEYguETpzbgx+S
	 BpCIH3u6hRDgu0z2gA5Ypva5FrI8OMcFOiivHd+fweSGUmRId+P+Hiyf47bM6iwEM3
	 4j5fV+stzHJs0FDZq2qc6fDw+wlanXlOPVjr+29V+/A/31xhg6+rRPGAvhIsT1vgtS
	 HhcS4Zp4fqznCJvexZOWjuf+RClQHNyL5Am8QznD//W2xy+BU8BbqhAoFa/cU/PgLx
	 JvVG/UXulq6QeB1cVSUysb6o2Z70IB9uTdOz9+JizL407x+M9ZdrOXAVmyQ85MIdPB
	 ALgYoD4ltHesg==
Date: Tue, 30 Sep 2025 07:59:56 -0700
From: Kees Cook <kees@kernel.org>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Petr Vorel <pvorel@suse.cz>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] kconfig: Avoid prompting for transitional symbols
Message-ID: <202509300758.B53A1AF@keescook>
References: <20250930045300.work.375-kees@kernel.org>
 <f2556f4c-9036-4b79-a4b0-4e4c82a93abc@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2556f4c-9036-4b79-a4b0-4e4c82a93abc@oracle.com>

On Tue, Sep 30, 2025 at 08:25:06AM +0200, Vegard Nossum wrote:
> On 30/09/2025 06:53, Kees Cook wrote:
> > [...]
> > +			if (sym->type == S_BOOLEAN || sym->type == S_TRISTATE)
> > +				sym->def[S_DEF_USER].tri = newval.tri;
> > +			else
> > +				sym->def[S_DEF_USER].val = newval.val;
> 
> sym->def[S_DEF_USER] and newval are both 'struct symbol_value', can we
> just unconditionally do this instead?
> 
>     sym->def[S_DEF_USER] = newval;

Argh, yes. I even went and looked at that struct to see if tri and val
were a union and my brain didn't get to the next step. :P

I'll update this.

> I have to run, will take a closer look later. Thanks,

Thanks!

-- 
Kees Cook

