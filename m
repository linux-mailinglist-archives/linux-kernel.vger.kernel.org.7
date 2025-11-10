Return-Path: <linux-kernel+bounces-892422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BD8C450F4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0AB3B052B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 06:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2B922A4E1;
	Mon, 10 Nov 2025 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CuhWz8WU"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822D09475
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 06:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762755071; cv=none; b=hiOKjkCb+oojCGDCL5+JCi/Gw/ATn1GJtbhovn8GyrI8K7XDy78TmxA4t7bvku5mwQM7bCZ97Z6hlrj237FJo3L83qrCrSLIA2hdZWcBcf/G4awRKDrSkAnbQ1LgqTDJO+SXbEk2mG4CLTbVBzr6OlBOVdT3KH6TOhAy2EGCVMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762755071; c=relaxed/simple;
	bh=kn7bWMOD1w4Il6cZ+/+8OIjb+KNu8oGX9vG5kAdhzKQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=diRsPQ5T5RgZZ7pKnZAlBvDSTRqJNUlXcspkmew+2CN1BPp/Z/vU9wOFA719sJtHPWSWHqyIpSJCHGWR8aeiIHI/z00MEmx6Kmv8U5W/OL74yB7eTw4xlsQhKgnOfPGRtlToR8YehwANZGUkhc+gXOSsO2YSpcJr4J8A8bOGZDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CuhWz8WU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b679450ecb6so2066555a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 22:11:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762755064; x=1763359864; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lm2jnslt3Rb7Zmho9VIECUwBmVAIkgs9O0pQrldOzUQ=;
        b=CuhWz8WUmf5xKzHrEG8cGqHEWQz8O3yNldaXHpPxfrh6/fWspRTawweuzYB6U9eqqD
         I+tiRcNxJ0gV4/JGcUJLeQHkyQtObmE4OoJJ0eQVBSbQeilv903vnYWNkTbEBPxXfkRo
         Hu37+uMM7SLVy4iQZnRO84d87sm72So3/NfCIlfAhuA7JNubHiTI6Lg49dxpXeAaIDYO
         Y2EkMPHdbzTNAEGAwmmAmmzpoDsjtDErcx4pKytAnbNVB9ijpniqw8u7D/uX14zPhrKw
         fiYXg+5hukCorzY+Ii6qT5BRfVi6co2+XMNlWW+IMod1+P6C+f/gcO5kJhXqSUISBVFx
         P16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762755064; x=1763359864;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lm2jnslt3Rb7Zmho9VIECUwBmVAIkgs9O0pQrldOzUQ=;
        b=FPpwHsuG3+tA7xA2oSZfYK9Msd4rU3yZZ//tyCqIl49tXvg4tg6NjLWA+hwgHnXJgI
         +HJUAlNxu4w0fGXSSkMcJH50Li2GGu5N3bl+BOK1aJzlMWJykPhAvPpINHaoWWIEGSJW
         fF58UTOrPmt3wv8tEEIxur1M/GPUjdHnBCnb0m6VZJSty3UYIkjQq3BE7w49+VK1KoTI
         UBoweGqmG5KIUzHsDNSz/o2fRp/hAB70ZIaT+o1SDXvHVNX1uxYLbg5WFQdazQk3ncHz
         DnC6ncKqVFt0ztxWEtUADS9HdnmfAoJsYfUZIvwPXDsVsvy3NxiJ7h9SIQjIM74+HaKT
         hSdQ==
X-Gm-Message-State: AOJu0Yw7ygfyaWr8jSIxd1Sm1F4ziHuLEFzsep9a7WPZcEp1+ZqO6VVI
	h4Canj/zjekHSBsahYwhpMHszg45AdYoIMjv+qP3eJJXMIlWSTU1d9CI
X-Gm-Gg: ASbGncsKXjfSz2x4iFHtPLJcDoY0ClkkVeFM5yTC1R6lmt95r9wPI87OKV/qH/GenkM
	TF9qvbdop166Bw2LxKpamLWY++cCPaea9XF/qvFsU8vPpRz5rPUfeceyGjktY+7FxeFHe4hZzkJ
	Rz8OtassmRrsjZBo4oc2sYsxG7WVBczow4M6+DjQAC1FGXxuxZmT1HxqwGp+CFsYfzJ7O45caYM
	mImAHoWHsd0GeYjeC9/HAjzqB+LRsSM56xDMC9tU1Xh8S1wyZd1ivR1gko7369CKH8Gr0YBK+Qz
	ndLfZWL0skVzc1uviPT9EzgeCExiwI3VlMQB6JTVjaq0rBXIQ59SKt+xbCXx7hk0hrazllDcAg7
	rYeOvgIV/ZXl40acMbc63jPKtgPR3pyNIT/nTr4XOfTJAzkRnA1DZys22dlhXSJ+h6r17RV1i
X-Google-Smtp-Source: AGHT+IHMrL7oM7MbUgXsz6PpnwSGEtNBy0/tjXziTJLhpBmiF1bAtTotF1PSodiPyR5ul8CseM+lbw==
X-Received: by 2002:a17:902:da4d:b0:297:dd30:8f07 with SMTP id d9443c01a7336-297e56e127bmr97197115ad.50.1762755063528;
        Sun, 09 Nov 2025 22:11:03 -0800 (PST)
Received: from localhost ([2408:841b:d00:77aa:94d1:35c7:872e:dcbe])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba901959a47sm11206095a12.28.2025.11.09.22.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 22:11:03 -0800 (PST)
From: Encrow Thorne <jyc0019@gmail.com>
Date: Mon, 10 Nov 2025 14:10:37 +0800
Subject: [PATCH v3] reset: fix BIT macro reference
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-rfc-reset-include-bits-v3-1-39614338fd43@gmail.com>
X-B4-Tracking: v=1; b=H4sIANyBEWkC/43NzQqDMAzA8VeRnpdhq6Vsp72H7NCmUQN+jNaVD
 fHdVz3ttl0C/0B+WUWkwBTFtVhFoMSR5ylHdSoE9nbqCNjnFqpUWspSQ2gRAkVagCccnp7A8RK
 hJjSqqmsvbSXy8SNQy68Dbu65e47LHN7HnyT37U8ySZDgDUnnME/rbt1oeTjjPIqdTOo/RmWmV
 Qa1cUbbS/nNbNv2AdVtVpkDAQAA
X-Change-ID: 20251105-rfc-reset-include-bits-4ec72344d1a3
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Troy Mitchell <troy.mitchell@linux.dev>
Cc: linux-kernel@vger.kernel.org, Encrow Thorne <jyc0019@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762755055; l=1297;
 i=jyc0019@gmail.com; s=20251009; h=from:subject:message-id;
 bh=kn7bWMOD1w4Il6cZ+/+8OIjb+KNu8oGX9vG5kAdhzKQ=;
 b=/2zhvMZNvZM7Lw68Xq35SJQCg9YliTKFKWru7VI+d2qiAMdjCz6rhb3eftKFD4r5Bu8hqHCj8
 j4O1xXDwRVkB/XyTwjvfJnXa4/exTQkWOwlGfekz3NwuFQre5l5lZh5
X-Developer-Key: i=jyc0019@gmail.com; a=ed25519;
 pk=nnjLv04DUE0FXih6IcJUOjWFTEoo4xYQOu7m5RRHvZ4=

RESET_CONTROL_FLAGS_BIT_* macros use BIT(), but reset.h does not
include bits.h. This causes compilation errors when including
reset.h standalone.

Include bits.h to make reset.h self-contained.

Suggested-by: Troy Mitchell <troy.mitchell@linux.dev>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Encrow Thorne <jyc0019@gmail.com>
---
Changes in v3:
- Fix commit message.
- Link to v2: https://lore.kernel.org/r/20251105-rfc-reset-include-bits-v2-1-f27c57b75a90@gmail.com

Changes in v2:
- Add header in alphabetical order.
- Link to v1: https://lore.kernel.org/r/20251105-rfc-reset-include-bits-v1-1-d7e1bbc7e1ab@gmail.com
---
 include/linux/reset.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/reset.h b/include/linux/reset.h
index 840d75d172f6..44f9e3415f92 100644
--- a/include/linux/reset.h
+++ b/include/linux/reset.h
@@ -2,6 +2,7 @@
 #ifndef _LINUX_RESET_H_
 #define _LINUX_RESET_H_
 
+#include <linux/bits.h>
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/types.h>

---
base-commit: 8fec172c82c2b5f6f8e47ab837c1dc91ee3d1b87
change-id: 20251105-rfc-reset-include-bits-4ec72344d1a3

Best regards,
-- 
Encrow Thorne <jyc0019@gmail.com>


