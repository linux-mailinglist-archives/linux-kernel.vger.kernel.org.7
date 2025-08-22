Return-Path: <linux-kernel+bounces-781389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F982B311E4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 10:34:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C933E188E9BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 08:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F48E2EBDDC;
	Fri, 22 Aug 2025 08:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq6js2hJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C5E2E2EFC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755851635; cv=none; b=L68WVuasIHvOhwqz4501Jr+5iuas7gBbsXHFG1eU+o+XVjIZaWEvf8wsY4dyX6n+d4iW1Lv6jdlDedOuXIHs2DDVf+dqh3nJjly2/QT4nw1G5voXnnS1ijzbW8UNcSc5extiTdFa7pEaDs1ZAN74bUNsfAaohCLvKYGA/fJbmYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755851635; c=relaxed/simple;
	bh=yzCN3FN0MfLniKF1uMMojUEwWVM/Bzgzw/IsqpDGm1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFE/snhuDGuduheFKmVqVwJpY7b3x6BgIMGg2uxCBXie/TXj+xH5aZqaiyr2weI4YSm285MG7KHzBLNt/qUItuj1atDRWy/7N3ycUeID06I4tYt0u/wFphTFksse6nFMIWWZ+EIDTrRt50neDBb3y+OaZV6OijSGQ2jn8+4OSpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq6js2hJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9F6C4AF09;
	Fri, 22 Aug 2025 08:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755851635;
	bh=yzCN3FN0MfLniKF1uMMojUEwWVM/Bzgzw/IsqpDGm1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gq6js2hJFvK/0MVHvNcSww8tMfWGNG4fS85gmircpw9pIIzTYZnK6RJDmOp4DKqez
	 EXoQ1UMlKsthGpNgV26M888qvEzuhOZDZhx57dBDPyQmJrhEWYGEGVVevmuH2WBLlB
	 DItjOKjU3uJ2SnQoZd6oCHT7ll12qf3hYQ6MWczgcy/xILOclCWbrBXdWdy0FRMJtH
	 O0zbdqEkTIHv+jo/ANB9UaSxLS8GWGiXfz4T5QPFb1ENHPhOTx2ODrLVBi7ZAcF+C4
	 5PgwIEZbtw1HGvpNBfKeiLB86v1b+GHr93vcnM+/15Eq9VuJ6qET2x+Gg2UFc+ZRUx
	 2G72CJIyjlYrw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upNDd-0000000C1V4-2l4V;
	Fri, 22 Aug 2025 10:33:53 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: 
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/5] MAINTAINERS: fix a couple issues at media input infrastructure
Date: Fri, 22 Aug 2025 10:33:42 +0200
Message-ID: <2cfcaefd4680270a470a5ada6d07128c0133c317.1755851331.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755851331.git.mchehab+huawei@kernel.org>
References: <cover.1755851331.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The media input infrastructure is missing a record for our maintainer's
entry profile. Also, patchwork link is wrong.

Fix it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fe168477caa4..6934c453bc48 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15415,8 +15415,9 @@ MEDIA INPUT INFRASTRUCTURE (V4L/DVB)
 M:	Mauro Carvalho Chehab <mchehab@kernel.org>
 L:	linux-media@vger.kernel.org
 S:	Maintained
+P:	Documentation/driver-api/media/maintainer-entry-profile.rst
 W:	https://linuxtv.org
-Q:	http://patchwork.kernel.org/project/linux-media/list/
+Q:	https://patchwork.linuxtv.org/project/linux-media/list/
 T:	git git://linuxtv.org/media.git
 F:	Documentation/admin-guide/media/
 F:	Documentation/devicetree/bindings/media/
-- 
2.50.1


