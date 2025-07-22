Return-Path: <linux-kernel+bounces-741614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C76B0E6A4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 729F256703D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC216F06B;
	Tue, 22 Jul 2025 22:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+5cO1yB"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FFB23E226
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 22:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753224361; cv=none; b=sU6RaWaVT2QMAmJXW4/uWtuB2vjBgo0KtlimxlnDztbeWkcB68PohpmfsdY1v9Ut70edDNx9cjZNkXN7FYp0kZOSFAyqQHVqv4oPYJ+3tfwGsVLIrUh/ld75pT4oLeFfHrQrrgEnTkB5CQ0669jsWhxpsNoKOrpagphALqceRTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753224361; c=relaxed/simple;
	bh=WmOYzvfLSIwwYh7wzvFvwUuOmGGBzeLGCfiUywOY/4A=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=smFTlAgOgRWaQsyYD/BJd4QOp+XaZcI6HInBAEvjVOMUzy5V2MORmV6oah/lvCFFa3/OcwEMnjE2p5GBDQXTo7qbYUXRNjQRdj3qV3Gnsv5LOMf/D3OFSon506imDrj8j9p6ImGFG5S3rEKUFejVy8n54xixj+cpcOLKSKjLxCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+5cO1yB; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e62773cab8so81473285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753224359; x=1753829159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WmOYzvfLSIwwYh7wzvFvwUuOmGGBzeLGCfiUywOY/4A=;
        b=B+5cO1yBmPLRU5CuG/p9pMPUOaGK6yz0IhjEuXfw0mAxbdUYlOVMlHzy1knozzhLZj
         cRpML5AGHFsZ+NAbhFNw4Bm9rP9H70Mx/hnRO1UUHhAAoBkQFATNVyjJ8ZYDolW5yuUe
         9gqsgheETPv4mGbP6ntdQqh2MnuppMx/iVSBWU6dGL6nfz50bkA8rpar2ewgSSnSutzU
         QRA2fMGkZpNlKC5SFTPMRz3Zu0JyPJvOuAXyy0F9eo8s3B84ySuYicEGKZFuvTBqyEru
         gHCasAj/JOlMl6tmNele7N8n/Z5JJvcL2ZfsvUsURt8VRGfZd2V9h7ep0W+6vpJlgVOB
         FWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753224359; x=1753829159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WmOYzvfLSIwwYh7wzvFvwUuOmGGBzeLGCfiUywOY/4A=;
        b=fUSBB1ML4xAfQf0QHDG7EB1eCgRNE9n/Vl/1Ox3yjjoo34wQQfcaDRc/rIv2Pa/Mj0
         6/vdJLeADfXigA2q8yotRAstpmJ5Sxy8yHWRuYvqgpsbVUUvcSnaRoz809LE+B+IWqDh
         du8yfkKO8oBfS+yzJwo8EfBWjWSywz6dM9rkx5ewCyjLqT68at/0QZo0k4rca/QK/Et/
         NXM1pVaff7tg9ShHf/SIUsbZmbjLrhpmA4zL5k4Lj/mAodY6YjbvuvydDHGGwVEtNTwO
         TzhcvFpK6TBWUXdCHh97pRB/5n3cCPH8q7nlq/AYsU/Qyz50iEczL4f1c637He/02E8t
         GIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVl08mOkIctiy/qB7sX4nAt3ivrj5DjVjCxLHE9BCd5wFAvObjAzKM37OImf4+YCAjFCaxDLlOu2yYz3ZE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe1DebwQLmg45yd2bzZe7Mu8l4tWBCiH1F1IygV5evpjC8j1K0
	MXcqYsEIUs8BePwBe+dvE7Ku36J3/H3y6x2OII7KHW8x/+O8DpoVQ+5nzJfMbVI6OvSC4A==
X-Gm-Gg: ASbGnct5+XpYOXSlHstRRqmYYceuvEMJXnkLwYLAB/Fq3XLMCbc5UR7jLQ8L7shQohN
	PITxMfJvok+XF6GhC3NHqHJxEEiSE3jMet0wOZoRZTLFu605zJrlN8b1mfOqbNC5ZCW6q1KWZVV
	DhukT2KuPaCO+LZeel2bf4o5S5REB+7Hs6uOE+9q4Hgb49XdsYut47Q1udT9XuHK91gL3kVSmsn
	AhcfU6f/K3gE19fMkyWNrrAF9AHELcqFB2814tnCNtd/8h4WDjm1j0tRmeXzmrTRAS4TYsZnkIS
	8dNqC9XIACIxpDjQZMV9Sq3sAueMIHiVUkmEhEa8FDKph+WojDampnZpUSdkAufNDrxOQcZdUVs
	K6UdgzSUdiTElKL4l5RfG54HWfTQq2u8=
X-Google-Smtp-Source: AGHT+IEVA0gP7rpWgRF62f94AxPhbeudU1OLrryLmb7oqHBUUf1VI3MNu7eyhhPm4ZYlj5X4YUgxLA==
X-Received: by 2002:a05:620a:458f:b0:7e3:495a:2982 with SMTP id af79cd13be357-7e62a037afamr156349385a.0.1753224358664;
        Tue, 22 Jul 2025 15:45:58 -0700 (PDT)
Received: from Gentoo.localdomain ([37.19.198.68])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e356cb6007sm570968385a.105.2025.07.22.15.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:45:58 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: unixbhaskar@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scrtips: There was a gap between the bang and shell path, eliminate that
Date: Wed, 23 Jul 2025 04:08:46 +0530
Message-ID: <20250722224318.31149-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There was a gap between bang and shell path, eliminate that.

cc:quentin.casasnovas@oracle.com
cc:rdunlap@infradead.org

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 scripts/check_extable.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/check_extable.sh b/scripts/check_extable.sh
index 4b380564cf74..c4b821654ff5 100755
--- a/scripts/check_extable.sh
+++ b/scripts/check_extable.sh
@@ -1,4 +1,4 @@
-#! /bin/bash
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 # (c) 2015, Quentin Casasnovas <quentin.casasnovas@oracle.com>

--
2.49.1


