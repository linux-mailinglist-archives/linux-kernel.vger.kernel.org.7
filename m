Return-Path: <linux-kernel+bounces-744745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028B8B1106E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 19:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB564E54F0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE642EB5DA;
	Thu, 24 Jul 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMcKYc+7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26E291DFE0B;
	Thu, 24 Jul 2025 17:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753378660; cv=none; b=k3guYCz4wdiYmJDUqO1Hh9WM1xgKKx+a8/tKCep8mIXVqmC/17U7UOjGhwzXvPGAQhVNhAjwCW4OvpC01xJGFN4B/CqlYF+OoF91Qas6wV8tt8488ws2LzoefeynL7Opqpm8gU/d8dYZzPm3B6YSqszVlfc3RRxmXdSgib+0HEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753378660; c=relaxed/simple;
	bh=po8PkYBzro/4vaDck+2ldRRnaKwqkkIL2j9Lob2lhJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ux+jwtnWxf/yObxEQGqwWvkx1SSeAj/M/uUfvnoqGHWvXqKk+uoQz7RwSqJwHtep6pXh3giSKkO6tpJGI5Ww7Hx7G/SUsWZ2P6aLV9v5krCAiweg0m1JwAYBXLhD4cOi9irl1DooNf1a67LklpWPVYC9WQ2O8im1+qUJOHKoQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMcKYc+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FFECC4CEED;
	Thu, 24 Jul 2025 17:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753378659;
	bh=po8PkYBzro/4vaDck+2ldRRnaKwqkkIL2j9Lob2lhJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KMcKYc+7UbTHCWwnp2qPdNR+FwbAXYoGbJkyRxtxuX3dVzI33+BtyxUGr4/j3AJoA
	 /hEnvAMuPuFr/mxX7MHAb7+/wcKoS76lHKrcT+d9sJ5L7s+Ue7BgzqvIU8wihYhXYI
	 2hziOVPwQJP/R288TLo+F0sxjg0GBN3VfOEipPP9xMB2yzlBLUDgA1p/QbAVsBd3a5
	 IZ/dm3LEcGlsY29mqFZctq42egviso3VgfKxlw5OaPDKcmyWw1qF/wfqB83Ta6VTWZ
	 dW4OY12pf7uVKpiDUccr1fQGGZhWq/wIToJW+N+x5iuDibnL4Fl1CaCEw7LjRgIAPD
	 q5xKrbIVYQAzw==
Date: Thu, 24 Jul 2025 10:37:39 -0700
From: Kees Cook <kees@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	linux-kernel@vger.kernel.org, jann@thejh.net,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] futex: don't leak robust_list pointer on exec race
Message-ID: <202507241036.20E180AAA7@keescook>
References: <20250607064444.4310-1-pranav.tyagi03@gmail.com>
 <87cybdp7to.ffs@tglx>
 <CAH4c4jLjSBxbd3bqkdgcCSWqXURratANgnbq9negrSU283xHpg@mail.gmail.com>
 <87frg3ss9s.ffs@tglx>
 <CAH4c4j+P2MJWZWv6M2s+wOdfCF6q6Wyq3=VsB=uNCtEH1LMp-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH4c4j+P2MJWZWv6M2s+wOdfCF6q6Wyq3=VsB=uNCtEH1LMp-g@mail.gmail.com>

On Wed, Jun 18, 2025 at 11:50:31AM +0530, Pranav Tyagi wrote:
> I hope this explains the consequences of the race condition. If it is fine,
> I'll add it to changelog when I resubmit with the helper function.

Thanks for working on this! Are you still planning to send a v2 of this
patch? It'd be lovely to make progress on closing out all the items in
https://github.com/KSPP/linux/issues/119
:)

-Kees

-- 
Kees Cook

