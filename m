Return-Path: <linux-kernel+bounces-724183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4ABAFEFAD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 19:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 508761890759
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 17:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EBF2222D8;
	Wed,  9 Jul 2025 17:19:01 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46ED156F4A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 17:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752081541; cv=none; b=KcvNLMbPcobHZVWQtUe79ndrD1HUvewN7D8OwLGAqk0caaFYFNKrLqoGFKx2AOV/1LV1C697lV7hFHcINFSVMn5e9QcpRVD8nrk1qdhL8CK6aVXhhbna3YZdMzGXUlTQaWB/U90GSiyJpRueLoDs/lBbxTtzqhBro3wDX2mhXAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752081541; c=relaxed/simple;
	bh=ic0r+c0esVMG4CH2cCbGk35wyYq5W68+w9EnoWvadNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rHWCjGVyxWXCBvwy5gb34cpYa6GQ/jDHllqBAK7+rJcz02lPVWz3FNzmpimaRwj0AtdeBv5XziM4Wb3IVddAIE23BBgJ8jjUqoQfH3clq3wMwyZMRT928L2YL12RjI+MsJrWo62+bPx0vAtfQtTyOUDhCPtZlDB8bM64C7s500Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 9D4BBC032B;
	Wed,  9 Jul 2025 17:18:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id F1C7E2002D;
	Wed,  9 Jul 2025 17:18:55 +0000 (UTC)
Date: Wed, 9 Jul 2025 13:18:54 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Aditya Chillara <quic_achillar@quicinc.com>
Cc: Ingo Molnar <mingo@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] tracing/perf: Prevent double unregister of perf
 probes
Message-ID: <20250709131854.5eccda2b@batman.local.home>
In-Reply-To: <db613bd2-c78e-44ea-9aad-9f99996731bc@quicinc.com>
References: <20250709-fix-double-perf-probe-unregister-v1-0-2b588b3c0140@quicinc.com>
	<20250709-fix-double-perf-probe-unregister-v1-1-2b588b3c0140@quicinc.com>
	<20250709102329.7a5430fd@batman.local.home>
	<db613bd2-c78e-44ea-9aad-9f99996731bc@quicinc.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F1C7E2002D
X-Stat-Signature: dtwjhffck6aq9pjw19qsk79g7ghd8wqz
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188NCHY2Gu4i1uW7I9s5x/BHSw3U7cvhGw=
X-HE-Tag: 1752081535-728028
X-HE-Meta: U2FsdGVkX1+aBOTUt80UjbZtu9MOn0ifBffLoTyCx/bCTJ5iNhm3f9lq3QsAzy+z+1W1x9pVkEIh1OVY7V0ZicfWViCn/Dqe+owuZwOPPER+fQa0yXbjoPlrp9d94B0IPZgudbZU30d0U/iB0/RZcYIoD790HD0FuiUPLLhPLSTS3pV00lyOgPt3Coj6H4lExQ2JT+CNO8c0KaYO8iV0iOCGVlD8QxJU6MzBBsXD1krMKWTM5ExmZFMIK3q07trQ7sq49qwdJGzJAPL/8RUbiD7p/sdAQf3CPo/YOcB7Zkjysz4QMQUZv7EGnZDB1RLvSpJEE8WRWInb2+xalgt3gpg4v8C4eCUuT6IASUu1DdEu97MtBVX6z90aGNDxX9PamtiEIO2g5veDH6ajeuKgUA==

On Wed, 9 Jul 2025 22:20:00 +0530
Aditya Chillara <quic_achillar@quicinc.com> wrote:

> The exact problem was introduced by:
> https://github.com/torvalds/linux/commit/7ef5aa081f989ecfecc1df02068a80aebbd3ec31
> (perf/core: Simplify the perf_event_alloc() error path)
> where __free_event was calling event->destroy() even though it would
> have been called by perf_try_init_event in case it failed.

Then I rather have it trigger a WARN_ON() and disable that event
permanently until reboot. It's a bug, no need to continue using the
event when it's in an a bad state.

-- Steve

