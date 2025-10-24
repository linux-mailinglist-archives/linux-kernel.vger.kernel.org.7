Return-Path: <linux-kernel+bounces-869473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A378BC07F7C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74F391891CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A8E2D12EB;
	Fri, 24 Oct 2025 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="sFezRd/9"
Received: from smtp.smtpout.orange.fr (smtp-75.smtpout.orange.fr [80.12.242.75])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3128224AE8;
	Fri, 24 Oct 2025 19:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761335493; cv=none; b=i0JQ0n1J/xpOMwknih+hzCOe/FbS33h1Oz9/3G0Ez+6DefnWkQEL17TNHa6hc/m1FnzI9TCjmiOJHaHbTJ70C3DA0coP4QKd3Dy2lGm3VpwZ4mP/Cc333tS/N9p2YOFJxhDespob6uvC6cLwOxKVXy5QUhYsIFUrkTH/YHDftgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761335493; c=relaxed/simple;
	bh=TgoRAttjZrkjv9UEZTNrJN2o1wcIKakkLiYhp3V8ZaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lcmz+6KDVwwRP0fQ3pgUdhnrOjgMnJtl4gmM44nL0zRuB4YH064zzn+oz+2zWH8o10ufiwNykzgoKOFBXhR/SzlhUdv0WM2/tZY8XAOZ8g9ptQz6jaBI4pXPQIzJ4VWCoFK54+qs6t9+9bPhtOkbggPQtOOAfWFg9oV3+nidC8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=sFezRd/9; arc=none smtp.client-ip=80.12.242.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id CNonv9t11B8skCNonvL6bw; Fri, 24 Oct 2025 21:51:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1761335482;
	bh=J8pEsRZprLFB+bgyN5+No3D9zQP7+K5GO7ykUh+mzRg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=sFezRd/9ma2NVFM5wG/ffEsx2ZbXxhNxAV/vrtZT+vSkPJ1fjul8C28dVh8eyYS3G
	 28SXYdLPj2HOAkS6zIT5auN36sVfmNTo87Oxnm5fgr1t9uHLvGBvTUrY5gzB0x4bQG
	 rsjzderLpJRhE4eDrgDC4VM/mx8f7BTbkz4K6/tgG4KZZuDJY8ZJhP7RzHYeJU0gyh
	 My9XPVNv7KgVXGwKxH1io60i9WRSWScfVlqoJhRHdK8rp9hh1GSDsocEmk9v61X+78
	 A9lgB6umdY04PJJor81CJoIHczYJ1U/t4mN+EgJHItj3r6L0iu1E5sMwCyYkQxjbwV
	 psDZO6qKxJI/Q==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 24 Oct 2025 21:51:22 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: andrea.porta@suse.com,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	devicetree@vger.kernel.org
Subject: [PATCH] of: overlay: Avoid spurious error messages in of_overlay_remove()
Date: Fri, 24 Oct 2025 21:50:58 +0200
Message-ID: <f756e04e8bc239b33a0428c2dd055f202e214f0b.1761335298.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make of_overlay_remove() tolerate ovcs_id being 0 without logging an error.

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This is needed for drivers/misc/rp1/rp1_pci.c where things are taken from
DT or at runtime. In the former case, ovcs_id is unused and left to 0.
Being able to tolerate such cases simplify error handling.

This was suggested by Dan as a reply to patch [1].

[1]: https://lore.kernel.org/lkml/4e92a271fdb98560c4e659556a1f3e99e7d0d38e.1760987458.git.christophe.jaillet@wanadoo.fr/

---
 drivers/of/overlay.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
index 255e8362f600..5b4f42230e6c 100644
--- a/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -1190,6 +1190,9 @@ int of_overlay_remove(int *ovcs_id)
 	struct overlay_changeset *ovcs;
 	int ret, ret_apply, ret_tmp;
 
+	if (*ovcs_id == 0)
+		return 0;
+
 	if (devicetree_corrupt()) {
 		pr_err("suspect devicetree state, refuse to remove overlay\n");
 		ret = -EBUSY;
-- 
2.51.0


