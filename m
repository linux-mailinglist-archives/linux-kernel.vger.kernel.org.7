Return-Path: <linux-kernel+bounces-848994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 807ECBCEF96
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 05:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CEBB3E6F3B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 03:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FA01DE3B5;
	Sat, 11 Oct 2025 03:54:08 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1A31386C9
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 03:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760154848; cv=none; b=NK4ESkIcktCuOrG55vM0TL8KR5BtQMNAYBwSXP7uE9tzJYP1gCtOFKFfTZxPDAAlu2Hm9ICAG8Vod6Q3KKx/qbqogRp/ZPbFYO3VvJm97+PgfFWwAF6cRyyOp24wCGDuo6mXV6pguHOFduwlz1I7DZdxGUhccjZbuu3cKO+R1TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760154848; c=relaxed/simple;
	bh=DWBbNrByHoEeD8hlTYkQStVAG6ngzy701X8pMhMqSNA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GiuExkviPbdwYszExuPCRjGXPnaT7kN3CT7Ymy6Jj2eg3aElZTpcXDEGJXZ8x4AhUVaolutWdvzK4U+rqY7IgjsRBwnh6XDPN2+Znpc1VBPy+1d6tj97jHi5vb/nUmaxKAnZRBPw+SxQOFkx5mjkJVp7Gnu6sIO1T6tCju3pJbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id C383713B223;
	Sat, 11 Oct 2025 03:54:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 1860220030;
	Sat, 11 Oct 2025 03:54:02 +0000 (UTC)
Date: Fri, 10 Oct 2025 23:54:00 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-linus][PATCH 0/2] tracing: A couple of fixes for v6.18
Message-ID: <20251010235400.6af7294d@batman.local.home>
In-Reply-To: <20251011034633.619611825@kernel.org>
References: <20251011034633.619611825@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: z97pb9jbqntfgggkt6rbz55yqonfqub8
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 1860220030
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/hs0tTfeHmx1VCKdI6MWvJH6bDRE4ML40=
X-HE-Tag: 1760154842-334835
X-HE-Meta: U2FsdGVkX18Fuft2cYW4krBTBV/0azcr8ImryyAl9/MFpezG4+cLEARnHkpKBEtQ/FGO+TUCkAdB/GN+dMiizMUs31mWfJrwAuKibcwrkh330BJP4vgnKx4mvZFXthQIvpdbDwW4h6ZCF9ELK0lWfohO/kNQi5JzmAPx6+L+UVX9k/I4WvIESNBwFjxSAIHgUBxuxUJIEAnAxcRM0C/0fk+kbAgb3EqV9+0TdeoZ7XuCMRSgxrXy9X86fDWq+nMjIsTN1rn9GzkPI7VAwrAFCS9R8Y1GKELkoc8pCsDuFvWPqRaxWpsb0sw16Spp5r+t

Oops, the "for-linus" is supposed to go out after it has been fully tested.

These haven't been fully tested yet. I have to send out the normal
patches to get it into patchwork and then kick off the full tests.

-- Steve

