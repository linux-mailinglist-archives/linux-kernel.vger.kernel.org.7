Return-Path: <linux-kernel+bounces-743226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 419B9B0FC26
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 23:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 245A37ACB24
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 21:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5873C26E143;
	Wed, 23 Jul 2025 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vxmjvvWZ"
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E73149C51
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 21:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753306213; cv=none; b=E1dRpYkOhPTgmG3cVqJBWCrO8EGTTHVXAK9Tpd+KqQ3rvih2JstLsl0qwQnvl546BKjw73fqNKx+ewNgOEx/ZRT6juX/RBTbXRxfiM4w82B4L5AaGMyzkirI3/2HSKK08V5FVfTO8FKdW0kasz7C8rQdmk8/QQZg0oH6LN/R+mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753306213; c=relaxed/simple;
	bh=yjRMt+arSlSCtRI6oS1L9afVVTF7+GzuoCmwkUVVLaE=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eZqcihpQQObkhog74/yopDmSjJNtHhV7NGRwHd2vzusZX1oCHnJfcj81HsJ9kt0qKIO+xlPc52raYI3kOeUZqIh059ojMZ5lxDTkBNnP7He3BmjaFxu2cHrQFdb5TnnoAdJBR3+VrqzwzxEMsJC4NucjhF2OKNgEC18BZRcn3Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vxmjvvWZ; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753306209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yjRMt+arSlSCtRI6oS1L9afVVTF7+GzuoCmwkUVVLaE=;
	b=vxmjvvWZ/xQfWRmnYd6/ZsdTOFJHl9v3zM/yLmVDe1fySZMFNVRZOo+GTqrP4a9HsYj62q
	D7WXcYGZKymNrLPUNZnmLAan+sYtQaDCLMT1Okw0jpBiZxzgi0eaBsUg8uwOtg5IHh7iXd
	b2ynl9COlPcdTS9zz2dE5L2IY4wkKcU=
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
In-Reply-To: <20250723172114.061cc226@gandalf.local.home>
Date: Wed, 23 Jul 2025 14:30:02 -0700
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Guillaume Nault <gnault@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>,
 Petr Machata <petrm@nvidia.com>,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <FB903426-ADD0-46EA-ACE8-96A3C15B434B@linux.dev>
References: <20250714075436.226197-2-thorsten.blum@linux.dev>
 <20250714123825.6f0485c9@batman.local.home>
 <F998F71D-1244-4154-BC5F-19201C23BDBE@linux.dev>
 <20250723143625.79ab2c16@batman.local.home>
 <AE36F453-DEAE-432C-9CDA-0D2DA875CDA2@linux.dev>
 <20250723172114.061cc226@gandalf.local.home>
To: Steven Rostedt <rostedt@goodmis.org>
X-Migadu-Flow: FLOW_OUT

On 23. Jul 2025, at 14:21, Steven Rostedt wrote:
> Isn't the above pretty much what I suggested?

Ah sorry, yes it's the same. I'll blame the jet lag from traveling :)

Thanks,
Thorsten


