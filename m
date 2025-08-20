Return-Path: <linux-kernel+bounces-776925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 682C2B2D30D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:35:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A4635A5250
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58972765E8;
	Wed, 20 Aug 2025 04:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0PavBDh"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038A26F28C;
	Wed, 20 Aug 2025 04:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664484; cv=none; b=RKBAW8WAfHVQe6Wc0FYsnSRlSBqGJmKsNmOFiDVWB6xBKtK0UIQHdr/H1F3kgMyF8BwJFxlpwoNraQ4aCsQwcJMF2Hry19yzWt7BDD3oNcxWKidxhNtgmDG4XihyeWOMAXaCiyl67Wycg37Ojbc+4I5VyuiD3ewmSDh+mtfGpSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664484; c=relaxed/simple;
	bh=qm3G9ju8uPlL4X0b7erdGuQwywlcIsY7m9cduvwOOnY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u4Ef2X6+HzdIvo83DXk2+VNi9Xoxach2dqbn7Tf+APGZ2K8z16Ysw7OTQTDCm5Z+d7IIoTSDt3mjJp2uIKd3aDDL/utLFLMterv0tX7Nk9BFW3uGXrPnY//PZIn4ohoHx5MYb7/FoMoYVESJS8c/NqmgXNoeTducGl8PjiMTvl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0PavBDh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2e60433eso4584928b3a.0;
        Tue, 19 Aug 2025 21:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755664482; x=1756269282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CyKlYZwnzyrTJtobVTaGI66bJYC4L/kYAJqhoIFuK3I=;
        b=F0PavBDhSTBtgwiCD8l9azTwf1YFRR1U0Hk1qB1AO9LPILHOEt/Yu7TsyF68YggTyL
         6Uw4VawPVERoWHBjQhTkUeRgdjncTn/ZNs+uQV+JUswYhXHyviU84EQmAsmXpGAA7EsW
         9DF0DMXew90AYoIYTDlKYY+l4wio0jV0Fd4UlRISXM3SovQC7dmyELQDBnXf5wIb+j/O
         cWetkcLt3AuNMV5/O32eAZY1ciKZRMF/M9T2tUk5yXiCboyjs/xUWisBX8PjtOJcGFa+
         SEupJMlG4nEMTypghU4LvakhlBqpqnx+KvuBt9SUWhgJH3EaLLCHzV2YsDCpZCpq57NH
         PBTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755664482; x=1756269282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CyKlYZwnzyrTJtobVTaGI66bJYC4L/kYAJqhoIFuK3I=;
        b=JVOShIDd9/ph1vQ51Jla2yWJxgXHA8+H0ctwEy63lfsFT+z0k/y+czu4sFYjxRmOUT
         Z9kLMntb8myOCUZgtix/5Kxg+tDhInATiTUz6yRXl6CrAgkCj9FVWAhw6bJ/lblEcpYU
         ZX5yUzx71C1klcJXBDAkhMf6Xfh76UxF3tFa070z3hWgoCsoCULFN9U73abw3+SC4XSN
         h1X3zy+8NivFZf3E8p2B1T9kycCXcgZ4ouytm4XaMqH/fpOsSC/e3Xg6qS0EsLHpMZws
         kb7nUiVDLU/M2/G7AL0GA9qwDdIsi0xdxV0/7ZVDhgNryYNQ3xVF8pnVk0a2r/WIQSgM
         TiyA==
X-Forwarded-Encrypted: i=1; AJvYcCU/cPcc0PkQoCCPPNuTENb9yHswVla1ndp/WCFwBq+Yu4oDZnXV+2R1FlJZrbsIugEZbpbvaPOE6Vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/8TD8/SJDtZ/X0IeuKON305SknwCp9y+iWP+zuzJeo+B0GYO
	Tt0FFuIhpxO7nR01uAGYnbLOpjJZdNj7u7ZFwW6gV2gG1gVRN76qF+7V
X-Gm-Gg: ASbGnctP3WLyi+K0bkrGtY8VNBfDCo7V8Dipo1NRnabJuROq4qu29p3oEqqOSxKM2jj
	wK5WX4Ne99Mk8PYbd3TF8Lqt68CyH19HedLWUiwTgq8K95HSydplUzoxgwIP6brkXbzx9/xzSdX
	qqzGuNayJ1Bo/Q0hS1HwXBlMVSqq47kfEsGKJSFbvkhkMoL8RiBEy6XUlwA26E0AJj9d1PlgtKg
	LvhFlfxBTQrVuNMKBClyytDwSdWc2Rwc0IocBqRTeVnAsYGu+qVylCmpcaJWlRhbANIrDjgk0ZC
	GBSvgONeOX1ZK4vslrw4LE9izSCF1Xjz2dVENZh50glxiEi/vyD26Np6/fe7Q1GElzRsOcPUUY+
	frQDtKEsRqQkxIjyx2AH9XA==
X-Google-Smtp-Source: AGHT+IFoO+aW2FNquc4nftkyJudwML7Au6CjGFNuS72S7hftyJIUJSX6dF3jYDiBLuVRPRWnryJwNg==
X-Received: by 2002:a05:6a00:85a9:b0:74d:f997:1b45 with SMTP id d2e1a72fcca58-76e8dc80626mr2056170b3a.8.1755664481907;
        Tue, 19 Aug 2025 21:34:41 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d4f77fdsm3979674b3a.66.2025.08.19.21.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 21:34:39 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 2030442DCF34; Wed, 20 Aug 2025 11:34:34 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux F2FS <linux-f2fs-devel@lists.sourceforge.net>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Daeho Jeong <daehojeong@google.com>,
	Yuanye Ma <yuanye.ma20@gmail.com>,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 1/6] Documentation: f2fs: Separate errors mode subtable
Date: Wed, 20 Aug 2025 11:34:27 +0700
Message-ID: <20250820043432.22509-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820043432.22509-1-bagasdotme@gmail.com>
References: <20250820043432.22509-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1071; i=bagasdotme@gmail.com; h=from:subject; bh=qm3G9ju8uPlL4X0b7erdGuQwywlcIsY7m9cduvwOOnY=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlL/bdNjZkbP+W9nk2ud9G+gKONF/hk/jiU1G8r233+Y NfCyJW5HaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZiIiiAjwzfuH1r6p2vYXq8x nLO2pECm1+5L6PbruamX9kjfmCIz/S8jw2t154CHGjOtDv1b+XTRZ8bkRVVnGR+rqeq8aHBYu1z jOhMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

errors=%s subtable is shown in htmldocs output as long-running paragraph
instead due to missing separator from its previous paragraph. Add it.

Fixes: b62e71be2110 ("f2fs: support errors=remount-ro|continue|panic mountoption")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/f2fs.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index e5bb89452aff29..203631566a2c58 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -357,6 +357,7 @@ errors=%s		 Specify f2fs behavior on critical errors. This supports modes:
 			 panic immediately, continue without doing anything, and remount
 			 the partition in read-only mode. By default it uses "continue"
 			 mode.
+
 			 ====================== =============== =============== ========
 			 mode			continue	remount-ro	panic
 			 ====================== =============== =============== ========
-- 
An old man doll... just what I always wanted! - Clara


