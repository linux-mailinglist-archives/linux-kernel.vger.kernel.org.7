Return-Path: <linux-kernel+bounces-781984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E390AB31980
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598071C2303A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FCC2D0274;
	Fri, 22 Aug 2025 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debanilchowdhury.com header.i=@debanilchowdhury.com header.b="e2QiEQpm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dgLAXY7V"
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027FF2FFDE0;
	Fri, 22 Aug 2025 13:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869343; cv=none; b=C7ZWpoH03oinN6vDbT8BCJKiHXTS0oCVNGJY0GFDZ7U4MUCD9jw/symtImQWh6T01IpBLkcj2LYFiujIOTFlOGDJP12xphWX53pj+bvlEg44GQFcSajnAio/QMuYd4NGXTStybfwLkQtZiG4zZqoQhYEucoYdS3/5dSnbntvTlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869343; c=relaxed/simple;
	bh=ZL8GY7g3uwloV0kELsLuK74wUOOqCTd2WYewZKfdFAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uqU+A7+wK9UW/bvpiFkBWdvzaSQE0W7j5gEv5b0f3T3V16rSY/yiXBdQRv1qWjP9pMP6K/BXACFcceE0OQMI2hzFRF5vCQ1RIiNwDvYzW4XX96ib6PpBL10wwbncdt2lvCXSlc2yhZTUdUGx76ul+qw9MepKqURefaTq153tYSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debanilchowdhury.com; spf=pass smtp.mailfrom=debanilchowdhury.com; dkim=pass (2048-bit key) header.d=debanilchowdhury.com header.i=@debanilchowdhury.com header.b=e2QiEQpm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dgLAXY7V; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debanilchowdhury.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debanilchowdhury.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailflow.phl.internal (Postfix) with ESMTP id 359101380836;
	Fri, 22 Aug 2025 09:28:59 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 22 Aug 2025 09:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	debanilchowdhury.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1755869339; x=1755872939; bh=wGSgMf6A1+ZzqOwuHh7cUjUzSlzSWwas
	r3z6cM11JqU=; b=e2QiEQpmtO+zUtuUCCuUIhEh+m8BC0Td/GFbdqqD5kcjSiIn
	gw83qn8IGVrB3oef45dIgnVsIrO96NIS3Dp9i0rfCickEk6Fo5QSyDmY00l3Ur7I
	ShHRxRS1h36kW7b7EYVWpYoj+Qgnr3IgueP1jqhcYjbrWXd/GccQ5/Pcf2IA7ZR2
	GX3nICLjBiae9tocfVc83SeGQVYiy+yy1OvHX+ewet3pIlnmxO3WHA6qBIVikFdb
	y5aRY6mLTnvFmXep2mxyoHiPmm9mXjBju49iNGUNbTETzFGjaMB9Y03hL7qN6AKO
	V4u7kNyM4x/oLhZsiX/zzdmvGFJOxDkjDXbduQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1755869339; x=1755872939; bh=wGSgMf6A1+ZzqOwuHh7cUjUzSlzS
	Wwasr3z6cM11JqU=; b=dgLAXY7Vbay4e4uyY76rDfSbM1NuTe2EzhxswsACNQdZ
	9iv6+qiXDQ43+CeIVt0eK/ShHUJctC1Miys2UqLzIx56wLZeM/GHmsww4AVW5Ysb
	KGSUS51wb/7HAD/cl8zk+KQpjk5yIo3vWBnPlIZjXSQOBh5MZZXcV0nhk8UielnB
	vE9SLw5UNnvC3ddWrr1gWMTvpCM1p8lc0k3hHcZQv+OrBduNmR/q/XqnBT87cm9E
	16U+bG54xtguonmxwnroKeDD7EX4MzeYh9Wv0LybDvOaLRytWNymHE9dlHuqrYq0
	9pvnUVDD3ixfUTHBJm5GgohHm44tjPQiEtTtSmFbaA==
X-ME-Sender: <xms:mnCoaH6ayRa1J5VjV97lTOdc70mpfxI-tzRb5VFXffIMalstXi-P0w>
    <xme:mnCoaFg_GnzLBSHa-goUBu-nQdAYbeSwK07ZcmkZSGtmnsxgYKpW963ZGgiUP9XbU
    hbFWNmHA32yfBMqxvc>
X-ME-Received: <xmr:mnCoaF7bGhjG0YWieZxUljQvarX73Fz0RrhZJENZKJC5Zxlxg2cGvI5ZxBtgIa13cJ5zT6vd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieefkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtre
    dtjeenucfhrhhomhepffgvsggrnhhilhcuvehhohifughhuhhrhicuoehkvghrnhgvlhgu
    vghvseguvggsrghnihhltghhohifughhuhhrhidrtghomheqnecuggftrfgrthhtvghrnh
    epuddtfefgffffiefgtddugeefvdeuteefhfeltdeuieejvdeludetveettdetheefnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhgvrhhnvg
    hluggvvhesuggvsggrnhhilhgthhhofiguhhhurhihrdgtohhmpdhnsggprhgtphhtthho
    pedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepnhhinhgrugeslhhinhhugi
    drihgsmhdrtghomhdprhgtphhtthhopegtohhrsggvtheslhifnhdrnhgvthdprhgtphht
    thhopehjuggvlhhvrghrvgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugiesrh
    hovggtkhdquhhsrdhnvghtpdhrtghpthhtoheplhhinhhugidqhhifmhhonhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepshhkhhgrnheslhhinhhugihfohhunhgurght
    ihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhdqmhgvnhhtvggvsh
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mnCoaCH2-PIzc-BXzTMsh8eBAabRosNSN8dfDMuwefl2-jnU3iBo4A>
    <xmx:mnCoaPLcv2LOc3B-3j2uBnHe0do8pRLT4eJ2Fd4ggKjffjEF5S7Ojg>
    <xmx:mnCoaHi4m799LMv0Y3iukXzpDUNrqwXbRmhrXAWmO-L_NV3AhwgFIQ>
    <xmx:mnCoaFmYV843PbkrPB52lbNVmZz5rBM9i2r8PdX3SjBVfL62YaJ5qA>
    <xmx:m3CoaGd2-erDJxWWGrT5hIJdem637aHkTCS0G3p7l4GHby1HeuaAwaHo>
Feedback-ID: i77364836:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Aug 2025 09:28:55 -0400 (EDT)
From: Debanil Chowdhury <kerneldev@debanilchowdhury.com>
To: ninad@linux.ibm.com,
	corbet@lwn.net
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Debanil Chowdhury <kerneldev@debanilchowdhury.com>
Subject: [PATCH v3] hwmon: crps: Fix typos in crps.rst documentation
Date: Fri, 22 Aug 2025 18:55:02 +0530
Message-ID: <20250822132836.5384-1-kerneldev@debanilchowdhury.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changed a misspelling in crps.rst documentation:
"Critial" → "Critical".

Reported-by: codespell
Signed-off-by: Debanil Chowdhury <kerneldev@debanilchowdhury.com>
---
Changed in v3:
- Update subject to correctly identify crps driver documentation 
  (suggested by Guenter Roeck)

Changed in v2:
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


