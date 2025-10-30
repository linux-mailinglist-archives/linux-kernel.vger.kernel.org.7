Return-Path: <linux-kernel+bounces-878456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1DDC20AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27CA44EF806
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65062765C3;
	Thu, 30 Oct 2025 14:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T9btayFM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D86274FF5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 14:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761835071; cv=none; b=BZEbqyCd4OlNn6/CtS/3p09YW+r05lJ72EUpl/FEO/iuBKmjWgl/UIG4z7QpHlrZD1TMnwEeKNzT5Vtyv4AG7K8ZuHITDdeU651UAan3ff2oW+1pd701hwlkR9dC1zG9Hv+RFkFLwo5xNyA7lYWNRBjepGdUy56fSY4r5sdjoBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761835071; c=relaxed/simple;
	bh=uiL/+HWIqkPDhLYnB+bmPpKcGNU/horgbRhtuBxsmro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rZILrJMzpVGzMaG6+x1UOoxwSiL0gN8PTGEa5AMwtQl+0V1mbThU83THi2VmUE4DzvlfMtDQHOg895q1rQMnQdbkmaFDfE+6OwX2FTUzQo2+9CeED/yrT433doonjJqP4ptWdx4cE/WLfafKYsjsCC7b7RSbVYbtUrnnW9MZESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T9btayFM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761835066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nkks9IPPTiRjudJKz2fy8ztuwHSVrBIwR6A4uWG3RWI=;
	b=T9btayFM6OTU3QzLpfDQvLHmgt6HpCK5NBJwNRu+iSvTsvqzWjUqA2UDxbPQ8XpoyMCo6x
	HfdukYCh9q5fkMiSHvGj46tHiBqaiRXv0zp9Msvs1EJKewkF8VvwiTo7VVxe060QihcGK+
	aVAo7A17OaeY8n6bpel1ThXiJ5bR35M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-RtprW2XSMy2w8Q9cn_6Ikg-1; Thu, 30 Oct 2025 10:37:44 -0400
X-MC-Unique: RtprW2XSMy2w8Q9cn_6Ikg-1
X-Mimecast-MFC-AGG-ID: RtprW2XSMy2w8Q9cn_6Ikg_1761835063
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso1051747f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 07:37:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761835063; x=1762439863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkks9IPPTiRjudJKz2fy8ztuwHSVrBIwR6A4uWG3RWI=;
        b=oKNFhNLd1yW8IiFPjxjVEjUcoyaAdOd0fOzWe0qCYx/pxgNjmpyHe8SbNJoZus0dak
         0M2OxEXBHTgxh9DzKAgfuaFzwi41KgMMcXU+uEsn745EQkvoNCgc2/WxbK04v2n3lChf
         EUcvokw5tpX60VH307ue7YsGxKW90IFeNchmulroosUaiw7Utg7cLbyv9tSmXDYtJJlq
         +270uX7lKj4bAumM43kqaeRAwdJL+cIZNNi9A5CEm1+Jgv1JR93JOd3BjXAH3zcnk9MD
         h0jV2Ct25UPTv3X7AV21Jd1zuw/J0t/7iOSUvd5wDwfCxD7nQJN5fe8/K0Fobq+LYGoa
         5Rsw==
X-Forwarded-Encrypted: i=1; AJvYcCUFux0usJr/08Kj8b8Zvjnvk0i8uEfYrCv9ZJnfDkp9nRhYZz7kjZC7XsO5P7QvTkqkjLjnSfWfxtsOXug=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNZFMHlh9RmqYfSaJ1TICTbZT9y/HkOXSJoRj9rk1AJDLPC8rl
	M+9sHNLfVzJHIujZjQCxUadNOX1+1s1+YOiroCYPkowY/r0x4FaHVVpXgdVGsMdSosnFepHRaIz
	hI7dTogC5+5Wb1NBcVKJkBATJUDhmnyq1vSPXMjqVRwxDV9WItgNKZm+4YPmEzr8+pQ==
X-Gm-Gg: ASbGncuHDEQHneRfbC7w1E9a9O8N/CBvGLJJBn8vofG3AAqfl/CCaHnQgHHId2+db1y
	294QwRhTOG9AefNLQhnQWF0a03vp6/OEVryc2qa0FOukp1HtJKQA9ykAUBzl24TQhz3fSS7IY5A
	TZK76WcgXZEIAzr5a07FhJzoh9U305DoS9fWm94vZJnZyyZec2h0mvWVLpSUaUTsK6XaaEyi51R
	pscLYlCHSu1atEiytv+yOfJTuUz2herQR9C1xG31eK/gZaWIp2x+gSLFt4UE0uSJNUS2AM1tsd1
	hi6+eZK8zA8kjwmHX5NAZxKN4FwjTkgwqaNQjCQ04kv88VSP60Y2bspY4FK5br7vTBnaQkEQ1GM
	OSsmbfF52kqeiOoTp4qQhPv3ptN/AhHi+7Uyc1aqJ0kX0LI7k
X-Received: by 2002:a05:6000:1449:b0:429:b963:cdd5 with SMTP id ffacd0b85a97d-429bcccf0aamr87213f8f.5.1761835062918;
        Thu, 30 Oct 2025 07:37:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH4Hb1Zr2+1H9F1aQQVjn8swQhMlyoOrBtrdyyo6F0SLZbU4syUP2hFz8P5UzKpetZ1C9iD6A==
X-Received: by 2002:a05:6000:1449:b0:429:b963:cdd5 with SMTP id ffacd0b85a97d-429bcccf0aamr87184f8f.5.1761835062481;
        Thu, 30 Oct 2025 07:37:42 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen12.rmtde.csb ([2a02:810d:7e01:ef00:1622:5a48:afdc:799f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a94sm38472105f8f.5.2025.10.30.07.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 07:37:41 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Austin Zheng <austin.zheng@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	waynelin <Wayne.Lin@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Jun Lei <jun.lei@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Leo Li <sunpeng.li@amd.com>,
	Rodrigo Siqueira <siqueira@igalia.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] MAINTAINERS: adjust file entry in AMD DISPLAY CORE - DML
Date: Thu, 30 Oct 2025 15:37:37 +0100
Message-ID: <20251030143737.136120-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit e6a8a000cfe6 ("drm/amd/display: Rename dml2 to dml2_0 folder")
renames the directory dml2 to dml2_0 in ./drivers/gpu/drm/amd/display/dc,
but misses to adjust the file entry in AMD DISPLAY CORE - DML.

Adjust the file entry after this directory renaming.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d739e18aab6..7031ee1e7cff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1080,7 +1080,7 @@ M:	Austin Zheng <austin.zheng@amd.com>
 M:	Jun Lei <jun.lei@amd.com>
 S:	Supported
 F:	drivers/gpu/drm/amd/display/dc/dml/
-F:	drivers/gpu/drm/amd/display/dc/dml2/
+F:	drivers/gpu/drm/amd/display/dc/dml2_0/
 
 AMD FAM15H PROCESSOR POWER MONITORING DRIVER
 M:	Huang Rui <ray.huang@amd.com>
-- 
2.51.0


