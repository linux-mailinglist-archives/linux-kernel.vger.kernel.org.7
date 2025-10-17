Return-Path: <linux-kernel+bounces-857699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EEEBE7BCF
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 11:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EC4622498
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 09:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2697320A32;
	Fri, 17 Oct 2025 09:14:29 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9489B2D6E4B;
	Fri, 17 Oct 2025 09:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760692469; cv=none; b=LnT4jQdhjSWKXo692K6RuNAQY2zl+autEOtOtgXXN3xct3XzUAAYRjB7sTzU/TeDvUJIn7SKLJZ+NB0vjKu9ujcyqj9NtgvMGyOiQ+o3b614Zel32F3NFkgBVapIOO6zqKr7zE9sziDAnDGGRwWTVo+51ZVA/n8620ibhW5DGfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760692469; c=relaxed/simple;
	bh=Sv4CXxzBJOfq1rxpt8Hzc6D60+L/r/E/RubWex6YyyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mlXTZawA+aGQeCw11AV3dmtzRnxcZ/kEu14Gdu2sZg4zzBwle+uBW6TkBlM97QTj/9LMGAGP/zZ9YaiIcziirUL30nrCLr5NO7Ik3yISr5dnuNLyp4ikBSuSiZRm8sgJJXOkZSlcrHySEXoZmQ2JAc6YACDtHSFp5Ya+NfFirFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 9ADC313B655;
	Fri, 17 Oct 2025 09:14:19 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 569996000E;
	Fri, 17 Oct 2025 09:14:16 +0000 (UTC)
Date: Fri, 17 Oct 2025 05:14:14 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev,
 joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 jstultz@google.com, qperret@google.com, will@kernel.org,
 aneesh.kumar@kernel.org, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 14/28] tracing: Add a trace remote module for testing
Message-ID: <20251017051414.7a6e10b5@batman.local.home>
In-Reply-To: <aPIAC0WEVg1pVr0H@google.com>
References: <20251003133825.2068970-1-vdonnefort@google.com>
	<20251003133825.2068970-15-vdonnefort@google.com>
	<20251016170645.15416c8a@gandalf.local.home>
	<20251016171155.0d871fc3@gandalf.local.home>
	<aPIAC0WEVg1pVr0H@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7hdhsjnkap11w1smo8kwhj531mpabhxq
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 569996000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19h6oOCw3PyeGtOXOG42FQa1CMRVS20sbo=
X-HE-Tag: 1760692456-794409
X-HE-Meta: U2FsdGVkX1++vc5wBG8SikSMLzHf4VoFfGg/rJahcryGkvvI9ElFZtxshtAU59/M6z3zeCiupurKvfqBqVpSi9QON0MvxuRjp4x7WAAW/t6bCxIWs7+vT043I5yRJPCh/hVBPfsZaR2hD8NBu1/dJv0+xVmELEl3z9yzwFe2Hf/UCce5cJSFpZIxGfZUzQ36jn6dIZdzH10+D56ZyCGdVBRte7xZK+d/L8Sk1ajc7miz5RzyeNYY8JHRttu3FzjX0F4hJ0sgRTUQ15iYylJNxbSUWpj4SDuFjtdTUDOuS82yx15qiOe9W4jPa+HAyqcIxqrGX1YXMa8nvL28UOsX4e3ItypVwivk

On Fri, 17 Oct 2025 09:36:27 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> And of course, I forgot to check CONFIG_REMOTE_TEST=M ...

It also needs to export symbols.

> 
> The following snippet should do.
> 
> Do you want a v8 now (and with your previous comment) or shall I wait a bit more?

Wait a little more. I'm currently taking a long weekend and will likely
play with it a bit more next week.

-- Steve

