Return-Path: <linux-kernel+bounces-751317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18609B1679B
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53BB2583D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD13F218AC1;
	Wed, 30 Jul 2025 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6GqECMW"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2345202F8F;
	Wed, 30 Jul 2025 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753907284; cv=none; b=o4U9NVH3BBVTjRL1+TkuS3l7MzktZxvjKNVbAF14ntzB+FJnYgB31JaIEe+tNEQYFbYy94p0wcIkKOOmXviwXlkX1P/3ApsjTvZPWfSxwf86+r6cQTw7kODJj7+bGOTzxb9VNDYKULYoTQl2/auuFm4eBb99lv6+8xNGBvL/p9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753907284; c=relaxed/simple;
	bh=Q6LIZ9VfDbEASLk+68Jb8+v6eC5UQlBlmh88PSjJ81I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cz2aMOgTxjR3BRAhKzT3NtyfMI1vpojSFNt52J3QGLTQan5kaNVKtgNBBmskj4HoOfTcbXoTqiSZ8O76oPi4HuV2/Lw+NDasHoYQ8IhoEXJgcFQDdpsad5Exu/bw2KbkOM0plHJBpW1bCn4i7BudC/haDsn5+ybri5cECjKH+LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6GqECMW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-769a9c3bbc4so217648b3a.3;
        Wed, 30 Jul 2025 13:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753907282; x=1754512082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgDycgduAUnq/4+6cJh6R3cHxik209mhVrzWhFm9578=;
        b=e6GqECMWWuE6MDqrf62nDpOWFHQvM5tHOhnei4Qn7mB3vPh7jr4xV2suotOQ4nd3wb
         EZoR0efVozF1fmRw6qOdFtur2oQTeN8ggNzNw19ZXBsum2LWzyeTXRS4lROVMWsiXIBF
         6j2rYzmSFA6HYZp+payW1nkI4GA8loyHyTDlr946eVXkFUdAx5EqsoxIGVNA8kyxcoq1
         jJPItOW0Uyrt2HrdXX0QuIZOwCqWvr3GfctBrJ4XPj5DxviCWllR2zj7T9J2AYFU21ba
         Uxt5qudMhsH6pHnfAROZlBClxvNhVmXMfPIiNTf2fFKhvpcAQajo1yxhgQGCWDh7kmlO
         W5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753907282; x=1754512082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZgDycgduAUnq/4+6cJh6R3cHxik209mhVrzWhFm9578=;
        b=sixkYfBesE03/yA8fVXf3hwTAwNpdTk7lnDY4DN95A9Z/134IOZP2J81/poFsWB3a6
         IHWjmzBvptd2hVm3hc0AHO02j+TJMaZvLGbWfM/vG9pKo8PuiH6jVuve3fn2a6xTrAY+
         ZIt2u7YX+t7kZLabNrlm2dCUajx1H9Hh2IdWbty+tUWrHrXCmKCWslHo4BnEJlL16cU8
         znRGBHejwwUl4bA1qhZrRENuIDJO9RpevfFOEP/CtILLPVFI28uQzqm/C1rpa4N3WyzN
         +fH70bGICYgAFAIpSILh/LAqkeBvFQQghae5bhWTPbMxVjRzVy2SVe6IwdnXWQmG9gS8
         T0+w==
X-Forwarded-Encrypted: i=1; AJvYcCWo0z+K5Y6maulSOLjrSHeNylRSTgqeG8KvPah4suLh/35QoeaMKeZy0uNtIgVCv9YxaIdFvSJceI0=@vger.kernel.org, AJvYcCX7ucpF7Oj+gyDYQWvaOptZtVzry2+zobWfVOlnJdFkrX8FGRHq8VEHf/Uk8fWeZxMvHAmymsPSHjHD9LjT@vger.kernel.org
X-Gm-Message-State: AOJu0YzSbqfI73hMULrZZtquGycjY/OflrUUtwQNtyL/ZarRmZIwehcq
	OQhuPQjUJN/tWgQggcYLYXI6ohoCkIlcptDqNQTlAXT/JFixNLYBBE2H
X-Gm-Gg: ASbGncvHHgw1th2rgyNkuI5QY/e8vCivOJstJFwzRqT0Z1XCbK1XBSxXobWgF/7D/hb
	0OnWQHGwqibjIJYwogo2IM4wCtpSBhXZjfb+0+TcQM6cuvd6fC1hQ7K/548wm8iJ85YTtQzCp2V
	0ya9ePZx1iRd9RdiTVQaWCRU6BiA4vHdVY5JZpdpdsc4QIxgOh2HQBTFkYNSpjw2PYPhw0onCLJ
	wCvp8CaVrbsVYleVf0mxRF2gKypzojHVZvK0x9dKlaYRNdn7w6iltNJcl61LfQSXBJcZI3OXFVg
	5S57zFNi6+QDuTsds7QIAItXkatdG9pSU+WJLPP676HaOgtf+vpH1+ZAtpqT22u2Md/lJqfMAs9
	pyGxw0E6XUrrtfda7jgnamprwJffr/eCGfB1TEJYS
X-Google-Smtp-Source: AGHT+IGLjgh/EtllwpcMQugZfIpJCA620ysg4LhMRyO7EP5nKjIvcOaz4ACdWsWsKJ6bRdSt2resVw==
X-Received: by 2002:a05:6a00:a06:b0:730:9946:5973 with SMTP id d2e1a72fcca58-76ab0924273mr7083720b3a.5.1753907281917;
        Wed, 30 Jul 2025 13:28:01 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bc5d321c5sm812199b3a.113.2025.07.30.13.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 13:28:01 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: skhan@linuxfoundation.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	christophe.leroy@csgroup.eu,
	npiggin@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH] docs/powerpc: add htm.rst to toctree to fix warning
Date: Wed, 30 Jul 2025 20:27:52 +0000
Message-Id: <20250730202752.8508-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The htm.rst file was not included in any toctree, leading to a Sphinx
warning when building documentation.

Include it in Documentation/arch/powerpc/index.rst to fix the warning.

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 Documentation/arch/powerpc/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/arch/powerpc/index.rst b/Documentation/arch/powerpc/index.rst
index 0560cbae5fa1..ae0280383315 100644
--- a/Documentation/arch/powerpc/index.rst
+++ b/Documentation/arch/powerpc/index.rst
@@ -36,7 +36,7 @@ powerpc
     vas-api
     vcpudispatch_stats
     vmemmap_dedup
-
+    htm
     features
 
 .. only::  subproject and html
-- 
2.34.1


