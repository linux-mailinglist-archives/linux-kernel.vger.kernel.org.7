Return-Path: <linux-kernel+bounces-860283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2928BEFBDE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 09:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02173BF626
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 07:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837DA2E1F02;
	Mon, 20 Oct 2025 07:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aBPTLW5Z"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2448342049
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 07:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760946827; cv=none; b=e2PUu3hpcErCHmIj+g1g5PXfR/OTzGHBSdGLtJis3whxziEuV01+M9psW6K9XdjHFeLxDxFojraERV97J0N/cwJMQRaJXDCJJ6uHcpOw2ODaVVltnCGxmPI22rcxipCX+srNhj1C087gfSb8ra8ImDkB6FmVj6bXR6lKt+gyEa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760946827; c=relaxed/simple;
	bh=JwLO30rRjM9bQPjtjPEvj/O3H+X2OBrB2JLgzBxJfS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DFCGfPIagn6dRxQ6F380eSsduRV2tJxL+QJEbtsncAkFeGGxsInA+wUSgzFdadg2FwtUbJIm9pcHHLA/jyzVuOkIHpI9yyW+gVz6ZP4QxtDcdR3wbMhAwMy1VB6z1rHmoywI4Uz1rLNgxQxKU8Q5jFHq6k8w7WwfSZSjWP6sNDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aBPTLW5Z; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57f0aa38aadso5365690e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 00:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760946824; x=1761551624; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EdH/aHJWX8AtmUkNQDRfe8AmPloc8JdVisE1GgEb4wk=;
        b=aBPTLW5ZpYvZ8vph1TDpEcmjZb2SpBoayOQtW4NyWelawnP0W5Oe4DLS7Nv8sLWLh1
         TRlcNohZgZCqdloHks76dI6AxC7XhUhVrz1SvHpV7jAbbyupnpGcusJQCSEXJspe1De3
         ayxIkx+DgwWgXl2RGSjHO6O1HG4VGNJVvvBe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760946824; x=1761551624;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdH/aHJWX8AtmUkNQDRfe8AmPloc8JdVisE1GgEb4wk=;
        b=pudSWV9kHSJmyzG+w4PzCX3NAnr+PSO0nsYc3IsbylcN5zrV4+bHugwLCJe8KlQ/P4
         WsdOxG0r1EBKD0rUi63c9Jsrhz+nBJB3a42wetr8d8CGhTusnT0I90drmCg8XcNdkqUw
         7u2bBepC88hMWWO2A3D0nGvFptvjmsf7l4kENLIOAWjmirqI1WHTKF/5GJrGtDtx3024
         EpjDNVhq+zxOBKyHa0plGoDld2CZzdu9OJcoEWzjm9NRkV7Ne+BWH5bXifBCsGLyHsCP
         +R2Ora54dbW9gcq73MflPhC+vswwHk0ZAY2Wh+F9b0YEue7ZQySRbol7dtjo6k8qOGGo
         ppQg==
X-Forwarded-Encrypted: i=1; AJvYcCXwBO1Odps6dAQ5wtWOQ5RaCWU5ehlJGd5zLoARn9AaOFUnhpCWgggk1fHNStTVyqWwV/tjQwPlqwvghJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS2vIfXxHP4KmxS5HMxtRRc/zGBEFvC/XrGil4LZznTXClMpm7
	5ZURUbYrwyJXgK6cNsmfe+uDFzbU+KHMZYfcftj3N+HVEGs5h3Q/V2M3REuolQ7yVA==
X-Gm-Gg: ASbGnct8sTCsgXEtWZRh/wKk843gIflTFh4c2PL+Eh4K+ZRyVzy2tk0iEUilp9ejdi/
	JrPaTaTx9el4vuaAmX/OYhRIlvccDI3DjOhIg3GqWHBZjLD0aJaXqgbiqhKTCsYIlAvL+ai7Xe+
	Gt77fzAerwuICWT3ROrW3+/XdGwkQJz1v3QEPXEKQAk/MUUZO0pNmPkOOGubEt+xrOK2Mg1/oQB
	AsWmkOK3IbB0Z5n/0d2RrwHPYJUZ6IiBAMun9vOIUTxIVYVlgNgBWx9SFG2BcRzSx30hnTj1snF
	XIqLZS+mX2UhLRJdPfon6r89nUVw+5mKxa7EEfb5zKVrq8mZjCijyuSYn0vkbREBZBsSc7Cphse
	BVoiI1dR6ky7iZ7vJ4mPIQNnlHm5N74bI9mInvOEGttnjWEW7Mf8wuDu744zVMcET47dJnVSYna
	XpT20btsqTNhROgS07tTokL40JJvZYE0vwn0IOcwVZId+pzjlXGiRmGbnA5LNl21elAg==
X-Google-Smtp-Source: AGHT+IELRftEatZGxbBt4UC4lC7RsQ14Oku0Jj8SWrZA72t9gBWlXbAP1Qxkh5MKzJIEp9Ob6+Dr8w==
X-Received: by 2002:a05:6512:31d3:b0:579:eda8:6086 with SMTP id 2adb3069b0e04-591d84eb765mr4937323e87.8.1760946824117;
        Mon, 20 Oct 2025 00:53:44 -0700 (PDT)
Received: from ribalda.c.googlers.com (166.141.88.34.bc.googleusercontent.com. [34.88.141.166])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def167e8sm2284492e87.65.2025.10.20.00.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 00:53:43 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 20 Oct 2025 07:53:41 +0000
Subject: [PATCH] media: renesas: fdp1: Use %pe format specifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-ptr_err-leftover-v1-1-150b0f8b46b9@chromium.org>
X-B4-Tracking: v=1; b=H4sIAITq9WgC/x3MWwqAIBBG4a3EPCeoUVFbiYgufzUQKaNEEO096
 fF7OOehAGEEarOHBBcHdmeCyTOa9/HcoHhJJqttabTVykcZIKIOrNFdEGWapp6KsYKuQCnzgpX
 vf9n17/sBuIJyhGIAAAA=
X-Change-ID: 20251020-ptr_err-leftover-1997b3a6e06e
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: linux-media@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

The %pe format specifier is designed to print error pointers. It prints
a symbolic error name (eg. -EINVAL) and it makes the code simpler by
omitting PTR_ERR()

This patch fixes this cocci report:
./platform/renesas/rcar_fdp1.c:2303:4-11: WARNING: Consider using %pe to print PTR_ERR()

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
It seems that we missed this file from the original patchset.
https://lore.kernel.org/linux-media/20251013-ptr_err-v1-0-2c5efbd82952@chromium.org/
---
 drivers/media/platform/renesas/rcar_fdp1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar_fdp1.c b/drivers/media/platform/renesas/rcar_fdp1.c
index 3515601030eccefe3d979303893c93c85ab0a9b2..672869815f636de25ce08261bf327f156b617a37 100644
--- a/drivers/media/platform/renesas/rcar_fdp1.c
+++ b/drivers/media/platform/renesas/rcar_fdp1.c
@@ -2299,8 +2299,7 @@ static int fdp1_probe(struct platform_device *pdev)
 		fdp1->fcp = rcar_fcp_get(fcp_node);
 		of_node_put(fcp_node);
 		if (IS_ERR(fdp1->fcp)) {
-			dev_dbg(&pdev->dev, "FCP not found (%ld)\n",
-				PTR_ERR(fdp1->fcp));
+			dev_dbg(&pdev->dev, "FCP not found (%pe)\n", fdp1->fcp);
 			return PTR_ERR(fdp1->fcp);
 		}
 	}

---
base-commit: 8652359fc004cbadbf0e95692c1472caac6260c2
change-id: 20251020-ptr_err-leftover-1997b3a6e06e

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


