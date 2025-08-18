Return-Path: <linux-kernel+bounces-773810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DC8CB2AB03
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD951BA555E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A112A31AF3A;
	Mon, 18 Aug 2025 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N4WTyqbc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BF327B358;
	Mon, 18 Aug 2025 14:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526658; cv=none; b=j1i+/RyJAitLNqzjzrG/dAOj0Aupx4x5vkagn0DIaDgv4fqpD8tTmV/8hxJl0GrBKcmsInndKZI+0MNwKgfGTj/q25rzlLRwg5WpYbREVo1HZDgwMDdelrttAkw2xzlI0o/lOTPh+hdCUImBuK+THyk+uF+IAeGiK88lZovKWls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526658; c=relaxed/simple;
	bh=H6weieZqmH6RhYEBwQ2kz0Yl41c2kBx3NqTgBGzgAEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwAivqXk4DyaRET5ZUnCNGOQYBqcu323hRiu6jbo5fKtysKnQ9bYbSei9JipTIO09dQUdkGn2z5Z+Myu8jikfbugv9EucqlzO1CXWP9wnsDrChre2jOUaFQDYvQrcy2gkGlyKexFun8ibPm0ZgtggPd1mUVdlVWa4Lat8GZHkXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N4WTyqbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C0AC4CEEB;
	Mon, 18 Aug 2025 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755526654;
	bh=H6weieZqmH6RhYEBwQ2kz0Yl41c2kBx3NqTgBGzgAEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N4WTyqbcvhmD96XQRNiJuW9foMCV9pLvyEsvtaODYtZXab1KxDzIYcU68yy8VqcD1
	 HcD5ddhgVUvlWS4MTJVL0kvq3golVj0OrU3/EWdftCAkp/XgTdGUZJJFtDYD4ch1Cz
	 7AxtQ04UqcQPEzvc6I5bNtGKlBhbhC9HBHCJgkJiM/Q41W774a4gu224bWs8hHP2tF
	 UBykcbQuwz6dMJiTbzE8FZOmgxEKpp4/wv8f0yjjVe5egn2NCf3JzkeZ72LLK5vbOL
	 eQkwseWiNKjYV2c5wKIZaqYFsMMjqYskM/Uo3IM5J9OIqr55xTPoOXOd7+4ulMEXME
	 KhJk0TTYSILlA==
Date: Mon, 18 Aug 2025 09:17:33 -0500
From: Rob Herring <robh@kernel.org>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: Saravana Kannan <saravanak@google.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] drivers/of: add debug for early dump of the dtb
 strcutrue
Message-ID: <20250818141733.GA979958-robh@kernel.org>
References: <20250808142515.142058-1-ben.dooks@codethink.co.uk>
 <CAL_JsqJntD-o6zMo-vaCQ+f=QDuyEmUgBJqjztoriq4QF7=zEg@mail.gmail.com>
 <CAGETcx99RE6=knBq75sMGUPKcuTKLXqJSo5NKyaZWRfXWEa7tA@mail.gmail.com>
 <cd6ed5b1-619c-4ca9-8fe0-6b47c7d641a7@codethink.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd6ed5b1-619c-4ca9-8fe0-6b47c7d641a7@codethink.co.uk>

On Mon, Aug 11, 2025 at 09:02:34AM +0100, Ben Dooks wrote:
> On 08/08/2025 22:10, Saravana Kannan wrote:
> > On Fri, Aug 8, 2025 at 9:25 AM Rob Herring <robh@kernel.org> wrote:
> > > 
> > > On Fri, Aug 8, 2025 at 9:26 AM Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> > > > 
> > > > When testing for boot issues, it was helpful to dump the
> > > > list of nodes and properties in the device-tree passed into
> > > > the kernel.
> > > 
> > > Shouldn't the bootloader be able to dump that?
> > > 
> > > > Add CONFIG_OF_EARLY_DUMP option to dump the list of nodes
> > > > and properties to the standard console output early in the
> > > > boot sequence. Note, you may need to have some sort of
> > > 
> > > s/may/will/
> > > 
> > > > early or debug console output if there are issues stopping
> > > > the kernel starting properly.
> > > 
> > > Seems to me this is giving the user the haystack to find the needle...
> > 
> > Completely agree with Rob.
> > 
> > Ben, can you give more context on what kind of issues this has helped
> > you (or anticipate it will) solve? Maybe there are better ways of
> > getting what you need.
> 
> We where having issues with u-boot on big-endian riscv.
> 
> turns out the string functions had issues with endian-ness and
> where corrupting the dtb when doing the final changes when booting
> into the kernel.
> 
> the kernel wouldn;t boot as sometimes depending on data alignment
> the #size-cells and #address-cells where having their names corrupted
> and thus the kernel would bail very early.

Whether the DT is un-corrupted enough to boot enough to print a message 
is completely by chance there. If the bootloader modifications need 
testing/checking, then that's the bootloader's problem to provide a 
mechanism to do so.

Rob

