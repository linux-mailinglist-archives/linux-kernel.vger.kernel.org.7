Return-Path: <linux-kernel+bounces-743016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57947B0F98A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 19:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62E42162D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777392222D2;
	Wed, 23 Jul 2025 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LUt56hqD"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076312E36EB
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 17:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753292792; cv=none; b=HYarRVHdZ+15Or0JLAJyf7XW9SQvxqxCmSEqz0ay9fJD38wGc7GN5VVzKgspnP3YVm0INOv8nuUcM70WFavPUAIKhMM0csOaGYdFLbB3KQ8ku71MJ+CKDLOw3EIefWl9sMFockwvGUZTAv9AkNm6NySfSwrslgKIUZ2AeebT6bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753292792; c=relaxed/simple;
	bh=lYnN/1pWgCDFqesfgHtQyFbqwYH5n9urVKcNuI5vi2U=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=OhVqEf5kkARp0QSN25LZoDjPWGYxzn4D48iwaUUyJ8xqthG5kyRnUE1E1spHW9KP+IC/5zOnGi37/gnwtS8Q4UvhgbTT/FtCFxfF3JmnivsFb/Qfr2kCt/Ar2jpCFwfdXsFyDN0jalGdvo0HgOp0/jvaqOqkJSzNNwk1lzWB960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LUt56hqD; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753292788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ug2rfeed2cWn/I2/5Z5uz7sqeV+pd/xv4VUaRzto6qs=;
	b=LUt56hqD5CCboMBaMivITHWY7Oc2uO6Si5y3LPXwB5Xc9XMSAE47X3dVjalNudEy07lIny
	4E9d9p1dWJ84BmnT2uNOdBpR9+/DoBpn4o8f5CIUsSzDq7xu3D8YcW0SIAchLEf6Hn9FRB
	hjVpu54skIoUfoPzX7e13KLNRx4Z8rA=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH net-next] tracing: ipv6: Replace deprecated strcpy() with
 strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <20250714123825.6f0485c9@batman.local.home>
Date: Wed, 23 Jul 2025 10:46:12 -0700
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Guillaume Nault <gnault@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <F998F71D-1244-4154-BC5F-19201C23BDBE@linux.dev>
References: <20250714075436.226197-2-thorsten.blum@linux.dev>
 <20250714123825.6f0485c9@batman.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Migadu-Flow: FLOW_OUT

Hi Steve,

On 14. Jul 2025, at 09:38, Steven Rostedt wrote:
> 
> Hmm, why is that string hard coded to 16 bytes and doesn't use the
> dynamic string facility? Perhaps something like this?

Your commit fca8300f68fe3 changed it from __dynamic_array() to __array()
and __string() seems to be just a special version of __dynamic_array()
with a length of -1.

In the commit description you wrote: "Since the size of the name is at
most 16 bytes (defined by IFNAMSIZ), it is not worth spending the effort
to determine the size of the string."

Thanks,
Thorsten


