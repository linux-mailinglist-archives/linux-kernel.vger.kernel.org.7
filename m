Return-Path: <linux-kernel+bounces-770411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C67DB27A6D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21F7D5C1154
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 07:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794002C325D;
	Fri, 15 Aug 2025 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3TicxVS"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627452BDC09;
	Fri, 15 Aug 2025 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755244608; cv=none; b=aDRiD9UI2uSlJuTNnEj7OxAYzM9P5siFxi1XGnxeD17s22/F2iQCNYLpYzwoZxL3jq2ZRc5UC0POzopFT+c3rh3KbWcnA+svulw54+xTGDrSZoV0Hf+qEILPuvJiL9aeqZ64RnegGm7YUVZ4JM5h4bqVi/rUW/Xb2c2oAIQgL0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755244608; c=relaxed/simple;
	bh=BSdi2w3mGBfqx7vQ62yyAGKSjWZXG1QSCbm15ZVydcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqmUZR1e+0dhv7hG8W+ExJauS/TbQducVKViYfSQfnndFd07bgRpeSyHFbZdoVBX2rF9c9IEltbT8AX7QS40YIfKbjG5tIgOObSV2TLtQ+XvaTtSxYz2U8gA141u5opXn1fdgZ2UEGlP+Dky8PyLmRIvx6QSL1vFhdnVsqtat2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e3TicxVS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2e614b84so1826594b3a.0;
        Fri, 15 Aug 2025 00:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755244606; x=1755849406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SqBwk/eT0E+fNoZp9YX9tGh8FiPKp3ALbCTa/kbWN8=;
        b=e3TicxVSX7l2Brq0uuZj1xw8FeDIwxSZZjwRtq72jdiEpjHyBc0a3JSie8ORzUI/bu
         zkYx8/6ia+5Vau/KhVHWMWSIJIdxQ0fAcxaK2junhk+4/EvMi2rjr2GOeoPRq2oF/tFf
         9eQXVcqVZmr1Ra+ABsjm3JuljmMJpUzEq/QEo5d8OD0p1YhnThaqveYYAzQ/ZI1pAK8h
         NNB9AUZCUB+mxYrll5sI+KyUhCplVv8fhuXt0a2QdLCdY2f49t27VcSID+pyz+Lwad+6
         xmLtgmF9P+lk2gGDt/DrRX2sHyU/GakE9heKpeoz3TWNZyz/2pi/2glZgBtYV1w9TPoy
         WMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755244606; x=1755849406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4SqBwk/eT0E+fNoZp9YX9tGh8FiPKp3ALbCTa/kbWN8=;
        b=FUBLxuIkLWvHuiJ73Cpn8D5fc4MzMnG0EzZT2wfgKoUClXpZa++MJILBGXMZF0AE80
         /Tn919f6SqYAcQcoB+9r/kzKpbWM9O9bMaL66hJpTzDvRBDCvR40hf2ThhQ92qwO6b3f
         L9tJO64mI4issqhSwjsuBXVsPHgmnzWFcQb+0vbOxBKhPfE2u7aZxyeH/2rZQ3M+KGI2
         lknAfE0maZ07lWPYdApb8OSE/U9Qm+y42KM+hBAhBeimISBgYA0S1id6LKfvo81iQmnz
         JSFT7+4i819/jqkwoQMBjIyGOR7vpc0CWF53QIFTrtjNwBagKjHjL6+A4LCByZ1/YOhe
         nLIA==
X-Forwarded-Encrypted: i=1; AJvYcCWLXtmX4D6GFT8GDvWHENYTt41KajDiklNubx1gU22JQOGZJXRXAuvupYoOh1jZpVbad5Pf+TmsbXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YydCUFUBuvCTz28OO0xZlhHR4I7ku5GCFFjpeByNNz6tIUgdnWE
	kjYGTXwvZ6o06PMpDM6247s48tIGEEkGDWTKu3tdcXYwjZdS8BXN6fdc
X-Gm-Gg: ASbGnct6uFSmMwJNL+WXUepmwtrIhVEeIpmqXWAN86vKaA6/3ONuJ4P29Df+4YjCwdr
	HACblrsQHz6vhl025ihZewTpCSfUowgA1ct/g+FwKW3c2dFMdDLmc1utJhVHpPhTwg/q2bXdu10
	eTvqfMBt91vKdDgaQQAx83d3oqz2k4bhtXez3fj/HUDWL56n4wtOiCzBIGePKy2Q3I3kg4KfpNr
	KhmWegFmEXYwlaF3P52PdSaBz62g5chuQY6gyXLgVap2s+9m9chXbagX3xhpBHTkTi3h/Zf7X4t
	DRho9mUTh+LN80mKe4jNeI0YNl8YWQMEErfmDnUcxc5CU4xsq+JaVoSIns3Yc3LcXNydZ1DydUE
	sIZp6p2mG13LyLqQewGAJgQ==
X-Google-Smtp-Source: AGHT+IF9ucjW/KtwwO3q2uYVf9EFn3Mg/zyi7hUeanmOPhSmnzBBOZt2Q3XjmVtqygSPlYAgPovRow==
X-Received: by 2002:a17:902:d488:b0:234:a139:11fb with SMTP id d9443c01a7336-2446d8b1f78mr16115555ad.27.1755244606499;
        Fri, 15 Aug 2025 00:56:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d54f8b9sm8483715ad.130.2025.08.15.00.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 00:56:45 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 3A2C142D95C7; Fri, 15 Aug 2025 14:56:41 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Device Mapper <dm-devel@lists.linux.dev>
Cc: Dongsheng Yang <dongsheng.yang@linux.dev>,
	Zheng Gu <cengku@gmail.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 2/3] dm-pcache: Use bullet list for data_crc constructor argument
Date: Fri, 15 Aug 2025 14:56:15 +0700
Message-ID: <20250815075622.23953-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815075622.23953-2-bagasdotme@gmail.com>
References: <20250815075622.23953-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1798; i=bagasdotme@gmail.com; h=from:subject; bh=BSdi2w3mGBfqx7vQ62yyAGKSjWZXG1QSCbm15ZVydcE=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnznq+fdHNXPKfJo/Se5TdDNSUC+2WSz+Q9dHljJ3fI2 t1r67ajHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjID0FGhs4d39cL3bu/wzi4 Rtt8jb25+P0ktTNhU/1spt44sqC+7yQjwye7tXwp126sCzNKE+rjfPnGNjSFc8K6u2rXVz/M87/ 5jgEA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sphinx reports indentation warnings on data_crc argument description:

Documentation/admin-guide/device-mapper/dm-pcache.rst:44: ERROR: Unexpected indentation. [docutils]
Documentation/admin-guide/device-mapper/dm-pcache.rst:46: WARNING: Block quote ends without a blank line; unexpected unindent. [docutils]

Fix the warning by using proper bullet list syntax.

Fixes: 6fb8fbbaf147 ("dm-pcache: add persistent cache target in device-mapper")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/linux-next/20250815131115.45518c74@canb.auug.org.au/
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/admin-guide/device-mapper/dm-pcache.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/device-mapper/dm-pcache.rst b/Documentation/admin-guide/device-mapper/dm-pcache.rst
index ecd015be798243..02cea738ae131b 100644
--- a/Documentation/admin-guide/device-mapper/dm-pcache.rst
+++ b/Documentation/admin-guide/device-mapper/dm-pcache.rst
@@ -40,9 +40,10 @@ Constructor
 ``cache_mode``              Optional, Only ``writeback`` is accepted at the moment.
 
 ``data_crc``                Optional, default to ``false``
-                            ``true``  – store CRC32 for every cached entry and
-                                      verify on reads
-                            ``false`` – skip CRC (faster)
+
+                            * ``true``  – store CRC32 for every cached entry and
+                              verify on reads
+                            * ``false`` – skip CRC (faster)
 =========================  ====================================================
 
 Example
-- 
An old man doll... just what I always wanted! - Clara


