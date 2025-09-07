Return-Path: <linux-kernel+bounces-804872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0720CB48124
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 00:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDCFF7A67D4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 22:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D08A22F77E;
	Sun,  7 Sep 2025 22:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="FEiDSTdy"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A720C25771
	for <linux-kernel@vger.kernel.org>; Sun,  7 Sep 2025 22:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757285781; cv=none; b=ATdfxOu0tC/BLTSAC6lPwlxNF4RAgKuuvDdiU1RP9HAkOqY+g5CaqJucslbQzQEp7JEBQUyrCSgU+VMK8+SxcRxdAYFI8grQ1R6LvOlx16bf62YGFbT+rNZOAL1pcj2TXXRY4mWjb8o4+Utj1wfe6U0RlqKZ88jzrEsg3SjL15Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757285781; c=relaxed/simple;
	bh=GB+1VfLtC92aDniK+990GlvDuxXg1deL2mSEfmUWB+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cq15mIE3GjHp8HLvymrw5boMh4cI9C3P+ct6rOx8uJySFiegBU78y43mnfKT6VEs217XXCeypSjguBmfEHogiiqpHGzBAVn6U+5OLh9NZ2vHPu3toBuLB7HsMr/xyPC607X8gP3CwQQKdAkLurdmW7Ui0/rlAg9qNkgbVgG9j0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=FEiDSTdy; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1757285766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y7re/zauySqiwyOR8u6YI3w1cTP+2u72fIYTne+bgRA=;
	b=FEiDSTdycNNHJdBii3q4CrGMEkMCriMKC+5HbqXctK1bHvpgxB7nwyeZdmfb4gHeALrNq8
	HgOsxCpxju/PtFjpaOUi4jNsz5EitlooV67J87frbmq/VNCQSfZgKbQlc1DbWIY0JXZaci
	Wv3zYp7xbpDil3JodO5xXUTreQ8Tjv4JOgVQIsissBKpECe4EyQS/PJy0xBPVGicLRiMY0
	P5z6z4YTNpwwcpnjM69D3wv4XaJWOs41W1bU3eTal4NksPpVaPHxIB0+03uUS0KMS0CAMv
	uJ3+MtQVaC+XyySnQ0D8tEGQndnWaq+9kheYoVRyCdDP1gC8VOZ8FItyXURLOg==
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Date: Sun, 07 Sep 2025 18:56:00 -0400
Subject: [PATCH] MAINTAINERS: remove Alyssa Rosenzweig
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250907-kernel-retirement-v1-1-e6f4b2eadb88@rosenzweig.io>
X-B4-Tracking: v=1; b=H4sIAH8NvmgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSwNz3ezUorzUHN2i1JLMotTc1LwS3TRDwyRLS0MzQxNjUyWgvoKi1LT
 MCrCZ0bG1tQDVVOVQYwAAAA==
X-Change-ID: 20250907-kernel-retirement-f11b99161435
To: linux-kernel@vger.kernel.org, asahi@lists.linux.dev, sven@kernel.org, 
 j@jannau.net, maz@kernel.org
Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
X-Migadu-Flow: FLOW_OUT

I'm moving on to other projects [1] and no longer wish to be copied on
kernel patches. Remove my MAINTAINERS entries: both related to Apple
driver support. So long and thanks for all the fish.

[1] https://rosenzweig.io/blog/asahi-gpu-part-n.html

Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
---
 MAINTAINERS | 2 --
 1 file changed, 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd7ff55b5d321752ac44c91d2d7e74de28e08960..3c10a189421c9d20247ad1546ba4af31556c87cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1845,7 +1845,6 @@ S:	Odd fixes
 F:	drivers/input/mouse/bcm5974.c
 
 APPLE PCIE CONTROLLER DRIVER
-M:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
 M:	Marc Zyngier <maz@kernel.org>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
@@ -2364,7 +2363,6 @@ F:	sound/soc/codecs/ssm3515.c
 ARM/APPLE MACHINE SUPPORT
 M:	Sven Peter <sven@kernel.org>
 M:	Janne Grunau <j@jannau.net>
-R:	Alyssa Rosenzweig <alyssa@rosenzweig.io>
 R:	Neal Gompa <neal@gompa.dev>
 L:	asahi@lists.linux.dev
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)

---
base-commit: 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c
change-id: 20250907-kernel-retirement-f11b99161435

Best regards,
-- 
Alyssa Rosenzweig <alyssa@rosenzweig.io>


