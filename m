Return-Path: <linux-kernel+bounces-608333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B0DA911D8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 05:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325D1190770B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Apr 2025 03:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F13135A53;
	Thu, 17 Apr 2025 03:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="MhfbGW+m"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150C31CDA2D
	for <linux-kernel@vger.kernel.org>; Thu, 17 Apr 2025 03:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744859257; cv=none; b=OOXFoT26MbruefUX/nMj3IFZ2kAcv7pzF43qfZuBpC+AtHLVOYn8KxkhaSL4sKqVevNAdqhpnF91ZBq+3j/Lfzzd+jwR0R67bUV5Gna1T1JQIOZb2WhJfkIOQIy/B5Bnr3cBhh/Aoryp/3aVJpdKromLrqgFRMsLbVibnu8ljrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744859257; c=relaxed/simple;
	bh=Olvq+VqDE6GxPFnA+c0/JsFYtG8V46GYmuP83/I6sTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ngHrNyCuSYK0IRo3zFbcxf4is7iqju4yXedXbnlHJLQUjM1lZ6oIA3mnhYfOpS9ZJk2HAJr7gDae3kxOOWTRHGHrckULPxkyNgItdmNWhOTNzA6cuJOHOdE3X9ZrVRh8K9vzyLg3UTtyIxpWQdvC2LPdzYs1H5bmJ5tAyw2YuJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=MhfbGW+m; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1744859253;
	bh=Olvq+VqDE6GxPFnA+c0/JsFYtG8V46GYmuP83/I6sTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MhfbGW+mGYgGZysZei2w7yITNQHTf+oN6HCRJstLDpUA9u/89JUxsbnBCS6Kg52vm
	 qtcrvbBJRryJ4eeNEUtgKKCJMGOLLXutgvPS6shvuVnRdNsq5Ayh0jluTkKkTsNH6N
	 vuL5Vz8TmsvXz16Ye7XABfTG8u3vBPZcWTUe+GRe0ltu5bFWkj7nmH6MXVjoK5G3bV
	 e8hFtoIVRdD0KTDa88sgXBg+r7bfbkg2IrH98OLDNEU53R2SM4V850xI2DoBuuw+s1
	 S1TKpkyBJ26kXsYZ3DcDZmKIDLiLzqporGbT72f3X4861rbg2ky7xHUZSpLgjJmyT0
	 bqmgjeX4LrSwg==
Received: from debian.. (unknown [171.76.80.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 429A717E155C;
	Thu, 17 Apr 2025 05:07:29 +0200 (CEST)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	daniel@fooishbar.org,
	helen.fornazier@gmail.com,
	airlied@gmail.com,
	simona.vetter@ffwll.ch,
	robdclark@gmail.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	valentine.burley@collabora.com,
	lumag@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com,
	quic_abhinavk@quicinc.com,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] drm/ci: Add jobs to validate devicetrees
Date: Thu, 17 Apr 2025 08:34:34 +0530
Message-ID: <20250417030439.737924-2-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250417030439.737924-1-vignesh.raman@collabora.com>
References: <20250417030439.737924-1-vignesh.raman@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add jobs to run dt_binding_check and dtbs_check. If warnings are seen,
exit with a non-zero error code while configuring them as warning in
the GitLab CI pipeline.

Signed-off-by: Vignesh Raman <vignesh.raman@collabora.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---

v3:
  - Add dt-binding-check and dtbs-check jobs to the static-checks stage.

v2:
  - Use LLVM/Clang instead of GCC to avoid architecture-specific
    toolchains for cross-compiling.

---
 drivers/gpu/drm/ci/check-devicetrees.yml | 44 ++++++++++++++++++++++++
 drivers/gpu/drm/ci/dt-binding-check.sh   | 16 +++++++++
 drivers/gpu/drm/ci/dtbs-check.sh         | 19 ++++++++++
 drivers/gpu/drm/ci/gitlab-ci.yml         |  2 ++
 4 files changed, 81 insertions(+)
 create mode 100644 drivers/gpu/drm/ci/check-devicetrees.yml
 create mode 100755 drivers/gpu/drm/ci/dt-binding-check.sh
 create mode 100755 drivers/gpu/drm/ci/dtbs-check.sh

diff --git a/drivers/gpu/drm/ci/check-devicetrees.yml b/drivers/gpu/drm/ci/check-devicetrees.yml
new file mode 100644
index 000000000000..75c9b009da1f
--- /dev/null
+++ b/drivers/gpu/drm/ci/check-devicetrees.yml
@@ -0,0 +1,44 @@
+.dt-check-base:
+  stage: static-checks
+  timeout: "30m"
+  variables:
+    FF_USE_NEW_BASH_EVAL_STRATEGY: 'true'
+    SCHEMA: "display"
+  before_script:
+    - apt-get update -qq
+    - apt-get install -y --no-install-recommends clang lld llvm python3-pip yamllint
+    - pip3 install dtschema
+  script:
+    - drivers/gpu/drm/ci/${SCRIPT_NAME}
+  artifacts:
+    when: on_failure
+    paths:
+      - ${ARTIFACT_FILE}
+  allow_failure:
+    exit_codes:
+      - 102
+
+dtbs-check:arm32:
+  extends:
+    - .build:arm32
+    - .dt-check-base
+  variables:
+    SCRIPT_NAME: "dtbs-check.sh"
+    ARTIFACT_FILE: "dtbs-check.log"
+
+dtbs-check:arm64:
+  extends:
+    - .build:arm64
+    - .dt-check-base
+  variables:
+    SCRIPT_NAME: "dtbs-check.sh"
+    ARTIFACT_FILE: "dtbs-check.log"
+
+dt-binding-check:
+  extends:
+    - .build
+    - .use-debian/x86_64_build
+    - .dt-check-base
+  variables:
+    SCRIPT_NAME: "dt-binding-check.sh"
+    ARTIFACT_FILE: "dt-binding-check.log"
diff --git a/drivers/gpu/drm/ci/dt-binding-check.sh b/drivers/gpu/drm/ci/dt-binding-check.sh
new file mode 100755
index 000000000000..5e9a439c48a4
--- /dev/null
+++ b/drivers/gpu/drm/ci/dt-binding-check.sh
@@ -0,0 +1,16 @@
+#!/bin/bash
+# SPDX-License-Identifier: MIT
+
+set -euxo pipefail
+
+if ! make -j"${FDO_CI_CONCURRENT:-4}" dt_binding_check \
+        DT_SCHEMA_FILES="${SCHEMA:-}" 2>dt-binding-check.log; then
+    echo "ERROR: 'make dt_binding_check' failed. Please check dt-binding-check.log for details."
+    exit 1
+fi
+
+if [[ -s dt-binding-check.log ]]; then
+    echo "WARNING: dt_binding_check reported warnings. Please check dt-binding-check.log" \
+         "for details."
+    exit 102
+fi
diff --git a/drivers/gpu/drm/ci/dtbs-check.sh b/drivers/gpu/drm/ci/dtbs-check.sh
new file mode 100755
index 000000000000..91212f19fb98
--- /dev/null
+++ b/drivers/gpu/drm/ci/dtbs-check.sh
@@ -0,0 +1,19 @@
+#!/bin/bash
+# SPDX-License-Identifier: MIT
+
+set -euxo pipefail
+
+: "${KERNEL_ARCH:?ERROR: KERNEL_ARCH must be set}"
+
+make LLVM=1 ARCH="${KERNEL_ARCH}" defconfig
+
+if ! make -j"${FDO_CI_CONCURRENT:-4}" ARCH="${KERNEL_ARCH}" LLVM=1 dtbs_check \
+        DT_SCHEMA_FILES="${SCHEMA:-}" 2>dtbs-check.log; then
+    echo "ERROR: 'make dtbs_check' failed. Please check dtbs-check.log for details."
+    exit 1
+fi
+
+if [[ -s dtbs-check.log ]]; then
+    echo "WARNING: dtbs_check reported warnings. Please check dtbs-check.log for details."
+    exit 102
+fi
diff --git a/drivers/gpu/drm/ci/gitlab-ci.yml b/drivers/gpu/drm/ci/gitlab-ci.yml
index 65adcd97e06b..ac2f498cfe5a 100644
--- a/drivers/gpu/drm/ci/gitlab-ci.yml
+++ b/drivers/gpu/drm/ci/gitlab-ci.yml
@@ -108,6 +108,7 @@ include:
   - drivers/gpu/drm/ci/static-checks.yml
   - drivers/gpu/drm/ci/build.yml
   - drivers/gpu/drm/ci/test.yml
+  - drivers/gpu/drm/ci/check-devicetrees.yml
   - 'https://gitlab.freedesktop.org/gfx-ci/lab-status/-/raw/main/lab-status.yml'
 
 
@@ -117,6 +118,7 @@ stages:
   - git-archive
   - build-for-tests
   - build-only
+  - static-checks
   - code-validation
   - amdgpu
   - i915
-- 
2.47.2


