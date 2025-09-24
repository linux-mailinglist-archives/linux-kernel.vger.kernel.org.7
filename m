Return-Path: <linux-kernel+bounces-830317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38199B9963C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 12:15:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E821B2342E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6292DCF71;
	Wed, 24 Sep 2025 10:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TH9PCkV5"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D892DD60E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758708928; cv=none; b=r+bVHgCCFgepDhOzxX8v62UDQWhpxM6LMzDKbddOtyAGxPw9rIl1Dt9tJLGI92pGSZGrzEwdx1ZVuQxnJo9G50FvLyYVmuygOKtWvVq5n+68fve0BjSh1CRbVUDTLnW5U3IgQj9fKOtBgKvd80PLIUkU7s6zoWI5cl50j4IoTCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758708928; c=relaxed/simple;
	bh=/Q9vCOreIoGjql+sVyN91PZfur9aXF/T51feLqehc4o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z79fWQnWFwbYqttIKxQrRsva893XHC+lFreQxOggkH66O+980TJ0YDre13wc0O+F39rRdH95mbABbFp/nmYbmmAu8gBN3uJiTWXV2xtmEIosjkdIRVfPeHorlB5rpbkBdc7Q9ELKlY8ggJLhX2MerHk2zWIbpCEHDJfzcsjDfEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TH9PCkV5; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3fa528f127fso605992f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 03:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758708922; x=1759313722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IOhc0Qxyul5wC2rt4MIQkux7LNfnaT0nE4lQR+NyZBI=;
        b=TH9PCkV5x+RxCdN7VoxYvAurJIrZhR20pr1r7UqewwPKUazge1Eqf9tEfFAjFjOk8d
         1MBogDvLU5QpoDHgHnOLxxVFIfe3V+tjwZWhIGfv/JWN2CxwR91KLxtXOZjjg3WV7q3t
         T9ueIsnX7i5WdMyV0NlAB63/Di08TNfQl92tgYyqAcsmyE1/p7fAdn1W5R+/dX2jR3nV
         98gXMrNbFBdbyx5lRL7xD0yIFKkNn39v3OwClULVyvp3h7C9r3UTpYUSKWTbx5HDwAJn
         qPVnRcelacyly8DQlYU1kacXBtFDYirmgqKhgQ/8fkfeRMGgjwTBE/FTEux1Db8faiwC
         UFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758708922; x=1759313722;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IOhc0Qxyul5wC2rt4MIQkux7LNfnaT0nE4lQR+NyZBI=;
        b=qFrP6R8aBT5VouUPz/AEiybvo1VBMs7S1cwLxnXZbsdq2qh3GuRs1nzMMSWUOrNaJH
         B8w/bIQsAmUFDPua0t8+ZJOMgPQDFbSAtGMDskLI++9xRp0OgRP2W0/7v3TbeTNN0qY9
         TlWFiogHC12wv5oRuZdKNO5QCIh48yjatwoHSq+DnCCPgVsmaFFzg23lcfM6a1nnMIf0
         G4qwWXKB8smuOOUTcCh0/X3tweDYzsnWKnVqfhD/idikqxMCplveIvKKiepOqNmsumH/
         m548VRDN9rPCO9rTanbsxjBUWmkPlmTJ9zNZC7szgvD1P4LKbp+sLzwq/dR6QRHCI/z3
         jYrA==
X-Forwarded-Encrypted: i=1; AJvYcCUew3cIDW2PH56sMZWE3vDfB5pQ7/SRm2vfSpgAuAYgbEek1g6d+Bzm+GUTJSIydJANKkGayuAINjq7vzo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1nNS9/UVRabff/L7YVZUWumAXce3jTu9qxDsCtUy+csPSppo2
	TZbQqyV0mrZD1+YA54dwIly7P/F6pP5iJENWxBeT89rfqluKDakGPkYU
X-Gm-Gg: ASbGncvqzjESa+y4scr/TWPgDip8P2FgGDhvKwj+SG6w8ZOa7CWitxho7Ap4C0rc2ev
	a+FIkwcjLcZsQMphc4TyQkhMgVl7aNHAxpcxrn6KNVhKlUPu1YUDXAZJwR3RvhQplD4IgiO6ex5
	3qMgFLf/p/Xn+VL72CWjAr/FXVeGML2Ct25RELKaKPn9K1XDa6/d8efVacst8YF2uzw3vVglmjW
	j6WX++t+R5+9CajqDp7eG0eWuprnsKhhFZ0fFv5EV5hWlHTDCL88nkURgSPQNtck4kMxjHzbtLD
	WfAfV0dfo2LR65w9XYbT6KRrUvq+fnxHXZ+Uum4eroVwJ4xs8u532bEBLK6cs/Wh5AET+oE27vl
	KoISrUZ2dw8VttTLFs+eydQ==
X-Google-Smtp-Source: AGHT+IEr/rY8DYnEgjfNqtZnQLYi8AIPod0JxD4snpz+21wUk07dSh+fVo+u5hSxKvTeDXsJt+uDWA==
X-Received: by 2002:a05:6000:400f:b0:401:c55d:2d20 with SMTP id ffacd0b85a97d-40ad1604b9emr1380003f8f.26.1758708921561;
        Wed, 24 Sep 2025 03:15:21 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46e2ab31bdesm24993385e9.11.2025.09.24.03.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 03:15:21 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/xe/xe_late_bind_fw: Fix missing initialization of variable offset
Date: Wed, 24 Sep 2025 11:14:32 +0100
Message-ID: <20250924101432.8689-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable offset is not being initialized, and it is only set inside
a for-loop if entry->name is the same as manifest_entry. In the case
where it is not initialized a non-zero check on offset is potentialy
checking a bogus uninitalized value. Fix this by initializing offset
to zero.

Fixes: efa29317a553 ("drm/xe/xe_late_bind_fw: Extract and print version info")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/xe/xe_late_bind_fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_late_bind_fw.c b/drivers/gpu/drm/xe/xe_late_bind_fw.c
index 38f3feb2aecd..4f0a529caf20 100644
--- a/drivers/gpu/drm/xe/xe_late_bind_fw.c
+++ b/drivers/gpu/drm/xe/xe_late_bind_fw.c
@@ -60,7 +60,7 @@ static int parse_cpd_header(struct xe_late_bind_fw *lb_fw,
 	const struct gsc_manifest_header *manifest;
 	const struct gsc_cpd_entry *entry;
 	size_t min_size = sizeof(*header);
-	u32 offset;
+	u32 offset = 0;
 	int i;
 
 	/* manifest_entry is mandatory */
-- 
2.51.0


