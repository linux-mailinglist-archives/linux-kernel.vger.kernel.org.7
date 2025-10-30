Return-Path: <linux-kernel+bounces-878365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 391EBC20676
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 95EF44ED30A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFDE25EF9C;
	Thu, 30 Oct 2025 13:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="JuFum/Z0"
Received: from mx-relay13-hz2.antispameurope.com (mx-relay13-hz2.antispameurope.com [83.246.65.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B36725784E
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=83.246.65.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761832446; cv=pass; b=OK9Xhk12VwGTmLM1/LN5+7/WMqz5zzlPmAYDvmAzir8xlGaq6CF9+vBAAEvpmkGbUdfwJ+uGyRekOqXulFIVKKLSNIVXfyY/qgQp9adTAUUR+HHcj2f0RYLllfA3XStDhFm6vNLjjr7LLQwKXbjQB8V1oT7tET0Hu9eKFlfZ/n8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761832446; c=relaxed/simple;
	bh=+sePMg1ADt1lzpdhzp3d8sszHWrpZkkDSdH4qWD+amU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mK8S/oTtH7x07tn6cZrYTVvCxx83NU4FNab5nPWmtHS4cFPRwe2OQvswvzAwA3zHhTxc7YGcZkN3T7VneOMIhI5/boFLBlAuQVXNif/Us7vKwIVLy9cfqgsnJB7j/AtwRtxpX2CAea3Kc3cqW4wlR/e5ZmW4Y9hmvyYW8Oc8KdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=JuFum/Z0; arc=pass smtp.client-ip=83.246.65.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
ARC-Authentication-Results: i=1; mx-gate13-hz2.hornetsecurity.com 1; spf=pass
 reason=mailfrom (ip=94.100.132.6, headerfrom=ew.tq-group.com)
 smtp.mailfrom=ew.tq-group.com smtp.helo=smtp-out02-hz1.hornetsecurity.com;
 dmarc=pass header.from=ew.tq-group.com orig.disposition=pass
ARC-Message-Signature: a=rsa-sha256;
 bh=Q/J0eJNHpyNTzgYF4P4yNw/ejnkLZX/hDBoKw5OjID4=; c=relaxed/relaxed;
 d=hornetsecurity.com; h=from:to:date:subject:mime-version:; i=1; s=hse1;
 t=1761832428;
 b=RnHEmGj7Ohi++9RKMXmkjh0R6rPVIexf5mIk2IYo4RVXyLresDjJEPJDxnjLsdyCDt2vBNmI
 cWZtUo2Lu/HQqzrJBqTz/pwYUoKETzQqhtZFPZZ1zy3rihfrxM6ah1bLFEWDZLvMgcPbyGIcEJw
 SBual+nec9lP182B+BEN583mvIYoPK0O64WKosTCzj1NxHriJVQ66t9h77BJqk6g+kyKL2chbrt
 4pmkN0MJO5VGwREEM4XqdVlk1AdlU4+F3YOP2JUfCW+RK+fsuGP/6DbiyeNFWF9/cXnVBRbQJ7x
 fiyxwI1LWBD0EAIwt9JmVxNBN9+Hx7MwqTdOl6bHu9cfw==
ARC-Seal: a=rsa-sha256; cv=none; d=hornetsecurity.com; i=1; s=hse1;
 t=1761832428;
 b=ezAqAqtE8iaAUifk0CF7dtAhkGezx4FqYCA80lHm4XkmdFxsdRI2UzHdGE9qWc5Byo7GJa+F
 ZiqSuJb4EU70j8LTd6WJ6zpHY0XpCsLj+64DQCQLZoPLkUbZHCLmIlkUpBcgkhXjoRYY3548uba
 6sJhr16+eeyCPNbn370YEZwWLlr4TDRFg6pr03t+P9Wcqgbz9EjS+0sMVaN0LBKyo1ZivZNvUGb
 WEx+1Sqx2/6PsD9t4RGTdSsxBBYPTs5A5sI6Ccp2TE8yFg064pV9bXYqd0Y9X5rG7HJKFInK/gQ
 JcvsEh1hoRpCzR3wpVU0RLMyRgRjvVD9CqCsnlRPXqVjA==
Received: from he-nlb01-hz1.hornetsecurity.com ([94.100.132.6]) by mx-relay13-hz2.antispameurope.com;
 Thu, 30 Oct 2025 14:53:47 +0100
Received: from steina-w.tq-net.de (host-82-135-125-110.customer.m-online.net [82.135.125.110])
	(Authenticated sender: alexander.stein@ew.tq-group.com)
	by smtp-out02-hz1.hornetsecurity.com (Postfix) with ESMTPSA id 108875A0B13;
	Thu, 30 Oct 2025 14:53:19 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	linux@ew.tq-group.com,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 18/19] arm64: dts: imx95-tqma9596sa-mb-smarc-2: remove superfluous line
Date: Thu, 30 Oct 2025 14:53:00 +0100
Message-ID: <20251030135306.1421154-8-alexander.stein@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030135306.1421154-1-alexander.stein@ew.tq-group.com>
References: <20251030124936.1408152-1-alexander.stein@ew.tq-group.com>
 <20251030135306.1421154-1-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-cloud-security-sender:alexander.stein@ew.tq-group.com
X-cloud-security-recipient:linux-kernel@vger.kernel.org
X-cloud-security-crypt: load encryption module
X-cloud-security-Mailarchiv: E-Mail archived for: alexander.stein@ew.tq-group.com
X-cloud-security-Mailarchivtype:outbound
X-cloud-security-Virusscan:CLEAN
X-cloud-security-disclaimer: This E-Mail was scanned by E-Mailservice on mx-relay13-hz2.antispameurope.com with 4cy5DV6fJtz3svlF
X-cloud-security-connect: he-nlb01-hz1.hornetsecurity.com[94.100.132.6], TLS=1, IP=94.100.132.6
X-cloud-security-Digest:813d6957f8f6d1a248c870b46880b697
X-cloud-security:scantime:1.840
DKIM-Signature: a=rsa-sha256;
 bh=Q/J0eJNHpyNTzgYF4P4yNw/ejnkLZX/hDBoKw5OjID4=; c=relaxed/relaxed;
 d=ew.tq-group.com;
 h=content-type:mime-version:subject:from:to:message-id:date; s=hse1;
 t=1761832427; v=1;
 b=JuFum/Z0P12q0znF7LWgjm73Ju1giJCi3qd7fAGekffbmycvzG9VgNTZFJ2gblIlIcSsryUz
 wM72wWiZ/+HI1bgoFnXN0l3DWn5ZNgk9M0aos3WL8EoTSDn8yebdbw4D4B2Ciy6LlS4OBGPEBNF
 2h9+sw37aWhoSfWB6SU5Mth+rc9h3Tx0TbR8LVG8VHJvswmfjcTaUEBBu660SQxxy7WqhDLFGgM
 yEXSC19khE0cZ1q9FPI7tAEYT4tyTOJ1QJ2w+ez1lvSnA5CYS1wdyu0XUus5u+bfq+HtD3QGDim
 GmimBkPcPCwj5wow7xio8dOHZkZTrR0zSUqQ51wzCKhYg==

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Remove empty line, no functional changes.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
index 15d117d785445..d3a9360b8c548 100644
--- a/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
+++ b/arch/arm64/boot/dts/freescale/imx95-tqma9596sa-mb-smarc-2.dts
@@ -259,7 +259,6 @@ &usb2 {
 	status = "okay";
 };
 
-
 /* X16 */
 &usdhc2 {
 	no-mmc;
-- 
2.43.0


