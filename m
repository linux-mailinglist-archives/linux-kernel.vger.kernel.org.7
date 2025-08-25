Return-Path: <linux-kernel+bounces-784626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CB4B33EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85FC17769B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B87A26F296;
	Mon, 25 Aug 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usN12V7H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F9126D4EE;
	Mon, 25 Aug 2025 12:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756123511; cv=none; b=HfXSjHdNzRiimG418fHJctGw4klMuNHWCSquB3QowaNmGUcy0C/MQSsI5CTMUVtvcQ131FfWowj1ETUIBLur8tPlpUD+t7ZD/IHmjdu7KzZmr/uVfNCMSPPr1u6cx5wyyK5OrHXTmOqW5RtkU4N+G5/54kbroliblBGOs6eckp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756123511; c=relaxed/simple;
	bh=uvqbNT8E36EAqzzQ38xNPy0pyZIoO6YvsdgwWxIpF1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BU7aG7+4gDReetRfNASm4ZREiHAkkn/sWfWU62zCNDL+7zVSHknn22VFLzOXaaZMyhZxIjR3EMCKruKGxN2FN+g6lhu0bgO1uNPLBZJTnAXjn3CHL4u4pD34jgaBpoSvP3CLDLa6tYvxsANCuU0Ruhc6Dc0eu/nGh/KVDcOIOIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usN12V7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2204C4CEED;
	Mon, 25 Aug 2025 12:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756123510;
	bh=uvqbNT8E36EAqzzQ38xNPy0pyZIoO6YvsdgwWxIpF1M=;
	h=From:To:Cc:Subject:Date:From;
	b=usN12V7HeYkBsI3ZAvbIU0wTNZYBusbBrX3brMUF9VIWpcXkZAJqBSocCgvYyEyOu
	 qS9iwST1HdiedsE3tCiWIcWU1oXsO34YkX/XECg4Q1n/iU1GoFY3dR6g2vRmozpwW+
	 AaCpbA9mnGFZVnp62csYzocT1ds/rYf2zkuh1Yei0y0mJgl2Dn3dRYIecxU1hON1Yj
	 59EtYMBWU0ibvo9TWwchNzryQqJ5UgGB5YOn5rMkq4Jox51hRQUOnY6/T5Pl9nBQqP
	 Et1qljnoJAq+i7WFtgBWLI1v5gJgcAC0qD8jzb4qqH6B1jq3d7gTs//L4vT5WY2eXb
	 ZiX2QKak7dEjA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uqVwi-0000000GF0H-42YA;
	Mon, 25 Aug 2025 14:05:08 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: conf.py: drop xindy rule
Date: Mon, 25 Aug 2025 14:04:55 +0200
Message-ID: <83068bc31839e7095f1f408e49658362d467797e.1756123459.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The rule as-is is wrong, as it was inverted. Besides that, after
retest building all repos with suggested LaTeX packages given
by sphinx-pre-install, I was unable to reproduce the issues
I saw with xindy in the past.

So, let's just drop. If anyone reports issues with xindy, we
may need to readd, but at the right way, e.g. {options}{pkgname}.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 8fcecdb927b1..574896cca198 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -458,8 +458,6 @@ latex_elements = {
     "papersize": "a4paper",
     "passoptionstopackages": dedent(r"""
         \PassOptionsToPackage{svgnames}{xcolor}
-        % Avoid encoding troubles when creating indexes
-        \PassOptionsToPackage{xindy}{language=english,codepage=utf8,noautomatic}
     """),
     # The font size ('10pt', '11pt' or '12pt').
     "pointsize": "11pt",
-- 
2.51.0


