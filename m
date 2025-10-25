Return-Path: <linux-kernel+bounces-870062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA603C09C7A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 18:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE4C425F80
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCFE317709;
	Sat, 25 Oct 2025 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6bMcV1N"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982BE306D57
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761410478; cv=none; b=NsgSoBrj6RJXESlSari30aYQaNwucefKKTtTXulDpeLEewAPVyQnbm69go0RVfQ49mlDdvxUGp1xh50Xi6sHV2+yAUVjxaWfQNPOmKGQBlmaSKrJBsF3rmK1iidlL0JgLeXXxb/KcIc9U+2m98mQfPGNAvyM4PqqHqZRpxeaGuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761410478; c=relaxed/simple;
	bh=1bcynx9xewGI6dVd6TNDYQ5HTZ9qbz+hT47nRzvSCxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sEiWxlpJo34NXeJBLVUgGKSCp9H8p2Hk68YCtLjQ1JdPwsD5txnyKH72GFHGxbWck8u1GQwSmbFG5r68MuATQHLuLx5CdrA3fKsChubqZ6Yw0kNGcSbY7ghG7HqVsm0KUF3Cr66D014wvuSernXC5CE4lJKtx40E4zrowdNbDzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6bMcV1N; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-88f2b29b651so335075685a.0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 09:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761410475; x=1762015275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GldqH8fEtUrzkHne1rF5BgiofNp7hGD1Vw1w37mqgw=;
        b=d6bMcV1NyxUvtSagw/2W53yzNS7fNBEJl5S4XnCxW5cbGbSThZ56pYuTXHP66y272E
         Z+hi61y/D5eB6nzkCtYq9KwUoiU54foQdVdk1h0MfqKolhgZSHsD9BNO458QUn16+Whc
         sr568QI0H+8rqxjKzCw0UaTpn0YLEWgY8S8HzQT5u3Ah5234+ymvx89/89UbQ22Wvryx
         KNChdmR0N4IekiPV5uWl8wI6TP3KIIxNx2PGB54MoFOMPhJ9eCJlFMxdmSsJ0rc3Sb+e
         K/WJV00fNI4WyFDXSjEceLJnK/Ym/FrTAHwcscWaE+SgJYvbMycVj56zVKyKSlUFbpih
         dEfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761410475; x=1762015275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GldqH8fEtUrzkHne1rF5BgiofNp7hGD1Vw1w37mqgw=;
        b=qbqElnm0fHFlAWzJRkoeWxOje93jiX0KGYDoHRDnITSsuEzqsb/d+0wIBsoUGvIpbn
         RJpQogC86f+i8HsBEgcN8ZEqSAhysjAkCE1S0uUi9snL6Y5hs4uy6tnVS6NIuwiExyXb
         d4HepLd+sGajelZU+y0LMT9mDkozvzqbEJo8Bam0nkWedQON2tjNTbO43XegQOj+akwV
         RFCQsksNy/YQRIYvDqd2YkwcUHIiESNcuRyxuMG0LY05H/ngZXjOeJzB1Z/V8ZNDJDh3
         DSLr3oHAyxzAX3vGppzfH7NwsOIP5bVRxy4Goof6l6I+i/w+t/8Y7Skw/70vR6vuh1gw
         PG1g==
X-Forwarded-Encrypted: i=1; AJvYcCURCSuRICsSEjcco6hXF7hPrpDEJDWU2qd+qsVPB+ZhYkD41IXW78F2RO9RYgOQh7ZRF5GWpV9w/Z2Ib0g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGsN1BOFbmmiQdEBNTbnizd35rIv57+tuXuzNX5A+4wrEfNe7X
	1efsAjclRJK1DrrjmY4DpZdyZGPcWn7h/Oh9WVGLSfgePDimkxEC00QvqYPbkA==
X-Gm-Gg: ASbGnctKKhH7AxSbxaG1/b09GD9+p3No0nInU3GAbSUZaqyx2OOIVS8hs+Okvo4MJDy
	i9+ttqjsPMIQjS+bOpUYx1yR9YDn4kZ37LcjHREjw/dfvGWe86mki7VGe3sMv66cNH3NgVXOsaE
	deNvaZZcjy6wSCo/R4ODMe1m1ugGd7qL9Lt0/uQNKsAVx47oNO4NrEDbUVI+M8b3WNHkpTts7sI
	PlMgxeN4ZvD6hJNOirhxdUyzFhGA2QCCXfwg6408U0X17Q0sq2C/NEKtNebmsYAhPf8aygTt552
	lB1iXrUEo+Uu9SklBkdKKctESPvbPatE6F9asuSnzOSWy2JHh1kTo8PudaetF20RI0WtLNZBFsm
	YWLtPYSuJO1ySroZUJT4+MM1wEbEp2VPxx9ClzKRN0/ESYPP/0RP89wJY7nQhl9iI/kH9NHIUdX
	Ua3sVJrfw=
X-Google-Smtp-Source: AGHT+IGJ5EoIFI83t52hIGo3M/2FHLwpmX4KGwa2Lw/NwuS3C1UYigsffJIqRTq4YJBeHeKmK7LHUw==
X-Received: by 2002:a05:620a:1a0b:b0:88e:991e:cf2a with SMTP id af79cd13be357-89c11e631cemr1286912085a.44.1761410475508;
        Sat, 25 Oct 2025 09:41:15 -0700 (PDT)
Received: from localhost ([12.22.141.131])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f24cd5938sm173525585a.20.2025.10.25.09.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 09:41:14 -0700 (PDT)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 17/21] mm: don't use GENMASK()
Date: Sat, 25 Oct 2025 12:40:16 -0400
Message-ID: <20251025164023.308884-18-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251025164023.308884-1-yury.norov@gmail.com>
References: <20251025164023.308884-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(high, low) notation is confusing. FIRST_BITS() is more
appropriate.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 mm/debug_vm_pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 830107b6dd08..b722dc3c091b 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -40,7 +40,7 @@
  * expectations that are being validated here. All future changes in here
  * or the documentation need to be in sync.
  */
-#define RANDOM_NZVALUE	GENMASK(7, 0)
+#define RANDOM_NZVALUE	FIRST_BITS(8)
 
 struct pgtable_debug_args {
 	struct mm_struct	*mm;
-- 
2.43.0


