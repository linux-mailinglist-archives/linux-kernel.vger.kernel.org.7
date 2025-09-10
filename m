Return-Path: <linux-kernel+bounces-809611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A259DB50FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 09:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6E0B1C82096
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 07:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F0930C37E;
	Wed, 10 Sep 2025 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aoe6EdWM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jCR4cp+J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF20630BB81;
	Wed, 10 Sep 2025 07:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757490224; cv=none; b=kcJskM2xzk6hHFH9LEUcUacsb/hW4Wa7Uu8+RtDAcIN2EeJUV7vrsJrRTR2pg8nW0bSApuulKTR7luDsiG3cknKJwrLTPc3CWymyK8byIQ8R+PKEPDmkgbgguifAebaHXO8UkpuwXY3US3Yx8tOv0Oi/VKSP3ZFgnPadC+YRSi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757490224; c=relaxed/simple;
	bh=ysPC8gIDUEZev6CRLE3O8KdZ2ZIncnjG7LDJ3jrnh4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q5XBgQW0yqY+x6qwMwKbOF0qkaVRQjfQsbuS7MlxBNQ0OPBp0k/gj5bkx+QsDyQPScr3wZ4rVvRcVvBdxBJUvqnCOb3Wyn4JzE1fo0uiwJIxENp10f20P55FLaeS7lMGR++PDN7952Lieok73bhjZ7td6OfaUA3XDQSy7kU1AY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aoe6EdWM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jCR4cp+J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757490220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=igumClIvpx2cwaJ/4/9En28rMWl016wmiHMG4dR/RVo=;
	b=aoe6EdWMLibP2L1yiuXeMLVrnBCJVyutM8lCtMs3SQWbCxosgfZlcp4arOHxrebf293tTb
	MuX7p048WTbTQbbZfaga55UG0sEdsBLjpzeEcMcXDQXRxs7Pw0BVpodL3AK0iUY/AkVn1K
	qrF+orNpgYaYo+0+D+EWMiTe/senYaaNaz+jHkHHTAMuTYXlp1/P1rWJSJd8Ixqln8DXWv
	+1SXRw48B2Kf7XtH4W6E1HCIDinV23GFO4rd02QnrLKQSzBBpc/nGXwhKGHdvREUNtOtPc
	ECzg81IgTWJ9taV/Fm98cVyDpfJyNmpIgZ49YmDV+ETkGS71oe3RPpLrTEIM0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757490220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=igumClIvpx2cwaJ/4/9En28rMWl016wmiHMG4dR/RVo=;
	b=jCR4cp+Jbka9j+05Dv4UjCgxgIeLhdG/g9qrPMDiZe9IJkTucQItFi5A9LrrWEfSRUmbIT
	FXjiL0VhzoZr2WDA==
To: Gabriele Monaco <gmonaco@redhat.com>, schuster.simon@siemens-energy.com,
 Steven Rostedt <rostedt@goodmis.org>, Christian Brauner
 <brauner@kernel.org>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Hildenbrand <david@redhat.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel
 test robot <lkp@intel.com>
Subject: Re: [PATCH] rv/ltl_monitor: adapt handle_task_newtask to u64
 clone_flags
In-Reply-To: <93a46874ceadf0080891e06d930336e120f2d753.camel@redhat.com>
References: <20250904-trace-task-newtask-fix-callbacks-v1-1-8edb3d557365@siemens-energy.com>
 <93a46874ceadf0080891e06d930336e120f2d753.camel@redhat.com>
Date: Wed, 10 Sep 2025 09:43:39 +0200
Message-ID: <87jz26ah1w.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> On Thu, 2025-09-04 at 13:36 +0200, Simon Schuster via B4 Relay wrote:
>> From: Simon Schuster <schuster.simon@siemens-energy.com>
>> 
>> Since commit edd3cb05c00a ("copy_process: pass clone_flags as u64
>> across
>> calltree") the task_newtask trace event exposes clone_flags as u64 to
>> its callbacks.
>> 
>> However, ltl_monitor was not adapted, resulting in a faulty callback.
>> This also resulted in an lkp build warning due to
>> -Wincompatible-pointer-types.
>> 
>
> Looks good to me, thanks!
>
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
>
> Adding Nam (author of LTL) to the loop.

Acked-by: Nam Cao <namcao@linutronix.de>

I see no problem merging this to vfs, if vfs folks want that.

Nam

