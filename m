Return-Path: <linux-kernel+bounces-776928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB789B2D310
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6FD7254DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45FB27B342;
	Wed, 20 Aug 2025 04:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAOh8mva"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB452773CD;
	Wed, 20 Aug 2025 04:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664486; cv=none; b=oqx9YL92xO+sQPA0INxnZTJV4mVhPsYJCTfTjvsdeDYkCCzXNIGrdtzE/K8zZ7OcTv5QwG9/TIIlLXm7qPRDBFTbcDTNLTucci8jxWxypDQuqtPHtlCBFRftcWm9NXskXhlG0XZtvgMtwkAB4aVcdburBsnrnetUYEsCCSw9qgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664486; c=relaxed/simple;
	bh=yQk+lQK1CQWqJS13FZep4quP8Zh4Ybk1JXSluoOwpDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooOt5I60R1fDYuzUwwBhtvJvqbSKoyW2Vd4CNYAtWHRfMTreDU6iCQDyPl6NtYsOacUwomQO4lNdDzH5RTwLM4NQcGbTAn38LZm1YhkS1DdYwvFZ83waCk2/jN6GLlGMQmulgNRLwzsHIk87my6unv91KBHEIJy1BBlI4GEZ3jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAOh8mva; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b472fd93ad1so3050612a12.0;
        Tue, 19 Aug 2025 21:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755664484; x=1756269284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r2IA2P+n6dJDRzMxIzjKYVRIxsfdKmslhVEOaLQ+T/Q=;
        b=gAOh8mvaP29AjQj10ypQWOC/iiEtZYsgE5aqddhjcTQsYITdIZ+AfYWw0Uf+FDbN5k
         bIQUFAh69aKKEve21/LQn0V5gbirdaGJbI7+kgV3PNIanHJe7f/wjWk2J9XA5lTqk+rA
         ZBIUCGNC13Hl82oWqJSFV/aiuutufyB0VI1hv65shTFWmycLJe9xVNAwfPmD719Td6OW
         abcCuINkTL3VTK+jknIeIaCg+gftLHnYL2a0l3XVB93BtxWven4/FytD/21pQ2Vip4pN
         TLqM38UnEPKBompTnEkJEhG7n/eR5QQ5jL1W0bsoW7YKXFyi/NN7Kd/D8Mei22JVt852
         9jVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755664484; x=1756269284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r2IA2P+n6dJDRzMxIzjKYVRIxsfdKmslhVEOaLQ+T/Q=;
        b=i0d1AO+H3laWMepuI5y5NXaWDdaUGaGWSCqIqxj4ES1TdrexrhlqaW/4FyVuU8/2JK
         MH56u3nqB2IejXxvdjR3kBEW2/KCEVTB+Wm+HbhPPaKneB9QrIbV8+AA1kjgTJATBmjN
         1ipKMlVZpCmoapVtbUhoc3OeFCELGNg9M4WTHMGQ+7qFlrYDRdzApT9GTXlLQ1KuOS+I
         wYVJNzrKqZB2HneO8e6zpx47ZzJPZwWb90XalVcu71bTH79me9jFG7laKjYw4HwXaSYL
         dYQk9pjgb41oDWYqLCTGbMC7PCxKQSmSaVcUOcGyCPl3cdkAbEQhgIitHOuBTVuEJzb7
         QhuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoCiOxz1Rcm/PITsc52s9mz8bdlDEC4Zv/x+d44zSDdKJyYXKhoYz2NLMnd6yPhwWS2xF5YQ9QCkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+klVbV7JtCIY3KrZ8DTLjOtU4/So3xJi4l9jS7gIqGMc3Lzv4
	xVYcbTVEAetn4j1Djd1kKI7klFmjUSNiS0iEDwQJ0hoXmHOEo7hvXeR5
X-Gm-Gg: ASbGncusDpEoZlnF6WX/MlarKYCFezQAnbJ5gML+qSCkZg5T/t9L0Lw/vW9ClTPoJmn
	CVKzQ/PbFAVRaH6hdymyo4hKt8YwPh1z3DxB/RGY/30saHYcl6/zkqGLwvNLywmEu70HKmmrAfv
	LL1DW7gYImZl+3mcDOIfjCALkPz5o3g6+fwyVt+CsHYLkiirBhVSADmdgwUL7co034XYZkTmWcW
	nsK+q9tlZQzZ9Iz6jcFhP5f9TDoqwpFgvOup4j5d9dKgGY9zIcI9OUKDkQLXVKgDdH/WJp62zFC
	okXwkt1gk08Xzik7jIIAnJz0eH9ysrGAvNaU03BXeBvFhlroCzteKRfpQLDpA7y3ekojN4Yqmgg
	uhZxtgMVKknu/+UhPQqAgXQ==
X-Google-Smtp-Source: AGHT+IFG0K6eJJ/ikjKEya3Hr6JFvroPTkyOpwyDpaD3ZIA3UUuA5xAdu4TqJAiZpI+4uf/BR4ZPCQ==
X-Received: by 2002:a17:902:dac7:b0:243:11e3:a760 with SMTP id d9443c01a7336-245ef14bf85mr15494885ad.16.1755664483956;
        Tue, 19 Aug 2025 21:34:43 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed35abfdsm13342545ad.41.2025.08.19.21.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 21:34:42 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id D87434401D41; Wed, 20 Aug 2025 11:34:35 +0700 (WIB)
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
Subject: [PATCH 6/6] Documentation: f2fs: Reword title
Date: Wed, 20 Aug 2025 11:34:32 +0700
Message-ID: <20250820043432.22509-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820043432.22509-1-bagasdotme@gmail.com>
References: <20250820043432.22509-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1215; i=bagasdotme@gmail.com; h=from:subject; bh=yQk+lQK1CQWqJS13FZep4quP8Zh4Ybk1JXSluoOwpDo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlL/bf1cOctSpnyQUfGsUBlxRuuGQEtwlr2hWfS7hz8s Tbd/dG/jlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEyEv5eRYSnDavfFO+xu57M9 sNTz8TPqZTlWliqw/MNH3uD3gtcvKTMyrDE+l8t34u9LC4tJ50vmr1rZrNUo+2dilU2C+lW175a sXAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

"What is F2FS" is rather a mistitle for the whole f2fs docs, as it
implies the overview section (before "Background and design issues"
section) and the docs covers beyond that: from mount options to
filesystem implementation details.

Retitle and add explicit overview section.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/f2fs.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 146511d63b684e..10504f774e1dff 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -1,8 +1,11 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-==========================================
-WHAT IS Flash-Friendly File System (F2FS)?
-==========================================
+=================================
+Flash-Friendly File System (F2FS)
+=================================
+
+Overview
+========
 
 NAND flash memory-based storage devices, such as SSD, eMMC, and SD cards, have
 been equipped on a variety systems ranging from mobile to server systems. Since
-- 
An old man doll... just what I always wanted! - Clara


