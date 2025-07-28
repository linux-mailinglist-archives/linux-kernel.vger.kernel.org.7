Return-Path: <linux-kernel+bounces-748442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E33B14161
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 19:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95FD542590
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 17:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495042701BD;
	Mon, 28 Jul 2025 17:47:08 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C09214A82;
	Mon, 28 Jul 2025 17:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753724827; cv=none; b=JBsuyfDSBYfmyhQYJB0TFa6xQt7v7pDkbnJ9vzt3qZM2gNPfH9TdJpaBHpDcc6xA1HPqajhJu5SbQlyO9THnWB3EExa+9KRMA00POarrkmxjOcOUdljSMQOMAc5lQqTzbI55o++RwXCzVS4+wjc1druoGF7Cd6nMlK96Gv1rsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753724827; c=relaxed/simple;
	bh=SyEMmCynzYvjf3flGglcVAa+hzKsh3WstJS1XG/DGcg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Aa64bBdmuJBUJ8TwbW6C8hHqH1H4EzvKwN1A2HjCcT/iv7FAC1aYzDcE/eGD/66CVcuFtHcXgAavB2J1y4bA+AGgvjQ1HaECVV21NNWve2uETX28rem+Ynxsaaijfok9alJW7QNRv8LP+TVVRVW9rb+CBrq2qc6LnNsi6PsBIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 42EC414033A;
	Mon, 28 Jul 2025 17:46:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id B1D7D20029;
	Mon, 28 Jul 2025 17:46:54 +0000 (UTC)
Date: Mon, 28 Jul 2025 13:46:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: <dan.j.williams@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>,
 <workflows@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <kees@kernel.org>,
 <konstantin@linuxfoundation.org>, <corbet@lwn.net>, <josh@joshtriplett.org>
Subject: Re: [RFC 0/2] Add AI coding assistant configuration to Linux kernel
Message-ID: <20250728134653.635a9dc5@batman.local.home>
In-Reply-To: <6883ea58b5685_134cc71006e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250725175358.1989323-1-sashal@kernel.org>
	<20250725114114.3b13e7b1@kernel.org>
	<20250725150046.3adb556c@gandalf.local.home>
	<20250725125906.1db40a7f@kernel.org>
	<6883ea58b5685_134cc71006e@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: bjgchuyfosmjyw7o5oaiyjckgqa4uuke
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: B1D7D20029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX195WzT8efG1fpm/htR1plhPRRieXnXT+x0=
X-HE-Tag: 1753724814-914488
X-HE-Meta: U2FsdGVkX18i2DLUVpuJ9Gwx6Ro32Ea8BbhE2AjXbjKqEA8lLJsy5OEkOsO6UTQSSodrpfv409xkX27w7TdcNKWsTIUV74P37xkbx2YHS7ZsgeZNAyG5HHHmkI4K6R3mfrVfmLLfu4LrFIPmiCnf8/92FjYUBYM3OKWE53pfTE1afTDIQY+yRA1psg4xig7H3ySgu4baSQCgW/zPOqsFPBstf8l6l6BTj6LEssljQexihf91uYW2C7rO7y5LG1QGaX30+U2pw7w1OEqns3r38b5uGM3rQOnCtHxCSCBmEhQce2VTFzLRAJuC+K3kSduRZ0+afHxnxRffPEz65zBt2kNCgcdfvjDg

On Fri, 25 Jul 2025 13:34:32 -0700
<dan.j.williams@intel.com> wrote:

> > This touches on explainability of AI. Perhaps the metadata would be
> > interesting for XAI research... not sure that's enough to be lugging
> > those tags in git history.  
> 
> Agree. The "who to blame" is "Author:". They signed DCO they are
> responsible for debugging what went wrong in any stage of the
> development of a patch per usual. We have a long history of debugging
> tool problems without tracking tool versions in git history.

My point of the "who to blame" was not about the author of said code,
but if two or more developers are using the same AI agent and then some
patter of bugs appears that is only with that AI agent, then we know
that the AI agent is likely the culprit and to look for code by other
developers that used that same AI agent.

It's a way to track down a bug in a tool that is creating code, not
about moving blame from a developer to the agent itself.

-- Steve

