Return-Path: <linux-kernel+bounces-600726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52CDA863BD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 18:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435253B7D23
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Apr 2025 16:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AE1221FDC;
	Fri, 11 Apr 2025 16:47:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402D9220698;
	Fri, 11 Apr 2025 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744390047; cv=none; b=UJjoXONHbVhw35+1kP+yxuOK1U7S0Ro80YtuOqdSjCP/A4Wv1JG2914jxxPZ+ySWkU5OC+DjXa78GGaXJ1YrCc0s940UdiuVTkmKp023BHKWjHCTX3dBMB7vQipM9+GcewBIDxAEa8aAHKVmm/Kjo9xp1CpITKIdZ2baM7Gf3ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744390047; c=relaxed/simple;
	bh=+b8LfmTJ9PJmjzhEQMW6WbLPkoK6QDLjLOoLTMlLbmM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KAOlo6kFLyWfaRVsQTX+JFNsBVWLmx2HbuPsg1SUPf4W6kb3T0IVkCLGbprQZkHV+vBaLcbwgwj0NFDzBxxGrIcYHBJc0JqE4joA+6ByEAJKCiWGRMkzh7DrERsSudBhI6eFrGAyR6bEijkMzqWa8X3p40Dx2jvs2BKi0uFux1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B78C4CEE7;
	Fri, 11 Apr 2025 16:47:24 +0000 (UTC)
Date: Fri, 11 Apr 2025 12:48:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sven Schnelle
 <svens@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
 <guoren@kernel.org>, Donglin Peng <dolinux.peng@gmail.com>, Zheng Yejian
 <zhengyejian@huaweicloud.com>, Aishwarya.TCV@arm.com
Subject: Re: [PATCH v4 2/4] ftrace: Add support for function argument to
 graph tracer
Message-ID: <20250411124849.30d612ed@gandalf.local.home>
In-Reply-To: <20250411124552.36564a07@gandalf.local.home>
References: <20250227185804.639525399@goodmis.org>
	<20250227185822.810321199@goodmis.org>
	<ccc40f2b-4b9e-4abd-8daf-d22fce2a86f0@sirena.org.uk>
	<20250410131745.04c126eb@gandalf.local.home>
	<c41e5ee7-18ba-40cf-8a31-19062d94f7b9@sirena.org.uk>
	<20250411124552.36564a07@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 12:45:52 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Also, is it possible to just enable function_graph tarcing and see if it
> adds these blank lines between events?

Never mind. When I enable the funcgraph-retval option, I get the blank
lines too.

There's likely an added '\n' that shouldn't be. Let me go look.

Thanks,

-- Steve

