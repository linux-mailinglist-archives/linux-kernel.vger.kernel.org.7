Return-Path: <linux-kernel+bounces-751120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 579D4B16573
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B926D1AA3D63
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B6E62DFA54;
	Wed, 30 Jul 2025 17:25:17 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42B82D839C;
	Wed, 30 Jul 2025 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753896316; cv=none; b=E57vljAP7vxejezHUogIaAPhoEr0ssjE3XvYoxPV4LFD8vO4jxZf3UTqgbc8Nm2zqXXSH3Oc7oJkUyuy/CzidD7sq1DPxZqHUQUM7AfsqiIRCbwO8Qqqqrqu5FYihR6trCZD4U1mtK+qgvctI7Fs/sQKkTFqibsRQkW5NkZTI/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753896316; c=relaxed/simple;
	bh=HN4Bnc+XS/4uRHJ4LG6byKEC41w6L+dxSrVLaFVeh+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ixTw5X4vOK10UgvpnCgmxaZa6WwI4O0+uM9QUDrvzM+24yI7GxzV85/uoYP14LYwNV+JSt67bSYhhwnUAXROte0xbgwCMZuOFYyD69ah4B1b7kHh0QqObd3ibrMNGDkDCTchBaUapgHWPX+ETsMoUYWxxAXVeeVOXo7QTQAJNsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id C62D8C04D3;
	Wed, 30 Jul 2025 17:25:12 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 4E0C417;
	Wed, 30 Jul 2025 17:25:10 +0000 (UTC)
Date: Wed, 30 Jul 2025 13:25:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Greg KH <greg@kroah.com>,
 corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
 josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, "Dr. David Alan Gilbert"
 <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250730132527.69617dbb@gandalf.local.home>
In-Reply-To: <aIpSlhPTC9G1AqvO@lappy>
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
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7e6m3o8nyktxpyg4bszjcr6fyy7w7gs5
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 4E0C417
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Sm1A2oNr8D5y7oXE8FmPulswLzRKNYMc=
X-HE-Tag: 1753896310-682708
X-HE-Meta: U2FsdGVkX1+jfJjTvt95jotAeAoHH+CvCbGu0cU/czd+4TVXLZqpyAGVrDuztR6dLLjDiMBhrwylw6AOX4WDlPipodqmbuDVBsNYejgWQ0azdM8g9pVWt/CgWinD+xkA6lcxHK7pHnmui02s9AFu/hTkheLHZjYU58qG1uWjYJEQHaDMNZHrNSvNyOBSOGVVlEck3LTOrPcFieDtJqeos4hw4tC8qFsi/oEjf0VdeMqyND3y3KmhxUw8MmD8bT/XS2S8P0lUzuOaexXpfP9WV6l/MzP3KXETUgyLDHveYfHdUwi2x00QZ7H5IKl/t9nxidbdNpcpkHttwmJ/TeFfbNhzvgvhKHQF

On Wed, 30 Jul 2025 13:12:54 -0400
Sasha Levin <sashal@kernel.org> wrote:

> >>
> >> Some sort of a "traffic light" system:
> >>
> >>  1. Green: the subsystem is happy to receive patches from any source.
> >>
> >>  2. Yellow: "If you're unfamiliar with the subsystem and using any
> >>  tooling to generate your patches, please have a reviewed-by from a
> >>  trusted developer before sending your patch".
> >>
> >>  3. No tool-generated patches without prior maintainer approval.  
> >

Actually, I'm not sure I care for the above, because honestly, I wouldn't
know which to set my subsystem to. It would be a case by case basis.
Sometimes I'm fine with the automated tooling as I can tell that the one
using it knows what they are doing and use it as a tool.

But I have refused patches from people where it was obvious that they had
no idea of what they were doing and just submitted something because
"checkpatch" or "coccinelle" said so.

-- Steve

