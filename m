Return-Path: <linux-kernel+bounces-825654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E935EB8C6FA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 13:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5FE416B37D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0232A2FCBF1;
	Sat, 20 Sep 2025 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="cd5Q3LSQ"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C9F28642A;
	Sat, 20 Sep 2025 11:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758368621; cv=none; b=Svf5/v2ftRfDBsOSACVQv5HcsRoh+VNs7N4N7cBX7d1Gu0Q43my0CmEV8I63emNi95udL/jYb2OvJ0pcfo+n9GquUE2PK2FTzA64pPmwbTqLUMSGm+dWPOE1hkIFMbjqInChmC3xk7B/kCvczczPbWbD1zDITvcUvLvT3O7+Nhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758368621; c=relaxed/simple;
	bh=uSp1CmJhS7d9SOZwpPkfMPBaU1lMBAlmqL+clv7MNcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWTHHspxlRrm0KvvBBPYOJDIBZDm0vF6tr7sAmp3rzUvblew+ZYtqQRDsqrJfZhz0N0WaWZYI4SkRgUNo7F58tTyQy9ScfMJLMbhXLJkrgfx2sj9bBt1+5U4XcB75OZj0ZVRuqcxzdvwNirUq49F2JMP3WqNemk19CqTLxuKCK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=cd5Q3LSQ; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=y67QkzLonKD3ieN8HbVFtEde4nHJxtGBUHziP7ooR4k=; b=cd5Q3LSQPzEY9mpaDz4YzNQTYR
	3xehso6FpnKF8bVo9c+Je86xi3plXAe9K1wbbk+5rnqBVnz/ttg+qjwjdcHcsy+3x+np8vgllnmwM
	yA6fwyqgM80M5ZQDiUYigkCrul5QocHtkgAF7fBJY98xl/nemSQyorXh6abalaNFwsjvtb5o6rsZy
	Yi10au28vXoUD5+mhdL4Zvy5yJamo0JPi/X+eqbAv5bYLpIowJRl5B7H00ADuHqYQjnOB9jWmMISy
	o/yDEXtE7Fu8QCXhPMJtQz3Zyxxu52Xa4Fu94IOZkdvvSedgT5exrDkqtKTRU7A8xaaeH3FSEaRux
	0DYpWmhg==;
From: Andreas Kemnade <andreas@kemnade.info>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alistair Francis <alistair@alistair23.me>
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 0/2] hmwon: (sy7636a) fix regulator handling
Date: Sat, 20 Sep 2025 13:43:09 +0200
Message-ID: <20250920114311.291450-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The temperature sensor in these devices in only usable if its
regulators are turned on.
To have that properly working fix a race during probe which leads to
dummy regulator assigned instead. That fix looks questionable,
therefore mark it as RFC. Having the regulators enabled increases
power consumption a lot, so rather turn them on only when needed.
The usual usage pattern would be to enable regulators, read temperature to
determine how to configure waveforms for the epaper display,
initiate the refresh and turning the regulators off.

Andreas Kemnade (2):
  hwmon: (sy7636a) fix races during probe of mfd subdevices
  hwmon: (sy7636a) enable regulator only if needed

 drivers/hwmon/sy7636a-hwmon.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

-- 
2.47.3


