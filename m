Return-Path: <linux-kernel+bounces-834210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7EBBA4332
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 16:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D8347AC6D6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 14:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0617A1DDC0B;
	Fri, 26 Sep 2025 14:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1iKz9jq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EA81D5154
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 14:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758896709; cv=none; b=hpQHNEBauZG4yWl/mkzUxnmoo6zyNVwYhJmWe2VTAd40ovwW49t0pSxHKOfwik1izLDFJUbA3ZtT2rA08JkZpMGKsNKbwX//1pGApyAaIC0pSVVodAsivM8+Rum1Kzzy/5sd7NUb51A/ZQSbv0ZJCtN80du6DW2eMxllgh0q0SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758896709; c=relaxed/simple;
	bh=0Py0gus+4Kw9xvuUld0HHLpuUDZX3KtoevhAxkUictk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upql1yJXTKAr6n79CieC65jNv3bo8Ar3u/xt3J8/mUpUVQh3CYJfJ0LsQCFInYg4pbCYjFdH8tnbdKdqjF8JG1I35rF9c9zGsN3gHEI5LdmCPR+JpXLuuc3ki/XmQ6o65XkPNO9n8dwcW4RV46dgu90HVIASbdys9TmwgusJFzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1iKz9jq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13485C113D0;
	Fri, 26 Sep 2025 14:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758896709;
	bh=0Py0gus+4Kw9xvuUld0HHLpuUDZX3KtoevhAxkUictk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1iKz9jq18I9U4b5c4xlfsB04frWUGHM31yqSfASTu16U9A4mndpu425DdOvaP709
	 +p9LCXNftxuQsIJYbMHZoQzVeLzYPiXWObPDp/os9GYAXiSXWRslh9psOvb55G1X5n
	 ryeO+/Cv2J1/fjFXLgOPb1JEXcRWo+K2umVzjzajPHDN1CiOncAY/I/ROTUcmz7bJ8
	 4Y2fQjwYFDlcRDWg3rd3t77kjc7uoqye2uhGcAyjnHHAgoB9ZXXiFnPAsijSLKOFgi
	 7p1xol7gyPVX28vkVMnlY080MLC2ZPmJrMw6bfpkZxYetfMBVC59w/RHJLNc96HWzx
	 lwIMhZOTkECdA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v29Ne-000000001Y6-2Y1j;
	Fri, 26 Sep 2025 16:25:02 +0200
From: Johan Hovold <johan@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 2/2] soc: amlogic: canvas: simplify lookup error handling
Date: Fri, 26 Sep 2025 16:24:54 +0200
Message-ID: <20250926142454.5929-3-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20250926142454.5929-1-johan@kernel.org>
References: <20250926142454.5929-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Simplify the canvas lookup error handling by dropping the OF node
reference sooner.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/soc/amlogic/meson-canvas.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/amlogic/meson-canvas.c b/drivers/soc/amlogic/meson-canvas.c
index 0711088da5dc..79681afea8c6 100644
--- a/drivers/soc/amlogic/meson-canvas.c
+++ b/drivers/soc/amlogic/meson-canvas.c
@@ -60,12 +60,9 @@ struct meson_canvas *meson_canvas_get(struct device *dev)
 		return ERR_PTR(-ENODEV);
 
 	canvas_pdev = of_find_device_by_node(canvas_node);
-	if (!canvas_pdev) {
-		of_node_put(canvas_node);
-		return ERR_PTR(-EPROBE_DEFER);
-	}
-
 	of_node_put(canvas_node);
+	if (!canvas_pdev)
+		return ERR_PTR(-EPROBE_DEFER);
 
 	/*
 	 * If priv is NULL, it's probably because the canvas hasn't
-- 
2.49.1


