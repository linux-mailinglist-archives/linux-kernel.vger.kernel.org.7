Return-Path: <linux-kernel+bounces-722589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25068AFDCA8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 03:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867537AD713
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB77E1624DF;
	Wed,  9 Jul 2025 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URWBSzy1"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB45B156678;
	Wed,  9 Jul 2025 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752022847; cv=none; b=BsaJzEfVeFR8YlNX3/WGrvp5u/UJ4s8Zo1HWsyApGq2GmUrm/3bU0pvNFiNxzEHD/R1yxLmrgTqaann1zaXWmqq1eEwK7FA922uVB8CYdgMbFeaAVy5OjSA6TSQ90XA/BINMeif3jR2FDYOlreUO/Tz1058ALDaakgynNLZjt18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752022847; c=relaxed/simple;
	bh=IsxDvUOlPC/SNQd1/+tcnpC3Es95w6IQg+qyLyewcNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBHt/EdbBcJMgm/UPavihwUV3p9StYJmr21rOYvXfL9ia395tFcJUoo6fbT08doccc+tAJYOKjvHBspc9tBo7W2W5JfzpmGrhvuJ+FJoPnsByaty3p+ohjaIJwrKOnW6hC8URZRQ9Is+GbD5QC6HjiURt0CbtMg8IueuDVkyd8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URWBSzy1; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e8b3cc05665so2793998276.2;
        Tue, 08 Jul 2025 18:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752022843; x=1752627643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2jsjg4EouOhcgExOsiiXXDMU3g5WamEv1plw5aSp2k=;
        b=URWBSzy1cz91XBJ5ACVDdXX/IGi2f3wYCoPCcAb0zSnz+DPn3a98ShzlhmEPUrx1WX
         7TnmFln+UCXiv8zMrk6JJ4DEEjJ/YrnWTUIklB0ADbXZH2K719C9+ZYvER7OYpeBgncp
         KDuFv01R+NKxiKOXHzYuJaBWIgTVy0qWEhgFpe1d3HBqtfzcJZxSmOJ4mygqQJdX6J26
         kfKH0PbEGxm1sgIJq8ADI+2+YISFZmzDrVx5UFaqKVIlwtV7+mqLYXVogUHipPKQ5VYy
         4brU680V61pTPIekZRznmSAJWdqsnFvuif3LmpRUGeM0Giao0j0iZhR+QZjQmmPwdVwg
         EqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752022843; x=1752627643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2jsjg4EouOhcgExOsiiXXDMU3g5WamEv1plw5aSp2k=;
        b=XcxzyAd8tMS4528P8M1xVk8vHtLeofwAqT4r/aHIHSmpTk6uQinGxgxp2676WKRAyk
         BCZy2QmRk0doLGJOreMDoJ+c6q0yAxdv1NavkbDdVEx54U2hhcsC3ztrl9UQJkFNR5ze
         YYk/UtOLX4+ak8Cqzd0Hu9h6rg/fTvpNK8dkPdOnc39k3KhORKAzgQ7HU0Gc/Z0QOd79
         aUsB65P9oXivqFZ9Aa9j0a6E1G8BDJmx8ZkNMl7/pHvru0wQPNLgKy7mRkvpivftq3sF
         2FmDHTwb5zAtdR4uufRpIEM2LXkc0zZbeP4Ci1HbGqPs4E2DlJVGRwTKine/GOXNjBl2
         QNng==
X-Forwarded-Encrypted: i=1; AJvYcCUbR4AG1h1mcX5kQ8NfV5Ak5JIQ/SzySH8vkseFNNP2jV3FpsDaS7SUjHJeaNGNtUnH/KtPfgz56bw=@vger.kernel.org, AJvYcCX4paOu7jmv3zWhG1eEzvPOesMe+qZuEuO9g2mymyfuqdYwG8ybTvlHgyKGk7AHosOWYxBNsz+HErNVYl7q@vger.kernel.org
X-Gm-Message-State: AOJu0YyFduVSPgo0Y93VIKMH78epR9730ie/yv5Z6NBBEXs8KTFFa9EA
	ZYMHDQJ5p6jcuF09quJw6Rr7q9p4+5btACXxgv4eanxKkbOTdviaOexJGaKcod3gtvw=
X-Gm-Gg: ASbGncu6oOgn1cQHxZUcotUMjC3KwmDlGMuHbPbLiuwqtgm537QhUcjUUl8yid5gNpF
	bAsC9HEaOzzEZ792rbHEUAM+KS+tOofu0oOLMa7dwJA79eKCdIotKoWK+r3Sm7fjJlWAfZKTLuK
	Rqj3gysj0Rq8YITrhoPA4Mx+D0B9XK8AGzF/sU5d7k5eWQd3pFQTRPtsyDrA8rGzra2m/uBZY6m
	WgilNHp0Typ7HqNIVI8tmXOrOcND8iRBHephiKahx8lKA0TV5u72tI9GTWdD0C7MvVh/2R8J9vb
	59QvWWMstb3GyJ2trnuCNfrTHDp9y+6478Ly6oSnk9ODUue2ELoE/lf5OZCEStJLpO0zgTQu2Tb
	yKNX27ro=
X-Google-Smtp-Source: AGHT+IG9eIe5dClap9KCxt/8jsEpzJHg4xsuwYOTV9E8tYS1KG14U14qxbM4oZ2qYkqz80lDz0BJew==
X-Received: by 2002:a05:6902:2c05:b0:e87:982c:5528 with SMTP id 3f1490d57ef6-e8b6e151739mr662630276.40.1752022842295;
        Tue, 08 Jul 2025 18:00:42 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:235f:99bb:f36e:a060])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e899c43ed8asm3656043276.26.2025.07.08.18.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:00:41 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	akpm@linux-foundation.org,
	corbet@lwn.net,
	bijantabatab@micron.com,
	venkataravis@micron.com,
	emirakhur@micron.com,
	vtavarespetr@micron.com,
	ajayjoshi@micron.com
Subject: [PATCH v4 06/13] Docs/admin-guide/mm/damon/usage: document dests directory
Date: Tue,  8 Jul 2025 19:59:36 -0500
Message-ID: <20250709005952.17776-7-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709005952.17776-1-bijan311@gmail.com>
References: <20250709005952.17776-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: SeongJae Park <sj@kernel.org>

Document the newly added DAMOS action destination directory of the DAMON
sysfs interface on the usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 33 +++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d960aba72b82..fc5c962353ed 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -85,6 +85,8 @@ comma (",").
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`{core_,ops_,}filters <sysfs_filters>`/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
+    │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests
+    │ │ │ │ │ │ │ │ 0/id,weight
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
@@ -307,10 +309,10 @@ to ``N-1``.  Each directory represents each DAMON-based operation scheme.
 schemes/<N>/
 ------------
 
-In each scheme directory, seven directories (``access_pattern``, ``quotas``,
-``watermarks``, ``core_filters``, ``ops_filters``, ``filters``, ``stats``, and
-``tried_regions``) and three files (``action``, ``target_nid`` and
-``apply_interval``) exist.
+In each scheme directory, eight directories (``access_pattern``, ``quotas``,
+``watermarks``, ``core_filters``, ``ops_filters``, ``filters``, ``dests``,
+``stats``, and ``tried_regions``) and three files (``action``, ``target_nid``
+and ``apply_interval``) exist.
 
 The ``action`` file is for setting and getting the scheme's :ref:`action
 <damon_design_damos_action>`.  The keywords that can be written to and read
@@ -484,6 +486,29 @@ Refer to the :ref:`DAMOS filters design documentation
 of different ``allow`` works, when each of the filters are supported, and
 differences on stats.
 
+.. _damon_sysfs_dests:
+
+schemes/<N>/dests/
+------------------
+
+Directory for specifying the destinations of given DAMON-based operation
+scheme's action.  This directory is ignored if the action of the given scheme
+is not supporting multiple destinations.  Only ``DAMOS_MIGRATE_{HOT,COLD}``
+actions are supporting multiple destinations.
+
+In the beginning, the directory has only one file, ``nr_dests``.  Writing a
+number (``N``) to the file creates the number of child directories named ``0``
+to ``N-1``.  Each directory represents each action destination.
+
+Each destination directory contains two files, namely ``id`` and ``weight``.
+Users can write and read the identifier of the destination to ``id`` file.
+For ``DAMOS_MIGRATE_{HOT,COLD}`` actions, the migrate destination node's node
+id should be written to ``id`` file.  Users can write and read the weight of
+the destination among the given destinations to the ``weight`` file.  The
+weight can be an arbitrary integer.  When DAMOS apply the action to each entity
+of the memory region, it will select the destination of the action based on the
+relative weights of the destinations.
+
 .. _sysfs_schemes_stats:
 
 schemes/<N>/stats/
-- 
2.43.0


