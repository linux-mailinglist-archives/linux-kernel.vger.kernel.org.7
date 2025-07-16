Return-Path: <linux-kernel+bounces-732813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCF8B06C58
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CAB4503FD9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5611FC104;
	Wed, 16 Jul 2025 03:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et+oFhfk"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7CC1D47B4
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752637090; cv=none; b=l8F5/SiZ6n4wX0TrgQMUtPynnwope2Xl+4rMy+bjKgHaIrIpSX25N56FzkhIIjT+TB/4tdVPlGYPfCJQYUdoGurqyVxlCWzWuAB5u1QC9J8ANL5FizyJZqmOrSNeWYCxCMlrYqz2XW7K64tDR4Yow31MLkTKV0+Z06DcRRbwYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752637090; c=relaxed/simple;
	bh=+FniijdGolTRpZ5tcmQ7r/3Xic0q+dOZ3BWLQ9qmRBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=m81H0yS/WP1BdP5Jr02L76unW/ygz2gk2S7qObwVYDNmVT9T+OXZWzPYBuQ0lxOdq3r1Dvkc6AWwXPI+4iMc07A57moofjWtNaSemS0J4U7q2t75fEYFXvFlTF3A6ZyhHCgH4YFbyCEWiQ3z9I9/F3Xph7bPyB7bx87rU7Hj8uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Et+oFhfk; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-73e6320e767so410836a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752637087; x=1753241887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ntZePFMmfycEIZ9kKC9D9juc8cWq8Pnx1EdDdBe+348=;
        b=Et+oFhfka32jRwKDwWPfNbiXaGDYGWsz5RoGFarKgmdqW9xkSOMrSBQSg4d8a/CZbe
         FY2viDjNG13IOhYfDdYDrb8StwLfXAxbdNIVIVANWuR1vhRLzIFkFJ3fzEMSdWaOcwv5
         EbsAY4/2dseM7T7qvYE50gbOdEgAJwuQszmC4JJRvITuig52sZkJWSfpf+nX6uitdFCp
         cXJC9ObFKelJFSLCrFNiGBUzJxyxvBn4KbUFnJOL7MYqER8UnPRh2Py2qLMDo3gEjIav
         U9iJ6QcxTZqeq5lhsar5ICPoPw9Tla89b1Cw9tz436izpv85Drfzsf/a3Uvi8JkNdY7/
         0U9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752637087; x=1753241887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ntZePFMmfycEIZ9kKC9D9juc8cWq8Pnx1EdDdBe+348=;
        b=dm011O3sNIV27QLOGHmy90oXYMDpHuYqh4PuuRtaD0vSu/2j5T4MpR8hhSfNeMT+Mk
         XZiZcL9gitNCZbrT4XTpj5GNqaraCY44OtvutXICWh1afi0+CNSP2OxObp8vBLPqAGoo
         jOsWQwCN1IkHTgnWBvU14NrMJo+nKzDiwkmQ2UB/dYjNAcnjYoUb4sUvVMSZnYgKdmKT
         CkoFqHLhyu9/FJz6xI2e020SNgXsUqS2sSO9C47cqcHIRyyABYdHF6h4n3cVIJnribA2
         8cXCfgiGn6HM5KZPTofKIw6exOFBEhVLhaUljk6ouaYA6HtpABfHWdiKwEB2457tVe/8
         U0yg==
X-Forwarded-Encrypted: i=1; AJvYcCUvS+jQnk7iry6FM+fWDwymCLDvSW7cILPY+Q5cvpGDDBPBxFFYnCfnOudcupijtpA8f2rVEh/ELB+9cwg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIJCuRzbfP8QIYdKGtckjo7WqIRPfhXZLJPv7LUm6INLF0HxVX
	OarZn42XJOR/JzNzue2OsThLbaM8DQXJjDcEpZ6+Xj2tDzODatww3JKi
X-Gm-Gg: ASbGnct79nB6afhnnVoz6HJWg+7A8d8IpR+46ApXtfM0Qv2tln7ADOrbUWhXFa5p9Pq
	koHAlWeA5a0YWMycy3VCoLl9ccBUl1Ir8oLUBsANudG6ojWjRvdLp8ISCnYVLO07kzgzOldI2NB
	2Yi8Dn8HiO87ThCXJmVSBUMAmv49r9wBb/kTBgfE2L9gYiCIvZp1A6Qo2PpvWHpdc12rz17J45p
	8Kc4/5Zbt7WCht4ysbDUs31T/X2AI6hBVfhJh4Y+8LCdfjrUDX6BFmrwJfKPYdRJNTbubN0+/pp
	FTnyVwdBJu3IatjFZpCqJ0uBgCN6npJIT7v2c08sQd1At3h+aporeTcw7ztIHXRwKtAZ39+27B3
	SmaU8tmaCFqM05z9nLgSqkVFK4LT4ZcUcesAzgFcyjqmXPpr4l1OV
X-Google-Smtp-Source: AGHT+IFoytJfvWvzcNOgoGowJg3xnSsJh6cfYIbKbpf+p6E+SdtGYl4YQM5aoodeCH7BzoE5xfF7vg==
X-Received: by 2002:a05:6871:890d:b0:2d6:72a4:4c24 with SMTP id 586e51a60fabf-2ffb24b1392mr1085689fac.32.1752637087613;
        Tue, 15 Jul 2025 20:38:07 -0700 (PDT)
Received: from localhost.localdomain ([181.161.11.224])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff116d22easm3140980fac.33.2025.07.15.20.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 20:38:07 -0700 (PDT)
From: =?UTF-8?q?Ignacio=20Pe=C3=B1a?= <ignacio.pena87@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] staging: sm750fb: Fix checkpatch warnings
Date: Tue, 15 Jul 2025 23:38:01 -0400
Message-Id: <20250716033804.59650-1-ignacio.pena87@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Split single patch into 3 separate patches as requested by Dan Carpenter
 - Each patch now addresses a single type of warning
 - Ensured patches compile independently

This patch series fixes checkpatch warnings in sm750fb driver.

The patches address:
1. const declaration for g_fbmode array
2. function parameter alignment
3. CamelCase variable naming

Ignacio Peña (3):
  staging: sm750fb: Fix const declaration for g_fbmode array
  staging: sm750fb: Fix function parameter alignment  
  staging: sm750fb: Fix CamelCase variable naming

 drivers/staging/sm750fb/sm750.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

-- 
2.39.5 (Apple Git-154)

