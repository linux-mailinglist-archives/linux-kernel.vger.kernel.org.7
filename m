Return-Path: <linux-kernel+bounces-753785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2C0B187EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C8E1AA5EE0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A7E28DB76;
	Fri,  1 Aug 2025 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XrGYTEVg"
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021DB6F53E
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 19:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754078366; cv=none; b=bHkZEut7qKxl3Ltk9VTEaDzn7FQjxdRuhY+rkI0qaUXTKER7zVP9fehY53H9yFzCQoApTQzDNIwxTtHihLkOQKcGNHmmn5llTd1PHDofxXQVvkrl7fQPbqAQ9khLs7/gdABhjD++voO/DsIe0yDmdjvydjD/uYGYYgEkY99wm10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754078366; c=relaxed/simple;
	bh=bYQXN1B8K5n0DP2UG+fP5IGUd0vb54YmpWGnJo5dnuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LV6NyQMesah6ZZKF3XwAGIyYW0ES7tz/9XXLhwTs4YSugzvIxEnupzmE/tm6/2PWI2BvUFHLUJO+6vZO615sF6elSVrybeq4OPIS+D0iPhJHVkppUBj30OPvL5ShrzbJQ24j6wttdkCJPHCZ1jGNiLcOgru/jEfjFjiyVeAsKZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XrGYTEVg; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <604028fc-0a41-4323-b72a-7c61e069ef3c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754078352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cTIB+VpKm829JSsiIHiJoB+yOOqh5LTcm6h+yByXhwA=;
	b=XrGYTEVgSmztKGNUqCYEmXFIvWwQTihBuA5UDnuH+JYDmc48ZGg/WU4g0oDJYRbm9rj9Kt
	jOgxIuyG2P5np2QjlrQw9QE8vnU+Eb9eX7tJ9luu93roCo9XDId1KsR09kveTiOqnhzVVN
	h+mTNDCEQVvClBfFzWc0e5NRXKb167c=
Date: Fri, 1 Aug 2025 12:59:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] tracing: Have unsigned int function args displayed as
 hexadecimal
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, bpf@vger.kernel.org,
 Douglas Raillard <douglas.raillard@arm.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
References: <20250731193126.2eeb21c6@gandalf.local.home>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250731193126.2eeb21c6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/31/25 4:31 PM, Steven Rostedt wrote:
> +			int_data = btf_type_int(t);
> +                        encode = BTF_INT_ENCODING(int_data);

There is a btf_int_encoding(t) helper in btf.h, so only "encode = 
btf_int_encoding(t);" will be simpler.

