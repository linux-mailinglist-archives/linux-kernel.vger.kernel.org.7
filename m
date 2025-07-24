Return-Path: <linux-kernel+bounces-744024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9BEB10706
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A928188E6F7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A12F2571BA;
	Thu, 24 Jul 2025 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fmbaoJo1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89858256C60;
	Thu, 24 Jul 2025 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753350762; cv=none; b=k7J/0Rpeu1/+dEw/cseZmd6H+i0haB248oGJoB6c4hRwvRzthLGTslQ1PLx6mtVg2E7q0f4Z01xiN61C/I8GVuoqbMj0sZblO81JRbTeRNnzzirEnn+uo1xObF/ZyYd3OJEW1tyCiRp9ZlMnvbjBcDUTqMa4RL6ICuz3ctNjLPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753350762; c=relaxed/simple;
	bh=Da9kJ9HlXZb6IhZHKni7Vr+93AneHuYm1kyDSU+Yxss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QOLGgXTCghmxkcCFNzyQwBXHdBk9/fGuTn/s1/qEDFJYjIe3GFgyhfR0S3JwqdsRSrSGOCRX6wdFghhj4C+D7q+yogWyxemFmYp3AK+e3Z8AJr2jiEuee1GLgfbCCXl8U3YGQOzWrpJKc0ZUgdUKRJn86TIQ/r1bJ5Lagi2B3tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fmbaoJo1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DAAC4CEF5;
	Thu, 24 Jul 2025 09:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753350762;
	bh=Da9kJ9HlXZb6IhZHKni7Vr+93AneHuYm1kyDSU+Yxss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fmbaoJo1kIHyhIOCrZndtdMSWBuTj+XcEDb+EdmRAzGwySSYbX0S3wpH5I6Y7vEys
	 bnor/Pk3zm376mHndsyXiKG5R7/HL5V8aBpCyNPF+8FY0+FN9U+zjV4MXZapYuobDZ
	 /QiakAnOzAKittWVyNnj4fFOKZT+0dMx+2OIeocxwtGWbPLOGPFDATLoUs0iJKrAHI
	 yZRM5k3AZyrwMKdsdmDG8j+iAhd8ITNuEbRR2tIcfwc7ehJABRckW5i+wh/jWu6Hhs
	 0qz7/8S9D0DSzKUvE8KwOG4ReVCa2vxLJKqf5Dfeg3PaVKdlkuCeSgy4im/0w5cLr/
	 hNioqKzzLmqLA==
Date: Thu, 24 Jul 2025 15:22:38 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Sergio Perez Gonzalez <sperezglz@gmail.com>,
	yung-chuan.liao@linux.intel.com, pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: sysfs_emit() expects a buffer of size
 PAGE_SIZE
Message-ID: <aIICZmB5-7gj1M6W@vaman>
References: <20250723230927.109534-1-sperezglz@gmail.com>
 <87o6takqd3.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o6takqd3.wl-tiwai@suse.de>

On 24-07-25, 09:19, Takashi Iwai wrote:
> On Thu, 24 Jul 2025 01:09:25 +0200,
> Sergio Perez Gonzalez wrote:
> > 
> > In read_buffer_show(), allocate sufficient memory to pass on to
> > sysfs_emit(), which expects a buffer of size PAGE_SIZE.
> > 
> > Link: https://scan7.scan.coverity.com/#/project-view/53936/11354?selectedIssue=1648019
> > Fixes: 35323d8ab811 ("soundwire: replace scnprintf() with sysfs_emit() for sysfs consistency")
> > Signed-off-by: Sergio Perez Gonzalez <sperezglz@gmail.com>
> > ---
> >  drivers/soundwire/debugfs.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/soundwire/debugfs.c b/drivers/soundwire/debugfs.c
> > index 825f7abbad32..08fb1e29026e 100644
> > --- a/drivers/soundwire/debugfs.c
> > +++ b/drivers/soundwire/debugfs.c
> > @@ -306,12 +306,12 @@ static int cmd_go(void *data, u64 value)
> >  DEFINE_DEBUGFS_ATTRIBUTE(cmd_go_fops, NULL,
> >  			 cmd_go, "%llu\n");
> >  
> > -#define MAX_LINE_LEN 128
> > -
> >  static int read_buffer_show(struct seq_file *s_file, void *data)
> >  {
> > -	char buf[MAX_LINE_LEN];
> >  	int i;
> > +	char *buf __free(kfree) = kzalloc(PAGE_SIZE, GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> 
> IMO, it's better to scratch the whole previous change.
> It makes little sense to allocate a large buffer here just for the
> temporary formatting.
> 
> Moreover, *_show() functions there take seq_file pointer, and you can
> just use seq_printf() directly.  The sysfs/kobject show callback is
> with the a fixed PAGE_SIZE buffer, hence sysfs_emit() is useful, but
> in this case, it's a completely different story.

Agree, dropped now!

-- 
~Vinod

