Return-Path: <linux-kernel+bounces-737910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74168B0B1DA
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 22:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29B451886FC5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 20:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB4523AB8F;
	Sat, 19 Jul 2025 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EOM3vEsM"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A66C23185D
	for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 20:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752958450; cv=none; b=kdWsPlDEp2AFamL6bQJqoSpG2VP1xd1nGOA6Nu40s+6Bmo73Yqcxzsl105ofEBpvrZ0xZxpkHOYeNta5J1Pdvtzdb7WVI77CxehrW4CFkT6hKB+if9LBzWSou6rJwJ27F06phwmpBHOEK96fjXb2vet/0yurg40yh82JmB61OKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752958450; c=relaxed/simple;
	bh=B934+Kc9/xezFy/Zn2zNjwBZazAlWZ7vR4aoJdUJbqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SE0vTXFyBFFSEvRmHBanMc89cHhrAcWaIIhoB0B9ep/ZPaP6UPUJI/V6v5xoMHUeUGMWi6iIZiphz+Xl9bM9x8ctr3vABsnekrunymTP6Q96k8QsD2N9Nvs7pyhN8LUoma2IFwxx0ax1zjdGrg4EldyGZwWVXtZb3IWimt8Jq4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EOM3vEsM; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-74924255af4so2801698b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jul 2025 13:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752958448; x=1753563248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOCDl5cthZmrU0Qd7NvIGZp3DnnEjIDPfQc2akvrlJ0=;
        b=EOM3vEsMy+nnV1UrrIhAZ1J3ktkPGc4uxsiIHEX1jw8UuZrJp6Ey9WCwHqGiSPgIV7
         zZqKG9/cYz0TKKskDXG+iTci47j8wAKC0qe1x/PUf7+W1T2yfO9OOnMNlCN7rdzn5ZrM
         bsQsvP1j1jHOPJJhg8gpZyf/uLcbmzyLf1YUfyVlLhiAVWjkcI7I7+xAax0yH1JkBeij
         JRcJ2EhDsv0jE7jiromnMCprjx/l+0LSi1KohDQawmuusqIdVLwGmDofHtzz3C0FQUzF
         qjOa+C3G25xrGzeH1FmYfm8ZrPc4nP8WHSM5imsUTzL8iRKAnKH4iWepMzCaJTBntW6r
         70Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752958448; x=1753563248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOCDl5cthZmrU0Qd7NvIGZp3DnnEjIDPfQc2akvrlJ0=;
        b=enUDzkUf/qnzq8mEwLsUFpILCCWRvsIlkwoLA5RBQAJu2ky6ejCBXDpyWIanWkJ1ua
         hsV/GLG5ruMnXR0c3+95czGfe2xo82Gfk4Dy9skXGrvNtOxHyZQP1LIRESRIcps4AuB8
         hASjCEQY209Vryrdo39jaquGPvdZqUU5RHmwRA9nJEZtuMFSAR21GBGVFqXFwkqJWA5r
         gSBIe298+39XHJO6KfZeKvr+S+Ac8iXCga+l45IIihzy0Khq7Ipby8vokXF7OrMs/tnn
         78qZ8GnRPUz2UMi1VH1kenVcTV+V7y1aWDImJx+W7hsReiXzu57/eN3dQiGEpCsuGp1z
         ibwg==
X-Forwarded-Encrypted: i=1; AJvYcCXydvm6mv6eKAOw1j2Wb5MorYrAyU9qUvT+BxDJJX8hlKxsykaMQDougOxQJ5YPGUKuQyZiPE+hireUKtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNg/ntn1utf2RjvEdivC0QHU93UUBFCWJ7j9/hmLCNGUvG0o2N
	M/nB+pBJLbeiNqv9uoym6+vIgbaSTtG3yd3uUahPxuzdYF4dVfbCII9K4ZYwJg==
X-Gm-Gg: ASbGncsCeMcN9OLBuMWNVUIzQqyhWN3VjJpEUnHgckveoXqKz+zpKn03iZSDY5z9Wcf
	nORnFn2J9WNrBJdRIwr3NlyS2dfkeN/sV/VVvLNvYq91qca0fg4U4LyZyzuOgCfjxT29hjQy4W2
	Fl66hh4JZqL02MlFQFF/CSmcJaIcYVmSicvZHlgEXSxzXtfpaxGL7t+QzrsldIIMjDJ0jn7ZeWz
	fyHaqTDavkm+rvg4DlmTMQ5ztcjVl0MD1duiWzq3j6ZnrJBz1bkwLupgsmG0x97O6hzvVFSz/yX
	Q52LluoPvgP9PGHPJO9GIFWm45LOKAJ4u3Qion5qhz/QlAoRAOmqbT0QO0RCIn6XgiH+xHJ8RYr
	89MaJknb5pGjgDNrd3AfiLQ==
X-Google-Smtp-Source: AGHT+IHDiz/vYnyFSdoqCw3qpOYzf4maRKdY/f/q8f9TnmbYYrrDXgxOf+5i4gNbyS3vpFHbwnroSQ==
X-Received: by 2002:a05:6a00:2d11:b0:756:a033:596e with SMTP id d2e1a72fcca58-75725a8a001mr18653300b3a.22.1752958448227;
        Sat, 19 Jul 2025 13:54:08 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb1546a6sm3249106b3a.92.2025.07.19.13.54.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 13:54:07 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 1/2] mm: cma: simplify cma_debug_show_areas()
Date: Sat, 19 Jul 2025 16:53:59 -0400
Message-ID: <20250719205401.399475-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250719205401.399475-1-yury.norov@gmail.com>
References: <20250719205401.399475-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

The function opencodes for_each_clear_bitrange(). Fix that and drop most
of housekeeping code.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 mm/cma.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/mm/cma.c b/mm/cma.c
index 397567883a10..adc57bf7c68c 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -739,8 +739,7 @@ static int __init __cma_declare_contiguous_nid(phys_addr_t *basep,
 
 static void cma_debug_show_areas(struct cma *cma)
 {
-	unsigned long next_zero_bit, next_set_bit, nr_zero;
-	unsigned long start;
+	unsigned long start, end;
 	unsigned long nr_part;
 	unsigned long nbits;
 	int r;
@@ -751,22 +750,12 @@ static void cma_debug_show_areas(struct cma *cma)
 	for (r = 0; r < cma->nranges; r++) {
 		cmr = &cma->ranges[r];
 
-		start = 0;
 		nbits = cma_bitmap_maxno(cma, cmr);
 
 		pr_info("range %d: ", r);
-		for (;;) {
-			next_zero_bit = find_next_zero_bit(cmr->bitmap,
-							   nbits, start);
-			if (next_zero_bit >= nbits)
-				break;
-			next_set_bit = find_next_bit(cmr->bitmap, nbits,
-						     next_zero_bit);
-			nr_zero = next_set_bit - next_zero_bit;
-			nr_part = nr_zero << cma->order_per_bit;
-			pr_cont("%s%lu@%lu", start ? "+" : "", nr_part,
-				next_zero_bit);
-			start = next_zero_bit + nr_zero;
+		for_each_clear_bitrange(start, end, cmr->bitmap, nbits) {
+			nr_part = (end - start) << cma->order_per_bit;
+			pr_cont("%s%lu@%lu", start ? "+" : "", nr_part, start);
 		}
 		pr_info("\n");
 	}
-- 
2.43.0


