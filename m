Return-Path: <linux-kernel+bounces-877716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F029CC1ED83
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 08:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7043AB5A9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 07:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52789337BB8;
	Thu, 30 Oct 2025 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8PUAp/7"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514B257AEC
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810630; cv=none; b=rrJwpR50kJ5j9MN88DoE6HxT5MRi0+zvzwWlMNfNOCfFY6uSAzdzULfA/Ck711uYzWgqa/c+wbgPsv4sFTrH7OfOgcxnZrhZbA55brABSyZUh2haJ/tSf0AzVJ6iqlp2c3JAeJJFyehlY5n8o48NWg0m6nE6kyqeOwZIyy8RORw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810630; c=relaxed/simple;
	bh=JEl9GC42JmfajoHCarU2JPEtxV/Dvh3GNqFUPBkz8So=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P7hgZmgq1N2e/Rw2iYNj3+pjngQuUXt5JDaFq76eLnTK6R8wVtJgN0wGbLqo9kliQ2JTWtAvBCQbziHgnKRchyb2cUInXGlDXelSy4HkpIQq2iLLDNFr+XkDlYNovPZS/EECjhfPGLfoH/IttwdvELU3Clnh6Mn1ZDbRjS3rnKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d8PUAp/7; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3307de086d8so726163a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 00:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761810628; x=1762415428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vdDJYs2ftj9g3gsNmVUwfcn6X4b2n8l3NR5CnT8xsbU=;
        b=d8PUAp/75/QKRXkvqcwfPDCm23XFiMmFSdAKkxyBcCJ4Ft/nxDzTzn/r5+ChTRoTXZ
         CgIAfjk2mvYQlI9AD0GO50UDn4Uz4RQz+8d6Rtg/Y5PML8fxlrw2RRj42ZVZYviSFLC7
         2TEh0w6GY7j7fuUCg247cD9wRmQFLycP2pwIRNP+mfZoApeOWHic09OLzYRZWZ50HVQn
         cDe0/7YhpPTltn+2TnBtVrJ/kO5EPIFKD1xf8t+hZWwG/lDHJx02QHGOrKqREYrgZ31b
         kMv2klfC+Za1Pj+TWsZVVt8q+cwjkrDK6zGFNucnfoYyYD+0z7E5lNb5sktlA+2w+Zmt
         getQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761810628; x=1762415428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vdDJYs2ftj9g3gsNmVUwfcn6X4b2n8l3NR5CnT8xsbU=;
        b=t5RO00B1HqUQCnHsFbzLsccXafhAbFh9blkNXhsGPyXDts77zCFX5DxF8QX54HILHq
         Us4MRWkH8z6Savr5iQeYMYGfNLcq5tw/wD39Tn2r9gTSCs1uLDA4i/RNXDv2JJYE6oqU
         9bAx5eHzPfpu0tT8CiFLkt6tD6ayMLEEKKZr4oIm84Uc4VEjLMQRqhti7JlDPG2fyarC
         4UaUHjx1nVYs2IM7W5Uxsz4PRMwLUGpbCoEyYTT/Xi1knl3Hp+yInY0IxYRBJsvRT6wc
         Et+M9TdHbJsK42sLkiPvB3lNmlvB4lPPjrugkf6cVCsHwq2c99+ZISN52a6iCpa46V+R
         8NcQ==
X-Gm-Message-State: AOJu0Ywavq558y9XB6rz5g8gqrj+24lh91YSgXVDE7m2IXN6rq3btGXc
	fOpzEPyTs3VMHyb1LEqj8waqyJvT4TzkEti+Na371dc9RLZG4QHTtrO2
X-Gm-Gg: ASbGncte6b86K6u/NEf+vRIsGQm5beAPeaK1ikb50pNn7Phvf5Uql3XSXm2CbGf8BOp
	gmDRd8YhMYMicQ/cZWkPJzlFt7z8rZ/jyvNLYnrvfEDi4q87cfROSPHwRkoopOFy+itbffZeoYK
	AB0mZjpxzQgze3X6GAmrptTvsDq2Tb+cQewTSKOlUHLHAP0ALiPKaCDTFPiozVKiNziajV0tMJm
	UpbqqXM2jxssl3+tbWAsWSpcBd8qFwRsbdOySQv8mCktsiBUvSEF6HV7wLq2CyefR9y7eM+Zg8G
	my8XdDs/pcOvSK/CRFZIQrJVNZkqXGdaMI6I85w+2KWloxxaujE2A0HQ8UbF8Bamhu5YAVi4V6C
	xpVszMUECgl8NWmxEUPB+arNW/h/apKmwTwzlbsr3hc0psiYahChZGcV1RyoWmmI70sGopeXr6e
	ueyDi66Fr4R2w=
X-Google-Smtp-Source: AGHT+IEnOW3OBrwdrAR2/T02/vIwASDH7t9uKYiCN2IyW2jPQ7gCDPSDpZfSRXEfWPjcVg3PiiwQKA==
X-Received: by 2002:a17:90b:4c09:b0:32d:d408:e86 with SMTP id 98e67ed59e1d1-3404c3ff4b8mr2592187a91.7.1761810627892;
        Thu, 30 Oct 2025 00:50:27 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050bb62casm1554574a91.20.2025.10.30.00.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:50:26 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 7AD704209E4B; Thu, 30 Oct 2025 14:50:17 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net-next v2] Documentation: netconsole: Separate literal code blocks for full and short netcat command name versions
Date: Thu, 30 Oct 2025 14:50:13 +0700
Message-ID: <20251030075013.40418-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1137; i=bagasdotme@gmail.com; h=from:subject; bh=JEl9GC42JmfajoHCarU2JPEtxV/Dvh3GNqFUPBkz8So=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJnMEpucuOR/GChNmvJz0qIJUgtObFj4kHXNrRd7Y3S/7 HO5+iZGv6OUhUGMi0FWTJFlUiJf0+ldRiIX2tc6wsxhZQIZwsDFKQAT2SvAyHB0dYPejlmlOdet 1/wKtCh4v+HUdsMvXz9+4uJlLd/LnnCBkeHxnq3C29++ajx83tl4/4u4vh0aSRHVUcyLbULmMCj t2MoLAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Both full and short (abbreviated) command name versions of netcat
example are combined in single literal code block due to 'or::'
paragraph being indented one more space than the preceding paragraph
(before the short version example).

Unindent it to separate the versions.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v1 [1]:

  - Apply proofreading suggestions on patch title and description (Randy)

[1]: https://lore.kernel.org/linux-doc/20251029015940.10350-1-bagasdotme@gmail.com/

 Documentation/networking/netconsole.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/netconsole.rst b/Documentation/networking/netconsole.rst
index 59cb9982afe60a..0816ce64dcfd68 100644
--- a/Documentation/networking/netconsole.rst
+++ b/Documentation/networking/netconsole.rst
@@ -91,7 +91,7 @@ for example:
 
 	nc -u -l -p <port>' / 'nc -u -l <port>
 
-    or::
+   or::
 
 	netcat -u -l -p <port>' / 'netcat -u -l <port>
 

base-commit: 1bae0fd90077875b6c9c853245189032cbf019f7
-- 
An old man doll... just what I always wanted! - Clara


