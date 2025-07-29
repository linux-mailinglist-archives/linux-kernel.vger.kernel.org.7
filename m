Return-Path: <linux-kernel+bounces-749628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27043B150BF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E393B0CE2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7A0299924;
	Tue, 29 Jul 2025 16:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hIJesd67"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE88F298CC7
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753804843; cv=none; b=JA9KuT5O1KOGc0wlDseXEEqQufANQ2p7MKqWzbfPv27mDub1wqxPDQiMPjq6sY88B4CuO8Tm8o2E3ciWI1hLlF5aNVX8FJvR55KP41GurD5b0nQaIqWB1rC1xyW6RJRhxpxba1gM0Me8Rc4b1qYYihhPB572iUbyz0Z3xAgCKRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753804843; c=relaxed/simple;
	bh=MynkkNnX7n81DqGA7Gs9Ht5g36Hw0zCI7XejOz8DkcY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GRmHpE1cEwcpSyhtALWhifj38GNdk06zCOaQ/PKSIgQ+FoSaWkpR97dY8wGrajmV7zWzBdUotsQpJ3UWEw5CIHlmh/LetMbMFsbTw7iankdznrv/WI3Kr1+YERcPBytm29EsHROvH/Kr4qYUCRyezUe/ZXwpADgfM6gTfo8HMu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hIJesd67; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0E2C4CEFA;
	Tue, 29 Jul 2025 16:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753804842;
	bh=MynkkNnX7n81DqGA7Gs9Ht5g36Hw0zCI7XejOz8DkcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hIJesd67JtJTn/cAO+m3xZHvvr468cN1mDNQoti3X/566nHXoKZX1+1xHG2TlUBnE
	 GAPP772e9eoCLupnjg7NkEQ7sC8w7WtKWS5amvTxEzYGpk9/DcuXgKHmzcUZEY90rj
	 CrSCVkzfOFkoSph+nO7S92MUOayOM7abDi/beWUpPIVDDJTznkRQXmb5a+c3fItcu/
	 mCojwI+Pvt4ajfc+PUmC5+hPH1+P8p2bys06T3Zg0Es/6Gc8cHKoXLvXdg1W8vdNkh
	 XQDifEen+cdVO8kptG8YE9n+GN2KgCdx25pPLUAgeLArE8TJ6h/pjihJx5GyubjCJn
	 /gV+tPWcU2EQw==
Date: Wed, 30 Jul 2025 01:00:38 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ben Hutchings
 <benh@debian.org>, Bhaskar Chowdhury <unixbhaskar@gmail.com>, Steven
 Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bootconfig: Updates for v6.16
Message-Id: <20250730010038.4673096e2e7b227405de67f9@kernel.org>
In-Reply-To: <20250730001421.dd070b79c120e9f6e9bd6b27@kernel.org>
References: <20250730001421.dd070b79c120e9f6e9bd6b27@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Jul 2025 00:14:21 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Linus,
> 
> Bootconfig updates for v6.16:

Oops, this should be v6.17. Let me update it.

Thanks,

> 
>  - tools/bootconfig:
>    - Fix unaligned access when building footer to avoid SIGBUS
>    - Cleanup bootconfig footer size calculations
> 
>  - test scripts:
>    - Fix to add shebang for a test script
>    - Improve script portability using portable commands
>    - Improve script portability using printf instead of echo
>    - Enclose regex with quotes for syntax highlighter
> 
> 
> Please pull the latest bootconfig-v6.16-2 tree, which can be found at:
> 
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> bootconfig-v6.16-2
> 
> Tag SHA1: bf716884a5d3afcc0be679239ae07a1ae7cee4a2
> Head SHA1: 6ed5e20466c79e3b3350bae39f678f73cf564b4e
> 
> 
> Ben Hutchings (1):
>       bootconfig: Fix unaligned access when building footer
> 
> Bhaskar Chowdhury (2):
>       tools: bootconfig: Regex enclosed with quotes to make syntax highlight proper
>       tools/bootconfig: scripts/ftrace.sh was missing the shebang line, so added it
> 
> Masami Hiramatsu (Google) (3):
>       tools/bootconfig: Improve portability
>       tools/bootconfig: Replace some echo with printf for more portability
>       tools/bootconfig: Cleanup bootconfig footer size calculations
> 
> ----
>  tools/bootconfig/main.c             | 43 +++++++++++++++++++++----------------
>  tools/bootconfig/scripts/ftrace.sh  |  1 +
>  tools/bootconfig/test-bootconfig.sh | 37 +++++++++++++++----------------
>  3 files changed, 44 insertions(+), 37 deletions(-)
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

