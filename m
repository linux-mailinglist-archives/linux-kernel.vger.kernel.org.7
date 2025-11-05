Return-Path: <linux-kernel+bounces-886781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42DECC367CE
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:53:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EF321A42B72
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8C9334C33;
	Wed,  5 Nov 2025 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mD9Qs72S"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD10331A61
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357276; cv=none; b=lpCEzMh7XOEfgtA+OT5FKkM4uYF4tjZojHo2pFOeQhVmoH05MNYVnhHbZ8kKVJrpicLJR1Xwcxu0q9jbRK6yAnSuEiBKP4auDSIJvrzDOsoCru7gQZJw+DLZCaltCCLEHYnCMV6i8WpxGZ4njKAXPmZj8GuZzS0ihz9Ln07tjDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357276; c=relaxed/simple;
	bh=PThzuauyXOvfBI9hAjB6vjJRiiIbnpvmFGXM6f/WNB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FHdocjZ/SzV+4vomFUMmfXJX88oT6zbbiGSlL4pWqCFyOrwsuf1HzBs2bfPu6627CbX8biiuN+t925Lw/DyPo7qmXYQ3Uvom2grGi8BguwjtX+vREw0IHEM8EkFJh0PseZXSnCNn+udPzF+nTZwLChNCUKA4w+djn86AUicCG64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mD9Qs72S; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2955623e6faso45337525ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762357274; x=1762962074; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=12uy7vsDjw+12HaxKFe3uuy/jZ58Rald9WAyQMV7vtI=;
        b=mD9Qs72SywiyX4XM7irmNBoPp/S09S5cmaRX92MjrCgSl92jY6va3EfGEllHlkfKbR
         7PRhofTF54Xdet8TdJn2e/XcVKZuwtGkpQuWaeIaukoQjIqZ7dXZTYJm7+oiyZkqy8l9
         otAJBWsE1hujDPcEHqPvWLi6Wwie/iyPmJcf62HjQpLEZKn2ULqxnJAjvXaPcoXjl1st
         +aQTW/B2qUuPXoeZIPvEIIkfPo3/D6QHAly3ije/sAJB4xJF118xoK/spXjn06JjL5nZ
         YsDX/scWZh/9Ff9HeQmBDjn5cw61ZArdvR5KsJXu1JOXAIjYPpAqs8Cmg1a0cazuWZM5
         2BXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762357274; x=1762962074;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12uy7vsDjw+12HaxKFe3uuy/jZ58Rald9WAyQMV7vtI=;
        b=TTsvMaPqEDkJCY62jYQf/c5kDH3H8VROpqwZuShBMCyxahvJfmzKX2hCJSjs1+US8y
         r0+zQwnPwUhgeNH0nPNm5DgGNQiZkIA56zEfRFeklirSi2nSpf29KOR3LezWUriSUBVg
         ZajcIdTG8xW8K3BlOVFOidbHH52C5zTACVQesRPAibQhyYrNAoHXkPjba2hHxbmXn7ss
         kq2tM/ub4UbOdnv75hAgo8NdnPCqLvQoLZvidRqO02JkQ2XQcbtxYLhjkfFf+5DAbQEa
         Mt4noysSfXd0DmaEhOGXf/VPHZoYYyftR5Av/TaHuXKsEXvlCWSB7HmCc0e9SKNMvBGK
         vxgA==
X-Gm-Message-State: AOJu0YxCjh9heW7ueFzRUv85BofxfFbCzwyIf3EBqi/7d9jZ5lIMBsil
	en5EQz2ZQyb1kH3zQff6X18tIQqOTC3luQQcKOAcSilN+DjDpxiBGaMHvJP3boC/h7s=
X-Gm-Gg: ASbGnct4BS7Sk/Ofm46+qAMjOBrVp40B/iK5cGSxTuUWUTb8UGnOhKHJbU0IK0k84rN
	NmaztKKUu8BIWJmqFylh5chEKt2CC3qtkgSRhLStLE6wrVxMUh9e4sQSYJwfOImEVBjKzLIkWVu
	6s2kUTq19YQO66eM9wcnlAiaoOpSmcNOj3obYkwDJBdumU7KzfDI+c/MxtT/LXgKvY6dpTwH+si
	YSudR/mw+xjE66Vp1t4x8qifBQpGxHRwfay84oy4dqhNoAEo9hkP4QH7J4ehh5mTfjHus4nHM8L
	Cgv4bPVViUaSbxRe6sDDheLMa6QeCxkEM+nAryjlQ52Ia5FUvq7V+EgxW3/WxT49YakyQ7PAU9a
	1wAOVkfrklx7baggVMTV3QvGSQeI2nvSlkVMn6Yd1VIYAiDhCRMLobtong1ZOnSdKHAEGBKBo
X-Google-Smtp-Source: AGHT+IGJrn/ARKVxk46Gw+MyToDYmQYekIQN1nXZO3nzekAB1If7LRY2AIX8BMI4yDsZOgHrJhyoRw==
X-Received: by 2002:a17:903:32d0:b0:295:557e:746d with SMTP id d9443c01a7336-2962ae94286mr45793205ad.57.1762357273884;
        Wed, 05 Nov 2025 07:41:13 -0800 (PST)
Received: from localhost ([2408:841b:d10:e194:3d51:2b79:c21a:cd80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601b8f28esm66028675ad.5.2025.11.05.07.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:41:13 -0800 (PST)
From: Encrow Thorne <jyc0019@gmail.com>
Date: Wed, 05 Nov 2025 23:40:12 +0800
Subject: [PATCH v2] reset: fix BIT macro reference
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-rfc-reset-include-bits-v2-1-f27c57b75a90@gmail.com>
X-B4-Tracking: v=1; b=H4sIANtvC2kC/4WNTQqDMBCFryKz7hQnRoSueo/iIj+jDmgsSSot4
 t2beoFuHnwP3vd2SByFE9yqHSJvkmQNBdSlAjeZMDKKLwyqVi1R3WIcHEZOnFGCm1+e0UpOqNl
 1qtHak2mgjJ+RB3mf4kdfeJKU1/g5fzb6tX+VGyGh75isdSWNvY+Lkfnq1gX64zi+XDwVSLwAA
 AA=
X-Change-ID: 20251105-rfc-reset-include-bits-4ec72344d1a3
To: Philipp Zabel <p.zabel@pengutronix.de>, 
 Troy Mitchell <troy.mitchell@linux.dev>
Cc: linux-kernel@vger.kernel.org, Encrow Thorne <jyc0019@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762357267; l=1186;
 i=jyc0019@gmail.com; s=20251009; h=from:subject:message-id;
 bh=PThzuauyXOvfBI9hAjB6vjJRiiIbnpvmFGXM6f/WNB0=;
 b=TWKIdV6wqnHIjt+k7hfVqaOzot8kHD/7rMAwdDxoTBTYW7cpjx6R/dKzcY/YVkYjO67wT3jV3
 X3uZJ5rx4FcAut8K8km98QMagSCcQ71krd1B6VXxYAzwl6b3GdpkKWJ
X-Developer-Key: i=jyc0019@gmail.com; a=ed25519;
 pk=nnjLv04DUE0FXih6IcJUOjWFTEoo4xYQOu7m5RRHvZ4=

RESET_CONTROL_FLAGS_BIT_* macros use BIT(), but reset.h does not
include bits.h or bitops.h. This causes compilation errors when
including reset.h standalone.

Include bits.h to make reset.h self-contained.

Suggested-by: Troy Mitchell <troy.mitchell@linux.dev>
Reviewed-by: Troy Mitchell <troy.mitchell@linux.dev>
Signed-off-by: Encrow Thorne <jyc0019@gmail.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
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


