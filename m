Return-Path: <linux-kernel+bounces-799660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F1AB42EC2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 03:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7328B7AF2D0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 01:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834951CEAB2;
	Thu,  4 Sep 2025 01:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAPKG068"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0471C6FF5
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 01:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756949167; cv=none; b=quQi922B82yTA7hKXz2Ho+9Ng5YXuMHd3nf12yERMS1jM6RDraXBRW9lXm0s2BQUB37kF/NDqgLWzULiEb/o9acFyNZbHPFJLIcQOtChKkCM+jVgyaOn+u27oWgznLRbIblDMLONiIVih1OarOZRzCSQ8he0FUBESe5/Bnm19fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756949167; c=relaxed/simple;
	bh=y9ZABqf+yHMqEW+QEAi4I7ocMN68Syj5J3cajh4yIcQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cSuBpUhs67ks9P4P2WNyKwR2BwxOmyh2gINAXsI4qzyMwcasDDcDU/SAF+hhbiCdTy5YnCXuA6UCof+jzAAaYAg9BPR6ivwvG7WkJ3vhOSCeVRdoB7U+464P2eST/qeSYeNeE62BvbzrLQB5aKQHvaJ+pJuUkE3fB9FPThv1lcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAPKG068; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8080a88a32aso56975285a.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 18:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756949165; x=1757553965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TLkWJqA+Qpg0LFBNtfXvmc5DTZiOLOhodc1Nry+glzc=;
        b=LAPKG0687i4fBrAlcWIZ2drbxNTixSzCj+NomvimNOscwXXMuFV1qbOQ2k5vC1wDoO
         XZ7dtah9LHFrSnascwmskH+K//MojdoxHUjvemtELrv+QmGcSEszUwzNsH7ZjVe2knNy
         zBd3B/2TQ28pZzkcgfD/xA00z35fDcXJYhyqbbq+46n6ONqphDV1AR4qdr+PxORdUInt
         cNIkfA/6D5XDzS2+9K8Rx2h5dYhoHpdstOha8LJsjRcnHwV4QH/v0B5Qcfgf+0/vSy/m
         8w+QIA76MQPqnheeTp6/nMZxHpITQVZszNrxRi11cyP7TxtqNNC/ML7kuKx4W4VAt7JM
         4KDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756949165; x=1757553965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TLkWJqA+Qpg0LFBNtfXvmc5DTZiOLOhodc1Nry+glzc=;
        b=UN8dHUQg845Hux4OTyPMCLFYo9gLfVCnFRVS8IbkShlmA0EpV1OWGyLfCaZnreRHcs
         hVeNMXMdYBYSRUUpT0QCWzlhdoh7fRrJR6XNel/OwGrOf3Ks+OqdHKjmy+lF1Mardrya
         P7DGXoSpXjla2eNHfo3i0Q5uK2VFdqFdYufVBpqviRSBotiM2VzaIFlccHg5gYdQSDHM
         0Ab/SYWomE7fT/AU/GVf5xNPmIIB3jy+fNleikZN22OMwpSJEzSEJHjNc2G132xetCal
         Pw9UjaGiOkbRe1iW5esaLyOCFSvlbjdcHDC5VJOyF/Ks1LNX6D6AwppvALPW196+8q5p
         /BYw==
X-Forwarded-Encrypted: i=1; AJvYcCWg0mWNlKBY5f1rLZv5penfKJLga3HxBy+HgxGCuWAzNvM07DeJl2Lr1m26ZG1xLO8tZcNS6eZanWOB3Yk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs/0D7/tmORtzIcnLrJghDSUn9b8EUDipWkEoSqXsRR7ewYCeu
	DJq3m4cep22/7Q2xdmyo6G3qyjBrGGB2ZWakN5x0NYcZ1SB5/G/nen8X
X-Gm-Gg: ASbGnctFrlPLchlSfj8tV1Ippy4DSyXuOn5CjD3GqQYBbVhZWxSI8zXb4ToB8Nucr89
	UFd43L3lbkB6hUnGGYJ9BKFN8zh83hw+CHpu8r0juYMg7KAyH7+tJfWEucAiWgFEK9aiMVEAYUU
	d2V5BdA21/mumYhQmqJyXB90lG+W+4VzRKtfka8luVjyPQq6b4uqysaxTLPo3FRyrZ/axpzaAKT
	IruhKBkVvjHBUBETCZnQHz+KrpNWrpL5xjReHUYFjGLRUSqtD33ivmg5ixezVg7typdK2x7u1K9
	7O5PvuQIPJ0dLO0+gcOfcUjNeO5IqKIst8pH/o+kZPmRrSmfT6fWmO3AWPg7iAEH9cYgn5Mlyj/
	rZ4dhtBUrtCYxvXZxjossmmT98oMsoY3baFkl8sABI12+/r0zYtroBVo4JpqB56IvpliPEjpu
X-Google-Smtp-Source: AGHT+IHuH1eBpiwG5vcqaGvUdDOknBvDXSPL9gGVmJCrJaxicgfo1GvDc2matEFCDaCgaDcEdCsDKw==
X-Received: by 2002:a05:620a:2805:b0:7e9:f820:2b60 with SMTP id af79cd13be357-7ff2c32f99fmr1705598285a.74.1756949165209;
        Wed, 03 Sep 2025 18:26:05 -0700 (PDT)
Received: from linux-kernel-dev-start.. ([159.203.26.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720b682faf5sm38423266d6.65.2025.09.03.18.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 18:26:04 -0700 (PDT)
From: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Subject: [PATCH 00/16] rtl8723bs: cleanup and style improvements for better readability
Date: Thu,  4 Sep 2025 01:25:20 +0000
Message-Id: <20250904012529.215521-1-vivek.balachandhar@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series includes 16 commits that clean up and improve
the style and formatting of the rtl8723bs driver in the staging tree.
The changes address spacing issues, indentation, comment formatting,
blank lines, and minor code clarity improvements.

No functional changes are introduced. All commits adhere to the Linux kernel
coding style guidelines to enhance code readability and maintainability.

The patches have been tested and are ready for review.

Vivek BalachandharTN (16):
  staging: rtl8723bs: fix spacing around operators
  staging: rtl8723bs: remove unnecessary space after type cast
  staging: rtl8723bs: fix overlong lines to conform with kernel coding
    style
  staging: rtl8723bs: align asterisk in block comment to fix formatting
  staging: rtl8723bs: fix logical continuation style by moving to
    previous line
  staging: rtl8723bs: fix indentation to align with open parenthesis
  staging: rtl8723bs: adding asterisks in multi-line block comments
  staging: rtl8723bs: remove space before semicolon
  staging: rtl8723bs: fix excessive indentation in nested if statement
  staging: rtl8723bs: fix unbalanced braces around conditional blocks
  staging: rtl8723bs: remove unnecessary parentheses in conditional
  staging: rtl8723bs: remove unnecessary braces for single statement
    blocks
  staging: rtl8723bs: add braces to all arms of conditional statement
  staging: rtl8723bs: fix line ending with '('
  staging: rtl8723bs: place constant on right side of comparison
  staging: rtl8723bs: merge nested if conditions for clarity and tab
    problems

 drivers/staging/rtl8723bs/core/rtw_mlme.c | 421 +++++++++++++---------
 1 file changed, 252 insertions(+), 169 deletions(-)


base-commit: 5141ae32d4b8971d7b689854fd47a200e695bda3
-- 
2.39.5


