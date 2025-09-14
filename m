Return-Path: <linux-kernel+bounces-815856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D79BB56BE6
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 21:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BECC57A46F1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 19:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA622E62CB;
	Sun, 14 Sep 2025 19:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chimac.ro header.i=@chimac.ro header.b="DHTV36n1"
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F131D618A;
	Sun, 14 Sep 2025 19:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757879429; cv=none; b=t4OUUZ9FwSwGAocuKb0JzH7rpgpvEc9QHt2EOVHWqfFzD46BBBfIemULchTmkW7l+0CJJJjwFS86T+AUDH8Ka9KtlThZ6GYkyJoqOcMoRPIuwy0kgNvZRbQ/8Fxn1otjXpDmiyn35UoDDeYB7skeZOhIu9J4pdmvHt3c5kXh2Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757879429; c=relaxed/simple;
	bh=e4oglKln/kWGzC5OImc77IVRWYQwfmmm2LcQCSQRHgE=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uctZQ8rWxHmkmZ6I9BU2EjGMFB+jnobacBpFsftju1PHvGwFy1PACec4MRTHGugPB1RRT0aWsEVpYA8vr5ooMtk4v0UjOHoK4C9RgtY1aXjT9qcady+U0NFEzLdXFXfGNk1aKOmpEMYWVs8u2BxLywBNCloFJs97UeLmL4kR85E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chimac.ro; spf=pass smtp.mailfrom=chimac.ro; dkim=pass (2048-bit key) header.d=chimac.ro header.i=@chimac.ro header.b=DHTV36n1; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chimac.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chimac.ro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chimac.ro;
	s=protonmail; t=1757879426; x=1758138626;
	bh=djy6pEV1flbGKyTc0C6a/T2ViewaGMlSKIVHBckmb3w=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=DHTV36n14DZl4xsfsOTb+RlOmen3czE2qa+1w/OwN0yI6tPyDRwPQIn15rSu3p014
	 TJ64u5yGCTKxVOa/uOGRUquba4m1y3FXcIllagNpMnViIQctoIqBqwhqJKcEpSHz/p
	 GK+4v7E8MJhdMUdfCzKbjEEo+GSbkQsImh1iN6XeBxzgNGhzkgagvJrozcahJlvrr8
	 SWeyqLzod90GsGXSTuNyTO3Ssaz6wjvYkW+LOUERjiLIpoBtS9e1MfyIQ+d4CXsBDz
	 ayohp43tk8DfJ2z2CPEB1sG95gFyxBdmC/VyqRADZlaXfoN2PrOT3zcCykgJVR1yzs
	 ESYOGmZUEZtJA==
Date: Sun, 14 Sep 2025 19:50:18 +0000
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
From: Alexandru Chimac <alex@chimac.ro>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandru Chimac <alex@chimac.ro>
Subject: [PATCH 0/2] soc: samsung: Add chipid support for Exynos9610
Message-ID: <20250914-exynos9610-chipid-v1-0-ade99e09a23c@chimac.ro>
Feedback-ID: 139133584:user:proton
X-Pm-Message-ID: 39594e83b55310b1a79ccd91510238da2d85c4b4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patchset enables support for chipid on Exynos9610.

Signed-off-by: Alexandru Chimac <alex@chimac.ro>
---
Alexandru Chimac (2):
      dt-bindings: hwinfo: samsung,exynos-chipid: add exynos9610 compatible
      soc: samsung: exynos-chipid: Add exynos9610 SoC support

 Documentation/devicetree/bindings/hwinfo/samsung,exynos-chipid.yaml | 1 +
 drivers/soc/samsung/exynos-chipid.c                                 | 1 +
 2 files changed, 2 insertions(+)
---
base-commit: 48c4c0b684f394721b7db809e1cc282fccdb33da
change-id: 20250914-exynos9610-chipid-b7c1600dbb92

Best regards,
--=20
Alexandru Chimac <alex@chimac.ro>



