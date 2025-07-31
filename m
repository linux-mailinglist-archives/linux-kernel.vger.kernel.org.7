Return-Path: <linux-kernel+bounces-752566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D61C6B17746
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:40:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56723A8392
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA97C256C70;
	Thu, 31 Jul 2025 20:40:27 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D042512C3
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753994427; cv=none; b=FL2XhJySH0r/O7xJkhAmQUYODeS9fX1bg1Ye8zmjLxriHotRLkLESbTVrhT96OGWMI9aeDkUbSZkEnyKPzH+ZAyBfx1TeSkZJit1IayelMBifWag9DMlb5sXNT2CfzBP0RkErbjk8wSr5YX58k2incHvtnUS7QFfx0u5fDL6Dro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753994427; c=relaxed/simple;
	bh=waiosXnmrDn1hIqAXRcn2voidmEqfcmgNqSi0SYXm4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOgEryvYu5D1wucHc5Ut8y8UOcASLTpP6fDfoTb7iV7FA8lIGFxf15g5ftE3oTx5VNZ/rMpISUVYciYcwFSpr4Sm6heLTRjvwRl1ByM1m9S3NG/+VYwLNJ9O8x91HNnQ+9oRku8Hau5MWC5oFpYJhTqLDVW4uqsUI06unZYunFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id B7D67114BB8;
	Thu, 31 Jul 2025 20:40:17 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 8579B20026;
	Thu, 31 Jul 2025 20:40:15 +0000 (UTC)
Date: Thu, 31 Jul 2025 16:40:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Mark Rutland <mark.rutland@arm.com>, Arnd
 Bergmann <arnd@arndb.de>, Nam Cao <namcao@linutronix.de>, Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, Yury Norov <yury.norov@gmail.com>
Subject: Re: [GIT PULL] tracing: Updates for v6.17
Message-ID: <20250731164034.48cf2c91@gandalf.local.home>
In-Reply-To: <20250731163831.3149a14a@gandalf.local.home>
References: <20250731101717.6c340b66@gandalf.local.home>
	<6z7h63sg3ljhy2k2ymnysm7hhcmtb76follkdy2y2iu54npxqj@wppxbg2qok2p>
	<20250731163831.3149a14a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: atmxhe4ss4kjidjy6mtrxgks6hqbaytd
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 8579B20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/6xnlIfrHYdwR3pgWZmuM69ARwpnwk9eA=
X-HE-Tag: 1753994415-275743
X-HE-Meta: U2FsdGVkX18g71Wmk4u/Kg4rqbu3p5UA6P2MIqliAdIVabJDPCFoOaRtTyVb20W6JbJlLewst71c9c08++39cYsAakEfX4coWbEmw8ibRRaMREGhMtXcukhGCZxN4FX6JCPixtG8DCPTGA6J+9ErcgaelE2SiNbWy39lgDNAPDnZYk4wLfzvhVpavVGPEoVfITachGhtrAfmb6B5lngq9YZyGNCRQfbtFOfjAQVTYDjVIKj2fyMT14b1CXDnjaczjLd8dvhIF5lWMRUX66+80EzVD8DZbmw2Kk3Lz7zMCYLJGj4ahM+D6n5yWuKBxT++SHffkwq6A/QXHl401GCBnoFEXX7Vsd5tfze50PENBTM67iqnCPOKuOU13cxc1ypo/NDn7vugAop5Y05IYLbycg==

On Thu, 31 Jul 2025 16:38:31 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> tracefs has been in the kernel for over 5 years and there's still kernel

I meant to say 10 years, but the "5" from removing it completely was still
in my head :-p

-- Steve

