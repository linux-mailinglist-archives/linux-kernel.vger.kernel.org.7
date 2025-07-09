Return-Path: <linux-kernel+bounces-723203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 883B7AFE470
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98B117B5E1B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7832728A1D4;
	Wed,  9 Jul 2025 09:38:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862CB289E3A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 09:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053911; cv=none; b=Ua+pzhBX4S41PAultEw3CSfEQicGC6c/n+iKqhACy1EK3REt9T+md0M67UEuiCjkP9Wa3A7tAxRnBa6/zxlUz/7ij52HqIlaKY/1e0N7/BCE26tXnE7+mqEJRB2JcXWS9O4y9Wzh94KJjE97bYYElurHUN84IloqYE2duS1cD7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053911; c=relaxed/simple;
	bh=Db9e+iXLe/WttAm6uqRxgVXYTlbnGiDEOFfbnzWYtmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hFBUyvs493iB0EW7SdTNggfW/p/bW4gnk20ZrqyEkTSRhnhwPRH3AJy/sJ+5A256kKbTs3Hg8sukk6VdD66xap0spfKaVJyftcGuwpEjUJzseHC322osjVvlOMIKYjqMyub9qB4kpMoqG1Jv3M1KvVGzFMFXqqn8xcDn0EmubrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 62BCC153B;
	Wed,  9 Jul 2025 02:38:17 -0700 (PDT)
Received: from e134344.cambridge.arm.com (e134344.arm.com [10.1.196.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 067563F738;
	Wed,  9 Jul 2025 02:38:26 -0700 (PDT)
From: Ben Horgan <ben.horgan@arm.com>
To: catalin.marinas@arm.com,
	will@kernel.org,
	maz@kernel.org,
	oliver.upton@linux.dev,
	joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	yury.norov@gmail.com,
	linux@rasmusvillemoes.dk,
	linux-kernel@vger.kernel.org
Cc: james.morse@arm.com,
	Ben Horgan <ben.horgan@arm.com>
Subject: [PATCH v2 2/2] bitfield: Ensure the return values of helper functions are checked
Date: Wed,  9 Jul 2025 10:38:08 +0100
Message-ID: <20250709093808.920284-3-ben.horgan@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709093808.920284-1-ben.horgan@arm.com>
References: <20250709093808.920284-1-ben.horgan@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As type##_replace_bits() has no side effects it is only useful if its
return value is checked. Add __must_check to enforce this usage. To have
the bits replaced in-place typep##_replace_bits() can be used instead.

Although, type_##_get_bits() and type_##_encode_bits() are harder to misuse
they are still only useful if the return value is checked. For
consistency, also add __must_check to these.

Signed-off-by: Ben Horgan <ben.horgan@arm.com>
---
 include/linux/bitfield.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bitfield.h b/include/linux/bitfield.h
index 6d9a53db54b6..5355f8f806a9 100644
--- a/include/linux/bitfield.h
+++ b/include/linux/bitfield.h
@@ -189,14 +189,14 @@ static __always_inline u64 field_mask(u64 field)
 }
 #define field_max(field)	((typeof(field))field_mask(field))
 #define ____MAKE_OP(type,base,to,from)					\
-static __always_inline __##type type##_encode_bits(base v, base field)	\
+static __always_inline __##type __must_check type##_encode_bits(base v, base field)	\
 {									\
 	if (__builtin_constant_p(v) && (v & ~field_mask(field)))	\
 		__field_overflow();					\
 	return to((v & field_mask(field)) * field_multiplier(field));	\
 }									\
-static __always_inline __##type type##_replace_bits(__##type old,	\
-					base val, base field)		\
+static __always_inline __##type __must_check type##_replace_bits(__##type old,	\
+							base val, base field)	\
 {									\
 	return (old & ~to(field)) | type##_encode_bits(val, field);	\
 }									\
@@ -205,7 +205,7 @@ static __always_inline void type##p_replace_bits(__##type *p,		\
 {									\
 	*p = (*p & ~to(field)) | type##_encode_bits(val, field);	\
 }									\
-static __always_inline base type##_get_bits(__##type v, base field)	\
+static __always_inline base __must_check type##_get_bits(__##type v, base field)	\
 {									\
 	return (from(v) & field)/field_multiplier(field);		\
 }
-- 
2.43.0


