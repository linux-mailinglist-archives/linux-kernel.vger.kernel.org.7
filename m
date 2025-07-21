Return-Path: <linux-kernel+bounces-739680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6B7B0C99A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 19:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E74E16F242
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 17:23:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9D32E0414;
	Mon, 21 Jul 2025 17:23:41 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48DB1F30A9;
	Mon, 21 Jul 2025 17:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118620; cv=none; b=clSTC+9Jzz2fma9XGRyWzj6mPLDQBicDSng19nt5CBgnRNUZzwQmA/GqsMh3bROHWLwSL6D6sgmX8EhSGOj/ibdPBynPhGydTFHFXJHrnuO0jtZjv5pv5xQVm3Pzv0DiDgnqlpkANiqngeoEh1PtpZFSvJoUSiF4qOjQpAwTxI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118620; c=relaxed/simple;
	bh=sSaJlmJxbdpP26NXJsmWtpT993GiOo/FBnZqzxzvRXY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXOaOZXAjRpy3zYL3HyZT8c7B1liil8nHkMe4mhYTG8waBK1tykmDBEpUiqPdLGVRI3bgQP6rZKqRBorIx0HQlwHX+GxR80sjaVqnOXSnIL2952dBp3jEHKyYykb4gheUyGN8tXRfUtUu7FNe1C9haXfbvDajMKyrCJrHAZRIIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id C3E5856063;
	Mon, 21 Jul 2025 17:23:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 32A201B;
	Mon, 21 Jul 2025 17:23:32 +0000 (UTC)
Date: Mon, 21 Jul 2025 13:23:31 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/6] tracing: eprobe-event: Allocate string buffers
 from heap
Message-ID: <20250721132331.771f6f17@batman.local.home>
In-Reply-To: <175299253643.418723.5944624119162360742.stgit@devnote2>
References: <175299249728.418723.17799706394466693180.stgit@devnote2>
	<175299253643.418723.5944624119162360742.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: en7cxc4a9r6fnn5aamyswxtez6ix74wh
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 32A201B
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/P8ik6rEvYj0BNRPdJEEcWJKgEPGjzCkY=
X-HE-Tag: 1753118612-128728
X-HE-Meta: U2FsdGVkX18eO5PQTiVqdLHRymwX2AjMLURqIXWC8U7Y8IK8bdJaNfe8Mma8aMNGOH4zB5lNJ86hJTdRYYYaahdt4IPua67T/yLm8O2qF7NbttCD8GbLH9KC9G+zWrBFSmam3JiKFLZ1gq74l8lf0D5E3qE3qsN38xxvzyK6TXzZEn3bOdghgp/jLEKYf5Cy8ftyoBAA7ZiJ8z683gQHDL8Z70zmIjDFKObdK4nsP/Jx2erfFqT/1Kj5Eq6HNCv+RH4hKciJGqSHbwulnBVRXiOxRmvAG2mwQinLHA9SJNq5hxFNF9N/DT7OWCOL3pPt1XWACLboFoQEmCwuN+pp6qbMmBxX6ufrNOZhG7JBAtFknM89KgmbqYyQk0fZzP17sAfE3NP2WanJyPItHEL1Iw==

On Sun, 20 Jul 2025 15:22:16 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Allocate temporary string buffers for parsing eprobe-events
> from heap instead of stack.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

