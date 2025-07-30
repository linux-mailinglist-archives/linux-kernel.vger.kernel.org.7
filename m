Return-Path: <linux-kernel+bounces-751128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA90FB1658D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 612B97B408F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4E52E0B4E;
	Wed, 30 Jul 2025 17:32:16 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0092E090C;
	Wed, 30 Jul 2025 17:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896736; cv=none; b=ljGR8I8JEDS9ltsutl1tNujMqAwpquvN2iyQQCViMN/4j0zG3qECW1r0mASisYxB9DkBbJHyV93R1wv7r3W/6NRZ9k1+hNaU7iNI8+G+kX1qHgxVbhWxTrWTteozk6ifvvhGWSitceNOkBSNCIdJwTHH9l/O/VZv0/zI7AjQR/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896736; c=relaxed/simple;
	bh=NinQQys2498qyiNBRGcS8/lpTf8W0uQhxhbbIBHawyI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uxQgFCtIFu6XM+myjVEaSt+WC2/Tm5fakl8qS64+v6QkRPBPz9VdgO75h/7CLmtvSBjeBDIqezqwJeaVLUpS4u9kfewe8Y30XEirLgU4/JGPBs82V081XQi6mb5vT1nNFt1jvkrd8E9VcOFB831yBgvy6ZFtSb6QfpTHdieD6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 748831DB81A;
	Wed, 30 Jul 2025 17:32:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id E77F32000D;
	Wed, 30 Jul 2025 17:32:03 +0000 (UTC)
Date: Wed, 30 Jul 2025 13:32:20 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, Greg KH <greg@kroah.com>,
 corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
 josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, "Dr. David Alan Gilbert"
 <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250730133220.6e7e9370@gandalf.local.home>
In-Reply-To: <eaf1366f-4b28-4312-a820-1cd04796ff1d@lucifer.local>
References: <20250727195802.2222764-1-sashal@kernel.org>
	<7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
	<2025072854-earthen-velcro-8b32@gregkh>
	<df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
	<20250730112753.17f5af13@gandalf.local.home>
	<158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
	<20250730121829.0c89228d@gandalf.local.home>
	<aIpKCXrc-k2Dx43x@lappy>
	<a1022055-52bd-4948-9399-908b29ca140a@lucifer.local>
	<aIpSlhPTC9G1AqvO@lappy>
	<eaf1366f-4b28-4312-a820-1cd04796ff1d@lucifer.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E77F32000D
X-Stat-Signature: 6b5x577wte8ozgpt6i5917esadg8nq8t
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19LcGNo0LjgW2Ekbt8lrE84SyalwtrTsMY=
X-HE-Tag: 1753896723-530352
X-HE-Meta: U2FsdGVkX19fG+MKAppCGtg6IG+I+Tb+G4lC6YsQJXtiTB7Xuv+xearwLeAEfIzNXYTaWMc3S1wyBmF6w7Sfd6otwJjRxk5bR8ujSpW0J5rFd2VP/Lwr5L7rJ5iExHFogjRI2prpmTTICcDVY0fvU6jTKoYYWfFyBMAmMTD31gTENq4wtN8HcOwDzgv9/nA0I14rjDNuKigFwi11iWcQYrFl0taFAG8fvGWMapZkjd79XdSgDjIyIPTL5o5x9gUsM/S2n35JFBWnlhw34VLYVkG/bfPIK03WwMrYrnN7l3jTSv0Awj8hjyGCMKnK1lEIMOy2BD2l9Pxf3apZywURFv+o9os3PA6W

On Wed, 30 Jul 2025 18:23:14 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> > I don't think we should (or can) set a policy here for other
> > maintainers. Right now we allow tool-assisted contributions - flipping
> > this would mean we need to get an ack from at least a majority of the
> > MAINTAINERS folks.  
> 
> Sasha, with respect this is totally crazy.

I'll somewhat defend Sasha on this.

> 
> Assuming every maintainer accepts AI patches unless explicitly opted out is
> very clearly not something that will be acceptable to people.

You can opt out when you receive your first AI patch ;-)

> 
> Assuming an LF policy most maintainers won't be aware of applies with the
> kind of ramifications this will inevitably have seems very unreasonable to
> me.

This is why the policy should just be "It's up to the maintainer to decide
if they will take the patch or not".

If the maintainer starts getting too many submissions, then they can update
the MAINTAINERS file to say "stop all AI patches to me!". Just like we have
an opt-in for to not be part of the get_maintainer.pl "touched this file"
with the .get_maintainer.ignore script.


> 
> You might suggest presuming a policy for maintainers is inappropriate, but
> you are doing so wrt the LF policy on the assumption everybody is aware and
> agrees with it.
> 
> That same document says individual projects can _override_ this as they
> please. So the introduction of this document can very well override that.
> 
> We at the very least need this to be raised at the maintainers summit with
> a very clear decision on opt-in vs. opt-out, with the decision being
> communicated clearly.

Agreed.

> 
> It's maintainers like me that'll have to deal with the consequences of
> this.

And you may be the first to opt-in ;-)

-- Steve

