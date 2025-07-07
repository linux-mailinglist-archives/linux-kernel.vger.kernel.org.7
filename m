Return-Path: <linux-kernel+bounces-720606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E99CAFBE34
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F935426DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC1255F53;
	Mon,  7 Jul 2025 22:21:03 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80DB1CAA6C
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 22:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751926863; cv=none; b=oF7bQ6UcY+B8tDjm1bUT8A03MOJ3BISFt2F5HNOr5uou9rOCqJmXId39EPmpwAf3OzoGRYYlOhczdFKNQVHBK74Klm0hF+iGsYz80eUakFEjMoJAMefYPEAaZIGY2RUA27ZUtx0Ss1huG3kAvVuSfrlfAbImLCmPa7xAp0Bk5Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751926863; c=relaxed/simple;
	bh=CcboY1+6mtwC8WBNfMlr72B5bIDKTsLtE6Vo+2DmoRY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjPIsJceRPHYIiQ1etW89395a89VHNnk40lSicxzTVyOdSLNsvYCMxuNa15kyGTi814p+NVR1P7uGfly9NrUVAXBP0ZNsWQliEOOdzBx/G0gyEq54i7G7F+rCfco+d2tPvEdo2hcev2H8EcD153kg6Df3GwQMBM+Bi+cXzJDQNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 3852410A560;
	Mon,  7 Jul 2025 22:20:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id BA8D16000C;
	Mon,  7 Jul 2025 22:20:56 +0000 (UTC)
Date: Mon, 7 Jul 2025 18:20:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: "Li,Rongqing" <lirongqing@baidu.com>, Peter Zijlstra
 <peterz@infradead.org>, David Laight <david.laight.linux@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "vschneid@redhat.com" <vschneid@redhat.com>, "mgorman@suse.de"
 <mgorman@suse.de>, "bsegall@google.com" <bsegall@google.com>,
 "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
 "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
 "juri.lelli@redhat.com" <juri.lelli@redhat.com>, "mingo@redhat.com"
 <mingo@redhat.com>
Subject: Re: divide error in x86 and cputime
Message-ID: <20250707182056.66a8468a@gandalf.local.home>
In-Reply-To: <20250707220937.GA15787@redhat.com>
References: <78a0d7bb20504c0884d474868eccd858@baidu.com>
	<20250707220937.GA15787@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BA8D16000C
X-Stat-Signature: f5yj86bb3m8jsy5a7jnnq7yd3bpa1u71
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Ym2XnxuOiq2yKn19JaJeAgC0C9zt9v4Y=
X-HE-Tag: 1751926856-559964
X-HE-Meta: U2FsdGVkX1/zgzb1/NjeL2bFo6SF37NuDb+yPPs1e+UPI1vUc1NQph4CEDku2m4LPehhuoSM0KdUn76kwxA6LCSTvTddvVOZXvd9LEoTbd1gcOaNHALwGp4BtoAZBq3BMM9YJMOJ0yUN5rTiIBmBXlncfcgTeNVNrV4McaZh4efiENYowCO5r++2ve3LMTZ5PPQz5Djm5OjpGJIvXGk4k9TERXQDWAeT6HcTRqb/VVy5iWIOMkAnT9jwfbMVI2SmDk8KvoXW7xMAVQ0rtt++k1vVgRNW3akbA4720ucyABOYguh8coDaGyF3soMj74ZKBMnO0HMTtxarH6Tk3lXEH15ruC3qz61Y

On Tue, 8 Jul 2025 00:09:38 +0200
Oleg Nesterov <oleg@redhat.com> wrote:

> Well, the current version doesn't have an __ex_table[] entry for div...
> 
> I do not know what can/should we do in this case... Perhaps
> 
> 	static inline u64 mul_u64_u64_div_u64(u64 a, u64 mul, u64 div)
> 	{
> 		int ok = 0;
> 		u64 q;
> 
> 		asm ("mulq %3; 1: divq %4; movl $1,%1; 2:\n"
> 			_ASM_EXTABLE(1b, 2b)
> 			: "=a" (q), "+r" (ok)
> 			: "a" (a), "rm" (mul), "rm" (div)
> 			: "rdx");
> 
> 		return ok ? q : -1ul;
> 	}
> 
> ?
> 
> Should return ULLONG_MAX on #DE.

I would say this should never happen and if it does, let the kernel crash.

-- Steve

