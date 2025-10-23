Return-Path: <linux-kernel+bounces-866876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30536C00E64
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 61E36500971
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 11:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B3930E82E;
	Thu, 23 Oct 2025 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b="AzmGxPgx"
Received: from out28-4.mail.aliyun.com (out28-4.mail.aliyun.com [115.124.28.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0FF305E2F;
	Thu, 23 Oct 2025 11:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761220254; cv=none; b=O7b3w0cv2O8IiCg+3Q+N2z/ggZ1Aks8qu2FwYBz7EIRYkFhf8NyhmnIuEPzZ3SkLEgTiMx/EGpUnYhgIq8iylveh+77ZKTPcv6Ckp6Zfk7Wxp8yv3r91ueNwxRTv/N+qlUwDWOo/BUMKdES9uOBQCZZWIVt2IE9TowvrJvA4Ou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761220254; c=relaxed/simple;
	bh=Ejsf6XBngtxYbRNLQelXtNVq3ZWs26NMIkiQ6iqBbeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpjvpoR0a1YRDoewIoj+f3vkO4jSADHPzou/fmJPhEv/1jXJFrsLrnG9i8HctTV1SY4f0CVOEM9OUMEnpICS/VbVjX8BTy5hQc1lGHtbBEV3Vq7qK0OZQXYbGRqQXf5pRM1qbBMAZ9OsZXOK8RAOIG0+yoejCbn2e+6n1aHQT5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com; spf=pass smtp.mailfrom=awinic.com; dkim=pass (2048-bit key) header.d=awinic.com header.i=@awinic.com header.b=AzmGxPgx; arc=none smtp.client-ip=115.124.28.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awinic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awinic.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=awinic.com; s=default;
	t=1761220241; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=I0x2z+i4gd5Gz0iz02dYYEQfSklfjr6CiyQ/pRpynpI=;
	b=AzmGxPgx7Peb4rpqoW892DcUPYMPNbEQc3Dg4YY1/qCIskcjMyadtdZuQDs/uwHA1w+Um3XWUY4EU66OpI/eXjLOQXHA0fG8+GBRrPECxSM6p8lVRgmXNFO2Xlqr7tr9/OXWy5i4P0bsCjxKnnun85SaE5/2RPB/17Ib/dbEm6/0JguKt+IH8GCVzc8Lfc3rE0aNaCmw6lDsJgu6GKJc8c2TNefaNmzPZ7ThBrEXgGz5MmPKR97Fhmalnc0vrdUssYK+jRmDr5eiKvxcDzOPzXsBxUeBEdQBoXmH9hHsnG5/ONTusMN3xfwOsd7zd2Oa33SwmY8YXJayszZXT7ur2g==
Received: from ubuntu-VirtualBox..(mailfrom:wangweidong.a@awinic.com fp:SMTPD_---.f5ewZFJ_1761220237 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 23 Oct 2025 19:50:39 +0800
From: wangweidong.a@awinic.com
To: broonie@kernel.org
Cc: alexey.klimov@linaro.org,
	ardb@kernel.org,
	arnd@arndb.de,
	cy_huang@richtek.com,
	ebiggers@google.com,
	hangyi@everest-semi.com,
	lgirdwood@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux@treblig.org,
	nick.li@foursemi.com,
	niranjan.hy@ti.com,
	perex@perex.cz,
	rf@opensource.cirrus.com,
	shenghao-ding@ti.com,
	srinivas.kandagatla@oss.qualcomm.com,
	thorsten.blum@linux.dev,
	tiwai@suse.com,
	wangweidong.a@awinic.com,
	yesanishhere@gmail.com,
	yijiangtao@awinic.com
Subject: Re: [PATCH V2 1/7] ASoC: codecs:Rework the awinic driver lib
Date: Thu, 23 Oct 2025 19:50:37 +0800
Message-ID: <20251023115037.35553-1-wangweidong.a@awinic.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <72907b06-c7f8-455e-8dd9-f5b4041d4bde@sirena.org.uk>
References: <72907b06-c7f8-455e-8dd9-f5b4041d4bde@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Oct 20, 2025 at 02:40:32 +0100, broonie@kernel.org wrote:
> On Fri, Oct 17, 2025 at 06:10:59PM +0800, wangweidong.a@awinic.com wrote:
>> From: Weidong Wang <wangweidong.a@awinic.com>
>> 
>> Extract the awxxxx driver common interfaces into
>> aw-common-firmware and aw-common-device
>> to facilitate subsequent driver usage.

> This doesn't apply against current code, please check and resend.

Thank you very much for your review.
Could you help me? What caused this?

Best regards,
Weidong Wang

