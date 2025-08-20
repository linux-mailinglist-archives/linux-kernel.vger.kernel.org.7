Return-Path: <linux-kernel+bounces-778482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BFF2B2E64B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 22:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB714724065
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 20:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00F0284B33;
	Wed, 20 Aug 2025 20:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvxKEhwB"
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A871BFE00
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755720978; cv=none; b=rgi76mCaAyBaLoUToX2xlhrTm0nkSjnPx45A8g/nH6O6Md3KjTo7VLqqgIl0IjNTnDUXGwjxsDT/ndgze8YbnuTM4lYHLq7aTxJhOhNJJkwIGJfjHZk+WNMFAVPD2oLhAB2IiKg37LTHLBR6kgSjUHv2th4BSCISnUD0fbAtl7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755720978; c=relaxed/simple;
	bh=NXTQLJ2I52qsungriptDmy8ITF/2iw/NLcw++Py2c24=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=snYQfFgGP8MrTmi3sStU36l3MMWPtWbAzuvletcm7iSz1/Kl3DDcIV2ZJMmin7GSbRjaZFGif3Nibatc00nR2HLspH/odCxOHopjnIRw4cV2xMUpl9Exub+xB33ZhLAOrT+cd0cSy4nsq8+J8ztVGIvcmz3ngsDDMcuKNGV5p1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvxKEhwB; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-76e2eb6d2baso783822b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 13:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755720976; x=1756325776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qIpEd04LLhW7wC7d9HjCp8cUc68SFaxpbzBA9V+sYjc=;
        b=VvxKEhwBuv3UaTpPo5Iy/MGfALMUd8MmN7VX5NkqHSAMLJjqtWVox5e++X23I33+OS
         jbiJ0lT7fP7mnZb5AE+jOlquFNHh4dcMpdpU8Gjp3rlyHZr2KxXpeHI1+rmma/Xm5VQi
         i4UvCyNw0KxurcP6tvxzh1zjChYyrvV2DJzbCY1ixBmElGsdfoV86SFR05xrxbFw7Ovu
         hjht4c3ZATsEYEFmW2g5EXfoIJ73P8NkzeP3hlEWj2D/N9LnCrVx/cJye8ozBfYdjIH/
         kCLQ7swEPC7eHN+5zm1LVSy2lcHkihyzIE9OjxXKzs45+e5NeTYT1+DEtQZEnyzDUTRQ
         DThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755720976; x=1756325776;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIpEd04LLhW7wC7d9HjCp8cUc68SFaxpbzBA9V+sYjc=;
        b=HNy6D+NTZdbMMU3MpJA6mVbrYuPCX1oyfI5wbBGntExyFLtGKc+jY0adDlf14pzXX8
         Fc8AC4F6D1GXgeHDsSQjR8PChwnk6lDTNHkmFedD/j3eiUqt/nYSKDSGQeEZfDr7JmIv
         EyFW99kDaNmWbZGkWnUBVOjLEjVYXiMjbnfW4NHS8cZJTReOf7l2Va42A7VYkwHXf7rA
         gTYNZR5kwBxa9BU3880wjUHU7fkXEbkae1r3vx33DPsxX3KWITwqdX6lV1vWLAehX6tU
         ubySnHOsW0gNGNt9qKZEGPRzFR/qCZDVFWb5WUM1+BtY4KlT5cRC/RG5u+IIUpbnCGxF
         U9Qg==
X-Forwarded-Encrypted: i=1; AJvYcCXw0/dTLsy6Z40UkMUmteEEH7CQE31IivQJ8+B4ZADxrtzHZtOXYDORUlArLRo7WcgWngb44bWIH2GNJUs=@vger.kernel.org
X-Gm-Message-State: AOJu0YywyXtaMthJxDFceQol6F3Pn0A6BThh+xKpGX8GfS36LnDbfh12
	ieIsffzGnCUCSB2B42QZymjo/MVBRIj+vm+owlSItmsFoeV97legYFATia0J8EUhG3akXkQDLXf
	hlBDmFwGQlqYksQ==
X-Google-Smtp-Source: AGHT+IE7GwfmR2D95ArpXhAM3e3FihMKCVaV4jn2nhnJyETg8rpRDPNgsDsY/10SNk9YeSB+51j2Lgd5YnxM/A==
X-Received: from pfbjw5.prod.google.com ([2002:a05:6a00:9285:b0:76b:de2b:6796])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1813:b0:76b:d746:733a with SMTP id d2e1a72fcca58-76e8dd85d39mr5837029b3a.21.1755720976156;
 Wed, 20 Aug 2025 13:16:16 -0700 (PDT)
Date: Wed, 20 Aug 2025 20:16:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250820201612.2549797-1-cmllamas@google.com>
Subject: [PATCH] drm/xe: replace basename() with portable strrchr()
From: Carlos Llamas <cmllamas@google.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Matt Atwood <matthew.s.atwood@intel.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Carlos Llamas <cmllamas@google.com>, 
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

Instead replace basename() with a strrchr() based implementation which
provides the same functionality and avoid portability issues.

Fixes: b0a2ee5567ab ("drm/xe: prepare xe_gen_wa_oob to be multi-use")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/gpu/drm/xe/xe_gen_wa_oob.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gen_wa_oob.c b/drivers/gpu/drm/xe/xe_gen=
_wa_oob.c
index 6581cb0f0e59..0a94a045bcea 100644
--- a/drivers/gpu/drm/xe/xe_gen_wa_oob.c
+++ b/drivers/gpu/drm/xe/xe_gen_wa_oob.c
@@ -125,9 +125,11 @@ static int parse(FILE *input, FILE *csource, FILE *che=
ader, char *prefix)
=20
 static int fn_to_prefix(const char *fn, char *prefix, size_t size)
 {
+	const char *base;
 	size_t len;
=20
-	fn =3D basename(fn);
+	base =3D strrchr(fn, '/');
+	fn =3D base ? base + 1 : fn;
 	len =3D strlen(fn);
=20
 	if (len > size - 1)
--=20
2.51.0.rc1.193.gad69d77794-goog


