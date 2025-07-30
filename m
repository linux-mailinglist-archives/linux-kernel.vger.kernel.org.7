Return-Path: <linux-kernel+bounces-751039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9FCB1647E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6F6188B438
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B372DEA7D;
	Wed, 30 Jul 2025 16:18:20 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD6718DB24;
	Wed, 30 Jul 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753892300; cv=none; b=TmYq/Ml6L9WQcn8OwxxVZxvxSZLmwVAIWz1/nmY52XOTB+qugki0BT9Ef1vhN/B/CewvfIqwvrZweGeO6ikmY7lF3wGnpexqWn9lRlKbLfYzyGHnf6uhUi3xEmDhY42hgc0cnn9j3ATKrQCoWgZRVp1eZ9yLHc2p8GkFoc4a2ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753892300; c=relaxed/simple;
	bh=7WHhap0k6u/Z0S7ZHEjO3hNhdKajez3+9KgQ3VaxjQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jRCLJgvDz4u5TJBO2UMoV4sPvb/ig2qIyC6K103Q9PZ1p1n9NysavHMWjZbfAS7UcfGs8Q6n+l3fLJmfmtT0DuiPxGLI0a1E3QIDjpBzOzuFPdLj5FgW4Y6d4iQXpvOV/I0z8zhz0Oa95h6tXrWIVnJJfIfpPTFrYr9vdiHmGtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 9611FC045B;
	Wed, 30 Jul 2025 16:18:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 084DD20013;
	Wed, 30 Jul 2025 16:18:12 +0000 (UTC)
Date: Wed, 30 Jul 2025 12:18:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Greg KH <greg@kroah.com>, Sasha Levin <sashal@kernel.org>,
 corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
 josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, "Dr. David Alan Gilbert"
 <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250730121829.0c89228d@gandalf.local.home>
In-Reply-To: <158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
References: <20250727195802.2222764-1-sashal@kernel.org>
	<7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
	<2025072854-earthen-velcro-8b32@gregkh>
	<df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
	<20250730112753.17f5af13@gandalf.local.home>
	<158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: of8tfcj65x1moznasd1u9c4acq6p1dx9
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 084DD20013
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1922e4tR6MPdhlbaQ4aZ4zeQnNCLT3FH08=
X-HE-Tag: 1753892292-25121
X-HE-Meta: U2FsdGVkX19PKljvnUbhYYqiGquQ96lDjf2eX/gtxyal8PzFRJp9QFDNTGR/4RyRRmsY72blv+STxTlUXG8WniZmAeORRf8bZNob1DDsofdV4z6BgBCexPQVPTbv6RcV/arvw31V9etXVoLy3St7qvadCfb5Mk/1AN0tUH3v+5JrzVc/uk8IExQIySnPot97J698gDv58oS5Zv736gRnO867Wwcm8zaHXk++aDGOkYNjv3JSt8F6K0t8fvBnWx7epy2u2IcLkT6gnbMnBngUiQ0lACbtzyS8FslHzetXMBwqJnYjkRFVXtjAnUPiKJ6P+XwPDuqGtRPaivIYQPU9xknYa764yLTk

On Wed, 30 Jul 2025 16:34:28 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> > Which looked like someone else (now Cc'd on this thread) took it public,
> > and I wanted to see where that ended. I didn't want to start another
> > discussion when there's already two in progress.  
> 
> OK, but having a document like this is not in my view optional - we must
> have a clear, stated policy and one which ideally makes plain that it's
> opt-in and maintainers may choose not to take these patches.

That sounds pretty much exactly as what I was stating in our meeting. That
is, it is OK to submit a patch written with AI but you must disclose it. It
is also the right of the Maintainer to refuse to take any patch that was
written in AI. They may feel that they want someone who fully understands
what that patch does, and AI can cloud the knowledge of that patch from the
author.

I guess a statement in submitting-patches.rst would suffice, or should it
be a separate standalone document?

-- Steve

