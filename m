Return-Path: <linux-kernel+bounces-746150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E80B123AE
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 20:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42E791CC659C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 18:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B6E242D83;
	Fri, 25 Jul 2025 18:19:59 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDE38F6E;
	Fri, 25 Jul 2025 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753467599; cv=none; b=CU00oIQ5JRxsIiduDHWQUAAUvdQCkWYphDDaV09DMB0/jUQjwj1AjDN2J+VBpxW4Gqp+7ZEmb77peYszkd74FivBJgZQHnaPICiGLjyARFbrIcTbG+UcpwfOm5oBBVTbqRjN4rPcxgXdKdyP/t2ZWPVHE+Kes8ch4iOiOXGw5bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753467599; c=relaxed/simple;
	bh=Lkr5RTIzok4UKozDWW6amtfOKTZ/IHbCnLsre9ig0+4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N26rQUrwc8R6xcg9PxrXMG7Zdr8joedrNl3jwopzZfsbR9H6qzOCVNdy/qBCFbErcfDiKpzCYft/yk9EPkE8QgriON943mBUA4LyxMBATE+em7USU0e9b7H3tnZUxzKqVjKcyzz+ncg2lskIi2JLmy9lKslzAvZpFxazzk3gJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 2ACAC1DC01C;
	Fri, 25 Jul 2025 18:19:55 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 278922002A;
	Fri, 25 Jul 2025 18:19:53 +0000 (UTC)
Date: Fri, 25 Jul 2025 14:19:58 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sasha Levin <sashal@kernel.org>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kees@kernel.org,
 konstantin@linuxfoundation.org, corbet@lwn.net, josh@joshtriplett.org
Subject: Re: [RFC 1/2] AI: Add unified AI coding assistant configuration
Message-ID: <20250725141958.10b11edb@gandalf.local.home>
In-Reply-To: <20250725175358.1989323-2-sashal@kernel.org>
References: <20250725175358.1989323-1-sashal@kernel.org>
	<20250725175358.1989323-2-sashal@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 278922002A
X-Stat-Signature: ycxqjpdgh5xxwis9a8ka5pep44j9ck7o
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX187cjOTB4FNA6vpsvABO30LUZf0Z4znARk=
X-HE-Tag: 1753467593-964805
X-HE-Meta: U2FsdGVkX1/HtcTL3BcYOlPNMW3TzBpCDWf5urcjL2hrzVHCmyNsczmymB+cP8M7vk3a6TAH6vALq0OOM30cqiW0l4yMPc9HZjikAHHyUrETlF5WyHhbG9qZJmdclMkMxnwU4ucVegewDrYFT7JK4onw/DRhAY7ukOemvyKxM5WAenpfnOwqn3psxZJwwh5l345aWpy7LgqcdFfsmBmFN5RRqSGHOUkCHFziA7s9p1QouczSM1FztZTUyXelBoO4Ii0HO67kwbO2bOHmN4liv3mEsSxP9ywnsp4M/jRTi+Fvh2lh8EzTFyKKWHb+wtFQSm7rZvZn7/KShik/z/ssqXXDq4egzaXx

On Fri, 25 Jul 2025 13:53:57 -0400
Sasha Levin <sashal@kernel.org> wrote:

> Create a single source of truth for AI instructions in
> Documentation/AI/main.md with symlinks for all major AI coding
> assistants:
> - CLAUDE.md (Claude Code)
> - .github/copilot-instructions.md (GitHub Copilot)
> - .cursorrules (Cursor)
> - .codeium/instructions.md (Codeium)
> - .continue/context.md (Continue)
> - .windsurfrules (Windsurf)
> - Documentation/AIder.conf.yml (Aider)

So these AI tools know to read these?

-- Steve


> 
> Signed-off-by: Sasha Levin <sashal@kernel.org>

