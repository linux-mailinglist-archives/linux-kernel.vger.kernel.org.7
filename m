Return-Path: <linux-kernel+bounces-785021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 435B3B344D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A918177F06
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:59:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D032FCC1D;
	Mon, 25 Aug 2025 14:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="PDfm7K8N"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA69F2FE58F
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756133882; cv=none; b=C2bvVg36abGgGOfqbIxfUBtqMFkPelae+Be3hCl4FPuAItxoq0JXAyyEUTw7pvde9JSXKR/j58PrEVHhqzY3kJiPaMHOh6jN20FoiMSlMqcZa+Fxu5WOXCr+V6wBYnQ4Itkdt459kSK0uwe1PkFanoofps1Exczw+75Rx0msHrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756133882; c=relaxed/simple;
	bh=Uo8Uq5CGd42i/IUZX2QiGqJ9jwcLrhXXcAVNfr2ZqI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpX76G0U6ab+MjJ/CDIvXFt4tzReCzvY37C0QEyLt/XE3SciVFJXnyVaTdKUYzettzSkBoUs9Wu9ayywDYookKfUt69ZjimTqOehAay8e0Hc9Ycpwn5h8Iw5KeA5VJz7PRN0tCYdobeh0dbNebOo57LzvxC3bnDFIEJMWYOGQsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=PDfm7K8N; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-771f3f89952so120482b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1756133880; x=1756738680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KNNjy6jnCK8i9cBT6PGrQfVqxJIthxv9ctwdRDGY9o=;
        b=PDfm7K8NieFMY50Sdlh/ug169oYnY/9tcoBKJLQCELXJnxgAgqIv09LuNQQfzGnG68
         lsyVpBypgdYeCY0+sb65Ogh35dUZTioX+bCxNSXPwlQ8mjC/gR9q6CtLESyTlDz8Vzpd
         /gMRcjFBteIhH9zCv3z7oqGYKF7gRXXJDcRHg0GdqWo9kZ1IV1W9S1nJikMcEBwvEJZK
         8PerSauEHl2NlBYwgoI1uClSoe0bExrWphQo/Fb5EvPtppNcxOfx87tI4En2m0DRypEo
         rgIcQL2fKuDSzVqkv7UlAo1sDcyPxb80QFd0Ld8AH4BZDCZMZ+bkXi/kpPunwasyhAo1
         wOuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756133880; x=1756738680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KNNjy6jnCK8i9cBT6PGrQfVqxJIthxv9ctwdRDGY9o=;
        b=VVyzeB/uam+hN5mXYtMhWg5HfWXmu4SUUwoay9uXe6pPYX3eOBr09udmYBOE6dof98
         rS3/VDyOpyEGtTBGD68PYpRGKVi8cvJVKk41dPZrAI7cR4PYsnCyBJYZzOE+kJlz+jPR
         w8vsrUMs4JlK5aUoWaJTWbFjTIxcK6A4OwlIQYeem8MArpgG06oZuNQ4U2lRvy0KCOJW
         bdgAEN0neJHJbdlqbK9YegpESdol566bQTEoL+E1ZXalPj10RNthOOnqdJg6dldhHonQ
         Ws/OBLh84fArtVOb79q/maZpLEinFBpfFuxmPPr5rRRsyzuC5a3UlvsIPsX4efaYMCVP
         +Aaw==
X-Gm-Message-State: AOJu0YxUIqDrDTpLVCh311dgwlac6c3A2hixAh1lJd8vgl1eiBAl4crm
	2d7/3sTn48eXcB8ZOJtsjw7if52eTfIZPSG/nKefjmKDHK53JIBkgpgxT+b2XzpMIkg=
X-Gm-Gg: ASbGncuk2UPLNxZclFLyxBlSNVyCE60mCSHDXy/ZJv8EeT6ick8qkGnIsiNM3f9sAqf
	g2uJQwDs7NrCaivKIwKp5eeFDOKVzQwylX5Z//gQpsjGG0tspFqZI/YLdLPQADNFJa1Kd3HZKgk
	9M4H6ylgK9ASe9Zx/EIZAzw8bRez0JSDH8IilfF8B4hWBX4ymXQneFgf6FhifnJUQ7thaoUtY7F
	5SL9qaybLsOYRz+pqwJwar7RRX1/g2WJKSG79qheARaYa+cO6foZFHptZ2Coi3Q57WqJtEPAmVq
	bynMfbmtFdfn8cPp/HCFH87rsaQrlh9uRp84EViBx8dO4bWvHHqcfmLGHdef7ZwqdhKj7Gt5F4Y
	Wcv28Ff2c89tMS64j7WG3K1x2FFx+Nkgnq9aDaIBwYr9IqeWxQ3BLxoaeZ76j
X-Google-Smtp-Source: AGHT+IGbWxmYTsBIeFlK1EvF3uLRm34ATqyatUoKhGCOYfILgtNZGvHj6AvQD4iDtUNoTtKa6iaYsQ==
X-Received: by 2002:a05:6a00:4088:b0:770:4753:b984 with SMTP id d2e1a72fcca58-7704753bbf6mr10848203b3a.16.1756133880306;
        Mon, 25 Aug 2025 07:58:00 -0700 (PDT)
Received: from H3DJ4YJ04F.bytedance.net ([203.208.189.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401b190asm7803436b3a.74.2025.08.25.07.57.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 Aug 2025 07:57:59 -0700 (PDT)
From: Yongting Lin <linyongting@bytedance.com>
To: anthony.yznaga@oracle.com,
	khalid@kernel.org,
	shuah@kernel.org,
	linyongting@bytedance.com
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	akpm@linux-foundation.org,
	linux-mm@kvack.org
Subject: [PATCH 8/8] mshare: selftests: Add test case to demostrate that mshare doesn't support THP
Date: Mon, 25 Aug 2025 22:57:11 +0800
Message-Id: <20250825145719.29455-9-linyongting@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250825145719.29455-1-linyongting@bytedance.com>
References: <20250825145719.29455-1-linyongting@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This case is quit simple by using madvise(MADV_HUGEPAGE), but for verifying
the size of THP memory, we need to setup the memcg and attach test
process to this memcg before perform the test.

Because mshare doesn't support THP feature, the size of THP memory should
be 0 even though we use madivse.

Signed-off-by: Yongting Lin <linyongting@bytedance.com>
---
 tools/testing/selftests/mshare/memory.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/testing/selftests/mshare/memory.c b/tools/testing/selftests/mshare/memory.c
index 7754c0e33506..2a415ce7bc01 100644
--- a/tools/testing/selftests/mshare/memory.c
+++ b/tools/testing/selftests/mshare/memory.c
@@ -68,4 +68,15 @@ TEST_F(memory, swap)
 	ASSERT_GT(swap_size, GB(1) * 9 / 10);
 }
 
+TEST_F(memory, thp)
+{
+	ASSERT_NE(madvise(self->addr, self->allocate_size, MADV_HUGEPAGE), -1);
+	/* touch 1G */
+	memset(self->addr, 0x01, GB(1));
+
+	size_t huge = read_huge_from_cgroup(self->cgroup);
+	/* mshare don't support THP now */
+	ASSERT_EQ(huge, 0);
+}
+
 TEST_HARNESS_MAIN
-- 
2.20.1


