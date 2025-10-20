Return-Path: <linux-kernel+bounces-860045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AA3BEF322
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 05:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76A3D4E9D64
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 03:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBD42BDC1B;
	Mon, 20 Oct 2025 03:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2GItnPj"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B79D2BDC15
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 03:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760931257; cv=none; b=I/FLaUGcWGX4/4Prb+JozscR2yGJGw+KvYoH/UuwwV2DjmUAbC6je2oMh4sUKGfcSFZ8W20u7w51EM8cmDpWX9X1kBpxh/ptlJmLPTg2Nmn3Z1Rtt5u9jYRy5MOaTU9d/7wo2+Vkq8K7dnCvBTh6UiA4TM+VO2mq8syhee4BJeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760931257; c=relaxed/simple;
	bh=dgpNPFFxsdIAjczNzjU4PLG/4kOomJBC5GhTApKNwOw=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TULRr0Muy0Ws3scu9915tyxzEab0U+H3YyYL9NydVjwiToA5hjpPJuEcj7C+rw3KPPBuMDmbHxsZnLXXrZMfKAXK+rgrf6IEkG18/HlVcAVoyREKhovV3tRBjeHiKCQsF3S+YeMaXnSqOHkg/YAjQCOTA8dnxM74fyWXZLz/uX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2GItnPj; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-3c9b1b8ccb1so236313fac.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 20:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760931255; x=1761536055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7rSqoF1bhRIMRZ/Ngttka/3cr36QgYmwYc1FwmVj14E=;
        b=B2GItnPj9ePFIyy1NV6ebkSdW4JfsI9guXfrDaE5F+udd2xe8lgafWxFQZyAytAQjG
         enucN3+yuoMKehfdGc5RK8GTNrkJnpdev0x11tnLneZ5iB42AqCjurWBmKE+iePu4n85
         lReHhBLku2K3Solh5iebdXjiHDKTlUzf9RJqqqehedOn6WHSLwBytbpl2qUAb9OvgrXe
         P5MNd68X/Tuf1VEzYjnFJrDbbMue81BjeDKRnQDECHP9hrx5zj+Gp+3bcPzjywVWj5yv
         AwXqJshWBfG7H/rHoTCWYzhoBgbeFjmOa/m5rx+1lfh2f0JGBLQYIr5i/XGTmfKVr7rO
         /M0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760931255; x=1761536055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7rSqoF1bhRIMRZ/Ngttka/3cr36QgYmwYc1FwmVj14E=;
        b=KtsTs8Me98TYcqmqyWbQkEWjhqUKgVugwgJLQ5/chOkkjZBPct3rrWU1D0v1VMmBbs
         4eM/prFlLL7bb0VnIPDj/WsRFrGbZDd9S723heVQc12oMyu+mBswk5cx1IMQb8ZRoK8x
         YfvHHJBToVXy1srf441+3J46n2p96M6IVFxU2zBfVDK43FKVNDFphcn5XRx9rW18vOZk
         FEi7ogD71t0tuw4ZtzYeyrkg+fPg+1tWMBbWw/tQBtJ+nnczFsNDn+f4xi2QiQ+9tUK+
         grU82o+BcJRrtASgcGKmFd9QpG2RHu6bldQq/RZ+uFfw1TQ4tqaxdRymzPDlhBTuaYK4
         iMfA==
X-Forwarded-Encrypted: i=1; AJvYcCVsPyqyJj3qu//fjjRk6pWloCL6CT07TIkPr9aJzeS22rM71zRwKWFCROfBmqA7C1qmcd4W8WbZKArIyxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzItunpLI0Bx7Wmt2WwgOrRVCw9yR/ZhkCodH7S7xvBuLbA63Xj
	NcKRXtN9PInxetvUSO61xUdbkRKW3bd6tmFJ+ugG6beqNP+hQjehb7iU
X-Gm-Gg: ASbGnctkEnhciHgFP+ROjBj0FE/5HZd+/NdPWoI35jSIYiUxWuADw4DWjWb7hp3Iczq
	zHtbXp70888X1Q8+SRNpRRgsgzPI/orJMjoWlVQrY6r7Nvxvni2DAhK0gLdUxeZfkCpLLHeB+Ys
	/TfrRPfcF44PYdEO3/7HbbvNScKBFqbSRCkuYOTLRpw1UYw3nU/jUZiTD7VQmWPo7zI19gFpyvm
	dkSxmFugxyQx0l+WyU81pEhSxF0NlR6dpjYfLQi6ii/eAiuFNgeGP9m9mUG7F3BuSZCHZ569cxL
	SpLEA62TojTs1LaXpMnBsjUKb2jFSKP9l+CuinfrAeCK0a8O1JtbPKckwfIT5oFtw6CUjtgBkQP
	M26Kdtz9aAdr4dG1UxQQckKDZT3wUX9Oawbvv/7Hu0eYEoAgZgzS6qRsxDsB228u9FWtl4gUaBB
	4mzX5Z2Q+dRWVZtVO1B4/s
X-Google-Smtp-Source: AGHT+IE9q9Mk98lP6hBRl0yUU492JUXYJJQ2DgdO+Y4L3lDypf5RtaLyuDaSNhzNdoqOYTgHdrMLwA==
X-Received: by 2002:a05:6870:2b12:b0:331:9036:6151 with SMTP id 586e51a60fabf-3c98cf43502mr5122705fac.4.1760931255070;
        Sun, 19 Oct 2025 20:34:15 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-3c9aefc51c7sm1878073fac.8.2025.10.19.20.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 20:34:13 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	rabenda.cn@gmail.com,
	inochiama@gmail.com,
	krzk+dt@kernel.org,
	mani@kernel.org,
	liujingqi@lanxincomputing.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	robh@kernel.org,
	tglx@linutronix.de,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev,
	chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com,
	fengchun.li@sophgo.com
Subject: [PATCH 2/4] riscv: sophgo: dts: enable PCIe for PioneerBox
Date: Mon, 20 Oct 2025 11:34:05 +0800
Message-Id: <ec474c5eefb79626dd6a4d65454da9109aaf2f4d.1760929111.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1760929111.git.unicorn_wang@outlook.com>
References: <cover.1760929111.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Enable PCIe controllers for PioneerBox, which uses SG2042 SoC.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
index ef3a602172b1..c4d5f8d7d4ad 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
+++ b/arch/riscv/boot/dts/sophgo/sg2042-milkv-pioneer.dts
@@ -128,6 +128,18 @@ uart0-rx-pins {
 	};
 };
 
+&pcie_rc0 {
+	status = "okay";
+};
+
+&pcie_rc2 {
+	status = "okay";
+};
+
+&pcie_rc3 {
+	status = "okay";
+};
+
 &sd {
 	pinctrl-0 = <&sd_cfg>;
 	pinctrl-names = "default";
-- 
2.34.1


