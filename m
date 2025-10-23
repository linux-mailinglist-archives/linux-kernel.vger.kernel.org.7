Return-Path: <linux-kernel+bounces-867295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0E6C0227E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5AC31356913
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0083093AC;
	Thu, 23 Oct 2025 15:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JQSmZ0yA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945703148D9;
	Thu, 23 Oct 2025 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761233719; cv=none; b=qowd6E1rHKJHt3cH6HBNSUZE2esXeSk3t3B9pi1leKWCHjoNCMNKVBKK0wTUY5U7m2OBqtXnuqp1a2fkfJ+sI+G23TRxjjR5ex1xNGnSNZ0vyZ6qJbaJc5c6DPTIwaF9HBeJqbQLVGUulZYFWOLlu7I79YwfFr2mLFPmo3pKQJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761233719; c=relaxed/simple;
	bh=Nkb+pm3t5LNBfH37ysbA7okGknNof6bVMhnP4clhqYQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Yf8Qcrw2F6noeuiw1zreEcQy65acMB6hle+sD9ZKrCoev8JR6LgMFqbYdgZn1lxXLUZeCg3u9+FGtBTfeK0et1evTN8lu2RaDZCZ5l/bsixDP5YmlbVARKrLDt3+DGjn90wg3ICEXJA8H4teeMlmzyGcgQD3Ifm0tXUJW6E3Nrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JQSmZ0yA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1373C4CEE7;
	Thu, 23 Oct 2025 15:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761233719;
	bh=Nkb+pm3t5LNBfH37ysbA7okGknNof6bVMhnP4clhqYQ=;
	h=From:Date:Subject:To:Cc:From;
	b=JQSmZ0yAWSeOccVZgahZDGLu/EQBG/WYrRg5avpW+B/ybHII+o2weSXmYAs90NJY2
	 EijJkntuS8X4CaMOFLUQ4i9qbXCRtNH+OUkabCIivIirvHVtEJW3O33prewMUZ3CkR
	 J0G4QcW8DvVVBsoeVdDo9+bFsmAxL984IzSh705heXwGhr1GxlY4Mafq1r6W+K2vkW
	 7PcbF/rqj41+v0j/jR7atgQx0PY3hYbfWZ5jJvnrDF0gn575QSeaFiPy2goKPz/N/t
	 xsshzMjJvqZ1zizDPwfIUAh2j8Ls63+JVrNs1btEhsf79lyj4AqGE5fXHNkHpeB3ak
	 GDlhtdwWMASxQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 23 Oct 2025 17:35:13 +0200
Subject: [PATCH] of: Make the number of reserved memory regions
 configurable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-of-max-reserved-mem-v1-1-cfecc7a2150f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBG4avErBswI4quEi0sf2sWWihEIN49a
 fkW38uUEAWJ5iZTxCNJrlCjaxvaTxMOsNjapJUeOqV7vhx783JEhQ8se3g2EyY72q03DlTlHeH
 k/a/LWsoHF53jsGUAAAA=
X-Change-ID: 20251023-of-max-reserved-mem-a8e8d7db3afe
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: Eric Chanudet <echanude@redhat.com>, Radu Rendec <rrendec@redhat.com>, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.2

Some platforms register more reserved memory regions than the current
hardcoded limit of 64.

Let's turn into a Kconfig option so we can easily tune it according to a
platform needs, while keeping the current value as a default.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/of/Kconfig      | 12 ++++++++++++
 drivers/of/of_private.h |  2 +-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 50697cc3b07ebeb24283e22299797ce4612db89c..721221ae73cef118f8bde8c64c6298aa5f1d106e 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -97,10 +97,22 @@ config OF_IRQ
 	depends on !SPARC && IRQ_DOMAIN
 
 config OF_RESERVED_MEM
 	def_bool OF_EARLY_FLATTREE
 
+config OF_RESERVED_MEM_AREAS
+	int "Maximum count of reserved memory areas"
+	depends on OF_RESERVED_MEM
+	default 64
+	help
+	  Platforms can create a number of reserved memory region
+	  to accomodate their firmware,	describe driver-specific
+	  memory regions, etc. This parameters sets the maximum
+	  number of reserved memory areas in the system.
+
+	  If unsure, leave to its default value 64.
+
 config OF_RESOLVE
 	bool
 
 config OF_OVERLAY
 	bool "Device Tree overlays"
diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
index df0bb00349e01145930fa85c195aefc0a7c32a06..af424ca876b4481c21563bfbac8691a74a42970b 100644
--- a/drivers/of/of_private.h
+++ b/drivers/of/of_private.h
@@ -7,11 +7,11 @@
  * Paul Mackerras	August 1996.
  * Copyright (C) 1996-2005 Paul Mackerras.
  */
 
 #define FDT_ALIGN_SIZE 8
-#define MAX_RESERVED_REGIONS    64
+#define MAX_RESERVED_REGIONS    CONFIG_OF_RESERVED_MEM_AREAS
 
 /**
  * struct alias_prop - Alias property in 'aliases' node
  * @link:	List node to link the structure in aliases_lookup list
  * @alias:	Alias property name

---
base-commit: efb26a23ed5f5dc3554886ab398f559dcb1de96b
change-id: 20251023-of-max-reserved-mem-a8e8d7db3afe

Best regards,
-- 
Maxime Ripard <mripard@kernel.org>


