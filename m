Return-Path: <linux-kernel+bounces-897599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC4AC53305
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 16:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50FAD541961
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9E0340D98;
	Wed, 12 Nov 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Omf+Fb1U"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F2A33B6E1
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962091; cv=none; b=pfX5FIkpcAimDTVTZLN3U8Cww5UcwCqQuI4xZTK9Z8jg1n6ZvF/KdfQUSozjyJJjQRyxu33ePIMJxzOR6YLFUdzWqxszeqHGxzHfmJh5mLfyTv1Ict8B905YMvkHCyWXItaHVQzWYVfHjmPOqEbh3O3lRQkRHlUY9nrBh5ocFa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962091; c=relaxed/simple;
	bh=2VDdKEp8F1Kmk4EzLuKTTS/byzcL3Fzd3mUIgAOO9xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UicsQOjrDB3/clTsxDRsR7K7+tKcu/+iu6xN0dmq9K5HB2SxB2YjdxjVkLozSE5o4CFeyMjuaiXWKVxsMPZlJVXeZ9u09njGQL1o5F9JgcB+3aXPUHxpP0SajM/9skMPFlSeH+zApgPHLP/TzESCKKEe1rRdFw5VxgP9oYpUsjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Omf+Fb1U; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b403bb7843eso214871466b.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762962088; x=1763566888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2aZ3q8iXsguvzv8869dZeM/b50D/XalAVFAVL82xgI=;
        b=Omf+Fb1UYpnkNc1YTDoNIOjKKnvGTc2JAbiRumwX+l97e8rHW41VdZbmJd25uPggGt
         QFRDV6OMDe8nuKLjB7jnFkuwPU9bmna8fcE6g7mn7hLagRmbRxvq82D0WCtAEUBPWjrV
         ajBw/L2z43lq/hQRWjXwQPgTgLtBjnRuAHVDXJAlSUoLlIOlywe/s1uiAfKpGzDZso2H
         0ykr4KJ2OQobsQFMJZrqHzhj6q26A40SR1dWZS1NtrWC/0HlPBuxc6rK604T/Ws7Nf+8
         457ycK7XsNNK9Ki31LwvuRDcnoezheNcerEjXQ51F3KV963mjivby+0C6/sD8EpyuckT
         Ns9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762962088; x=1763566888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P2aZ3q8iXsguvzv8869dZeM/b50D/XalAVFAVL82xgI=;
        b=XuTC3uxWsB+tahS+M0QHSMyw7889SLTIE7neiByTLVa/rthyNiIuIrbgmBF6ejkQzk
         9uQNSoiHLepGe4dpWbw0Le/C52G5WWzoEJcgHswVcpz9vVbNva4BvZRHB+1YUfuQJuro
         HDN4vJwA5lNSeAYIXynnz7LBv1V8CQjNNBH3X6KukERXYLbon1SZQ4dcmt0WFy2HZXd1
         BKz2DLnOlXGGwXa5LxolYs2UnJ058hoaH0skGW8kr2JtTbvHM8uIaqT8CGpfqQmbracH
         gzdS7Jbvxi9SuXAotZ0sKLmcKpEyNbpsjkvYRGYJ7ROrWxD8oH4LQNsqgV5g5AEw5Uc3
         dXiA==
X-Forwarded-Encrypted: i=1; AJvYcCXfwM7JSR3CZX1Iyfw83BUgX2KXanv5rQ+TkMneofneevhm3q6HIPrZ5Oxu9dtDILskTt+qcWQgTEZSjWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTMFa4BvmHES1MxunHXmEdKQY45B6RjkbpItjeRjen2r4KA4dJ
	m7T5Elwx6vhtdyJgw+dn7SK1unHDkyL8Olrnc8GWK0PF1v3mtDqcbiUt
X-Gm-Gg: ASbGncupkP7ov6Vc2KSKFPa0f+o0NzIHKJMfcaI42Hc356lQ6j9WtTeEtG2ACX2sWpu
	plib/eNAEsG5a4qbnyaDaNUITj+JlKgNtHeXbLkUp2MAeeMk218C0AIWUCsykFLWMk2n+Tt+gt8
	siZC9DOjoPWaffihYfLSZRBqNqjf4KNxvntBZ0Fr0B3BGntayDFu6ayvruAatwixzclolDn6a1h
	9nvtpmtAYj2etrPiIcKGRnZ0UCknMwc92qB8gNNC0pavgsoIGTrnf2wR94Mt53Smjpz7nYEbtGO
	NiyRlIc0Fh1/rN+5GdrJD5YcBSWUILR5x1U0co4ReI0SeiwBm1rVVotWfHVDxswb3LW6DqcymNs
	7zQ2Tl+bw0nx2mOlVxWZSLOnN9bLnFjf9DpxCyZbe2HAfCXsmLZkILL1jXiNSK+WzHUNlgGH6Lk
	LB5andNtxMKWq21ygFyjnMaH93gy9Fq6ZI+h0vNv6ygAHY8YH7qaZWzksV4cS6hjwP2WGEoQ4u7
	UpoUQ==
X-Google-Smtp-Source: AGHT+IFugR4FUZvpldRleNYZZnPoxk2FrSRsDVPT6ppUn3fq+PC6KyK9eoozx/2VMx4e/g2GMOwGOQ==
X-Received: by 2002:a17:907:2d0d:b0:b73:21db:5fa4 with SMTP id a640c23a62f3a-b7331aec4a3mr387296866b.62.1762962087982;
        Wed, 12 Nov 2025 07:41:27 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97d456sm1670023566b.39.2025.11.12.07.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 07:41:27 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 4/7] ASoC: renesas: rz-ssi: Remove trailing comma in the terminator entry
Date: Wed, 12 Nov 2025 15:41:05 +0000
Message-ID: <20251112154115.1048298-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251112154115.1048298-1-biju.das.jz@bp.renesas.com>
References: <20251112154115.1048298-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Remove trailing comma in the terminator entry for OF table. While at it,
add a space between the braces and comment block.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 sound/soc/renesas/rz-ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/renesas/rz-ssi.c b/sound/soc/renesas/rz-ssi.c
index c7d5576c8283..5dc510cf66e1 100644
--- a/sound/soc/renesas/rz-ssi.c
+++ b/sound/soc/renesas/rz-ssi.c
@@ -1248,7 +1248,7 @@ static void rz_ssi_remove(struct platform_device *pdev)
 
 static const struct of_device_id rz_ssi_of_match[] = {
 	{ .compatible = "renesas,rz-ssi", },
-	{/* Sentinel */},
+	{ /* Sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, rz_ssi_of_match);
 
-- 
2.43.0


