Return-Path: <linux-kernel+bounces-767830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D9DB25997
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 04:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D806F1C85C20
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 02:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBD7230BD2;
	Thu, 14 Aug 2025 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jf3VAhtj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24B91494DB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755139546; cv=none; b=WwG/rAVgPje/fvnoJXeO7EACeBQpXkJiWhC9KrO2eRpwA8VgNEaruI0HCFeND0pPPX1cz0hBrxEYUpgqDKST5zPkdLWRQ3CMTS8vI3zZoxUTQZaHHXbLXw6e+bf1GP8KiUUQkUA13tgOMfaHtEjiq6o21fh7NxozvyXG68FTIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755139546; c=relaxed/simple;
	bh=v6gtkvXreyqOqot4vkurerVhlYiyKQACGbn8bOCtH/0=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=Nb9WL9UKuPezzrt5FMZ/QU421rWsYtMeTnEk/ChzZ6Yv1ySED962FRThyO3PWgJN3WYGXscwBsV7vGpEra/i+HLvCLW6lgV31NJokc41Wp0LwJzC1T87tXYec4LvQJPkOic7j16eK2BiQUR9UaV0U7pz1jdnUP+pO6atpMbZacU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jf3VAhtj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D3BC4CEEB;
	Thu, 14 Aug 2025 02:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755139545;
	bh=v6gtkvXreyqOqot4vkurerVhlYiyKQACGbn8bOCtH/0=;
	h=Date:From:To:Cc:Subject:From;
	b=jf3VAhtjMpl5qCNIDTYJCo6KsPnnm2bZ0Tt+V+4V3TZREvqG63HPF+B7zst8gUM5v
	 fVGeKsuLbcP7E2YUhJRACq2BXm4Ua846XfK0hyWRcyT0YlAD+++0MnfLGSjGTlNwM/
	 rl7Bhdwgq4fc9b5eFkHh5RxwfWSy08OfEVHfbmS344dR2O2yDR4Q2kZURB0o1hy23D
	 9BNcr1//wexcEVEvq3/mkzZiBDlKwWp74L4knttu+ESb2CvuB83j8+EFH/Gw1U0krq
	 l590Oa4mow1RVbSyznZ6iXaEqkM8BIU6Y1hLmQp9zGiypi1Nz1v1aiJF0ZJCE2YIID
	 lx4RJ62JgCL4Q==
Date: Thu, 14 Aug 2025 11:45:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Steven Rostedt
 <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] probes: Fixes for v6.17-rc1
Message-Id: <20250814114541.681999bfa828ca159b7bb32d@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Linus,

Probes fixes for v6.17-rc1:

 - MAINTAINERS: Remove bouncing kprobes maintainer.
     Since anil.s.keshavamurthy@intel.com causes bouncing, remove it.


Please pull the latest probes-fixes-v6.17-rc1 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
probes-fixes-v6.17-rc1

Tag SHA1: 1bc9e46d17a3246b34b1030dcf8be0a4f61930f6
Head SHA1: e2f9ae91619add9884428d095c3c630b6b120a61


Dave Hansen (1):
      MAINTAINERS: Remove bouncing kprobes maintainer

----
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)
---------------------------
commit e2f9ae91619add9884428d095c3c630b6b120a61
Author: Dave Hansen <dave.hansen@linux.intel.com>
Date:   Thu Aug 14 11:38:58 2025 +0900

    MAINTAINERS: Remove bouncing kprobes maintainer
    
    The kprobes MAINTAINERS entry includes anil.s.keshavamurthy@intel.com.
    That address is bouncing. Remove it.
    
    This still leaves three other listed maintainers.
    
    Link: https://lore.kernel.org/all/20250808180124.7DDE2ECD@davehans-spike.ostc.intel.com/
    
    Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
    Cc: Naveen N Rao <naveen@kernel.org>
    Cc: "David S. Miller" <davem@davemloft.net>
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: linux-trace-kernel@vger.kernel.org
    Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..a2bc2bb91970 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13686,7 +13686,6 @@ F:	scripts/Makefile.kmsan
 
 KPROBES
 M:	Naveen N Rao <naveen@kernel.org>
-M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
 M:	"David S. Miller" <davem@davemloft.net>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
 L:	linux-kernel@vger.kernel.org


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

