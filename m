Return-Path: <linux-kernel+bounces-785530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D2DB34C18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A03863AC860
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB4727F017;
	Mon, 25 Aug 2025 20:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ejH4POjv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C7393DE3
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 20:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756154072; cv=none; b=XAsNHJihJh9XHDsLuDXhSM8buo7FCKO3eJy6Ap2RkbpjRSPHxZUwpxz4Rc4Uw3wSu4DKh16XXw5jnd98VDVpqyM2qA4Ua+EIaZYyOxXnm43khGorhln0Fag47+H4KZ1eXZQ9UbAO7joZ37Q9sKSFOv2Td/yU5PWObIPFWBuKqmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756154072; c=relaxed/simple;
	bh=E6GpoylaUUBw3yEZZQ0csSzbsujgOrj2g/pI+5+Q3+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSfdh30np5hSDJVsPUxX1Y4gouHk01JxD/6Wz784MsjCI8E2KMM2HzHfCX2DkeSyY7W+ecWhJoxbfGyI2LCsKHNA3Lxl2mJaAU2dtv7J8FOgxDy7enL0MGsiU9d8WF29+jlsobakcFdXE8FG6/2QF8T4tM2uegzUmSloDj/mCUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ejH4POjv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5074CC113D0;
	Mon, 25 Aug 2025 20:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756154072;
	bh=E6GpoylaUUBw3yEZZQ0csSzbsujgOrj2g/pI+5+Q3+Q=;
	h=From:To:Cc:Subject:Date:From;
	b=ejH4POjvnIXGoMvz4MLLENXhg3upImWwWEQl3MAoDa9+XG6jLPxIo1ogOwoeV+xO/
	 rQTViZLngA/61IssCtWZQ7jxztwf19MzzYH06og3tFaZpPw3GElp7tTeaafvUwHIGC
	 lFedT4Kuv57SkaMhZC4FLLd/qbmPNOP0WjsxtQJADbWulPCCL7nUP2c3MR/HFdilME
	 H3tlKdLlYlm3FfR+hhNNtO9BeOyQDmARy516P6p5wbIqWDIkyGH//did8aQ0zHPprW
	 RqlJkKVPCSKw/n7xQeWAfCra3v7oUl9a5ZRJVhFv8m274sAWWZeIfsUzAR1jrNGY+9
	 +aWlHLRML0n4g==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>,
	John Stultz <jstultz@google.com>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] jiffies: Remove obsolete SHIFTED_HZ comment
Date: Mon, 25 Aug 2025 15:34:23 -0500
Message-ID: <20250825203425.796034-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

b3c869d35b9b ("jiffies: Remove compile time assumptions about
CLOCK_TICK_RATE") removed the last definition of SHIFTED_HZ but left
behind comments about it.  Remove the comments as well.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/jiffies.h | 2 +-
 include/vdso/jiffies.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
index 91b20788273d..0d1927da8055 100644
--- a/include/linux/jiffies.h
+++ b/include/linux/jiffies.h
@@ -61,7 +61,7 @@
 
 extern void register_refined_jiffies(long clock_tick_rate);
 
-/* TICK_USEC is the time between ticks in usec assuming SHIFTED_HZ */
+/* TICK_USEC is the time between ticks in usec */
 #define TICK_USEC ((USEC_PER_SEC + HZ/2) / HZ)
 
 /* USER_TICK_USEC is the time between ticks in usec assuming fake USER_HZ */
diff --git a/include/vdso/jiffies.h b/include/vdso/jiffies.h
index 2f9d596c8b29..8ca04a141412 100644
--- a/include/vdso/jiffies.h
+++ b/include/vdso/jiffies.h
@@ -5,7 +5,7 @@
 #include <asm/param.h>			/* for HZ */
 #include <vdso/time64.h>
 
-/* TICK_NSEC is the time between ticks in nsec assuming SHIFTED_HZ */
+/* TICK_NSEC is the time between ticks in nsec */
 #define TICK_NSEC ((NSEC_PER_SEC+HZ/2)/HZ)
 
 #endif /* __VDSO_JIFFIES_H */
-- 
2.43.0


