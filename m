Return-Path: <linux-kernel+bounces-879498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5893CC23402
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85D284E9B71
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 04:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85014279DA2;
	Fri, 31 Oct 2025 04:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQG4u79t"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632CD28E0F
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761885249; cv=none; b=NgZkv9Tl3Xs+8ULpl0UgiNbOuOP6fgnwVp4ngXQ3xPokklqYtlx0b1Dz1ohQKKTQ7gWxx1/j3uuV+fYyPzX7R3kimyCR/zy0Pn+22nxoZFeaMZn93iRFl81Lt+sXvykeyGul6htz2RbnWjPNftEVx0pXVqIUEzMxtAucyFT5rjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761885249; c=relaxed/simple;
	bh=Bpl9bS/WVMWM/ICcHkLvzN+RyuexkmOEFpCdccFpZHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QLnDlGq2F3tzXRKSKovGo1oNX00SKFYRCNxQk+iUCvTd0EWTwTvDmzysXYSADwBP3qbvLo0gduT/0g237sVxqVKSEPYqqwabsHEOJYLNENK9QMesEAQc5IQM9gyz3OXHqu1eUvly9pmdIkddCDLldV/VhICFXpWL/8715GmI2tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQG4u79t; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a1603a098eso1233196b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 21:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761885246; x=1762490046; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8oE9JQNdIr2S6AC34eXeEphVmop0Si1yVhh0HmwvbZ4=;
        b=PQG4u79t1IpYUUqBfgasP6GYxymdHZceUhH0JkE+u4YBk1MeMPn5gFmmOxm0WvIKGP
         Odn4dLVAAdbcYGJ+fvkUllDJ4bGXP+Ha3AChNgniH6IHIRRl0XhyXmvQ8pMPN5HPtMwj
         Uc1XjnNxFb8/scK9RBCAv6bl6+SS5sq6F5+0jtyDB4wEb2lgT92bguzwPZZdZTzP4VrA
         f3Y+woZ6OfYtydP205aCEL3LOj4WPaeMcxJl3B3j/md6aYi725WOBO7ooJH2wuAOYyvg
         rEqDPYLDgYNHSS2iafzjbLmTfPQDvumpNTOpyeIZ6hRYQUTLFZv/0pzymlOVT13KK7qt
         Vf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761885246; x=1762490046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8oE9JQNdIr2S6AC34eXeEphVmop0Si1yVhh0HmwvbZ4=;
        b=VH3WnqhWNuANLId4ysHJZLvYj7eAdFj922Hwx6bXnNjlN+qQFITPa2nb/vQ8MMNDfv
         qr1PyscSS+xQ7IJl0umLNrHF8ufjHXmK7KEwiJCFtom+lDG1yur9HnNuq8j5TuMd50QF
         vyojUBNS64Jnc+C+ehm1DuUtdGzkoPBjr5xQSIUdbJlhlD7UykBbdKLCCFXqAYQ6zX69
         N9e9o16gdxYG7wo27HFmL/U+FVUX1ouBSx3mTQVhk+AECGVKx6uiKeuOoyiOCSwmOGDg
         Qfm5U6632f66+iyVcgkBQUEoeIxNi4kWd1yfGYTm8Kz0ZskZimKX3FEXJxZcobLRbrZc
         v4+g==
X-Gm-Message-State: AOJu0Yx1Rb/pCmVExVZ1+4ZEUSiuYO0Gf+FrsYVWNRY+osSWoe+e3EAV
	9a/Q54opkZQhd2P/2XDlfDgNDqqdU9D4vOYqvNm0TyzKYJLAmsLZVzqj
X-Gm-Gg: ASbGncvT3w7lmi516vmJfoCgPuyUTfxkGCz7a1LNKmS43Ahi+N5iGLT3IurZcja7Jqt
	FzGX7MY4+N/i09MVeMmYM/urABAymg/m6vpbt2xiI7UMKpu0c+/ClPSeH8wCTiP379eGOmAH7/A
	idturTl2hC/GN3oWAobwQIXF4azgKBwqfFoU1h2BtfYcv+05kqNZTNzhtDf97kjSV1I2XOPqDoq
	Uvnl3gAkCsJINeqYYBqCMBapr4RpVCpDSWjjYyY+dl2fOz7VnS5EnApFlPaB9BhstlXR3DGFfxI
	nc06qLURGNqanIPvAW7Y84jYYVTVAlsZJTkMTEW9reb4Z8kCGoTUeUAQkp+jXETx0AiCTwlQpI0
	ERIxzAGCgrWVhg6FfF1rITZeXwL/rjjgmO8w9XI14F/QI2h7g+iMd2yRcxKPGED2Ttwyftr89qS
	tJN79jyEJoVlc=
X-Google-Smtp-Source: AGHT+IFcwgVexeB6wDVdvipHJTWCcrQS3UvBXAtf/Vakf7r8dXNqGnnrZhcup7mg4kDFjYS+86zxzQ==
X-Received: by 2002:a05:6a00:92a4:b0:7a2:7157:6d95 with SMTP id d2e1a72fcca58-7a777952b44mr2476269b3a.14.1761885246480;
        Thu, 30 Oct 2025 21:34:06 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a7d8d77930sm584989b3a.17.2025.10.30.21.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 21:34:05 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id F026E4209E4A; Fri, 31 Oct 2025 11:34:03 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Alex Shi <alexs@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Dongliang Mu <dzm91@hust.edu.cn>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] Documentation: treewide: Replace marc.info links with lore
Date: Fri, 31 Oct 2025 11:33:56 +0700
Message-ID: <20251031043358.23709-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2729; i=bagasdotme@gmail.com; h=from:subject; bh=Bpl9bS/WVMWM/ICcHkLvzN+RyuexkmOEFpCdccFpZHQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJks1rZT02e6zayOFOtpuJjgkzZHMcOq/a96wr4t7hntb tKXriZ1lLIwiHExyIopskxK5Gs6vctI5EL7WkeYOaxMIEMYuDgFYCLhKYwMb7YIGGWvdzjbN/uF 9OfT+X35U619r/Q23E0VnNz2Z+VCoIrj24vv6qVO/1y9XfPF3amrmCWU5cu/typvCX936UBl/Do OAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the past, people would link to third-party mailing list archives
(like marc.info) for any kernel-related discussions. Now that there
is lore archive under kernel.org infrastructure, replace these marc
links

Note that the only remaining marc link is "Re: Memory mapping on Cirrus
EP9315" [1] since that thread is not available at lore [2].

[1]: https://marc.info/?l=linux-arm-kernel&m=110061245502000&w=2
[2]: https://lore.kernel.org/linux-arm-kernel/?q=b%3A%22Re%3A+Memory+mapping+on+Cirrus+EP9315%22

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/driver-api/usb/writing_musb_glue_layer.rst | 2 +-
 Documentation/mm/active_mm.rst                           | 2 +-
 Documentation/translations/zh_CN/mm/active_mm.rst        | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/driver-api/usb/writing_musb_glue_layer.rst b/Documentation/driver-api/usb/writing_musb_glue_layer.rst
index 0bb96ecdf527b4..b748b9fb1965af 100644
--- a/Documentation/driver-api/usb/writing_musb_glue_layer.rst
+++ b/Documentation/driver-api/usb/writing_musb_glue_layer.rst
@@ -709,7 +709,7 @@ Resources
 
 USB Home Page: https://www.usb.org
 
-linux-usb Mailing List Archives: https://marc.info/?l=linux-usb
+linux-usb Mailing List Archives: https://lore.kernel.org/linux-usb
 
 USB On-the-Go Basics:
 https://www.maximintegrated.com/app-notes/index.mvp/id/1822
diff --git a/Documentation/mm/active_mm.rst b/Documentation/mm/active_mm.rst
index d096fc091e2330..60d819d7d0435a 100644
--- a/Documentation/mm/active_mm.rst
+++ b/Documentation/mm/active_mm.rst
@@ -92,4 +92,4 @@ helpers, which abstract this config option.
  and register state is separate, the alpha PALcode joins the two, and you
  need to switch both together).
 
- (From http://marc.info/?l=linux-kernel&m=93337278602211&w=2)
+ (From https://lore.kernel.org/lkml/Pine.LNX.4.10.9907301410280.752-100000@penguin.transmeta.com/)
diff --git a/Documentation/translations/zh_CN/mm/active_mm.rst b/Documentation/translations/zh_CN/mm/active_mm.rst
index b3352668c4c850..9496a0bb7d0705 100644
--- a/Documentation/translations/zh_CN/mm/active_mm.rst
+++ b/Documentation/translations/zh_CN/mm/active_mm.rst
@@ -87,4 +87,4 @@ Active MM
  最丑陋的之一--不像其他架构的MM和寄存器状态是分开的，alpha的PALcode将两者
  连接起来，你需要同时切换两者）。
 
- (文档来源 http://marc.info/?l=linux-kernel&m=93337278602211&w=2)
+ (文档来源 https://lore.kernel.org/lkml/Pine.LNX.4.10.9907301410280.752-100000@penguin.transmeta.com/)

base-commit: e5e7ca66a7fc6b8073c30a048e1157b88d427980
-- 
An old man doll... just what I always wanted! - Clara


