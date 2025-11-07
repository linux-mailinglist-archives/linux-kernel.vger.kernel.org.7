Return-Path: <linux-kernel+bounces-890778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD18C40E95
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 17:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F177418840B2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 16:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C989C3321BD;
	Fri,  7 Nov 2025 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OmKJto0l"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B533321A7
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 16:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762533786; cv=none; b=bd28HxJTmhb/nGBVrNKRAHpjgl27sPmLPiNjMbUm+CLWEYMZgp8KgkHd2j8BwJmN+5wUi2vJ/2kU+4oICxy8Jx1uanDa0FENjxYQsJeweLmMnuaVqkHSow5jL9xmfiNSARRsz4AAHQgqSjMvnzQaB5jtRAGHDIR7iyFo0+/6A8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762533786; c=relaxed/simple;
	bh=x1aBY8u88X0nutnqASK2cYZrDArpC2SWwtkeHNj5ygs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tXrceAlZitV100CfNvPNHZw6Gdmw3ENFsjf4ZEta0RYvEA41UbLDHtOTojrvlGMj9sbmf2u6oTH7rhEwEdb4stLdI8/RU9p3lR4caPqeD5AIfoCbR7m0ADg5YMcUF3G8tsRQ2cUaUD3Gxpt/pMNW/3oIpGM3FY2b+RggC0VnmcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OmKJto0l; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b2c8fb84fso2095f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 08:43:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762533783; x=1763138583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=on8bewL1RI4N4l+sU7wrnJnMvJdHM/hSBq36uJM+rEs=;
        b=OmKJto0lOHCfjcwkBDnzhUGq5DpLuhAFhYJBraOhyEsuar8mOXRUW9W90rRPaVT3ms
         q7pRmxZFnH9t25pn6K/khLNd4yVnl9Zk8nPrMmMUYCLuH6XbjPlIgRKTM5oMMRe+NYqr
         YUCxTI9njzWBMMi2lHgZjWzXDCdIK1VsQYP1GGW6JEYAjzPKD5y1uhYSgYkB2Of8+8G4
         nhnt7RV2qrQqcjZKAeih8FBP40JaUfn/kU2eyqxWeChhKfCQKt+bbVNAM1Wa2QYwOygT
         j7BEnEER9u4A6/XIROTUVd6q8MWIpbSODwGRX3IeEEvrualaUk1NMrztIq9EiC6KImTH
         EbRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762533783; x=1763138583;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=on8bewL1RI4N4l+sU7wrnJnMvJdHM/hSBq36uJM+rEs=;
        b=gKGDmg/INppWH7Z2j/BhhQ3dKKB50eNBIXGKEZ9XDc5kJmopUFQ32ysJ3gU9kNE3FP
         YC8dQB3ls9gpXE7/ibw6EQOsw0zdV8jjCxRHA8km+Q4fVNmeozTYSuLUO65Jx6PhWfyA
         nq3Pf75RbLNoMz+7AGIuNxr6W3+c4UN/ZpTG0XvLr/m0rScGW/jSWwuSECYjqSTdif97
         K03nDWDAB4jxHoRbgk/FbBrYBPQ4SyFYEwyiynGKhDkOV12aOQs0B61qPR1FtDANNFXh
         t0lKIl5Mkbrmoxo2E2YLEG/7S5aqUEPkItfUQp/cFE27dhektkZtXIrj5KdUv1ZaT69T
         yxUw==
X-Gm-Message-State: AOJu0YzMqeVSfLNn46n5fJBG38De+6fzyW0IbltShE8b9YLGshiC8LiR
	IVBtxHX02nH9I7KhDE4vp6gSujk7k9oSQhxd+NjbcgPkH15JQ8N6K+wxZPpmQrTLim4//x02no4
	dsOmIo0YbGqvjIaSZ2IEHglAAAMyW9+8Hl7bKuKvX+fhFyoD4TUVedFQvRjTUZW7uvyI19kWP8m
	AUGeXP58V/9L8lyowQXFMe+cmqkEdW8OBQsA==
X-Google-Smtp-Source: AGHT+IErWQ/bAs6sgLKAGNRJ/4CQ20iQCILHo6B+nhBcFHGoZnZeYmzcBl/waJrrk8dDdmr4ZnLdN3g5
X-Received: from wrzd3.prod.google.com ([2002:a5d:6dc3:0:b0:428:4fa9:ac7d])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:25c7:b0:426:d60f:746f
 with SMTP id ffacd0b85a97d-42ae5ac329dmr3140724f8f.30.1762533782550; Fri, 07
 Nov 2025 08:43:02 -0800 (PST)
Date: Fri,  7 Nov 2025 17:42:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688; i=ardb@kernel.org;
 h=from:subject; bh=fwiBdr2UguIhUnvRRI7uFyScWi3GAhl3ehVZMRQfNi8=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIZNPsfETS8sT+bOnqzxSTleu8262DO08KLiGPZ7zEpuqR
 7BbP39HKQuDGBeDrJgii8Dsv+92np4oVes8SxZmDisTyBAGLk4BmMgVVoZ/qkd7Dn76GcJq1qrt
 +mN7veu1Dxn/uqTmP7376OzXF98PNjH8L3QIvnNR8eVcj1u3Clb/+Kx5addtUe/GiMOC95nOxq/ dzwAA
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251107164240.2023366-2-ardb+git@google.com>
Subject: [PATCH] drm/i195: Fix format string truncation warning
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Ard Biesheuvel <ardb@kernel.org>

GCC notices that the 16-byte uabi_name field could theoretically be too
small for the formatted string if the instance number exceeds 100.

Given that there are apparently ABI concerns here, this is the minimal
fix that shuts up the compiler without changing the output or the
maximum length for existing values < 100.

drivers/gpu/drm/i915/intel_memory_region.c: In function =E2=80=98intel_memo=
ry_region_create=E2=80=99:
drivers/gpu/drm/i915/intel_memory_region.c:273:61: error: =E2=80=98%u=E2=80=
=99 directive output may be truncated writing between 1 and 5 bytes into a =
region of size between 3 and 11 [-Werror=3Dformat-truncation=3D]
  273 |         snprintf(mem->uabi_name, sizeof(mem->uabi_name), "%s%u",
      |                                                             ^~
drivers/gpu/drm/i915/intel_memory_region.c:273:58: note: directive argument=
 in the range [0, 65535]
  273 |         snprintf(mem->uabi_name, sizeof(mem->uabi_name), "%s%u",
      |                                                          ^~~~~~
drivers/gpu/drm/i915/intel_memory_region.c:273:9: note: =E2=80=98snprintf=
=E2=80=99 output between 7 and 19 bytes into a destination of size 16
  273 |         snprintf(mem->uabi_name, sizeof(mem->uabi_name), "%s%u",
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  274 |                  intel_memory_type_str(type), instance);
      |                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org

This is unlikely to be the right fix, but sending a wrong patch is
usually a better way to elicit a response than just sending a bug
report.

 drivers/gpu/drm/i915/intel_memory_region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/intel_memory_region.c b/drivers/gpu/drm/i=
915/intel_memory_region.c
index 59bd603e6deb..ad4afcf0c58a 100644
--- a/drivers/gpu/drm/i915/intel_memory_region.c
+++ b/drivers/gpu/drm/i915/intel_memory_region.c
@@ -271,7 +271,7 @@ intel_memory_region_create(struct drm_i915_private *i91=
5,
 	mem->instance =3D instance;
=20
 	snprintf(mem->uabi_name, sizeof(mem->uabi_name), "%s%u",
-		 intel_memory_type_str(type), instance);
+		 intel_memory_type_str(type), instance % 100);
=20
 	mutex_init(&mem->objects.lock);
 	INIT_LIST_HEAD(&mem->objects.list);
--=20
2.51.2.1041.gc1ab5b90ca-goog


