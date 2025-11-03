Return-Path: <linux-kernel+bounces-883579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11D9C2DCB5
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 20:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B38C42023B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 19:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D335331DDB9;
	Mon,  3 Nov 2025 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLqUElTj"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98544296BA7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196687; cv=none; b=iMTAhivQNIAwrsmZPlt35tOnvSW/N6FzU/6TXQYHZOj55k+rWC/B3rI3XWECCKhlBDjsfKw0Z7hpBOLyAB35NfzP8BTaYfimtdPFUIf5kqJe8dxXVl1xiJwncQhnTTjOC0Gy0JndSERG2IJqb+5SCMmUwxFL9+ibK9RyNUdLy5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196687; c=relaxed/simple;
	bh=eBx6eNYJpGqcVLhC0pGnTGwcOmUv7nKxHVe00eFrT4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R16VbxSF82PByl/wLBtXeyK2i6heH70t5IelBN4KEolSN6FWiARIjUxm1J4v/alyU+gRifvdw/pnL1C30kGmeblTuE2bCw+sd6tsRiXgHpUEyw6Gxt+kdvPTfzE7+lNM8DURhFyuHCL/y5eSj/FyaB/H+uL5A6q4MMQN4jZ+xFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TLqUElTj; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4711b95226dso61380205e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 11:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196684; x=1762801484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMHLkj+gI0nwETQtcp9VFdw3HslxFYJiK9T9Rphw84Y=;
        b=TLqUElTjoS/RJxJ5f11QacN6KNm2nl5LgpEyU+mrBW3KGIYYcsVXnFEA27rO2c0i1V
         wao7enuJinTJgha+u6ivxYgbUaOxe/vA+2jQo2dC0hFxAAu6/Jx/j+jLGZ0J4Ca4TOa2
         9FXog/muNFA7Dz1QmlIrnhev8KVhSUWSGEfCFzEWQJxWes6vHi/nVGuR49Muew7+D7V5
         wA+g4pFbC6vnPnpnsIYFAiBzU9v2MJOgJRKTXln4904xDkVytHeISSvgHN+ya2J/uGaV
         EV4qXbUg7n/YWepf6ItqbdeLGa4id4SW8pUDG/bj6Q45WuidK4U5wIegI/8BdTTzH294
         Znmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196684; x=1762801484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cMHLkj+gI0nwETQtcp9VFdw3HslxFYJiK9T9Rphw84Y=;
        b=uBD68GYnIBEMQt+andE+bm75hlvsJ+GrePZF9sjiHmGo15z9/eQDl5bOvVcjgxPK3M
         0VlUVQR4eu68FkqWWtUfh/Nf2Jk3YNnV8kPpCR7Ed3BLSCE3OcuvTnfymrt2Kf3ki491
         bjxCPMvZ403G0U5aY1v96v1ctAMTU1oSXYzxJQyKqL0096r2K3UH2UOZxyq0FjcumMgN
         +h4mJusmh3bpanWZzuDkjYmnrRIQXiDOKjY/zPEEXpdTcV27q5tDfY5Zc9VZURP2KxOF
         F6SLUxoudy1bz7/39sIa26GAKwjfUDNf+JjJENNNORUguOfhtW/tyXxwPCp45XzmYwLk
         eoUA==
X-Gm-Message-State: AOJu0YzxD9mqvLlN1V7qtkxxr4nSX2h7miugw8mqYPbV0kPYGD6ZUNaw
	2osI7uRXeqBH8/vxqW8aXYV7M6zDHk/6J5bniDIjNbwKgP/XFp+kmmJ2cU2Fj0NV
X-Gm-Gg: ASbGncvzm6nOPiimcR/3Q9D77YUFAzhiuqf98vygEsVHJ+zt5DQiOv9RNLDldSHhS6W
	Ir6kPUaDEUkvRfP5N9FSvUSijNlMJ/kZT/wGJeYBiGQBoYNIFFv4JgLdBwst1o7gOvvHKrXdyEY
	GiVVJ4Dvs4hvzO3vuHKUqeBoWCQxZ3YEGOcIjaOQe/ZoiEWDQSZ1pIqZ0yG0EFyigLbm67VMHfK
	RD3FIwdqsT1kVVFlq2TVVpyvFTghzmdQo4xpEelvRXaNBx4A25XJ6d2g9wZQXTASJiLn6Grg01Z
	yLjLouSdDHu3h+4t81ebWbuUOob18Dy8YDP5uhimQV6k/aEzKypzO1ldS6fv7t75mlR8QkObDy+
	zJjTU7QeDbiBToLWtehhiiGcpumG98XpgPIYzahi9x3L97/Wsxj8lPzKiDilr4hQhe6YJkgHBNR
	OXNMFgFVnKndMWeFQT0LmzIIwpcj7wLNBuhGw92HJovOVkRKpQ+WrtJr5ZM06WFQ==
X-Google-Smtp-Source: AGHT+IFz0pIUFvJwFuBYW+x/ZsgwBHHSe03OIKbGEouVkS7xyooy0cXJf8nLP1dMjToJSUJvDFolaQ==
X-Received: by 2002:a05:6000:2088:b0:425:769e:515a with SMTP id ffacd0b85a97d-429bd6a795bmr12203265f8f.42.1762196683544;
        Mon, 03 Nov 2025 11:04:43 -0800 (PST)
Received: from fedora (cpc92878-cmbg18-2-0-cust539.5-4.cable.virginm.net. [86.16.54.28])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-429dc192ac4sm327407f8f.17.2025.11.03.11.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 11:04:42 -0800 (PST)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	"Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: [RFC PATCH v2 3/4] mm/vmalloc: cleanup large_gfp in vm_area_alloc_pages()
Date: Mon,  3 Nov 2025 11:04:28 -0800
Message-ID: <20251103190429.104747-4-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103190429.104747-1-vishal.moola@gmail.com>
References: <20251103190429.104747-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we have already checked for unsupported flags, we can use the
helper function to set the necessary gfp flags for the large order
allocation optimization.

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/vmalloc.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 38d94c0c8153..ced77fc65ce3 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3634,10 +3634,8 @@ vm_area_alloc_pages(gfp_t gfp, int nid,
 	unsigned int max_attempt_order = MAX_PAGE_ORDER;
 	struct page *page;
 	int i;
-	gfp_t large_gfp = (gfp &
-		~(__GFP_DIRECT_RECLAIM | __GFP_NOFAIL | __GFP_COMP))
-		| __GFP_NOWARN;
 	unsigned int large_order = ilog2(nr_remaining);
+	gfp_t large_gfp = vmalloc_gfp_adjust(gfp, large_order) & ~__GFP_DIRECT_RECLAIM;
 
 	large_order = min(max_attempt_order, large_order);
 
-- 
2.51.1


