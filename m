Return-Path: <linux-kernel+bounces-768032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D75FEB25C25
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E2E2172184
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A21F257422;
	Thu, 14 Aug 2025 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajGLyKMv"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF541E503D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 06:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755154020; cv=none; b=pgz+asm74GSpJ1kFuXCsCcUbKINYjVE7TF3nnRyy3Qgg4yEgzbORzn/gIfFxnchbL3YuyLLBvdWAvuiyWfC9XIISrYT3BJgU+T/rZFoZ+KpWvwpdjX+n0k09AFcIrKegvVUGQ9D0ybLF4+uuoKJRAh3BD/Ni4tKAhd/jtdr2Or0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755154020; c=relaxed/simple;
	bh=YSpLg+J5WTSW16h/agaVa4uJ/XyUCJPuk0TCZ7jbPJc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zl8RNvNFj4gokkJ57809tjHgVIvGt3+OgCHIR4IRrji+pqo9JvyFxs1O6noY2l0QKHqvvtScu24L3d9nljjUWYOmRr1g2wiY4hnDxGlWfybKeD8STXP7WekoDHNfSNZ1lnUtdykKcVr3cgnneWgGjFYUfgzA6DFYyHezIpuehNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajGLyKMv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-244581eab34so890055ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 23:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755154019; x=1755758819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b2yKV+8oABBq/VNfZJ3N0uo/spfr2I4vDDNhhSy0qLI=;
        b=ajGLyKMvFBKRn07BReIj5QL4ZvOOfw1gB3+f9VG31FF+3tnmNQxehdoMD9IqFyRjAx
         N4bZkjf1W/3zfzduRgwsHODDJ2/V2bcV8j7y+Gjuuh2xqqjUU4vohE4BD9c8c+gBvx87
         eKDGvTbvClsF9m57Fw+RloeM9frxjRW6IOK97+hmxMXoxgD06+aaMkjHeYEdlo62qhuk
         hWaDRKnwZPU11KPIKbG60TAyV5DEd7ab6Y/Y027irojBLYLnhrzj3oGoS9zV1lPX1rO5
         bFTt/oxxh1tYzjjFZOKqfqiIh7zpCl/Nzl+3x2uhaIL7AKQW7OBx0pa5IoBuiD7bl0dJ
         PeJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755154019; x=1755758819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b2yKV+8oABBq/VNfZJ3N0uo/spfr2I4vDDNhhSy0qLI=;
        b=Eg9ad+skpTgX9b+e/IMQHHNKxseq+rD4gSW8ZgK3Sjapo2wekcznjYE5pYjBe7IxJk
         o7pzAhvDW0i5EIMvLWeB/n0apuojA+xNWxvhOKiNTpdPf1L6YmHO79wCqG6Tt7lSf3VJ
         TdTyhy1ztFkBAKxj6cwbtSrYwP+CEPToa/iroLx/M4vbhUJxb7QmhpDhw9JeQVLKmUYG
         zUeGmEWtchV6LJR7kXOY/saY0Yokg2+tsSf25ZaCWvAV5g3quicNkSbOz4N4DivMtaTW
         KSmFWUO8tHKa2kAQAcFLFczOswvISkHHt+HjsRDMQpRE+DRZIgvmZeH/eAaX+LJX2NP5
         acug==
X-Forwarded-Encrypted: i=1; AJvYcCX55yoF4xi1AzyzwbSZE4dof2EijmPraqF26JGzaHQqWEXUM3wIndZtg0Zy2oP28EQAPEfYflRv+qavrOI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0fx5IrUSHj8tFHw388s1ADoKKROwaRcOg4dvyuNA6aQTvQTQP
	7TLj/K6ScJp2ekGcgLC2GJnh3+KI162dajNqrxf//9tfft1Twe76MppK
X-Gm-Gg: ASbGncs0JM7WzlMWU7D5U/H+Gbq+3FEpyWIHNBwaDlJMU3vhy8E6X1fnT7tyqoJ3ZRR
	AKNADJFE0BXfCizH4m5QW4FNby9M45rGYmHmGRzfF/1oVR2P5mzm9SfJvXrdbVrzJ8+IUbn7/0K
	/ByRjJpAHPXaK+GDMZp4Rp4au6pFMSvfFqtdg81y18z66J9j+Er5JrWuZR/b82EQQKDeN6j/VB7
	KLgW8sMSdZ0Kk2m7pAjqTsDjB0QHaznzTVelwoqCkcqoInh3y1FDeI5kuFjDDm19Dc/IgLEyf/h
	ZOHXG/Uu06efafBcT7ewgm2h4CWG/07bqSRrYC8SW04ykdwvA7p0u/OUTlJowL3gv7qW96HhEgf
	Eu1+6X/O9ivlRr3kzS0sW16+KvFJMdBItvhtID/bLlY4YtCwt0ojBUvtxzBN+pLuRg7PJaP1jWk
	hHOBB1B7r6lXxdwbgnUufvy6VKKggdmdkFvA==
X-Google-Smtp-Source: AGHT+IFxpRtM+kqy4oRQeSQGVx00yH60P9IPjOz2awbe6y+pgBdHuVzteeYciNxpvLRgKrSxq0ySPg==
X-Received: by 2002:a17:902:f543:b0:240:1879:c2fd with SMTP id d9443c01a7336-244584c4391mr13982795ad.2.1755154018605;
        Wed, 13 Aug 2025 23:46:58 -0700 (PDT)
Received: from crlab-Precision-7670.. (2001-b400-e3ea-ec7a-a0b8-2b9a-bbc5-b6e4.emome-ip6.hinet.net. [2001:b400:e3ea:ec7a:a0b8:2b9a:bbc5:b6e4])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-241e89769absm344662025ad.80.2025.08.13.23.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:46:58 -0700 (PDT)
From: Crag Wang <crag0715@gmail.com>
To: Jean Delvare <jdelvare@suse.com>
Cc: dell.client.kernel@dell.com,
	crag.wang@dell.com,
	Crag Wang <crag0715@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] firmware: dmi-id: add product_family to modalias as pf
Date: Thu, 14 Aug 2025 14:44:39 +0800
Message-ID: <20250814064443.1278029-1-crag0715@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices require product_family information to trigger
conditional actions when the value matches a predefined criterion

$ cat /sys/class/dmi/id/product_family
Dell Pro Max Desktops

$ udevadm info -q all --path=/sys/class/dmi/id | grep MODALIAS
E: MODALIAS=dmi:bvnDellInc.:bvr0.59.39:bd12/16/2024:br0.59:efr0.0:svnDellInc.:pfDellProMaxDesktops:pnDellProMaxMicroFCM2250:pvr:rvnDellInc.:rn:rvr:cvnDellInc.:ct3:cvr:sku0D14:

$ cat /sys/class/dmi/id/modalias
dmi:bvnDellInc.:bvr0.59.39:bd12/16/2024:br0.59:efr0.0:svnDellInc.:pfDellProMaxDesktops:pnDellProMaxMicroFCM2250:pvr:rvnDellInc.:rn:rvr:cvnDellInc.:ct3:cvr:sku0D14:

Signed-off-by: Crag Wang <crag0715@gmail.com>
---
 drivers/firmware/dmi-id.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/dmi-id.c b/drivers/firmware/dmi-id.c
index d19c78a78ae3..284652d75cc7 100644
--- a/drivers/firmware/dmi-id.c
+++ b/drivers/firmware/dmi-id.c
@@ -87,6 +87,7 @@ static ssize_t get_modalias(char *buffer, size_t buffer_size)
 		{ "br",  DMI_BIOS_RELEASE },
 		{ "efr", DMI_EC_FIRMWARE_RELEASE },
 		{ "svn", DMI_SYS_VENDOR },
+		{ "pf",  DMI_PRODUCT_FAMILY },
 		{ "pn",  DMI_PRODUCT_NAME },
 		{ "pvr", DMI_PRODUCT_VERSION },
 		{ "rvn", DMI_BOARD_VENDOR },
-- 
2.43.0


