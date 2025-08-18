Return-Path: <linux-kernel+bounces-774390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA420B2B19A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A221B2627A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F8BC273D8F;
	Mon, 18 Aug 2025 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Opg2GDrJ"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DCD25DB12
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545294; cv=none; b=Kk2Apt894cKYS7FSim+lHEBXU5F2Z7eLRLiF3lFjiLL0Boyv/+FkX30gsDqKp9vHpm9I5NWeV7MLz4bTOIKSP0Os2kY1opdgSud2VtlAglBjhtFU3lTDXx+rOCRJ0LlDMucd3IBZt8CWkEa8q2+By91M8KnObSzCEBq/RDK+T5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545294; c=relaxed/simple;
	bh=I1Q/5ADe/aK5ILNDdLYpOTGm5h6cDlpW8ALO+LCmpkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCQ2UXS4Gsm84AaCR//F0xvWhsqrvCWUXFGhc9YIg0fdEQd79OYzMVPvDyN7iopW1T3+/0VhnyxuXTbAd3y9axzryA13bXmFm7lHzr9xkh1kB2oQPH/BtwcWKzRzeh/WE/0x08vyqVMtW3bt1FWCfMGfq11GERDxd3UxDC79tYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Opg2GDrJ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2e89bebaso3316819b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755545292; x=1756150092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBc/8/kjXUbobC+bXkGfosbfw3HU9KPbekc4bmg+zJw=;
        b=Opg2GDrJc7Z6dEjp2AnKXNOL8sK2lk8qvz16ZjL3vxrXMUfVic7qjCaFv6YHtUEBAL
         /5V5B+hLjydcE0p1MXD6W+CVF8f35u5ciFNyxxo3Hd0lFoOhV/xnv8vAFqOGGw2wm6H7
         OCqEFAmHxPSPcHpPqr7V5xFpTE0cVf+BmB1jE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755545292; x=1756150092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBc/8/kjXUbobC+bXkGfosbfw3HU9KPbekc4bmg+zJw=;
        b=J/gpeQ8vqzhpfd1KW8Z1PAI1YNvanSdDKZCKk80C36sVy4VOPq92E5ybyZVIYGRYfc
         PM57lTV82WATDiFNF2HNBqPKQy9OlRmCpEIk0YbIvK2+h/eVE6fF503ybz+yaktGutES
         vFOi8sTHR3M7Fm/2drcDWZFC77Rquri8jI/XbvgjWPZik/e2b5BQ9dZ6UjOUwodEGpVT
         612zvfd3o5F9Lf36DKQp/Wz37HoOmix2VgKabEbNf6Bc//sfuFoMeI29QmN4U7b1BZLh
         q3YjQzmqENt6/sncipQr97Ggux0o6tbSDXdVD8qjl725Nbzw6Zthh/lXkbdyZotbyTeY
         aB3w==
X-Forwarded-Encrypted: i=1; AJvYcCUqwbuDCkJVNkd2t7aY8Qzasv1mae3oX+twl29GvLC/9NZJg1gjhaI5fzwcVaq94WAD8R7bMrk+wgKCfXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWZEkoJ7bYewPCrAbD/cNiTqK1LAAvEk715VF3SJChEYoJ0yux
	c+8NatGbmIxbG98YeegNA4coh5fzvNGnYWjKwM5SzbetZ5wl5NhHY9Y1b2CFZ36qSg==
X-Gm-Gg: ASbGncv0xldAVWZxpHIKqxQ6rWu91AjoeaGZUhrASNl4Adrb3ROcKgWhkDHnmJiozn9
	r3sPsGBLUXlil5F0kG2KMI4V2xeeO5/xinCQNsiSKHKiuW++Bqd0YO0XS0A8aJEjTu4J4VOaoUt
	GnYUz57HKCNZlyXj3jfHqgFMlz3hmMUnB/F8EbXGMF3825Bfxu+d3t8x46oq2qIWBjBaiuHvKVu
	d/sisuBC/qqs6L6pawkapCHsUz3ahlejoEfZRq4mb2EGcMFpG13O35zYSOWBvDgdyqM1Pj73SXt
	d6fITl0aWMmBAvzuFSRsKlnUdFOnRjmGRl29ClC8TNtT13hieAmaDv9Bdqu467UrGED06WuUKbk
	Se6sXXtCS6MuQf9OOA/1HUUqx5yI5Xb6x0HXqqheJTK8vAYCB7nBwF+K8LU1R
X-Google-Smtp-Source: AGHT+IHK7Wdp5hNX6Ek3lXPb7srBrzM9Htr2J93rwVtwIFEJKGnUcvWlX8Y2O869HH27Srry8sYPEw==
X-Received: by 2002:a05:6a00:2441:b0:746:2ae9:fc42 with SMTP id d2e1a72fcca58-76e44803060mr18110146b3a.19.1755545291733;
        Mon, 18 Aug 2025 12:28:11 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:87a3:e3ff:ace1:d763])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76e7d551493sm338678b3a.112.2025.08.18.12.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 12:28:11 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: David Gow <davidgow@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-kernel@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 1/6] genirq/test: Select IRQ_DOMAIN
Date: Mon, 18 Aug 2025 12:27:38 -0700
Message-ID: <20250818192800.621408-2-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.rc1.167.g924127e9c0-goog
In-Reply-To: <20250818192800.621408-1-briannorris@chromium.org>
References: <20250818192800.621408-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These tests use irq_domain_alloc_descs() and so require
CONFIG_IRQ_DOMAIN.

Fixes: 66067c3c8a1e ("genirq: Add kunit tests for depth counts")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/lkml/ded44edf-eeb7-420c-b8a8-d6543b955e6e@roeck-us.net/
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 kernel/irq/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 1da5e9d9da71..08088b8e95ae 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -148,6 +148,7 @@ config IRQ_KUNIT_TEST
 	bool "KUnit tests for IRQ management APIs" if !KUNIT_ALL_TESTS
 	depends on KUNIT=y
 	default KUNIT_ALL_TESTS
+	select IRQ_DOMAIN
 	imply SMP
 	help
 	  This option enables KUnit tests for the IRQ subsystem API. These are
-- 
2.51.0.rc1.167.g924127e9c0-goog


