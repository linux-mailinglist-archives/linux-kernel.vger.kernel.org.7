Return-Path: <linux-kernel+bounces-724636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA74AFF518
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 01:02:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4130A16ABFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFBE31E9B3D;
	Wed,  9 Jul 2025 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sApYsoYX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82D16DEB1
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 23:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102127; cv=none; b=N6eg9AGb2/Q/7r0LC/t4EfTJfTbGg34glNCd4WnaMwBErPDdDVPhl+bj+8UnCUkcUrNFQwQKSjibU+v2Y/Q4Kt5F42vYgJtL8pXoCaRlxe5E3GmtmEC3XotrB7QvzXCoQMTu8rCikTZxKove+pV1aHnEKOpkeY7Eme5n24V/ttI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102127; c=relaxed/simple;
	bh=X+wyGYzqpEPeA3lD3fYlmzNuBNRgI4mDn/pMcVp0HEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gwr5NPf5lTV7rSP6Hg4qGXPFSZsbv02z4GWgjVnsAhRRbn6lZCSqKKY5VijBwiGZwsLB9dvQ0kwrWsFdF75LvVNUNUSS6qRqwOkSA36DxSAmXPbSuEkqLKzefZeDm6uOT5SAW8g4JEl+guif3lGjBYezoDthP5pAPtmbf836+0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sApYsoYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6237C4CEEF;
	Wed,  9 Jul 2025 23:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752102126;
	bh=X+wyGYzqpEPeA3lD3fYlmzNuBNRgI4mDn/pMcVp0HEw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=sApYsoYXtBZT0GhDGHCHu/jj6CQ4kZUb3XaGZssx2Ruy2EmQJkH/w3WmtO7R0yMrX
	 CfcJOLwXGMpeGswtBRDSK/up+FlK62tmEUx0QtOQyn0upl7qzwxhSiPAooInym8EqU
	 lspzaRp6RAjPC0nfGC9dxSGBamTt24P1xsXdHZTcyI7JCwDcXzlWgVU5T2ryEbguNY
	 vvKKK6Z5cHL2q9xQ6By2huOw/Oz1Ib8inGmIxy9LFrOPVDHU8z+pVQy3K2RQ9cMAT9
	 VPX57CRueCYzXN63VtfdnhTwfmSVNARSQGlC0JQONher39b7en7OQMyEG/97fzu3xg
	 QP3+rHcBks5qw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 90386CE0C26; Wed,  9 Jul 2025 16:02:01 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:02:01 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Mateusz Guzik <mjguzik@gmail.com>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jon Pan-Doh <pandoh@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Karolina Stolarek <karolina.stolarek@oracle.com>
Subject: Re: [PATCH v6 2/3] lib: Make the ratelimit test more reliable
Message-ID: <0740de0d-4097-4beb-9e94-6b1b77d1c138@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <d1007957-97ff-4f6f-92ac-606f68c65dfa@paulmck-laptop>
 <20250709180335.1716384-2-paulmck@kernel.org>
 <20250709154454.fb140093fa88f4d63fa0d4c5@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709154454.fb140093fa88f4d63fa0d4c5@linux-foundation.org>

On Wed, Jul 09, 2025 at 03:44:54PM -0700, Andrew Morton wrote:
> On Wed,  9 Jul 2025 11:03:34 -0700 "Paul E. McKenney" <paulmck@kernel.org> wrote:
> 
> > The selftest fails most of the times when running in qemu with
> > a kernel configured with CONFIG_HZ = 250:
> > 
> > >  test_ratelimit_smoke: 1 callbacks suppressed
> > >  # test_ratelimit_smoke: ASSERTION FAILED at lib/tests/test_ratelimit.c:28
> > >                    Expected ___ratelimit(&testrl, "test_ratelimit_smoke") == (false), but
> > >                        ___ratelimit(&testrl, "test_ratelimit_smoke") == 1 (0x1)
> > >                        (false) == 0 (0x0)
> > 
> > Try to make the test slightly more reliable by calling the problematic
> > ratelimit in the middle of the interval.
> > 
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > ---
> >  lib/tests/test_ratelimit.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> Patch 1 adds test_ratelimit.c and patch 2 fixes it.
> 
> Unconventional (and undesirable IMO).  Would the world end if I folded
> 2 into 1?

Folding them together works for me, as long as Petr is properly credited.

							Thanx, Paul

