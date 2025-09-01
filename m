Return-Path: <linux-kernel+bounces-794517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4247AB3E2D4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C048F1A8342C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577D733A011;
	Mon,  1 Sep 2025 12:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYVMklMI"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994C3376AE
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729575; cv=none; b=igtSPGNOCE0THucv7boOOLFW4oYjZ8gMzTKgZR8dfRlNQrdCrFZLxEfG2MSXilFyOhZWWhqmXq7TQxlP/oxOXXYvnNeU9oIU319Ivh2x4GlWCIfWIidnidJAbB7ISZfe6RJwx+4uITEOLeB+KjehhjXgUbMGCMPVGMqQLzR+uaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729575; c=relaxed/simple;
	bh=JGP5rkJhi7rwbgiBgeBDI87RnZKwD9MYWHswkx7G6iI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBgDkttFVghF/8Cq60tobJ72jrGfor1d8OUShvthiDI3sjV/pn3KklOMRnwuMD0QY20f8HWZJ9i+Rqg8cIHvUeM4SlWE37G8lE4FDCEExBMCD/OCIei4KhHkc7LbfbeJNf+zY/mFBLFmerPdFsy65KDb1wZzQ1a7eTiAW5wXLho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYVMklMI; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45b77f59bd8so24527215e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729571; x=1757334371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3dM96E55Q2d+IuiT1HFvvKMogR+YhmA24qq/y8oh26w=;
        b=gYVMklMIO8RKC+ezpRTEqQ9p8il9qmgOMU7lj13zLjgz6EXpnNT1kYitunawflK/oS
         DL6p5ZXlpIdXIr52seXaFcXaBwveDwfbzzTOHPXh/vEE4JbxU2ZkdbGq5Jw2lsHLwoOa
         u6eifbwle3+e++AaFFUZye0vUIymrSwnT1d9zLmq73dQBrsx2dP/TU1JURmmTMpl9sO0
         0JWLDltYdmUrb7ZskPpUZgKFPmXRNPalXqWAdMaXBF+lrDELrwohrsaFBAhCk2fRVulq
         GEy5A5sLGb2MJKVjw+iSJ25MOwcLLhGiO3DbWzfWPW4gJ6cSHYMIaNKc3K6a7PQ09wQd
         zxzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729571; x=1757334371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dM96E55Q2d+IuiT1HFvvKMogR+YhmA24qq/y8oh26w=;
        b=af/KErUAKn5KECEjNsDBdI48fROvCq3Cybtkrbi8ppSMnfxezwWkOKCGwhNjFBVcqP
         OvZvrkVJyz9mBBJc3QaFhr6GyB6FKubF0Tq/3DGCzDLvP5zRRrWWB8ELqYNvTk5DE8Om
         hkdt9udGvBmCyLfnRSZFZMElJ3l0TJ7ddAIhuqh+OASi7/3CBwe3ILqwcgxExVFMSCWJ
         PGClCGwKp7aFWCEaghyNXde9SLbmdegampz/wljP6+ffvjivb5Z55Z+L70ScfEWCV+V1
         uob+UYECOjNfQUTMWK0a+y+qXPEta7rJERIjq4zilQxl+1AxtySGV1fFlOu2DgFQRhlg
         IlvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcMkE+w3xJAmft/UniSjUQZWdUgeWZBZZSjGufk+XDbr95SfGF75riFA7fH1uQ18SGgWy7CI7yz0QBckA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaOY6SPElSYSFTtJcMBXRCfPNmn+VduNMJ5n7PcOYlgV01JRVM
	obDRRbLP6Mc/y2+QJ9v/MkQ0yiBc4MzF8sCIb+BIsHbf1HWT8g57suSA
X-Gm-Gg: ASbGncuJaoMMVn8uaZsXyqsvPBPQZiCMR2FLSgaGIIf/0rFTjEQzmDtMDOBC68wh/MC
	78ti3gom6xjB4mW2IVsInVpIy+sn3kLVE8oGHTV2Z2mDUZQWuKAmMLzevGBfN2UTbYYPIT8V3gR
	ta0bFy6NeQ/RA3cLRPsVIlXnUPvojjqouTJ8Pos+wbY3mJijLMgyP0l9cw4veFnvg76Sptptq+D
	9ks8j9lzzZpqLJit5v2blH2AUU2ufot3l/NIbNxob9u6776i8x8B3+ER5mNwlxjYliHe+RLLua4
	NhXgVA5BzcTdRAXdRpmBjnMCZnfxjNlBfbZTXyMY9O+So/KvCiQO0WrFQ5Cr46PVIDiyQO/bu4v
	LudqFsrkgmsy/kfjq1w==
X-Google-Smtp-Source: AGHT+IERl739fULguTB8wwYqhn80dq/ta43RUTSs6JPhZjlt4LfeVOI7iahJopxrHeUJTf3jhOn4PA==
X-Received: by 2002:a05:600c:1f96:b0:45b:7510:4042 with SMTP id 5b1f17b1804b1-45b84c65642mr76911685e9.17.1756729571065;
        Mon, 01 Sep 2025 05:26:11 -0700 (PDT)
Received: from fedora ([94.73.32.0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b74950639sm207297055e9.17.2025.09.01.05.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:26:10 -0700 (PDT)
From: =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To: louis.chauvet@bootlin.com
Cc: hamohammed.sa@gmail.com,
	simona@ffwll.ch,
	melissa.srw@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	sebastian.wick@redhat.com,
	xaver.hugl@kde.org,
	victoria@system76.com,
	a.hindborg@kernel.org,
	leitao@debian.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>,
	Mark Yacoub <markyacoub@google.com>
Subject: [PATCH v6 13/16] drm/vkms: Remove completed task from the TODO list
Date: Mon,  1 Sep 2025 14:25:38 +0200
Message-ID: <20250901122541.9983-14-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250901122541.9983-1-jose.exposito89@gmail.com>
References: <20250901122541.9983-1-jose.exposito89@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove the configfs related TODO items from the "Runtime Configuration"
section.

Tested-by: Mark Yacoub <markyacoub@google.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 Documentation/gpu/vkms.rst | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/Documentation/gpu/vkms.rst b/Documentation/gpu/vkms.rst
index 31a3880ad83c..364b574a8cae 100644
--- a/Documentation/gpu/vkms.rst
+++ b/Documentation/gpu/vkms.rst
@@ -233,21 +233,14 @@ Runtime Configuration
 ---------------------
 
 We want to be able to reconfigure vkms instance without having to reload the
-module. Use/Test-cases:
+module through configfs. Use/Test-cases:
 
 - Hotplug/hotremove connectors on the fly (to be able to test DP MST handling
   of compositors).
 
-- Configure planes/crtcs/connectors (we'd need some code to have more than 1 of
-  them first).
-
 - Change output configuration: Plug/unplug screens, change EDID, allow changing
   the refresh rate.
 
-The currently proposed solution is to expose vkms configuration through
-configfs. All existing module options should be supported through configfs
-too.
-
 Writeback support
 -----------------
 
-- 
2.51.0


