Return-Path: <linux-kernel+bounces-782950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB85DB32786
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 10:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A04894E1647
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 08:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F552264C9;
	Sat, 23 Aug 2025 08:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yDJxjKX6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED91662E7
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 08:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755936066; cv=none; b=tP9492YpkibgROIuhJOQ2ZQPcM8HxWjTEz1hs1xSISAYi/AxLb2ZWPnb2+0VQFffuN1apTntRrcjriPPUbjkHjd6UujMVheoNt8VS/vUXviSwNkon1cJssJtIPaNPN5V2Rn0crxp7BqR9mjEOqkZzXX4h5ItT2snBkH2rIoAN28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755936066; c=relaxed/simple;
	bh=984FHb5AOhpvcvvYgScRhcwhRLkuDooutUv6huPZH10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W12RtARQut7cYEhc1CyNCQCpSaBSRCOER31WFbF176ZyleI6az0zbJr9LiX81ud6OqQqIsKKFGNCWc553fsJD0vZb2SeQskpKb9mQ0TiKgBSKJfE84JVprJ+Z5BvZq9aW7JxOu/t6kyXrLe65vKBOxlT3oZ2sZeeAJGSdTgUHbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yDJxjKX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B86C4CEE7;
	Sat, 23 Aug 2025 08:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755936065;
	bh=984FHb5AOhpvcvvYgScRhcwhRLkuDooutUv6huPZH10=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yDJxjKX67efN94aIAtWa/UTkWdTFZJuQ8IfI/EE3oQWcz0Ke90LzBQr98Gx4f9Chk
	 ZhmsOVOEpkb2zRe4mKdG0gb6C2XhxsQ6hcPNPMk93JOx9MPlwj7r+wnIKqRC14NsSs
	 Hy6xG1XhRtXM4qbtMNmM8bPK1qIfwRPq9WYP2APQ=
Date: Sat, 23 Aug 2025 10:01:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org,
	safety-architecture@lists.elisa.tech,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH] /dev/mem: Add initial documentation of memory_open()
 and mem_fops
Message-ID: <2025082352-ending-immerse-fee4@gregkh>
References: <20250821170419.70668-1-gpaoloni@redhat.com>
 <2025082120-emptiness-pencil-6d28@gregkh>
 <CA+wEVJb-yBYZqnVs_D4VYvqYsG1k=BFsPzp3ms1=646q3dCLKA@mail.gmail.com>
 <2025082209-laborer-hesitate-76cc@gregkh>
 <CA+wEVJZntQ6Fx8VWzL-PpKWw7=vxKQewxkUfu_f01Px2EFtRZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+wEVJZntQ6Fx8VWzL-PpKWw7=vxKQewxkUfu_f01Px2EFtRZQ@mail.gmail.com>

On Sat, Aug 23, 2025 at 09:48:32AM +0200, Gabriele Paoloni wrote:
> > > > > + * - The file position '*ppos' shall be advanced by the number of bytes
> > > > > + *   successfully copied from user space (including skipped bytes).
> > > >
> > > > No short summary first of what the function is supposed to do normally?
> > > > Or are you relying on the few words at the top to summarize that?
> > >
> > > Function's expectations would define the testable behaviours (so they
> > > are broken down into detailed expectations); nothing prevents to provide
> > > an informative intro above "Function's expectations"; I could clarify this
> > > in the patch for the doc-guide  and revisit this patch with informative intros
> > > for all the functions....
> >
> > "testable behavior" is going to be very hard given that you are
> > describing an internal-to-the-kernel function.  Good luck!
> 
> Well that is something to be figured out (step by step :-) )

Well what is your end-goal here?  Do you need/want all functions in the
kernel to be documented like this, or do you only want those that are
describing user-visable functionality?

What is the requirement that is causing you to do this work?

thanks,

greg k-h

