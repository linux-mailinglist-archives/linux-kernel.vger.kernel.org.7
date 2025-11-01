Return-Path: <linux-kernel+bounces-881200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463C8C27B4B
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 10:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E463B802D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 09:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5258B2D837C;
	Sat,  1 Nov 2025 09:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDnb9KjM"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA7E2D5920
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 09:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761990489; cv=none; b=WfMCMd/GRaEIfVnjtggxeFVQR39TC4XDgmmL4fxLlaRGPA7d5OAdfGHEIN+RxJjHf0Ygd0yduyVUvhFkuoJeUjj1RfmB7EOM48NYrY2Fqq4rpovhDJFiKKU506bKsWHSOK3Ll+Jq5RnCM/redgA+XLMl+r2VMofdfOxRVLjnxlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761990489; c=relaxed/simple;
	bh=scKBOtDHVqKDIQ1wnHzvccmWbCFHaFUh0A9SeEEBF5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+9lBm+IBwZvGkcey0Mt2GBelwSqKSHmrdi8Vch3NBP2+Z5Yib358CvtP9bhGezK6fCmLRpZHRtZJd9nBHxihGHS1DsuuIWDprYk7/SG1ws0OZVNFiUQaKgyabcongo8avBd9jrVUU3hwX2oVDRBmzqrl4kBlpLcRzS/Ine3yMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDnb9KjM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7930132f59aso4434575b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 02:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761990487; x=1762595287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlhKMqWLH6Ttx9Tu79F/62Lvn4ZGhBAbvbXeziFMbEs=;
        b=DDnb9KjM1YHI1mBpiMqrKD0cvFxzifXJvRB6JhZBPbGUy55vUph+n1JP8wYa5hyX1i
         3xxmcblTOENIMF1dgfkRAzShTlerm5liklOiuOCtd3DxO81OaQ8k9mCPk5h+0UsuUL+E
         uIXFDHFiaZI8UY9lcEcALcWVa417dT4ZsIOir/X9ngk0o7GFE7QPljtnWMfAXesS59g9
         ByREjh9uwu8r9Ac2156iO8dqjWyJGQmMwJknXq/L6PrXUR/dyKnLFZPE1flzGiBv8jEY
         P96FmGWUTr9Lofpq0zHLnIeOWxXtCmRVEviwWkw+Ecx5AMklf2Qv3BrXv+aoIh0I9VJe
         PJXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761990487; x=1762595287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlhKMqWLH6Ttx9Tu79F/62Lvn4ZGhBAbvbXeziFMbEs=;
        b=HQvvwk3tB0y62BZdCJxwhArL3tlECJVTZH+SIuzr68M76wSqi4Kt49MWG3pWAISmMa
         NZL9+MP2yMG/BWS5CgEm0h1KiN83HZVTGIc5a6OpN65Fy3GzMyCVc6XF7XSmCe++ugrW
         ZxlMOkPrtBpx4mDaSyFR0Gfm2x3uaikHoLlPYe68LHQosOrOQQEoB9jad6utA5LMzJ7N
         Baks2f2KGv7DANPCpO3vmEMBM6naK5qYY4bVWJZsX8WRoYJA6jcFHDJcnQzBi2zaiUip
         sALQMHuIW1sEJwJzRsDUgrAn+xX9g1XSgRkGP2jk/A6x6bAZv1+V2NfwFz+6PspA7gNK
         NP4A==
X-Gm-Message-State: AOJu0YyZZxMHbReps3V4HNn3tZh+2vroLJuFwqJqDUilnarVzXZhrEPB
	6V2QnxQyv1zcpuaw1N5MxUiDkyAlImbbdsTdEHh5IW1XjrPit/lRnTZv
X-Gm-Gg: ASbGnculyI/bYZ1al4zH2kwCnVh3PjGAgcThsgS8G+TsV5I0PwtOfs+MH6GnLP9b4st
	XvQaxLiEwG5RcmYulPy+aDtqa+VMAj0huQ0W4jiZ5zN7GiZ34pHfhfqcg6fN+wOXbr5Bg7VzoRQ
	W3hkDlQ/VpRHUiwT8OBCgx3Iv8DxE5tinxibgs6eAWEKjFjwPFdLwohzAFWMZF2cLt3oZJOTS4u
	5x2lP/DL6OzbbTpVIOYkUq0DSaQhwK8Aixs8Z6bQewgH54xH2KvwLaorNF9LWOlaaVi1xZR7kbC
	HHEkwy+7cy5q/FxFIbawHT0eTvFEvSFtk+4yOQzE+BPwTry+GiaTGkCzbmMwihLL6Q+zZ2bcM31
	fdIJEV5ivfc6v0E0tkI/F6sBeMkq2WwHmbL8O3Djm2ZixwqiQ/8JjfzD1JDxtXs/ymexr0nHBDB
	+mLvgXXbmTx8Q=
X-Google-Smtp-Source: AGHT+IFkBjadAlRvhWq+7eM46hxZBHaQSQ5gXKI08Y3+aBwkshix92V65FN8ebBWTu8xjYudEyFEDA==
X-Received: by 2002:a05:6a20:3947:b0:2e6:b58a:ddec with SMTP id adf61e73a8af0-348cc2c2872mr9266465637.36.1761990486624;
        Sat, 01 Nov 2025 02:48:06 -0700 (PDT)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93be4f8cccsm4550093a12.30.2025.11.01.02.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 02:48:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id E65EB4218354; Sat, 01 Nov 2025 16:47:56 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next v2 7/8] net: Move XFRM documentation into its own subdirectory
Date: Sat,  1 Nov 2025 16:47:43 +0700
Message-ID: <20251101094744.46932-8-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251101094744.46932-1-bagasdotme@gmail.com>
References: <20251101094744.46932-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3293; i=bagasdotme@gmail.com; h=from:subject; bh=scKBOtDHVqKDIQ1wnHzvccmWbCFHaFUh0A9SeEEBF5o=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJms1/JSknh6zi5oWKbks+j+lfM/Q4/p9Xc7a02LzmNWf iSfv8Suo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABPpyGdkWCBUkaK565PuO8fk s4fP1BtpNEskrn5p0R7kFj3DMHKKM8P/PEZFXSeBhNwzZauOF+Wsl+rdIL/65nz1xfpLP9QYbqv iBQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

XFRM docs are currently reside in Documentation/networking directory,
yet these are distinctive as a group of their own. Move them into xfrm
subdirectory.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/index.rst                  |  5 +----
 Documentation/networking/xfrm/index.rst             | 13 +++++++++++++
 Documentation/networking/{ => xfrm}/xfrm_device.rst |  0
 Documentation/networking/{ => xfrm}/xfrm_proc.rst   |  0
 Documentation/networking/{ => xfrm}/xfrm_sync.rst   |  6 +++---
 Documentation/networking/{ => xfrm}/xfrm_sysctl.rst |  0
 6 files changed, 17 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/networking/xfrm/index.rst
 rename Documentation/networking/{ => xfrm}/xfrm_device.rst (100%)
 rename Documentation/networking/{ => xfrm}/xfrm_proc.rst (100%)
 rename Documentation/networking/{ => xfrm}/xfrm_sync.rst (99%)
 rename Documentation/networking/{ => xfrm}/xfrm_sysctl.rst (100%)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index c775cababc8c17..75db2251649b85 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -131,10 +131,7 @@ Contents:
    vxlan
    x25
    x25-iface
-   xfrm_device
-   xfrm_proc
-   xfrm_sync
-   xfrm_sysctl
+   xfrm/index
    xdp-rx-metadata
    xsk-tx-metadata
 
diff --git a/Documentation/networking/xfrm/index.rst b/Documentation/networking/xfrm/index.rst
new file mode 100644
index 00000000000000..7d866da836fe76
--- /dev/null
+++ b/Documentation/networking/xfrm/index.rst
@@ -0,0 +1,13 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============
+XFRM Framework
+==============
+
+.. toctree::
+   :maxdepth: 2
+
+   xfrm_device
+   xfrm_proc
+   xfrm_sync
+   xfrm_sysctl
diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm/xfrm_device.rst
similarity index 100%
rename from Documentation/networking/xfrm_device.rst
rename to Documentation/networking/xfrm/xfrm_device.rst
diff --git a/Documentation/networking/xfrm_proc.rst b/Documentation/networking/xfrm/xfrm_proc.rst
similarity index 100%
rename from Documentation/networking/xfrm_proc.rst
rename to Documentation/networking/xfrm/xfrm_proc.rst
diff --git a/Documentation/networking/xfrm_sync.rst b/Documentation/networking/xfrm/xfrm_sync.rst
similarity index 99%
rename from Documentation/networking/xfrm_sync.rst
rename to Documentation/networking/xfrm/xfrm_sync.rst
index 112f7c102ad043..dfc2ec0df380c4 100644
--- a/Documentation/networking/xfrm_sync.rst
+++ b/Documentation/networking/xfrm/xfrm_sync.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-====
-XFRM
-====
+=========
+XFRM sync
+=========
 
 The sync patches work is based on initial patches from
 Krisztian <hidden@balabit.hu> and others and additional patches
diff --git a/Documentation/networking/xfrm_sysctl.rst b/Documentation/networking/xfrm/xfrm_sysctl.rst
similarity index 100%
rename from Documentation/networking/xfrm_sysctl.rst
rename to Documentation/networking/xfrm/xfrm_sysctl.rst
-- 
An old man doll... just what I always wanted! - Clara


