Return-Path: <linux-kernel+bounces-876854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB76DC1C8CE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 46A484E6F80
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B041D354AD0;
	Wed, 29 Oct 2025 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tdoTTqrB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98D626B2A5
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 17:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759666; cv=none; b=H5n4n8cu3pxKQU3GdqB2nv6n5Dd8NHbfz/6v1zPYCls+8l3mluCjL1poXkV+KiDOIowd+RzRn6gzaHhwJrBdGCFbJkuC/QRQz46pruv+OeswgfxZVkOIczcw0UiEUtkGTz0m54RWM6HSgO3rlJljX6MwkiaPfUEkgCv5Y4+X9kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759666; c=relaxed/simple;
	bh=iPr8+Z1bwHsaNyPHs/N4eEQetvDlzmbe8TK2+r6mUk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iyA0IvcaRxcaDxFmI220i31zJe6nBxQTqMqSdLcWntR0Ob6fh6tvZNGck9REdzsBN9l2z+5wvRQWuAK7ielluIE76N5QUzVJ3dJAk7YOifNczXDwqPGH1YThC20EcTAAAPqHAsotypFMDsTjBmE9kzRyIUFKhIlRmPEqJ/qsKCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tdoTTqrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AC1C4CEF7;
	Wed, 29 Oct 2025 17:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761759665;
	bh=iPr8+Z1bwHsaNyPHs/N4eEQetvDlzmbe8TK2+r6mUk8=;
	h=From:To:Cc:Subject:Date:From;
	b=tdoTTqrBykeIDu/xpcw5kRMYvX8Qs8OL3nIpG7/EbzWnXeo6/nXDEy1+yHMP++Qa3
	 Qj2goPtSUDkjPjxa/h3QdNYEmeiGwm/d4v7TP0lKtzMWomTYSQ3YC3SB5UzdiSiTVM
	 n6/F9CF8PwwZ+ENRGLH1j5sCw3Jn/Gx3DxmQlUbwDq6FFVhoSXWyUcU4TP2/Q/DCut
	 Ov9lxmhAbVxnt2FqABqTv1RNEZ4rVI9ZSe1fUQW+TjnxkjTcRP8vCUp33dD0zH6c6+
	 6Buhwge9XeC9efuubO10f7vrAz6miLEDaNiVM6WcCK7G1Rr5JZ3GQ0hSA5DiBT3BqV
	 7ljgmdGmEgvOg==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Stan Johnson <userm57@yahoo.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/prom_init: Fixup missing #size-cells on PowerMac media-bay nodes
Date: Wed, 29 Oct 2025 12:40:46 -0500
Message-ID: <20251029174047.1620073-1-robh@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similar to other PowerMac mac-io devices, the media-bay node is missing the
"#size-cells" property.

Depends-on: commit 045b14ca5c36 ("of: WARN on deprecated #address-cells/#size-cells handling")
Reported-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 arch/powerpc/kernel/prom_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 827c958677f8..f26e80cbc615 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2893,7 +2893,8 @@ static void __init fixup_device_tree_pmac(void)
 	for (node = 0; prom_next_node(&node); ) {
 		type[0] = '\0';
 		prom_getprop(node, "device_type", type, sizeof(type));
-		if (prom_strcmp(type, "escc") && prom_strcmp(type, "i2s"))
+		if (prom_strcmp(type, "escc") && prom_strcmp(type, "i2s") &&
+		    prom_strcmp(type, "media-bay"))
 			continue;
 
 		if (prom_getproplen(node, "#size-cells") != PROM_ERROR)
-- 
2.51.0


