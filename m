Return-Path: <linux-kernel+bounces-747183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AABB130C1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 18:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4AE857A30C1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806A421CFE0;
	Sun, 27 Jul 2025 16:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="bJgv4qTb"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D42EADC
	for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753634846; cv=none; b=h73+3kffi/P0H/8t5RiKj9bV0ZlpNVca4HvDVOSv13op1zJmRfscBwHEczgIX1+xLAg9SMvRt+J7W8Fok/ME6ngbOHurYw6AgERpw1WiP5V0KHl2zVCe55A87/qHoenRLMaMkqzwT6lt1GfYBPFQkD43R2f4fdYj4plONZrc1xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753634846; c=relaxed/simple;
	bh=HKybxJbAZ7QkEnEA4dC3PJkGsGcMK5dMhQWxitevWMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jdxbzKVsNORLc4lEyNLPpYeK0168UdLc9vjXq9cYPKgLwo4oObPfiaGtA4Gr+LzvytHt2KZy6ULbQuub1cSUzdvt2RE4Q2TGbO+1kbm7F+DuMTZFJMLX1EHjQb3V2I6rm+lSHrGRcpvt9l7WPaVQpaIfHVwY0NhhjWga2iQqHTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=bJgv4qTb; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-75b5be236deso2964630b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jul 2025 09:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753634845; x=1754239645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+nlZLhgbzNu4yHryVz/Cin3yxvevrJXaOVe2qbhyTGQ=;
        b=bJgv4qTbFFumPxlLpQIvVEWvmeXQs8ZDqwY9TKLco6itXAYh2deyYFwRhz/6VODmuz
         dI1Figfge0QSN2zFi3cIESyBESCJf3AZOjCVS9etxGPuH4VfIfJzNtx6vLdkCe5jJn4C
         jGRYyvs5C1/goNdYtJul9RjBHtjPPHwKUUv7kUmahYcPEdBRAL9duRxi/mElWAMImXzm
         IKEOCU/x3iwDgAYcnfrzArzWV5e+ZXezUy3/fZpc5L/I4hOcL41vPJib2PVbgynFxSj+
         QJg8L6rVIyd9bWprVskQsbqbMs4TCXUjn/QPFv8o4+yRwVNcltFne2udiRJ6S2379cSH
         +N9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753634845; x=1754239645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+nlZLhgbzNu4yHryVz/Cin3yxvevrJXaOVe2qbhyTGQ=;
        b=BTxQQufrvyDs+F7fhUKAgQvYZG6ua64pXCB3AacOyQfeqb18X7Rmd3DxPYwsePMrkb
         KhpuRawp3OUCYTJH37ejgrqvRZjCcmOCupRTk2TZm8KnDUTfXxWKzCZt4XbNsCqqa4Br
         11Pzt1Mj9uIRHU8aSWjL3A5iQUjYivcr5Nn1MsDcTXbYLxGwAxOiEPSYDx1FLHMC+lbN
         Yeg5UydcvSOy50Pw1nQIdobS5C1UJJUN7ePz0lRv5XDrql4X2UrjwBK1pDmEoUqMYYnT
         JpDw6sUWANzpyxjRgExE6H1sXDu/anjnD9QOPX4170s7PkwGdOmZgYQc2ODGsCwQowjE
         BdHw==
X-Forwarded-Encrypted: i=1; AJvYcCWMZRsr6233gV0hNeB3JoJ13uAhwS0Oasq9fentMtzAD/eB7wc5BanVoyTRJKdhdzNHjEr1iQqP2ew3akU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs7Kpt/7TTRlI5gArRce9s7mUT4gJmlXwDkQy8G6AdHL7ADAjH
	nJKDcnZYLwoH2mS+CLyAIcTzSkSIGWb1RORlQ5R50EunBbfjC/fiVDp/LvJg8YFUN6s=
X-Gm-Gg: ASbGncudes56+zDWmLwsq1Jv2Aot5qJAKl1eUZ2NKozrhrMDnmOYy+F4ABbRUYi+O74
	ZZzUn4+CH5DeHlJg9uo9dVoi5BpSQO7y4CG1uZBFzKs7rqX4Bx+xOKHpMLU7UPNaOY7Q2qvrLWp
	5tV2fMRd7KYWhO7nMVyQatuZLyNCkmP85FpNfQd/5vS8v2p06BmgMYx7r3im72yGYqxAo8bRmUU
	HUgcB84pmchCc+LSNgBIFe1ijHE1NAjpM1w9XFn2pgDMJwvn21nCHN5s1NOLHZ7l4EBPw28jg2x
	+nOir6ov9m1eyZsG/K5Se5HlxAWyTk4ipjGxa9eB/i+hIW9Y4sYKfU/tjmEkzx4zk+bN12JWzcH
	63BQKats=
X-Google-Smtp-Source: AGHT+IFpUf9ixp3WbtCQwIdkg8l0/FnIXF3k5K0FTTBfnxUvBgBg78uuQYfEkC1Bz/scBmfJWi1w7g==
X-Received: by 2002:a05:6a00:1395:b0:75f:9622:4ec4 with SMTP id d2e1a72fcca58-76334fac30amr13104977b3a.20.1753634844674;
        Sun, 27 Jul 2025 09:47:24 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.17])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640baa00a9sm3402878b3a.140.2025.07.27.09.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jul 2025 09:47:23 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH v2 3/3] blk-wbt: doc: Update the doc of the wbt_lat_usec interface
Date: Mon, 28 Jul 2025 00:47:09 +0800
Message-Id: <20250727164709.96477-4-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250727164709.96477-1-yizhou.tang@shopee.com>
References: <20250727164709.96477-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

The symbol wb_window_usec cannot be found. Update the doc to reflect the
latest implementation, in other words, the cur_win_nsec member of struct
rq_wb.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 Documentation/ABI/stable/sysfs-block | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 4ba771b56b3b..277d89815edd 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -731,7 +731,7 @@ Contact:	linux-block@vger.kernel.org
 Description:
 		[RW] If the device is registered for writeback throttling, then
 		this file shows the target minimum read latency. If this latency
-		is exceeded in a given window of time (see wb_window_usec), then
+		is exceeded in a given window of time (see cur_win_nsec), then
 		the writeback throttling will start scaling back writes. Writing
 		a value of '0' to this file disables the feature. Writing a
 		value of '-1' to this file resets the value to the default
-- 
2.25.1


