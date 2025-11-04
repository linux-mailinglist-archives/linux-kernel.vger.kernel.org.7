Return-Path: <linux-kernel+bounces-884668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA336C30BBC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 12:28:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3BBDC4E6E31
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 11:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77412E5439;
	Tue,  4 Nov 2025 11:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CXmDb5EL"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4C42D2488
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 11:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762255726; cv=none; b=pP9eoseai3gL9RJpc+3LF7N0yr0qBtAWz6fW+2RyRwJuIDkNEB5fE5B3xdJ9ZFcVZ28dC4Pl3MVkXjDCY9xCfyL/5ZqnLJG8YXO0CEtlDgEfrELN+H7w5Qms2xuYPSbdYIiCQI8WFbFv10rSEkA+14Nkf7ijMmHdaF+qw7xsdIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762255726; c=relaxed/simple;
	bh=zVzW848wcpzFwJAgPK/KarPXxlh9qHAQdW2+l80NgnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gKtlobz/MonoV+jut2/nJefdeQm3LPavEAtQUXKByx4C0ARulhrt3PcN1bLk/EeA0cOdFhkpDd9MunUBPdfirGeFmoJ3izAIuhrGZGrzg0Vug/yfRzc8VKdwFynY+0d52Jf71yuxgTX2C2mSLE7ezw6xmj7rehkyOaqn8lOCUN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CXmDb5EL; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-27d3540a43fso53407865ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762255724; x=1762860524; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CxdVni7d9zY7Eb56aBlMj/F4HouDx96+uAbwzp09kRU=;
        b=CXmDb5EL84gQ/j61XbCFXBC3X3Z1wXNRislpaN4E5p1nS3xwgmx3OIWy5r8XiMyl4H
         9ebKaKkksNoiZIrCJmUznF1SjaygeJwPrlhy/J/abwUiE/RUdp4KnleUtUKbocKeUSKQ
         ffz1u44jBeLJaoGl3TjiHr1gYUPjJVVRJ2VsUpEjBWMcpy4QJHki9D2kMvnNbjESUGMf
         LJxMSUBP535rCsc8HeBmsfxMtlRreat6vbUBPkUQG3QisBAOYpEz1WdAdV6DYCREV9yB
         Ef5F+EpbFNJFkM+MsUQy71N2NFeLERUfX6bAjzkZihiXygLSwPV5QNwaxK6xHGHpOh5m
         zZtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255724; x=1762860524;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CxdVni7d9zY7Eb56aBlMj/F4HouDx96+uAbwzp09kRU=;
        b=N5SmwAsYyoq2pGwOFotRn7dIWdbYBgYgMB7Is/P5j6bAtS3L+MkJ6J8i+kLULz5ChX
         HZaWjPQAvnNMJZNWgKshEADnenGXSW4rR99ImeyJ/oDF6WxLu82i/Yy8v1NKHje4Dy/e
         UgwhZgRs/vmbANVB/sbIo3ffQ5NT4PbTpGJEm7/0g6qcczzI+EzZm/7I8qVwvW2Gllg6
         nJy8VcTjF90jSsTZHhd7qBUJ5GokirbeJrto/8HUB/aYnFQllroGnkY6FWSPSJsjlR/m
         V5k7vRw5suP2IKHn8XpbAxAxUmFShZbqZLTDeaTQhgOre75agBdzThHepC6n6LGQZeY6
         5waA==
X-Forwarded-Encrypted: i=1; AJvYcCWt2ypKh0KC4U4OvpK9va70d7v3SOdU4FfRwVWYfDNF1FDjlH2ESYL1XO7+sMjBFMYVxMhIOMthyZDCbfw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+8jQboObEeSSxxeUbsUwsXqRQlbHXZXBUNtF/wd+q6SJpq9w4
	VLmbz75EHGbxVFvlPYZjwOllobCHmbIoeW2qDH6u0XJhK++7AXwabihM
X-Gm-Gg: ASbGncubA/tEuiQKL+ywcjMM1FeHiMCv8P+pIBiYmhXUUDj+r8HQTJcATUBlnInjYgg
	aW1B+RaeDjjzD9gf+likTX2JbEj2eF38L1IrFuxvgk3CO5UTDawX4V7NDJ4OoXnD+yCv34vebln
	PSvwXvlO1Zw/UUTeG3NhJWuNk71Pm8CVcLnzOuAJJmLwNs/RG9pZnRktfona6Q5SWJlHCj2o9Hp
	8LISPqNW/rhuBu1OEcExB9S34gkK03K6xsFcu69o7lrk6YTQxQBeihTXhn3DCbodGblgOulEyih
	2cFpSOD0VUj6eMB+iwD/20bPRmkxq6yXe3avU+GaWfUuQfuW+Rd3SJwid08siDCVqFTVIudDtHw
	FqPUdUKYVntYpa0u5XELEDfKJSxJVbhR1Gj/bwpowD6+Js/qNytf9s0TmeBFxcUFgVk8b9Ouhtw
	4d
X-Google-Smtp-Source: AGHT+IGuay4E3cOeIh7l443N7j7NEY6XyHAZjQH0TJBkBS2+aHXGG30+zXi+TgbVqPSIBrRWuFP+2Q==
X-Received: by 2002:a17:902:ecd0:b0:295:9b39:4533 with SMTP id d9443c01a7336-2959b396096mr101951295ad.30.1762255723916;
        Tue, 04 Nov 2025 03:28:43 -0800 (PST)
Received: from aheev.home ([2401:4900:88f5:503e:a1c1:64ad:7a99:42ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601a73c91sm23386055ad.100.2025.11.04.03.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:28:43 -0800 (PST)
From: Ally Heev <allyheev@gmail.com>
Date: Tue, 04 Nov 2025 16:58:36 +0530
Subject: [PATCH] powerpc: 82xx: fix uninitialized pointers with free attr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251104-aheev-uninitialized-free-attr-km82xx-v1-1-903be69f2cd4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGPjCWkC/x3Nyw7CIBBG4VdpZu0kgPX6KsYFwl87UbEZsCE2f
 XeJy29zzkIZKsh07hZSzJLlnRrspqMw+nQHS2wmZ9zOWtOzH4GZP0mSFPFP+SLyoAD7UpQfr6O
 rlY0JfbgdwjbuT9RSk2KQ+t9cruv6A4Cmc6F2AAAA
X-Change-ID: 20251104-aheev-uninitialized-free-attr-km82xx-00c4cb7c3d69
To: Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Dan Carpenter <dan.carpenter@linaro.org>, Ally Heev <allyheev@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=allyheev@gmail.com;
 h=from:subject:message-id; bh=zVzW848wcpzFwJAgPK/KarPXxlh9qHAQdW2+l80NgnY=;
 b=owGbwMvMwCU2zXbRFfvr1TKMp9WSGDI5H6dPmL776+tMe7e3QZ0318e/f3BxT1aTy5UIJemqh
 ycVdn3U7ihlYRDjYpAVU2RhFJXy09skNSHucNI3mDmsTCBDGLg4BWAi3IaMDK/fBt7uiFoRctHp
 gKHpwlnTvh6+MP+lUP/07c8D+9Mi5pUw/K80q9nr8unJ/96fl2tzkssvnrvyRmx28bt706pV2VK
 23mUGAA==
X-Developer-Key: i=allyheev@gmail.com; a=openpgp;
 fpr=01151A4E2EB21A905EC362F6963DA2D43FD77B1C

Uninitialized pointers with `__free` attribute can cause undefined
behaviour as the memory allocated to the pointer is freed automatically
when the pointer goes out of scope

powerpc/km82xx doesn't have any bugs related to this as of now, but,
it is better to initialize and assign pointers with `__free` attribute
in one statement to ensure proper scope-based cleanup

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aPiG_F5EBQUjZqsl@stanley.mountain/
Signed-off-by: Ally Heev <allyheev@gmail.com>
---
Testing:
Successfully compiled the kernel with `allmodconfig`
---
 arch/powerpc/platforms/82xx/km82xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/82xx/km82xx.c b/arch/powerpc/platforms/82xx/km82xx.c
index 99f0f0f4187672614f4f8ad46ab7906f7ad8078b..4ad223525e893c0de15540db2b2c4d239d6d841e 100644
--- a/arch/powerpc/platforms/82xx/km82xx.c
+++ b/arch/powerpc/platforms/82xx/km82xx.c
@@ -27,8 +27,8 @@
 
 static void __init km82xx_pic_init(void)
 {
-	struct device_node *np __free(device_node);
-	np = of_find_compatible_node(NULL, NULL, "fsl,pq2-pic");
+	struct device_node *np __free(device_node) = of_find_compatible_node(NULL,
+		NULL, "fsl,pq2-pic");
 
 	if (!np) {
 		pr_err("PIC init: can not find cpm-pic node\n");

---
base-commit: c9cfc122f03711a5124b4aafab3211cf4d35a2ac
change-id: 20251104-aheev-uninitialized-free-attr-km82xx-00c4cb7c3d69

Best regards,
-- 
Ally Heev <allyheev@gmail.com>


