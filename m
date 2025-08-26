Return-Path: <linux-kernel+bounces-786410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3061CB3596B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 11:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0496F173C27
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 09:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B0F31984D;
	Tue, 26 Aug 2025 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JMAV8Hy3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C730C2D7381
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756202011; cv=none; b=sPQKEuR6/nUn4O8cyNTMG8w6NHZr/0mIxUU9CQxj9kQSNI4sceGKvsrClDJX4tO+LxzdKtxmOVCQNKLlr8+wyiy606DZSyDe4TPAM+wNORO0zSzqROYsoZE85an6q4151XPr2sELV5hIgFGOI4HAprCvde7M/XaZ/TBB2bGbwx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756202011; c=relaxed/simple;
	bh=XZnHeu0+ZKqYbkI7xl/aYke543F+ASHJUC2mKlaXB2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=oaCAJ4iEoXSr5p66X8zSVe/GNSDufhmqMI9WPsCETmo1j8K8LnqIHkAldctLUIPmS4N39WGGma7zBeh+kOjL12/IHYKQE9OXVuvQce4ElqLEsQAovMJPUHku71BLrWcnc/cmQFB0QUy4GGJmBKFaV1d+BnVknYn0aKJshcDeg8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JMAV8Hy3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756202008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+94yg2WMuvOWorZ2H1VXwoA0FOZey/3GaK3Gs0XnqNw=;
	b=JMAV8Hy3sWwJO8vVKWS2r04brTVCBy+4CzQPtI9EoNfJrlja3f2ZpTiPsm/x0Z1yaCDQgH
	OT5YJGaftJUhfV69nXl9J5q4n99nH6rKGBpMjDCB9/qDi5ttlzZCiez6HDQ0mMU1wKsoUr
	+8Wc3quuMN1wCuB1irUoLn5ewo1yPSo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-106-ppPB3tmSODOKwXTA3zSBPw-1; Tue,
 26 Aug 2025 05:53:25 -0400
X-MC-Unique: ppPB3tmSODOKwXTA3zSBPw-1
X-Mimecast-MFC-AGG-ID: ppPB3tmSODOKwXTA3zSBPw_1756202004
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 686C3180035C;
	Tue, 26 Aug 2025 09:53:23 +0000 (UTC)
Received: from t14ultra.redhat.com (unknown [10.44.32.16])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E0D661955F24;
	Tue, 26 Aug 2025 09:53:19 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	jstancek@redhat.com,
	linux-kernel@vger.kernel.org,
	joe.lawrence@redhat.com
Subject: [PATCH] powerpc/tools: drop `-o pipefail` in gcc check scripts
Date: Tue, 26 Aug 2025 11:54:34 +0200
Message-ID: <e8c743dfb16c6c00fd793d7afa6eed33c49f895f.1756202009.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

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


