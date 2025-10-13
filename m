Return-Path: <linux-kernel+bounces-850283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C76BD264F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 609FA18951BF
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FA52FF168;
	Mon, 13 Oct 2025 09:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GygZDbCz"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F1B2FF15A
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349297; cv=none; b=tRyC8sKMRwepN4WWhDGk2BnOTf79hrhsnYH9grQBDdFtlAx7QJA1SREBClekbtvzA0wtuxzRlqL08nWtIyZs8i45oTouAwnFpRwfpaNo7nLSRSUXvq3fNY8mg7Rdn7nozQnjB0aPn1lgK1S8Ce3UOHdY/5eTYoaiQtRSYVIm+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349297; c=relaxed/simple;
	bh=135EOhoKTKFqwmoxLeVvMWCOwk5PnK2lNA1ueQEBRko=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HBJZhvGWXKOb7JqHeQb2cLE2gqgpYnYrDQZlrfSEPYuQMXb+nqSuYgGX+ETo7J9RUb1tgo6ElwTCojgNTuH+hxFMilHKxO5iajQHKSGW1q3kqX0x1JjzLfJbzNt3qf/MBv13yxsbsjp7OscboYL6w19DdQMJ21e4IkDNlPvvFDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GygZDbCz; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78125ed4052so4771342b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760349296; x=1760954096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1XBTCn0qOLXBNC2zwAF6b8+Yyipiu86tjZBownPcTO0=;
        b=GygZDbCzK6vE6txljvNPxQjYxdgzvscY/znuMmt0a8HxSDSPsR3yF+g6qHB3VvYQtp
         6LpEWEK+FzE706ZQEFFpT6WnP3wGeeMXVrHDgPR6nyL8WntxVHN5EDZ1Q8lRKbAnKmpD
         /gEb7JnpZPUvxx749+K3Jj42AYG3YyPzEK38qh4gXvf+beiJ8TcoiZBYRHsTFpajHAaz
         d2NKWOEwE+5tVk7lXopcty6Rodn6TnTuT1NoNb1+bXaFHeqNCDXb+aZ4uRUK+u/Jrrtx
         lTo4txFVdAh7VqgYbCO/P2VbgdZriTyqzfpRuT8BWnKQTMqZtPErn5MUEP4z2zKV1NcF
         Iyyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349296; x=1760954096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XBTCn0qOLXBNC2zwAF6b8+Yyipiu86tjZBownPcTO0=;
        b=o+J7CGMsjd6pxN8DfhnWE265h1oPjBBeVQTynRNAcQgxqNbojR1LB5oUgJS1aY1leS
         Ac2HbntbYjoEJvawJAfV9ma3NS0DGSV6IZ+N/8rtyAFBoj2xYyNV3BvlNPcUNHu5Xf0Y
         K6afqIYZPvV4FTPHJAjyjLuWlDbB5XxX/6G6LRberujjnaUjsoFd+Yxxu20ydexf13Ae
         BOpwRe+ADucHDfXjjjU03Lbijlevxt62lDFIaZ81BIGgTN8ix4yYzxbMd6/P2NkU1Mz/
         TZPVXd6bU3526Kd4E2cxUHtSauNmhlPBWm6kWMqrx+bIfDKrsnr2EV8BAUeoP0YrHXwd
         m3eg==
X-Forwarded-Encrypted: i=1; AJvYcCUwJD8w5U5mAkszKV9EpqnIFuxzW+McKPhmGvuVwLCpp0GQuHm8I2oR2LXUU0KVg7+LYgrqFMCDpObDiX8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn22cEAzn7QWxRjVBb3XxklxKMfZh30wjwMP2gcgm2W0k5RpFJ
	lupKiu5ivUaKLzRSwGUCRSalWRWgHkhizVKJ/zFRuS1p6Jz4irFFDlRA
X-Gm-Gg: ASbGncsn7xSz2LjTiZUXP3Af2EsaBideVgkYD4+bNkP0Z1f6/jyrPzIrpxMahHDK74g
	a4BsM249YiDy2FT6HfbMYfn/3yJyAcozFcEVndOru4xkbh0V6qnuA7ljiVSCz6vQLwmT9BifyPE
	ElOJkERRaeat/2Zo0+Li4y1X07oND1eQ/G8kPG3aOyIYE/h3Nyz3prqz88TNCl6KuWkmns2W4Ig
	Vr2IcBKxvlhvafbaW0Shk2xrklyqjU0cgEi4cJH2RO8g/rVpNA5TxGq8BoWuYK3tdjUkO+KD1mL
	WUtYmpAWBn68bAAvo9RygoVu4MwLZjhZZkeMj5LykW2t17YjetoRmlmFzF7iJsTO8cxTOFb1wml
	/OHTwbuu4KccjeS3JqkLy6UrE96Qyk431jnuhlRQ47R7AtAESvMqjD3LZnTcpPV+X
X-Google-Smtp-Source: AGHT+IHCOC2UNw504vBDm8gMi8seqOaSIpg2GtFp/hPeTYk7Ed41YoQAxobGkgEagxM0zCsu3LNgjQ==
X-Received: by 2002:a05:6a20:3d1c:b0:245:ff00:5332 with SMTP id adf61e73a8af0-32da80da55dmr25664345637.7.1760349295737;
        Mon, 13 Oct 2025 02:54:55 -0700 (PDT)
Received: from archlinux ([36.255.84.60])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678ddfeb7fsm8975030a12.19.2025.10.13.02.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:54:55 -0700 (PDT)
From: Madhur Kumar <madhurkumar004@gmail.com>
To: nphamcs@gmail.com,
	hannes@cmpxchg.org,
	shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Madhur Kumar <madhurkumar004@gmail.com>
Subject: [PATCH RESEND] selftests/cachestat: add tmpshmcstat file to .gitignore
Date: Mon, 13 Oct 2025 15:21:49 +0530
Message-ID: <20251013095149.1386628-1-madhurkumar004@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the tmpshmcstat file to .gitignore to avoid
accidentally staging the build artifact

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
---
 tools/testing/selftests/cachestat/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/cachestat/.gitignore b/tools/testing/selftests/cachestat/.gitignore
index d6c30b43a4bb..abbb13b6e96b 100644
--- a/tools/testing/selftests/cachestat/.gitignore
+++ b/tools/testing/selftests/cachestat/.gitignore
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 test_cachestat
+tmpshmcstat
-- 
2.51.0


