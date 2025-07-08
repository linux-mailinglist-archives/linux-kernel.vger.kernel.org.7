Return-Path: <linux-kernel+bounces-720792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C98AFC06C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 04:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ACBC3A7586
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 02:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369DC20B7F4;
	Tue,  8 Jul 2025 02:05:37 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E7DAD24
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 02:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751940336; cv=none; b=SA7ToDrI/YIKnUNGhJHjJxNfTVVLUDt8ktVcBsgkytCJW7Ve2SOFoSrUTeoQYdwsdYHdw3G8FRn35u8u8BSeeWtZf0S6QH0lFJGmX8VI1a+LdI7Vwcvsr6tCJlYELzL63nimsBro3xKuqS1wSYc80N8WAi69+Jy38eQVvjTN4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751940336; c=relaxed/simple;
	bh=Ukf1beu7Z3UgIce3RxpuEdhnGAGC4GPRQ4/as7Tr5n8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOTTcSwfe+dI9AOOTUeaHRjQjrzRHJPVnabtSHMn5tkE+jXJ8lx9zcvC1s7WD6e7limmBlMr7T3S+7SQn/nBSB1bn0mQnSZJmSneKCg5RLP9FIsl5slIyro6i7wi6TlEvmwmCuZoHYHhIJsjKWbg0kQHz9xz3fsermobaqWKxgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id E15F2140432;
	Tue,  8 Jul 2025 02:05:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 1C7896000E;
	Tue,  8 Jul 2025 02:05:30 +0000 (UTC)
Date: Mon, 7 Jul 2025 22:05:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 David Laight <david.laight.linux@gmail.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "vschneid@redhat.com"
 <vschneid@redhat.com>, "mgorman@suse.de" <mgorman@suse.de>,
 "bsegall@google.com" <bsegall@google.com>, "dietmar.eggemann@arm.com"
 <dietmar.eggemann@arm.com>, "vincent.guittot@linaro.org"
 <vincent.guittot@linaro.org>, "juri.lelli@redhat.com"
 <juri.lelli@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [????] Re: [????] Re: divide error in x86 and cputime
Message-ID: <20250707220529.19eb2a74@gandalf.local.home>
In-Reply-To: <8f68278c4a454fd79b39cf21d4c0974f@baidu.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
	<20250707220937.GA15787@redhat.com>
	<20250707182056.66a8468a@gandalf.local.home>
	<20250707183331.029570bf@gandalf.local.home>
	<42f5344b80e244278aaf49f112498e02@baidu.com>
	<20250707215322.0e4ec431@gandalf.local.home>
	<8f68278c4a454fd79b39cf21d4c0974f@baidu.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: s5by4ubu7duxsdjpudwz18qfq1m5syxi
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 1C7896000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/7fN3hVUYdnIa3GgXFj31T9pP/1uCYdaQ=
X-HE-Tag: 1751940330-595184
X-HE-Meta: U2FsdGVkX18BPjX5oYCZjuhPZiAZYUoSEBP5S89BGjs8qpH4s2P97XTYXWCUPThWZqtYwav53thOeZPA6seUqcb8ByEpbhsHVbJCcDqRqPCEDjCdWsRYOpBtA5s8i2Pk1Hil52lHKjZMeui75HMBUBzGfSwuvn66IlJavWt8pRaA2JC75BL0mj3c9A/qbqB/lKlqqpiCaThA5+pugELaVBngJz4WAnfjTqF5EA37kPeNKJTWT4B/PuRCM3F6i8wwb15+cfM1iq1xLYIIOObs26bSYlKH5Sh+27Q/5wgsnCduKyTDoaVzuvrErfDNVXyUPaLvOtkl59YanEfLy05MAaeBZl7lEN4d9Od8+zl58SKbn3qBOS+VFg==

On Tue, 8 Jul 2025 01:58:00 +0000
"Li,Rongqing" <lirongqing@baidu.com> wrote:

> But mul_u64_u64_div_u64() for x86 should not trigger a division error panic, maybe should return a ULLONG_MAX on #DE (like non-x86 mul_u64_u64_div_u64(),)

Perhaps. But it is still producing garbage.

-- Steve

