Return-Path: <linux-kernel+bounces-745382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BB3B11928
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 09:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA4FC1CE1C58
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 07:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1773D2BD03F;
	Fri, 25 Jul 2025 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MrTxadTg"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7AFBE65
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 07:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753428459; cv=none; b=oWqWBj8+Zd2Y+2zDKe2YrtFKeehtl5dhEDL0NMRKynbRIiQkC+2XjQ4ln/IeqyAx8IyMRiDyjgpc47AMmDiYevy7o+1hI1gyhhU2OiyULT28fkZ4z7IPhQO2gfsb//9UD0LYdv9IGhsAW8MrOq+FX/H8+rIOPus9q5CePBzMt6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753428459; c=relaxed/simple;
	bh=2IRuVumcOkylwNTGiCeEwonCb0/fTs0gjF0k1DIxrzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k/NiZA/Qvee+qlkJ4YlD9VkFRvLybyPgLbfwAD+bEk7xrTjozN53va5pilPdzd0Uk56tIa1nmGlVh0x2J2WCB5CDk1obsAZDy5fN83Ik9HoPxJi3E7SodrEcnEvzqkUwxS/C8yK/0pUi1EPYhFDaht3SyuAYYUkIqQqs9pS+Kyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MrTxadTg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4550709f2c1so14463005e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 00:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753428456; x=1754033256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6QL8IFabAlNq2YUnjd0j76KbVt8/qh8cFRe9/l7opeg=;
        b=MrTxadTgCdyiZ+/1IGR7SKaf/i4BdFh4SwM4HeB5FthoY4paQZjwHd8eoZpD/Iistw
         74xvUySMfmHNun+r2URK36s2lQy+0LYUpicFYPPvBqZPLfwyzci/bXkzUZMgCH8M4Z3x
         3ehIRqviPf52jqlZMJTaoTRVoGu7TpA1W6x8AIN5smzvugvO9nNjpouH88dVCNS1DdsQ
         XCfGLVi6VnOw+TtoRF+LSthRGhemsiZgB/yGAlLDSow8WmuRY50n0fzjMCkKJTa0uWl2
         tO8dF+yyGWb9z1xleNO1jQSyDSw3L4eZgTNx4guuaqVG3p7TlXjbHwrNGjYxG8qkyN/k
         63jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753428456; x=1754033256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6QL8IFabAlNq2YUnjd0j76KbVt8/qh8cFRe9/l7opeg=;
        b=XJcH6EJUa9gT34Na+AIa7Py/NC0CwUv3MF7HxNwzKJFmbw27Tk/fUPORJ4hpYsYD2i
         GITOrBlGBvlDl9tUJ327pc/nwSCP/ZVvOfUzVBwfP9+t/8GWSfcek3iRVHuBPvu9R6ZF
         3PIz9nXTm0jBYXDAgMX61MV7xFZDCXiFIiJjNyWZ2i0Uawc5C4jm5TcQNCwJne+Nbdgn
         WPB97bp4OqMA0BCffToDu9Bx8frKuS7yr13+EJrhQ/uhAL41Io4yp4h580R6pZWzluly
         qhfsA2BL+wutFk0Cj7WqmVp9cs6THIIRP/eN3anyweyOd4ZiLRANdg3BzJwrpS4++6U/
         oZog==
X-Forwarded-Encrypted: i=1; AJvYcCWTQK4Pz0Io2bszb0oqlhT68kLgRZNKCgw4MLl8j8uEQugxu/osqy5tpAyf/qidnys9uo4TtY289DtcUdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1rZw0REYiZfisXNDQlbkwJ9xXrP+t77XzHevBHtNDZ43mPwiC
	u4KALrHocgNuwqlIJDRhEwjkUKvnV6Ap7bt2oVdGpyhjsl6BCzZYWVPB
X-Gm-Gg: ASbGncvikGEgH8uqJ+lpv6G3xGbN/sEBM0qrpEepsx7ZGgqn4zOHNmxo6wUMnbFdGoN
	qMoIxUrR1CJ/jaKk6EPX9vBhUqhw/nalsH+DKTBRJUxJlcK9c0Cjqjp+UWd4QwOI28HcdDPpMkO
	AYDP9KdMmyb2W2tbOBeOkI2HFGsBm0nTGgnayZnlC6zuUEf4l69NqxhCY4ge/9qwtzVAGpWNwcF
	cpV+bi9IfIm2IlO4sfG1M5EqmBHas324JW388cgwNfuw+mO+WFEs//Y38Q17MxgohMA2e6bFmwj
	8M+FuklM5rdWDsibntQt1Se+JeIe0/yekElJ1kjDmo3+29QZ7uneLpYUfUDO6MZp1hDByS7Ylww
	jPNWU6OV0THfEGzZN5nAesOlqWV1fPXlR
X-Google-Smtp-Source: AGHT+IHXUqI3/O2tykas7YCqb0hJEiPruqG27l3QuNQZxuNeJkfBrL0rNt4o7YlL5rbuFTNvpq5rEg==
X-Received: by 2002:a05:600c:37c4:b0:455:ed0f:e8ec with SMTP id 5b1f17b1804b1-45877447987mr4301385e9.9.1753428455491;
        Fri, 25 Jul 2025 00:27:35 -0700 (PDT)
Received: from fedora ([193.77.86.199])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fc7885esm4227301f8f.35.2025.07.25.00.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 00:27:34 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/i915/active: Use try_cmpxchg64() in __active_lookup()
Date: Fri, 25 Jul 2025 09:26:42 +0200
Message-ID: <20250725072727.68486-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace this pattern in __active_lookup():

    cmpxchg64(*ptr, old, new) == old

... with the simpler and faster:

    try_cmpxchg64(*ptr, &old, new)

The x86 CMPXCHG instruction returns success in the ZF flag,
so this change saves a compare after the CMPXCHG.

The patch also improves the explanation of what the code really
does. cmpxchg64() will *succeed* for the winner of the race and
try_cmpxchg64() nicely documents this fact.

No functional change intended.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: David Airlie <airlied@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
---
 drivers/gpu/drm/i915/i915_active.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_active.c b/drivers/gpu/drm/i915/i915_active.c
index 0dbc4e289300..6b0c1162505a 100644
--- a/drivers/gpu/drm/i915/i915_active.c
+++ b/drivers/gpu/drm/i915/i915_active.c
@@ -257,10 +257,9 @@ static struct active_node *__active_lookup(struct i915_active *ref, u64 idx)
 		 * claimed the cache and we know that is does not match our
 		 * idx. If, and only if, the timeline is currently zero is it
 		 * worth competing to claim it atomically for ourselves (for
-		 * only the winner of that race will cmpxchg return the old
-		 * value of 0).
+		 * only the winner of that race will cmpxchg succeed).
 		 */
-		if (!cached && !cmpxchg64(&it->timeline, 0, idx))
+		if (!cached && try_cmpxchg64(&it->timeline, &cached, idx))
 			return it;
 	}
 
-- 
2.50.1


