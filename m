Return-Path: <linux-kernel+bounces-793465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A81B3D3E3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 16:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09DDF189D2A9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 14:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DDC4315C;
	Sun, 31 Aug 2025 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMRx5My1"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0977261A;
	Sun, 31 Aug 2025 14:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756649736; cv=none; b=jC6PFEHdsjtO9qvYJaBf2Yz+BtSd3HvjqchiqVyNE2quMK6FO/3fj2EqJyMz0SnoHzTUINHDFOYfeFw1JNwE4cz6xtGmkBbHpL336jPn9yedAL7pcCUXugvb+hKgqkimnikioUK8CgUjxNQCSm13Yx+8GEI0K62bQveahH3Z5Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756649736; c=relaxed/simple;
	bh=Kd/gX5fjRhUyfF8lcZ2fmkUcEqn0Q7e5V2RHg3ZIw9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y+lDXEsGH/BeUm2ORJdj1Og6xQCsJGBFveP5Ujgg61HhFxXemlUb0b0A82MoHRrdbPMkMIBtEcY55HMj6gDd0dURdB211HmRnoOnPIpem2eJUTP3TB/forkpe3s5QEmC5NcHmkHB+2S67AcvP/yx9d0puNaj4x2d4E5IZjkzePE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMRx5My1; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24456ce0b96so37103025ad.0;
        Sun, 31 Aug 2025 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756649734; x=1757254534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HT2tnFXLGodr/Ol/iLDsu6bZVkZa/3lt411uDOwsk1A=;
        b=UMRx5My1eEgAOpAGcf24JK0Z3uOsTeo5j4tRDDYvGpVeW9nC+adT0sZOoQ6HnbaofL
         qV0+KmQ7vpIQph/Kll3UVIXrxXMJmOo5JlBZGsaS5MNSLGlTiNX5Dfhkr+th9OCsKY/i
         IR/vFvJibg1nuwPoxPJbS92Jqk40gpD5dt2Lt57cM5X5oOa2pO6O9Kn3urmoulmmw7hL
         ZDFpfdP17fiRFba3vAisBmytGEJWphseczviO0Pb5HEzvEHvCX3lHeoU+iXELl9rF2sL
         WIkQmz2FiDwx2XXuuKnABlJcjsRDvsef7oET/Q7ZuVucyYIWihJw+rjYMjsAl3gVCCNY
         FerQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756649734; x=1757254534;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HT2tnFXLGodr/Ol/iLDsu6bZVkZa/3lt411uDOwsk1A=;
        b=ivv0wYGd5p4gdTyXbWyk4lvJrsQSPuSz2c8Kk1iiWduV51SlqrpuFjUjxSlsQ03EEi
         wbeb+PpLWmRPdwxKGdlCf95kXTDn55NZw5erRgUugZ0g8GLmH7q4cywLYgBSPJRlgJsA
         CA99Xu3f9AU8eWqS5Ce1VXGHdf1AtXOmigf3svHSkQdpFW7klTNw3xA6xOheQKNbvn4q
         bBkYaREGLkRtq82hCaAzCKGrtLkP3XD5ihNM57sJC8TUr1Xs0S/khyls3DPmXG+nujS3
         7hxvIFj5emKgoRuih2/xJhXwiSdH0nEhCTZRBGBwUMfgT3itntrIYfEqxjDUP6CrxJun
         hxIw==
X-Forwarded-Encrypted: i=1; AJvYcCU4ClKZp7kn9FBvivbxf9dM9bm5mPN+N6CWJX2le8uldNdNCRYEBU49Wh7UF2RjF8BcRPxteWF9uZI=@vger.kernel.org, AJvYcCU4Hrjn6nUdUBZu69oV1SsDVj5ijYLbtj4dRPMd6wR/YwatID022CRtTIV7gGDoTrYhFlAU5mgktBYAS4ue@vger.kernel.org
X-Gm-Message-State: AOJu0YyP3bXr+R0jJ+ZOIwyQCwGXMrpF2/NhpoldczyQYi3AYi9ywfBU
	Bdk1WmFylo5Oh9s9wHGvn6P5DUFfvFUrU1xynWbNzRVzHHc4zVEkyeCd
X-Gm-Gg: ASbGncsG7zbZ8P7vCY++Y9wQcytBZ89mTnqHgkvIaRVawi9HbLHRJzS1KINNuCrCCo+
	5EqrxMP15+GLH7Y/XMfj74TFoiLIX1cX6M1Es9W/3LuWs86KXX7JBI99J7XDiBKhAw9doYMXB/Z
	zp8KMDc+C2PcNQcw37BNEpbUOu5HvnqtAI0YOB2vf3K5B6Mursw6hEDiJd4TWpi1nO9Az8sRxne
	+QkmYdGiOk5CLEkLXkYL/gmFdZrsvd59R9KJ+ZYAnscauiRzS1pFjPSXg3SJMHfBNZ7yuv7RbCw
	ZTsJvC9lBuj1kKL7bU3ghCIpxXHOA82on5cNlwnQXFpAOHilRZfMVVa3OgedUOyuWQQbASWay4I
	JlrbDZGlrVgmSH5kBIN1yJrN6IyfdX/OMHoLkIf61j1BiTbo=
X-Google-Smtp-Source: AGHT+IFw+ZIS2MKM3bdCIDJ7UFL5l11P9sSsVyLYU1HFxQeGPNi2j5pi/ybo/wZjl06HLWYrWCy3Tg==
X-Received: by 2002:a17:902:f708:b0:24a:acb7:a1a4 with SMTP id d9443c01a7336-24aacb7a5f7mr32595525ad.9.1756649734163;
        Sun, 31 Aug 2025 07:15:34 -0700 (PDT)
Received: from mohin.lan ([152.57.1.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249065a3b67sm78031815ad.120.2025.08.31.07.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 07:15:33 -0700 (PDT)
From: mohin24khertz@gmail.com
To: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	corbet@lwn.net,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Mohin Nadaf <mohin24khertz@gmail.com>
Subject: [PATCH] docs: gpu: fix spelling error in drm-uapi.rst
Date: Sun, 31 Aug 2025 19:45:22 +0530
Message-Id: <20250831141522.7813-1-mohin24khertz@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohin Nadaf <mohin24khertz@gmail.com>

Fix typo 'unpriviledged' -> 'unprivileged' in DRM UAPI
documentation describing error codes for operations
requiring elevated privileges.

Signed-off-by: Mohin Nadaf <mohin24khertz@gmail.com>
---
 Documentation/gpu/drm-uapi.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
index 843facf01b2d..7435664a1ffe 100644
--- a/Documentation/gpu/drm-uapi.rst
+++ b/Documentation/gpu/drm-uapi.rst
@@ -535,7 +535,7 @@ ENOSPC:
 EPERM/EACCES:
         Returned for an operation that is valid, but needs more privileges.
         E.g. root-only or much more common, DRM master-only operations return
-        this when called by unpriviledged clients. There's no clear
+        this when called by unprivileged clients. There's no clear
         difference between EACCES and EPERM.
 
 ENODEV:
-- 
2.34.1


