Return-Path: <linux-kernel+bounces-776922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A8EB2D309
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 135785A547E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52A125EFBF;
	Wed, 20 Aug 2025 04:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVg39veb"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E7253B43;
	Wed, 20 Aug 2025 04:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664481; cv=none; b=g1RdYaaxrYCnNDJzHY3M0kV6nPkphAxJCCe0mV6OpNTpHc0TetcdozDyFUjGXuLpu9Bv1Nwvi2Ys+Fq57NdnInKUxNeO346vsQT8ZuCOMsYvXS07VsKoEHjsNMT/gSTp0u8+K+0iGEFf498V4ng5ZKt2vM2FPyfmGXQihMek978=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664481; c=relaxed/simple;
	bh=XPBG+g8op80wWwfXH+4JKxjmC6qZmKE5cKfnLEosge0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpiH7EMOpNX/4JmYxwNoUmE58KaZ9IiP7nN5jFLVLsh/gE2ermkxV2/VCt0QmguAWq1T1P37Ge4ccNNLqiptzlyoRAzN8eagsurqMmYrc7GB4rDQGIgWGxhSDIlddCEP+X2nJmnYByIuzYSzsCzSWylsykhK2TAUGJfBzuwJZbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVg39veb; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-76e1fc69f86so424543b3a.0;
        Tue, 19 Aug 2025 21:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755664479; x=1756269279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5YIgPDQYLfJdyuoeZ22MoAWvyaC+TIoYM7ZDNNZCDs=;
        b=CVg39veb+tmc4jiSl2//nlfklrgx/GMPHlbuEIQgy4lGpE8dZH0L41jmf7eX62jbbw
         4Nvzlnuv/Vnozwc76DIiVJj1LRpV1XOiJVW2+SZ5sUFsqqvXXoT8trcK/fYPntzA57Bv
         4V6nid0PBW8DKLcKaUdnE9NETteYpP4NykPHV7BppRxWIHSP6yZKFAYVKdSQPXzxIK88
         imJjWcGxsixPFxtP0ATycbi0fx3iPRiWhycaTjcpTszQCgo6hR6FJ/xA1LLByImj2MQe
         PkETR2VF8Sv1cZbpCDXaXAZIrGTOgcXB4gAqf8oulV/8lO67s6Fqwur9AdwxpemSdSvy
         kGAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755664479; x=1756269279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5YIgPDQYLfJdyuoeZ22MoAWvyaC+TIoYM7ZDNNZCDs=;
        b=nNodKmTR+XO7Kcj1D0z1wvWHmOaM9lA+ADulUd91hu+g5sgwvRQC1L4omh6od72lh8
         RYNXBRpgGKaKBTkuTvK9oSISavJBcY+1ESw6xFCqyLYXKud/epwrxkXF3EuRuOop2Pmx
         ZxG0235s+lDhvGZXKjTlbW8u2+lHXySQUqr+j/WBafwPuOl32iu+MnrOuZ4q15uUFuEU
         SWtrNhDW1/UhAQ0WqyS1quGyk3btL3Cy3r9B6EoyAtBAs2cHErYp7QWNAMVPOwAozpLM
         0rQRJ0Uy48ZideN7aqb4ejbk19EmaMMlTIng8q5wZq2zqqnPv+R5TpwtkKKN7u3/GI7C
         9TqQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6TIc/QCm0tDcnxkxTarRVQuPMMs3PJxNYLKAYmU1wmw06AHOdH/WLCmnwUfBkWLbiCPWlOu7VWJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz38YCioxcpFP+AlDo+4EmqDs7r31AwgKBF19jAQoR7KdkEqUoH
	MOOcroFpcuwobQuxncmSjmzDGTzTxsMwUiJXv7v7SWlTVxbvJgODw9Ak
X-Gm-Gg: ASbGncttkbWDAqgAGhFbEbk/wZdKkABXGYJBnMEvKSZJ4dFRUqo1/xkf7l1llkUzeOb
	UdTHWxbm03cOA0iFftR08uawsB0I1V/mluFqHLUSeoEO7ETCTU6hEtN5HU1d2L+EmKzXXyoZpLW
	+WuTAFYzC6UNAQJwZEXgCxOt+kXgMbnIR6E48z9PyNE/xzg5prdDto64Pj3h+OxmyhN4S48+O34
	DqqszFH78vl2Yv2t5lGFfoQDv+bjJuYdt1dSGiF0dXL4pKvf9k08kc/SotVppYy49G1wFgtFeIe
	uBRvXooPUTQl2ajc7NOxiMnrbOtHH7KRzPJF0R8j8ECkAegmle7R10QNu2+4gkCSRdyEvVZghqJ
	lS0GwIi5IuT+8+Eo7Nff1pQ==
X-Google-Smtp-Source: AGHT+IFOdokuGgSnF8qKq3daJpFSDdbQS4MDKvGB1Of1XUNNLmsRd7RwZTWRG7pXgbva/VjqyVS3wA==
X-Received: by 2002:a05:6a21:3282:b0:220:1843:3b7b with SMTP id adf61e73a8af0-2431b746b1emr2401182637.4.1755664478823;
        Tue, 19 Aug 2025 21:34:38 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e253b846sm872758a91.12.2025.08.19.21.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 21:34:38 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 54B96411BF98; Wed, 20 Aug 2025 11:34:35 +0700 (WIB)
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
Subject: [PATCH 2/6] Documentation: f2fs: Format compression level subtable
Date: Wed, 20 Aug 2025 11:34:28 +0700
Message-ID: <20250820043432.22509-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820043432.22509-1-bagasdotme@gmail.com>
References: <20250820043432.22509-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1281; i=bagasdotme@gmail.com; h=from:subject; bh=XPBG+g8op80wWwfXH+4JKxjmC6qZmKE5cKfnLEosge0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlL/bexydT9v3HDe32/imzWbrE0nv7ii4yJWScPh4TkX mnYmtLYUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIl4HWJkuKny4/SWM2U6eqky xuf4mB+2tEmYv4uKnGoqwp3yxzqlHKji3bWC6yWMi+ynJGz8uo85+ZPJCpV0j4x0GceNBz6uXME HAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Format compression_algorithm subtable as reST table as it does the
semantic job rather than normal paragraph.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/f2fs.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 203631566a2c58..132c3080ad5c4c 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -291,9 +291,13 @@ compress_algorithm=%s	 Control compress algorithm, currently f2fs supports "lzo"
 			 "lz4", "zstd" and "lzo-rle" algorithm.
 compress_algorithm=%s:%d Control compress algorithm and its compress level, now, only
 			 "lz4" and "zstd" support compress level config.
+
+                         =========      ===========
 			 algorithm	level range
+                         =========      ===========
 			 lz4		3 - 16
 			 zstd		1 - 22
+                         =========      ===========
 compress_log_size=%u	 Support configuring compress cluster size. The size will
 			 be 4KB * (1 << %u). The default and minimum sizes are 16KB.
 compress_extension=%s	 Support adding specified extension, so that f2fs can enable
-- 
An old man doll... just what I always wanted! - Clara


