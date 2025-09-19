Return-Path: <linux-kernel+bounces-823821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66ECAB87833
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 02:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23FE3BA97B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 00:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6392A2441B8;
	Fri, 19 Sep 2025 00:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gs9xeE5z"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252C31E9B1A
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 00:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758242226; cv=none; b=bZvQHsAPTJu+Ib8zJ5v3GcR1/KK/C0A8IQiPEnMFoRhCuUfv4/F0rIfyH2d6W9s5724suIAucCxULCvWD0ux9KJAwstKBdlU2hgeqt8rpFOPRR6A3Mz8a0jTG4wN5sFAeyj/pPfEKCoSA6H2/dyn9RV6HN2yqTifzMyGxgcxyJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758242226; c=relaxed/simple;
	bh=/zHl7Hocdub5nwWFq/uhyVeik+EKW0ciwzHubkGEnkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gvPnAqNiYn5pAW4Bf/ZNdKNHf0uoEI94EFvmLTnM5wzTg2tvQyxIEwSVGn/6tACGeV/+PSvVhz0efFuZ6xj75PEc38OO+9ksNM2HNB6xjxJHPDJZkbsL4M+MADBAf0YUwyIQthhW8nGrtH/hnN9MCGj38W2sV/nfGiX+bzxT+H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gs9xeE5z; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2677a4d4ce3so16749825ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 17:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758242224; x=1758847024; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xNKV2H1bYIOdZ9kzp0zgPBPORIzeOGUyz2fBTqyLjPw=;
        b=gs9xeE5zIAvPuHixu9CkhcPmKme81+umC4AdGwD0VFrXicHioYAozaol0pFcSEZ9GJ
         7ZJIII8xxmxw1UT7Q9JetFaA+FdqKWEPnSkwsxFkXfBdid1kFoaW09NP4XBRLrkH2v9R
         rm0JB/TcD19ZfjglRqmqGhflOwLR74ylAPLm5ya76ri1b0m1OBFHU4NxCCa6bCLynGoK
         HhJemlqxN0P6oT+PwsH6gFYnQepctRDtIc3NHdMmH8SY7CSpRY/PMGtMKSTPvqcNWiMp
         a8yDUEgJBHny8IAU3IlsgfbpLVP0kEls8kuBXiZDj0daQyre50rWyNmve4FksFoVubjQ
         giFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758242224; x=1758847024;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xNKV2H1bYIOdZ9kzp0zgPBPORIzeOGUyz2fBTqyLjPw=;
        b=Huctc2dEKtURFZtQK20wOSGN3YIX9K9un0yK+4MeRZAQZSWcqZNMLxab36nEmpLiMi
         cMHHkdTX3KGFDlQChXjQg98STU0cp3Ve74xEgOjw9L0VoF9dpdpx+AvqhIETfIituNhf
         2F9KfZmynItk5GS9l2BA899GmD4VyPt/DhBYJbMupioK/JDusRylMt9ATbI/QK4wZnsy
         Z5BymS62ulA+dc0fMtJsF/qudqJARMWluCVe7bzBQLF40FOIk1XNkv9Mybofl9Wv0OkX
         A0ICMUyZu4S8xqmNyNbovG44G8/Ph7Cf+HwqQZ/QfmoQLs6JIGHIjk0zKhoFqM/chotc
         bszA==
X-Gm-Message-State: AOJu0Yyu6rqO7sSI3GpFv5JKtycBu/fE+0a0B5r2XLEDrKACqkTP8qEB
	dX5/VMI2KTmakJlisnEC4gFefLWGAHPXRLVaG7xSXAOfmtohCRWHJ51O
X-Gm-Gg: ASbGncvvZnncWbgujWs8ootBJyRHzjpCAeJHI2Qe5aG7YT6thcucywDfUp+Zkyx558I
	rZI4UVwQEUlWSVjSBPym5Ae2b9tFg1UWYjC6hyMrD2J4vhcnRwgP/P1lL8L8BZ1oQtVApJTKcKa
	9VXOj5y7/t9NFCJmbL/s+yzCPWrK3SrGmn9ipAyuS2rKftsNZX7yIyVIr9LH5zF/dRwj1Z7wx5u
	QROs6JIBHd26/HsWTsPB7p9WcxRG7631PzY1k1tjriq+qBa0gjW+IfI5taUIUSRPfVTw3a2o+H2
	m5Q6EOKWSJbnNePA3WID8NDvs1MHNR7ALX/S0xdsCVoEbTIqw7siR4k3fJ3+ot0ZqukzmvI8cnr
	sU6ODBJOTA5gnrRqInj+4sS94qS76EbHE6IhQx8aY
X-Google-Smtp-Source: AGHT+IE/yBNlcgm9BPTKttWbmAHCiZjMO8WtHGa5VVD5WcCQjQ2ZZ0IocaszrdjGPXBK2fPfpIuodQ==
X-Received: by 2002:a17:902:d2d2:b0:25c:e4ab:c424 with SMTP id d9443c01a7336-269ba534e05mr24162985ad.33.1758242224003;
        Thu, 18 Sep 2025 17:37:04 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033ff66sm36649275ad.133.2025.09.18.17.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 17:37:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id EA12F420B4E0; Fri, 19 Sep 2025 07:36:59 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Framebuffer <linux-fbdev@vger.kernel.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>
Cc: Helge Deller <deller@gmx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Teddy Wang <teddy.wang@siliconmotion.com>,
	Bernie Thompson <bernie@plugable.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arvind Sankar <nivedita@alum.mit.edu>
Subject: [PATCH 0/3] framebuffer docs toctree index refactoring
Date: Fri, 19 Sep 2025 07:36:37 +0700
Message-ID: <20250919003640.14867-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=bagasdotme@gmail.com; h=from:subject; bh=/zHl7Hocdub5nwWFq/uhyVeik+EKW0ciwzHubkGEnkM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlnllSdYxS+K3jwt99iXc3oxld1K1Pf7Ez88NJ9dk+K9 //qzx07OkpZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRF4UM/+O/ua3WsUgKtWGW +994d06Y6xeL9kMOz44+b5u9a/7XZG5Ghs2hFX9eNwdKVG6//E5p/97fpw++fPU3LW+bZDbXeiF mWWYA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi,

Here is simple toctree refactoring for framebuffer documentation,
based on docs-next tree. Simple because it only splits the toctree
in patch [3/3] into two sections.

Enjoy!

Bagas Sanjaya (3):
  Documentation: fb: ep93xx: Demote section headings
  Documentation: fb: Retitle driver docs
  Documentation: fb: Split toctree

 Documentation/fb/aty128fb.rst  |  8 ++--
 Documentation/fb/efifb.rst     |  6 +--
 Documentation/fb/ep93xx-fb.rst |  4 --
 Documentation/fb/gxfb.rst      |  8 ++--
 Documentation/fb/index.rst     | 80 +++++++++++++++++++---------------
 Documentation/fb/lxfb.rst      |  9 ++--
 Documentation/fb/matroxfb.rst  |  9 ++--
 Documentation/fb/pvr2fb.rst    |  6 +--
 Documentation/fb/sa1100fb.rst  |  9 ++--
 Documentation/fb/sisfb.rst     |  6 +--
 Documentation/fb/sm712fb.rst   |  6 +--
 Documentation/fb/tgafb.rst     |  6 +--
 Documentation/fb/udlfb.rst     |  6 +--
 Documentation/fb/vesafb.rst    |  6 +--
 14 files changed, 81 insertions(+), 88 deletions(-)


base-commit: 348011753d99b146c190aae262ee361d03cb0c5e
-- 
An old man doll... just what I always wanted! - Clara


