Return-Path: <linux-kernel+bounces-834405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CF7BA4A05
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 18:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517154C64B8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6162F90D6;
	Fri, 26 Sep 2025 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mh2Pqbs+"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE32F7460
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904078; cv=none; b=j9fn5cvmhT+8KfhWTXuBEkMRpvZxaY4HbzXQaXrcDeAwWIUuvQJix46CYMYoeVWvwZCG3Q6jv8CKlWZUZIIqdRqw5jmnMQk4aEGjZD14C77MXNP3uiv1nDpChXbrjpgOkEbZqu4FVbKewxi5Xv5K3INRhh4wg4ezNIbUwfE72rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904078; c=relaxed/simple;
	bh=ji/pYhlnACaKaOAfYIWNSXFRexU3GRsGkKmsdd6hDxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BMACcjgkHU6ZZqvxHWDx1q+VsP7ULP1typ7nphKHlmm1gA9iFOi95a4k8aKesfxsDYJyRLBhno71AG2rZPrPwqMt/hTYnpg81W+9jfOyW11nZmjFKXoN6Ovi9foDtuWAaoR5F0wvFbiYMmt0h9AU9FGETn+CTHUO0nmT0yhjaWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mh2Pqbs+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2698d47e776so20694775ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 09:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758904077; x=1759508877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Neebg3bGNAkQ/ROETpufeOc+tWzliPzskjjkM8BaCbQ=;
        b=mh2Pqbs+3W17EqKKopkl/hxLd041ECQ8gQ9dka2es66WtMHrCSE10K0gCCdhIedsxA
         qeh+JEez7J5yY1iRosTktuJuhdk7p79iDdjINwNmrTXErWVcyzCZvg7g0p7OiquvU1O7
         oIZLeFRHJNG9lcW0o+FLRxamcXFX0YmDKA0SHH3tfXDFGy/vrKpeNCtsLdea+D5PgFCq
         IWI1phNXvhELSV8JSwEJm0NiaGSlm/tiYLHoqFmwGV6m2thcnwV3lLp9klLiwqOpvaE6
         LIYHHZyIs6HhX2E1/JXo0+T+9WF2vO267t3nl2Il6pxMylM/4hg+hnPzXuJCrXA/4C1F
         MygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904077; x=1759508877;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Neebg3bGNAkQ/ROETpufeOc+tWzliPzskjjkM8BaCbQ=;
        b=ef2c08hlfEefeBCbpGC9surlFYR+/8Fg80yuh17IWk/7C4LdJc5PGELMcDc2qAuVRP
         yXn/8uUw4TPYoeNx7EKFVVFF9LpFtM1pm62ibhkJqTV9NYm0SpSL3rd72mRsaysRudPs
         k82Zob/I3l+deeSwTWAd5AF3rIGouwtv4dEDFOw5rdcFZPV+7OYXKsmi1XijKotNHbEe
         eqkDmMwD2l6/Tgj4o8CV4huyVynEAPh+gOn9+u/Ys9WZcWJ/fbmhcOtpnpQKH3aSo4eI
         8NfNZu9T3f3H7PFyS3pzUvn6cNe8w0VpjBJVrUF1TizkBT59zWo7pmVCCjqvBfizRY5i
         i4aw==
X-Forwarded-Encrypted: i=1; AJvYcCXcpOBr1hOIADHBrWQWYS4f6x3xTC8lQz8HZbnBtqvbfXkfObybjuMuTTY+ldL5eKLSjT+/lP8bzB4cpp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKvqWO39UpWrL+IOsOelZBSNjeZKBHQ/LoNFiVG+vOtlfxwK5W
	rYpEsE3XNCFWGwcb/E0//a2ondGmyrQjRnZnlop5f/DJduCqu/WZ3bLm
X-Gm-Gg: ASbGncvJqisZcjrWtpudBbJqAqMqJg8vugGU1os+Dcnxj0CNTrp4o59wcKFr66Yelc5
	jI+6ezUCjbGWoKGEfAXn4yGOqb/tQIS3/apgvxszQ5nba0KXtxw2MyIROzmxN7HiS7IoiiUcP6Y
	UCTQnS78VH4N4176L8TJx6SfAcAA5wYYhKylJ1RwgKKXkpZy9JSFxGflsJuFKwxKQBdQKeP3YeM
	wyKncZ5iBIketoBGQh9BFM2MmdXfHcxH2tGMTwqSFh3kj1cRz62xKB9fRbEoSk9jE1t9bbusPMb
	2dxzWESiARFD//Qaw0HCdRzvpmp33qNvuaSqOfIH5xqj1gP8Ag1lfRQiBWUyqlmQnbn0EZuHrAu
	ggew4XpZP9PjYaNwm3pIaji5D80113WSs7ktzqVaueiv3coIRyFoci/fZSLjt20rXOyZGfbMUQf
	C/Upi6UAr8tsaeDvSuTIxbUbiWvYG8QtQOEimh
X-Google-Smtp-Source: AGHT+IEQE5jqGklvdW2MJi+BHY9hlv8FvmTiKo/dGoO+8Vpcz9GROlQK10cosgequifhuEVqUAhh7w==
X-Received: by 2002:a17:903:2352:b0:26c:4085:e3f5 with SMTP id d9443c01a7336-27ed4a56c51mr75752515ad.50.1758904076490;
        Fri, 26 Sep 2025 09:27:56 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6ab64c7sm57277395ad.130.2025.09.26.09.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:27:55 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] docs: sound: describe 'chan_map' member in snd_dec_opus
Date: Fri, 26 Sep 2025 16:26:58 +0000
Message-Id: <20250926162658.989479-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building kernel docs, the following warning appeared:

  WARNING: ./include/uapi/sound/compress_params.h:364 struct member 'chan_map' not described in 'snd_dec_opus'

The inline struct 'snd_dec_opus_ch_map' inside 'snd_dec_opus' was not properly documented.
This patch documents the 'chan_map' member and its fields (stream_count, coupled_count, channel_map), resolving the warning.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 include/uapi/sound/compress_params.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index faf4fa911f7f..e90e2f40732a 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -336,16 +336,14 @@ struct snd_dec_ape {
  * @mapping_family: Order and meaning of output channels. Only values 0 and 1
  * are expected; values 2..255 are not recommended for playback.
  *
- * Optional channel mapping table. Describes mapping of opus streams to decoded
- * channels.
- * @struct snd_dec_opus_ch_map
- *	@stream_count: Number of streams encoded in each Ogg packet.
- *	@coupled_count: Number of streams whose decoders are used for two
- *		channels.
- *	@channel_map: describes which decoded channel to be used for each one.
- *		See RFC doc for details.
- *		This supports only mapping families 0 and 1, therefore max
- *		number of channels is 8.
+ * @chan_map: Optional channel mapping table. Describes mapping of opus streams
+ *            to decoded channels. Fields:
+ *              - @stream_count: Number of streams encoded in each Ogg packet.
+ *              - @coupled_count: Number of streams whose decoders are used
+ *                                for two channels.
+ *              - @channel_map: Which decoded channel to be used for each one.
+ *                              Supports only mapping families 0 and 1,
+ *                              max number of channels is 8.
  *
  * These options were extracted from RFC7845 Section 5.
  */
-- 
2.34.1


