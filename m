Return-Path: <linux-kernel+bounces-858680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55476BEB680
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 21:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0C6AE4EAB14
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 19:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1940E50276;
	Fri, 17 Oct 2025 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYVzrYeo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE423D2B4
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760730457; cv=none; b=E/0DK4CdDY28auhUs5Qb8BAsEnvc8kDfL7Ptv+0538gJB+hs1hPQNpU5Vko9ZHlNbl0z9Hi5v1WWC8aSqoDnZdhBdITiPIwuOvFO+WyMFI3ZV5MG5DymFcmcfdAaKpMHjQ/AOOq/HXylJHhguvc09oWRaTxaGxX3CmXXvnu1+l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760730457; c=relaxed/simple;
	bh=UMbBmGVObvqk5+bPLvltzvj3HzbENWtkvk1hNf6xRHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CzfS3FdgEdbBA/Rw8xHCXzYXP2NPOPYvYJAqLok0kb684QU6v0NkDxSurdfdxND3trrGIoZ+U5gXyBHMUMuekGDdwcryf4cmI8uZ80mjDsrP9KPCPqrwd6Q6OTyPcXtSTj85+K9B2SNA1HqSPzKupEkJ2YQIBpTvXwsLLnS3JTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYVzrYeo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA31C4CEE7;
	Fri, 17 Oct 2025 19:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760730456;
	bh=UMbBmGVObvqk5+bPLvltzvj3HzbENWtkvk1hNf6xRHM=;
	h=From:To:Cc:Subject:Date:From;
	b=kYVzrYeo20PW9YmqOxSUR7+aLKdxTMiOEZmHPovI8ZQSpQFCDLklljKPpT6c6ylfn
	 RvO+o6FR1+STu/jVKwQVFNCXLXNPUxB6TPJiFZiGSrNPTqCNrQs5SPa/Al5b08LVmM
	 BMQSaXh4+XpIZmLxasTrXR6cX/10MtxTQNH6B95HVivzqb/kakEWoFi7IZ/2Of2g29
	 Ghi3KKUuogwbnngdKD6o5+sfWO7ADAwMK5TcHQsy7DWt5wQDZpB1GUyrSefJd0T3ZZ
	 0IbmjoNUxxRTocVQYbRqQNhhNKRsJCliiLFcuJfNUU5RRx/g/5DCPxlsqeqadOLXSC
	 lW6HmoRSJjedQ==
From: Borislav Petkov <bp@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] objtool/klp: Add the debian-based package name of xxhash to the hint
Date: Fri, 17 Oct 2025 21:47:32 +0200
Message-ID: <20251017194732.7713-1-bp@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Add the package name for the devel version of the xxHash package
"libxxhash-dev" as used in debian-based repositories, which objtool
now uses.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 tools/objtool/builtin-check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 7b6fd60b022b..1e1ea8396eb3 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -164,7 +164,7 @@ static bool opts_valid(void)
 
 #ifndef BUILD_KLP
 	if (opts.checksum) {
-		ERROR("--checksum not supported; install xxhash-devel and recompile");
+		ERROR("--checksum not supported; install xxhash-devel/libxxhash-dev and recompile");
 		return false;
 	}
 #endif
-- 
2.51.0


