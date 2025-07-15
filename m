Return-Path: <linux-kernel+bounces-731049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BD7B04DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 04:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E70B1AA444C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 02:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68BF2D0C74;
	Tue, 15 Jul 2025 02:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoVXyNUT"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B582D0281;
	Tue, 15 Jul 2025 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547387; cv=none; b=af2fXJdgKBm/Jy8JarCxp7HarI8CHEtPHbKcq0e8wtAoc91rZKgcez4x/MzVKSQK0og5y782SpZsdyXPmgZOCGwzieBfBk3BwhIfIjmAG1xQZ/fFcsPcEIR6P6QWwURUci+07zPai4uMT8JDocY3Ax1y9CdHmLUxgacWkoqNfHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547387; c=relaxed/simple;
	bh=XmJuGyH1LI7BBoH5lerHk65fvOaWlXKJ8JbP014sKE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqbMp7DMvfhq4j5XiA64M5ldqB3zXQEKLzDVus9XHqab21ZuHaSE/fhJsAz/6aOZ9k91lvQ3ZTVurg3ZHsfW3PP38w9U3NVeMytJidalDn+vM0IVQxwxPg27EPyuBEMg+HtcVZVVe1OT6hPad23g2tnlf9q4Y6T1k92YTPzkV98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoVXyNUT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-74af4af04fdso4664575b3a.1;
        Mon, 14 Jul 2025 19:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752547385; x=1753152185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pn1PQpln2K/kCXiZHlLDgu39MrNnlOn8L9ATG6U02Xk=;
        b=NoVXyNUTHcynz+iHtcs7uMIvmHYm1XOL6i3I2METI/m5h0mD+5jwXCtZsbY8+bjkHi
         LOnW4tZSgdwbxYuDwwcwGhDZJJnEy5H54OHtrprhabI1nOefqetePY5FWBojMOAghe2C
         y8s5uaMLUW9pvF3GBKDEKkSmwFshJ+sMqdk40nVyegpIYUU/6BClcvTZdwKpUr8b1jdA
         llrvMZNAEl37dlC6bXDmelIBDowxxXycsbqZ1wPqfX+L04fhOzBmAgfeNawfwLzavLT7
         OUtONcwEg3rxDLmZYpFzkBio/gNUmTgcZizYR0jD3+nIIWHIUg3BmF8bfWpIkVA1VY7F
         0b/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752547385; x=1753152185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pn1PQpln2K/kCXiZHlLDgu39MrNnlOn8L9ATG6U02Xk=;
        b=n0f4x6aRWeCG8hMu8NdNirhr8+eHvvBwJ6NkAz0RhrDaIG/+YJM8rxJJRere6CGYVF
         2EVwWBNRlkKjBf6nT60fNBGU2U9XBW5X3HmuJuY+MMAWaUjxtuO8op4pBX+qUIbCrDkP
         Hz1mIkwy2oqH9aJdtXxYNGschu2KpBvwSd4N/6RvaMVGAZ55TCzgB51JdzwqrYq3+H7B
         9LxIKnFTxvWaWHBfmVfQkhJ1FnAADYTGo/QW1cyRabw3LZUcPvhO8SC3t/ZE9mb5K0d6
         5RZbNTTUEFL9ULdpVdCjoV253Z/HIw4b+Y6tpNadfXFha7iZfLZ2V2f1RUT8dyGeFYqi
         FrxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUaJ5W56niGGQZaXK4fylNVOQYK61T9N4XX5RXS0QUd+WlvrMED2QVrs7dR3qrjiMbYyC1XqjyVHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLuIBg9juyTBTtlUGrqD9dkmso1Mnj/j9uXgnVp1P/m0rPHekz
	tkbew36ie2bxpJAiBYABgeV/F2OPYlA4g6/bsqkyZDxfRMLEm4XTEfuC
X-Gm-Gg: ASbGncuhHNmdFpiJVOrhXbROj0m3vWr57wYZ6IR0frkcw95OJtip2HW9FxT7a8Dch4A
	mwjTxziGa1C+bGkVOSAFBj7EJZEV8chSOt5L2Uchu9wHG6SbSNuBL8ifOJpip7lU4Qdl0ipM1Gc
	oKHdEMZW5oA7ZFc5YnMURqqlRMyXGUkY5qrrovHTJ59yf9y27zL+4fv03bir+oYxlJ7KB/FKqat
	kkdMQZbMDt6ZviJNfm0VZSQDC1P2hejOyLakkiyduUdukI8ym6DeDDdOej8f4+cdIiYuTX+pZ+r
	ZyCB8YjJ6PJJa+xUlXNJGuiKF0KHLkXd+98l+Mt4finct7Y22j1iQpiHoW0bxsoYsoSIhK0fIl3
	M9fMKisJU0+CxEVMT/4nhfQ==
X-Google-Smtp-Source: AGHT+IEcRZ/12CBzXP0nquG289LN4ZdcHl+3zTaU29EO+cWuo96N39XhiCFtD7mAmMMHFA6oerl4CQ==
X-Received: by 2002:a05:6a21:4d05:b0:235:2395:9b79 with SMTP id adf61e73a8af0-23671d0cadfmr3878102637.20.1752547385060;
        Mon, 14 Jul 2025 19:43:05 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3bbe52c914sm11010094a12.7.2025.07.14.19.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 19:43:04 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9AABD420A815; Tue, 15 Jul 2025 09:43:01 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Haren Myneni <haren@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 1/2] Documentation: ioctl-number: Shorten macros table
Date: Tue, 15 Jul 2025 09:42:57 +0700
Message-ID: <20250715024258.16882-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715024258.16882-1-bagasdotme@gmail.com>
References: <20250715024258.16882-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1652; i=bagasdotme@gmail.com; h=from:subject; bh=XmJuGyH1LI7BBoH5lerHk65fvOaWlXKJ8JbP014sKE0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBml+xvZH1zkqVnLfKs4ce1i00c6joqXUuZk3ss0jtS1b Pl9U3d9RykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACZSuobhn5Gkdx3j3vPW6rxf 7+67NH+hndfbC3aMUgrrtNoLfpZaVjD8Dzy57dyWF9dSfR+kfDmR9+e/Maujncw/FR69n5pCd1q msgAA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

The macros table has three columns: the second one is "an" and the
third one writes "an ioctl with ... parameters". Simplify the table
by adding heading row that indicates macro name and accepted
parameters.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/userspace-api/ioctl/ioctl-number.rst | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index bc91756bde733b..ad5e7001f59137 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -10,12 +10,14 @@ Michael Elizabeth Chastain
 If you are adding new ioctl's to the kernel, you should use the _IO
 macros defined in <linux/ioctl.h>:
 
-    ====== == ============================================
-    _IO    an ioctl with no parameters
-    _IOW   an ioctl with write parameters (copy_from_user)
-    _IOR   an ioctl with read parameters  (copy_to_user)
-    _IOWR  an ioctl with both write and read parameters.
-    ====== == ============================================
+    ====== ===========================
+    macro  parameters
+    ====== ===========================
+    _IO    none
+    _IOW   write (read from userspace)
+    _IOR   read (write to userpace)
+    _IOWR  write and read
+    ====== ===========================
 
 'Write' and 'read' are from the user's point of view, just like the
 system calls 'write' and 'read'.  For example, a SET_FOO ioctl would
-- 
An old man doll... just what I always wanted! - Clara


