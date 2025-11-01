Return-Path: <linux-kernel+bounces-881288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE6FC27EC2
	for <lists+linux-kernel@lfdr.de>; Sat, 01 Nov 2025 13:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA6C34E9C8D
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Nov 2025 12:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE3B2F28F0;
	Sat,  1 Nov 2025 12:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYZUM/Tb"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A132C3262
	for <linux-kernel@vger.kernel.org>; Sat,  1 Nov 2025 12:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762001806; cv=none; b=UZ6/nY27xdW2EGmNZeTrppdo/GPHNC8UeWfQSdOXWFIh+iSM0PdwguqK9BB9aW2GqTm891rJjmejhpkL+9ouj0YgD8aqnFlnf3YfgRoY5shT9ZAumxmW/lhZ3yHpWTkSq3/WLVaXhY66GslqsQ5jbXZGkhSxdBcKUyqubKSIk2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762001806; c=relaxed/simple;
	bh=bY9blcWwS6sUmcL8NElBTzi1r0kjFCooMSoEK5zz8Ok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bCUdhPwlB8URX2tGLO9d4Gumk+V80F6mub5OYD9GBFJlBFszdEosbe/HqtF3kKwwIouIa3eCPa76vNHHHviXmNCFD0KGNvVt+sjy3bzKQmKfO4z4dtizBwd39VHbSzCr6EFpQTtdi5xEEuZ/7pXZYgt6jkAss0aKxMQLO4CaVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYZUM/Tb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso25162055e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 01 Nov 2025 05:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762001803; x=1762606603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wGVmb1DJ+yAOnx5AlPbC58cKdV6J05JG0r5lqYgWdxk=;
        b=VYZUM/TbQJdj5zH+JUuSGdfhJxgjAZtX7L378yT583NQdeRfYfcyMVAcU7jmQMumjA
         zpwFTh+xynnOPKd0cb3iZ7KQbdOexnKGKR+x75Mr7rcpGQc5tbDx6vNrOfPrpzOcQMZ/
         WVqYDRFqGr1E0dsOb7OQS2gwxpqCuIPZkz0fS0EQrjGOy4pk2cm76vFt8eSDjvOUJQav
         FAMQWOqsrJ/Sfykw5EvJyiWVU7EpG1ypS1tvf3r/MD0bYIrPPIKnaCoxW23fyRucWo2q
         intVvjKBGxZHh0rNSs7tAFiVkXmXeYJlDcqy7WtxiyaMPXvMIB7R+ReZAOlonT9/lOvx
         aZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762001803; x=1762606603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wGVmb1DJ+yAOnx5AlPbC58cKdV6J05JG0r5lqYgWdxk=;
        b=AKrqKvPWm2UCPT6obeSlQglXY2jDacTOfBNkldYatKh64Fdpjch3s9L6oOtCVc0Uy/
         9YNLuKVB2bCS4Ckn90wFtnf1YEXamWhcvRQ5DJOF5f+wrl/VCXWmhAjOXZXl1Bb2SO8p
         1dyCAFtMRN0ePYgfUeEe80NZaiCHsJ9PAHwGZZvzCDWDng5WPRHaTYkcUSXA0FacYYkY
         MCYz52G/ABrwo4V4Fv9i/Mfm6sYGCUhtevWfqAWlWbABid4d1mHFmq+JwQrR3KgICBRC
         Eni0MbKEP5/a9yxEqHkrdFyPhpmTjR6/2K1xM0vDqzAE77eblQU06fhDHy8y0zDqdCm+
         +MBQ==
X-Gm-Message-State: AOJu0YwD20F/uilYQOeFynhEG8O3DpXYnurebR0058bLhm+XOlYSnTLA
	5YMIGC0QulQFrA1Bf/6W7zECeC67YFFS808hlnsMlU6vzrYv4ajjSRgx
X-Gm-Gg: ASbGnctYUweAF2xIRAC4V1cEcBBKrA2mNvw/c9D3mp8Le0zU6Y+WW9WATpVOWX/qT/l
	HbOAG/EQnwOQiRrrc8xVuX5QJKwj60jljHzbtF07Jtc9zfo3xxIGdFyMeOCFdgZHwM5PpYYyi2B
	VRoqjcsRV7TvFmYurNwmSzrfbs7R+UwwUtxcc3uBggnLaVqcBwFXj6Rt/d4VdHmYgpz97B3/R9I
	rOQSJBTLhoef/ytQdTiOQuRqEr1opHz0KxuWjg6cgCG/1op7ausfVAHKk1RU/Yk5WVSbm2DHkCI
	wFK1d6I8MGWoz4Wdd4eXQVXjYWKElKhz/XD52rnO7vhKLuCnivrXkEsHsv2Ye7CB2i1CZS7VYZd
	9D+NA/V0tLHWNdLUQ6f8JVdHwhtqAbuvDtprTFXmF2EcsSzAS9P4ALSQDKfXASi/PG/gsW6nH6P
	FUjhXZuHoQp+ZSJDD67PBCqQ==
X-Google-Smtp-Source: AGHT+IF67+MB9gNMQj44RfGkbRUyMVSRr8JGv/Vb3x0BucDfXENO6/yD2+Bv+4xEmQGnVJYrNs47/g==
X-Received: by 2002:a05:600c:444b:b0:477:c71:1fc1 with SMTP id 5b1f17b1804b1-477308b7d81mr67818705e9.19.1762001802876;
        Sat, 01 Nov 2025 05:56:42 -0700 (PDT)
Received: from localhost.localdomain ([46.10.223.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f2b5asm8827647f8f.40.2025.11.01.05.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 05:56:42 -0700 (PDT)
From: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	khalid@kernel.org,
	"Nikola Z. Ivanov" <zlatistiv@gmail.com>
Subject: [PATCH v2 0/2] f2fs: Add sanity checks before unlinking and loading inodes
Date: Sat,  1 Nov 2025 14:56:14 +0200
Message-ID: <cover.1761993022.git.zlatistiv@gmail.com>
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
- Add sanity check in sanity_check_inode() and remove it from f2fs_iget().
  as suggested by Chao Yu in order to detect on-disk corruption early.
https://lore.kernel.org/linux-f2fs-devel/d4b7c03c-6554-4407-b823-aecfcdf7dc3f@kernel.org/T/#t

Nikola Z. Ivanov (2):
  f2fs: Rename f2fs_unlink exit label
  f2fs: Add sanity checks before unlinking and loading  inodes

 fs/f2fs/inode.c | 10 ++++++++++
 fs/f2fs/namei.c | 27 +++++++++++++++++----------
 2 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.51.0


