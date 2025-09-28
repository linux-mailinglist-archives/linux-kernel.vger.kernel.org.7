Return-Path: <linux-kernel+bounces-835257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE273BA6978
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:47:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89F10176FBB
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BBD225761;
	Sun, 28 Sep 2025 06:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="G5FUZBjF"
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B45B1C6FF6;
	Sun, 28 Sep 2025 06:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759042064; cv=pass; b=UqcEjZjSZXweSkMFtseyWJmRSb3mR/sxl69n2/xNbiXrJcw3MR6Wdk2Ey0RZTwLm0Uc7nxVqRrUE5VTrNEp4U3G4Si2U+QeSh90Y4pMDWCzzKC+0ye/kFJkVg/4n7/q2HlSg/zU93zH4jHE8Ae0wB7AKS5zA9kWJrzjPSMYrIkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759042064; c=relaxed/simple;
	bh=t6ustQj7Xfe3HKiERNgrVHhh1pz2uVuazT2CqYYtX+I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VW4p7YhuBuGhtBIAJJQeHA0YJfuMBof995sMjlLek+HA9Wv5AEUvI/iSFagq2SOQf4QiorEeLoCgFgvVG7ynbk6H2WPLaZJ137m8NxOCnGstS8OlIhAXAIrceW/4pLMITQX9XhhIBljMb5X+LNvOYRjzvhXysoCMWJGEfMW+1zY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=G5FUZBjF; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (ag129037.ppp.asahi-net.or.jp [157.107.129.37])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 58S6kw0D051679
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 28 Sep 2025 15:46:58 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id EA234109EFD83;
	Sun, 28 Sep 2025 15:46:57 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SgMd9GkpPodp; Sun, 28 Sep 2025 15:46:53 +0900 (JST)
Received: by www.redadmin.org (Postfix, from userid 1000)
	id 7E3BC109F2881; Sun, 28 Sep 2025 15:46:53 +0900 (JST)
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=127.0.0.1
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1759042013;
	cv=none; b=j+K2CKhOHrESoUHYiYOGxBoYd5j9Ey0b6TSHGOxPbSiDseNnNGvgsXvcfWta2V+MU1Agxf+CPR7Uhi+35UPwn+JFaE+fsnU8LoWnkw6vR7YREyEKo0GK8tMeSdMuxgXO53Z1jwL/tWOb29VErxX0nrrIru5g8denNRxDV2eXnZk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1759042013; c=relaxed/relaxed;
	bh=t6ustQj7Xfe3HKiERNgrVHhh1pz2uVuazT2CqYYtX+I=;
	h=DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=HMt32kzNplHxRIZjrssxUZ4FLxqJNmv/Zxj87Y/1ubBx/yWTTGSsij6tm2TCUjyrkSreUm8oIzzBduDm2lR/NU6Ax06vX5BLfBFTkz8D3+RektbLNRRGwQnM16ADFqO0JWlqJQSg0l8mcDzqEemXh+pymgcw+Y9FaWl0Hm7+Jq8=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 7E3BC109F2881
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1759042013;
	bh=t6ustQj7Xfe3HKiERNgrVHhh1pz2uVuazT2CqYYtX+I=;
	h=From:To:Cc:Subject:Date:From;
	b=G5FUZBjF1himgrUO+Abz5dIhQRc4vg2jEbeUDp7PUr7P124LRQKP9/cvRKq2gTzYD
	 omm6HWFpg90h5Rzy8H6iN6l3ASPQBU0vN69rVdTHFM43IfqsEV2IpYkpz1wlLjXZ8q
	 bYVsJ7nlNChytAX04H5zYyeONUVWQOsXUrnY2U3o=
From: Akiyoshi Kurita <weibu@redadmin.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, damon@lists.linux.dev,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Akiyoshi Kurita <weibu@redadmin.org>
Subject: [PATCH] docs: admin-guide/mm/damon: Correct typo "directores"
Date: Sun, 28 Sep 2025 15:46:51 +0900
Message-ID: <20250928064651.281325-1-weibu@redadmin.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The word "directores" is a typo in usage.rst. Correct it to
"directories" to improve documentation clarity.

Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/a=
dmin-guide/mm/damon/usage.rst
index ff3a2dda1f02..5cd42d428c89 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -357,7 +357,7 @@ The directory for the :ref:`quotas <damon_design_damos_=
quotas>` of the given
 DAMON-based operation scheme.
=20
 Under ``quotas`` directory, four files (``ms``, ``bytes``,
-``reset_interval_ms``, ``effective_bytes``) and two directores (``weights`=
` and
+``reset_interval_ms``, ``effective_bytes``) and two directories (``weights=
`` and
 ``goals``) exist.
=20
 You can set the ``time quota`` in milliseconds, ``size quota`` in bytes, a=
nd
--=20
2.47.3


