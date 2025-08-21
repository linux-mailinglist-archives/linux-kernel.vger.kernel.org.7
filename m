Return-Path: <linux-kernel+bounces-779809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D246B2F939
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:03:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC981CE3BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 12:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82915321447;
	Thu, 21 Aug 2025 12:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debanilchowdhury.com header.i=@debanilchowdhury.com header.b="FqdcS1LB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9XkwSiW"
Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B94319844;
	Thu, 21 Aug 2025 12:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755780976; cv=none; b=eGIFG+VEzCI1jUHX+KTVhaiwI8n6VeynMzztPXtOUTwuzzqS+JAtqkztRYQ0jP216ycjghOHj3FqUo4kVyv8Mq+gwhntOumwVbAHtcWJN9xSiv9EFED+u6s/cjkUge+V8Yft4QvHFKZyLNyuUid3jX4uSTa4+kT/0Q7OWQrqckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755780976; c=relaxed/simple;
	bh=whkJEqsTOCyePNjD7NYZqFQXAji21QPdY2r46YSe06w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OZhx5drUCeTg1okG/9go1NGHMwA6qbyw+sifCys1ow8ZQ43YO0h8TorPC24s3aNcxwZEjyZkwTbdF19q18Lilu4WD3sUI5p0HpYu2eXaOBcFnVszTl3yCiBdSmi+T3Z4rySDeTtqgHorwbr/ZTxDZ2JvJpCdZ25d9zFM2wGgQ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debanilchowdhury.com; spf=pass smtp.mailfrom=debanilchowdhury.com; dkim=pass (2048-bit key) header.d=debanilchowdhury.com header.i=@debanilchowdhury.com header.b=FqdcS1LB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y9XkwSiW; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debanilchowdhury.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debanilchowdhury.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.stl.internal (Postfix) with ESMTP id 784BA1300595;
	Thu, 21 Aug 2025 08:56:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Thu, 21 Aug 2025 08:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	debanilchowdhury.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1755780971; x=1755784571; bh=yBewjbsnFCVygw4nugjy4355G6givRfy
	7NgyrPli+2A=; b=FqdcS1LB2GklU63pvDvxbGY3hYnvGEPRIB1dXcrlMcld8lsz
	Y0prwgvAg0AtlWiWblqQM285FIx4ynBMRUsx58RK6k/M8tHuvr4QfuX4Cg1Glzgj
	X4sRYitrxAB7awuamTDxq4Fo9qDDhE0KfpVlpD3B/aHZGCnmtOENczbVzbcBbpCV
	ZhRzMeZvSCWwiVJqxWA8kw/Ut6lDmm7FRFNtTSrliB4wqdkIw92xVcE7AcL7fKum
	tKTL2WvkKqUpTUozONVGOzxm4DZ+R1VRUw51/KvtcdgMrC5nKCvx1TJjEa5OvRjD
	N7VOr9fGVUOmgwlvjgC+mtl+YT+XXFLteq1nUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1755780971; x=1755784571; bh=yBewjbsnFCVygw4nugjy4355G6gi
	vRfy7NgyrPli+2A=; b=Y9XkwSiWw2oKIrsGmOYdovQrZP/myCrInJVy/wWNVcoE
	g1BGRYhToWe65vXU0UMwYZIvvg45ts+v0GayJoCkHsdDjAgDHtyosSGJ/pNH3raL
	5prr4UGWqL1iuj24YRa3QFReZUXeyM3WwY0HZ04r+j39P9aQfYhmEA5DaUvxl3d3
	oa4Q1ihYLMO0D+iF1k1yIIXc/2b5CrYF1u+Bf6/lrDwMdnOGKfDSmrXWGaf7WTMd
	nX8ot8yubYtKnKeTLMkS1s6DSGdLK+B/EFZMPLpmFdlj5NpcW/UwMCRW94c4FUaN
	Nn1NYEgw9X+G/d7ghYGHotKUUU26qjaRjTjR7TUaTQ==
X-ME-Sender: <xms:ahenaFT-UyARaEYh9hqMmKXXcfeap6glqh-ApRDcBi6WNUxSJDbl4A>
    <xme:ahenaHYFAX_l_p3HqPykRK7wRf8UH8ZURF9KzSo3gJYFJEdQiuQMGxp3OiPCNzXCm
    pgSU0fUMYwfTTiJOrw>
X-ME-Received: <xmr:ahenaCQqBFLqhdalGjPKx3Hz9hnWrE450AoOOe5wMDZ8jvNB-nMI5qsbj7KtisYEBewLF6nJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieduvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtre
    dtjeenucfhrhhomhepffgvsggrnhhilhcuvehhohifughhuhhrhicuoehkvghrnhgvlhgu
    vghvseguvggsrghnihhltghhohifughhuhhrhidrtghomheqnecuggftrfgrthhtvghrnh
    epuddtfefgffffiefgtddugeefvdeuteefhfeltdeuieejvdeludetveettdetheefnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvg
    hluggvvhesuggvsggrnhhilhgthhhofiguhhhurhihrdgtohhmpdhnsggprhgtphhtthho
    pedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhkhhgrnheslhhinhhugi
    hfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehjuggvlhhvrghrvgesshhushgv
    rdgtohhmpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvghtpdhrtghpth
    htoheptghorhgsvghtsehlfihnrdhnvghtpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlqdhmvghnthgvvghssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepnh
    hinhgrugeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlihhnuhigqdhhfihm
    ohhnsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqughotg
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ahenaG9knYorJgkQYRgz7YM3p3lyPRV3cqoNG12IkcW2WVDJd2_z6Q>
    <xmx:ahenaCjoxALiQ0LkmrMCoGmxime9ZmmBJowKr7VgggAgf00oRPz2Tg>
    <xmx:ahenaHYCnJMsyND4BYWUig_CWYyeOONuPqY9VPKx8vJEq8xdDe_NxQ>
    <xmx:ahenaH9NGc_jfnMYr0cNHSJU4u0xP9zIJvp2SeDU0pd0idND-FKhpw>
    <xmx:axenaDWR-9T882OJpeI-NS_0A7OeDipszvLn5FjvJKT-cuJ90gvuDVdd>
Feedback-ID: i77364836:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 08:56:07 -0400 (EDT)
From: Debanil Chowdhury <kerneldev@debanilchowdhury.com>
To: skhan@linuxfoundation.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net
Cc: linux-kernel-mentees@lists.linux.dev,
	ninad@linux.ibm.com,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Debanil Chowdhury <kerneldev@debanilchowdhury.com>
Subject: [PATCH v2] Fix typos in hwmon docs
Date: Thu, 21 Aug 2025 18:20:24 +0530
Message-ID: <20250821125539.58313-1-kerneldev@debanilchowdhury.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Fixed some typos ("Critial" → "Critical") in hwmon documentation.

Reported-by: codespell
Signed-off-by: Debanil Chowdhury <kerneldev@debanilchowdhury.com>
---
changed in v2:
- In previous patch "From" header did not have my name in it. Fixed
  that.

 Documentation/hwmon/crps.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/hwmon/crps.rst b/Documentation/hwmon/crps.rst
index 87380b496..d42ea59d2 100644
--- a/Documentation/hwmon/crps.rst
+++ b/Documentation/hwmon/crps.rst
@@ -43,7 +43,7 @@ curr1_label		"iin"
 curr1_input		Measured input current
 curr1_max		Maximum input current
 curr1_max_alarm		Input maximum current high alarm
-curr1_crit		Critial high input current
+curr1_crit		Critical high input current
 curr1_crit_alarm	Input critical current high alarm
 curr1_rated_max		Maximum rated input current
 
@@ -51,7 +51,7 @@ curr2_label		"iout1"
 curr2_input		Measured output current
 curr2_max		Maximum output current
 curr2_max_alarm		Output maximum current high alarm
-curr2_crit		Critial high output current
+curr2_crit		Critical high output current
 curr2_crit_alarm	Output critical current high alarm
 curr2_rated_max		Maximum rated output current
 
-- 
2.49.1


