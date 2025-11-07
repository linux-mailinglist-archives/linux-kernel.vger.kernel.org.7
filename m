Return-Path: <linux-kernel+bounces-890978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8087C41836
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 21:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C54F3A5715
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 20:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4932309EEC;
	Fri,  7 Nov 2025 20:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="3V09t7Tm"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6FF302172;
	Fri,  7 Nov 2025 20:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762546025; cv=none; b=Qtf/WWLyVG9BbUyuXershYA8vlFb9p6Hjz7GKRG1mdVFQXUpd+ZioZhgRCm97u0BpvG2sivFA+ykyM4RD+5TDGUGeAvIjaIzfE96D2fMgZ0fYzz4SW+kSmHpGbtdr6ovX4nPdDM819qJ3JikPbeIfOYmYNi2/cqbBLla2jKcG08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762546025; c=relaxed/simple;
	bh=AKXzh+5uva5q/n6thBi28TDZoI7er4chBXEi4uRYGAo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CNoVXrzxPO1t7kMuNOI9USWNc31KyazS41zp3wOXSHr6GT708HHEFn820taWMJtjAV3ojyVNdzqnbHjxYg/jBo8du9odCLBV7ptT3XcNEyOpoOJ6faPda+SGpBD+M5+aW/9jFqt2XzE3MNteOQzYWs5jf85avpKnwoDjemfZ5e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=3V09t7Tm; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=o88pTOG3PybXpUsckn3hO3L/+Le5nl9WIKim3ric57c=; b=3V09t7TmMy5VHmxuFjP9sIjUrQ
	3PIKzJ46XyrwmnAfPmA2Pc134HsarDgAHvWYiTxOIgjyujCFD39m6QC1ScfBmzSZDfInQrOxctI+7
	sGxUID4Ab++hbvmNR/NuuImD/KRjcx49eZLEgHjjhLvyaJeNWVF1KtmFyjVdTCrX8ps7FLIMc7Mhh
	BYxuraUXU2xGfpl4tV7yV40dGoCGOxW3jfx2RzYHcW/hLJRJUvSbHhnZCrHGmjSrTwC2gUtCZNtsT
	4Guyv4tTZsZuMjwsZTbptCfHy5hqp94yyBDmREc4HXgljR8oHdhZzN3Twjt10G4tPbCtgIikTlzDJ
	RZgqBIjA==;
From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/3] regulator: Add FP9931/JD9930
Date: Fri, 07 Nov 2025 21:06:43 +0100
Message-Id: <20251107-fp9931-submit-v1-0-aa7b79d9abb6@kemnade.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFNRDmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQwNz3bQCS0tjQ93i0qTczBJdg8RkIxPLJNMUsyQDJaCegqLUtMwKsHn
 RsbW1AF3GkIRfAAAA
X-Change-ID: 20251107-fp9931-submit-0ac249b5d6b0
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, Guenter Roeck <linux@roeck-us.net>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hwmon@vger.kernel.org, Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1427; i=andreas@kemnade.info;
 h=from:subject:message-id; bh=AKXzh+5uva5q/n6thBi28TDZoI7er4chBXEi4uRYGAo=;
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDJl8gbHfpuguPnziTIeUsGWR6rY93pv19E6vm9IZteBO3
 qqoVVKBHaUsDGJcDLJiiiy/rBXcPqk8yw2eGmEPM4eVCWQIAxenAEwkTYbhf+zt2XIJVUt2t83p
 ye9YELSRNe3RtlcaEzmf3/cy2qTxl5fhf8pS0YTrj3OuSj3sufrsf4OIhvIZFaHvsy+2KD+pu7r
 1IgsA
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324

Add a driver for the FP9931/JD9930 regulator which provides the
comparatively high voltages needed for electronic paper displays.

Datasheet for the FP9931 is at
https://www.fitipower.com/dl/file/flXa6hIchVeu0W3K

Although it is in English, it seems to be only downloadable
from the Chinese part of that website. 
For the JD9930 there can be a datasheet found at
https://e2e.ti.com/cfs-file/__key/communityserver-discussions-components-files/196/JD9930_2D00_0.7_2D00_JUN_2D00_2019.pdf

To simplify things, include the hwmon part directly which is only
one register read and there are not other functions besides
regulators in this chip.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Andreas Kemnade (3):
      dt-bindings: vendor-prefixes: Add Fitipower
      dt-bindings: regulator: Add Fitipower FP9931/JD9930
      regulator: Add FP9931/JD9930 driver

 .../devicetree/bindings/regulator/fiti,fp9931.yaml | 133 +++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 drivers/regulator/Kconfig                          |  10 +
 drivers/regulator/Makefile                         |   1 +
 drivers/regulator/fp9931.c                         | 567 +++++++++++++++++++++
 5 files changed, 713 insertions(+)
---
base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
change-id: 20251107-fp9931-submit-0ac249b5d6b0

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>


