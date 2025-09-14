Return-Path: <linux-kernel+bounces-815890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC72B56C56
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 23:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9DD3B0196
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5542427817F;
	Sun, 14 Sep 2025 21:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf5G4Ppe"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BCAE1FC8
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 21:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757883630; cv=none; b=PUnNSfsBZz98azL+CnZWGRHleiq9iIkFpZE6KV3ufPaGIsG5yrETsHkBl4E+CdH592tA+Rg0Uor0Q9Ekd3tFSvYizJImSwS7iu53y5ocIc4c8KiHB3Hr8hYq9Kl8bE3WK11vtYzHyvlUSpXD9A410wusq7zpPQ++WsWq5IcD6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757883630; c=relaxed/simple;
	bh=uEiYwiQoAW8hMQLGLN7/ysrpPGt17wGdOfYRNEL7B5w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dj4tnrfk0O3FhdoJVj6SFrsxUQW67a+pbZ7DX4G/33cq4J3wrAgkz8F//dBysQbmArZ2ZxM/mTlogz+OA5m4a/f0J4Al4yeykFHlI2YyrE6KfNNaJHcxmdZmydQVhfKxvmmkjEt7Rc2dLoQxggzxPNf3/1dwB9duvBEdZo9I65Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cf5G4Ppe; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b04271cfc3eso448146866b.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 14:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757883627; x=1758488427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6o99YyuBnjUFUiAgMBZrvlSAftiV3PzBtzxmR7sfJvE=;
        b=Cf5G4Ppehg36u9sWecyzYGd676S7LosMo9Iwq2P8HPoRrPv7x6lbac3W88L6igWYbG
         9VW+/JATc6ZnZIJR4TB7TWhDBbOMx44kFI2d2kAUG5aQlXQtuNmAGrd8UABriOuyapxu
         8qTqG6y172X7x6Vk2E+Y6MW6byGQkZGaa0Ik1/bOf3BTmFlLVXd3vSbAw6jzlYccamEI
         8saS3cjd+Xh4RmTqS1aow4yVlM8bMif5i1f3fqFXwBwkoSUVKxrys5joeO7pGwaqvf1W
         NAaTXo8zvEpyT/111ihUuIho3RAKAGcDdiK6HbN5Xiiuv5zPFR3GoB25ABAj1zcmmkjz
         +gBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757883627; x=1758488427;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6o99YyuBnjUFUiAgMBZrvlSAftiV3PzBtzxmR7sfJvE=;
        b=FlpUDHQkO+6VMsy1BDhraJ1472e2MCgPFvVSLPi73rzbF9929RJ7WBji0a+W5R0vsl
         xuPiYGk6Xn2jrZoO1RiuGPCqnijTtSMR05n86f7taXryvwpxd79IdPagMjnmZsVnPtt2
         DOZ9hfEfOrct6+3L2VjqIghUu/pqiphTIlr9OYpSrOeHLOYsWrxKKs8JbV9C987fCt32
         JqyCUgtgfEoniI6gf9BXQXxhlDNabw/3ymfvfgqamCafOM2RHVFCZyM3C3JoFsT42b9s
         cHwknZsp3pSqzpheaeatmzFYRu4ggn8GMBxlVSjTp5bu4GlVpCKf1qaAD55Qloms5N+I
         ih7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWU0VlMW8Ji07Bn4zHbJAOVAxcP/6yVmTvZAvUc/jUU35eQMn6Y7jRZQ38q+dqud4nOKldW7xeed8863xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycHTlYs24Cd26/noOkwQuaJ349wy25xN6eenoEwePeg32t6mMZ
	pw4A/LT6nIpv7VlCNuss47ifg2w8itrKjppx8iRRh5D8L+a5MhCMG0+OROtZ1+o=
X-Gm-Gg: ASbGnctf27LnFg0HrWNBZDIiO/5vsViX2hazepjZgYVv60MHQeOhwXLo4gkgLp4WyY4
	+LMuck4P2euX08lIMhQkX+f3307fA+cKbwVhpEtXklur4V/9F1wk2Y27DJqsMSG60USEYhiUlw+
	SgDVcjQhgf4S5YS5kyK3rD4F9G88njqVkTF1gO1Q/8AB8F7dXmGkf6ryrrn4qjZyuTmMwZ2uJXN
	KbD5lQ4MkEXD2Kdl/rUFE0F5wst8YWOoRoLsD24kXLFHgDhfL69i3Q9sp5cq0Czw7ypqZEXAJf5
	NN4I2PWuR05VN2EeW2TkxjnyxdGpJj1ZtELIxXpO6qJxdnSpxlLZ7xgA49pTCf+p7Ox/SyzOWXn
	B0RrDokxf6fHZL/k3yOd5rEzmpHHYH+MeXTFdGFdOZoCtQV4=
X-Google-Smtp-Source: AGHT+IEJTfAOE4SXVvnMZJXfSiCXUP+glB0hAyajLfStm/gZeUg5YzgdetRjeZvlFu0Ssqcih7xpBw==
X-Received: by 2002:a17:907:2d26:b0:b11:3cd3:a46f with SMTP id a640c23a62f3a-b113cd3a774mr65570166b.53.1757883627260;
        Sun, 14 Sep 2025 14:00:27 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:226e:7d72:f695:46fd:3aef:7487])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32dd6f3sm798516066b.67.2025.09.14.14.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 14:00:26 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: tiwai@suse.com
Cc: kuninori.morimoto.gx@renesas.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH] ALSA: asihpi: Simplify error handling in PCM substream setup
Date: Sun, 14 Sep 2025 22:59:45 +0200
Message-Id: <20250914205945.214179-1-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor error handling in the PCM substream setup to combine redundant
checks and improve code readability. Free the dpcm structure and return
appropriate error codes (-EBUSY for HPI_ERROR_OBJ_ALREADY_OPEN, -EIO
for other errors) in a single block.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
---
 sound/pci/asihpi/asihpi.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 8419f2b6e58..fd0a67b772d 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -982,12 +982,12 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 	err = hpi_outstream_open(card->hpi->adapter->index,
 			      substream->number, &dpcm->h_stream);
 	hpi_handle_error(err);
-	if (err)
+	if (err) {
 		kfree(dpcm);
-	if (err == HPI_ERROR_OBJ_ALREADY_OPEN)
-		return -EBUSY;
-	if (err)
+		if (err == HPI_ERROR_OBJ_ALREADY_OPEN)
+			return -EBUSY;
 		return -EIO;
+	}
 
 	/*? also check ASI5000 samplerate source
 	    If external, only support external rate.
@@ -1156,12 +1156,12 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 	err = hpi_handle_error(
 	    hpi_instream_open(card->hpi->adapter->index,
 			     substream->number, &dpcm->h_stream));
-	if (err)
+	if (err) {
 		kfree(dpcm);
-	if (err == HPI_ERROR_OBJ_ALREADY_OPEN)
-		return -EBUSY;
-	if (err)
+		if (err == HPI_ERROR_OBJ_ALREADY_OPEN)
+			return -EBUSY;
 		return -EIO;
+	}
 
 	timer_setup(&dpcm->timer, snd_card_asihpi_timer_function, 0);
 	dpcm->substream = substream;
-- 
2.39.5


