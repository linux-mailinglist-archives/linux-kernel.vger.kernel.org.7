Return-Path: <linux-kernel+bounces-815647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DACAEB56966
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5278F189D4E9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332D11DE4CA;
	Sun, 14 Sep 2025 13:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="X+0Vejfe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818381373
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757857457; cv=none; b=V4GpoYm3cYAUldym2sgC65RTKEPHo04P87vZpgad73cqZwxPb8ey71hshMQWwlCUylJeERDrpjDiXB4KRR4zW4BgRXm2oCgHxovCMMUle40zDeDp8g2ey4c+q7h3WlLd/RMRVC4dcEKo8zuKcv3vp0hqpzNmGWUvkoZHsYKeV4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757857457; c=relaxed/simple;
	bh=37DW7rMQTqGuIaU3oGdVUUuXcppF9xbIvVaQblmAqTY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXPxYrgFnl9avzFHMygjVA6WdScs0okkNomlZ7SeDcAOPwvjf6EdcW1oxgZitP625s0G9pDF259aO6odZFUk9z7DeJYolg4bOKH8G/XjrJZbn9zzRuQD74WqkT+ZEVIIx3xpnekV2yS6F9ac8qEGeNlVlvemEXaVa3VwiyEQSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=X+0Vejfe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B725BC4CEF0;
	Sun, 14 Sep 2025 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757857457;
	bh=37DW7rMQTqGuIaU3oGdVUUuXcppF9xbIvVaQblmAqTY=;
	h=From:To:Cc:Subject:Date:From;
	b=X+0VejfeOPbQdxARPgsHAucALdy8L9TmDWboFJVdNX3D9M/Atg2yFuh3+GvzaAwIf
	 FSW8+mkn3mVCz686mb46rt32H5zDCobiS0cu146fWW5gyzIWML8pG7mEjOWHqmtNf8
	 XOuGDI4a30ITzDxRID3aPcK0enwJzrfRhnwfAftk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH] intel_th: make intel_th_bus_type constant
Date: Sun, 14 Sep 2025 15:44:13 +0200
Message-ID: <2025091412-machine-despair-248e@gregkh>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 25
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=37DW7rMQTqGuIaU3oGdVUUuXcppF9xbIvVaQblmAqTY=; b=owGbwMvMwCRo6H6F97bub03G02pJDBnHjq3pPXS25+Ss/z+OPRbOOvKeP5F5zp3j7aeOlS/Q3 GnVnz3XuyOWhUGQiUFWTJHlyzaeo/srDil6GdqehpnDygQyhIGLUwAmUsrBMM+8RPHHHLlDu12L PVwUFFYv+H9hginD/Fi3/aEaX8VTpz+JiO/q5i1e/V7EBAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the intel_th_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwtracing/intel_th/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
index 47d9e6c3bac0..ba7c8b184cbc 100644
--- a/drivers/hwtracing/intel_th/core.c
+++ b/drivers/hwtracing/intel_th/core.c
@@ -166,7 +166,7 @@ static void intel_th_remove(struct device *dev)
 	pm_runtime_enable(dev);
 }
 
-static struct bus_type intel_th_bus = {
+static const struct bus_type intel_th_bus = {
 	.name		= "intel_th",
 	.match		= intel_th_match,
 	.probe		= intel_th_probe,
-- 
2.51.0


