Return-Path: <linux-kernel+bounces-793239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B226FB3D0F5
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 06:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6E967AD1C2
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 04:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3655822069E;
	Sun, 31 Aug 2025 04:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debanilchowdhury.com header.i=@debanilchowdhury.com header.b="UjewcU/2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k+Y7ITmh"
Received: from flow-a2-smtp.messagingengine.com (flow-a2-smtp.messagingengine.com [103.168.172.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5937261D;
	Sun, 31 Aug 2025 04:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756616256; cv=none; b=n+d4fINVjze/njidc2uIJfkjzHs54tubOqMbWLeOVJv4+z3EG7LEuX1C77FY1SwIkgk1dkeiBhgIRlhi/JCDry0ThMlhgKGLZ+/twlkfo92Pr3UdtbPkKvCFW9FQoOG+25OkWffZ/pSRN6P7JyMpw8i+1sS1fjmd6L5nNSfLgtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756616256; c=relaxed/simple;
	bh=ZgdvW6GgvJ1Gj0JKAawiJAVU5WNBvXuwI8BkRynFXcg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fNls5JOwVvILrUwP7C06CyyEqgRA2QilvC8GWKqqLRsjbYtA1bO3sVOWFTfZL7VP9wEu+2fsp4HokCeWcS5YqNA7yMdErcek+NW3nlXEFM/eIlvZgoQ+6vxe2MBS4XwHWVcWM2jR5X232PyFeguHMsVNp3yO63VLnDgk9GUEK5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debanilchowdhury.com; spf=pass smtp.mailfrom=debanilchowdhury.com; dkim=pass (2048-bit key) header.d=debanilchowdhury.com header.i=@debanilchowdhury.com header.b=UjewcU/2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k+Y7ITmh; arc=none smtp.client-ip=103.168.172.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debanilchowdhury.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debanilchowdhury.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 5323E138027B;
	Sun, 31 Aug 2025 00:57:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Sun, 31 Aug 2025 00:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	debanilchowdhury.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1756616252; x=1756619852; bh=EWxmYn7csugiS8y3bY0p8+D1k3LgZQJI
	gdJXipDGzfY=; b=UjewcU/28O6nJ39u9OMTxzFMuFZEGZQzY8XzurdIQYNmWjsh
	JRu0hp3xtF/SOan11vtoDZZR658llIDw/ge+0XK/rquqlat4paZIpZzQcR3WpolL
	0B4O+HkLNBSBCCgQMe/aMwozsyrshk1z6XTteKempvwgk8O8nujWXcEv5lNL9Iw2
	g7m9UkH6wS6bg2bPpm/p2MYlrtJjNhrHyFqm/B17817pHBRVVdn7Bzz71zkAbAA5
	nWDbZeaMe2ECYTPYyajbj8mhuZn/7TDf2ZoTiEA4IeUPIJWpwkCy87Qq2DXPcny9
	Dn6MicmTtfJxmdNgnzJo9Pp0K5FklDwM2rvBxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1756616252; x=1756619852; bh=EWxmYn7csugiS8y3bY0p8+D1k3Lg
	ZQJIgdJXipDGzfY=; b=k+Y7ITmhp6wWsmVi7PSGvsnQB5q9JnbNLqf5SSqm5zRp
	OJGjn+4HY4VQvTNBrZ54Zk8sih3VuRsn/V1i/ZxkHhMad2JP2TraYKRPrcHjVJCN
	NCPiG4ojZv9kJb4Q7c3OSTDPathm24is/isEcQ1IQfCdqPocHQQCR5N2W2kqfRiR
	WIW+aW7WTUCGLfzIuO9QiQvdwzmo4CR0cV2dLLWEyIXfRYp09Dy+HM7THFgDgGqF
	VagXAVVPt6R17/Um/b1lvKh3Aj/LuFa0L27NbX4Hz8nhdo0KbW54eFuovnFFxIN8
	gg9AazPcMP2ITzgPTj4i2qL+2qBgTBQga46cKUEe6g==
X-ME-Sender: <xms:O9azaCy4mdIlWtz4ZTFXOx649xsNKMJzswt3EKZvqWBc-b3s0dv8pQ>
    <xme:O9azaG42ya4x4-EGlvdvWybMRbuXfQKaLgwWFb9_vVeYs9_uKYcYlVEqqYOZ1N4qP
    8lLdd-_QJnz1weLRz0>
X-ME-Received: <xmr:O9azaLzT37qO9rWtI2r0WKT7WJV0n2QkmarMTXuigeWByFI5N8K3QyHgbOwlnULEtnat5QPTOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeekfeejucetufdoteggodetrf
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
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhkhhgrnheslhhinhhugihfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhdqmhgvnhhtvggv
    sheslhhishhtshdrlhhinhhugidruggvvh
X-ME-Proxy: <xmx:O9azaCcqo7LBaUhSiCmPvYtTSKLBEO5KCZZ92LH05pAhZfQVlyQbUQ>
    <xmx:O9azaIBnfRJc1QZXgv9bgS0VY0PeqP3ne42Kzl-xblr2kxYbZPJLjA>
    <xmx:O9azaO5Ks7xpMaJhoQ-g8nZY1KCv8iNLBZirMi6KS75Y580IqoHjng>
    <xmx:O9azaJf4vhezExlJjSNEeyZFt5Nvd9kjd1P2G7jWSqA1ahILQ_5YaA>
    <xmx:PNazaO3oJCdaKZEDTqHJiA8IszZT1rRyxfqH8U-9wauUXwtGVQTcLeZi>
Feedback-ID: i77364836:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 Aug 2025 00:57:27 -0400 (EDT)
From: Debanil Chowdhury <kerneldev@debanilchowdhury.com>
To: ninad@linux.ibm.com,
	corbet@lwn.net
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Debanil Chowdhury <kerneldev@debanilchowdhury.com>
Subject: [PATCH v4] hwmon: crps: Fix typos in crps.rst documentation
Date: Sun, 31 Aug 2025 04:45:54 +0000
Message-ID: <20250831045710.6009-1-kerneldev@debanilchowdhury.com>
X-Mailer: git-send-email 2.47.2
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

Found using codespell tool.

Signed-off-by: Debanil Chowdhury <kerneldev@debanilchowdhury.com>
---
Changed in v4:
- As per guidelines "Reported-by:" should be immediately followed
  by "Closes:" with a URL to the report. Since this was locally
  found, there is no URL. Also since this is just a trivial typo
  fix, I am just dropping the "Reported-by:" tag.
  
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
2.47.2


