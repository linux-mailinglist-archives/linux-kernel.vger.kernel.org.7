Return-Path: <linux-kernel+bounces-771211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C787B28438
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 18:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AA4C1880231
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD79B30E833;
	Fri, 15 Aug 2025 16:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Ktves4xJ"
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E030E0EB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276267; cv=none; b=LSiSGJ/aWFIE/bVABRj8qvhl/eg54HOVLj+NfbBo4aVJmBveWrC42r23Zidq83a5wwwQvJor8ZTCO6wpcrqiluaujkXFaSUk0FZjcaTb94b6/KrxHAo8QPXHczrr0+k3lJGqeU6NrwqeR05/m9qfTSozR8GrGI00hNfmEIJjRb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276267; c=relaxed/simple;
	bh=n7I3orGRu0gT5onp+LDbL746gxMd1RG+ru+jp/oTuLo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i1yEdh/clh5xQrMEDVnsc/sbPxjeQjlUGiyTPfjugdV3TmnV9u6PfeXBMUXyKadJ+9q5NMaTz4ecEseOVbU5/PmGaSdi6ef4ySnT/tlQ+oRCXfYgDfMfNVi1lJ13sWUK3rzVJm5JHlRHZFSsuD1TrSZCD28GLEMA4KVy6UXPF+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Ktves4xJ; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-61bd4e84776so684049eaf.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755276264; x=1755881064; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2UDwSuiUo0QvF8XkoXE//Xp/LQx2Zw0bhS6vPnsJexA=;
        b=Ktves4xJKLicfsGlGAY2spbb+a8Ymemb1mK35Gg9BjZBr0Taic8uxroZgHRo4Skp9o
         wAkgrWgziey4btOGHirDFqEQkovsCQEPNlOuyV8En/D28EXK9R4h1JG2wAAOoUkhupld
         KD3X9/jeXSkV02Vq9IDhDaZAz9gU2wSYY3rndyW4D+aciN2ube0kmbPeQSPnQF4MPXOt
         FdOWbjOl4OjO0KzS1tpPn79dt1qXtp38u1NIuAB3UfoblMFxnWZo3nLj6u8V6umeU88l
         XrrUsuWLn/FB20HmGUag8wRmATYqNBwAWZARB5keWhUeyOLhd/xvRo8omhL1c/ETX9py
         WbfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755276264; x=1755881064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UDwSuiUo0QvF8XkoXE//Xp/LQx2Zw0bhS6vPnsJexA=;
        b=iDu9RRTfGLeI4/0o+imkyz74nJC2Rtm0eKTVmyLE0I7dlGbfjolEFYgsVpPh6v4tXL
         dfjcbicdI0Hh3ioj/K6l1MIhJl2wtgI7bMt9RAnCGUp9hmQksAtMUgx7+Ea5VkWLMWrT
         Z5UCi7vPbejdboQAfZmN7wHe9NkQ1h9aJPGOx1IqrLxTncW7uHeIzQA/z4I/MH2zXDfv
         Uw7kbvzh4XxkKZz5cvvbbcEvBSdrgX7hBj3+seZjV3wGb8D3TC/rpsmx7pntlbWG1Vk/
         Im5odPVTQXz1/VBdWK5M3ZZhWlJB2PNhzMZFDJcjN7i3aR63iURCzNslLfKJvHiQPX87
         LyRQ==
X-Gm-Message-State: AOJu0YyMl8/bDS0pZFT4vF14PiuhPxfrQD5oNJ0mePWxd4a+lOyRBM1R
	eqXPj/l0UIOx3xXGfKrILlaMUviCoUBaCyK4dgX9Rn8rSsWeZYLhVWPsg64RRqRnwZomeI2zt/c
	Cw1c3
X-Gm-Gg: ASbGncvIxpBmVdENU2ShTK1scWu38DCDFEmmP+IA/KCoImTthgx2aVtf8IgJKCaG+pf
	QJrez7QFJtMwJ2b1285HdvKlwHd9C3YMMNGDbF9N6/fUyrlEydzIXRerDRud81xUpaZyWdVbqZ1
	/KETedC9mJd3EnvXryNPwomKiwRlQKcXQh5162kst1KaToyOMvZ2gJ46PakZ2zNPsoUa3unQR5t
	E/6UdHY1pp0U+VkOnSq19brqRGpm2ghDL9OfloVFsNaTzfsEfnESkiRZPHxk1o1hvkqqHa/4z7h
	9yMgFuR9RqdVuGj9Yj3SAXsgSEPZFi4ZC9QHvRXvvBn6H34HFDH9v27bKWYL0RJpsDV+eTWE8La
	FuYuusR+rZaYivO0BVW4o9N5Of+6ajHI8YPFnWA==
X-Google-Smtp-Source: AGHT+IF/Nar+wKP5e3lUmEDgf1PRwtsVmJbTaF5RTOgkSNGXc3O8szqd0HakjQOSiWM3mfvEm7ijrw==
X-Received: by 2002:a05:6808:15a7:b0:435:73cc:5b81 with SMTP id 5614622812f47-435ec470c7amr1422549b6e.2.1755276263618;
        Fri, 15 Aug 2025 09:44:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:677:c1a1:65b9:2b0c])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ed1b186bsm305263b6e.21.2025.08.15.09.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:44:23 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 15 Aug 2025 11:44:00 -0500
Subject: [PATCH 1/2] MAINTAINERS: merge TRIGGER SOURCE sections
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-spi-offload-trigger-followup-v1-1-8ec5413a8383@baylibre.com>
References: <20250815-spi-offload-trigger-followup-v1-0-8ec5413a8383@baylibre.com>
In-Reply-To: <20250815-spi-offload-trigger-followup-v1-0-8ec5413a8383@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1356; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=n7I3orGRu0gT5onp+LDbL746gxMd1RG+ru+jp/oTuLo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBon2PYq33ssJJQ3essQ568WxRa51norRkiV3+IG
 T1yLolF/+2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaJ9j2AAKCRDCzCAB/wGP
 wGodCACHjX8KbW/0fYoYfOnae2echB4YW42JZs+5Q/LLKvFKhUCsX7IwqKPcZ1b357igIKpHy9s
 RdGHRNN6hEFjgPWh54Fn57LvwekMW6ZrRoG9V9kZODkXV7gcnW1mrKCabcR+CHVaAUzYUOjgoca
 hMfyKzxaVRQyH/8p1U96AJCzDD9qhCDwE7OqtYdTgz3un7oP6IjjCA9dvBHtLhAPCzUf/zCB3ZJ
 DqkEIoG24+9/tctkCBBFdHPkiADcntcxSXq7jRST2PVBN1a2AM1+M+q0e88FLghufuox5MPaMUP
 ys/TuQMik/4mcNn3+mVnvuV74YJV17146EafA5yJCpT/rapr
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Merge all of Documentation/devicetree/bindings/trigger-source/* as a
single entry.

In the previous merge cycle, there was a merge conflict between the IIO
and SPI trees and we ended up with the current state, but the intention
was to have a single entry for all trigger-source bindings.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 MAINTAINERS | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa45799dfe07de2f54de6d6a1ce0615..4b133ccae8fe5e87a03892d0c30e700cd4df3bf9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25603,16 +25603,10 @@ W:	https://github.com/srcres258/linux-doc
 T:	git https://github.com/srcres258/linux-doc.git doc-zh-tw
 F:	Documentation/translations/zh_TW/
 
-TRIGGER SOURCE - ADI UTIL SIGMA DELTA SPI
-M:	David Lechner <dlechner@baylibre.com>
-S:	Maintained
-F:	Documentation/devicetree/bindings/trigger-source/adi,util-sigma-delta-spi.yaml
-
 TRIGGER SOURCE
 M:	David Lechner <dlechner@baylibre.com>
 S:	Maintained
-F:	Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
-F:	Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
+F:	Documentation/devicetree/bindings/trigger-source/*
 
 TRUSTED SECURITY MODULE (TSM) INFRASTRUCTURE
 M:	Dan Williams <dan.j.williams@intel.com>

-- 
2.43.0


