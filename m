Return-Path: <linux-kernel+bounces-777775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EDB4B2DDAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83B384E0993
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 13:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874DE31DDA7;
	Wed, 20 Aug 2025 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debanilchowdhury.com header.i=@debanilchowdhury.com header.b="ciWRj656";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RqcYhAWr"
Received: from flow-b4-smtp.messagingengine.com (flow-b4-smtp.messagingengine.com [202.12.124.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D931CA7D;
	Wed, 20 Aug 2025 13:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755696071; cv=none; b=mgHUx593iT8QXksCfotDvF0qlYPrK/k3u1NBtv+DLAp063VrmtvFdWTTL7izvvZKXK+Kg1JOjW1YHGWne2x2kDsU/rioqgOt1KiQMipJUX2ZUSJwyczY+PDiyD7/1Rl+CmLQh3E5mJ1tpMkgi8Ue3yNUy3XraLtwuf1mhfK8lFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755696071; c=relaxed/simple;
	bh=XsGOUexS48UBQOOs/YAItiCIMtGhVhIMcpJQIr9hATU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tA06qKSHHOHB35AJM0YCEZ7BIivAlz8gfJyGRiHXXV+1cfdoV9i0NGEH8ucNAlRRsfAcZTcFVB1aNf5pQzSn2M3NjQ3RcTlyv6SxZkYXeLpfKnDedlZ0YFP6hZxmqfbZcapMuw/RRVku8KgA5G9hwwlSph+8hiuFkDnZ7xsRXrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debanilchowdhury.com; spf=pass smtp.mailfrom=debanilchowdhury.com; dkim=pass (2048-bit key) header.d=debanilchowdhury.com header.i=@debanilchowdhury.com header.b=ciWRj656; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RqcYhAWr; arc=none smtp.client-ip=202.12.124.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debanilchowdhury.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debanilchowdhury.com
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailflow.stl.internal (Postfix) with ESMTP id 6F91E1300BA1;
	Wed, 20 Aug 2025 09:21:07 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 20 Aug 2025 09:21:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	debanilchowdhury.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1755696067; x=1755699667; bh=nEImHcQLvkNTCdFF2RtXX95NV2iRh1V3
	J2yvcVtfk74=; b=ciWRj656q5wiX4lnyxquvE56D6HFFEZxvfkLf4mPHt+ijgJN
	Hx8RaXReL73dow2oljr1DsQby7Og6Yu5Ihex8EghsBYpr65qfI76uyZauHgEbq0K
	1TNUpNHYiYZrxKhdBWrCSm37Ck0kDBgw/qKBT+vwymH7qLz/pYSj5XdCHCbVVY6L
	0658WvOzIzl31plVzIY1Osi72cKjGfzUeI4w2XynHS/Sj7WnCidV2TIw+629btXK
	mY7EbRLslbuk/KcsqLx4o/JlV6fXMH98pqS8ysOktZGDtp2vvZTXhqqj5tV8cyhI
	xgb8JTLPRMmJAGQaTBkSWFDZ44UXm+2Uz0LtlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1755696067; x=1755699667; bh=nEImHcQLvkNTCdFF2RtXX95NV2iR
	h1V3J2yvcVtfk74=; b=RqcYhAWrQaCdXoeWDP6EJnvareF2jWFHDlGgseqOkBUR
	HjFoVIoDus2utHLOEtUf+Y7d9Km2K1nsbImjPHL77TLPMRowyOUrojAhyLdslOs2
	E1QqpUe958HOqVP5441NY9OKQyn3Behma4r5xqrrIC113tZi9Efjypf9DaMkR/sU
	I7w5s9/Q4aanxllTCju7AzZ08Lq+kaSyLuhBH2WbZlILut/TyFqyKqedYvHkvH41
	/uVXA5cTeXw9n78kHpgCGAwcC6kvcVLZ2fwfoCsVBGdvMaAxOcDt3lKE1+nwFgUn
	sb6aNnlrql6lpcimwteeMfc/iRhsw7BAKLWtu0WXeA==
X-ME-Sender: <xms:wsulaAH0vk_vJo1M2qtDeSPc3igywCTFuzdQ9eo0_fH6CUseFmiPjw>
    <xme:wsulaB8OwUkVyz8TF0wLXf2vVyFVP0lH79cT83YZ7BB2IbMEjc66NwhNkgFsxxEq3
    DiGWBwf25OQU8bmiv0>
X-ME-Received: <xmr:wsulaBmwW7fBcKPzWe3wNvg1aMsJnOVde3f0E58G7UcsVbMUjIH9clMz88awdLXzI6KCc41X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheekgeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekredtre
    dtjeenucfhrhhomhepkhgvrhhnvghluggvvhesuggvsggrnhhilhgthhhofiguhhhurhih
    rdgtohhmnecuggftrfgrthhtvghrnhepgefhleetiedthfelhfehtdevgfejtdeigfegte
    fgfefhieffheekudevgeelkeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepkhgvrhhnvghluggvvhesuggvsggrnhhilhgthhhofiguhhhurh
    ihrdgtohhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepshhkhhgrnheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtth
    hopehjuggvlhhvrghrvgesshhushgvrdgtohhmpdhrtghpthhtoheplhhinhhugiesrhho
    vggtkhdquhhsrdhnvghtpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtg
    hpthhtohepnhhinhgrugeslhhinhhugidrihgsmhdrtghomhdprhgtphhtthhopehlihhn
    uhigqdhhfihmohhnsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinh
    hugidqughotgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhdqmhgvnhhtvggvsheslhhishhtshdrlhhinhhugidruggvvhdprhgtph
    htthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wsulaMCLF0eZsrnfi0qwk3-W9DxUZ_RiW0cB2oiHJ25xZ7Qvmp3CXg>
    <xmx:wsulaKVrxn4by8ihI64CdoWc1OaGHn6ki7kQXR_u14tVZgZcwfk12Q>
    <xmx:wsulaK9Mn1kPljByIwh0tQ7GFKaZ6cc7QjtU35EwPCUD6xjS6Jv_PA>
    <xmx:wsulaMQdu-0itt_oaNGTUeUyRsl87GQp7GtlDLsM1oPasL02aOtBbw>
    <xmx:w8ulaEZEjBugC0-U0GT8K1mOIzY4LG9R1SANBC6j34t-nG15ZqfSZRmc>
Feedback-ID: i77364836:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Aug 2025 09:21:03 -0400 (EDT)
From: kerneldev@debanilchowdhury.com
To: skhan@linuxfoundation.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net
Cc: ninad@linux.ibm.com,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Debanil Chowdhury <kerneldev@debanilchowdhury.com>
Subject: [PATCH] Fix typos in hwmon
Date: Wed, 20 Aug 2025 18:48:08 +0530
Message-ID: <20250820132033.11377-1-kerneldev@debanilchowdhury.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Debanil Chowdhury <kerneldev@debanilchowdhury.com>

Fixed some typos ("Critial" → "Critical") in hwmon documentation.

Reported-by: codespell
Signed-off-by: Debanil Chowdhury <kerneldev@debanilchowdhury.com>
---
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


