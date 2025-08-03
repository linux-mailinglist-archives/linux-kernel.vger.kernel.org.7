Return-Path: <linux-kernel+bounces-754436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15316B19447
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 16:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49CB07AB1F5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Aug 2025 14:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523C8265CBE;
	Sun,  3 Aug 2025 14:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iFaC6D/R"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFED156677
	for <linux-kernel@vger.kernel.org>; Sun,  3 Aug 2025 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754232695; cv=none; b=Qsz/ZzVXivZz29DEppIq3+GD12NPq4v4TuvolUiPNUC+VNJkotb1L4s+c8viYhyXZ7iZSnMT0o1IOi0IZpQuqfeeMw19bMHPrW0n4mw5NCJJymGXTx5XlDbvkglLLZ7hAjD5/C4DDaCDN/MWUqEvfwDvIv3cxqHPtyBWneHA06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754232695; c=relaxed/simple;
	bh=R3jpjmKrJbQirI+2K5k/ptOXV20RY1coOunZ5bldD4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+1zeRcEFa6ETuMeCUu2NBx8O7WCHCtu85XJFRATrR6w8ADnihkPrIXVYxipXR04NhwjDGnoQcbafIb8N1Lq9KBCo4hUJEQjD0Ntwb3tBhv0liuXop+FrecgVvQu5zCHUEeefYQ9mY8brkoNyXTp5RtvgssCP3yHSRI91KCbdpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iFaC6D/R; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-23c8f179e1bso29092925ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Aug 2025 07:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754232693; x=1754837493; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Vkkz14oBDajFCh+KZnGbaaU8Qt9SjhfOB4COwpfGi4=;
        b=iFaC6D/RJ/xrGFaYzfOmtiYEiOfzAXPt7R2IXuvPyAQLzWTuXb0u9xe0A7z3HJwttv
         B65SKpz37lV/VrJuiDboBblD/s7IqRsx3k1uQKQIdFJHWuq2TGZRWtEL5M6xnsIXBE4c
         r2pMetL9eM44ZgZWXQlYiReLnIALJHaJXXnqBPp20TT5Y7d5zDuoStC8/TqM8fczA7q9
         /Lp5y4WjobeF/MWiPmFsvwhCDe2Kp4zjOWjqP9tWw6odYgg7wlH723Lz1+k0RCPeUW23
         PApklNe0Gv8ezgL9aTUZw25BhIt1txcG45qfwMtfpvXVethGHyTWpJVcKX/Q9LUP9NsJ
         wu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754232693; x=1754837493;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Vkkz14oBDajFCh+KZnGbaaU8Qt9SjhfOB4COwpfGi4=;
        b=q31IYmXSmssf/cSzZ4lUVDVlhUJ6Q0U7zBlvDc1XVCjN+OP+ph3aGAYvi82KpaVj2d
         FAmjPFR8h0LvV+QCN16+J6q96RijtiF62UOYBt78BKW+6PT9ibvx6woY8u3oohCYZNvC
         UMyfOxOtpL2D47REsnPgL0nks2T7JaQLLGhdYgeWL/v7Vbu3uHO8s1z+yZNwI0nVc+FI
         HOiH5F3NjHAycDiUOKceR509At/UkHJefEmnrMh5YdMF5Vm+XmvgnVY7D1xZnBf+afOy
         JuZhFPX39WA2INR2ta9yUSYQq0ucgz6+WsNQnEDeMHqPUwErV7tOsK41Styeg0mnxizS
         J3EA==
X-Gm-Message-State: AOJu0YwVIGb+23cWjtN2Wb6xLedPap13vpeRcWFcnBf9m8PY/oUd4wRY
	KpGW2B2EkU74F03pd9FKqiW8ViotH8fEU0MML7tS9DYdi+5H4PPNYdmj+aNGnOU=
X-Gm-Gg: ASbGncvJ9HY1cYMMzL+Ii9aNgz3OqiTwGHu5LNlHsd8RBk+DsWaGSZrfatUcnVv0TMU
	Ur2FORQEn2YsuECglIdlrvffBxDumD6KUkAVo9xIYvr0r30+BGA0nCy6W0iIkBHhZkVzb/Lg1Vr
	IfzQbGjWA7VwWxZro0Gd43p4Wh0cXPJvrgbpZepYWS3Cj94YCwXhvvCpYyLIAE2RTIGDXC6oj2e
	IpVygsvhWVFPaBfZl0mHg/N18ZltzfRl+Gc/CDOMwEBEEh8JF6e+zeNBYKrGYDfrR/nrj2mcmHd
	s3fyA9jDwdRu7zD/+rDWUomrTYn/m5GjAesGwtBOUJlWnABZOjdmk5WdmiLtut1C8NWZWkSg9ul
	69kDEidxFbSDyz7TNczgqN8fomyr8vNzVgokKA2I=
X-Google-Smtp-Source: AGHT+IHaACvLIJbhyrNkE1Xr1pnl80KhAoISJ1CmCby1eqnice4TBxjONpHeIDTUY5UhfvxMryX8Tw==
X-Received: by 2002:a17:903:2d1:b0:240:8cda:9ca1 with SMTP id d9443c01a7336-24247059772mr73691585ad.50.1754232693079;
        Sun, 03 Aug 2025 07:51:33 -0700 (PDT)
Received: from VSPRIME.. ([106.220.185.138])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977896sm88475825ad.79.2025.08.03.07.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Aug 2025 07:51:32 -0700 (PDT)
From: vsshingne <vaibhavshingne66@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: vsshingne <vaibhavshigne66@gmail.com>
Subject: [PATCH 1/2] docs: powerpc: Add htm.rst to the toctree
Date: Sun,  3 Aug 2025 20:21:12 +0530
Message-ID: <20250803145113.7149-2-vaibhavshingne66@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250803145113.7149-1-vaibhavshingne66@gmail.com>
References: <20250803145113.7149-1-vaibhavshingne66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: vsshingne <vaibhavshigne66@gmail.com>

Signed-off-by: vsshingne <vaibhavshigne66@gmail.com>
---
 Documentation/arch/powerpc/index.rst | 1 +
 Documentation/virt/kvm/api.rst       | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/powerpc/index.rst b/Documentation/arch/powerpc/index.rst
index 0560cbae5fa1..173a787b6cc3 100644
--- a/Documentation/arch/powerpc/index.rst
+++ b/Documentation/arch/powerpc/index.rst
@@ -36,6 +36,7 @@ powerpc
     vas-api
     vcpudispatch_stats
     vmemmap_dedup
+    htm
 
     features
 
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 43ed57e048a8..41e1a72bd593 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7230,8 +7230,9 @@ inputs and outputs of the TDVMCALL.  Currently the following values of
    placed in fields from ``r11`` to ``r14`` of the ``get_tdvmcall_info``
    field of the union.
 
-* ``TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT``: the guest has requested to
-set up a notification interrupt for vector ``vector``.
+ * ``TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT``: the guest has requested to
+   set up a notification interrupt for vector ``vector``.
+
 
 KVM may add support for more values in the future that may cause a userspace
 exit, even without calls to ``KVM_ENABLE_CAP`` or similar.  In this case,
-- 
2.48.1


