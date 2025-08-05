Return-Path: <linux-kernel+bounces-756461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11301B1B4A9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 15:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C1918A4B81
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 13:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74D0274651;
	Tue,  5 Aug 2025 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBDfMAU1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34850256C84
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754399788; cv=none; b=BxDRgCdLrOhWrnka4MZtTqk2fS/vHdGiWeBCTD4DO3EZcK528GxQZC/Zyf6Q2sUUd1EQ7sN1CPxvwIbtUHKlpOVNzEs/aVJciIoGDHyXWS9ywnoYASkmMLgQFo4ZTZRS25DCJ8U4x/25c5trEQe9+uN/+/herwvLH8HD/mhKXlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754399788; c=relaxed/simple;
	bh=6W/xiw69ukViUYS1/UU6MQFnwfzZj750hgnXc5V+itg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ke4BiAZxu7hoXKzu5M1vuLy2/lfVk8kOaY9+SG3XrCd1hPchjfKHiyevqqgNKffcyuKLKmv51zccjioLEDdrLCxbYDAX1+AEsgi5SJeKQvr7NDNFk9Yc7JAEGyHqpem+xp/SwYLsifgauXS0evOAEV8SZc1y1zCGK9BXL33xB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBDfMAU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF3AC4CEF0;
	Tue,  5 Aug 2025 13:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754399787;
	bh=6W/xiw69ukViUYS1/UU6MQFnwfzZj750hgnXc5V+itg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HBDfMAU1if/4DRCA5L71LzllHZASdNF/G1sUrwtMoBv5XrQyiT6MTXM+lT4n3AxYK
	 LOHeM/IRko/MbMWT2oEyY2K32IElsXLxRDHdnWWxF72ReLM5Spjlh778s6wSU3l7u8
	 hAmr7tebPwSBtO7VedtDDojgONy6cUXEdpm7TnSG/Lc0PGoH0FLP7DAZ3/gwXJihOu
	 agjNbM/3GnnNq+Uyf2oUTc+bLJ8taPkt3rTyVJNqwMnWkAgPjRLTos8C6JPKQKLfQh
	 U3ATRjiVRoSWnB7CqvpUxCNaCi29ElJHF6xaj7yKuNNKWaAUqKoge/5yxsUL23FGtg
	 UpHNQ9pELZIeQ==
Date: Tue, 5 Aug 2025 14:16:23 +0100
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: Re: [GIT PULL] LEDs for v6.17
Message-ID: <20250805131623.GL1049189@google.com>
References: <20250730151013.GC6782@google.com>
 <CAHk-=whwhtLWi7n1RjOk4Yvmt4sHdEMd9DdzaLdfHc_8StU-qA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=whwhtLWi7n1RjOk4Yvmt4sHdEMd9DdzaLdfHc_8StU-qA@mail.gmail.com>

On Thu, 31 Jul 2025, Linus Torvalds wrote:

> Just a small and unimportant nit:
> 
> On Wed, 30 Jul 2025 at 08:10, Lee Jones <lee@kernel.org> wrote:
> >
> >  * A potential buffer overflow warning in PCA955x was reported by older GCC
> >   versions has been fixed by using a more precise format specifier when
> >   creating the default LED label.
> 
> I'm trying to encourage people to use more straightforward language in
> commit messages, and I ended up rewriting some of yours.
> 
> In particular, try to avoid passive voice.
> 
> So instead of "A fix has been implemented to Xyz" just say that it
> contains "A fix for Xyz" (or even just "Fix Xyz").
> 
> Straight and to the point.
> 
> As an example, I edited that "was reported by gcc" and "has been
> fixed", so that bullet point became
> 
>        - Fix a potential buffer overflow warning in PCA955x reported by
>          older GCC versions by using a more precise format specifier when
>          creating the default LED label.
> 
> in my tree.
> 
> This is not a huge deal, I just wanted to point out that "simple and
> to the point" is a good thing, and talking about fixes in some kind of
> passive voice is just strange.

Thanks for fixing.

I'll try to bear it in mind in the future.

-- 
Lee Jones [李琼斯]

