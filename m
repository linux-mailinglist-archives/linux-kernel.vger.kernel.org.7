Return-Path: <linux-kernel+bounces-666492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E4DAC7751
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 06:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 979161BA00BB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 04:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF7925229C;
	Thu, 29 May 2025 04:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DUfKqDlk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3741A2643;
	Thu, 29 May 2025 04:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748494036; cv=none; b=uCBxPPCkoOck1PnG3HX0A5Lzp1Ws8pn2T/DlZKYJZbvOpos8Yl3rxMuqmn4iBtoFQlPe69vLfqWXHQVS7zOTb3qVYeD+Td2jiOjNWZBa6WJ/gp+L9NKe1vZtxvJ1hqRpPPZFgX+agWDEu1ximWulZFHvZzicdVtUsqRjuR6qAfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748494036; c=relaxed/simple;
	bh=AQvpGrvVHzdCNOLS7M9nxYozPa3Upe+YZyZ3oSHoX3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psk1atU7Xkv+4xD2yJ0FzBtkr8/k0WLxWjNbzwgS5s4R3ezNou+RpHBOB1I2P6lWLDG4j2y+G7pvNSn5f4ygaVHKuUpTfaB+o4nJA28gk0QMrelgdlns7QyyOnwUXhp9B9Uj/7DOpvTn8t/HXM8yZoXg/+actjSGRQPqNrKZhU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DUfKqDlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C19C4CEEA;
	Thu, 29 May 2025 04:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748494036;
	bh=AQvpGrvVHzdCNOLS7M9nxYozPa3Upe+YZyZ3oSHoX3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DUfKqDlkrBNAb7Lvw4Jsi1V79xhOjxioV6vvrabCW+Srd0/hgPkfLQLWXKluXHP0/
	 zmPreT6qInfrDLrba9GvmhB6nThh+SBKUJbuDEmy12Hl0dYIVRd9qPItmi8WFSVzhA
	 U1KDPsgBmSlVM2wEpOfdz8uttahDXid6Q+rs8R/A=
Date: Thu, 29 May 2025 06:47:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kees Cook <kees@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Eric Biggers <ebiggers@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>, Marco Elver <elver@google.com>,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ubsan: integer-overflow: depend on BROKEN to keep this
 out of CI
Message-ID: <2025052937-certainty-encode-4085@gregkh>
References: <20250528182616.work.296-kees@kernel.org>
 <20250528213223.GA3885532@ax162>
 <202505281559.FD37A978F@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202505281559.FD37A978F@keescook>

On Wed, May 28, 2025 at 04:00:03PM -0700, Kees Cook wrote:
> On Wed, May 28, 2025 at 02:32:23PM -0700, Nathan Chancellor wrote:
> > On Wed, May 28, 2025 at 11:26:22AM -0700, Kees Cook wrote:
> > > Depending on !COMPILE_TEST isn't sufficient to keep this feature out of
> > > CI because we can't stop it from being included in randconfig builds.
> > > This feature is still highly experimental, and is developed in lock-step
> > > with Clang's Overflow Behavior Types[1]. Depend on BROKEN to keep it
> > > from being enabled by anyone not expecting it.
> > > 
> > > Link: https://discourse.llvm.org/t/rfc-v2-clang-introduce-overflowbehaviortypes-for-wrapping-and-non-wrapping-arithmetic/86507 [1]
> > > Signed-off-by: Kees Cook <kees@kernel.org>
> > 
> > Should this have a 'Cc: stable@vger.kernel.org' on it? There might not
> > be much randconfig testing on stable but it is still very much possible
> > for some random user to turn this on and report problems.
> 
> Ah yeah, I should probably do this via a proper Fixes: tag. I'll add
> this.

Nit, "Fixes:" tags alone without a cc: stable do not guarantee they will
end up in the stable trees.  Always explicitly add a cc: please.

thanks,

greg k-h

