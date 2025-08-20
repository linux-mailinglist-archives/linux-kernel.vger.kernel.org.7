Return-Path: <linux-kernel+bounces-776923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE83B2D314
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48F61BA6350
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E166265CBD;
	Wed, 20 Aug 2025 04:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG4BIS8U"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26572257848;
	Wed, 20 Aug 2025 04:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664481; cv=none; b=lcnID9T9wfWSYHemcpJa5dCr+mLqOJ1vzxAjJsoJ91okB2wxAPA6eRSZ1Xn3yT/QsBA+X25pF8U323+gvNF5/Unr2YQC0mDjTa3boRgX3RqaHQVtHDOUaYoCh1Jz1I0PzqL3xTNuD699s+vZFmSuOFB8stJQtDQp/9rgcLLOyjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664481; c=relaxed/simple;
	bh=u0ScB7oJe040CLbxIigtJvBlv0iClHGKbewou78MoPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B/Xdf5tkMNbUE0wNB9AYxXuC5H2wbda/HF+cHs1NBnM4emAp79PBbig2p6xkOOnTH7srou2fm4RPZufNIb6S/Xo/8s9gSL9QhYCV6UGHO3ijFVpHDoYAs1RWGDL1Lr1XPgjyWTlooDp/ct8x5krAcA8FDeAGJJDTGvUZbZmog7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG4BIS8U; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e7af160f1so1523739b3a.1;
        Tue, 19 Aug 2025 21:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755664479; x=1756269279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ln0od7Z4vv9pu4v2OzT1GPO1Pii9c7VKabfV2KE9JTQ=;
        b=DG4BIS8UCJYQhcRaC115hUb2ySuNsKYEns62UpvnGOIV/2DeXc7eLFd+9zB85WT4cd
         NWGQbw+vdSi1Gsp2QPLSixPXlikbgmxWeK/yFIXDTXYlP6TwdoThAs7KiR+2nD3XFzZb
         ijcjvzVE25Le3DrjxHOE2uTTQyDUPmgBL+1noEKEL8ffAcoNjvysn1mqJQxK6jS6agaf
         FqApi0KxQsnYB8qwvTgWKF3GJZnZ8Zo9POKKVKywkA1qKa/86zjtKD5zLuKNUGvVRQoj
         2+dtfyh7PVO9vjfva59kL8198RuENKUPZwci9oBCYXf39DxRDaAJAthMnDazpnVGKqoF
         /A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755664479; x=1756269279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ln0od7Z4vv9pu4v2OzT1GPO1Pii9c7VKabfV2KE9JTQ=;
        b=t+2VyopYeFeitwwFDD9zm1TMmCvqalEci3hOax1rBC8TXPp0gph2F0qAzDsFRyRNH4
         SRG95+dUXkn2xTGfuzdEkcxE4Ws4WKdhj+AvPBsYcH03aC/QKrZYfXyezuLn3HfxpT4K
         +GNS2L2CXcbQQHEJXqzMr4pBotaUv7+ZxmnZ68w1dUB/jF83mU5ABxYDKmCgo/VsE7bF
         hd2/nE3J/P7jhzbjUHqFGOwTNX9JSdHY6Bcp1LNzRXYvKcqXey6NerkYXwSjHNq98We8
         thyeHAFu9ZNywJoHGQI+lYRgFc9YDBx7/x74Lg09cZJ7BDFAr3d+fT8AP5xFeMO+oIei
         yx5w==
X-Forwarded-Encrypted: i=1; AJvYcCUSpwWkp5E5rPnzARs8LSa3EHong+I9apfyNhUa3hpdEKVyrBglOH/zhcj7MHA1bfSyfte17Vrhh7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBFdM3tpPInfvyjWx9kZFPIZ5XZm5LezHKxfiLId26tZ+gtQ/N
	vTi1/WhLNqv1ymIGIjUEza74dnu/WnoIgnnGJzblNfnQqPrwlKuZtzhF
X-Gm-Gg: ASbGncune7Xn/POioxoa/EdLzhkFdak5iT9ZFuRePHK0/DPEnVF8D4frTCzEcjyxaei
	RHZEjzq5lMQ46cs+u+nnSnMKpGfE/3SP5ZAR9hFlgC5SpkCp/jexj4PQGqAvbmWHbB8RDGyNoXw
	YDDSc32fbMdr2xXAF+8+DbeykOi53EG+HiOWQJOogfTGhE+9XadiQRZJy+zwL/Zflul211hIsOX
	+D6pJXLKkFMXhCpUBwOGhtcxRkF3eLN1A/pmcMBEbIeeL64FnedVdrz8z9vwV0JMD/SyxWP134Y
	zimtLmA56IW+ed21X4+NKKzhIuHp4zHEK2mDgty6gozElIlD6P8aVDD7BH4n1gnIRPJREe9P/0C
	bzf51KuxX0jJ049S0vZq7XA==
X-Google-Smtp-Source: AGHT+IFUrF3nY//FbHCmRJnSjf8PGBS6sQaGnh0boWKFjVAtouYQCTp8sIA3TCct7jxHiBbbS2BbPQ==
X-Received: by 2002:a05:6a20:72a8:b0:220:78b9:f849 with SMTP id adf61e73a8af0-2431b84772cmr2759936637.24.1755664479355;
        Tue, 19 Aug 2025 21:34:39 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e264c470sm857925a91.25.2025.08.19.21.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 21:34:38 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 99FDF436C400; Wed, 20 Aug 2025 11:34:35 +0700 (WIB)
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
Subject: [PATCH 3/6] Documentation: f2fs: Span write hint table section rows
Date: Wed, 20 Aug 2025 11:34:29 +0700
Message-ID: <20250820043432.22509-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820043432.22509-1-bagasdotme@gmail.com>
References: <20250820043432.22509-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; i=bagasdotme@gmail.com; h=from:subject; bh=u0ScB7oJe040CLbxIigtJvBlv0iClHGKbewou78MoPk=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlL/bf16/pGnG/fE1Mh+bX6z5z990Jvaqz0O2F2ZdmOq veHasWOdJSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiXlqMDM/Pz1jXukfId9cn 3vzSh1w7Os7z7LMXuCETknaP2Xfhwf0Mf8XsdM4cvGx/bvWhE/+ulORMa/l0aWXPoV25/Bk9/t4 CG9gB
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Write hint policy table has two rows which act as section rows: buffered
io and direct io, yet these rows are written as normal rows instead.

Column-span them.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/f2fs.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 132c3080ad5c4c..85e015b712c2e1 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -800,11 +800,13 @@ ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
 extension list        "                        "
 
 -- buffered io
+------------------------------------------------------------------
 N/A                   COLD_DATA                WRITE_LIFE_EXTREME
 N/A                   HOT_DATA                 WRITE_LIFE_SHORT
 N/A                   WARM_DATA                WRITE_LIFE_NOT_SET
 
 -- direct io
+------------------------------------------------------------------
 WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
 WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
 WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
-- 
An old man doll... just what I always wanted! - Clara


