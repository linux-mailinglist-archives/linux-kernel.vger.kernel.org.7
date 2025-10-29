Return-Path: <linux-kernel+bounces-876031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E85C1A8A1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 563AC568108
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 12:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC39923D290;
	Wed, 29 Oct 2025 12:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFnF7gfN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F2A223DC0
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761741062; cv=none; b=PnRO04DaXz7gIy2fe9NmQ4EPIaldhB/I45gXg9MVXjWhIAuBh+5Vx9lKZUZ2I+5yDmDlOOgwzqvz1cwG4L29cChoPg1LzkZMlWJmvRW2wFD1Pobs8e26tIHLSR3UQyzUl06IG8XFT0mm0BtBeDOZQodcAiKvhdfKYGATGCOLgZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761741062; c=relaxed/simple;
	bh=0wU33jQD//uWKiP7ZOKBsLlRKigCgGy8GmSwIy9R/bA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gn6CfgF44Y9LcbAowX2E77QwjxCvkG7Ly90mzslZmoLS9jOpbvv8yAA1Kjv1CFqsqMhh7J6daA0EUts+lyXVfsXZI8NiEaaFwtWFzI+ENh60bZRqZHNcEWVsbMTDgGx11mbOy/Dj93Ngt076leee5GdeNk5BiDTs+7Wrdtpu9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFnF7gfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B78C4CEF7;
	Wed, 29 Oct 2025 12:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761741060;
	bh=0wU33jQD//uWKiP7ZOKBsLlRKigCgGy8GmSwIy9R/bA=;
	h=From:To:Cc:Subject:Date:From;
	b=sFnF7gfN9Urn2PNYTabLD4IPQmkzzbeR9H4/ZQtF+3inRjmiloOcfOy6UKk+cXkSq
	 HHKvtOr1beNoieNKQ78BYmqGSykvosbLYiiwIckG4ur2pbosY3aWNyh/sO1XRWuuvG
	 gd++NoMp4TdEAmlrJB6OVylFFaDmbWNJBwxkV9qmvTifdpR2GGLnEWsvBtRK0AsGOT
	 hA88lWazy/emr44iKmQqAi4tTno01ZiEECF4pprliPSRITqvJO+Kg0Ia1FBXlNeSL6
	 aawfFxyzlDUXtGj4NfmH/Sn2aVfuozHnBhWE/zk7BCEyQHCZe7HaSaVhvzgl/xea2o
	 QYySxE1uyRa6A==
From: Borislav Petkov <bp@kernel.org>
To: X86 ML <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"Borislav Petkov (AMD)" <bp@alien8.de>
Subject: [PATCH] x86/CPU/AMD: Extend Zen6 model range
Date: Wed, 29 Oct 2025 13:30:56 +0100
Message-ID: <20251029123056.19987-1-bp@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Borislav Petkov (AMD)" <bp@alien8.de>

Add some more Zen6 models.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index bc29be670a2a..8e36964a7721 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -516,7 +516,7 @@ static void bsp_init_amd(struct cpuinfo_x86 *c)
 			setup_force_cpu_cap(X86_FEATURE_ZEN5);
 			break;
 		case 0x50 ... 0x5f:
-		case 0x90 ... 0xaf:
+		case 0x80 ... 0xaf:
 		case 0xc0 ... 0xcf:
 			setup_force_cpu_cap(X86_FEATURE_ZEN6);
 			break;
-- 
2.51.0


