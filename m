Return-Path: <linux-kernel+bounces-886344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBE9C354BD
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 12:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B5C7B4E9253
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 11:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFF730F941;
	Wed,  5 Nov 2025 11:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TduNVMCw"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C1630C633
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762340999; cv=none; b=gXoQhyEFh6gowhc10e66iOtSX2ffqMhrv00B3Dem4MrFt4vwvZZKti1AdeIK105iGGBUh9sT2i3lNgv0yYqDYfCAYuRruL5lv0hgrFwhQSmHVl1GANMGHEZo9A/y0A3ZoIixP0zIY9kXZumNM4QMWHseuOFdy8Hce+t3PyzrX0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762340999; c=relaxed/simple;
	bh=qOUc++FbpRH9EOOvQa4AZbyk8wXb82NantRb8isyR/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q0vBY6thmCnPBtywMgLkVVj5NgJbsuunQ3YXLoCnErKAgm0pxpnXzhv6jFzmTUKsqlAzlRwExxOTxE0H6I65T5N4zqFs0ydxr8yZFAy3vwPRZUgrQq2StP2PWw6JnGn6Dbw6hqDazRCEb0o/qiqS7ujfmfaQc732lNojdsNml6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TduNVMCw; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-477563bcbbcso8762875e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 03:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762340996; x=1762945796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fNljkoDjcu+DjVHFlm8hZRjkzJt0yBrV07jD/iI+rkk=;
        b=TduNVMCwhdBHVm/hHMNAQ3yiCJWgjvrRCdIYTUfZy4gRb8Z1QoBLyoTJtoYReYnt0Y
         +yeNIndKDPn7v1bsVJiFPwqylor/wAoBgZBitR1GPN374erNlxg7i5CDIOWi1mK++BBG
         2VygmVmgJSjq7/2S8JT8gwkWarmZm2eHxSxe/n3xZeymN1scYyaeILWm7Pzo66fR5TXC
         dNO6coOqpngS17YUuLbb2FaxdEE8Bz0atBJL8T4hc76IpdrASD+srIh3r9vrbqEhAclO
         8FX7+w11HeLZWzFvbJCKDDVO5c5Kvf0NJrsD5ieGRUpnWIUaw6S6EgErKPm40OXfYwLd
         IF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762340996; x=1762945796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fNljkoDjcu+DjVHFlm8hZRjkzJt0yBrV07jD/iI+rkk=;
        b=d1NLTsWVxVd90crYV3Vpdva7riMtCLBPRz5xGkRQEBvykHYM1AVdKJLbAYK90JOlnY
         6zsmUxV4ASCj1dMS3q/1O5HF1ezXYV27ocNP8ryc31ZeRir3vZI+gIjWsd3fmD2E78mY
         3UrEGtJfSxrLxkPBENaS9dhyOXKY1yWgnDZqGr661Oq2/znvVod5PQ8ozaibxRYCteUk
         gOIw3ZDqXOo3Cl6mYHn3vZDpSAasSJ6pYt8tucFKQ8SDG+Uae8xhx3fZHbpeDPIo2qm1
         RlZKALUbd4KaKBWXK0PoypKgwvqqQOKNq9nn6J4uMpxopP9BCUYGNq3svOC18UfN1xN3
         i8UA==
X-Gm-Message-State: AOJu0YxB2Cj3sJckf62hcC1qdYBHKea8Qt2aDChL1sn9pQ9oN5/aCzdu
	UF+XxzDCwMxunZHIshtySWTlFgobs72YHEjtlFSgfoVhItSqT5i5kmKX
X-Gm-Gg: ASbGnctL8dD9J+qZ8no2vwGpJLr3L3ZDBU21j5aKtdJx5KjuWywNk9uubGEuLbuxhWH
	fhMDee1McOSm7QPo9WBUUriMgDiENMZW+1dV683VNw7j9GOXszZZyMzQbugw4NN0HXmDFJ6AwcR
	HloFVpCVRBI4h73NJAlOtoTzWJt0j2z1lQBTLOo2E2T93K5OK3TnRExFTlJ730KH6UeIrnEPVut
	poPDGayiG+zEEPuryeSayrW2bJEuwDDZB+gmpCgtDq7xSIlvesroN4tRB+EH3BrYs+sw4+URKSR
	uN0wrL1R28+UfKWCE8I/gB4BdalJ/eMDtgb/quPtub2k3roKQtVikgOeJAt7WYyTBxYfNkoI1KW
	UIiV+LvHMlpd428sMM9mo8yL5BEhZ5E3Q+TPxVGQAuXrqlyxVYTgs/BSNp7BJ+MEA7F02tSSDc7
	DbsKfMnUCsX2s=
X-Google-Smtp-Source: AGHT+IF2UxLPAaLgLuHgbIyHft9aPDsEhxD/4ZlCe6k4ng4kCQPn8kS2+g0dONw0r1xUVMNFLgkTpw==
X-Received: by 2002:a05:600d:8381:b0:46e:376c:b1f0 with SMTP id 5b1f17b1804b1-4775ce9bc74mr15632625e9.7.1762340996155;
        Wed, 05 Nov 2025 03:09:56 -0800 (PST)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477558c42adsm39728415e9.4.2025.11.05.03.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 03:09:55 -0800 (PST)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	khalid@kernel.org,
	stable@kernel.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH v4 0/2] f2fs: Add sanity checks before unlinking and loading inodes
Date: Wed,  5 Nov 2025 13:09:41 +0200
Message-ID: <cover.1762339963.git.zlatistiv@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is provoked by syzbot warnings caused by corrupted directory
inode with i_nlink == 1 that passes the initial sanity check which will
only mark the filesystem as corrupted in case i_nlink == 0.

Tests:
- fio/fsmark parallel create/unlink on VM with f2fs root filesystem.
- syzbot

Changelog:
  Changes from v1:
  - Rename exit label in f2fs_unlink().
  - Add sanity check in sanity_check_inode() and remove it from f2fs_iget()
    as suggested by Chao Yu in order to detect on-disk corruption early.
  https://lore.kernel.org/linux-f2fs-devel/d4b7c03c-6554-4407-b823-aecfcdf7dc3f@kernel.org/T/#t

  Changes from v2:
  - Remove i_nlink == 0 check from sanity_check_inode.
  - Wrap i_nlink == 1 in unlikely() marco.
  https://lore.kernel.org/linux-f2fs-devel/1f519357-a489-41fe-8159-a8e319aedd17@kernel.org/T/#u

  Changes from v3:
  - Replace F2FS_I_SB(inode) with already obtained f2fs_sb_info pointer.
  https://lore.kernel.org/linux-f2fs-devel/4de88613-54a2-4ef3-9b56-7963cd3e42e6@kernel.org/T/#u

Nikola Z. Ivanov (2):
  f2fs: Rename f2fs_unlink exit label
  f2fs: Add sanity checks before unlinking and loading  inodes

 fs/f2fs/inode.c |  6 ++++++
 fs/f2fs/namei.c | 29 ++++++++++++++++++-----------
 2 files changed, 24 insertions(+), 11 deletions(-)

-- 
2.51.0


