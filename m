Return-Path: <linux-kernel+bounces-749536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84993B14FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DCCB18A3F00
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81713286D74;
	Tue, 29 Jul 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uO6bTyoa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3A7279798;
	Tue, 29 Jul 2025 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800928; cv=none; b=EQ57MBmSDIYuXV2/6E44kI+HMFZ8UNIhZN8q4tW/u/DWQumVMliVtkTINoVixxGNFHvO0aW1lrLjSN5TBo2otGBMsxr5Qu3343HT0HXVBmi2X4FC9EwSk46W1mdsvYcVfO/F+LYLFlTIhc59WK9Aigpndfwb0/OER9PDPei3kcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800928; c=relaxed/simple;
	bh=Q3gYf/DIMIEXPt6UJykgS6edcrSiP3yAlz0MAKHuu50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lBy7F4FHeAETp0ahWvcA8jMsxIS/egjrKvcsBv1Wi5cWgjF7apaMTrNdVMjLSM0tG6Y2iUIDt2XHCxSyfbSDQ81muXoUuMIgpgP2TGMq8NC2Z/Vu+8xj5aSfg+dsL6huAWwfeAnAhQ7vxCyAYkuK0nIbo/QW98/Lv1B01D9C8/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uO6bTyoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7752C4CEEF;
	Tue, 29 Jul 2025 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1753800928;
	bh=Q3gYf/DIMIEXPt6UJykgS6edcrSiP3yAlz0MAKHuu50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uO6bTyoampMvY8EOYkhjMShe5wmvvMZJ4KAgoS9L2Wj4045SwAhjRorh6iMWl/yfX
	 /rROm6t6KUVaH5PFWAJ+rmAtRYgKcZABigBEloJ1PC7EiqhHDcebV6iB/yM9IS2iE0
	 P+Y42eBHgp4Ft7Jsf7jJe0aNDQT0HyGhT5DKxGng=
Date: Tue, 29 Jul 2025 16:55:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Suchit Karunakaran <suchitkarunakaran@gmail.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	linux-kernel-mentees@lists.linux.dev,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Joe Perches <joe@perches.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>,
	kernel-janitors@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v2] checkpatch: suppress strscpy warnings for userspace
 tools
Message-ID: <2025072910-charter-delegator-7f97@gregkh>
References: <20250727125044.101779-1-suchitkarunakaran@gmail.com>
 <079be718-ae8f-408d-a789-05f4816e0bd4@web.de>
 <CAO9wTFiQdHA3JjXAbmXdxmeUHehVY+43+zg4BiYBxY7coSi+Ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO9wTFiQdHA3JjXAbmXdxmeUHehVY+43+zg4BiYBxY7coSi+Ng@mail.gmail.com>

On Tue, Jul 29, 2025 at 08:15:03PM +0530, Suchit Karunakaran wrote:
> On Tue, 29 Jul 2025 at 20:12, Markus Elfring <Markus.Elfring@web.de> wrote:
> >
> > …
> > > This patch suppresses …
> >
> > See also:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.16#n94
> >
> 
> Thanks for the suggestion. Will keep this in mind next time.
> 


Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

