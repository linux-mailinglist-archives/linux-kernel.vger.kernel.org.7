Return-Path: <linux-kernel+bounces-872474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB8F8C11496
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 20:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538974215B4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 19:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8307430FC1C;
	Mon, 27 Oct 2025 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqdsHKOg"
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5F730C60C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 19:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595007; cv=none; b=fbz9z7NAjvFUoNhVHDoUQZ3Yn2oBg2FEmsu/PIJFt+8Vpbwe6PkDBGpqd+dtd7DvYMYV70W1iUHW1cFyj5UFTXKVIoRV30x7hEbD3XWAS8jGpWA1N22NhNxML2t7K0NB7ikoKJt7X+gxwsbdfUHekbfVXuTcxn7nWYCBSM7zDEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595007; c=relaxed/simple;
	bh=UZZhAbmAkKv+FTP5GhIDbZHPDxG4xE0BfY9TmDHhbOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VdgttTtqPUT4RUtv+BAUYELowmfbO3ok7edqtxZpEsvrrUceQYeijWowhpyISUS2IrgkjytQp8WyiPAG5HOR0W8gHJR1p0x0BCbn1iNDnX4GZ4LdmjwR+c7itNQB+9wTedQokTL1bYIutc/m2C3JHVEYOAcmWYAnjWsjJIwwZd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqdsHKOg; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-93e2d42d9b4so213821439f.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761595005; x=1762199805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hLhpczMr/qRNQs1RGJCHlSNtk+HMp4BppJDnLUYfVFc=;
        b=bqdsHKOgsbb9uMVYJyDBRfsNwR1bNCUznTlOLW6TlPn7ilViEIiEkOYZrEkbgEjuFV
         /0jSAKraXz9FZtlEjM4dyy6QfuadfYPSXV1epLh0YTwc+y4OMmJOvKj4qxvployBaXlL
         L4m3URglKZt3LVHDbDaG+CKfC0Ix4OBE18S9ga8Dq/SnOkiwZG3PLN+Lp0lnE/cwMrcX
         fUtg7bnt8c6V9CtyeSo7yrRBUt7RUUXh+wuVdzG00tglLFVKlZ2hNsVKYpfG2jrigD4o
         4hSibgzK2dOqCpgT8oyn3Xh96cD4vdQfFQRTyaB2R4T4kQn9nddYSuPGpawuObpkNLlf
         ntLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761595005; x=1762199805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hLhpczMr/qRNQs1RGJCHlSNtk+HMp4BppJDnLUYfVFc=;
        b=egsNGGDaqQ5yyycXCcY9imKFwx50oR1uvdJbelP7kCa3DNjtdXkV3YvQ1Kt/XcCtEp
         zCH9iz2GfGShGrQ0LpOekm/Kcb0Yrt0nmPW7/qZ84PgpKuHHlI6uPDAHitA9sG67oHrh
         IVCSqkmHLFJ7Y+G0aoRt1hhCRMgrm4hQTWCKxcz26onjU5DOiihgm4u7NBdPUhXTPF8V
         mBQpcXpfBfs2H5Mk+s2jXLQ00xmVWKLXixz8V7ueMjKbbndjkyrso8/kg2OKk7ucdYWl
         PswJbo/DrupntWipkWQwu7cE8PrA2p3pr3lZWY7KJYxFDz8TxrDzWS3Rkt2R/IE/RBgF
         jGNg==
X-Gm-Message-State: AOJu0YzNZ/azOqtaXSS0RgHx898tFDxBayk9j0nEw7KAIRhWbqxicsVm
	AqsWBOpFJS6gNWIMGd0qNfbsgpULtN7hjMLwgBaZ21iFgLXOZ++eg/uM
X-Gm-Gg: ASbGncvnrzXQAqK1tuNbrF25ZYqeGqqZ4vRjumA+318IYtDvS2MVJ/1UOIkwhDTGc8D
	hsQ31Ufh9TyStYyfMWH96vqVyWeJXyX0tFf+onXGUPaecUww7rjm8Ukj8J30QHkjnOrXfYwuI34
	9X5Y6b4h/dsr4M1Q+QGP3KbhXpjjVN6JdI5ja/ELnHao0SEFMvDob7apekfQfjCXpC9Ng7IKVsx
	jk5zVBe6z5cGerwoYxmPhGef4s0BOJrTkAGG2Q8/fxlx8XpgMlpXmUkWLg8nCqa1w6LFY2kDcum
	l4dN3QkvKs7ZnlPQfw4rbQ0V5nPlX4zCMZxeN5RZEXXlRM3/U40mCNiwTG//2RprksN3KgaGx6i
	cRHp7ZDCvnJXPlIZwadsqyWDtkftyIw6ZE7+jg4KXPgc/g+G7d+AGLxRSZgw8MclhT7Wf1Ngilk
	KYxfoPWUGXD2OAbMsfjuS0fJN92mtt0F4MVvjQtayQdp/81MAaI+/iRYzjgyOh9cc=
X-Google-Smtp-Source: AGHT+IHH+n6qnh06CjvonKm65cHZGMxYdSEgMYDvgDnSsw6DnedswB1L838R+C1gHzhYrTwaneJdHQ==
X-Received: by 2002:a05:6e02:2488:b0:431:d95c:83d6 with SMTP id e9e14a558f8ab-4320f6ccafemr20938425ab.11.1761595005094;
        Mon, 27 Oct 2025 12:56:45 -0700 (PDT)
Received: from princess (76-224-4-192.lightspeed.clmboh.sbcglobal.net. [76.224.4.192])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea9e37cd4sm3482853173.60.2025.10.27.12.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 12:56:44 -0700 (PDT)
From: Ben Hoff <hoff.benjamin.k@gmail.com>
To: linux-media@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	mchehab@kernel.org,
	hverkuil@kernel.org,
	lukas.bulwahn@redhat.com,
	hoff.benjamin.k@gmail.com
Subject: [RFC PATCH v1 0/2] media: pci: AVMatrix HWS capture driver refresh
Date: Mon, 27 Oct 2025 15:56:34 -0400
Message-ID: <20251027195638.481129-1-hoff.benjamin.k@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

This RFC series significantly refactors the downstream AVMatrix HWS PCIe
capture driver so it is maintainable in-tree and aligns with upstream
media driver expectations. The new implementation follows V4L2 and ALSA
subsystem patterns, splits the hardware plumbing across focused source
files, and introduces proper runtime PM and interrupt handling. The goal
is to keep future maintenance manageable while providing a direct path for
existing users of the vendor tree.

Current status / open items:
  - Audio capture paths have been refactored from the vendor driver but have
    not yet been validated on real hardware. I would appreciate guidance
    on whether you would prefer that I drop the ALSA pieces from the
    initial submission and stage them as a follow-up once I finish
    validation.
  - `v4l2-compliance` passes for each video node, and I have exercised
    basic capture in OBS. I still plan to do heavier soak testing across
    all inputs and audio channels, as well as cover the suspend/resume
    paths.

Any feedback on the overall structure, subsystem integration, and in
particular the best way to stage the audio support would be very welcome.
Once I hear back on the preferred direction I will respin this as a
formal v1 submission.

Thanks for taking a look!

Ben

Ben Hoff (2):
  media: pci: add AVMatrix HWS capture driver
  MAINTAINERS: add entry for AVMatrix HWS driver

 MAINTAINERS                            |    6 +
 drivers/media/pci/Kconfig              |    1 +
 drivers/media/pci/Makefile             |    1 +
 drivers/media/pci/hws/Kconfig          |   13 +
 drivers/media/pci/hws/Makefile         |    4 +
 drivers/media/pci/hws/hws.h            |  194 +++
 drivers/media/pci/hws/hws_audio.c      |  571 +++++++++
 drivers/media/pci/hws/hws_audio.h      |   22 +
 drivers/media/pci/hws/hws_irq.c        |  281 +++++
 drivers/media/pci/hws/hws_irq.h        |   12 +
 drivers/media/pci/hws/hws_pci.c        |  708 +++++++++++
 drivers/media/pci/hws/hws_reg.h        |  142 +++
 drivers/media/pci/hws/hws_v4l2_ioctl.c |  576 +++++++++
 drivers/media/pci/hws/hws_v4l2_ioctl.h |   32 +
 drivers/media/pci/hws/hws_video.c      | 1542 ++++++++++++++++++++++++
 drivers/media/pci/hws/hws_video.h      |   24 +
 16 files changed, 4129 insertions(+)
 create mode 100644 drivers/media/pci/hws/Kconfig
 create mode 100644 drivers/media/pci/hws/Makefile
 create mode 100644 drivers/media/pci/hws/hws.h
 create mode 100644 drivers/media/pci/hws/hws_audio.c
 create mode 100644 drivers/media/pci/hws/hws_audio.h
 create mode 100644 drivers/media/pci/hws/hws_irq.c
 create mode 100644 drivers/media/pci/hws/hws_irq.h
 create mode 100644 drivers/media/pci/hws/hws_pci.c
 create mode 100644 drivers/media/pci/hws/hws_reg.h
 create mode 100644 drivers/media/pci/hws/hws_v4l2_ioctl.c
 create mode 100644 drivers/media/pci/hws/hws_v4l2_ioctl.h
 create mode 100644 drivers/media/pci/hws/hws_video.c
 create mode 100644 drivers/media/pci/hws/hws_video.h

-- 
2.51.0

