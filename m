Return-Path: <linux-kernel+bounces-766499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AED7B24749
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 191C01AA182F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA232C15B7;
	Wed, 13 Aug 2025 10:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M7ij0xoP"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A8B2F2918
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081152; cv=none; b=qzTjpGuWMLIykwJYdW2zHZ3UDfjsalwNAm+rC+CZtCAljd3TlNiSIyRJFPAxfUeJL6GiLoai7mjilLr91hugI52f22ad5Mp72RXib0t4W2VcZ3kSTYq35HlAxa4iLQ+3CXxqJ3BBAmHgrvw3OKluvJvTYWpfrdw9KUrROh7sEl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081152; c=relaxed/simple;
	bh=NIIZPc0sY912C1m9icYTUlAu6CHaAo3ThTuiUKfZGXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PoSmGRpAeASfy8PvoO92qISvR9sAngrd+qXAEnmTxuNgJjb+Hj7RTc4miyE5b18yBb9ArCaPWYuLw1AcWf1Sn9xC1UgzlvlsV7bMKYZDw0Yk2BWTT8wU8Rfw7pRhX3nR3hIn0BD8J7B24Z+tPAaAmGnJ54BGwMgGfvTuUg6KLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M7ij0xoP; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755081138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yRug7LQyvFONu46jBMGRmPeIFE9+yuqhOdPPzW6dSeU=;
	b=M7ij0xoPfeD2CH1dQLA/0tV34M+LYKhKQFovdoB6gCYrIzbVZxdkMWBds9fseU3RgqQ6d/
	vcTf3us3Ri+Jqeh6OoTjfaXWQgQSlOU+nNVEZU1l3/sHwIUuHjDiVoMYcRW4fcg6KRqYoB
	CXvjEr+YP97xor1iZ3smZ8jn8bzzXWA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] powerpc/rtas: Replace one-element array with flexible array member
Date: Wed, 13 Aug 2025 12:30:59 +0200
Message-ID: <20250813103101.163698-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated one-element array with a modern flexible array
member in the struct rtas_error_log and add the __counted_by_be()
compiler attribute to improve access bounds-checking via
CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/powerpc/include/asm/rtas-types.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/rtas-types.h b/arch/powerpc/include/asm/rtas-types.h
index 9d5b16803cbb..5d40d187b965 100644
--- a/arch/powerpc/include/asm/rtas-types.h
+++ b/arch/powerpc/include/asm/rtas-types.h
@@ -42,8 +42,9 @@ struct rtas_error_log {
 	 */
 	u8		byte3;			/* General event or error*/
 	__be32		extended_log_length;	/* length in bytes */
-	unsigned char	buffer[1];		/* Start of extended log */
-						/* Variable length.      */
+
+	/* Start of extended log, variable length */
+	unsigned char	buffer[] __counted_by_be(extended_log_length);
 };
 
 /* RTAS general extended event log, Version 6. The extended log starts
-- 
2.50.1


