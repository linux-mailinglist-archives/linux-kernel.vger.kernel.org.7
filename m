Return-Path: <linux-kernel+bounces-761485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D84B1FABA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 17:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81511175DCA
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Aug 2025 15:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8BD267B12;
	Sun, 10 Aug 2025 15:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aFH0+/FP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CEB1531F9;
	Sun, 10 Aug 2025 15:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754839499; cv=none; b=c3vdjSLSLxzmWLePFP9k6/bt63UafPvFmN6b/zIEAsoFfHQjDwixr6oHyknJHeBVcBuoPnwva7HA8POO4FAIR7dRKDyScmGv06dRxX+PYH22dFdvdtjeyXnhxj+DfRE+Lfxz5G8642tsSBTd64m3BVCEFHCraUTJHi4NVPscdr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754839499; c=relaxed/simple;
	bh=PLxj+5oEAOsT67VdDk+2iuZq/HsnoFHEhynn/Tyf3gs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4DAjRjC6HJ8UZ/ptvBb+hQwq192oOXOH2FCYfQHy2WLDKiU3dVCFkMKcgijm6SSiYycgbhxdkZIPj9W8nTCcKEfKcK4nKRIT7E9bNismsVwtuaQILLCLBo09wRSY5NenElncFKuDO0fg11jZKah299o3owBdm72E2EHv0s1Kdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aFH0+/FP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3C8C4CEEB;
	Sun, 10 Aug 2025 15:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754839499;
	bh=PLxj+5oEAOsT67VdDk+2iuZq/HsnoFHEhynn/Tyf3gs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aFH0+/FPyi7lfvCWUoFyttfWxrILDxgBt1wrylmuXeH4nRa7CVepd9kfSrqeIZ1cB
	 v5GNAevMLo0cYf6RYwSkB/hx35ITzFNb9eugnFaYfR2Z6Sc8Wb3BDGhi++yw8aWhJn
	 IOFfqMvw42wB4uvLuNQDMjoOGpcUAirD+5QiQSgc=
Date: Sun, 10 Aug 2025 17:24:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [GIT PULL] TTY / Serial driver fix for 6.17-rc1
Message-ID: <2025081054-embark-sessions-4a18@gregkh>
References: <aJdf0rAZ5x5klUhX@kroah.com>
 <2025080937-hardly-facial-cde0@gregkh>
 <CAHk-=wh-x5kbjAZHK4Xto_Qpf55iMrAvKhAzGpoHT6fDZfkzJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wh-x5kbjAZHK4Xto_Qpf55iMrAvKhAzGpoHT6fDZfkzJg@mail.gmail.com>

On Sat, Aug 09, 2025 at 06:18:50PM +0300, Linus Torvalds wrote:
> On Sat, 9 Aug 2025 at 17:57, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > And, as proof I shouldn't send pull requests a few mere hours after
> > getting home from a week long vacation, I got the version number wrong
> > here, it's 6.17-rc1, but the tag and the text all are correct, this
> > affects your tree now.
> 
> It's not like I even look at the tag name, so I wouldn't have noticed
> if you hadn't mentioned it.

Ah, good to know, now I can put almost anything there :)

Thanks for taking this last minute fix,

greg k-h

