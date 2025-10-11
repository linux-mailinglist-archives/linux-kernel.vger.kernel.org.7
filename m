Return-Path: <linux-kernel+bounces-849209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DEBEEBCF822
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 18:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 63FB134AC5E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 16:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744EF280004;
	Sat, 11 Oct 2025 16:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="l7ZoZL89"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1E527FB28
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 16:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760198792; cv=none; b=WhDXDmXD24HxTLVlnI/OasGgVOl7aTjbcKllCAWYQ9mqdvP+bPy5xf/Cghbg/9Wj2gHhG3Mv/YeQyUkEnsLBWJgnfpP8/ZmTrX0tzAPDQ49jybyMfIVfZSWY5eYuw5Ey2J+pXwHUA4ymY+R3MMiX9BxwbJLFFdggMIekKpjHpz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760198792; c=relaxed/simple;
	bh=5rFbMqeStpaltIS7glm2LBKpSjvIVsWZyHQBVx2Lss4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnMGK8I/R+/NH/VnUsII1RQR9N45SszzMuiZh2Zniux1zUQcE3PG1ubQADmWA3h1w9l3h6bvRDow2m84VncXonZ2ObVBNBeStK7t7KvEFilKuWC2j7m6rG1CXCkg2fayT1z5ObfYljR35ztwavbms4xlIn+AjNaPVcARmR6WRTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=l7ZoZL89; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 574CF240101
	for <linux-kernel@vger.kernel.org>; Sat, 11 Oct 2025 17:59:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760198380; bh=P6SznLlb+1wLEnL5KNYfhH4JJhCf89eBVGCxqT259vQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=l7ZoZL89KFwneLjV9ze4YySsOejeI9ERiX70w6krCCo3UjniS4oO7sgrrmj98AkfM
	 3+AN1Ajt7b4fuY625XeZnYYV28I60mRquocchlnoTUe5+wSUOlIVYjHbeHi73Vebqr
	 zvgLZqG8/7dzHioYil/uVGsV0tsYEXYsIViztVUS6YkT+75BR5CAebi/k/uqnYy2Yk
	 PLg9aR5TGETA9Etr41+Tw8KoZqV4D0IQWs3DKwZg5bFxEoWVV9w8t7Km9Uc5l6F4VR
	 y4XbJZFSUrw05VwV3uKCZ9ZB+9IhkNU2dOWxPSNJnWT21XrZWFTE/AHBpUq0C7KV4K
	 W4uhEYlz7EJ2g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4ckSwq4qkSz6v1g;
	Sat, 11 Oct 2025 17:59:39 +0200 (CEST)
From: =?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Martin=20Kepplinger-Novakovi=C4=87?= <martink@posteo.de>
Subject: [PATCH 3/3] CREDITS: Update Martin's information
Date: Sat, 11 Oct 2025 15:59:39 +0000
Message-ID: <20251011155903.7442-3-martink@posteo.de>
In-Reply-To: <20251011155903.7442-1-martink@posteo.de>
References: <20251011155903.7442-1-martink@posteo.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Surname, address, email and the description changed. Apply these updates.

Signed-off-by: Martin Kepplinger-Novaković <martink@posteo.de>
---
 CREDITS | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/CREDITS b/CREDITS
index 903ea238e64f..c534b7fa0b5d 100644
--- a/CREDITS
+++ b/CREDITS
@@ -2052,16 +2052,15 @@ S: Korte Heul 95
 S: 1403 ND  BUSSUM
 S: The Netherlands
 
-N: Martin Kepplinger
+N: Martin Kepplinger-Novakovic
 E: martink@posteo.de
-E: martin.kepplinger@puri.sm
-W: http://www.martinkepplinger.com
 P: 4096R/5AB387D3 F208 2B88 0F9E 4239 3468  6E3F 5003 98DF 5AB3 87D3
 D: mma8452 accelerators iio driver
 D: pegasus_notetaker input driver
+D: imx8m media and hi846 sensor driver
 D: Kernel fixes and cleanups
-S: Garnisonstraße 26
-S: 4020 Linz
+S: Keplerstr. 6
+S: 4050 Traun
 S: Austria
 
 N: Karl Keyte
-- 
2.47.3


