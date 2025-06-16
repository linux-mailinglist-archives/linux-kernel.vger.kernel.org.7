Return-Path: <linux-kernel+bounces-688901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD02ADB8A6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 20:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8C13A964D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jun 2025 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E25289372;
	Mon, 16 Jun 2025 18:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OpaF8pqh"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B23E1B4231
	for <linux-kernel@vger.kernel.org>; Mon, 16 Jun 2025 18:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097736; cv=none; b=n29KF9shSvQABYwlm9psa+DwjY4MBtCrK5RnwrVjE9ejL5brE/GlPkxuqHx9OwrgaWqAx6dKsNDs2eDOBYlTsljM6oxL2+BOaEeMtwP2R9qn+3ZTetQYLETAvGC0ptNy7kbl6qOqvnY5JGA37gXE8unDQSiVArwixcLdmLMUMhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097736; c=relaxed/simple;
	bh=E1ZIO9BFrLWcgct8qP07+TcvpjAKRQ1ZjdkzQYhno/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMStr65t4DOd5wmBmuUSMfOX50egx/S3r2F1JixgM3uTBO1FbuG+2pzD2FU2148cTgnKOY2C/gtKbIbAlut/dkEC+eowp+F35acFY3KGzLKBaQcf4YklSH//kfrdtn+TTsDjHql8hJBpOwXZFvNjmYHzp+TCjb6m7ccM5uTlsyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OpaF8pqh; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=psYij8s9Ia2uYH+3eeL2z0De96IT8g97QGXw+98uT8g=; b=OpaF8pqhsEEyn/YUt8Ls0rCWPP
	Fex+nlV8DsU7HvGjjEPobjGnW2KFYWfiw0vUnYH9hxr+JYmdsL7YWI/70HX39eTl1+ZfUY2ZOLmYV
	T0+Hvx6FkVrmAZd114MFj78urHM5fGMqSF/2tB1g+/jWhLvwHezAfsrtUIU+UCv1mPGjbyTOsdi9x
	S+cpiHUKFnFxwKsVbpWqVrn6uRqVzK3kAOkNCKesMWc5tJMXEzLGEWRLyXsFOW9FN3bR/N9UuSphF
	IynfJs/xVwMTF8oy6zrenXhytgRCSolV/Rhxhw+LOVeG+75Hm6bUALPZUzOI4QK6fTmcFqb+13o9f
	vLq32qpg==;
Received: from [191.204.192.64] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uREMa-004Eh6-4E; Mon, 16 Jun 2025 20:15:20 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: "Alex Deucher" <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	siqueira@igalia.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	"Raag Jadav" <raag.jadav@intel.com>,
	rodrigo.vivi@intel.com,
	jani.nikula@linux.intel.com,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Krzysztof Karas <krzysztof.karas@intel.com>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	amd-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v8 1/6] drm: amdgpu: Allow NULL pointers at amdgpu_vm_put_task_info()
Date: Mon, 16 Jun 2025 15:14:33 -0300
Message-ID: <20250616181438.2124656-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250616181438.2124656-1-andrealmeid@igalia.com>
References: <20250616181438.2124656-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Allow NULL pointers at amdgpu_vm_put_task_info() as it common practice
for "put" or "free" functions. This avoid an extra check for NULL for
callers.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
v8: New patch
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3911c78f8282..dadf5633476c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2447,6 +2447,9 @@ amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)
  */
 void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info)
 {
+	if (unlikely(ZERO_OR_NULL_PTR(task_info)))
+		return;
+
 	kref_put(&task_info->refcount, amdgpu_vm_destroy_task_info);
 }
 
-- 
2.49.0


