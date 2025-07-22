Return-Path: <linux-kernel+bounces-740723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 534ABB0D852
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88171560F24
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A561C32;
	Tue, 22 Jul 2025 11:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anvDsLFw"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD9B2E3AF4
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184218; cv=none; b=lfO2ixbE85IxnJcjSk4cpunaXPAQESi0RCZRGeggsf1qc0xSPJP+GLtBsxnYcfqiKbVT78fyOnJtCf0xya3ob4Rwkewa4ig5EWGTleaxiX6daxeJeOIb0V79oe/J5nrzMGfa2lWDvn9PJ4PYDAXoVlhYvLPINW5gV4/vW3ayYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184218; c=relaxed/simple;
	bh=de1qD53yMXyXhMXuwBZ7HDegwT/YLNZw++eYKlRirBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDsMUDXbhsyZFU77y8D7+pOAONa61s5XVdfIclXOdb9o2qCr3GODWpKf6h7wUuCClZ9L5V2vg3n2PTa0b/YEsd6qlq4xFm+lJoP7zWkWEPQ6ZdShDfTf5XRRfSe17N+Sf/6B/tvXExGpq1w8dYZcDE1b0Czskt5f81JCfSRkgrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=anvDsLFw; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab554fd8fbso51203661cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753184215; x=1753789015; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=de1qD53yMXyXhMXuwBZ7HDegwT/YLNZw++eYKlRirBk=;
        b=anvDsLFwlIeDVk87sELIXPi+h1Fi6poicgB/vFzkJ7G1kiL5ykkYjtmYur30pcYSX+
         gipLlQSCvpd3R4D0VpXFhiCFxdJLR2H62RnF8KboHcNUgue3i2OkdIuIYKQNWG0aAdLd
         TH/Sq1SDnosu8rCmi4EbGTi2hbhm3OfpWKE7jXmGLgflz9SsLbCCzk3JB5wR0SF31adP
         9QmS92quKyqZv6QuwYRr5L+C+K0LA3ksoAG9pjIpSp7Z0KDxfU7nqQvVAy7Iw+hshoAF
         Q/OLd1nSMtoITT4KUPj/YAFSIhS4+uacJ8IVUN7ihacBlM8qtF+ogzpmUVsqAJYe3bSi
         38Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184215; x=1753789015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=de1qD53yMXyXhMXuwBZ7HDegwT/YLNZw++eYKlRirBk=;
        b=pp5ZQRguMr44qQRcRL4LTvvQVdTi9C2qbWLsPZilhG2XSBjXl7tCn6NucGBuAWKboZ
         JkH7WUx7x0hU4OvhdltSG6QIJPnVhfIJgmphc3SD2SZ2SrLCZ70Uwe2maCj3TRpIYGV6
         /VzzoF/bD9rkY2CdQcxV0HfWlWPZ8MfSFVHJRMtnnyN9Zid+cdvcnS4mVum+tuac6jbl
         wYjFVwJ0iQT4PoXh9IaOryn9EgPCi+AW5v2a7R+hQQNj9FD/GoR9G3RRtwxftAzwVX/D
         wPf4fsiuDrt0djf3u6F8DgnV+u/Ty9AMvhbly5Z3DnzXgs3xPy4kG0YZtIwn864tfyUW
         7c5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVf6pgappOgZTqpvj4XZaaCmYvO4pTmp7N1DG9YkvdvKaypeZIxIy90WTrziyKpZtCInZsvXCR8+Xif0mU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2hyx5Hr7pJCEMzjWsmcj1ntJWNyor4qmxTnwcjNtHUrRMR/YP
	hNekWaWMn7ApkiDwvscoGRgX3FAxXhec6+rKa8BcB/FMAhfi9pLClndY8WtKqINhD0M=
X-Gm-Gg: ASbGncv18JRNrryuS0ECYLVimLPm26FyvPVytKoquOVlF7Np6xgOTIFIxARrXdNmRWL
	DzCnuHx/BxQDqH7QwFFOkus7queVk4sp2m3QX5Qh/P34P6W/btc8wmofO3MRZo6bmCZ85yBlTjy
	BaYpQTaheNCiUjX9mVvv6/tzhMYom8YRGFJUK7bu/r6mErR7Es96O8phrqDnq83gODlzi+YXewp
	7O/xfo2Gx2O8G7UrfphONN7ToOCUqjASI7VtEd27/UkUUpSXXRRGeXBATfSitgzto0dV60aEa+E
	5NHVI9G82pW5bhwJUkG7hdqI3XerjEgWBNWuNoED12Ed48o9mx9+9MCxaVfwWFPl6ad8EdX6OsY
	++xTjrl6A+yvqD2BGHWBW8MyapuE7DdmQkA==
X-Google-Smtp-Source: AGHT+IGcSHCv0Awywz+GwvFAr8u9lcIFUb1Myk+n/nsVbU7gMIVVEiLiv1GMsxrt5f277iOaWK0QUg==
X-Received: by 2002:ac8:5a4e:0:b0:4a9:7366:40dd with SMTP id d75a77b69052e-4ae5b7e0a76mr46980521cf.19.1753184215301;
        Tue, 22 Jul 2025 04:36:55 -0700 (PDT)
Received: from Gentoo.localdomain ([191.96.227.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b25a18sm52457651cf.59.2025.07.22.04.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:36:54 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 01/11] Shebang line was missing,fixed
Date: Tue, 22 Jul 2025 16:46:57 +0530
Message-ID: <464054a78bc2ee15eb0384a314a072d3b0305bc4.1753182971.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1753182971.git.unixbhaskar@gmail.com>
References: <cover.1753182971.git.unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added the shebang lines at the top of the file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Documentation/admin-guide/aoe/udev-install.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/aoe/udev-install.sh b/Documentation/admin-guide/aoe/udev-install.sh
index 15e86f58c036..1a34692cda23 100644
--- a/Documentation/admin-guide/aoe/udev-install.sh
+++ b/Documentation/admin-guide/aoe/udev-install.sh
@@ -1,6 +1,8 @@
-# install the aoe-specific udev rules from udev.txt into
+#!/bin/sh
+
+# install the aoe-specific udev rules from udev.txt into
 # the system's udev configuration
-#
+#

 me="`basename $0`"

--
2.49.1


