Return-Path: <linux-kernel+bounces-820538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A64B7DBC3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C883238D7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 11:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4222F547F;
	Wed, 17 Sep 2025 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="k8S0kp51"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020B32EC0BD
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 11:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758107626; cv=none; b=YFdyzs6NcENIKX9vUOCEU5xjL03GDn1/oRiMmAaR50ZgTzhC2hWyAHtBBsRLXAZAXSyU5LO66ttPo6m7VIMyyrqQ1dsxvs/0ZyDw53NgwvrUokQVAvCJ5fLbN62eHVMIwAK+UlPx+9Ly1Z70c4YXuJU+dyxIDgUFnqQl/uUDyJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758107626; c=relaxed/simple;
	bh=zQe/z+qDYNsZ6M5CHtOZnyOAH9P7RZo8QdnI4PDOo7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZMvMHzci4C8zVnLy0hbHt3GwBpUFxudpfoLM10hw3OLY6oHw5hpvBn74mL3Ut+rFMMGQKfdWfTfjISjJpdC5uzfO8i1s5VZ66JBYVvxmIGjTQsFDXCZWCo0S5hjGGGbjYIXN254lxVYq+Yg4mBcnWCDSQeH7xvNzuTll4rWUEKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=k8S0kp51; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-261682fdfceso8350865ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 04:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1758107624; x=1758712424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gpVFnQJK85Q9Z+39jpO0lJZZc1Nu8KNAXStfs8r/sJo=;
        b=k8S0kp51W85ZfkYPDdAXhZuHGXA7zQhZaSAb+9YJcP4Y4rTN8H/y1H4+TRVd6QH3wW
         1o/Ktjtza922XqQzNbJWWoKdUgtD2IqcvTvA3B4+xJv2fz1XQw4gRrC1ITLgGNrtcDm4
         +HGt95N/BxbV/RgNkIZlWLF0j9cOrbEuiTycxNNKkee56rbInFKW8dCmA9uFIVBC6rrX
         4ZZbezvb0auMGzGTZtWEei+QrSAYBE6NSBn145xNBnJQHXILr3IiiFbZe0Vr8O0/10jz
         KwQzEcR6QMNgXdVJ2uEjnYQjQPn63dWbtO5c85Duky1lNaHR0b+S7kpq5bnLCqDfRM6t
         lScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758107624; x=1758712424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gpVFnQJK85Q9Z+39jpO0lJZZc1Nu8KNAXStfs8r/sJo=;
        b=Xup0DD3nRt+Km8co9UZaAT6Cz6qmBIU4mgL3L6+e5mEQyU6gfsVuE7N/o4oYHf320k
         VnhebKxWG22nnw4p/nL11lfG6V6QJFajFa4e3Ji7IIMZl2Ht9wxF6239WPHBq6hpc1AZ
         qSq47zHueG9JZFfjmSQR+CapNh5Hkq12HiqOtJWThLyKaoqahHrfatcSbKuIeiu9JveZ
         4x0QUue8VmSXn5Nw0pmCFv03E6YVzPNBIZ/nKLm+W3952rBVQP3fEwQ4K+2vKY2gEZTM
         aIgcv87EPrCfWADbQ/5i0HXPVKS7jSVopBeIqQ/5gkQYq7AMT+XcyBS1cjszgCjVvQOy
         5QsA==
X-Forwarded-Encrypted: i=1; AJvYcCWtebHFFwP3V4+PiQOI9w4WOcIZvf2LaWJlXUzzfW9iayVdkAGVZDdQcpItQweS4eJ7bJglBCgZSdBWrgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPPat58W8uFQPfkKAVMyaGmBONaZrRm7sn5rhOzCwZvfG8KRoC
	DBaYdLdmpZ4U6qGs3t3PrkMJoeiagT8jqeYOY/FiFiAo7L7EhMW/na3K3AoPY+uAquk=
X-Gm-Gg: ASbGncuVd4KDLlxj+jIVL5Yu1u5+FioFD6yjtOhcowVs9eptNadYFRZEr82nD7OVFfY
	hQ35POp1RkdBLPrWuzAbfZbjEW6VJjrFDCB1ggbmmSkrKf18J0ybphjhQ4BETCw+v5ik95Uv1XB
	jQdn4WnooCUS9uA5xhuTxV74SmCLku+RVdSvV0xOxZnYq83yQdwrfwkL8zQzFVOaYxXiV2+Dxe2
	PV93V7qRX6qoUNFUEtMdlRRTYya/2epOXQ65HTag+RsqQrcAs9argXgIBOcCmIdfqGBuXcLG1U9
	JMv0x39Eb3JlPa3Puv3KgJQLZKCj76wUGABMacCchvVwM7GpX2qVp/VxL7/jzWpeZwAokoKvSHd
	XjDQxrEmzyzcTlNZjLVgl2zb1OOkJxEt2MlNlLGAO5ULfp+0iLcppRfkI
X-Google-Smtp-Source: AGHT+IGBK3w7KSmxjJxg5GKNR+TLS8twm6DWLFyjs5+Ei7BBZUVpj/ST7ilq6me4VOBB/aZBOm/Vbg==
X-Received: by 2002:a17:902:cec2:b0:24c:db7c:bc34 with SMTP id d9443c01a7336-2681097477fmr22668825ad.13.1758107624269;
        Wed, 17 Sep 2025 04:13:44 -0700 (PDT)
Received: from fedora (cpezg-94-253-146-122-cbl.xnet.hr. [94.253.146.122])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-267b4ae8808sm59079655ad.132.2025.09.17.04.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 04:13:43 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: luka.perkov@sartura.hr,
	benjamin.ryzman@canonical.com,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/2] reset: sparx5: add LAN969x support
Date: Wed, 17 Sep 2025 13:12:36 +0200
Message-ID: <20250917111323.60781-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917111323.60781-1-robert.marko@sartura.hr>
References: <20250917111323.60781-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x uses the same reset configuration as LAN966x so lets add support
for it as well.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/reset/Kconfig                  | 2 +-
 drivers/reset/reset-microchip-sparx5.c | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 78b7078478d4..35cb84d1de4e 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -170,7 +170,7 @@ config RESET_LPC18XX
 
 config RESET_MCHP_SPARX5
 	tristate "Microchip Sparx5 reset driver"
-	depends on ARCH_SPARX5 || SOC_LAN966 || MCHP_LAN966X_PCI || COMPILE_TEST
+	depends on ARCH_SPARX5 || ARCH_LAN969X ||SOC_LAN966 || MCHP_LAN966X_PCI || COMPILE_TEST
 	default y if SPARX5_SWITCH
 	select MFD_SYSCON
 	help
diff --git a/drivers/reset/reset-microchip-sparx5.c b/drivers/reset/reset-microchip-sparx5.c
index 6d3e75b33260..28ad8f1298a0 100644
--- a/drivers/reset/reset-microchip-sparx5.c
+++ b/drivers/reset/reset-microchip-sparx5.c
@@ -198,6 +198,9 @@ static const struct of_device_id mchp_sparx5_reset_of_match[] = {
 	}, {
 		.compatible = "microchip,lan966x-switch-reset",
 		.data = &reset_props_lan966x,
+	}, {
+		.compatible = "microchip,lan969x-switch-reset",
+		.data = &reset_props_lan966x,
 	},
 	{ }
 };
-- 
2.51.0


