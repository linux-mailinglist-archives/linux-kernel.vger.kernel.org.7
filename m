Return-Path: <linux-kernel+bounces-746118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C785B12356
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 19:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215941892CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C607E2EFDA8;
	Fri, 25 Jul 2025 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQ9O23s6"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C742B48CFC
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 17:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466181; cv=none; b=JPQOSM3hEQ8+frfWaWG3tJRZyEDO9YSzHx8EOIvdLMcf6+OchUOYurHGOo0xVCqb7tGUcxZRIjupKS46wJsXE1n5oRI4tmjKilPmrA+BJGzHyf+wbUENLlH6+oXx+ZRWC6Phs5G5mYFlImZvHJbuLbUqVmc9EWgdYTOLAnk2LOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466181; c=relaxed/simple;
	bh=408MfN68YPxKC4AY4SLbEEDmE8SwRP2WIuikvOrctvY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGgw+beBO3NkeGMuFu3xY6Qd3fq+ygGNi+vx9kOrFFWxOnyVb4X5tb1pBUM2nJBFyA5QtVAfL3YWikmTgM4HFbT1GeUglFynBjXNPbJ1DdGcmFDLWZcstpVk1GXD8/fK6a4tqFVK0EPBFG8yY7XxONn6l5tofZqYYrMxqiUYpHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQ9O23s6; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7086dcab64bso22679957b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753466179; x=1754070979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EL+MWOnu6J0AeWzpNehXJxrYyQIB7n1NGQrL5l8W5j0=;
        b=gQ9O23s6o8/Xk3LT33abtSksEVpyuOS5oTB8/aPE5xl1ym08rkLeQCeUwvYXCemoT3
         4lahf1+cfn5gunnOvw9dIlOhjB6xdL51XjIe+dNGwCIFPbyUtWjWqme96lhPXMKJe/07
         zc0+M+HB7yrsaD1ncXzkBXJEmYyjOaI6lYoIc4r0TyD5uIxNrtgK1Oa9CRJkzPE9wgMf
         /2OwCyXHSikscS87hFg+rqxxnF9NKpcFi1HQJAOt+nARCkh7XWfpgu7a60QHUN2BUDxz
         l43Ua4vC4ebUluNeU8KLDEA+bf8VoqTirZvy8RxUp+Moy6Yn5u9TM1Qd1chUW4eCqDfA
         Y7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753466179; x=1754070979;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EL+MWOnu6J0AeWzpNehXJxrYyQIB7n1NGQrL5l8W5j0=;
        b=YPWWzcZDEXZATTzxxykWydMk1QOjIjWXUDD+N9CbwA8dK8pSCvL1QGUXzxYrXPD9FK
         jZ5z/iMqNAszN2zvFLKLlQ33m3ZF7eCQ453I9+VU6Kb4yJtdXt5HVtQ1exJiTHl5CtGV
         8eBlOgRs0iWSStCo3j2xTE3Kzy2g0Srz/A5BRrdrskkc/fr+jzPudfl9vj/L7u0ZcSN0
         z49LT4kc0h48bRc+5sHEr9zyvQgDAv/Rl8pqok7vlSEyMVoHbbrRBUX7R8wJaYoJWstz
         PnTjHln0rJSAfUnK0ePA56fj3rRJwU5ecjWFxxbLVA4EwZYPjVNnacJLeLHys85QF8iN
         RuVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvmJAYkQ0xtQ0qCkH2NvWJcGVcRgWK1RNgsoh+NCf6k9yaElZUFzX8ogMUPZMBfdFyz03Vd7X5xnYOc10=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSakhfhWzb3fYVZBnE+HvvMaUD8rcXSVq8KQIMkY26mLgndGXI
	2iUmTTPAKOww+LvO1EXK+kuxC8+SQJEEkehseDnVIN6JYotVW8ZqBLj19uWZhA==
X-Gm-Gg: ASbGncveBLZHdBTictV17WBbNED8lt5JwLkxNyP+kbrP4/sHeVPDST5bvfCPhB56ejP
	WbIVkbYv3Ydr3jyr1SQk3vZMxI8/Qk62XU2qlBxyCCQ7DJhNgMT75s3eQuQApihmrEC995jeJuX
	DXw6LlJlBdVQG2uBT72UF976Aw975rDy5jCAabPX+KjAQD5VNGP/kUQfcNkIyGp21wpmDLqNqgr
	/EGGXDEMvC8Pl3hnaCqwpQDCCtSaucg/3gpHC2a7el7JTh9K1+y9bGIQQQmROOaGNZLIRj8FlzV
	9aCwBXn2eohNL7mFaIaVtzGPbOIDHpCQkyUhbfeHZ1IeYR11l8+E33CkMtAvntq4Ld4NDcw+fVB
	uvL8Kvrv+Zdhb+MO4IKNH999HKlxxLeqV
X-Google-Smtp-Source: AGHT+IEoRwVXsNZPqWUO+bMb1H+ndTLEcE9IUQvqFvRrxdUDdtniK0RMG5+DlEeoV2qd/i/01NmnuQ==
X-Received: by 2002:a05:690c:a4da:20b0:719:4cff:16db with SMTP id 00721157ae682-719e342c9f9mr22522357b3.25.1753466178462;
        Fri, 25 Jul 2025 10:56:18 -0700 (PDT)
Received: from localhost ([2a03:2880:25ff:4a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f23ad29esm774787b3.50.2025.07.25.10.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:56:18 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	David Hildenbrand <david@redhat.com>
Cc: Zi Yan <ziy@nvidia.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Gregory Price <gourry@gourry.net>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	kernel-team@meta.com
Subject: [PATCH] MAINTAINERS: Add missing headers to mempory policy & migration section
Date: Fri, 25 Jul 2025 10:56:15 -0700
Message-ID: <20250725175616.2397031-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two files currently do not belong to any section.
The memory policy & migration section seems to be a good home for them!

Signed-off-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a8bebd0886df..dec8db8b5cc7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15838,7 +15838,9 @@ S:	Maintained
 W:	http://www.linux-mm.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
 F:	include/linux/mempolicy.h
+F:	include/uapi/linux/mempolicy.h
 F:	include/linux/migrate.h
+F:	include/linux/migrate_mode.h
 F:	mm/mempolicy.c
 F:	mm/migrate.c
 F:	mm/migrate_device.c

base-commit: 25fae0b93d1d7ddb25958bcb90c3c0e5e0e202bd
-- 
2.47.3

