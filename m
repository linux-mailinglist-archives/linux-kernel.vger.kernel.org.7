Return-Path: <linux-kernel+bounces-888154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C43C39F4E
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EBD91884FCD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C66F30DD06;
	Thu,  6 Nov 2025 09:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DeHZwXIl"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADAA2DE200
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422950; cv=none; b=mVUT8vjCHh1/WNwn0UN7jHEvq8AaVnxnqO3/OI0UtxogAPz5/RkEdr8vVxE2qT10HW9ViiTV7AbYqQQlHRnDB2bMF1xPl/lylO9+6itufujVYbVor/9EZbQr5vp2RpGqgGmlGbwDtxfLs6w31lGB68vqWB23GZJOM6z84lnk6eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422950; c=relaxed/simple;
	bh=lGb+rCNSnJ/Re9I074l78vjpp6/yu6/7U6mL2e+8rjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JsGfbnZ1nJHX88ko1Zxp7EqSLuwl94leqTXDlk+zUdel/ykSpKCOEXOeA6KClUefE7m0MOYKeE2qpEi62E+xGo+BntpNWju1q7i/IYEzus77sKNGy1QZnsg1aD5cTiNHzazQQGgE417L4a+I+tHLAkPa78QYAgTwjjhkACsB+eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DeHZwXIl; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2953b321f99so8757705ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762422948; x=1763027748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sx3MpVj7PiHTaRtB2+AQXnkYRvNzs0/kE3anQ6IOaeM=;
        b=DeHZwXIlOAQIZ4IYN0+ls86e4UlJ0pQ/AJlt+cSbeVJ7vEAtxKCq7cKJ7GjTgJD9h5
         HKK08f04i+iB8Yj3X58iYIiAnKwOoiS1cWccJlln6STUByWjrmIfYUBMxMbI0rTRHEIS
         BH9P2R/6EePvfMC0AKE1F0saP/KAEkG43owBXowWkLgV/KiqysTUUk926Fg0LUZVmytO
         VWayLjKTxISmBgBjxtajeI62BBHnYXFNETGwv473Nz2wt4cPYPEX/cI/bI0yN936IoCg
         deX5AdMpe5qCDxhl1P+ITLp8FQFh8Epf0c/zcxOEDiTpmeV+uRBzSOd/qbClOtoCE26d
         lMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422948; x=1763027748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sx3MpVj7PiHTaRtB2+AQXnkYRvNzs0/kE3anQ6IOaeM=;
        b=SGxNf9/NenhrK0ENAv4B7N1ddpLnZkv1uOoKAOPbl22gE/54ZgiCDnSsnHiEbA8Z3U
         ePxs31F9mRGw3d6c892xrDOqS4adOvo2y6DL71q1WqY2kceSdKlDep9BhVW+zbpR0Ndj
         5Opg5YSPk75CjpA7zLb1SeiimnZwVQbmF5834AsKIWlXYKGeJRjJ6HaTfUyIHRA0WP+P
         rKFEpePxJe1LbmfBZLxXP4WnI3U0NEkw+cOFKALgAv7U/4e3hfQruez3E1Dz7AmsKTAm
         Qujk/MvHI6XDOpUCXwjWL0s/FGd6MsoKT3uDBAdYHXeB/E/6I+HvV/iyLojV6EQ2P3O+
         JGJQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8BDn6/FgKPeXE/PVCD/DMPlkKeamBRfLsXHkjyw5nzZkEHufb/46N1pdPu3iYGozVprXQ7XbeVRPBmZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrXo1TVtFGBIzBaQmV8d9xMdKvd5S7TOX+3OMJ/hUcwzvsvLnq
	ACmzvceVTMoJKLiZMVcZdEa7zRfKm79hS/kiSOsp+0M5jBgPx7+TM4AN
X-Gm-Gg: ASbGncvhEYX7v/gt8ZnNG4MhcYproapKBRs/huEMFed8dVaHJhMkT9sQnk0B7fviPpY
	Rzv0atWs2q3PK1FfPjjnLSAQQfJEft1kXK86gO945GvkjYhE9WWk7RZ/Qkfy+e5b45PkcCZmhmO
	CfOV0hKnfH+ToLjntWNFAYBsIHyo0wbGjYFjyY2msmxkYQfM6xrRUp646a6BxR2aPcz20WSJDVL
	CLlbzJ6CyGj43C5H7h/7Q28aDw/+sJj1yzzF/1ZTgKxUqMrreZUe5gmXbSg31XxLHZ7Q0TrT7Eb
	XOIgjFMc0n5l4Rs3qgK4YR3KBVCc2BJpHvPgK/9K3us9LRqTIwfZEiuMazRmWNHIbzuS9HMfchw
	1LQi53TFUxfHwh23B6r7SAgsosySobloXF2uzPYUODgOh3jQWDMWVGfwF1cEUxlIBka4UmwSrID
	Y055/8QbYgNWZhIfuiUS4=
X-Google-Smtp-Source: AGHT+IGLWpaeqUyOqwgdTGI+r36lnGa7tydw0O2a7A+GFy9ENF5YsdFbKzmv4BnmJ82XJw5jO5gf6w==
X-Received: by 2002:a17:902:d48c:b0:294:ccc6:ccfd with SMTP id d9443c01a7336-2962ad1bdffmr91436475ad.24.1762422947738;
        Thu, 06 Nov 2025 01:55:47 -0800 (PST)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1eb7sm23046285ad.89.2025.11.06.01.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 01:55:46 -0800 (PST)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>,
	Wei Yang <richard.weiyang@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
Subject: [PATCH v2] selftests/user_events: Fix type cast for write_index packed member in perf_test
Date: Thu,  6 Nov 2025 15:25:32 +0530
Message-ID: <20251106095532.15185-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accessing 'reg.write_index' directly triggers a -Waddress-of-packed-member
warning due to potential unaligned pointer access:

perf_test.c:239:38: warning: taking address of packed member 'write_index'
of class or structure 'user_reg' may result in an unaligned pointer value
[-Waddress-of-packed-member]
  239 |         ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
      |                                             ^~~~~~~~~~~~~~~

Since write(2) works with any alignment. Casting '&reg.write_index'
explicitly to 'void *' to suppress this warning.

Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---
Changelog:
v2:
- typecast '&reg.write_index' to 'void *' & remove use of memcpy as
 suggested by Andrew.

v1: https://lore.kernel.org/linux-kselftest/20251027113439.36059-1-ankitkhushwaha.linux@gmail.com/

---
 tools/testing/selftests/user_events/perf_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/user_events/perf_test.c b/tools/testing/selftests/user_events/perf_test.c
index 201459d8094d..cafec0e52eb3 100644
--- a/tools/testing/selftests/user_events/perf_test.c
+++ b/tools/testing/selftests/user_events/perf_test.c
@@ -236,7 +236,7 @@ TEST_F(user, perf_empty_events) {
 	ASSERT_EQ(1 << reg.enable_bit, self->check);

 	/* Ensure write shows up at correct offset */
-	ASSERT_NE(-1, write(self->data_fd, &reg.write_index,
+	ASSERT_NE(-1, write(self->data_fd, (void *)&reg.write_index,
 						sizeof(reg.write_index)));
 	val = (void *)(((char *)perf_page) + perf_page->data_offset);
 	ASSERT_EQ(PERF_RECORD_SAMPLE, *val);
--
2.51.0


