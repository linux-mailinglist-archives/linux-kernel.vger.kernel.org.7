Return-Path: <linux-kernel+bounces-760126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D20B1E6D5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 047311AA6AF0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A635259CB1;
	Fri,  8 Aug 2025 10:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ipXnzS27"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDC0227E95;
	Fri,  8 Aug 2025 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754650445; cv=none; b=jwtmtRPt/Ixj8evyJUvJ9pt7UYojXOptqv9qPXkv8tlWjfCNAQ4ZWQJZu14rNX5npfa9AJaYk5s/Yto4QOj7e08fV1MCF1IfPi5+S4xFMtTE+9yzkNaXPtlwIPvKHp7nOGQASsGEr46ccPskX4O7h2nzvDU2/j9uzi1fk3Tth3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754650445; c=relaxed/simple;
	bh=lnVlmRUuumBXjFDMqsZCaql8rzu778J/CcpHymusD+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gHFOLsGDFzwKKRjFQK1qYQmQEoNVYnN89O6DuMHV4+qRaX+ImBaAtACW6fj/xEtLPd1v9rkNKo215EB93VJdSQN7auj48VWvdJn/3JJNraUqzCFvf3Z7BsYj4tEKXYd+tSJ+TjSNZWmavZjbfaPQYqADagIXHuvHlQ8z1hm3D74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ipXnzS27; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3b7920354f9so1618615f8f.2;
        Fri, 08 Aug 2025 03:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754650442; x=1755255242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qMqIIfGgn6miB0zobtsFUkQvM4z3NfFxewv7fUWGHOg=;
        b=ipXnzS27bQE5AQPa4Ac+bR+eyKxCqVCQ+iJfgR/fM1tvNiKsSHBUblvMBKOTxGeAL3
         6WWEag7mcR/84Sf5ZW2QLjlCjlrI510Wt2UIOjw7z14BiXsAX8yzmoRDEjnrpsvDLMYp
         E1uzLrZSF+/N7WUuebbelL7ns+O2polfAnkMQoZCoxW3V8vQjP3A/wXoX9iLKHQkznoA
         p3y5vO/9uMUghc0zb7bAw3Kce8N75xBMBEtlx6szE+raPRnggZDbhh8h7GKQJXQh/7Y7
         dV7TpAc9SDsMTbWmg9b6/irY1tn/jjKvYFXsoXLufvmnhAQwhe1cxVbO2sZ0PFkMbQ78
         pm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754650442; x=1755255242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMqIIfGgn6miB0zobtsFUkQvM4z3NfFxewv7fUWGHOg=;
        b=aVf1bodYbdrjqVaqCoZqGXnjsy3YeYHJ51EuLv197QplLGEPDHKc016YrtpquL3uTP
         W5lWjTupJ3RCrNWpWs7xr0vsHqiNm4LKJU3aIQj575kw9Gz+GGr6FdE2csaxuU7xVvVa
         K+Duu1NsHrsAN+rVpX+0qwsu7Vd8iLlca3BotGIBNMB5PP1c00jRrjQD5WPZJ727OZ7d
         w7cRkZtPwuJet00f/bN+up0mak+L/Mmq+axCygvShURtIJpoAuzhQrBwHAjDeARS3HGi
         RfPBxIJhKi1WIqakmB0ijSB0e803sJqoLpRMmawcK+QRz5hjma0MmycqQ+OdGKG395ND
         TvVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQhfPhbG9GdbeeD7bZN6+wHPVFL/eJCeGZ9jUzVMdxv4XQs8+VC+s0hnDHrV4D9O9xgyw12/xuhoY9rFE=@vger.kernel.org, AJvYcCUk60ZaY9iwSfpyOsxl2Sc43wjj2StTUKhkL6qAdTn97UseJSmteXtWnMuRZ/bcsepPV0V5+NoRuoM1mTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi5zLEwnK3QbGpZA0JIbosrWdlXorzZzukd08m8F88kzJoTtLW
	g9pajpG7jOD5TTFm1QNgZIOIe6M6NsboXZdNg6TBltK43Sv6MkavOiRTSPuWdIIvKKD+Gw==
X-Gm-Gg: ASbGncs6tusJtgEvIRu5ZQpzmswqCTXXHMi++GqvJL28r8flMMhzsp93ypbJs45jjI2
	7FS+XBSle0KVrj8myn6SCAL8605Ffs8x1WoxAGzDrvwTxWtTjxpbzomgghOBPk1fbYFDlv2WdT1
	1j5qU0eZQpCBgNMmoaDTnwso3RLD4dCsBSh2OwJAGQUv4bpvz6/l/fuo/UZvRY77+KYyAw8CJjj
	V4zp/cxgfhVNKmVv80duSHVd1VPAkUAaVfU4lvgoLUx1xuDquKtmsCA56f5bepy392aMKWsb9Cf
	pUPmF+7vAWAvBdbqcblBScbc8bOypplWsyLQDjH93i9h2z1th/9dWJwcJ10M89jAz02b4KXrJqo
	pte3Obypnj2ol6A6dyvHQ
X-Google-Smtp-Source: AGHT+IG2qUBo7DwH1oxPokpOfFJVSUkPFi0bV2hgL3Hre/p0CbUqcKb4SWB8ggHg1jAKJzCAcNy5YA==
X-Received: by 2002:a05:6000:1785:b0:3b8:d16a:a4a5 with SMTP id ffacd0b85a97d-3b900905a8amr2477013f8f.0.1754650442478;
        Fri, 08 Aug 2025 03:54:02 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3b95f4sm29760042f8f.23.2025.08.08.03.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 03:54:02 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Kiseok Jo <kiseok.jo@irondevice.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: codec: sma1307: replace spelling mistake with new error message
Date: Fri,  8 Aug 2025 11:53:24 +0100
Message-ID: <20250808105324.829883-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a failure message, replace the
message with something a little more meaningful.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/codecs/sma1307.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sma1307.c b/sound/soc/codecs/sma1307.c
index b3d401ada176..6a601e7134ea 100644
--- a/sound/soc/codecs/sma1307.c
+++ b/sound/soc/codecs/sma1307.c
@@ -1749,7 +1749,7 @@ static void sma1307_setting_loaded(struct sma1307_priv *sma1307, const char *fil
 	       sma1307->set.header_size * sizeof(int));
 
 	if ((sma1307->set.checksum >> 8) != SMA1307_SETTING_CHECKSUM) {
-		dev_err(sma1307->dev, "%s: failed by dismatch \"%s\"\n",
+		dev_err(sma1307->dev, "%s: checksum failed \"%s\"\n",
 			__func__, setting_file);
 		sma1307->set.status = false;
 		return;
-- 
2.50.1


