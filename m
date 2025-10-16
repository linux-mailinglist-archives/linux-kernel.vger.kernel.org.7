Return-Path: <linux-kernel+bounces-855843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB9DBE2775
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1A23E2261
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5668E31A7F0;
	Thu, 16 Oct 2025 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XbMA3O5L"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF7D319617;
	Thu, 16 Oct 2025 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607605; cv=none; b=fgoGY5+zZQ9MyTtvAdUm7v7TzFPsSwwbY0fw3+449ZZIsX/L+GTmcmZcrt+O0DX21UQ6evv9cNXf7QfXyfGErviurDO5T7zJJ+0elcWePsLAVZiG/Q0VVQKHf/P3uU4HOBkiZfzGah9YBRrHhjzPfa9KtdYAK+RdJ9mt7896wbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607605; c=relaxed/simple;
	bh=NhqcqTJNyfYIU/3v/Qyh9zQctAtRT4fmU7cfaevXBAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UkPB3n1X6+9iGrPj9Zn6K/bp5M8Re1E51AcDVeI4iIMIX7IR8Pb2/yvWCOtau85pesNwR+xluKMcQv6DYCDcriRqeJV9KmUrZOgV0IgXBKWtjXbE0ufL4EPiM1FxjZ3FIsX4FMdKGH1ek7H3JOejZfLukDKs7l881bhKIqwnfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XbMA3O5L; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1760607601;
	bh=NhqcqTJNyfYIU/3v/Qyh9zQctAtRT4fmU7cfaevXBAU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbMA3O5LgDpwNsvnkfOJdbrabSVMqwGqw5uQFjOzD3fLCFpJcs+mi9aDv/VOfGCjX
	 s73xOQCVhq0HEpV0lEK2BQRAJlA/jut6V1mQZNHkqB+hczKoayt0Mrgn2/r4V+uQId
	 UJYRivTVPXwLoNQPUontX3Beiw7rqp9o2V3FZm1xT2fvXyxAzjHxDwZB/TRHMZjUbh
	 /6naJm2uLMLD1kcB5PiL695ATIE1+mv8GXnODXyAga/x7dFvMLTbOkyTmupbXXGEKW
	 SIuYl/eCYNIiixBnhmH8k96U6A3lbkyuKK2ojrKTDGGrkEdEfOrJx5Pwd6CU/4cpaU
	 9dU5aTp6Mn0QQ==
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 44AC417E1400;
	Thu, 16 Oct 2025 11:40:01 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: sboyd@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	hsin-hsiung.wang@mediatek.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	kernel@collabora.com,
	=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= <nfraprado@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH v3 3/5] spmi: mtk-pmif: Keep spinlock until read is fully done
Date: Thu, 16 Oct 2025 11:39:47 +0200
Message-ID: <20251016093949.127326-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016093949.127326-1-angelogioacchino.delregno@collabora.com>
References: <20251016093949.127326-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Move the spin unlocking to after reading the contents of the
PMIF_SWINF_(x)_RDATA_31_0 register in pmif_spmi_read_cmd():
since this is the only register that we can read to get the
data from all of the arbitered busses, a concurrent request
for reading (especially on a busy arbiter) will show a race
condition and a unexpected or corrupted value may be read.

Doing the entire read sequence while spin locked guarantees
that concurrent access to the arbiter doesn't happen.

Fixes: f200fff8d019 ("spmi: mtk-pmif: Serialize PMIF status check and command submission")
Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/spmi/spmi-mtk-pmif.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index 68f458587c67..9f416b231ab8 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -22,7 +22,7 @@
 #define PMIF_CMD_EXT_REG	2
 #define PMIF_CMD_EXT_REG_LONG	3
 
-#define PMIF_DELAY_US   10
+#define PMIF_DELAY_US   2
 #define PMIF_TIMEOUT_US (10 * 1000)
 
 #define PMIF_CHAN_OFFSET 0x5
@@ -372,7 +372,6 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 	/* Send the command. */
 	cmd = (opc << 30) | (sid << 24) | ((len - 1) << 16) | addr;
 	pmif_writel(arb, pbus, cmd, inf_reg->ch_send);
-	raw_spin_unlock_irqrestore(&pbus->lock, flags);
 
 	/*
 	 * Wait for Software Interface FSM state to be WFVLDCLR,
@@ -382,13 +381,16 @@ static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
 					data, GET_SWINF(data) == SWINF_WFVLDCLR,
 					PMIF_DELAY_US, PMIF_TIMEOUT_US);
 	if (ret < 0) {
+		raw_spin_unlock_irqrestore(&pbus->lock, flags);
 		dev_err(&ctrl->dev, "failed to wait for SWINF_WFVLDCLR\n");
 		return ret;
 	}
 
 	data = pmif_readl(arb, pbus, inf_reg->rdata);
-	memcpy(buf, &data, len);
 	pmif_writel(arb, pbus, 1, inf_reg->ch_rdy);
+	raw_spin_unlock_irqrestore(&pbus->lock, flags);
+
+	memcpy(buf, &data, len);
 
 	return 0;
 }
-- 
2.51.0


