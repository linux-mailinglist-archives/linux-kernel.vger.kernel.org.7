Return-Path: <linux-kernel+bounces-838223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C8FBAEB9A
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 01:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C162E189ED63
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 23:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029302C030E;
	Tue, 30 Sep 2025 23:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p7YZ+bt6"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15750433B3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759273437; cv=none; b=jOCpa8I9DeWiT3YiOOPONLM35x2XHEnjNFcXuZ/01j9ikZEiT86V6p1k/+LP8hd6+v5HhbhD25Uio11sri/OeVgpKvxm8Wv7RtVFo7yfivNRkWH1/RDg+GxKr03e9ClJlDwZUkeuriEejfOq39T/lowNoLSjMo8uMN16k/nbzs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759273437; c=relaxed/simple;
	bh=MwsxlnZczU/bnB3A4SBELGbj2o2bz3EsiwhVQvoMcVE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=re1qBBCPqmblXcci0lSlR+2bwCJwLrurfVqOS5OAwlgGRbgDUXE9N1IeIVNGfxhkvAe6/yCwMdJOGkeJfKDCO7H8+XLzH0AUiOypVLMPmE5GK+3wvEJwLi6VYe0ln2Db4WpV9PQ6tz38B2SFgbvqP/xUlalqC2AFHhqzxlPo2EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p7YZ+bt6; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759273421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yKvcQaGiIXcyV92n6d4ZDbACEVruTCAsYgqJlCgePMc=;
	b=p7YZ+bt6dp/z/krOPJz2NtGQHfALZgapKqlhaKr/R2k0nieOPyMHUy42HV7SZah75yiZ5k
	ji5mDaIr7Xl6wzsDcSif7V3jLA0eXSDjRUPWI2y+vSNLsl3c/SR2I6HwHCgcEavoMPd4Pu
	QA/rb/p9xf+Od9nzmqXpPRPTj5IgKHo=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2] tracing/osnoise: Replace kmalloc + copy_from_user with
 memdup_user
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250930172841.63dc86b5@gandalf.local.home>
Date: Wed, 1 Oct 2025 01:03:29 +0200
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <76B6CC10-1C0A-42D0-83E8-8CA8A7790BF0@linux.dev>
References: <20250925211736.81737-1-thorsten.blum@linux.dev>
 <20250930172841.63dc86b5@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Migadu-Flow: FLOW_OUT

On 30. Sep 2025, at 23:28, Steven Rostedt wrote:
> Which makes your change not quite compatible.
> 
> I'm going to rebase and remove your change for now.

No worries, I'll send a v3 tomorrow using memdup_user_nul() instead.

Thanks,
Thorsten


