Return-Path: <linux-kernel+bounces-808436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F885B4FFAC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 16:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF3371743F9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 14:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241653451D0;
	Tue,  9 Sep 2025 14:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uGx1f+jP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6922D274B35;
	Tue,  9 Sep 2025 14:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428812; cv=none; b=pKOdky2Zs3Sale927lVmT1PDHaWP8an/dzUyRNPIb5L/PzvqDaI7X6S0XHUfNZxzgxZTRKNSDiwa7lLboUNhhb9grTrDG1Ma8r+7IDPA0e4l70swARMLrkm0VD9RR4U93bux/1/ZF+nUH3h8OnEyureuWcEVSa1orGAxCTcYDfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428812; c=relaxed/simple;
	bh=wMve7g6C/ZcITOKfcYRiE8yQDt84LIXKxpCee0BqYAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FCsiINqvaSHnksrl5UzrIcLJ7RllWnDgB9LHzasc+9eMEvwtKFCk1n8P/RvOoNo/rcZZ1BnG5VkgtQk9Ald/++Kv+xU2yg+aNoYFSswW+0Xdl7tNE4Eo282q9Nne32vQE6MoMxX+KXeL3KukIqzTSw7cOhvtn92cGEium0mBc7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uGx1f+jP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87716C4CEF4;
	Tue,  9 Sep 2025 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757428812;
	bh=wMve7g6C/ZcITOKfcYRiE8yQDt84LIXKxpCee0BqYAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uGx1f+jPVEL+onZ8HorJGR5WKb9A4DxoPxLw6HOXwNW1ZiNs+s40oRO+NcYF1nLjM
	 +yvJbUDk2jqk/tiKcmipR9L4ttXWFmz0gtGgMuDzh0H+Cvrk3g9501i9aV1C5dC6u4
	 S6H1DsSDzMSIE5EPMJojDp7osiziMGzjh7ycd+AY=
Date: Tue, 9 Sep 2025 16:40:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: GOPI JEGANATHAN <ggopijeganathan@gmail.com>
Cc: Dave Penkler <dpenkler@gmail.com>,
	Michael Rubin <matchstick@neverthere.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: Declare processor directive as
 CONFIG_TNT4882
Message-ID: <2025090945-yearbook-busboy-2b28@gregkh>
References: <20250909041707.3001-1-ggopijeganathan@gmail.com>
 <2025090940-backyard-mud-253a@gregkh>
 <CAGt2Sa+MriEYjPOFGmKWuHXabwkJeWn7q9o8U14B7o3QY4xmyg@mail.gmail.com>
 <2025090945-ecologist-gravel-d028@gregkh>
 <CAGt2Sa+tKAmxspYX=iyihmZYxWg0=xOJPW+J0h=9rTG8E99AAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGt2Sa+tKAmxspYX=iyihmZYxWg0=xOJPW+J0h=9rTG8E99AAg@mail.gmail.com>

On Tue, Sep 09, 2025 at 07:56:07PM +0530, GOPI JEGANATHAN wrote:
> Hi Greg
> 
> I just saw the warning message in Checkpatch.pl file. It's says #if 0 is
> something wrong so I just change the processor directives properly using
> #ifdef CONFIG_TNT4882, Is that change is wrong!?

#if 0 is a way to comment out code, you just enabled that code to now be
present.  That's probably not the correct thing for this driver, right?
The whole thing is already using CONFIG_TNT4882, so declaring it again
would be the same as just removing the #if 0 line.

In short, only change this type of thing either by removing the code
entirely, or figuring out why it's still present and then fixing it up
to actually be used and remove the #if 0 lines.

thanks,

greg k-h

