Return-Path: <linux-kernel+bounces-865215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E39BFC84C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 16:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119B818870D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 14:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED2E34EF15;
	Wed, 22 Oct 2025 14:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POWMSZJD"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1C34C807
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761142924; cv=none; b=FXTaks3JD1Pq1dkgbh4SCyXAgc6HPnlLQWwn0Rz9BC6drhfqAjktNidoDpiJQv/un/ySmWOQoiYmUP5PQBTBGBvfEKktCvDdRcCTfY0uxFZm0I3tdcz7xQALGBDWbQgleiISiBKJ2A+zYS5LmWZrUIKk4d0u4bc6weI9eYZAUbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761142924; c=relaxed/simple;
	bh=LMNj3RJtvSAolKc/cNyymmQWeXKMjtcs4eYn8DUf4jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ONjBP35UiKY8TPLmhJgKpNNNGEKyj9GZueLFREz6d1iHeYqwj1UOoCkkGijnyZnmFneGfYIfENSU/lOxTJP4NolDZvqALlVQ4+F9aelcYz1HFQBoqcItcNUH6/VTO0Xl74IzOXOwUwQB/HgBq6Z243JKztI/dhaWE4VvPM8PGpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POWMSZJD; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee12807d97so6410866f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 07:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761142915; x=1761747715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNqGqTCCsfPGbDV/XUSDGT/efKZfdWLbKEq+jQy+Hag=;
        b=POWMSZJDp7lpsCky1EgRlQLwH1w0TX/qXwWgEcXcEJUONjXLwGvTyMQw0U2PtwwaUR
         dDMCX4sTtRfHgL0W9UkSwGe6eybkaEJ7qWlgMe720o55F8uZUUF3JAXFzU6IyEAyytj6
         4WjEX+huRmlGu9NzEh8moCPBJ26OMDBNekWekIC43RP+ZUS9ODog9d4uxeVNoxfF0O1t
         eue7s3PqjdubmPWcRNi93cq+9MYgwn9hvlNbxQjQxkzb38cyWhuzi5cTEngosZudg9DT
         83r3THfeh3s+CinBLeFPEWi0KpQcHmy4wBeOnybQFnPv/N9cGRKyFrbDEDpYylBoJzv+
         Uvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761142915; x=1761747715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNqGqTCCsfPGbDV/XUSDGT/efKZfdWLbKEq+jQy+Hag=;
        b=nUlN1A76avDCIKP5YopiZhdvENCmgVlQYcrJdBA4pixtnbftp4QH1GoL7+zwI12JXc
         co82WwH54gkpr7kfigW13Z/FFaodx6Bbxe/2CzylZLQtuE3mzKoIMvgUR9yxeN8p5qtH
         laPRWe2i2aLkdMrxIpV7Z+ZTs5hYFkAGJrCe29tdhFj8Ouy2F74IjGpCUzI4W2XoOOkj
         3QdUq8GQDqWoPvHB3vyVvmP2JmBDkXWG5Y3fKmuq3CplZyEqxAqsAFw/Yp+nlXYCYrJr
         l4lX4M2Yr7WUvHlseItCQAQa6zCrkrXAHcEzi2bm8D7oQTzgAcbsQ+ywNZGq9TgxtwgQ
         Hnzg==
X-Forwarded-Encrypted: i=1; AJvYcCVDUORA5lvBNQNb+u1oryy7/+SLHMMLeo584hhzB5nbeHTYlwgsBYYvMDlk6RiWeruezU1l89T11kKr82E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBVxZRcMwvVkhZ+4BeRLwum1rFXcyJVpvg3pUT29wnvXnKRT8j
	vu3+KlmGTfnTEU8LV2jsEkzuP8sWekDu7C5A8/yvLcQmKDQw5z/dlVrv
X-Gm-Gg: ASbGncv5F0mCJfpqMy7jVWbOCd/2RxJao5Bbd6UkTxR4+iSgFJVeIrx/w0yn4pO+TvN
	lFzts7opabWwgClw67seUalJbMBwMCCQn5S05TWT9T1oNBKh1vKvTkuG9Hs2Wcvt5ZdARJotROs
	4YLBoAFxqOr7SA6ic5xk2WnpCRUPerGKg8UxwFOrzrYl0zI3fml23RgbjqGVUyj9tCF3YSPnH4d
	ia/jcktmpGp3/hxFOKFT61L9OpNqWak1l1pKpRfuiOQH2WoQY7LVZMAvhLrNUXzt9Etx9x8bXMx
	8iF6+OWmVjjCAj4P8Pg7x6RsPw/+JtOFvU74I9+5Qr+Mlhesvql//nlhaMxsNcV0qFnNAglqcC6
	EvfYAibPYpUxIJhLwBrJc9HHoVYuAkom+aPD5M/APrVFyGskJe5sAl9gyFWyGeQNzc68=
X-Google-Smtp-Source: AGHT+IFX0XnrlT4GW6rKQFEmK1orh25Up0PxK9L9DQEcm8KVBweiXSL9uA4QjEkF/hiMIpTbvZ0SpQ==
X-Received: by 2002:a5d:64c4:0:b0:426:d51c:4d71 with SMTP id ffacd0b85a97d-42704d44253mr11937579f8f.8.1761142915306;
        Wed, 22 Oct 2025 07:21:55 -0700 (PDT)
Received: from xeon.. ([188.163.112.61])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5b3d4csm24803518f8f.19.2025.10.22.07.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 07:21:54 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Dmitry Osipenko <digetx@gmail.com>,
	Charan Pedumuru <charan.pedumuru@gmail.com>,
	Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
	Aaron Kling <webgeek1234@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v5 18/23] staging: media: tegra-video: tegra20: increase maximum VI clock frequency
Date: Wed, 22 Oct 2025 17:20:46 +0300
Message-ID: <20251022142051.70400-19-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251022142051.70400-1-clamor95@gmail.com>
References: <20251022142051.70400-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Increase maximum VI clock frequency to 450MHz to allow correct work with
high resolution camera sensors.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/staging/media/tegra-video/tegra20.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/tegra-video/tegra20.c b/drivers/staging/media/tegra-video/tegra20.c
index 93105ed57ca7..149386a15176 100644
--- a/drivers/staging/media/tegra-video/tegra20.c
+++ b/drivers/staging/media/tegra-video/tegra20.c
@@ -598,7 +598,7 @@ const struct tegra_vi_soc tegra20_vi_soc = {
 	.ops = &tegra20_vi_ops,
 	.hw_revision = 1,
 	.vi_max_channels = 2, /* TEGRA_VI_OUT_1 and TEGRA_VI_OUT_2 */
-	.vi_max_clk_hz = 150000000,
+	.vi_max_clk_hz = 450000000,
 	.has_h_v_flip = true,
 };
 
-- 
2.48.1


