Return-Path: <linux-kernel+bounces-877500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0F0C1E464
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 04:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2FD374E5979
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 03:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FCF257832;
	Thu, 30 Oct 2025 03:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btbMpYS6"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A83243376
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761796288; cv=none; b=mG+x5UyLVwWalSb0IQNbS33RuBdzHoa1XRYy5Dccn5rUaNKu2aaANTR3gXkN5XxQtdLp3QjTmnub/fPewHky/Qc8Ec6f78g9CowsKFwHXFPdZsbp6suFKOf4ipdGNzga/be0IhsZ/HyJQ/l2odDkAo3B2hnA7YA7G2L8I/J1q1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761796288; c=relaxed/simple;
	bh=TL+XCHcH+n6MK39anwfguhKCdbMZioXo9hu9YTmscfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E2OitnYP7Z7+c+L+L5KHvQoJFXBUH6SZxkgr45qGNv4Fzh0xKoVQ09Ka0eBKzZws4sbQBi6J768AbVGnCtgYqvqU2oM3/t+c8gRhZ5+tkpFTyPfRn1pfiJcBbxzDRD32RArpc9p8ORxnwAa+m8rZkv7L+xC8lTHPJOe/00P+N4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btbMpYS6; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-33d7589774fso860138a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 20:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761796286; x=1762401086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DK21muBo3UIxSycy5cFvME18bLykBwIoMuPFojznbjI=;
        b=btbMpYS6Mf44+cZ5V2A3R8J/pyKqS+sQVl3Xb4DtxFEuxu0pZSf354z1QxEagIf2Mu
         hjeq2O6MmEZxzpDGPMQBbd39QXYs3lQvizn6/UJZYsnbwvCVGfI3K+nvEwXrNYdWm6mn
         nW/LkRzFydeA2DWp9M/dGrDlbqCAhrGYIBIPYi2+zdhqJVNAXajlUdoyWq3jOu/p4IVu
         OmXISkQCaI5vd+JViS3t1krFvkqghw0ZesusC9HWiDoI2sK7htdg0mE1Uv4R9x/3l1sI
         DAmtb0pp7sF9Jyt0naSBWzDLCd8/A/WxdP4LfQJek4T4gQwfGvdux7EzHuwaX3LoVQDd
         7r2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761796286; x=1762401086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DK21muBo3UIxSycy5cFvME18bLykBwIoMuPFojznbjI=;
        b=o33A2ET8rZVaDqzo6fqduarxxjDy402eIvleyXJ8StQR+uQcveaJ7Pee8h7RU+0Pdw
         YeW/5EoYKUN/dvEtly6rUwOvkRxmY2w0EHAluXGTHF9QnrJUFDcjvxBUJP/mg2jP983X
         Nibm3QU7sfEsVuFUghGzxYUIkYJrBxKB18AcpsUPstQZYoS8AcgaT+MS27iUSW2xVSvA
         mMf+9l0i5fQrAi8fJs4pZfuogB9DMdOLeb0i/Vf/7Nsk6yueoU6q8hRLEkSxvLgcwEYw
         5dNPWMh3U14BISppjGoHbBCuDl0CVJyKJMYcLmJ2DnuegsQivRguNUZAFqpmXggkmc7O
         TwYg==
X-Gm-Message-State: AOJu0Yw5zRIVmTKcmoRJEnLGj39mc1qp5HuYh9rHCUkqQWjC/tK5t4QH
	TAaORsoITq/JTmAKCErMtCK5K93cHXHQ6gU0nj3QTgF3rxFkONX13Sx8
X-Gm-Gg: ASbGncsQOlaq/lUFx7Vjw1G5/3XCrylcAtyAJUpI0Wc35HxSIY6Kb9zldTzkN/JX2cv
	+gLUMHKyWR7u4u+m+a+Q0enQ+ph9NtENB/ABi/eVPZy9yQxFlBZsfH+52XjdCfas2hXazHQwOCN
	gFaYuV0fYMs8gUJmFxr3oumIe6xcWVCn/X8IsXOZC3wqczYyt7ir2qgy7qNQmLyQMGSVA/MNWPf
	q/2F17Kn0MA/kV3+JsaWSlFeyf0g0A0d+k5yW58KzWTL0gyhQ6WMRe0z0ViDb/Dd2Pr1lKn5EDq
	5uI6g0tdcACZ2Fe6OJOTG3Io1WlzZ27/o2nr44u6h9OCEBpQwpXWc6ylMpimayzziawKWBEdz/e
	E704LOY7ya9MhfwgE/r8KalFJBY8m15St0+kfGxyEml8h8s+pI2Nro9aE1D3Vqm7SmtVyRW29tE
	28+0MdaG2VxIwkzK0O0Z2eZi/Rt3f9Kn/8nAkNgaeEceyP3KrjS0CW/4GL0sxDtHwqTirq/Dfqs
	pzr5xMKGqLFnJEvHp7B
X-Google-Smtp-Source: AGHT+IFFhXTigNwcgut4xjvhuiYCf7MizqLvVK1GubXrZ6u76gHvkgwJt2E9krH32A5XWoR0OKr3tw==
X-Received: by 2002:a17:903:2442:b0:26a:8171:dafa with SMTP id d9443c01a7336-294ee35d302mr21391585ad.21.1761796285826;
        Wed, 29 Oct 2025 20:51:25 -0700 (PDT)
Received: from toolbx.alistair23.me (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net. [2403:580b:97e8:0:82ce:f179:8a79:69f4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3381sm167953225ad.16.2025.10.29.20.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 20:51:25 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 0/3] nvme: Support PSK reauthentication (REPLACETLSPSK)
Date: Thu, 30 Oct 2025 13:51:11 +1000
Message-ID: <20251030035114.16840-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alistair Francis <alistair.francis@wdc.com>

Allow userspace on the host to trigger a reauth (REPLACETLSPSK) from
sysfs. This will replace the PSK for the admin queue when using
a secure concat connection.

This can be done by writing the queue ID to the sysfs file, for example
something like this

```shell
echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk
```

`replace_psk` will only appear for concat connections as that is all that
is supported.

This series also include some fixes for the NVMe target code to ensure
this works against a Linux NVMe target.

Alistair Francis (3):
  nvmet-tcp: Don't error if TLS is enabed on a reset
  nvmet-tcp: Don't free SQ on authentication success
  nvme: Allow reauth from sysfs

 drivers/nvme/host/sysfs.c              | 31 ++++++++++++++++++++++++++
 drivers/nvme/target/auth.c             |  4 ++--
 drivers/nvme/target/core.c             |  2 +-
 drivers/nvme/target/fabrics-cmd-auth.c |  6 ++---
 drivers/nvme/target/nvmet.h            |  4 ++--
 5 files changed, 38 insertions(+), 9 deletions(-)

-- 
2.51.0


