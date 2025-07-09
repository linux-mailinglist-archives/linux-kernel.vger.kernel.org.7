Return-Path: <linux-kernel+bounces-723935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3DBAFEC93
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A747170BD2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718F41D63E4;
	Wed,  9 Jul 2025 14:51:15 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766C679CD
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752072675; cv=none; b=PEAoIscmvMfP3aIRfESLj8o8rlcQ6JdGC/5agU3jVnxV22XGgmXpWQ5E5SxpanajCtu4SNtlDTwcjJcmuR7LnNuV1CrKYJDuMpc6uIaefBrtv7hV7lR9kDX1eEONVlJELfwhaOLM7DWSm9yg1r00sybrES2i8kleouDnM6aDBOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752072675; c=relaxed/simple;
	bh=oc2ZY3QsOQ/E3WFADv8AX4zpkr+FcT+A1653XP/M5F8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgu3h9EvlPIq3tH9rXZ1TrWX9dGpxVDknIV8myamcbvkbRgsGpXPH2SWlpr5MAHXGCwXfmJ0HBUHVSXWQUBNdW/QW1R/ynKuSNbyW47ZAqbEzm0tMDua5HnVUw44e5Pkclsf9/G4BvMnN2pbqjtFp2oD/sq/BZpDHkwg8CHNDIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 550F98025F;
	Wed,  9 Jul 2025 14:51:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id B136D20028;
	Wed,  9 Jul 2025 14:51:09 +0000 (UTC)
Date: Wed, 9 Jul 2025 10:51:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Aditya Chillara <quic_achillar@quicinc.com>
Cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH 2/2] tracing: Prevent double unregister of tracepoint
 probes
Message-ID: <20250709104249.77fc7edf@batman.local.home>
In-Reply-To: <20250709104017.69190334@batman.local.home>
References: <20250709-fix-double-perf-probe-unregister-v1-0-2b588b3c0140@quicinc.com>
	<20250709-fix-double-perf-probe-unregister-v1-2-2b588b3c0140@quicinc.com>
	<20250709104017.69190334@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: iuw9yxcfgy59k5iybhz4o3nkh4gainmm
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: B136D20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/fuoDhdxNWZwCVlMOsyDq73n/0l0Si+34=
X-HE-Tag: 1752072669-600650
X-HE-Meta: U2FsdGVkX1+v/NoaMKnGpbWacbrZ+HXi41k7/M/G5eYd/VJp9alRzMfLn4z+OjSdWmslMNAqKD54BdQijSTf2sw8a3RcPE0eg5MDc95zSd28t3gAosrUAz5YTarLQXIeCiXS+v1ozIDBmr9Z9P/zClqUhdmSUQHAekxnOa6aGJtn4cCFkwRsYeMp9BpEaMQMoBllrcApsRXxV/Jnx/Vk+pT/wiXw25Gy0Q1ezL9/xo6ZfzJYLIgVfTecbFX/4EjA8/TlwEaed7DHv3MXg33YJYxN+yxA742LTQwv4HZkiINoCQnSgqB5lFe/OyaSgripGLRPQIk6bHb4MpQ8M27XDxWdScQCfPnFdzehlgzOstFvVqaMuqx6iZ2fiVH4E9YS

On Wed, 9 Jul 2025 10:40:17 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> I would make this a bit cleaner by:
> 
>  			if ((old[nr_probes].func == tp_func->func &&
>  			     old[nr_probes].data == tp_func->data))
> 				nr_del++;
> 
> 			 if (old[nr_probes].func == tp_stub_func)
> 				nr_tp_stub_del++;

That probably should be:

			 else if (old[nr_probes].func == tp_stub_func)
				nr_tp_stub_del++;

-- Steve

