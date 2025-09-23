Return-Path: <linux-kernel+bounces-829237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CD8B96963
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EB517D240
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65389212551;
	Tue, 23 Sep 2025 15:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hy5Vo7yB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014551E0B9C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641457; cv=none; b=GKv8nAjcSdnVjX0Z/7prtWD6sa5HeycntJLix9lM3R+NTgMDWhS2E+XYpiE6iNgqCZ+J6JxnqJtEOqgmoRZcmWdJb038XYpiCkAcrHsGOhOCMuJrkLXIGdelrOTOsgUlUczM1KDdsYJd+HodB8xY578+9vcrDhhMXFlz24U9pWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641457; c=relaxed/simple;
	bh=rCVw1adcjYkdtfuE+IpJkIeek0eVQVlqCw6CkfcUBXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=Tzz268Cz7VSWhDxGZ+bCti+IXpdJYvoELJCVZkgwWcm1kpM4b2ZDXzYQR6zAhcGxrxOJoV3/scfxspNTXIr5GG/NlXbRYqN+YzS0hQGuf9ZoQ5W8uYCuCCuH4ZFe0G2WWT5l4PpSlfsb+nc2I8GIfCtXWsYz7z74MaClIUYBN5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hy5Vo7yB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758641454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Gepj0GovVH3AS/Kf3XZjwnwXf+WGuvdxszVKLwmSkUk=;
	b=Hy5Vo7yB5IdnkpSIQcwJKUOljxcXH37m3VjtcGfXVt7up2nu5AVvuQXTuZoqHrf1BGcIbe
	JQao53dunhZhbcCEyv+UKRxkp3kjMB/uUotc7Fp+R25iFN38n7q+38CfPGf85th4yaSqaY
	EGQR92lr1VQuw0cjZnuaQKjYc1kC5e4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-Is6LQT77NyiaptB_lKTIGQ-1; Tue,
 23 Sep 2025 11:30:53 -0400
X-MC-Unique: Is6LQT77NyiaptB_lKTIGQ-1
X-Mimecast-MFC-AGG-ID: Is6LQT77NyiaptB_lKTIGQ_1758641451
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1821019560BB;
	Tue, 23 Sep 2025 15:30:51 +0000 (UTC)
Received: from t14ultra.redhat.com (unknown [10.45.224.118])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C73B19560B8;
	Tue, 23 Sep 2025 15:30:47 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	jstancek@redhat.com,
	linux-kernel@vger.kernel.org,
	joe.lawrence@redhat.com
Subject: [PATCH RESEND] powerpc/tools: drop `-o pipefail` in gcc check scripts
Date: Tue, 23 Sep 2025 17:32:16 +0200
Message-ID: <cc6cdd116c3ad9d990df21f13c6d8e8a83815bbd.1758641374.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

We've been observing rare non-deterministic kconfig failures during
olddefconfig, where ARCH_USING_PATCHABLE_FUNCTION_ENTRY was getting
disabled and with it number of other config options that depend on it.

The reason is that gcc-check-fpatchable-function-entry.sh can fail
if `grep -q` (or scripts/dummy-tools/gcc) is fast enough to exit while
there is still someone writing on other side of pipe. `pipefail`
propagates that error up to kconfig.

This can be seen for example with:
  # (set -e; set -o pipefail; yes | grep -q y); echo $?
  141

or by running the actual check script in loop extensively:
  ----------------------------- 8< -------------------------------
  function kconfig()
  {
    for i in `seq 1 100`; do
      arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh \
        ./scripts/dummy-tools/gcc -mlittle-endian \
        || { echo "Oops"; exit 1; }
    done
  }

  for ((i=0; i<$(nproc); i++)); do kconfig & done
  wait; echo "Done"
  ----------------------------- >8 -------------------------------

Fixes: 0f71dcfb4aef ("powerpc/ftrace: Add support for -fpatchable-function-entry")
Fixes: b71c9ffb1405 ("powerpc: Add arch/powerpc/tools directory")
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Acked-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh | 1 -
 arch/powerpc/tools/gcc-check-mprofile-kernel.sh           | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh b/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
index 06706903503b..baed467a016b 100755
--- a/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
+++ b/arch/powerpc/tools/gcc-check-fpatchable-function-entry.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
-set -o pipefail
 
 # To debug, uncomment the following line
 # set -x
diff --git a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
index 73e331e7660e..6193b0ed0c77 100755
--- a/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
+++ b/arch/powerpc/tools/gcc-check-mprofile-kernel.sh
@@ -2,7 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 set -e
-set -o pipefail
 
 # To debug, uncomment the following line
 # set -x
-- 
2.47.1


