Return-Path: <linux-kernel+bounces-807448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 328F9B4A473
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58034189CDC2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F48242D70;
	Tue,  9 Sep 2025 08:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="SNbUNCEc"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3C1A262A;
	Tue,  9 Sep 2025 08:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757404991; cv=none; b=Qz3tE6shMFhBYNFL9cmn93V5QOKkkwqtFu5QjEztiNaMKC7j9Ib0Dao+HH53V7yg5cuUPYI9ILWbmQqdotjXvfbpdIQoye/YpcarICLq48/cykjtQKc7pqkSqxQ8zVhSdVriy9DAxUL+Dk9eQKBgK9PEX9+QMs6XpzEadBlvZkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757404991; c=relaxed/simple;
	bh=ZLGUpI+Wdo34rg5qSS9psPdxKAfzinKVPb6v9e0+ybc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vd0OTBmrx/G47VM4PcdSj38LDoIKrHxSSxpLjQMSSP8OVCL1+3yo2Z52wzzf7RVb3bbFKNSJaXqOk/vP0dxxJrGWBW3tx8+Uj/5kmVTW1j9wRqmogEuyfA5g4Ah9qsd+9Eug+NcSmN71NgAu1yoA5ihKIQebAFi3PD3Y9kvOtew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=SNbUNCEc; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=Cc:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=KX17V2NjcwJJ6NiVlViLAU+7MVjS3l7fc1IXv5WS+xY=; b=SNbUNCEcw0MGhSRr27lg4we1lp
	U12IEUlvN14FdUwWejSyYgbdxAoRRm0d8sQHKL4mosEnCRbbNzYZU1Vhg8o4eg9UEE+5TMiw4xeyo
	N7HHcWl75nh3Dsqpi1ScI1iVqMbTWwwVjbBt3IFPd223fsDHzSOw8l2Lxumi0MrbijJUWt6L19FOd
	5MN5avbmav+CjxJIFjtqWhQpRVqgh52o8AeUZK27wJO7aiw0dSshn2IMdnk3TVN5Xnhbc+DJHN21n
	XQpk8YsTk4FbyxCneL7moCAFQC/sZITH3iHkRwwTOyq0PZCWuvDed+tsLmyZ4sh2cwwf11IR5SJSp
	4kZumm2Q==;
From: Andreas Kemnade <andreas@kemnade.info>
To: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2] hwmon: sy7636a: add alias
Date: Tue,  9 Sep 2025 10:02:49 +0200
Message-Id: <20250909080249.30656-1-andreas@kemnade.info>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add module alias to have it autoloaded.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
 use macro instead of device table

 drivers/hwmon/sy7636a-hwmon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/sy7636a-hwmon.c b/drivers/hwmon/sy7636a-hwmon.c
index ed110884786b4..a12fc0ce70e76 100644
--- a/drivers/hwmon/sy7636a-hwmon.c
+++ b/drivers/hwmon/sy7636a-hwmon.c
@@ -104,3 +104,4 @@ module_platform_driver(sy7636a_sensor_driver);
 
 MODULE_DESCRIPTION("SY7636A sensor driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:sy7636a-temperature");
-- 
2.39.5


