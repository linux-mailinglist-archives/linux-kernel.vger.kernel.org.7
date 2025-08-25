Return-Path: <linux-kernel+bounces-783848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56CEB33377
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 03:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02F417FA33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 01:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC3001C862D;
	Mon, 25 Aug 2025 01:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b="b9LbBD0g"
Received: from mailout02.platinum-mail.de (mx02.platinum-mail.de [89.58.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE12139E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756084707; cv=none; b=HkodFoFp/Da+xs7Qc8J5SZS8SmMyclLehcR3n8zDAcjhO0Y3a2zTXeAEYcXOMnroDx0EGSbsuR29UdehVwlhGYwiB2ETUTLLP3Kc4S746YWZHy3zFO0mMn7z/waR3/lWm75xU4oMBdzE2VYGQpS9WiMpuRlmpwC99cc8aSWrwu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756084707; c=relaxed/simple;
	bh=Rh4dkKQC119Akv41mQ4vorQSwJE1Xtdn9NDHvo5rGBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ct2bhfTYaWpqVyrH/8yAr9niDYM5WgjPFhjvESQENEuy4GbGqD0Lbwa0Vudgm+Oq1FRXTFpwgk5dhL/Cuz6PSu5aCGLGv1HYVBi/WQAYAcX7rcs7+hAtHw+DN94JJLXVENOdyhcEaXmyf7LPvteXSZT2uaS3Z51oTNHhoLkglyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org; spf=pass smtp.mailfrom=achill.org; dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b=b9LbBD0g; arc=none smtp.client-ip=89.58.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=achill.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout02.platinum-mail.de (Mail Service) with ESMTPS id E6A759A28F2
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 01:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=achill.org; s=mail; c=relaxed/simple;
	t=1756084179; h=date:message-id:subject:from:to;
	bh=Rh4dkKQC119Akv41mQ4vorQSwJE1Xtdn9NDHvo5rGBo=;
	b=b9LbBD0gtwCWpIl9a4xqUddAEwBbdZ3ZU1IB45RzpC8xoOrDLpFM/OB0MTHchB/4wbCYS5FpwdK
	8dmMP18/Co7iDnePg520h+rUzAOI0V/baCJugx4ZRSMQl/iR99/lLdcaJcTDj7MNyUsOG2aoiXwu/
	8Q58xdEmOslNIJusigAbs+WS867w7g966l5oOt922GYHh5CK0g8/l/Zb2NVVZVc2Zxh40/D+Gc14/
	AyXxLtl+zkBrQxDlkUjjBvsozH4VJE9YE74OppzlCBvMZ4puGSMAEefVuGJhLktwLlr/G5+ibuRMN
	/ncWZUMDGISv6qV7mPqzjO2nFLsIr6W8CWvg==
From: Achill Gilgenast <achill@achill.org>
To: Matt Atwood <matthew.s.atwood@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	Achill Gilgenast <achill@achill.org>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH] drm/xe: add missing include <libgen.h>
Date: Mon, 25 Aug 2025 03:09:09 +0200
Message-ID: <20250825010914.99742-1-achill@achill.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

basename() got implicitly included on glibc but not on other libc's like
musl libc and therefore fails to build:

/home/achill/git/user-aports/experimental/linux-mainline/src/linux-6.17-rc3=
/drivers/gpu/drm/xe/xe_gen_wa_oob.c: In function 'fn_to_prefix':
/home/achill/git/user-aports/experimental/linux-mainline/src/linux-6.17-rc3=
/drivers/gpu/drm/xe/xe_gen_wa_oob.c:130:14: error: implicit declaration of =
function 'basename'; did you mean 'rename'? [-Wimplicit-function-declaratio=
n]
  130 |         fn =3D basename(fn);
      |              ^~~~~~~~
      |              rename
/home/achill/git/user-aports/experimental/linux-mainline/src/linux-6.17-rc3=
/drivers/gpu/drm/xe/xe_gen_wa_oob.c:130:12: error: assignment to 'const cha=
r *' from 'int' makes pointer from integer without a cast [-Wint-conversion=
]
  130 |         fn =3D basename(fn);
      |            ^

Fixes: b0a2ee5567ab ("drm/xe: prepare xe_gen_wa_oob to be multi-use")
Signed-off-by: Achill Gilgenast <achill@achill.org>
---
 drivers/gpu/drm/xe/xe_gen_wa_oob.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/xe/xe_gen_wa_oob.c b/drivers/gpu/drm/xe/xe_gen=
_wa_oob.c
index 6581cb0f0e59..74af4b9fde65 100644
--- a/drivers/gpu/drm/xe/xe_gen_wa_oob.c
+++ b/drivers/gpu/drm/xe/xe_gen_wa_oob.c
@@ -6,6 +6,7 @@
 #define _GNU_SOURCE
 #include <ctype.h>
 #include <errno.h>
+#include <libgen.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <string.h>
--=20
2.51.0

