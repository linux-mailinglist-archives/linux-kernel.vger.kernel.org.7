Return-Path: <linux-kernel+bounces-738287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A3CB0B6C8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 17:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7117D3A3A36
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 15:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97E51F4C8C;
	Sun, 20 Jul 2025 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DD/269yl"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF7E35973;
	Sun, 20 Jul 2025 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753026597; cv=none; b=tPmurz6bNprqa+3T1XBWStuY4oR6cwmdYY7M7Qz8cRTv0OOHvIof99HskEfpqom2CsA8WWh2LjphFo2sTEXgkqvbxe3ZyV52WbFVGdCZRdLBOttLkXdeksdBGLk9Jot5QnLLUy9mWbj+7EtEr1IMPT+Yqkf75YYlpgmCEkUkCeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753026597; c=relaxed/simple;
	bh=WuFSV70CiHFeLwFjmoriru2B6DdN6PfYARb8HsIY09c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q5X5sgO8I3VL+TOO9rOlzZefrYrrn66ZbxxffpoBmbLQa0CG31R+HoPYQfy7e5AjvZlW9aaJ6xy4oWx73cxZV0va22mhlgy6o6CZoQ4L9cPLABZnbl0fa1kqtqMTpxo9A8zaCixUJ3q+o8cnwWPC/PjlqSiPxurlArBBwaFHxEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DD/269yl; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0b2ead33cso629370766b.0;
        Sun, 20 Jul 2025 08:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753026594; x=1753631394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=56IimgoFcz06vn4LfjzFPGxXnWUOYp9UN16wymaCQB8=;
        b=DD/269ylfqAnsjOfp0+EqBwoYpazAvhi1mps1DOvpgsvVvPdI3nNg7jx1p0b1r5l0S
         Xtk5dDXsajJmj7J/XN0bXNvM9qSvVhTkkVwOeAqQxIiH7nOQEiWquuyy6BzapCkw3UT9
         R/KlKG3T/sMzk/axG14oh2D1a2gN8kK+sPDK8Qd6jLqWg+CZCFHtwLST/b1aquCHGUgv
         HPJzaz1t15XwUgGcaV3cQ0aPyHZ/e8kVWRf11dG/pwqghs+Tqym5qyD0HSetoxt93bai
         TeQUiQAIJZHOAPyEXKwgMTDvOUroHzirom9jeqeCJ+ZcPo7DFFR/3Ou1z6ykmTzAGkZE
         +sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753026594; x=1753631394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56IimgoFcz06vn4LfjzFPGxXnWUOYp9UN16wymaCQB8=;
        b=C44AfZYOe8EpN2RiOJqdH//BNfdcGEeOV08KYTKnOKFM9KwzO5h7Ys0+779ar+Xgkk
         8jfa04Lp7DPwB7Vag/mToZDZy+4qxorYAqXzobRbuokNcuG3Yux8a2e1KFx6k+iCQzEa
         L++ejsY9vHOSOeXEyOvVGtwBPMFazpUq1mE+7J9huhVcjA5W9FxPTsy8mmvq//YEVLq8
         fMjqIGAcSxPs1dEaNh0yhI9wrlpz90dnLTrxIY+UZ3DUNjozbyNsn5SOUJe3XgNrb23S
         gs8cLv7bI7QVLR+z0SbwVitDcc7CwHHuRrQo4by5jBjqqkK90JDa9N3rR28rS0Qz+/DI
         2icg==
X-Forwarded-Encrypted: i=1; AJvYcCUbDNDlBW+ef7637TK/iIzT6mkQeZKfqZInRShZcOy7mBZsWJk5TWCmFu0HcRAvWA5D6xS64KHyQ3SZww0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYMs0NMwup7Ztoj4xP4nF4+k/O0UkLqy5hIim9DG/gx17ZMXWU
	ybaFARPdaaOESfScxkFOLldBubbwL8l9+P/kjwjkIMHX2uSUih6SFeQh
X-Gm-Gg: ASbGncuK9wg4lbf5gGpOM4luIQ54lsEZ0Z+8pPCq9M7aBFVzbcXgEsLBSUWRIsK8cmw
	rLVSY4U7xElyMfe1c4tXwJ3CnyZ9yZOjjxUB/ZtTXbHABpLDFFH/qOis0KKWBVgcyjLve98B61+
	Ur3h0w+cpH3Cq1xqXWH7H040WP1nJXBxjHAelUKJzgo4OfvMjgYYZUUbMRR3KEEHlS7Glb22tiU
	d11ZFpLwmFcVEFB5u5BGlfn4K4qexaskMcEUwUJt09PTE4mYFVdwBsasNCFfZGVjQ3ylxn9cibw
	IgmgesJqphMhyY4QpB+Ez+7OzCnt92SYP3PnAcUjqSrkf4097hDGKSoSmUUJFY0Rb0hp2SS3JOh
	pD4C0DVDRMJai/odznBKqgyld/GEl7HONH3BPMX2wZYSBTTZCchHXGVHof+jD06+UvCESeRCQuQ
	5RGZiV8Xk=
X-Google-Smtp-Source: AGHT+IELAKp3pj/E85bGmMDRGjhbN9K2DOlpdV2DUARaJQybqQCf6aHPgdcDIhbNjoJn8DdHntVZyw==
X-Received: by 2002:a17:907:7f87:b0:ad8:959c:c567 with SMTP id a640c23a62f3a-aec4de005efmr1315169366b.10.1753026593507;
        Sun, 20 Jul 2025 08:49:53 -0700 (PDT)
Received: from localhost.localdomain (46.205.192.124.nat.ftth.dynamic.t-mobile.pl. [46.205.192.124])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c903fb62sm3915620a12.44.2025.07.20.08.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 08:49:52 -0700 (PDT)
From: Dawid Rezler <dawidrezler.patches@gmail.com>
To: tiwai@suse.com,
	perex@perex.cz
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dawidrezler.patches@gmail.com
Subject: [PATCH] ALSA: hda/realtek - Add mute LED support for HP Pavilion 15-eg0xxx
Date: Sun, 20 Jul 2025 17:49:08 +0200
Message-ID: <20250720154907.80815-2-dawidrezler.patches@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mute LED on the HP Pavilion Laptop 15-eg0xxx,
which uses the ALC287 codec, didn't work.
This patch fixes the issue by enabling the ALC287_FIXUP_HP_GPIO_LED quirk.

Tested on a physical device, the LED now works as intended.

Signed-off-by: Dawid Rezler <dawidrezler.patches@gmail.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d91aac06a..0118b8c88 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10694,6 +10694,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x87cc, "HP Pavilion 15-eg0xxx", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87d3, "HP Laptop 15-gw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87df, "HP ProBook 430 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FIXUP_HP_GPIO_LED),
-- 
2.49.0


