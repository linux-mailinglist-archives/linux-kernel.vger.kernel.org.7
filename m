Return-Path: <linux-kernel+bounces-785139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA039B34685
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 17:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC47E5E564F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 15:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1894B2FF655;
	Mon, 25 Aug 2025 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="feX/4DTX"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A332F4A1B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137490; cv=none; b=ijjiLQk6Ix90NARFX1mBhm4IPYDVofjxwrJKss4AY9lT+AcldEjnUFHL3YMprBHW9eSD55m7s9+0jsGt7gWEwdW275cniIEpO0TsdOQ7MlNJ25DGlwKj9/rFgROXUUhUUoZSO5KM1oIBPiPcaIyqysRleJdE4tktmWpAYyFYljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137490; c=relaxed/simple;
	bh=cGBgNnLlZDhG/jnfPmu3sMmK4+lBkTH6onzTfdZ8cXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rhG0muQyuUNqF3v8rv4kKAsVjdRWbccqPiSjZEsOFrVcfrH1bV7HTH+59FbpNgdeuGgCGtoC5KDa8u8pWX6KTA7UsOMbd+04YJa7y66Dphxum6Lx/XXpoCBzDGtTf3DnuJBXPw+LBX5d+s0Rg7T8tFaWp2+jvz4OiV3NJAJX+d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=feX/4DTX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-244581c62faso56998925ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 08:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756137488; x=1756742288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lkwErEFpwwFQOHYRvZPN+kMZDZFEGs5jc16bYvoo+nE=;
        b=feX/4DTXdk3NI5O7OBBrAEutrXoDt30OI9WKOjiCO86q68r9f51TCd63dmPnWssgtH
         Q/jmhy7INvxJhqYytx8emFFGaXd3sIYeqp2eDjgheKZERgRQVO592sqmC8wiCAb/mJbd
         BUeF3J6Etx3ZVjXkPvMPJ3v7+rC3zQxiFhbZ+h6nXh7W2wUeZq4EK6T99FHDoGeH2D6y
         KK7v1baj8/xw3BVCmdLPGPpiz7nihENgI++QR8aFVgK61PZcJvVS2zUzmjxQHWdyROhA
         ig5f1MkRk7tRpg2BmoIIu/hAv3+tZhQSyu9ysam11WBis9vz5l1Vi0E5d0fLNK4rlZzG
         BXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756137488; x=1756742288;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lkwErEFpwwFQOHYRvZPN+kMZDZFEGs5jc16bYvoo+nE=;
        b=uv1kD5+nEDmx+AcjiyUW4ewP/SbJsjPWYixpjicxzfbQa8PDEhuyZ9y8FFXHg4BNjG
         e2abcPaehU9xWfDGz7QaSxQDS+QI52BRJA5QBfPLusWuyBtAkH/TyNTtE71oJcuhBqJp
         s4YSe4KGc5daDxkILqumHXaFBCrXrKA7fKZ8eRBVEjUJ1nWZAzdbsLLrxhimSRqAEgh9
         Qs0ZBLz1OucuF4HICTP6nz2px3qrN5/+13JbCter/AgCIpehCypaPolQxXErSw3F9MvE
         douy+gUckJOn90KwKdYwYhqipJainvW9Wbhhd7UHqn7w/or0wRCirYB709JWeJibrnim
         kXEw==
X-Forwarded-Encrypted: i=1; AJvYcCUigQeGRJbtrnb6ANsBYVMqKwV5J+wUtZjvkmzoMgYuXgppSAWFMhOdM9fSBm6gcskAfe2sxtGXVaNvYic=@vger.kernel.org
X-Gm-Message-State: AOJu0YwelULAtslDCWXrtYtARQdHpI+u0kkrzbpwsRFfXgYoni30GwlR
	4Ah72MGnh20sdMkyIkxxR9SkP7e2z45cHjRfySdBoG9BdQjWF4gQ5cWncfXMe2ZbvKNAoVlk5lp
	VvS2iCzHudBqCoQ==
X-Google-Smtp-Source: AGHT+IFFAXlYjauB8hf2P8M4bUyuciisgELTWwgt1wqb+R8oSPO5eYv/Ss8op3w6WvxFmQwmUhX4/UeNCsS7jA==
X-Received: from pjbok14.prod.google.com ([2002:a17:90b:1d4e:b0:325:8fba:708c])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4c8e:b0:325:245d:79c2 with SMTP id 98e67ed59e1d1-325245d7ac2mr16362226a91.15.1756137488184;
 Mon, 25 Aug 2025 08:58:08 -0700 (PDT)
Date: Mon, 25 Aug 2025 15:57:42 +0000
In-Reply-To: <w4j3kzezrd4xqc4q4vkpbbxqvqxitam5htkex6rj6dguj5kbw5@27gqnp6veuu4>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <w4j3kzezrd4xqc4q4vkpbbxqvqxitam5htkex6rj6dguj5kbw5@27gqnp6veuu4>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250825155743.1132433-1-cmllamas@google.com>
Subject: [PATCH v3] drm/xe: switch to local xbasename() helper
From: Carlos Llamas <cmllamas@google.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matt Atwood <matthew.s.atwood@intel.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, Tiffany Yang <ynaffit@google.com>, 
	"open list:INTEL DRM XE DRIVER (Lunar Lake and newer)" <intel-xe@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Commit b0a2ee5567ab ("drm/xe: prepare xe_gen_wa_oob to be multi-use")
introduced a call to basename(). The GNU version of this function is not
portable and fails to build with alternative libc implementations like
musl or bionic. This causes the following build error:

  drivers/gpu/drm/xe/xe_gen_wa_oob.c:130:12: error: assignment to =E2=80=98=
const char *=E2=80=99 from =E2=80=98int=E2=80=99 makes pointer from integer=
 without a cast [-Wint-conversion]
    130 |         fn =3D basename(fn);
        |            ^

While a POSIX version of basename() could be used, it would require a
separate header plus the behavior differs from GNU version in that it
might modify its argument. Not great.

Instead, implement a local xbasename() helper based on strrchr() that
provides the same functionality and avoids portability issues.

Fixes: b0a2ee5567ab ("drm/xe: prepare xe_gen_wa_oob to be multi-use")
Suggested-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Tiffany Yang <ynaffit@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
v3:
 - Switch __basename() -> xbasename() per Lucas.

v2:
https://lore.kernel.org/all/20250821220054.3700783-1-cmllamas@google.com/
 - Wrap changes in a helper function per Lucas' feedback.
 - Fix typo in commit log: s/avoid/avoids/ per Tiffany.
 - Update commit log.
 - Collect tags.

v1:
https://lore.kernel.org/all/20250820201612.2549797-1-cmllamas@google.com/
 drivers/gpu/drm/xe/xe_gen_wa_oob.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gen_wa_oob.c b/drivers/gpu/drm/xe/xe_gen=
_wa_oob.c
index 6581cb0f0e59..247e41c1c48d 100644
--- a/drivers/gpu/drm/xe/xe_gen_wa_oob.c
+++ b/drivers/gpu/drm/xe/xe_gen_wa_oob.c
@@ -123,11 +123,19 @@ static int parse(FILE *input, FILE *csource, FILE *ch=
eader, char *prefix)
 	return 0;
 }
=20
+/* Avoid GNU vs POSIX basename() discrepancy, just use our own */
+static const char *xbasename(const char *s)
+{
+	const char *p =3D strrchr(s, '/');
+
+	return p ? p + 1 : s;
+}
+
 static int fn_to_prefix(const char *fn, char *prefix, size_t size)
 {
 	size_t len;
=20
-	fn =3D basename(fn);
+	fn =3D xbasename(fn);
 	len =3D strlen(fn);
=20
 	if (len > size - 1)
--=20
2.51.0.rc2.233.g662b1ed5c5-goog


