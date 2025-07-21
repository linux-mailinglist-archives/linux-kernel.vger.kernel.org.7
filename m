Return-Path: <linux-kernel+bounces-738683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5841B0BBE7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 06:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67A7E189A326
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 04:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56BC217736;
	Mon, 21 Jul 2025 04:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="D0FxOvMr"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F20321766A
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753073108; cv=none; b=R6Dk2GgVxIliQ2YnRYWynqAPcNDLBoSijLGfubHlhbXMcjOjRZ/DCKvCEFAR9kLTh+hovt58RjKc5PK4TtsiVZJ29+ewo7oFZ8ZUyiuyMfu0PvFqIlRfZVh/ipIHDkD4Jotq9Gs0ut6eO4frO4hGdyATb4hvADe8jiU7QyUbhlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753073108; c=relaxed/simple;
	bh=IOaQogKtGxB1EtFGBLmlcjD939y2b+5TBhAF/IwPWNg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=TR3/246O32lNcy4MZbA+reZavibQiuqwAYpD3v5G80+aBlb+uYwMLtoX0qxcLuYSTON62MwlwLY++kzA/YE4N+TuXlMgknOgqhPKYI5qarLxx76gWTC5LZO9dgccsryDObae2zqDFF4vUrsXJtbdf6eKeodNGVGUxLQYy8P+H5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=D0FxOvMr; arc=none smtp.client-ip=43.163.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753073094; bh=RQ+cjdgHza/KI1QwGGviBWep/upPtbWOWqbB6ehvprE=;
	h=From:To:Cc:Subject:Date;
	b=D0FxOvMr2QY3Gf+xyOWfYNtrRpfIoQ9zXiYQfW4xpOBYHSjVnTaCXOYhkSNZSYKm+
	 hEOmw3xs7XuWtfjgW5y6xFSosYov38IjBdT4OTgcUHORqNzLq4lqdPXpvgcOZAGyn7
	 Zt8K66qItvy/MLUptAJ1CJ3mwoyzzQ3p5WClf+SU=
Received: from VM-222-126-tencentos.localdomain ([14.22.11.165])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id AD7B68B3; Mon, 21 Jul 2025 12:43:23 +0800
X-QQ-mid: xmsmtpt1753073003tho67wc1v
Message-ID: <tencent_0A4AB3348A519A1A2EF46D99BF6A52D9BB06@qq.com>
X-QQ-XMAILINFO: N+vldBj843eNbldmdOBgjRJW9E+3YI8vAPtVhMB/ed+Ags/abXnrp08GtC3mdj
	 517ofsAS2wP4RUoC7xErk1A93ogYdf1wc7rzTf98D8Ay373Vy3Nm4W1y1oA3cwn+wK2vA39IlLQG
	 co3Qa4m61LUzFg3W/7jV6I3vgObk9j8753Ok+ubGTTf8gXpoeMELkX+5OmzQfCX4T2hmMVZ0AZe/
	 BSc078ro2Bs2Xr5dfoYkp45xXQy2/YqWMEblC2OuNRaKPFMyrNal8+15iT/36eDfCGYoXGAPCsAa
	 RzTW0hBQVRgXxYXHxCiAEVb8dZX1VkqDQfIL3MrwhwkMz1ZT5zVUdFnxVXMNdqhKayULhxpw2vrx
	 P5l9HNHOJiuCcSrozCrH3AJ6OGOHK6ssYIHXTLV+1mVdo/4M6hFePbELjRBi7mXm2hUVk5sOBCW1
	 PlImQtwddTZMwcJbhG+ZnOORZUIQJmYO4SKiKBKIYpfk7HLrJjy4lCb8Ki5/Bi4Aakl3UWg+drL7
	 EVdwZ0kVedJdDkIGOD22mqAHetIZ0g7D2S7mc0FhrewbN2LW7bscY6ynLxK84dhtKLFzEdp++m6P
	 yxdg732BK/j3vvyyZsuLuBJURbghsSXmtm9cyei0f60WZUN8poOk4Qn3zcixWms81ke+e7A4vksc
	 WuTVGYbsLCzr3cRXyQyd3C4iNduiN5q9EeVbsE3O/g/ErM9faTFgCa60o0NrMV8DI8DE9OAuT8sW
	 o1dPIcKsxN2L1Evhpn+ppaQMQGRAS2eLhmGm68VgckBW3me4bpMLL3ZTewxnMsQvDB1iLl6W54Fx
	 IZXuWTpQzr+SUY+2oO2MVjPo8uTwv2OV+gyoMdbC4b2Nze7t1Z96GfmVUfoOzNn+q3w8kvtEMFht
	 qAhDYh3crcuTr5Kmvbp1SoXTLnLQCCCJXoqCve7l2Hu/I6sCibOqBZz8CqdcUnxIMF++QTrDi4RL
	 ll9f8dh5avfPZDQejW8/KK/tq41Yqv9G+89uuhdml5D+eR0ySiQiswGcXimH7ZlEyJ7sQhADR6Sf
	 /bsg6KYwYJUEcCBUPC+QDSecFZgMHc3t+sVRp3R8wuE/KpSKbYAQtrhTAYW5EdFiZStnAt4A==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: jackysliu <1972843537@qq.com>
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org,
	Siyang Liu <1972843537@qq.com>
Subject: [PATCH] irqchip/ls-extirq: fix resource leak in ls_extirq_parse_map()
Date: Mon, 21 Jul 2025 12:43:16 +0800
X-OQ-MSGID: <20250721044316.179541-1-1972843537@qq.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siyang Liu <1972843537@qq.com>

The ls_extirq_parse_map function uses of_find_node_by_phandle() to obtain
interrupt parent nodes within a loop, but fails to release the reference
count on these nodes. This results in a kernel memory leak as the node
reference counts continuously increase.

Add of_node_put() calls to properly release the references when the nodes
are no longer needed

Signed-off-by: Siyang Liu <1972843537@qq.com>
---
 drivers/irqchip/irq-ls-extirq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 50a7b38381b9..fb4e7b3a6e2f 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -164,6 +164,7 @@ ls_extirq_parse_map(struct ls_extirq_data *priv, struct device_node *node)
 		for (j = 0; j < intsize; ++j)
 			priv->map[hwirq].param[j] = be32_to_cpup(map++);
 		mapsize -= intsize;
+		of_node_put(ipar);
 	}
 	return 0;
 }
-- 
2.43.5


