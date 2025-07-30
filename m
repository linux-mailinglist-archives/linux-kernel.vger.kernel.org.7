Return-Path: <linux-kernel+bounces-750963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40600B16364
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F46117B088
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1272DCBF3;
	Wed, 30 Jul 2025 15:10:35 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E622DAFB7;
	Wed, 30 Jul 2025 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753888235; cv=none; b=ins36xJIrvrUAsYCwVh/xbBD8CjQVltvlk76UHlTxDr2aS928SmVlrtTRHh0RBppUGM+FZo7fcrI93X1H90/BEptGL/TPQVtEOG/uZoGUhm0i0vl1u1EwfhfSUO2BaSL/XJQB69konchsDXy8tcaTXTCQ3arC1LHInaSL3XFYjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753888235; c=relaxed/simple;
	bh=s1pwW/NE6FB9t8dFQS7zeKFVDD63iSvre2LkrFI6xuU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VwnrYM6wAhJbq8roqrsc1hYHZMOQtl7BUTcjuR2KIcTQv9qCk+sCgIvQ6IrPflGM0nutt7cA7Se9q+p2KvIxf89xbfGDYPA5yal5zgCxoNt+t/XbtC2rdziHmf0rtodGYmNItr3A+9zfF8Y+MDYmriHYcGKvS1pht3G2WVaUGKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id C27731A022B;
	Wed, 30 Jul 2025 15:10:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 94B402000D;
	Wed, 30 Jul 2025 15:10:28 +0000 (UTC)
Date: Wed, 30 Jul 2025 11:10:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, Kees Cook <kees@kernel.org>,
 corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
 josh@joshtriplett.org, konstantin@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] agents: add coding style documentation and rules
Message-ID: <20250730111044.37146f6f@gandalf.local.home>
In-Reply-To: <6a2312d3-286e-49f2-aedf-b0e41b48ba14@kernel.org>
References: <20250727195802.2222764-1-sashal@kernel.org>
	<20250727195802.2222764-4-sashal@kernel.org>
	<202507271939.D78EC559@keescook>
	<aIcGQR8tjmjr8dlb@lappy>
	<202507272219.4BF02B6@keescook>
	<aIcSu3LidOqoaVOS@lappy>
	<6a2312d3-286e-49f2-aedf-b0e41b48ba14@kernel.org>
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
X-Rspamd-Queue-Id: 94B402000D
X-Stat-Signature: sr7fx6ummzfugmthypyxfqdu5asmr4pc
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//4UTFqJ7IHA0JCr3zA2Su/E4T4K7X4Qg=
X-HE-Tag: 1753888228-196057
X-HE-Meta: U2FsdGVkX18tZY5oPrS1SGFFWkOTFOmVHvio+IQTeOqO3pejj7P1NPmTz4pSoTlt97afCXIH33OX+I+HynxM11k04S1oRciJ9iE0Ryr7rKQXDPE7kuIPvel2uBzlU1RQ9JXDx8v9cLR8GaDwd2PmEhlaaCwNu9iJkNyk5JOmWoRSJH9cs8IlYq8WsERn2mTXli0hK1c9PxATfZUKtz9yXz6NymJ7HT78uS61h/DWzslxMjCQw1EHJ8eIJT011WuEk9hb4vU80ubpCRigPZlWDEJ/afrpXwG9BaxQpt4gbeWsBWx2+TeiVI/1MrUqArdwXS0K2j6ZfMVUKR2mwldkqbZHoov3Hlhw

On Wed, 30 Jul 2025 11:31:35 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> I pop up there a lot, but there is no confusion. I am (and maybe we are
> all?) well aware that checkpatch hard limit is 100 as explained also here:
> https://lore.kernel.org/all/df2e466a-cdaa-4263-ae16-7bf56c0edf21@kernel.org/
> 
> But the coding style still says that preferred length limit is 80.
> Checkpatch is not a coding style. Coding style document is describing
> the coding style...
> 
> People trust checkpatch way too much, thus its hard limit was raised.
> Some maintainers also agree with that, yet it does not invalidate what
> coding style document says.

Yeah, I had a couple of patches that were sent to me with everything at 100
max (comments and all). As I still have my windows set to 80 columns by
default, I find it annoying. I told them to fix it and resubmit.

But a break here and there where it makes it look a little better doesn't
bother me. For instance, the code in kernel/trace/trace.c has:

        if (tif_need_resched())
                trace_flags |= TRACE_FLAG_NEED_RESCHED;
        if (test_preempt_need_resched())
                trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
        if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && tif_test_bit(TIF_NEED_RESCHED_LAZY))
                trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
        return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
                (min_t(unsigned int, migration_disable_value(), 0xf)) << 4;

Where

        if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) && tif_test_bit(TIF_NEED_RESCHED_LAZY))

Breaks the 80 char limit, but honestly, I rather have that than:

        if (tif_need_resched())
                trace_flags |= TRACE_FLAG_NEED_RESCHED;
        if (test_preempt_need_resched())
                trace_flags |= TRACE_FLAG_PREEMPT_RESCHED;
        if (IS_ENABLED(CONFIG_ARCH_HAS_PREEMPT_LAZY) &&
	    tif_test_bit(TIF_NEED_RESCHED_LAZY))
                trace_flags |= TRACE_FLAG_NEED_RESCHED_LAZY;
        return (trace_flags << 16) | (min_t(unsigned int, pc & 0xff, 0xf)) |
                (min_t(unsigned int, migration_disable_value(), 0xf)) << 4;

As that breaks the flow.

Thus, to me it's a guideline. Try to stay under 80 but we don't need to be
draconian about it.

-- Steve

