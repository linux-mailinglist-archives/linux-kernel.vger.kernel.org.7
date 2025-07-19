Return-Path: <linux-kernel+bounces-737921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96547B0B1EF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 23:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FFC33BFD55
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 21:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EC7223324;
	Sat, 19 Jul 2025 21:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mjyHakC+"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9175422126D
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752960286; cv=none; b=CZlbpo1QFFeFLxmO8pN5bhfnG0P+8rt/9b9WK3Zn64s3mwDIxld98aJcRuCkRELiQqRFoZjPL/Z2RMiEnCCpyXrE5lsi5bQxfc9zmZn5UebXSQmnURyAxbrNZ7jRxcxO2iKf29p1lkJ7MLEJdabRHD8rnSJBwZ1k2gFLos0oZiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752960286; c=relaxed/simple;
	bh=ZGT5SlOLzHNBsx8YtMr1uAYxyFHk59XYCsK8YGJ6wU8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eoles1r7Y9/LBJ0nIPD+PwpBG3CybJw0WayOOciGW2VXvMwcOaj5sHtNcPFS/aSb7KJuYxhrTNAc+iN1BFGru5E/rfqP8UKQ+1Tj/gvxxXRQ5XI6LCYQJ8gqHUgvnI5qiQvmR+q3a4Jo2Xvdm+YG7t5pKju4jtTP62U3UBX1nEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mjyHakC+; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b3bcb168fd5so2586828a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752960285; x=1753565085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=fvHEZqyePgEIEyaX5O5G731U2NvymlRLg7a4de3vjgI=;
        b=mjyHakC+nD+47cely9MFN4V7cRxR1G+ITvCLu5QHrv/hG2espHAAN2vtLJynBIcdPd
         vfd56xnZ5cKy6kFqVgCXhpxXh1pi6cCRC+qI3/tF8t28HmjHfYIL0mTJQwEwaZaZ03jK
         poVnE4eiDT5aU3Wq2RCcnegt1thHn2nEQe2znnW124xJXI4EB8sWu2YyGOsWbWq6KA6M
         8jijXykWl8YesTS9zwvLH78NsqontF4ZjoqVL4DiT5B2DtbLQ1ilY93tOBtG/RUQP7V+
         /jW6VR/C5kOiS7TZNfyV9aX+DrJI3GYR/mfUBqjX3bNI41AnBbgLKRPAtdXEtx0YHlRG
         W14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752960285; x=1753565085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fvHEZqyePgEIEyaX5O5G731U2NvymlRLg7a4de3vjgI=;
        b=SZe0aA7M2qHynLjif2E4odDHJ2LgIy7hFGIFSNhtQEcKhZ2vAPIXlXALYUUu45/HH6
         oxfni2EvJZCE0/01SkuuPPCVc+NUc80NHu1SrCQ1crvU4SG4Qphiv7aDVAhu26eaAa75
         yO5QgFL9m3ND6OsI33wgbL0bh5OfKmInI5AckAKdTQk9muRLYqauVQs/7idV6ubFJFi6
         l1DakupE5A4yUK10hkWBhdcX4B/j+5pFNSbciMhR4de6Q3GL8ZyhgpSRYkMbqzhW2VFP
         WiDJilSm06VUz4I0gQtO/PBndFDrjUmX20fW1PrLTNzvFYTsXHhLeJIpivVRIq/MaHTV
         yrqA==
X-Forwarded-Encrypted: i=1; AJvYcCU/H+bzrAJz9VVdyK4T1f/w3m6dzmtjcFrIbBovAHqE/mJ5++mDcebFwSoVpRXLWmT9JuOPVgl3/jsNqLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvODgo5GFdGmRrP3o0EEKV8iSoYEjkjeQQKbyObXqkSPkdSOav
	7daAzC64/ubhv5yS4SuoKUG1PrHEw4vC8o6kNclvd+1qhOxXUghHuNhX
X-Gm-Gg: ASbGncuvhMpBLl34IDRxIghea+oJmuxQbG1lYlTGTWq1mt3v3kDPpjJXHAUZIp8R4at
	nWMe7+xhxpmzwCCfTmIHiIC+6UY+mW2bdnN9mzj+cLZi23xIJ3GA8Xdpi8OPFODR/9OtrdNzk09
	JAiSig3brryHwyJw1zs1RGUV0Mj3Ff9WZ2LlbEeSnZNhOc8CBUT+E9nYIw+M9rI5F7C7QtIb0B3
	o8Pu2YEL91NIrr/qHGbVRcwBV1hdf6zO9AHTDm/XWLoTaD1Xq/n9ccXN5kzBJchdKrJoVrkkLj9
	70lA+0tKzNXkQVwknQ7lgcpdYS07sHG0VRJkDmqMonLGlit7z+lSr1JN30sEsbOj9/AVyFGIfQG
	bX4uJnlWKq7puSRrZzdkNng==
X-Google-Smtp-Source: AGHT+IE4ITH/lXRIZHVb6mSTWUAwl4U3YI+cW0FSuQZphGowS1gQYsGdHpkpPmW9tcR3i/aO0RfOMw==
X-Received: by 2002:a17:902:c947:b0:23e:1aba:410e with SMTP id d9443c01a7336-23e25684a2dmr236136155ad.2.1752960284673;
        Sat, 19 Jul 2025 14:24:44 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6f0e56sm32808695ad.200.2025.07.19.14.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 14:24:44 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Yang Yang <yang.yang@vivo.com>,
	Ming Lei <ming.lei@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sbitmap: simplify __sbitmap_for_each_set()
Date: Sat, 19 Jul 2025 17:24:40 -0400
Message-ID: <20250719212441.402681-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

The function opencodes for_each_set_bit_from(). Fix that and drop most
of the housekeeping code.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/sbitmap.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
index 189140bf11fc..90a702a249e6 100644
--- a/include/linux/sbitmap.h
+++ b/include/linux/sbitmap.h
@@ -279,15 +279,9 @@ static inline void __sbitmap_for_each_set(struct sbitmap *sb,
 		 * On all other iterations, nr is zero, so this is a noop.
 		 */
 		depth += nr;
-		while (1) {
-			nr = find_next_bit(&word, depth, nr);
-			if (nr >= depth)
-				break;
+		for_each_set_bit_from(nr, &word, depth)
 			if (!fn(sb, (index << sb->shift) + nr, data))
 				return;
-
-			nr++;
-		}
 next:
 		nr = 0;
 		if (++index >= sb->map_nr)
-- 
2.43.0


