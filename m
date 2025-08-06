Return-Path: <linux-kernel+bounces-757720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A1EB1C5E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 14:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72A9C16C932
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B12A288CA4;
	Wed,  6 Aug 2025 12:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzRmpctb"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33015274FFE
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754483575; cv=none; b=G6WL80KuD+Ht4hOdxsedgFcM+HxvJY/rSsJbwXF9hc+mAwstJbPILvd3qy1zJe5Kv9KWH/p87mootu6RtQ6SrkUjYLLpT4w0qyGuYPXxg+8naqEcAOhDy6C7QbWFHXKWvu320hO3lEPvRp5MCUHAAb8MGCWn4AYCtQodLM6Q6lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754483575; c=relaxed/simple;
	bh=woHaBmwifeMRsO88QscZh4yINz3uaj5h+XcreSBQlSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MH49htn2utPtBODdTUdvTrAdtkyOr4xI4PF/5iRR6BMvSDHPe88IxmDwl68IBZPK3Lj4Usj/oUYJqBhBJg92sK1ipCwGsRdTgE/onRTGwrCb131nYxE1Fxj+u2h+TPRScXgz8Mb/m1HmH1fuHb07LfYyfFt7rwUceVRUxYqcTt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzRmpctb; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76b77a97a04so4403045b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 05:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754483573; x=1755088373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CHIu6G28Pk4SOSDxdrkK1OQmPtaJttmCNLhq9tiQ5Do=;
        b=lzRmpctbpDyeQkl6ygCTKWtaKCLDU+bJnc4BRuGqjaV3I9/IRaYp0UpXHH0ocVJNbe
         AlJaXvBf4JmA6gq9t1CxjeuyJbpPz1FQacMuuv+8MQjk6lKIq2Yvp4Rg67cB8dttQlzk
         DuY1lern0taAGJ9nJBnL6ANAOmFdcTObKm81N2jILDmBip/0sQqZO4suVT+vIAhpJY+D
         e3uhrO8GqNaEkE2COQt+Tkmm7pkMlG29v/2cyyN0GJNdHQiAa4g47BRvq80F7umj89Yt
         gAw7fafnioxZFqf7qVxy5ChaZz1HkXIxeCd/qqOjaPbQVe/8tmscmo6r6sxO9GZ55c9N
         R7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754483573; x=1755088373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHIu6G28Pk4SOSDxdrkK1OQmPtaJttmCNLhq9tiQ5Do=;
        b=p79EuL9TsdLU1qjZOZNyAlhmJUaDVTn75+yvYoiFFTJZqYnpjapoctUQZUu2QsyXgZ
         hYK7S4ZNiUH7ZiX7VRRUBDpakn3U4FBNK7+jqqCj2YaOPNsYC0PW45jGV4/e1IjKVwCn
         S5V6a7Qqvj8U0tTAtZp0QdPwx5SD8HZf5nJ4/cTtpA38FQ5qxsDODVnZlz53YRo12151
         9QsYSPRIuD8zM4pQOUat+JsptcMKzMjwyMt1VGsaXiwcRFkmIOashOXRPxaT2NUekdjo
         NgHqrHPlB6TlI0sWcEQ1YAha7IzH6g4ieKUczfpUsXwf5U13bf3n2/mee75HTIVh+Vb5
         p2JQ==
X-Forwarded-Encrypted: i=1; AJvYcCUK0Me2CZ7pj9LRSUPlbJWdPFsV9xnmtS1WekcWRPs/uXlCGNZicIODul5U1K/Q62W2kv02uR836CFiJp0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzp20FGK8IrY/z3P5/mIh8Yxq6fpe8cy3YoFF2gDcMCWquhegs
	ZW3IDQuKVOVAWNyxKt9L4pnZBL07b26mFiobELchK34UYihUfT+c++rA
X-Gm-Gg: ASbGncs/nJKVoQvqlKuRIAQTEMVUzIk5fOzz+coyDbFRNAWUQSAsRkBUqt9b+nMDxvq
	oY7pdSJZN1waQ8yZjmoEfQgw11qB82I2UaeG4LResUhWKIbmBpqlc13dZwTI02ODDzYb4mgV6nZ
	HODEwNJI1HBErqtlhcoka/7DzgbP8830HItBpL1Z3LnmWQj3Nnk4SrAnPqvjXxkf/TuH9Cv2QtW
	h+M386AsOGKGOdUxl7XJPskCqWKd7N4caEMg9cwDsLXDmTksrg0aONysAuXscG/IEux/JnhiXDE
	ryguMqxbQDlIdonwHlNqmpB5XLHgDLahL/oUOVkAdpzghd8VlJ7mDHUHvOlD8EmLOd1Gv0Qy3uG
	NUU2Wwf3ZNrSkxxlpqXrwTBiaEj25Ih4=
X-Google-Smtp-Source: AGHT+IEuyhH9Ap2y5cyWh/2VBI+sP2iOnNJmD/qT0hpDjCW5rg7drATMI2KtDBa5ttCnjW1bOkPpfA==
X-Received: by 2002:a05:6a20:9392:b0:240:203d:42a with SMTP id adf61e73a8af0-240330c2bafmr3531003637.21.1754483573210;
        Wed, 06 Aug 2025 05:32:53 -0700 (PDT)
Received: from localhost ([61.152.201.176])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b422bb1133fsm13619878a12.56.2025.08.06.05.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 05:32:52 -0700 (PDT)
From: "mason.zhang" <masonzhang.linuxer@gmail.com>
To: chao@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	masonzhang.linuxer@gmail.com
Subject: [PATCH v3] f2fs: fix CURSEG_HOT_DATA left space check
Date: Wed,  6 Aug 2025 20:32:36 +0800
Message-ID: <20250806123236.4389-1-masonzhang.linuxer@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix combines the space check for data_blocks and dent_blocks when
verifying HOT_DATA segment capacity, preventing potential insufficient
space issues during checkpoint.

Fixes: bf34c93d2645 ("f2fs: check curseg space before foreground GC")
Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>
---
 fs/f2fs/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index db619fd2f51a..d8dae0049b6a 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -649,7 +649,7 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 				get_ckpt_valid_blocks(sbi, segno, true);
 	}
 
-	if (dent_blocks > left_blocks)
+	if (dent_blocks + data_blocks > left_blocks)
 		return false;
 	return true;
 }
-- 
2.48.1


