Return-Path: <linux-kernel+bounces-778823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C97EB2EB9F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 05:04:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A875E6D07
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 03:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C455F2D877E;
	Thu, 21 Aug 2025 03:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a2mJC9yt"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6A61DFE12;
	Thu, 21 Aug 2025 03:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755745311; cv=none; b=Pzmw+yUz9vjt1pR2EFTcDtpj2mttZgksswE4p9Yq0zAw2C1110qgf2m6NoDvZjQ9H9SLJrGXw0G8xya2z7Tm+3bogsatbmuXLajm24HvR4wPNRquLXBXPnyDb2zam/1+HILIF3lVI1WSKyGCFWKrie9P2XciPtb4BxVxWMhQutM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755745311; c=relaxed/simple;
	bh=Jcs8Ws3m0JKE+7LCfB29ysWJC1gnGoNZf1A7NqIoPzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LVkDa7wzeJzuHam4vQSSrJh4pvV/wmE+ssO4uKqaE8YZcrt0rrwLkRVXrXrk1GjMyjOrOwoPZ7J/ahy8tExF1BU+ANpyPXN3YHWsPZUxOBQJ/zzcxyNTodvhpc/Zg8AKJv5hJDRwEOk7T0KtgeTiavSyCfvHQX3GBQnXWPqoFtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a2mJC9yt; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2445806df50so4565445ad.1;
        Wed, 20 Aug 2025 20:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755745309; x=1756350109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dchl2bUxkqbgVtu+uy7PwD6R4U4jQS+j2652EoPkofQ=;
        b=a2mJC9ytUlfmyYbwIdjD0dIPCjy/L80pmKgubiAWTeMmyxIRZ8DBsGg8ah0RbVeDPq
         td57bfNye5kGRKfXZuj2FgkOR9V9luHAoeBgEbknkgdJvzbK5zWCb9d7eFXqFUv5SOtM
         EYj+xR5XNgaZl6ASfGGxptGUvYHx9DB2ZLNFKuxQCCeOSN7tqaM3fQ8LDFup6ImxRHRn
         iDlJSz9hPCJZCG9VprPpblosnW9OFgOju4BMqvdwc7aWKxT73eQG31YSaMBzEjeCyrfu
         sp5lLjzA8A2S+NsNUPEnVqgleZQRKr9kpHt4+8Epw72G/LydJOErn/xDWQThV97NM3gE
         xalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755745309; x=1756350109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dchl2bUxkqbgVtu+uy7PwD6R4U4jQS+j2652EoPkofQ=;
        b=RSNTOsPmTgOLWep3m/S1svMHLh0r2gLqsIpfhwK3gDOG8AxXdXuqtyBiOD/WN1wtYB
         2Ib+tPMOt2yw0Xq46v6AABdoFtbv2u/R/BV8rzWbmAxqVdLQDY1Lhi9NG/5w1V+lXw9i
         qBPY3bW14KGPL2EmTVhJ2Nx97FVG/OkNEwbVfYOFQEXHO8Ht6ltzUg0aJ5bwVZGqZypL
         6MmUcP3YcCbQEqGLT5LhVID5kuxgnVKajlFIOZKD1ojm3wWuLBIW8d6E61p4JFdSlIwI
         cT/bT8fy9qLFv+Kr2h15KPChuQc59oAQfmzUAGTzF1KhkKBvAkTId83K+YZm1eeg5oEG
         MCmA==
X-Forwarded-Encrypted: i=1; AJvYcCUbYwrlOxjXDCBQhFufl6gOsOl0Q+fof82AO5Fs2e9JJM+dNaUiuDONG0x/p5Hi5qsXIEwHv+4vxOF+Hd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcNAl7mONpspSTyfBG7MXZ+wRTLejA6szeuePHCklVg4JtrI4I
	8x23TQuvUS/QFTieG60VehrVFHRL7Mj6IN0i5CzitXww25IraAqIkXDYI23ZsyZB30c=
X-Gm-Gg: ASbGncvcblgmu4nSHY0Wi69VQwmci1OERZgT3XV6dcr4ROfIcGMXiUT2J/wBfW4Xmmo
	Jqu2M3tJDRjEXMIbL+vBRjQR8ls1zlhDR25jqhYMSy6Vt3DV+GXKfkCNlO8fcv0EV61ViQ3alBA
	Mf+tLUWC97075eZPkh4v1VK0nZ2nCsyg22furwCzy2W4dnRP/WBhTr3RhCxvnsxeUmu4g/nWENz
	+LiAgV4GHsFIT0VTnYzjbQ1NHPjRRWGcVskoJCJffYh3ZTYyxUT04IKwE0JVGyEDJVbmufCXltz
	qUSoZBUUltn5kXchKUGeoGW4MjSB5YSQ1KygvFiY0oUtbwGPh+Auud2M7ffZdbKpLbyMnoDqzKW
	ZT58mt0lovh7wxgsFfT1FUECcnyI=
X-Google-Smtp-Source: AGHT+IHsGc+xADnS1KQl1Eq0/IUY+3ItHxMypYdEF+dKr5ceq+9PZoCw5+c5P8t1BY/0NJT8/0dLRg==
X-Received: by 2002:a17:903:384c:b0:242:e0f1:f4bf with SMTP id d9443c01a7336-245fec053e8mr11669045ad.18.1755745308564;
        Wed, 20 Aug 2025 20:01:48 -0700 (PDT)
Received: from lkmp.. ([49.37.161.210])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4c73f2sm40160695ad.94.2025.08.20.20.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 20:01:48 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: linux-doc@vger.kernel.org,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	airlied@gmail.com,
	corbet@lwn.net
Cc: tzimmermann@suse.de,
	mripard@kernel.org,
	maarten.lankhorst@linux.intel.com,
	simona@ffwll.ch,
	siqueira@igalia.com,
	harry.wentland@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	skhan@linuxfoundation.org,
	rakuram.e96@gmail.com,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Deucher <Alexander.Deucher@amd.com>
Subject: [PATCH v2 2/2] docs: gpu: Fix spelling in gpu documentation
Date: Thu, 21 Aug 2025 08:29:56 +0530
Message-ID: <20250821025957.22546-3-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821025957.22546-1-rakuram.e96@gmail.com>
References: <20250821025957.22546-1-rakuram.e96@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed following typos reported by Codespell

1. complection ==> completion
   implementions ==> implementations
In Documentation/gpu/todo.rst

2. unpriviledged ==> unprivileged
In Documentation/gpu/drm-uapi.rst

Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Alexander Deucher <Alexander.Deucher@amd.com>
Signed-off-by: Rakuram Eswaran <rakuram.e96@gmail.com>
---
 Documentation/gpu/drm-uapi.rst | 2 +-
 Documentation/gpu/todo.rst     | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

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
diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index be8637da3fe9..1d064e617699 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -319,7 +319,7 @@ everything after it has done the write-protect/mkwrite trickery:
 
       vma->vm_page_prot = pgprot_wrprotect(vma->vm_page_prot);
 
-- Set the mkwrite and fsync callbacks with similar implementions to the core
+- Set the mkwrite and fsync callbacks with similar implementations to the core
   fbdev defio stuff. These should all work on plain ptes, they don't actually
   require a struct page.  uff. These should all work on plain ptes, they don't
   actually require a struct page.
@@ -854,7 +854,7 @@ Querying errors from drm_syncobj
 ================================
 
 The drm_syncobj container can be used by driver independent code to signal
-complection of submission.
+completion of submission.
 
 One minor feature still missing is a generic DRM IOCTL to query the error
 status of binary and timeline drm_syncobj.
-- 
2.43.0


