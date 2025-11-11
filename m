Return-Path: <linux-kernel+bounces-895774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75904C4EE24
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38D53BF5C1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 15:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D657B36B066;
	Tue, 11 Nov 2025 15:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4rKv81/"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFCC36B064
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 15:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762876220; cv=none; b=iE+VmLTZX36jgp+uSs1U/uPCvVgdWFaWmR0FAfaJUijepeelaYdWNl3jaA9VxOw8VyUXAxrvqhFH6yAlBZD6FLuWHfI2q07AsvcLzpiUApqaXnXn/trxTHdMYLwhMrYH79TggjreumX2vze3KkrW7mqgaCvJFo8jpCxP3RJ3h7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762876220; c=relaxed/simple;
	bh=DHlxEl4Cm3VRdwsbOA/YSIyQycDreMiqXswBc5rWTMo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IpvdXhOAY5BiVf39tf82bg8A9E0dMsRqqRGtcg+MBtFRiq4s9R918eLE+kbwNClscj7hwNsd2x1/2Y6yo7BSdnHmeRUC5Jhk0iYT0A+gt2eCh/AdLsmCqWoRJQnG+x8Ftisr/p+S+JwD3B7rLg8KCTs3kimGaMdkOxkoxKIRmgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4rKv81/; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-297ec50477aso7290145ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 07:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762876218; x=1763481018; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kwxwWH0h/k86KA6Lqbt4Xcny5Xif9KRZerM8f0+lE/Q=;
        b=l4rKv81/JX0GM6mncWXjrWkmY8XtAtwOHkFkeVsXXDSvDNhdrnHd26iM+8gOcPt5gC
         GPohYZFO16Qc9oUdZsSKtNpFktwtlrc+qHY/BdCsnrVDiB3BIJgLc/q4gknKfvRMT45f
         XQQAMN0Ahz6MPTKYqxJ9nzAQ2+019pdjfv0POpV7AX8ESgKgOs7mf3Vk3opaGDE8SvPu
         R/wGNTpq7+JOTqNXG/Dj2XclZxALV6XwWCztoy/hYTk/e3L6b9yaOVyRSVOrDQqWiw97
         T1paQva5C5UDXfCM7Krvk2h35zF9KRij/x9DuLMSGFPnrrtmzcj+nKoG/nB2XSiaGxhi
         p9HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762876218; x=1763481018;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kwxwWH0h/k86KA6Lqbt4Xcny5Xif9KRZerM8f0+lE/Q=;
        b=k8VjyBkAkzEINhyJo/G0a52CDctlUNJz89g0Oxxwh5WjNReY/6pLrEXeskCEP7f98V
         hRJ5YO2BBz0ffsz0qOH9EOGtOfYorRYu8JPmC3we36TlurSblI11Va7s0HT0pa098x5t
         qUfLTx7pPU7NZx3DypdiONcFnfClhoaS8oxhdfezPBR65ncX8ea1RLw60q7ZDOSYivvs
         uunfiNyHnZqKGJTG/AfWA2n8z23pBn15wgdyBCJZ61jFTc0GLxyidm1HzhOIgXgmpvNF
         qJY5MuR1wbF5pSQvlmZ6FPepOOgctZLwgTcCbV/zIJ/Pgd2ZBQKOnjKcxGK6G4IBthzM
         xOVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP29E7/IrGLjSsyO+FZXCKXouFT6l1JYRcY7ooA7ciSiwnF4QvRwt7YAbKiCfdmS9UlzMvPLXwNLIs3YM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVs5TvF5/Y8OHznhmkeeQfuBLnm/M7vc0eLW4tm9IkTONw9joo
	AlpEhJyX6pwjBq8doSx3hFminU5TG4leptG7oYVfjZ/8spKYp0xsiRuH
X-Gm-Gg: ASbGncsc0W1ioDFfvpa7Cfc0z7zek1y0qb7zBALLSx42LVSb5eY69U25o/4zFdQ3WH1
	1NGGL2/Mak1nMRqf9iv037Xb7tFl/rA++pKCBLBsXW5Tg3OisgceBuCNODJ/iWO4wypcGvAo2qT
	o0cXCiRY6KNBMm98NevqgdUvVwqqwfkbQUGrlfXqUq1nW6HaznAKDYYhlk6Th+RU3JjwxkkDnQR
	tTLfWuUu0nkStAHXhFZiEXyKWrz/5eNuI5s7KwS/FdMeLZwb83OUuLvZr2VIdgg8NptJsKOTZiU
	oBEZ1i8DZjv/GzUvO6YbERGHIGGVw5iCr8B0dJbH1qQY8+4qxzstTNKd2oOE8YD1JFxFBVkIrby
	DcdFerGsRkG8cD0cNNs+5Q+QzRkTxV1CLtxxvZtWqm44yAhGWabal70thq33FO4iNyZAzrcfJ1+
	g6ew==
X-Google-Smtp-Source: AGHT+IFUeZ86WNREaY3JnN9DeD2rSCTPmqw3Crt4HqqKMYEinhAe5X1WLVaqt8s1Jagy5zo/mu0g8Q==
X-Received: by 2002:a17:902:fc4f:b0:295:55f:8ebb with SMTP id d9443c01a7336-298408213e4mr48838695ad.21.1762876217391;
        Tue, 11 Nov 2025 07:50:17 -0800 (PST)
Received: from localhost ([111.55.24.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbdb09fsm1087615ad.17.2025.11.11.07.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 07:50:17 -0800 (PST)
From: Encrow Thorne <jyc0019@gmail.com>
Date: Tue, 11 Nov 2025 23:50:09 +0800
Subject: [PATCH v2] clk: spacemit: fix comment typo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-b4-fix-ccu-mix-typo-v2-1-d64b97b48d1f@gmail.com>
X-B4-Tracking: v=1; b=H4sIADBbE2kC/22NQQqDMBBFryKz7pQkatGuvEdxoeOoA9VIYkNFv
 HtTobuuhvf5/80Onp2wh3uyg+MgXuwcwVwSoLGZB0bpIoNRJtfKFNhm2MsbiV44xbtui0WVFqT
 LnlNFGcTl4jh2TuujjjyKX63bzidBf9Ofr/zrCxo1UtN1bZoXim9ZNUyNPK9kJ6iP4/gAIVCcB
 rYAAAA=
X-Change-ID: 20251028-b4-fix-ccu-mix-typo-038c19fe30c4
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Yixun Lan <dlan@gentoo.org>
Cc: linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Troy Mitchell <troy.mitchell@linux.spacemit.com>, 
 Encrow Thorne <jyc0019@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762876212; l=1164;
 i=jyc0019@gmail.com; s=20251009; h=from:subject:message-id;
 bh=DHlxEl4Cm3VRdwsbOA/YSIyQycDreMiqXswBc5rWTMo=;
 b=y7lORg16U5lsvcS9/DoSo7mwT5fo22eEVpj3gCoSuWbYgbLul4lhSwzA8UAzZmSxgvPPJorn1
 KMkTZ/dZIi5AGLNsXQ9FoACulckMazmMA6jsBicgtNXnh6nT7N+o4BK
X-Developer-Key: i=jyc0019@gmail.com; a=ed25519;
 pk=nnjLv04DUE0FXih6IcJUOjWFTEoo4xYQOu7m5RRHvZ4=

Fix incorrect comment to match the filename.

Reviewd-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Signed-off-by: Encrow Thorne <jyc0019@gmail.com>
---
Hi Stephen,

Could you please take a look at this patch for inclusion?

Thanks!
---
Changes in v2:
- Simplify commit message.
- Link to v1: https://lore.kernel.org/r/20251029-b4-fix-ccu-mix-typo-v1-1-caddb3580e64@gmail.com
---
 drivers/clk/spacemit/ccu_mix.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spacemit/ccu_mix.h b/drivers/clk/spacemit/ccu_mix.h
index 54d40cd39b27..c406508e3504 100644
--- a/drivers/clk/spacemit/ccu_mix.h
+++ b/drivers/clk/spacemit/ccu_mix.h
@@ -220,4 +220,4 @@ extern const struct clk_ops spacemit_ccu_div_gate_ops;
 extern const struct clk_ops spacemit_ccu_mux_gate_ops;
 extern const struct clk_ops spacemit_ccu_mux_div_ops;
 extern const struct clk_ops spacemit_ccu_mux_div_gate_ops;
-#endif /* _CCU_DIV_H_ */
+#endif /* _CCU_MIX_H_ */

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251028-b4-fix-ccu-mix-typo-038c19fe30c4

Best regards,
-- 
Encrow Thorne <jyc0019@gmail.com>


