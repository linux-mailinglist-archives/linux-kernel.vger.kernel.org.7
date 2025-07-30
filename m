Return-Path: <linux-kernel+bounces-750911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75EB1B162A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 16:25:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C425018C3586
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 14:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0672D978C;
	Wed, 30 Jul 2025 14:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdqB44Uk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8341C5D57
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 14:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753885512; cv=none; b=f1tqICa7IQWBtpeAA+VJc+iMuewmp2KWtfN4goQ8/gZzR/8TaFFEQ2VXqFeq2ZK2n7Kp4vxRD8b1lMozy2hqRNYVluD917NsnMOanwq+tHDBEc0oNaDZfb9iQ+6bxZKK0iMbkQ7Ya8V9HlsbllvlLrlcB+9lrZjUyQgCtTOWLJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753885512; c=relaxed/simple;
	bh=b94EMsPauTPXIs6iS7FEi4HO50VLfVfniGMv4RnkUaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k1NnzA+3r4nQXlBjEapSrXVSY47dixGppNeeWD8iHGIUsAaMRY6mhdzydI2GwaHaAhe6+cNiUZavvdMDbjdP8PR/TPtwwrO8U1yQ/iSJ2Rn99kPPTDfFKk/Imcf+fs9P9sZ/TYIa7N9jb4O4Da4bnASLZ2DnBesJ9m4owClQ6+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdqB44Uk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4DA0C4CEEB;
	Wed, 30 Jul 2025 14:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753885511;
	bh=b94EMsPauTPXIs6iS7FEi4HO50VLfVfniGMv4RnkUaA=;
	h=From:To:Cc:Subject:Date:From;
	b=GdqB44UkR+cOPl92neN/zm3NT+23iUZPkDXpPMpEG/LyHUCJpm+hC4IyYyJjNJZ4u
	 zj9fhpEM9RazokQ79mSeA83hSOfjPR+93RYJWKa/vdJ3u0JHLsn4FbwPFmZMZmLYby
	 3818L5A8yoMS+2tcqt5Nd9zEMv/1WBT/uAVWFPcCEyqntFSC+XAR+eFpiI/bbuKhCP
	 +gKcFYvAi+/JBh16vXCuLYZxcB1GS05aQjvdmrUSW5HMntsMxCoWl1j8FFD+XfoQKf
	 VNlpzKnqqSPZnVlYrtxCw5XhqkWtqKDRuALN9BhvjOVIvKrvy4MniMpH+nIDlOZ/g+
	 ZOr1N1Vg0/Q0w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <ioworker0@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Masami as a reviewer of hung task detector
Date: Wed, 30 Jul 2025 23:25:08 +0900
Message-ID: <175388550841.627474.3260499035226455392.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Since I'm actively working on hung task blocker detector,
add myself to a reviewer of the HUNG TASK DETECTOR feature.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 MAINTAINERS |    1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0b444e5fd5a..e76fa00b0c3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11290,6 +11290,7 @@ F:	drivers/tty/hvc/
 HUNG TASK DETECTOR
 M:	Andrew Morton <akpm@linux-foundation.org>
 R:	Lance Yang <lance.yang@linux.dev>
+R:	Masami Hiramatsu <mhiramat@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	include/linux/hung_task.h


