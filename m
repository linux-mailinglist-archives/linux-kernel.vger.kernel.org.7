Return-Path: <linux-kernel+bounces-859602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B9EBEE140
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B908E4E5F73
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 475B02D3EDF;
	Sun, 19 Oct 2025 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcW4LW6Y"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800A21C16E
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760864037; cv=none; b=hbasJhL84MoiMKvv5r+grl4f4ezs9HF281PDMQept+7BDCWNRpOpzMNilx16koeIiviYcJjsjqRWD4EOfHU4GoS+JMpvtQebSMI2+DvEniCqoU1j9LjbcfjBawFBjQWwAFEXWXT6Skc5oKYR/PYxn2xa79YZ0b5tA0j3an9zPuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760864037; c=relaxed/simple;
	bh=B7lK6WdEPVIV/jVwlFcbiH2rLakLIWiHaQY1KV2oU60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s7nl5DxqMy2RRSSdge5T4m1FV1TZcNEQvfMoXmpe4TrpJOSmR5YrXx8gglZ/VHxlfjXw1oMjrQKi//iWkbfW4fGl/8N29ciJLLf6jHoo/3c1ee9xEHe7yX10lVBPnins1vZd7do13MD4X1ZvSDZdZ6uO9SZMqAcCjKl4w2sRhDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcW4LW6Y; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-57e36125e8aso3366547e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760864034; x=1761468834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=savhjec6/koJGGQDuCRH0JcAzleQmiExHQobZiRYHTc=;
        b=ZcW4LW6YTWfiE10kDNbKgjmLfLS5XWieZFbcS8awJAi2QbkXSIgKij97na4yMd8l0x
         9yLEgSgiM/horbJBnQFPtd+zwEFzNXqUbQyRbVpk0kvd8ezOVu0Tt04RoAh1pIpMIxrL
         1LKRynENy0F5z4mWxe8WwA1GocotxDh1ZlhVg5WGjeav85BJCa4B0/x51K+lD6vb7hsA
         IBGzjQMgLMPxnbdAyooWy3zAXnMIWcr2AXiAdGkkkZiT7G9nPVZElas2RiEm8FxnN0b1
         TcyUTd8wJxzcEPDMfOt9Q+P4c1MY9rHAGJ50hV3MWM9nhgzgEJeXAS6M0D7odHQWGiAq
         KVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760864034; x=1761468834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=savhjec6/koJGGQDuCRH0JcAzleQmiExHQobZiRYHTc=;
        b=SctDgu1HK2YJB8mAUAcXQRLHQS+rn0YggBeuc2ZJ4oVU1IRmLwkSCZyihPE9IjsShr
         TbmmxHY5wNS6/LXH3RvZyfr0J4CcP5rr/89ic4iAPn9l1HqghjVC8BdG3oG27I8+eVW+
         Vo7Glxb3Vg0JBxbCP9uKhzllpT9yb+EWbs/kKcAXbdgc1K5dN71WtMX+fKZrhlDUTsF1
         1e1PcMY28Ogp3HmKVhkJ8tpOwLhuFU14v1bWhEL0zKapcIiarPch8W5p1M896EcK+8Cz
         hBSOpJdFjVFJJ7a0K2X48YgBArkKkynBNH2hafI1Sj4VIsQMFHqfE5kdbImOg8F4SUQo
         mcVA==
X-Forwarded-Encrypted: i=1; AJvYcCXHq0UXDgPlttFH65CuURpjrUgUBq/KtgqrmIaeLqatqc28ClR1hcF2Qpr7Wh7mf9mF+ZZrEMOKGwuUbQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx97alG+khcDZkCdECsW1gc/CXS5etgr5ZsgAxZwUECT8ppdq7H
	ad+mWbjgSVu/S/pclcU61ugMqr0HwoKCVFVsb8n998NqMUr4WKokNFAo
X-Gm-Gg: ASbGncuH3xPNg5WCq6ImEphbHse1BynAbh68scPkT6f3thaSX3UHcKTK73XgoK1AL3s
	lvZe1XF+xC3o31ipMjssHKjhUcohLM8LqnsEFhCrBXjPvbBboZ3g7tMMClWw81/krvYDOr91vDF
	urrtavxj/W+J9M+vElKMVP0EKoK70qZHxYnYZ1lqF3S2DdZMSlpDsdREfGWA81zin6ZWS4ItfPQ
	eeq+lb/LWzr+v7oaRrnZT7lCKpiasvDzBEEbq0OSoS4wLzbugyfvBNlS3JEPOLKtO2A75UPOskP
	3WxWJSyJ86XVWJN6QnxCThdMHfI5cvvgUsr9L4nj4yvyCjz4VMzsVULz/LnTDATa7S9PD2qAFbR
	QUaFZetSUXmj8drAu6Rcx36HbYocd5F9d9toDfbKjuvWD1hfW72qpc1zUkvU+N8Frm9ZqBz6Yv8
	0C4l5lEV0Lys4=
X-Google-Smtp-Source: AGHT+IEKPQuqSJ3g4pw+2iojsl9js/Y4J6ZPVEtChS4rkkTO+szOKn9vOGeS6hNXhnWp5Cbr/ZstzQ==
X-Received: by 2002:a05:651c:892:b0:371:fb14:39bb with SMTP id 38308e7fff4ca-37797912769mr28170581fa.16.1760864033626;
        Sun, 19 Oct 2025 01:53:53 -0700 (PDT)
Received: from NB-6746.. ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a91f49basm11972401fa.16.2025.10.19.01.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 01:53:53 -0700 (PDT)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: a.shimko.dev@gmail.com,
	gregkh@linuxfoundation.org,
	ilpo.jarvinen@linux.intel.com,
	jirislaby@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	p.zabel@pengutronix.de
Subject: [PATCH v2] serial: 8250_dw: handle reset control deassert error
Date: Sun, 19 Oct 2025 11:53:25 +0300
Message-ID: <20251019085325.250657-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aO_NYGFCKb0J2uqK@smile.fi.intel.com>
References: <aO_NYGFCKb0J2uqK@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check the return value of reset_control_deassert() in the probe
function to prevent continuing probe when reset deassertion fails.

Previously, reset_control_deassert() was called without checking its
return value, which could lead to probe continuing even when the
device reset wasn't properly deasserted.

The fix checks the return value and returns an error with dev_err_probe()
if reset deassertion fails, providing better error handling and
diagnostics.

Fixes: acbdad8dd1ab ("serial: 8250_dw: simplify optional reset handling")
Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
Hi Andy,

Thank you for your review.

The v1 patch hasn't been applied.

I've addressed your comments in v2 - could you please take a look when you have time?

Best regards,
Artem Shimko

ChangeLog:
  v1:
    * https://lore.kernel.org/all/20251009081309.2021600-1-a.shimko.dev@gmail.com/T/#u
  v2:
    * Add fix tag to commit description

 drivers/tty/serial/8250/8250_dw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a53ba04d9770..710ae4d40aec 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -635,7 +635,9 @@ static int dw8250_probe(struct platform_device *pdev)
 	if (IS_ERR(data->rst))
 		return PTR_ERR(data->rst);
 
-	reset_control_deassert(data->rst);
+	err = reset_control_deassert(data->rst);
+	if (err)
+		return dev_err_probe(dev, err, "failed to deassert resets\n");
 
 	err = devm_add_action_or_reset(dev, dw8250_reset_control_assert, data->rst);
 	if (err)
-- 
2.43.0


