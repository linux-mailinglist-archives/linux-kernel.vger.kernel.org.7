Return-Path: <linux-kernel+bounces-767737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0891B25867
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB09C7AFCF7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 00:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E098472623;
	Thu, 14 Aug 2025 00:36:05 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F061224F6;
	Thu, 14 Aug 2025 00:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755131765; cv=none; b=VrRBO1HNNFY05sq2HWxesY37IGDd57lVv/K85KLGOJLBeKZOdOeww3VVveAV+WGaBVvFUul2jtRXnlQC3y3+tDf2QHWbMz5GseViVfuDrRXuDoK8OIH1sA0ezg0tLopXkBkugD9VuRiats9RklL1pORHxYV1VCTNo5/d25LU/Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755131765; c=relaxed/simple;
	bh=mpkDnPLbOUx50KpkuUD5mJ/La7GKqG6KmylgOxgVZE4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SVU17cTFp0z+kw+OW0KKOZoVXusrgz1kfIGAn33PqwusLzm74y6YJBUDc6d/mpQSHPD5MqYbZlCSr+ZEfip+zafyxe3nXbEWA0Nd/afHYYJhxrxIA6X9Xm0WvZSZcF1HAvNOu1AcKWItFpPqo/3n8F3qy+H9udp0gb1/G9SKLf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 5E0141177BA;
	Thu, 14 Aug 2025 00:36:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 479A135;
	Thu, 14 Aug 2025 00:35:59 +0000 (UTC)
Date: Wed, 13 Aug 2025 20:36:47 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, corbet@lwn.net,
 josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 workflows@vger.kernel.org
Subject: Re: [PATCH v2 2/2] agents: add unified agent coding assistant
 configuration
Message-ID: <20250813203647.06e49600@gandalf.local.home>
In-Reply-To: <aJirFxwuzxyau1j-@lappy>
References: <20250809234008.1540324-1-sashal@kernel.org>
	<20250809234008.1540324-3-sashal@kernel.org>
	<2025081040-armchair-although-8bf1@gregkh>
	<aJirFxwuzxyau1j-@lappy>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hdr5whjza6thcyjsgny54ydu1w36ugf8
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 479A135
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19O7s64iK5UKDHNNHvGwMHIV2MRzI8zzrs=
X-HE-Tag: 1755131759-651178
X-HE-Meta: U2FsdGVkX18uF7lPn7YRrBQ4FFO7EKwM6F1D5s1BdqTYEZ3qKBnrFUiqEBYUzvbgjR49RePaX0KjrYaXztaJDFpslRykYQikElvg4RYHMcAVTb48TBqioqktFP9UpU/fhyfIk3D1ldfovRLv/GdpYG0uzIfSNV2Tna7ikyx87S8SSivGUVNq/NwvgqJAUee9vcZ/aOaHz9g0eUuQMYBr3uV6StyygwSwmO3N28Lpzb3TvwgL3R0TxjeRCFC15ck3LlSV06s3+/RXA5PaAE6d0xyA0loZSsp5RLmspFOFjRsqdAU73wlW4T3Mg/xT4cZgHBwgHFxRqTri2H1U4GEfbNX0aokimIzG

On Sun, 10 Aug 2025 10:22:15 -0400
Sasha Levin <sashal@kernel.org> wrote:

> We don't strictly need this patch. Here are the options I came up with:
> 
> 1. Multiple agent files: agents automatically read our rules, higher
> chance of comlpiance, doesn't require user to do anything manually.
> 
> 2. No agents files at all: this means that the user will need to
> explicitly trigger an action, otherwise all the tools I've tested it
> with will happily ignore the README file even when prompted to do other
> actions on the codebase (analyze code/write a patch/etc).
> 
> 3. Only "AGENTS.md" which seems like a few of the tools are trying to
> standardize on. We could also use it in the future to add prompt cues
> that might not be relevant within the README.

2 or 3 are the only options that seems reasonable. I agree with Greg. I
wouldn't want these files adding noise to the main directory for every
agent.

> 
> We could also start with most of these files, along with a statement
> that they will be removed within 12 months to give the various tools
> time to standardize around something.

Ideally, in 12 months they will all standardize on AGENTS.md and that's all
we will need. Let's not enable them to do their own thing in the mean time.
If we add this file, I would suspect it would help encourage the agents to
use it.

The best "standards" are the ones that are done in collaboration before
they are added to a specification ;-)

-- Steve

