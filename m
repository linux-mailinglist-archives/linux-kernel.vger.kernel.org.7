Return-Path: <linux-kernel+bounces-863679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03386BF8CF2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 22:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F4C119C0A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 20:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64693281357;
	Tue, 21 Oct 2025 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9vSORIG"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F8C27FD68
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079921; cv=none; b=eaoYjUqO6MznM59IQXCn1KdHQp/mT5Q0J+BTIunmiku7owNd3XQ+75uCdB/sX+RHrbrHUtw590OswpOlE49lgGyiURDuV5rYgy814rtJ+99xgTanMmncSLkO/056rBXusQ3PRx2Z5Qxg0C/GefJ0mzBIqFCaG3WDT0wbGbUOTE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079921; c=relaxed/simple;
	bh=R+QG6MhvXu3xq8dTeh0N6uuhjElL893RdNz/Ga4K0bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AjcXlPuZM7iSKWgizbkodyEQVfjEZIZjbCZILVuaitcQ2VQIMp9K4C+1kx2y8dOMOnTMX4mCbxkvd9e0ENeBPavFYb8GNTNDWrwId21/uuE6KqrM+BzjpodGVwMc9wDD91BMFtNvrUB5bE/1ziZAfx8HtPdepzIEAulCAbdxqmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9vSORIG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-781997d195aso4644091b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 13:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761079919; x=1761684719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZqLomk0XJ6mMJ0399FGLK0f1IEBoFk1TbnIiBF5Ifg0=;
        b=S9vSORIG6KWAvNGGjaQv47MOb8AzlufYcdNe+SBXZyMrsRlRgX9TV+WcridcAx2Tkb
         +KC+8eu19vVRCUKX9ZDQM12fsqF64JPu8PUXfHt44kSGOsrDdV8XSJnyIgbvwkqm8Gtq
         cJ6JuSaDo4jG1RoB81cUjbElKZL2+cLHIJycCNdE3nDrzY190Ex2DwdxyIzFXCIN5LGV
         U7+4bMuktT9f/wd4U4aNQAFS7oThvSjd5f7/2uU5SAShXMfmfIWp2BJwfObxYbqSnNFe
         k0XQuPndxoeL1LFbOSPW97V6ABI6HHKRq4GJBivGGKHU+GPu1HkeGtoOwVVyVy03Jk9+
         6LfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761079919; x=1761684719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZqLomk0XJ6mMJ0399FGLK0f1IEBoFk1TbnIiBF5Ifg0=;
        b=NuUgeDCGIIWkMGaDgwF+b0cyoLxIC6knSHWu5HGwx8VDXsWHQyWAjyn+P7oU0rgH0c
         +7LNEYSo1qS9lZijCeOxXEuSmXWzknrjqiuse8i1t9wYKmtEv/y+SzJJuG3VqnaWuIk7
         srQ2VK1s2dK2HSdMBulO9XI1U4ovjf/ixhGSUadzZuYCLGc4TkawsGcblCpGJP+T1YiS
         NgcCjDBo69NXhoZHERCB1dNIreE0fTVogyOK2va9r6l5elQthkgT2Y7FHAQPJzb0DBTX
         ulCsC3saK4szCEPkO8Ac4tBsvtd1BO3MRfXCnhvC3MtKlfKQdZuxxTQzOF93Nc3KGKvN
         jiDw==
X-Forwarded-Encrypted: i=1; AJvYcCUDlp4x+JEPy0Yv30Qetk5cO5evh4KtlpBzLY53sO5+QjC9cQITgXx8Ugs42rrA4gKfHeRKpKEZEW5NZiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS0Hep2wtgFJgWZR8SZxPLzOcLdIME0aADaCUycQtCA/ZYd3rG
	zJsGFAU5o5jxySibYL/0M4TSWLY7Db0QWMyj/ezjmfWBavImwbOhzN5qJLE6Xbi2GINCig==
X-Gm-Gg: ASbGncvwAEFdINEU+lKJv2Wdssg0Ge8NX9wC/Upr5KawPFY+n9nc5nXXgI8yZz4IMjN
	H0NQb83lXeRkh6qVYI7Oo5jjYUs0A2E9M866pokSqYg4x+aq6EMYGaA5lh9isA1ibdjUy0CchD/
	qq+C7U9gHuQS6qoytVMiLWG2FwnGJIkuyFxbAaayKpizxmM1jAcUfmbcu45nmEltji0rBrOtlf9
	POs+ktFp11axrsnqYloOCvn96vmXIHtyyU9qe1pTKeJlfkfFIAeVk/MjmgerokT/HTwSSv3D9KM
	BshmIchZ2qWTn/OinU6OKcKQllcj68ikoNCW/k7R8Q9rwfFeFV0nbMw5cLpZGMQjZ3ibzBRadpR
	iixqsdScvy1hVH4siJWDwbzaoyaGvjglvNdszv5FpmqlGJwRivb4jmBHfpJocvWFA2+708gesr+
	NcXw==
X-Google-Smtp-Source: AGHT+IGXa3KYk/FMewSl8GbMydrsPyCOFz6qkCeh/qanJrM3SOqws99nYJilMQBpqw29e2CQHXEsvw==
X-Received: by 2002:a05:6a00:4099:b0:7a2:23cd:418c with SMTP id d2e1a72fcca58-7a223cd42b2mr19100009b3a.3.1761079919503;
        Tue, 21 Oct 2025 13:51:59 -0700 (PDT)
Received: from skylark ([171.50.223.156])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2300f3c38sm12267929b3a.37.2025.10.21.13.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 13:51:58 -0700 (PDT)
From: Amol Dhamale <amoldhamale1105@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sriram.g@kpit.com,
	Amol Dhamale <amoldhamale1105@gmail.com>
Subject: [PATCH 4/4] wifi: mac80211_hwsim: use more restrictive permissions on debugfs files
Date: Tue, 21 Oct 2025 20:50:26 +0000
Message-ID: <f0609c73741321798da9baf7016270374d8e20fb.1761078139.git.amoldhamale1105@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761078139.git.amoldhamale1105@gmail.com>
References: <cover.1761078139.git.amoldhamale1105@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adhere to Linux kernel coding style.

Reported by checkpatch:

ERROR: Exporting writable files is usually an error. Consider more restrictive permissions.

Signed-off-by: Amol Dhamale <amoldhamale1105@gmail.com>
---
 drivers/net/wireless/virtual/mac80211_hwsim.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
index e62d4a98671f..7b206a4d57b6 100644
--- a/drivers/net/wireless/virtual/mac80211_hwsim.c
+++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
@@ -5816,10 +5816,10 @@ static int mac80211_hwsim_new_radio(struct genl_info *info,
 	}
 
 	data->debugfs = debugfs_create_dir("hwsim", hw->wiphy->debugfsdir);
-	debugfs_create_file("ps", 0666, data->debugfs, data, &hwsim_fops_ps);
-	debugfs_create_file("group", 0666, data->debugfs, data,
+	debugfs_create_file("ps", 0644, data->debugfs, data, &hwsim_fops_ps);
+	debugfs_create_file("group", 0644, data->debugfs, data,
 			    &hwsim_fops_group);
-	debugfs_create_file("rx_rssi", 0666, data->debugfs, data,
+	debugfs_create_file("rx_rssi", 0644, data->debugfs, data,
 			    &hwsim_fops_rx_rssi);
 	if (!data->use_chanctx)
 		debugfs_create_file("dfs_simulate_radar", 0222,
-- 
2.43.0


