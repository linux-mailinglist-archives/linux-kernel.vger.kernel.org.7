Return-Path: <linux-kernel+bounces-865330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F7BFCCED
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72E0C19C3053
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 15:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C779A34CFAE;
	Wed, 22 Oct 2025 15:16:40 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF81334844D
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761146199; cv=none; b=AjqRTRJi0UscPbrRphPdtX+nKHOjXHsKu7m2LjyHILSbtPZBxqg3ONcrZa6Y3BTQyBbQioHsU4wqadaqxXm0gL6V17cS+1rfWc1QtLmZddAywmhFzqbHrFwp/JhxO5BT4yQt7lYybahlsnG8UGH3uy3aWFTDW6hY844YkfHayvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761146199; c=relaxed/simple;
	bh=gNxwSEEYTn8QIrAGaT5TYqJatWbJ5xumhCwyNULplLY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAFLaSbPFWjp0p4Tzw60DmN6CQ9S15x2xRQp81jQWuDic6psLJkVo6HPOc0GJzhVA3qUKMeFqyMorBaOULKXFzLUwqM+34qBGSqKkLWm7tyIzHHp/75e8QfbFE65KmMq5ZF2nKWyse8aYtIQCiVN7tfPjTxwq6pDZVC6HHg8lxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id DC2325BA54;
	Wed, 22 Oct 2025 15:16:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 3D69B20028;
	Wed, 22 Oct 2025 15:16:29 +0000 (UTC)
Date: Wed, 22 Oct 2025 11:16:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: jpoimboe@kernel.org, rostedt@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/12] unwind: Add comment to
 unwind_deferred_task_exit()
Message-ID: <20251022111653.2b04308d@gandalf.local.home>
In-Reply-To: <20251020101602.GK3419281@noisy.programming.kicks-ass.net>
References: <20250924075948.579302904@infradead.org>
	<20250924080118.893367437@infradead.org>
	<20251001113505.25281444@gandalf.local.home>
	<20251020101602.GK3419281@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3D69B20028
X-Stat-Signature: 69jd1ty8tayawsy3bsssu3k1k6izd3hw
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/YinUgDX8Fd5ho/V/E8oQR06/xy2VvnGc=
X-HE-Tag: 1761146189-949672
X-HE-Meta: U2FsdGVkX1+qmMZtjFMZ6IHrJh3qaWg+4xz1ef+SdI4ugRsvWaVR/sc7lIgSkfgCDtBTSrm4/0VRGDEVu7lWoIXk2brOusghx6qrKBniWqVc6Det5fdETK3ZvTMdw/UmaQcR7ZdqgPQLgC8i6GuWhmGxhLfcX0RC9K60GZCLptQSqIpaxEb5dYh+85i5sCEvSRsNZjXNd2kIU5IvbVCefCNzu0KapYu3fZ3wRff2DFsXm/+19O1tPtWGFhR7adqk9bZMvs+FQXS+mEfTXlZ7q+FN7qHgEQT2kN21VyDAMYH14tJoka6pK4XpeM+uLinJ/8xolTxb3viDNRIOre1LWAudXkTu4wPqSNSd7r2hjXjYq/B1m3sNMh689veHDUnamr7T5/Xi/TU8ZeUbtBHXoIYqPR/w2vRbqfCWK1i/CEVz3JCz6uNyXoqMpnzB9ysp

On Mon, 20 Oct 2025 12:16:02 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> > I would state that it also flushes any unwind that is currently pending, as
> > exit_mm() will prevent it from happening.  
> 
> It now reads:
> 
> +       /*
> +        * PF_EXITING (above) ensures unwind_deferred_request() will no
> +        * longer add new unwinds. While exit_mm() (below) will destroy the
> +        * abaility to do unwinds. So flush any pending unwinds here.
> +        */
> +       unwind_deferred_task_exit(tsk);

Thanks,

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

