Return-Path: <linux-kernel+bounces-723608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E8BAFE914
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF510562185
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 12:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B552DA763;
	Wed,  9 Jul 2025 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="h4kJCVY8"
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731CB2D97B0
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 12:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.165.51.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064540; cv=none; b=rbKHUaB15a/cXadrWt5lAfJ2L9bSQQ5KqsmC6cnd9Ud2f7wVNJ3um7NH/Nkvg89SP9v4BRpxbb23c3Z61zkljumJIppiuRcvC3791ewkUOmgwfDi4mygBkmwZ8Ev9xaJgQpNHx8pfMl8NU6Baw8QrWR/WAo2b33VV8UOzS5Nt08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064540; c=relaxed/simple;
	bh=IATOFFAkOTbsVHr/2zyzxbHWp/m07RHobqZy+swWvQk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sjwkl5T+FSTFY5zgCHwHT/P5GvUGlJHX0B/3nB3prQdebRoucxwzzdTbzT/bxmj8JxA1Q6QGzs4mMcB8FPaPAawcDJ0P9jjn0hBKe56jALPAcTrXRCOd00cb5r+W4FLnkKSeC5JppwfZ4i9Kdw4PzAhKAXjGJ1pGNnevPkiq0qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=h4kJCVY8; arc=none smtp.client-ip=188.165.51.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
	s=protonmail; t=1752064521; x=1752323721;
	bh=cXeI8EsZBybxtyL9n7ikAUKanntF+2PJYliFI/Cq4xw=;
	h=From:Subject:Date:Message-Id:To:Cc:From:To:Cc:Date:Subject:
	 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=h4kJCVY88yPwrjwti+8sDE074puzG7KkkUnKlcok3KrloqvNKD/Kz6nQ5CT2B6Kw/
	 PJQfp5hA3snjvIpiKMmohaqU/FUY7b/p5ayn588YelReoDkaJzHfZYMgjRB3EDU6I3
	 ZRpwJnCtPjD+UyH+GRRvQS/D1KRwLUiaIXXGNjzNsZSb2miUi5c7PybSaFECiTfjlh
	 nl5kxqSdHM+bSoPUzW8DdNOvdwCCYs5NpFK/Uedm3hrf2VKhAhobd8Y38K6KsDgahi
	 Jir9Dj47rEzS58Te0uYsNkx8e2zEUWgkJ5ZdwNE7CjkoKLTUzvWVNYvk287xQlRu1K
	 mZSzWGIYZVDCA==
X-Pm-Submission-Id: 4bccrR3RZLz1DDrT
From: Sean Nyekjaer <sean@geanix.com>
Subject: [PATCH 0/6] iio: imu: inv_icm42600: pm_runtime fixes + various
 changes
Date: Wed, 09 Jul 2025 14:35:08 +0200
Message-Id: <20250709-icm42pmreg-v1-0-3d0e793c99b2@geanix.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPxhbmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwML3czkXBOjgtyi1HRdI5MUCyC2NLdINlECaigoSk3LrAAbFh1bWws
 A3S8CO1wAAAA=
X-Change-ID: 20250708-icm42pmreg-24d824d978c4
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sean Nyekjaer <sean@geanix.com>
X-Mailer: b4 0.14.2

This series was triggered by "Runtime PM usage count underflow!" when
unloading the module(s).
By testing the driver in various use cases and reading code it was
obvious that it could need some tiding up.

I'm still not 100% satisfied with suspend/resume is calling directly to
vddio_enable/disable. In my mind it should be managed by pm_runtime.

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
Sean Nyekjaer (6):
      iio: imu: inv_icm42600: Use inv_icm42600_disable_vddio_reg()
      iio: imu: inv_icm42600: Use devm_regulator_get_enable() for vdd regulator
      iio: imu: inv_icm42600: Remove redundant error msg on regulator_disable()
      iio: imu: inv_icm42600: Simplify pm_runtime setup
      iio: imu: inv_icm42600: Drop redundant pm_runtime reinitialization in resume
      iio: imu: inv_icm42600: Avoid configuring if already pm_runtime suspended

 drivers/iio/imu/inv_icm42600/inv_icm42600.h      |  1 -
 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 54 ++++++------------------
 2 files changed, 14 insertions(+), 41 deletions(-)
---
base-commit: 3e28fa06444e7031aba0b3552cce332b776fe267
change-id: 20250708-icm42pmreg-24d824d978c4

Best regards,
-- 
Sean Nyekjaer <sean@geanix.com>


