Return-Path: <linux-kernel+bounces-752569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D604EB1774C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:45:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE6024E753F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7613260587;
	Thu, 31 Jul 2025 20:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCDdjhTA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210FA25A2C9
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753994702; cv=none; b=srOPr5B2K2FIVpElGw/d3rVsf4DRVyvYEMdhLCeGoubOdZhdx7hIOwffv8kGaBo+I6AMrSLciziENjj0Gnl3PzeoQEPyvliSDgfmuwb892girt53LMQ6twNDz4gdXv9XBENWOSOX2w/Ei3vWRnrBHG2EPQP2GsyqZcDRrMeJa5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753994702; c=relaxed/simple;
	bh=ppP8qxkYkHvFmAhOckOs6AleU2TACL5lKaMhhb9n2p0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iIxsiLqW2DeklKvaTer5vFZnoosj2YMuOBPyOowO2T/IKuoHrLPm49KeyHmbGSAjGwyFPyjv8C7HUov1xsrr10rHBBF4YJJrxhhWoSZT++/oiH7DdWxK+EYP4v59YDRc7R3VmGu5m3iTgd5UL5raJMGj5jV/K2Qld6lIpBJ7arc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCDdjhTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87118C4CEF4;
	Thu, 31 Jul 2025 20:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753994701;
	bh=ppP8qxkYkHvFmAhOckOs6AleU2TACL5lKaMhhb9n2p0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lCDdjhTAlAxQHukS4QVfbEtDf74kv7NukNO4N9bz7GVm0Cq97YingUzJ6Pc1pJ+lP
	 f9xv9GoSN3tnH3QTL3hCNSPFdiNeyIr9oDerTAGEIMs5uVDrqsaZ0npfAnYs82N8I/
	 75fpUEeFodnK4XfhY7MSrwxRJaqwAmXwYe6HaxDJgWEWK8JP1WWOBLzBfjSPi9UVHa
	 EZI3L+b1nt8Qi3rllq7M7JU0wRBIiRtlwEm3pwt3LVZfznzo1vmGWZRN6DqnFdDCX2
	 +yWdpP7qlgVhiJXUieLPrpxlbVqmlu4CNlboPnmc5vcQh6Cu5fzety2wLrION3HdEK
	 oat0mo62Iqyog==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 31 Jul 2025 21:38:18 +0100
Subject: [PATCH 1/2] regmap: irq: Free the regmap-irq mutex
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-regmap-irq-nesting-v1-1-98b4d1bf20f0@kernel.org>
References: <20250731-regmap-irq-nesting-v1-0-98b4d1bf20f0@kernel.org>
In-Reply-To: <20250731-regmap-irq-nesting-v1-0-98b4d1bf20f0@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=3021; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ppP8qxkYkHvFmAhOckOs6AleU2TACL5lKaMhhb9n2p0=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoi9XJMbQpgy/qrQ5HiM4tAL9tVTpwvUCnMv4gF
 hRbEK0bAs+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaIvVyQAKCRAk1otyXVSH
 0DrpB/4heRJgsPUqJDffZwmjdfWYv6HbN2nPYkT42k7/e55LkTBpJ19xfOzMTdu6UXixGfi0GDV
 2FK5LJU48ZBgMaowUmYjD7oM3O9598s/a8nOKKa/QDkmqzUI3MCuxKUXkwtqcr0aXo52ack23yl
 ApBxWd+Y+UxLWY1fGBNe4aCueXmcDjgJctFo/EZJJxuF9IGeIiDAlwSjAvkuvd4132MbxDMpW18
 RsTS4UelZTWv/saIOpgVvoNwCoEGktBVUeOnXVwMR/20+1Zl3mxWl++qGSj7u/0F91ZReSNqhpY
 NLxvEQfknONk5rpwQ+UKoRHuS290n5iM+vmXZ4Jx6kELaDtG
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

We do not currently free the mutex allocated by regmap-irq, do so.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-irq.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index d1585f073776..4aac12d38215 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -816,7 +816,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 						     d->mask_buf[i],
 						     chip->irq_drv_data);
 			if (ret)
-				goto err_alloc;
+				goto err_mutex;
 		}
 
 		if (chip->mask_base && !chip->handle_mask_sync) {
@@ -827,7 +827,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			if (ret) {
 				dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
 					reg, ret);
-				goto err_alloc;
+				goto err_mutex;
 			}
 		}
 
@@ -838,7 +838,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			if (ret) {
 				dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
 					reg, ret);
-				goto err_alloc;
+				goto err_mutex;
 			}
 		}
 
@@ -855,7 +855,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			if (ret != 0) {
 				dev_err(map->dev, "Failed to read IRQ status: %d\n",
 					ret);
-				goto err_alloc;
+				goto err_mutex;
 			}
 		}
 
@@ -879,7 +879,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			if (ret != 0) {
 				dev_err(map->dev, "Failed to ack 0x%x: %d\n",
 					reg, ret);
-				goto err_alloc;
+				goto err_mutex;
 			}
 		}
 	}
@@ -901,7 +901,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			if (ret != 0) {
 				dev_err(map->dev, "Failed to set masks in 0x%x: %d\n",
 					reg, ret);
-				goto err_alloc;
+				goto err_mutex;
 			}
 		}
 	}
@@ -910,7 +910,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	if (chip->status_is_level) {
 		ret = read_irq_data(d);
 		if (ret < 0)
-			goto err_alloc;
+			goto err_mutex;
 
 		memcpy(d->prev_status_buf, d->status_buf,
 		       array_size(d->chip->num_regs, sizeof(d->prev_status_buf[0])));
@@ -918,7 +918,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 
 	ret = regmap_irq_create_domain(fwnode, irq_base, chip, d);
 	if (ret)
-		goto err_alloc;
+		goto err_mutex;
 
 	ret = request_threaded_irq(irq, NULL, regmap_irq_thread,
 				   irq_flags | IRQF_ONESHOT,
@@ -935,6 +935,8 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 
 err_domain:
 	/* Should really dispose of the domain but... */
+err_mutex:
+	mutex_destroy(&d->lock);
 err_alloc:
 	kfree(d->type_buf);
 	kfree(d->type_buf_def);
@@ -1027,6 +1029,7 @@ void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
 			kfree(d->config_buf[i]);
 		kfree(d->config_buf);
 	}
+	mutex_destroy(&d->lock);
 	kfree(d);
 }
 EXPORT_SYMBOL_GPL(regmap_del_irq_chip);

-- 
2.39.5


