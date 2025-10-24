Return-Path: <linux-kernel+bounces-869430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F287C07DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D31D0402571
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6190436A614;
	Fri, 24 Oct 2025 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="XpNiWDaY"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55EAD36A5EE
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333361; cv=none; b=ErfiMUSM/sn+OoyhUdonOSfeE31ebm5vWpe42lKvoF8R7rjwwDkyFjmrrB9Xyx/Ku8NJqBlcKcnICdVTIEsxPuAaS2173YCdtuqYshkk+OYOGfMsTa8Tc5hF5HXl5LHBJ6hgreXVtHrzS817jlMlDaCHWfpxFb1XiAMJUG91Zlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333361; c=relaxed/simple;
	bh=h91Mh4hoPgByHdcKd6/RneQUViXMJHcN0u0JxmaBjQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obB3SHdltiUd/QbK/q4t3lUpfyswKkYo5HyvEJZOMBCJ0Nk1QKvDKhfibmjk+2w0iiPxc7hLmL/Paml0sm+z9FdygoRtLUyBy8Wn6SjlCJ+W26dReNAvDsTNc67KewMbFQPRUlubsXelOSWFhpT5J0RJLn4dO/6gk0vXTi8UwL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=XpNiWDaY; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-93e9b5bafa5so88826539f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1761333358; x=1761938158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXEnNR948aKFzOMEVavf8q+kCpka+pPq8yUEtfNzTFc=;
        b=XpNiWDaYdXhBpbLYVgyZi+XkvNFkLhEmE8vp+ILBHEEuP079SIOxJSQnElBsFgYgLu
         U47BPAle3pLtchrhvjS6xijXG3FKCHPTstc/svM4GewBgf8bcAbbtX+D7bjtqZc1YerI
         DHcz8m/8UkYsNZdLNA0/vfn4zskuHvbmX1YN+xh08UdC22o84OdXnxx6XV7VDLonhH3W
         6fj+vVlkPq9tjXFrGULzCRuRX4iWoxq33Ovt8nnbgpFtclD/ktH4tjARCjc38CcnfpV/
         gWKlDgvR/VVLmLWzt7A7S2B2EYZsAV1i+v9vkqjOiPw4aQaTcjQEp3RqihzFRZEbBaj8
         sQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333358; x=1761938158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXEnNR948aKFzOMEVavf8q+kCpka+pPq8yUEtfNzTFc=;
        b=eFVZnlPv4QDYWldUeDL6ISVMk+SYM2FFq6ZWTP7vvabn8hPhyRPj3UZHogl0gNBC99
         eEEJxLg7Pqhp+130N7msrn29/rxRXqzc9RqR/R974CyloLrp9J5GdwRwkNCkIhplEh/a
         hjRJlrqllB0iJ8Sntbpvi15x/TbXRVvjHXERLk424Bp6aJj5bwcUo//xy2yqtbnAcEt3
         3v43Bjg3MRXOoydzUB3DPJQ0wyfy/yVcIqKTJhkNKZEZkBa4yyTeF37eXn94xHhs4eMe
         MEGewigLFX55i3b37cz7S9Gzphc/B7+Qd139joVV227LfCy72PlNTzh7ePdaknzRuHUD
         J3kQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGjJ8HM6ak5CRpepIS8smT1fnwYeMaC6lhVdQF1wQjYxqZ2jT4bLl73Dmbww+e7F6dH83CMTnUuM424/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq9doG9bYiFNKRKGdwKQysFOpEYUmyaQDvOlw2+Weq+sBlVJnF
	jwGdQsIl1PpeDqfJ8P7eDCafsifIANaPwP8U5wb3ddC2wVnmB3VKq+LESXyiqqxePVI=
X-Gm-Gg: ASbGncs8qltO/F8bc+jIsp38ehE79dkwi8iTyZBKqzGZGTvaMUu2J6XFlbrl2SLbtzf
	6Up/FW/FDBSS8H3As8lBMzQ7Zz+MqpcAk41aRJvPWAnn/4XLoe6uMQf2sAUkETW7sI3zAXoXKbI
	e6rjtdKEbht9vtba3uPDcuaDMc9/Bh1GLvsrOdFn/OU/by+fzp2ZmZKM3q+4jg+nd0WaImbSjc/
	uHXjQ3vTz6pK7oPQ+BvnL4xHriftXqr+PVU2ekLmW1TF24RQ2dSkxZfT2vGaHfvIIGXJW4x7owt
	ngldexL3CY66g8pLi9+29y3Jb9jVNDa8APOnD6C9oSF25Y1tC4SXVtIsRbV+nz4NOELEDQ5x4gc
	GO+chhFb34mFrlxbXo7yjQmIeu23n/JAdvW31JG04H563cZ4k4GX4Wy/KUNwWqniyF8UonVNb1j
	+8A/RQwIl3HQAYyi1ZmoBbg7iXNJvy4OpSLTeKohGHWBA=
X-Google-Smtp-Source: AGHT+IEtD+Cr8mACF/K0NonNKa9lBHI7Tp+o5Vfp1juGLlBk90z7fTUTAMVH9dichKlDp3Ypt60Lnw==
X-Received: by 2002:a05:6e02:148d:b0:42d:bb9d:5358 with SMTP id e9e14a558f8ab-430c527f7a5mr415578465ab.27.1761333358489;
        Fri, 24 Oct 2025 12:15:58 -0700 (PDT)
Received: from zippy.localdomain (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5abb7fdb7c7sm2427824173.44.2025.10.24.12.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:15:58 -0700 (PDT)
From: Alex Elder <elder@riscstar.com>
To: han.xu@nxp.com,
	broonie@kernel.org,
	p.zabel@pengutronix.de
Cc: dlan@gentoo.org,
	Frank.li@nxp.com,
	guodong@riscstar.com,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Subject: [PATCH v3 3/9] spi: fsl-qspi: add optional reset support
Date: Fri, 24 Oct 2025 14:15:43 -0500
Message-ID: <20251024191550.194946-4-elder@riscstar.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251024191550.194946-1-elder@riscstar.com>
References: <20251024191550.194946-1-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for one or more optional exclusive resets.  These simply need
to be deasserted at probe time, and can remain that way for the life of the
device.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Alex Elder <elder@riscstar.com>
---
 drivers/spi/spi-fsl-qspi.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/spi/spi-fsl-qspi.c b/drivers/spi/spi-fsl-qspi.c
index c887abb028d77..1e27647dd2a09 100644
--- a/drivers/spi/spi-fsl-qspi.c
+++ b/drivers/spi/spi-fsl-qspi.c
@@ -36,6 +36,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_qos.h>
+#include <linux/reset.h>
 #include <linux/sizes.h>
 
 #include <linux/spi/spi.h>
@@ -267,6 +268,7 @@ struct fsl_qspi {
 	const struct fsl_qspi_devtype_data *devtype_data;
 	struct mutex lock;
 	struct completion c;
+	struct reset_control *resets;
 	struct clk *clk, *clk_en;
 	struct pm_qos_request pm_qos_req;
 	struct device *dev;
@@ -857,6 +859,8 @@ static void fsl_qspi_cleanup(void *data)
 {
 	struct fsl_qspi *q = data;
 
+	reset_control_assert(q->resets);
+
 	fsl_qspi_clk_disable_unprep(q);
 
 	mutex_destroy(&q->lock);
@@ -902,6 +906,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	if (!q->ahb_addr)
 		return -ENOMEM;
 
+	q->resets = devm_reset_control_array_get_optional_exclusive(dev);
+	if (IS_ERR(q->resets))
+		return PTR_ERR(q->resets);
+
 	/* find the clocks */
 	q->clk_en = devm_clk_get(dev, "qspi_en");
 	if (IS_ERR(q->clk_en))
@@ -923,6 +931,10 @@ static int fsl_qspi_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = reset_control_deassert(q->resets);
+	if (ret)
+		return ret;
+
 	/* find the irq */
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-- 
2.48.1


