Return-Path: <linux-kernel+bounces-780744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A317FB308DC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61A15A27F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2905285CBA;
	Thu, 21 Aug 2025 22:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WtXJ9JKg"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBC25C88
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 22:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755813660; cv=none; b=q1S86PvrVte6VN7ILjjSzTH171LWinhSckupeo2/uuHRtB/F2AegqL8wrmZprhcK9+RSzK6KwbxwsbePFrhOIVPDpVtv+hDp6SMpwU+lhR6CsMSB7goR1zr6aQqLp73r6CmnLE8C14EywZ6gYS5y3DxU5M4sEg7wxYuH2ODg3iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755813660; c=relaxed/simple;
	bh=1nvJxYXQwUIpsHiqMhVuXkaYGDPfbGX9Sou5hYTfpxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K/xoVy6u+uoWLpS3aISeOR51AHSV9uMFF6XAf0fWQAJo+ZxVU/ZT/FFNn3cji8a3sDjVbu+oboAroZgysK4WBA6UkEFrCH8cOZ62Yvu7kZpwSKay2EU7lc21K/Zs0C5xCxeNVvK+XMLoaKQuAHYRGtP/L+8hluI/WOzGCSgwaus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WtXJ9JKg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-76e2eb6d2baso3316236b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755813658; x=1756418458; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cLlpuHdBM/UdMtUWDBy4/i+9L6ubcblOqSNe/mP7/k=;
        b=WtXJ9JKgK5U43kaiLGj8MLy4TPyWre4+vBeRU7aLUbR41eCW5WqujKjAdHvTCn+1+J
         fI72HID+CxPt8HBHPVOUzk5alXO2xiEpJDJSJvufeUKWzUIqzScNmUMJ0kCXm2T6LuUw
         j3Kn71FBqda6nZK8PZge/IMNISjjGT7dV5CmSOLF0bFyGAJnLceeQsCWZMn7Oe8AT4dg
         87JYrWwHPnuv8PPht5cXinwdUUUC+X6y3+yy81GdusQEuNSvDgHi3txm6RcJHfXPPtNi
         bzxRaTsUAuMmvo0WcxxV7ydef8EOneslaGFtU1TOMxDcMtP6GXx2fVfb9mNhrDmjjVHV
         OEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755813658; x=1756418458;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4cLlpuHdBM/UdMtUWDBy4/i+9L6ubcblOqSNe/mP7/k=;
        b=j4akfvfQ5Ts02ZWfI4m9q2vEsLZr3CKqm9rKXtJdfKPkqRL0lqFATd0oYt4/1BWmdA
         g/W7yTr7mqdmh0dtz3KeD0UPxpHDdq724WfdfgFkjmWTj+fms5Vc5+Wt9SSTWtmppx+T
         b/G3d6Aol0hETVnE8MRqaQjyrX2bWv1hTriKqm3QuIqZSExJtGtM2ol4h+MK3vukVz3h
         Kmk7vIbMjDsK7H5zkh6ndQdyojRvPrM1TR1NJpiRB7/sRjU1zS+0Ng24c5qjb2CIsNeu
         NvkVeDVXkWIy1YFqRK5Y0PvNKy9yG0k3YDhBssIY2AjvDXsYZTTnknSPS18UK8DMul74
         gJYg==
X-Forwarded-Encrypted: i=1; AJvYcCXWxO28znyfkMOcA5prEICg3sPwKTFbvlLvFMaW8vhiAUmAR+4sy5BZpUAnGBPNdIzzm4ANQzeMmpnNRjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCAE2lliSciaEzc1D5kU1oV4cjIEJ+4fQVOB/+65Ofl1mkD0eb
	12vydJra0pHXVld6/BT90qG479BYzg9MdA5zPz7lDhxu+gpwEU4d1yyb1ZeG4lnFDyc7F67oe/B
	DrhZviy6oFSxHDA==
X-Google-Smtp-Source: AGHT+IEAbdE+rBrrN9gQKjiTu1VWCSa69pr7H1Wqyou0ZlgqSmruqcwdp3/7Db/srMjoEdDP7SkVIJMHghXH9A==
X-Received: from pfop21.prod.google.com ([2002:a05:6a00:b55:b0:746:1931:952a])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3d0e:b0:76e:885a:c1cd with SMTP id d2e1a72fcca58-7702fc472d4mr1141804b3a.31.1755813658055;
 Thu, 21 Aug 2025 15:00:58 -0700 (PDT)
Date: Thu, 21 Aug 2025 22:00:53 +0000
In-Reply-To: <v5j6nxynzvvlcxu3m3mkeyjv5dlozzp7ixkgc6u6hdzh7en6jh@zvzqm5n7njfd>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <v5j6nxynzvvlcxu3m3mkeyjv5dlozzp7ixkgc6u6hdzh7en6jh@zvzqm5n7njfd>
X-Mailer: git-send-email 2.51.0.rc2.233.g662b1ed5c5-goog
Message-ID: <20250821220054.3700783-1-cmllamas@google.com>
Subject: [PATCH v2] drm/xe: switch to local __basename() helper
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

Instead, implement a local __basename() helper based on strrchr() that
provides the same functionality and avoids portability issues.

Fixes: b0a2ee5567ab ("drm/xe: prepare xe_gen_wa_oob to be multi-use")
Suggested-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Tiffany Yang <ynaffit@google.com>
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
v2:
 - Wrap changes in a helper function per Luca's feedback.
 - Fix typo in commit log: s/avoid/avoids/ per Tiffany.
 - Update commit log.
 - Collect tags.

v1:
https://lore.kernel.org/all/20250820201612.2549797-1-cmllamas@google.com/

 drivers/gpu/drm/xe/xe_gen_wa_oob.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gen_wa_oob.c b/drivers/gpu/drm/xe/xe_gen=
_wa_oob.c
index 6581cb0f0e59..c18faccdeb90 100644
--- a/drivers/gpu/drm/xe/xe_gen_wa_oob.c
+++ b/drivers/gpu/drm/xe/xe_gen_wa_oob.c
@@ -123,11 +123,19 @@ static int parse(FILE *input, FILE *csource, FILE *ch=
eader, char *prefix)
 	return 0;
 }
=20
+/* Avoid GNU vs POSIX basename() discrepancy, just use our own */
+static const char *__basename(const char *s)
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
+	fn =3D __basename(fn);
 	len =3D strlen(fn);
=20
 	if (len > size - 1)
--=20
2.51.0.rc2.233.g662b1ed5c5-goog


