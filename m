Return-Path: <linux-kernel+bounces-805196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746DAB4852D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EA743B791D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230662E7BAB;
	Mon,  8 Sep 2025 07:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b="X0Q6oZKq"
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A2D2E62A4
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757316471; cv=none; b=G20DNcOduzrbAojSiifG6KQd9A5hKyXQPcVWLmNAlB7fvRxw1X88x5jCUssEJ7kInxxzoIam1ClKXntvyaYw5RusGAj2kLsW2apGsXeianMrXxJRQK4Em0A45iiHBsx1LsFyyU3aLRGYgaw/oUWgKFxXh6aywdt9Sa45GehHuBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757316471; c=relaxed/simple;
	bh=m6P2ifyb2S9aL4S799UQEuuQspOh/8y6FFDeBdDh+ZA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=uFBX5F9qZZKYaWQERKXcLkvopj27qWOzpt0L3WeiUilSQkhz0gV8vaklYG2TAPhfDpZofNYpmlH3yRf6S5tJaFoj/xcvv5PntySFXUK12P2c88vjqnFrGIoOU+Doge3v7Vdjp7j2r7ze46F4exXdySrBKzooGW1/d7jc9wrdJO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se; spf=pass smtp.mailfrom=grimler.se; dkim=pass (1024-bit key) header.d=grimler.se header.i=@grimler.se header.b=X0Q6oZKq; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=grimler.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grimler.se
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grimler.se; s=key1;
	t=1757316457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s6dihIf8dRj48AF5jPOhCRWjZ7JWA05I9MIiVmOPVtw=;
	b=X0Q6oZKqzJr+JTOYipYoyZoI04xQnZRkJ/ggYeJXe0d3TZolCHT5M5mpiBqRGj4m6wY+tS
	ShE5D36ZOd1cxRonket/mri5wWtLYX157va0J62dksPWsHCNYMAAzaufzZkaWP+md5nZuT
	XKCUzH6UomkCbYTJkIGoOO7CGEH2/o4=
From: Henrik Grimler <henrik@grimler.se>
Subject: [PATCH v2 0/3] exynos5250-smdk5250: describe SROM controller and
 ethernet port
Date: Mon, 08 Sep 2025 09:26:54 +0200
Message-Id: <20250908-smdk5250-sromc-v2-0-e91b2375d4e1@grimler.se>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD6FvmgC/13MTQ6CQAyG4auQrh1TBgeCK+9hWMwMFRrlJ60hG
 sLdHXHnrm+T71lBSZgUztkKQgsrT2MKe8gg9n7syHCbGixah5W1Rof27tJtVKYhGvIu1M4VSKG
 CNJqFbvzawWuTumd9TvLe/SX/fn9Ujad/askNmlCUGEsfMI/lpRMeHiRHJWi2bfsAzoijF60AA
 AA=
X-Change-ID: 20250722-smdk5250-sromc-ea5b95530eb7
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Henrik Grimler <henrik@grimler.se>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1506; i=henrik@grimler.se;
 h=from:subject:message-id; bh=m6P2ifyb2S9aL4S799UQEuuQspOh/8y6FFDeBdDh+ZA=;
 b=owEBiQF2/pANAwAIAbAHbkkLcWFrAcsmYgBovoVYKGkaXfYWHIIoUROmHqmzQeWHVBTPFVcfF
 b537vzfq/OJAU8EAAEIADkWIQQsfymul4kfZBmp4s2wB25JC3FhawUCaL6FWBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwzLDIACgkQsAduSQtxYWsYtQgAgF4PHPETcK6t3eCeZlF0EPy3GjYIrQH
 qnxESTAzF/51M+p4KKxslzW6+UYQE4fRlRIkVgKcCKeZhvwpZ9GW8c3qpUFK0JMEErjKFDH4s3E
 5SXeLSfM95i98GKBjOD89eqGYQ12kpddUYgdnJXMXaDqCdBBxUQhhE7xDIy63pZz3CZDabIAVeC
 aA+8ZJkOOHtsAeWx6LtG48EN/5lifqS/oRrQs7tgbqWs+2Zu9By0HtQySyWIFuVMh4qxyJpwlZa
 jTyccjPtAq0O88McodoD6qG5zDqh+/o12q+GLFwBeT1tCIq14vjnCuME4WGkNKo35Z13/xHIyYr
 Rty5nEqbbsA==
X-Developer-Key: i=henrik@grimler.se; a=openpgp;
 fpr=2C7F29AE97891F6419A9E2CDB0076E490B71616B
X-Migadu-Flow: FLOW_OUT

Based on smdk5250 description in Samsung's vendor kernel [1] and the
u-boot dts [2], the smdk5250 board seems to have a ethernet port
connected to bank 1 of the SROM controller.

Unfortunately I do not have access to the board, so this is not tested
on an actual device, and based solely on the linked sources.

[1] https://github.com/krzk/linux-vendor-backup/blob/samsung/galaxy-note-tab-lte-10.1-2012-gt-n8020-p4note-exynos4412-dump/arch/arm/mach-exynos/mach-smdk5250.c#L982
[2] https://gitlab.com/u-boot/u-boot/-/blob/master/arch/arm/dts/exynos5250-smdk5250.dts

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
Changes in v2:
- Use comma separated tuples in ranges (@krzk)
- Add patch to update ranges format in exynos5410.dtsi as well
- Link to v1: https://lore.kernel.org/r/20250904-smdk5250-sromc-v1-0-b360c6ab01c6@grimler.se

---
Henrik Grimler (3):
      ARM: dts: samsung: exynos5410: use multiple tuples for sromc ranges
      ARM: dts: samsung: exynos5250: describe sromc bank memory map
      ARM: dts: samsung: smdk5250: add sromc node

 arch/arm/boot/dts/samsung/exynos5250-smdk5250.dts | 37 +++++++++++++++++++++++
 arch/arm/boot/dts/samsung/exynos5250.dtsi         |  9 ++++++
 arch/arm/boot/dts/samsung/exynos5410.dtsi         |  8 ++---
 3 files changed, 50 insertions(+), 4 deletions(-)
---
base-commit: 1557c2eb023d9cdf97b4686fd206048c070d4e70
change-id: 20250722-smdk5250-sromc-ea5b95530eb7

Best regards,
-- 
Henrik Grimler <henrik@grimler.se>


