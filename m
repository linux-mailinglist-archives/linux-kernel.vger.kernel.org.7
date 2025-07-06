Return-Path: <linux-kernel+bounces-714525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D344AF68F8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 06:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF4D3A1D6C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jul 2025 04:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28405289E03;
	Thu,  3 Jul 2025 04:01:22 +0000 (UTC)
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F42E28935C;
	Thu,  3 Jul 2025 04:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751515281; cv=none; b=r9uGbmkhDRiGD9hC+QmWP+I0kzWe1+0UQ8iPVygXdCMwKKHV8h+2SMdxprbBfghywpmhL2uZKw9GY4fvtnoSnjFrrj0cadPQ7dDRK6OuIXZymZayxDWaVEzSaEZ0+OVc3SwFqTZBKpIF45PFKQYjuugHu/uhbypyxmL1x0aizoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751515281; c=relaxed/simple;
	bh=JpoUSlhJB82auXvu10Mi5QN6NRGkCsUApGJnLQme5SY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YNbSR7p/YN3dbQXbl4dWEsBDjQSW2HC+afAu/odlVy/4L8/aS9VNjC/T1XqR4cfG/IzeXaayXDqbLj5WmeM7JdGNm6nworqwRVVyapcUrRoXKfYy3Ptffaej3u1wEsZnEI990RQRPRJGsX/BP6ULh4kHVWw1xL/i5u+UGv/O+TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from mop.sam.mop (unknown [82.8.138.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sam)
	by smtp.gentoo.org (Postfix) with ESMTPSA id 4559E342138;
	Thu, 03 Jul 2025 04:01:15 +0000 (UTC)
From: Sam James <sam@gentoo.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,  fweimer@redhat.com,
  akpm@linux-foundation.org,  andrii@kernel.org,  axboe@kernel.dk,
  beaub@linux.microsoft.com,  bpf@vger.kernel.org,  indu.bhagat@oracle.com,
  jemarch@gnu.org,  jolsa@kernel.org,  jpoimboe@kernel.org,
  jremus@linux.ibm.com,  linux-kernel@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org,  mathieu.desnoyers@efficios.com,
  mhiramat@kernel.org,  mingo@kernel.org,  peterz@infradead.org,
  tglx@linutronix.de,  torvalds@linux-foundation.org,  x86@kernel.org
Subject: Re: [PATCH v11 00/14] unwind_user: x86: Deferred unwinding
 infrastructure
In-Reply-To: <aGVo9b1xiT1Moq-P@google.com>
Organization: Gentoo
References: <878ql9mlzn.fsf@oldenburg.str.redhat.com>
	<87wm8qlsuk.fsf@gentoo.org>
	<20250702121502.6e9d6102@batman.local.home>
	<aGVo9b1xiT1Moq-P@google.com>
User-Agent: mu4e 1.12.11; emacs 31.0.50
Date: Thu, 03 Jul 2025 05:01:12 +0100
Message-ID: <87plehkjnb.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Namhyung Kim <namhyung@kernel.org> writes:

> On Wed, Jul 02, 2025 at 12:15:02PM -0400, Steven Rostedt wrote:
>> On Wed, 02 Jul 2025 12:44:51 +0100
>> Sam James <sam@gentoo.org> wrote:
>> 
>> > In one of the commit messages in the perf series, Steven also gave
>> > `perf record -g -vv true` which was convenient for making sure it's
>> > correctly discovered deferred unwinding support.
>> 
>> Although I posted the patch, the command "perf record -g -vv true" was
>> Namhyung's idea. Just wanted to give credit where credit was due.
>
> Yep, it's to check if perf tool ask the deferred callchain to the
> kernel.  To check if the kernel returns the callchain properly is:
>
>   $ perf report -D | grep -A5 CALLCHAIN_DEFERRED

Thanks both. I'll update my notes and tinker more.

>
> Thanks,
> Namhyung

sam

