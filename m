Return-Path: <linux-kernel+bounces-732646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD2DB06A09
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 01:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA381AA4C92
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 23:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3521C2D839E;
	Tue, 15 Jul 2025 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTl5R80x"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577442D77F5;
	Tue, 15 Jul 2025 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752623181; cv=none; b=UiMKwhzuRwDR5Cs43zP5DrWmBQSdVJZdIiBOELRa39nKUhJqS3aNXPXSO72snLyPDElbk79G+RTOhFlPqSa01BLXJG8UZdox0N14KH6o4iuMep8/reanIaHGw6QVSS+gTSiyBccwAYGiKkzfSZY9i5MKYwHff03Ae+Pm3UTYe5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752623181; c=relaxed/simple;
	bh=k6Ek1V0zFww6cTykRAAu80fQP06Gke8Nizb83BaqAJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kGBeDL2dmobCV3qA8bTm5NXxCTEdXkPM8ccDaDLdzLbkBZcqoHyhnhnd68BlLBtacyxNhkoNX/IuxkvUjQFZP9Ffan4pSI6TfYCx3Fz+sSuigTDJw3bF8xCdfyqJ3D/95rGIxCnxvNMIBwzBKHiHzBjAtuQqqCpEJG0bWdozdkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTl5R80x; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23dea2e01e4so67894285ad.1;
        Tue, 15 Jul 2025 16:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752623179; x=1753227979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bp8YHaUYlt3FEpZipGcvq1XyhTc8r4Get1J5KKVgG6U=;
        b=RTl5R80xYT4vnAhojsF10AVHuuMqQ60YIjBajdMgiPCotgLeVrQxBAHmcuHagoQCSF
         U0CeSoYh8KFozimzGeh8TqRfRkc6zzl7RM9j0UwjBIKmWPnc6ggLfyDWOoTiFyiJWUxP
         auWX82PHhTAlv5vuAT5E1hnxV/gUawPWeUbtpzsw2psp0h9R0mj+O/HHiiWo5e5yilfc
         V7oA5ecrHxip+UJiOSt6kM7kz//siLkCXGQ18q2/Hy/W7ShyT8m01WMc9iqub9/Un8GL
         RZFp4KQla8VrEM/dfGCzl8Ge5zKh5sNIII1QuqjkS0qXHw6DS6ClxF8H0QHhRF9vrOOu
         Krfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752623179; x=1753227979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bp8YHaUYlt3FEpZipGcvq1XyhTc8r4Get1J5KKVgG6U=;
        b=Duq9NXfKNUkXapSEHwzqJJVmjwpraiEUcQBxsHTEnkqdxEYGH7muZO39Ugz42kbWQu
         Ti/IVcPnIRNGUO65IrC/ReuON6eNBnWu2M7lrFDOhfWptLgohmSS4Dg8mVaGh7ltHoQS
         a5XzIJuOACIvp0YW6KOXfEMfxeHDwDM1OS03cegBBYLoM0M7McV/GJZRKgQ+pAN2Y27W
         ME4SiQPOq0hShNmPCq/OUKj571KyfhnpZEfSt5/XSuFIndMtxbgAtXwChuObqN5B6rlK
         P1qhE9EKf+AF4gmWPBkE8Opv7LjOSeJPcsS1govRUhRerCsHk7D4JJXsORoLVBy5yxug
         dWfA==
X-Forwarded-Encrypted: i=1; AJvYcCWpBu3kP6rs5JFTKWwIWlT7ej59oHj1nSynG2ZrXpb5OX0LNSjj2UESAMha3JyZbclu3bsLbZbmK7Iu@vger.kernel.org, AJvYcCXGzKGwbGhD/3FDKNyBoK4yMZfXmO4m+a3kP4I+Oq+MqcmkAgeAxfcxfpJPAuey5fK6iBfa7WkNV4PIYSWB@vger.kernel.org
X-Gm-Message-State: AOJu0YzOyJDITlFdtvQuQ6Le4KyQWBO70akIopv5j5DkjEwBuCg+Uf/Q
	txP8C4JFAzqW6BgOZI2TTzb3CByn6QS0hbQwNLlQz8Q7nKmsbXSYe5rW
X-Gm-Gg: ASbGnctR25L/JUHB8WNQOIs+Ckj88bvNuFUVqz0bB4S9QvfcUvQq4pvWTrmmYz4oe17
	HFXJYSsBdyPJgZ21jTsaeK1EeUSVYV5KQqHqRGdyZO1C7vaMmADVb7veA40T0DQ4iMgb/k8ku16
	hdZPia28YsF4MVrGjIl8dadkPjhAWeDNnpTqEUjlGfkKpYVyUR6+KO2kaplNUZIOsR5bLyPkaQS
	b3nAyaDKQJN+nzgct3ccruEYzqTV/V9hLYjIk4TjqhGkoDeynptjvCgxVw64miwpARyrHpCNdEa
	GEOoag7Ouj5eNpWXW12XTBaElVd1CQ5wqQoGTxuo3NIvrkgYM7meCwVSN82EHZbbvPhBFfVLmIw
	Jwi0dMtIpSINfdUGA6t6qHMJWzHdAIyq91Qd/snaB
X-Google-Smtp-Source: AGHT+IGLkH/wdKFd+75SSyrOh1cDKiBg7GtdCVxnE/02FgYw1Y9r43ihQWjCRdkaMfD/gTqEvDbaFQ==
X-Received: by 2002:a17:903:1aeb:b0:22e:5d9b:2ec3 with SMTP id d9443c01a7336-23e2572af07mr7511155ad.30.1752623178673;
        Tue, 15 Jul 2025 16:46:18 -0700 (PDT)
Received: from localhost.localdomain ([207.34.150.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42b28a6sm120031265ad.87.2025.07.15.16.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 16:46:18 -0700 (PDT)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	=?UTF-8?q?Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] reset: bcm6345: add support for bcm63xx ephy control register
Date: Tue, 15 Jul 2025 16:46:02 -0700
Message-ID: <20250715234605.36216-2-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250715234605.36216-1-kylehendrydev@gmail.com>
References: <20250715234605.36216-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ephy control register on bcm63xx SoCs contain bits for
resetting individual internal phys. Use the existing bcm6345-reset
driver to set bits.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/reset/reset-bcm6345.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-bcm6345.c b/drivers/reset/reset-bcm6345.c
index aa9353439e70..56518f7bfbb3 100644
--- a/drivers/reset/reset-bcm6345.c
+++ b/drivers/reset/reset-bcm6345.c
@@ -119,6 +119,7 @@ static int bcm6345_reset_probe(struct platform_device *pdev)
 
 static const struct of_device_id bcm6345_reset_of_match[] = {
 	{ .compatible = "brcm,bcm6345-reset" },
+	{ .compatible = "brcm,bcm63xx-ephy-ctrl" },
 	{ /* sentinel */ },
 };
 
-- 
2.43.0


