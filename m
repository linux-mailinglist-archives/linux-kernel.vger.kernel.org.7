Return-Path: <linux-kernel+bounces-842529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F20BBCEF3
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 03:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DE114E3FC4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 01:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77E2E1D5CE8;
	Mon,  6 Oct 2025 01:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brrk+DBC"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C141C3C18
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 01:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759714639; cv=none; b=Du0YjB/Uum/nGxQN/Yt0W7n9QYMZVWYT1MIQSrdHWzJghc6PNu9uiudDvqmLJsh8KbqupqR1gp3rZ1tQE8/x4s5CXGe3suG57g1vBZUrKVxN1zKXOPHd02YAIb7Lr2ZZGffQZWrlwgF19BNPzrJqjJZecAs6oqo7viVtHb4662Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759714639; c=relaxed/simple;
	bh=8vb78HgLflfOFaCJ1SzwxhWOvrnKvFy9/Pw3SIfHYhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n3OoUbq/Lk8i2Wr750ZcpOGXFdc8qLOJ2RACYqOixsgTikl/QdLTgos4lmNyu6pbHxNQ/5mFNVlvy63GGV+jKzsjaob9rwCOnKIxDIVgktkcmrz0gyD7j8ujmjCZ4mO+DamqOoDW65dg3/EyF1maE0MH04FFXGlKy/6Dz2tFUTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brrk+DBC; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3a5437f2e68so459505fac.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 18:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759714637; x=1760319437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qqs5Ij+9qF2GYjJfsvIYV0c8RAhcOS3264WorTC2CQ=;
        b=brrk+DBCZ6QNiQVbmKjmYMqOLb90Klz38XAIjDN5EmD8VWLuvo5e2/lOphvjvecrXS
         R62ewoLo+xYt/VUXdvr87bMBPVkRSvXsA952zQtYLU14GpE22SthUTT/P/i0L8QhkI60
         JMtZ+sA1r7w8t3qH0A9+Qq5X6LgsaW6gDYBQp+XkpSu59j7GWWyrTNb515fRDIGzxYPS
         rkFYhz+7gGPhkgeAeeB6tofu7H/3tyenVm/qmJzpq1D8uig4GKrxQub2N4d5oHToeCD8
         9hbEthDKSwJNaqcVTaKowEZUuobHn+1EwUm/YZByHyqS75oJjS8IQ1OcBInwO7Blbrdv
         8i8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759714637; x=1760319437;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qqs5Ij+9qF2GYjJfsvIYV0c8RAhcOS3264WorTC2CQ=;
        b=ukSq7CYZEkBR4fY3SCYZilwvAoeU2j7y8riO2ZdMsEozRGQouHPSqGDumDxcWZUMB8
         MTBmxWfw5axAeqQ7FaBOTUZIKpnUYk21tUHpR6HJhTBZ6HsFoz+qo8bELQMPtJBa+dm5
         IQ6EF/8QODMFPkH6f8hcJy+RFPbJP7IaZBgtNSjlaF9cJyX/OkRLIXsO7bEFhnRlqUaf
         2I07kG3FKo37en5FcGS0+k7q1uohvzPr8miJnLFt5JNU7Cr0Pg83MDkHoToya6CrwtGg
         WdxLrzR9+z1cQYg7nG7T5ePfNbbNwJEOjvXk2Yx4cvFvyYS+9Xca/oIpQAfKhCSeRJr8
         6nBg==
X-Forwarded-Encrypted: i=1; AJvYcCWDA3DyNX3fFPs9l+jVBa3maI3PSz2aqHOGoJRHNXNNBXYEnXQNYYnGds1twM7QKx1KbqWHz6oBX3KOa+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaxO3JQQyegQzBVpMqfCOv7uBZmvm9k3APpLRSvXvJ6SW3UycW
	SqQD/bS1BIKgQKeFfSfLYBIM33ytlAQnJoAOxI8kMtinAi7jR7Lx5NVp
X-Gm-Gg: ASbGnct5B7OVACMRlLL81loadZMLBi4iafxrLnQpXbVhIjhek9ZFw8dqaAt6uFklQmt
	DHjIfQ3fuLupktnxds+KAe48CArFyKKDMO7McYxZ5fwIM0Aa0A81ZPS/J661Qc8rNc2cgRNBn+o
	+w//nGfRrytkpf/bCFCrR8P8/ovBU3BX9PUIiO1q3f5lNFuMy4mYCxt7RTyY8TSSe1LBKTjVY+U
	S3TOfYj4uX9IOjaC1n8a8hZ0167Nn6dBfHauJTB+tRLYRNdoEP+Xm3HcuSWUnskvvJ/+Om3PK84
	/7dMDP6JLjosS0UcnnKOQ+e9d8WcTZJRymKTN8+cpUXsgMc6Nsgq1ZWWg8gSksqAVTj1Tr09NP9
	YEtXiVEuo/rknCCd0RzjBV1ZArjvtqC93Cft9l7H8L/4DjimopYrR3xPjSUtmSF4MaHW+lwMYUn
	a7k3f6ap3hT9kLVn7XVA==
X-Google-Smtp-Source: AGHT+IHAYM1xwlbULXHzAzvUYaszsHniF48mSz6Ui/2I7/3BZwTGS4Gyl2/hVMl7ZhiOuJTT1MOHTw==
X-Received: by 2002:a05:6830:7105:b0:7ad:31c:56cf with SMTP id 46e09a7af769-7bf772ddb3amr3505956a34.4.1759714637454;
        Sun, 05 Oct 2025 18:37:17 -0700 (PDT)
Received: from Michael-ArchMiniPC.shack.lan ([75.167.107.197])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7bf3fdcfb69sm3462870a34.13.2025.10.05.18.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 18:37:16 -0700 (PDT)
From: Michael Garofalo <officialtechflashyt@gmail.com>
X-Google-Original-From: Michael Garofalo <officialTechflashYT@gmail.com>
To: adrian.hunter@intel.com,
	ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Garofalo <officialTechflashYT@gmail.com>
Subject: [PATCH 2/2] mmc: sdhci-of-hlwd: disable bounce buffer usage
Date: Sun,  5 Oct 2025 18:37:00 -0700
Message-ID: <20251006013700.2272166-3-officialTechflashYT@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251006013700.2272166-1-officialTechflashYT@gmail.com>
References: <20251006013700.2272166-1-officialTechflashYT@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the SDHCI controller in the Nintendo Wii's "Hollywood" chipset, using
bounce buffers causes the internal Broadcom 4318 Wi-Fi to fail on most
data transfers.  Disabling bounce buffer usage allows reliable
transmission again.

Signed-off-by: Michael Garofalo <officialTechflashYT@gmail.com>
---
 drivers/mmc/host/sdhci-of-hlwd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-hlwd.c b/drivers/mmc/host/sdhci-of-hlwd.c
index 5bb845d13599..59736ae85c14 100644
--- a/drivers/mmc/host/sdhci-of-hlwd.c
+++ b/drivers/mmc/host/sdhci-of-hlwd.c
@@ -63,6 +63,7 @@ static const struct sdhci_ops sdhci_hlwd_ops = {
 static const struct sdhci_pltfm_data sdhci_hlwd_pdata = {
 	.quirks = SDHCI_QUIRK_32BIT_DMA_ADDR |
 		  SDHCI_QUIRK_32BIT_DMA_SIZE,
+	.quirks2 = SDHCI_QUIRK2_NO_BOUNCE_BUFFER,
 	.ops = &sdhci_hlwd_ops,
 };
 
-- 
2.51.0


