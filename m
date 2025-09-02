Return-Path: <linux-kernel+bounces-796752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8F1B406B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 16:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180767A45DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB04F307AD7;
	Tue,  2 Sep 2025 14:28:44 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA6303C8E;
	Tue,  2 Sep 2025 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823324; cv=none; b=l+wyXl8aLRmsNkCn4PxR2P6MmxggzV2jyHQ55YOxOUPwQj8R+EePRZdAymWVZlme4D/4RPrC/4AQwiutAEL7tQntX7qoMIc1666v+KN+JP24QGThG1lTty24FGqYOS1mktjvoYZQeXiJvxegvSLzXK3LRnD8CAtMn3CPtgOaBeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823324; c=relaxed/simple;
	bh=TkrgpslKuSPo0ZM9EHtcWoH4HGK/nqSdH+oSDOiB6Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZACfkZOuobU+2Npb8LMjvWp8Ge47rP6oBXw7tN1DPKAAOkHRqW3YA0jHRqjJ7mzHQRbrbEgZfInw2/jE4NltJUj2ot2+MJ7D0jJh0rqNJTWVVl4uV+huLtJf0gy3SHzxfo0FWAa29/fBmkYCAnjdlsNIjNTDmW5M+rrBBfYU+Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 78E578479E;
	Tue,  2 Sep 2025 14:28:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id C1DAC2F;
	Tue,  2 Sep 2025 14:28:32 +0000 (UTC)
Date: Tue, 2 Sep 2025 10:28:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ryan Chung <seokwoo.chung130@gmail.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/2] trace: minor documentation fixes for clarity and
Message-ID: <20250902102831.134a26c1@batman.local.home>
In-Reply-To: <20250831101736.11519-1-seokwoo.chung130@gmail.com>
References: <20250831101736.11519-1-seokwoo.chung130@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C1DAC2F
X-Stat-Signature: myjeqdrbq5gjo49jcyeh3p83o3etmie6
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/+8mfpzDUQ5m9ZGTfRTsKTiR+ji7LAwBU=
X-HE-Tag: 1756823312-267627
X-HE-Meta: U2FsdGVkX19qbpG0qlynaYkahSQbtc12Jj/iBc6ysBBfCr+SoLsYjIZZQ3ODD9oPqd72krZPKn/ewCwDfOg0t5IKFZL/JW/ejtppPJpo9MXg8gIpUCsRIOxSc15gzPSQoP8sUen8EdshGcvvF4r+ANBSqSkE1dpvyZy1/icizd9XMuOFjMr+kto0OYb6Yp5AZMjCp4h6Q/ZCvfeLRV1cLeZDDdzgxcgyOVCCsPM5cQr74f4HJCmKr/aTHR6Wmyn54lIGCJTI67dzi9TUM4Y+s8XxHJvLncQqL2pgiE/Pmd3zFjxGpotnXzF+wbCSns5XONhaeZrJRQnnM6cfHsp8cSVk4VPC+5PzVmDyaFqp24Dcn88cmAzUDyrYeRqwn3I+MlF3bNoN+jp5gsPmyTqLEA==

On Sun, 31 Aug 2025 19:17:27 +0900
Ryan Chung <seokwoo.chung130@gmail.com> wrote:

> Resend: fixed recipients; no changes
> 
> Hi all,
> 
> This short series cleans up two small wording issues in the tracing docs to
> improve readability. There are no functional changes.
> 
> Ryan Chung (2):
>   trace: rephrase for clearer documentation
>   trace: fix grammar error in debugging.rst
> 
>  Documentation/trace/boottime-trace.rst | 2 +-
>  Documentation/trace/debugging.rst      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

The only comments I would make is the subject tag for the trace files
is actually "tracing:" and not "trace:".

Also, even though the changes are minor, a simple change log would
still be nice.

-- Steve

