Return-Path: <linux-kernel+bounces-865530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC8ABFD533
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5D10188FDDA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB651286D60;
	Wed, 22 Oct 2025 16:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="V/GnAKqd"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C5246795
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 16:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761150969; cv=none; b=mAbDHbbYFXdfYhiTYUgackHTni6F+mDV9uafLKy8Xh01EzdvNh16jdiLEBmn5KTh/57V3w3DZm3pE5ePWECewhGH+e/P/6UUfhwgoELxGDkg/ByjTttm6e/9KRjVnSgb7FNe1gxxxA0gwWOLdJkGBgEHbUSUwlfLJGtiEGuXyts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761150969; c=relaxed/simple;
	bh=WEp0i6nUj24r4fdAM3/hWH3sfjwDIwL6W+mOF4+TX6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o9NI2RMayMNQNchzQMLCW5oWiDmbRfUgbX/4yHn+zwGhyFI2pAG1IVLrytRJRA5yr4x/4DUP1tLsikXslVNeh03iE5GWJyb+N3gtkKsQSi5HX55fHLX1quFldO23rlFrMcH4JzcluDp0yuZmwxJ4xp4jFS65cb+o1FnrD82umm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=V/GnAKqd; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-269639879c3so66641625ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 09:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761150963; x=1761755763; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YwecGbA01jSIHkfKfeaE5nVwSDYL/I3dch9VA9Sw4zQ=;
        b=V/GnAKqd09UMtPp+9EzPD5HC0pp7ipYvG6hCFHtyWbz9FZtBFNpPRnK20X6koGTtx2
         vNmKgh8hUX+bKwkNGXUwXzkavB8YOYGLMYx8VsltgKZeZcRdJF4SMqaT9Cul64sozQJH
         qIFJQlIdRt5bHkSJNCoAmxz0UE/xr6eFoxpzjZWOF9gtK9M56FiJvNyty3cukFu/+l3o
         LNDSkavmWi4mp1TesQcWy3Z7mth7+9HHAm2L/qJSPBOYGR/9lUqk7xhTR/a8Ih+mLutK
         EwicAcPGnxIokAZOBZ7aNv5wdwvSs5x8C/rLPrA3sb0pm2CQvVHextEG0gtunDQQxRMu
         XuvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761150963; x=1761755763;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YwecGbA01jSIHkfKfeaE5nVwSDYL/I3dch9VA9Sw4zQ=;
        b=DUdXMTFOJf/mB/ORMWDGD0OgKqmwf8/fhl/Eh6FUOcQFU24Z7OheegYHIXX6kIyKt9
         oJTjdlf3KauJ7PMOnUL/qIszNRGiMgh0eqKTwQkh6A78Ow4wTuB+ieOsLhf7teG+ALZB
         7m7rKTND33dk94V4qyPc/jkGjoklN+DgwyOgwpWIBGk/tArI3Pm41e2MEKlGZAlyIqn4
         1h/8XxSaBQTat5ME2HwQrlp07YnhEY6D5hJ9XJFVhIKrhXYJ7KV7KloW/NcdHfzz5W1T
         vl0ZPPOvmumcMgxL1eF/ELkfwhoAs0XlrHnN65q7Y8ug0VwHA+P8K0shr990HRHRY7g6
         gRvA==
X-Forwarded-Encrypted: i=1; AJvYcCXTMFigseemLk5I2ALR7bZRpWUjkvMZeG0rgOD2HOB/Bldtk4dBMyl6EUN7cWOxrgLK2RWnmCq9YrAsl3g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye9W8i3I+ej0VFexB4Zcomd8jtGFzRtSMmwFpZM5IkmotlRQCJ
	ABplYGQEcSTbsKdqCAZYp5CKMy8LfEKCE8+gEKByC8ycAxEofCMDcdoS6oQWIv6zGaY=
X-Gm-Gg: ASbGnctDjeL/vwAolQMw6AMJM0JYKD3+wPTGaTi2UNfaeO3quOYufL0YZDKuuYUmwYI
	R6YVYmN/cNhxbDonq5xl59LDY/fZ4KUwjvJhKQfPR0LxJg00XWgnzzz9aoRYbIUmppxtk29SmeM
	1AOz4V3vw7G7KG9MtZgZsklxblbIz2JdxbxexoEHahN9E5QihHI1/0am2cQf+UiLEI9uP/r7LCZ
	CzGK+R1n2uy8UvDqPk+/jsQgLP7O/AQg1+jU6BNtyYS59WqFKjNNe5NdolRaM796QsPladUUrP1
	ZQO5y/01rEvS1AeU9zUzcAKxWC/l+TitYkJX9fkOuFWwzCvIgOSOLR7+o/ykv+CkK5LtE+/1V7E
	7XGsaz5hJT2QowGZvtHFDSiGRN6bvyA9cOzY21B7i2f2M/wGsV6WEXedqr6JNx3z0/A6zO8bfkE
	/81ISmgDT5vLk=
X-Google-Smtp-Source: AGHT+IHaeP9A14zUB0muZVyyLtWP3umHacbDkVX9TJrKOLE0ui4bf8Z/gLJxD4LKOyyJ/NbyITHklA==
X-Received: by 2002:a17:902:e88e:b0:290:a3b9:d4be with SMTP id d9443c01a7336-290c9ce63cbmr245700855ad.24.1761150963198;
        Wed, 22 Oct 2025 09:36:03 -0700 (PDT)
Received: from localhost.localdomain ([49.37.223.8])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29246ec20a4sm143398945ad.7.2025.10.22.09.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 09:36:02 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: ecree.xilinx@gmail.com
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	alejandro.lucero-palau@amd.com,
	habetsm.xilinx@gmail.com,
	netdev@vger.kernel.org,
	linux-net-drivers@amd.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] sfc: fix potential memory leak in efx_mae_process_mport()
Date: Wed, 22 Oct 2025 22:05:22 +0530
Message-ID: <20251022163525.86362-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In efx_mae_enumerate_mports(), memory allocated for mae_mport_desc is
passed as a argument to efx_mae_process_mport(), but when the error path
in efx_mae_process_mport() gets executed, the memory allocated for desc
gets leaked.

Fix that by freeing the memory allocation before returning error.

Fixes: a6a15aca4207 ("sfc: enumerate mports in ef100")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
 drivers/net/ethernet/sfc/mae.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/sfc/mae.c b/drivers/net/ethernet/sfc/mae.c
index 50f097487b14..15d4af6c1bb9 100644
--- a/drivers/net/ethernet/sfc/mae.c
+++ b/drivers/net/ethernet/sfc/mae.c
@@ -1100,6 +1100,7 @@ static int efx_mae_process_mport(struct efx_nic *efx,
 	if (!IS_ERR_OR_NULL(mport)) {
 		netif_err(efx, drv, efx->net_dev,
 			  "mport with id %u does exist!!!\n", desc->mport_id);
+		kfree(desc);
 		return -EEXIST;
 	}
 
-- 
2.43.0


