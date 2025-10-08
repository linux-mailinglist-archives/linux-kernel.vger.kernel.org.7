Return-Path: <linux-kernel+bounces-845132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C12CFBC3A8B
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 09:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CEDBC4F7A70
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 07:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228782F8BCD;
	Wed,  8 Oct 2025 07:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maMAs5hy"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707892F6579
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759908700; cv=none; b=Pn8UGnjj9Hf1o2YN+8Vclr7G/VMnfTFho8YsgH8kTK6E0lLFDL6yahajN61vrYdxUdxUn4Oh0cIGP3yJJOVmotioyqzHPdYKg4r+x4UpTTy64MIX4ZEZy6VDwPzmWDcVmXy6EyB4yVF3EquaTMSDi5PtDkndXLOFaiJ+0ggkyFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759908700; c=relaxed/simple;
	bh=PeHm1wrR0AAPSTDMxiNgwUZQ4BKQBSCJMUznSgFPtDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YP++6tp4UsIaqT5SPU6o//vMNUPTpmIKd3Ngg4xH9ohDJe4Bkh444iI58b5xuTU2MAz8jyrfE5ArcRnfW0Sj0gOvFlY7bPHa+RndkciFKhhB6ZunSpvv68jBFMHzChBQFmiG/2vf0xhB+DDz7bHkv9CQquwE94elxu1mI3t1SGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maMAs5hy; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-57da66e0dc9so7017155e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 00:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759908694; x=1760513494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GxcQ3SZL/bX2w7ws13Plp9aplxV6uyygzePW373+H0o=;
        b=maMAs5hyEz5a5uZb1WoD6pTZmz5xgW3P77a/X9yx78Awk7p/fz6DcKUxef9AfuSVTn
         w58Cctw8fylUo2AIbIyGMmL27VSa84NfUf599QU54sFB9832lFWJJp1dY7YauBdNlDxg
         h3Gp5Isv77przEuwVb42Tt030rpNxypEVbE4AjRc4XLZU0kZNT3aLP06lPJM5MnghOHb
         TqJrlPFBf50d/wYLFfMd3qAGyMZ5YZqXw0wAZHrG2tnOnqFPxpqNJ6ObqRd+SyXraI9K
         hv7gluOoA32NJ6aZX4e+yU1ikobAxIsBC7dZX4ezicV+1kcsIRfVk31Icl19TIXOjOBw
         sGdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759908694; x=1760513494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GxcQ3SZL/bX2w7ws13Plp9aplxV6uyygzePW373+H0o=;
        b=NabDTJgAAO8rycxtZFYQRaLG88EZFfYxH/kbbXZjeW+bZYySywfx5KHwAf18Ylj0wM
         U7+nzXm4SAl/hwapJaKq3NWkzyb/k2SzfFRwZ+6ieEdl5yMC4BP4j8wj9yLPndlD9VgF
         uSiPIW7/9l2vO1WX6WDMqV55n00sIg4BjKginuWs6fXL2pav9fTauQUBk2Ns7lEj8BLa
         1KPpp/zRyPMjrj2kMleLFxy5tBoJ2Dv12yzf0oWPTB7kkSwXtxyHB3Wa3ox1/LxOkGfU
         r/i91GWtHLn4nx7Ses/DGZuDwnZsn6JsQlLf+bh08gkK3no2a9kX3xje9+/qkbAegsPI
         n0+w==
X-Forwarded-Encrypted: i=1; AJvYcCWXvafQGoqQZCuwhvFkDI33a0Yqz94jXJZrkILep3t7WDI0sNpDznbuQxWg5faxf08ThHr9Bjq/GaMWiRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLlL4jjM3HMWTqoMQ+ON2hkxnROx013rtpyGrsJFp0kTlDoheC
	607cjkpqRbRp0ES3iMrzkO4lqoNZMsYDwzHZOS0e/UACHojA0LOVSeiW
X-Gm-Gg: ASbGncv4/r9Z69gDy1Npblf8BpfFdfaIUXAZjsc00LfjxIEiY4CAtLVNZW7t49D7Dai
	nNXPCKVYm3xrEyeEk81yVf/aGZMtdL6fbd6E976vfTSp3rBf7ngUIoikvKSLb0xCSfUFQ1CcGES
	hqjx8TSUC10Y4vWbtybjjEdc4gCL3dngDVpIY1N/rnHHtZdxABoPGTL6nlLP431jBVCFDn3xub3
	3fn0JX7sveTX1hxCJpFmXSleCbNBBIWKDm6BiN+/rP19m+60jddAVrfe4syNQSThxWR6P/Iw8b3
	MYHZ6Q2+vu6l9BzkxLs+KGGEMEUZ6tlyvAPvCBTTjABKCo2/ubRDj8sMFY5dbcBtB72jMc9Lf/p
	u0PbsHKqj8spIiBi4IwWsOAsU524V4kD6l9MssQ==
X-Google-Smtp-Source: AGHT+IHCy3e0qspIz9xOBUfl4DFzrhgYH1uWX/O9LZQV10EfDxDXgWG4DqQUX5eJig20VQVw/qTisQ==
X-Received: by 2002:a05:6512:33c8:b0:579:6de0:983b with SMTP id 2adb3069b0e04-5906dc2a41dmr787981e87.17.1759908693893;
        Wed, 08 Oct 2025 00:31:33 -0700 (PDT)
Received: from xeon.. ([188.163.112.70])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0118d22bsm6911016e87.85.2025.10.08.00.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 00:31:33 -0700 (PDT)
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
	Linus Walleij <linus.walleij@linaro.org>,
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
	linux-gpio@vger.kernel.org,
	linux-staging@lists.linux.dev
Subject: [PATCH v4 12/24] staging: media: tegra-video: vi: improve logic of source requesting
Date: Wed,  8 Oct 2025 10:30:34 +0300
Message-ID: <20251008073046.23231-13-clamor95@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251008073046.23231-1-clamor95@gmail.com>
References: <20251008073046.23231-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

By default tegra_channel_get_remote_csi_subdev returns next device in pipe
assuming it is CSI but in case of Tegra20 and Tegra30 it can also be VIP
or even HOST.

Define tegra_channel_get_remote_csi_subdev within CSI and add check if
returned device is actually CSI by comparing subdevice operations.

Previous tegra_channel_get_remote_csi_subdev definition in VI rename to
tegra_channel_get_remote_bridge_subdev and use it only in VI driver since
core VI driver does not care about source and does not call any specific
functions.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/staging/media/tegra-video/csi.c | 16 ++++++++++++++++
 drivers/staging/media/tegra-video/vi.c  | 14 +++++++-------
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/media/tegra-video/csi.c b/drivers/staging/media/tegra-video/csi.c
index 9e3bd6109781..ef5f054b6d49 100644
--- a/drivers/staging/media/tegra-video/csi.c
+++ b/drivers/staging/media/tegra-video/csi.c
@@ -445,6 +445,22 @@ static const struct v4l2_subdev_ops tegra_csi_ops = {
 	.pad    = &tegra_csi_pad_ops,
 };
 
+struct v4l2_subdev *tegra_channel_get_remote_csi_subdev(struct tegra_vi_channel *chan)
+{
+	struct media_pad *pad;
+	struct v4l2_subdev *subdev;
+
+	pad = media_pad_remote_pad_first(&chan->pad);
+	if (!pad)
+		return NULL;
+
+	subdev = media_entity_to_v4l2_subdev(pad->entity);
+	if (!subdev)
+		return NULL;
+
+	return subdev->ops == &tegra_csi_ops ? subdev : NULL;
+}
+
 static int tegra_csi_channel_alloc(struct tegra_csi *csi,
 				   struct device_node *node,
 				   unsigned int port_num, unsigned int lanes,
diff --git a/drivers/staging/media/tegra-video/vi.c b/drivers/staging/media/tegra-video/vi.c
index 90473729b546..04b538e8b514 100644
--- a/drivers/staging/media/tegra-video/vi.c
+++ b/drivers/staging/media/tegra-video/vi.c
@@ -160,8 +160,8 @@ static void tegra_channel_buffer_queue(struct vb2_buffer *vb)
 	wake_up_interruptible(&chan->start_wait);
 }
 
-struct v4l2_subdev *
-tegra_channel_get_remote_csi_subdev(struct tegra_vi_channel *chan)
+static struct v4l2_subdev *
+tegra_channel_get_remote_bridge_subdev(struct tegra_vi_channel *chan)
 {
 	struct media_pad *pad;
 
@@ -182,7 +182,7 @@ tegra_channel_get_remote_source_subdev(struct tegra_vi_channel *chan)
 	struct v4l2_subdev *subdev;
 	struct media_entity *entity;
 
-	subdev = tegra_channel_get_remote_csi_subdev(chan);
+	subdev = tegra_channel_get_remote_bridge_subdev(chan);
 	if (!subdev)
 		return NULL;
 
@@ -204,7 +204,7 @@ static int tegra_channel_enable_stream(struct tegra_vi_channel *chan)
 	struct v4l2_subdev *subdev;
 	int ret;
 
-	subdev = tegra_channel_get_remote_csi_subdev(chan);
+	subdev = tegra_channel_get_remote_bridge_subdev(chan);
 	ret = v4l2_subdev_call(subdev, video, s_stream, true);
 	if (ret < 0 && ret != -ENOIOCTLCMD)
 		return ret;
@@ -217,7 +217,7 @@ static int tegra_channel_disable_stream(struct tegra_vi_channel *chan)
 	struct v4l2_subdev *subdev;
 	int ret;
 
-	subdev = tegra_channel_get_remote_csi_subdev(chan);
+	subdev = tegra_channel_get_remote_bridge_subdev(chan);
 	ret = v4l2_subdev_call(subdev, video, s_stream, false);
 	if (ret < 0 && ret != -ENOIOCTLCMD)
 		return ret;
@@ -1630,11 +1630,11 @@ static int tegra_vi_graph_notify_complete(struct v4l2_async_notifier *notifier)
 		goto unregister_video;
 	}
 
-	subdev = tegra_channel_get_remote_csi_subdev(chan);
+	subdev = tegra_channel_get_remote_bridge_subdev(chan);
 	if (!subdev) {
 		ret = -ENODEV;
 		dev_err(vi->dev,
-			"failed to get remote csi subdev: %d\n", ret);
+			"failed to get remote bridge subdev: %d\n", ret);
 		goto unregister_video;
 	}
 
-- 
2.48.1


