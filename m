Return-Path: <linux-kernel+bounces-782121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A135B31B73
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B94B64340D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1943E31280D;
	Fri, 22 Aug 2025 14:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZPDDhWkt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6013A2FE564;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872388; cv=none; b=CjF1jBPR9640pDqwZL5jY+oMZgPGimGqPRmCTKAJQYOp6cLpRsdxAPXCkK9GIgB7BEaXoroJkt3SGpqKlnAHyXydCk/yCTQBvK7h/LXgJHFKUOgu1UoH/t3OCXfxTcA3VUhj2d0JBssbkNZZKLG2Q3qLiJmS3dCo7VWLvfHlUrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872388; c=relaxed/simple;
	bh=xaVYPkTp3UCaFGLlpkZHV5Y3yGQI0qRfBiGX9ydW30c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ltm+hbG7NGxuUVfp/FSKpO4/5G4sJNkoiqBx1Oh9lpZfUdg05iX0clmP7K9sfBHyWG05ckSfsSB/gtHeQr9kfUBK8c+E/irplrPN4hkHhYDjmuF8Pt9bl++0q7kjYtKkfoJsr3iN4ODCZEB/F+1NOA/7D4JdvrAaBc3UudWDa/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZPDDhWkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B03BC19421;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=xaVYPkTp3UCaFGLlpkZHV5Y3yGQI0qRfBiGX9ydW30c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPDDhWktb4G+LquyVzJFUAueM1W0FMp3s2jOTA2CUSJFGdOfKE8/6iy//dlqvoTLh
	 WrpIrRbxqnfj9gntTOgJsx9gaI12gZDTYdEp+zlSvzhZeeGfqHfkKnVPSCrqyIO2YA
	 nsfBrEdMrxFuNP1/5f6TLeOIAB/Wd5DrSsx/d+VumIKqJvTpOWf4zPoIGuA4bJuEZ0
	 DyNHP7+WFX0Q5FFPdiNnTcniubti+Oys12ag3XfaqzIjBarRXBPhXAe3MNjUv8JZJM
	 XZat/DItWzK1WZ/3RgOfIHYVk52EAkUOndsWLX5VcjCofKU//QnxrJxdgr1O/Yshp/
	 U5GpqeGd7vpLg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCrB-0zmo;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/24] docs: parse-headers.py: simplify the rules for hashes
Date: Fri, 22 Aug 2025 16:19:17 +0200
Message-ID: <0c011090272f7a1068545409222f970ddb1ed431.1755872208.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755872208.git.mchehab+huawei@kernel.org>
References: <cover.1755872208.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Normal :ref domain accept either hashes or underscores, but
c-domain ones don't. Fix it and remove unneeded places where
we opt to disable underscore transformation.

Ideally, we should have a rule about the default, or change
the way media docs have their references.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/parse-headers.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/Documentation/sphinx/parse-headers.py b/Documentation/sphinx/parse-headers.py
index f4ab9c49d2f5..344090ef259c 100755
--- a/Documentation/sphinx/parse-headers.py
+++ b/Documentation/sphinx/parse-headers.py
@@ -162,7 +162,8 @@ class ParseHeader:
                 if not ref_name:
                     ref_name = symbol.lower()
 
-                if replace_underscores:
+                # c-type references don't support hash
+                if ref_type == ":ref" and replace_underscores:
                     ref_name = ref_name.replace("_", "-")
 
                 ref_link = f"{ref_type}:`{symbol} <{ref_name}>`"
@@ -258,8 +259,7 @@ class ParseHeader:
                 if match:
                     name = match.group(2).strip()
                     symbol = match.group(3)
-                    self.store_type("typedef", symbol, ref_name=name,
-                                    replace_underscores=False)
+                    self.store_type("typedef", symbol, ref_name=name)
                     continue
 
                 for re_enum in self.RE_ENUMS:
@@ -272,8 +272,7 @@ class ParseHeader:
                 for re_struct in self.RE_STRUCTS:
                     match = re_struct.match(line)
                     if match:
-                        self.store_type("struct", match.group(1),
-                                        replace_underscores=False)
+                        self.store_type("struct", match.group(1))
                         break
 
     def process_exceptions(self, fname: str):
-- 
2.50.1


