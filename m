Return-Path: <linux-kernel+bounces-771683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBA4B28A4D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 05:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B73E1895733
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BC291DD0D4;
	Sat, 16 Aug 2025 03:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="R+NVgeiq"
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D383F634;
	Sat, 16 Aug 2025 03:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755315268; cv=none; b=aObY2DGbvCBMg1jrfC4EgDUDhJC5onc2d7FqwkegZPgRk9HMrJz80JRVCz1SVRW4P0DG6qPpTiwSPpNhhi+n5xfjos/EylMCitTSGe/iTP19Qvxi21dIlGOlf8VQypa+tGt0JUQSVJKq64lxrF7FMeTWZSZRa8KJNisEhf1DAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755315268; c=relaxed/simple;
	bh=3Onuxn695AX2zEBK95rdI5lJFfzKyi0Gig3enS3hQmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+SW11ge0A7UkzzOXNMfvJs9nwFH+Laa4WTpdkbl1xgCK9xmf7kQPjBSVJ5Ac0MERSCRoewn/GbDazAK4DzG2UyIkTTUlrIZxtj8cP6zWrB5IcNfm495s4X75XkoM4qyCOfqo1U/Vo4Jhs/cRfHnzRN4a9+LqtD7tvzsfDci98I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=R+NVgeiq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A83CC25E88;
	Sat, 16 Aug 2025 05:34:24 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id afTrq7HLdU_U; Sat, 16 Aug 2025 05:34:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1755315264; bh=3Onuxn695AX2zEBK95rdI5lJFfzKyi0Gig3enS3hQmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R+NVgeiqRnyYkWKR6/RQcRcFhSfpkrqtDSns2taOmndMB1ppMr9rLIzCsxOcOInVG
	 Wb3zSGxmxaxRBpjD4tWPaKli0kp6GV1Y9JLlPDQNjIYWvXS8tWLnCpTK8wNJuG682H
	 6sLDMQht/ykZekRtQaizA8H/vkbYdjf52sgHxX8n5OlNpxXKkaiQ41O8sUjWDyeAhN
	 JhlJn03PqaEggyymzz36JZvVBnWNRG6WZtDwdH1RBW9IjOwz+i21WXrDNrnG3XEsP/
	 8IjYknczapdvyOaDGa6/vquc29ar8lWsYAYEmxKgngXpEy0QXk4eKm83mORZuphjGm
	 KsL4Gms4VF+FA==
From: Yao Zi <ziyao@disroot.org>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	Mingcong Bai <jeffbai@aosc.io>,
	Kexy Biscuit <kexybiscuit@aosc.io>,
	Yao Zi <ziyao@disroot.org>
Subject: [PATCH 2/3] reset: simple: Support Loongson 2K0300 SoC
Date: Sat, 16 Aug 2025 03:33:27 +0000
Message-ID: <20250816033327.11359-4-ziyao@disroot.org>
In-Reply-To: <20250816033327.11359-2-ziyao@disroot.org>
References: <20250816033327.11359-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The controller has contiguous distinct control bits for each reset
signal, where setting to low represents reset assertion. Add support for
it through the reset-simple driver.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/reset/reset-simple.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
index 79e94ecfe4f5..03a19d4505e6 100644
--- a/drivers/reset/reset-simple.c
+++ b/drivers/reset/reset-simple.c
@@ -155,6 +155,8 @@ static const struct of_device_id reset_simple_dt_ids[] = {
 		.data = &reset_simple_active_low },
 	{ .compatible = "sophgo,sg2042-reset",
 		.data = &reset_simple_active_low },
+	{ .compatible = "loongson,ls2k0300-reset",
+		.data = &reset_simple_active_low },
 	{ /* sentinel */ },
 };
 
-- 
2.50.1


