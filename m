Return-Path: <linux-kernel+bounces-732778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1E0B06C05
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 05:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0014F17F451
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 03:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF6B27702E;
	Wed, 16 Jul 2025 03:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXWLrd09"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5AC275B1A
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 03:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635345; cv=none; b=YX/mv2k0aJAaLtZ1wqsV4TXC6bmfELqsHUg/qNY503jHm2RKezsZMFBnJBCEseLe2x4kZNSuNiYT4cIIbmnWqI90CIF9uDu7UybbRPx8t9610CrW62WOwH3vz9OUyxLoSzueRCNkiY7JUCukZtASK9DdK2fbGqKG1PCA/n51ZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635345; c=relaxed/simple;
	bh=aw1qrn3XItFfU33Kee5ADNSklF1prnnPtVpwdJRKlBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gh/xsy//AfqBX+Ns1zDU6npyxGcVtVAv355IhES2mzoZHEVFPmvN/H9r6kjVOICmeh7fmCwyI7vN6On+ttjIX+2RG3m8WmAl8ISwfzSG9YSWi2fvZR16AEvEtqkdFe/uHPkX5t8I/gpusHWIkyv9VtVRPnYr8Wk0rkMLisl9P7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXWLrd09; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-75001b1bd76so2491063b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752635343; x=1753240143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GShlIz/kV03jSXdv9D20VWxN4Rmrvju7eLozrnVV9tI=;
        b=EXWLrd09R8BnyI5nDZg7On152o1msrCAvU4Yvco3M/b31P+aY/D5sU1iuzg7jNMoZF
         bC4SsU5SeDhrA8idq4SIMfhCvVEX7Ys0f6OjV66w7rndKlw7WGtL0WR4cxymE+R+sf4z
         +ogmqGkyARG1oA4FYNWdL94E9AA6Rf4i+TBvLe3Rl6BmRKcPsC4e/2zC8FNseNmKBYBZ
         LRhuX4PFA9GIYD+bO2X9di5ol7FdEgZaNrEBsSPbg8B1Pqsi6LIxj1hPw3qpCZP/SfKl
         2cN4AA7CvZUIKQOTrtF1IK5vmcczFqLvPgKVTaiJbMzFjtEAUJ0XDFkaiDPe/7Y8AHGt
         BDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752635343; x=1753240143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GShlIz/kV03jSXdv9D20VWxN4Rmrvju7eLozrnVV9tI=;
        b=UTfMlIKMMYnObH1afqwfGuBV1z/2mcLZ69uVeHQqaOC/9t93vGYVpq391LurXrAe+m
         t7jAxoaC4xoQhdS4KaXLAdvJUuoC2D3SyiB9VvFLyWbWqP7kkYreT+2uox3eU5MNUWIh
         5nLmymv84emJNkRv7nqtJ3IJcPe7fBomFtbjVfYaoKZUX9HATkIXED9OXM4GjacrNBNW
         onu7muQYWYzz8lGTudHbOX+9hqdcur1g5fOxqN+7GRje3XFvfA1o7+lWaNUENeqUtTLK
         xESZEN03ro6LQulGJwZKKTppNevVB043waa0byVkdiLGEWHr+HddzbP91s/7r541ZY6b
         dhAw==
X-Gm-Message-State: AOJu0YwkCVy9PUA016eopw+tq9EbYrXijCfXl5Q6DzYC41oD12l6S0KI
	SDtIG9vG/QNBMm2BD9PD005aPd4GqrjhGz6+rVvtTuvGkigjZwtIF5I=
X-Gm-Gg: ASbGncsjwvSvmP5LhTKaybQyArJn3TB7KdAj3A1lZy61ZKvkduc2Buyrt+KW8e+2QqG
	Sc02+hZ8m1VGrJKUmt7XlcF89Q111YxCXvrtgu6K/+lSNAOMp5s5G//XbN1r8rvLXrZsGd5CiNo
	KXtepQMeQA2QD0gP9Nq5tLsOtNL3aQ8FeL9fbR4R2902AoTSdwQyW1TKKMnQQeEdApji98fgILy
	IP8zr7w1q8G4ePh3k2BfoJovzeYsetayC/LXiBi4OaX6qjjm4GZpvX4ayGeKiJGuerS0lu88FZf
	7DwmzwBIl6wutLQbdxv7gEL9ntd6ZoHCBSvo78u91eWGZCKiJGUhk9A/TIgUNrIbxpphXCSLuiy
	U5BH9YUBpA0iObOXtV1HL8WcZb3/DajHmnXbP4Hc6Ezv/cFQQ8vlXi6lnCBiCiw==
X-Google-Smtp-Source: AGHT+IGUvDZfp4nDsZMynfDw5DKl/QxXUki+UZz/BuRd9iOC062/PzN1plTwx2vKMToamJfvbMrGuA==
X-Received: by 2002:a05:6a00:3ccc:b0:740:6f69:f52a with SMTP id d2e1a72fcca58-7571f911982mr1371901b3a.0.1752635343401;
        Tue, 15 Jul 2025 20:09:03 -0700 (PDT)
Received: from max-MacBookPro.. (36-237-135-199.dynamic-ip.hinet.net. [36.237.135.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9dd603asm13549549b3a.12.2025.07.15.20.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 20:09:02 -0700 (PDT)
From: Meng Shao Liu <sau525@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	visitorckw@gmail.com,
	Meng Shao Liu <sau525@gmail.com>
Subject: [PATCH 2/2] samples/kobject: make attribute_group const
Date: Wed, 16 Jul 2025 11:07:34 +0800
Message-ID: <170a918a8e14b1e0c003b6e277cd5813631c2749.1752634732.git.sau525@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <5be61d284a1850f573658f1c105f0b6062e41332.1752634732.git.sau525@gmail.com>
References: <5be61d284a1850f573658f1c105f0b6062e41332.1752634732.git.sau525@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The attr_group structures are allocated once and never modified at
runtime.  Also to match the const‑qualified parameter of
sysfs_create_group().

Signed-off-by: Meng Shao Liu <sau525@gmail.com>
---
 samples/kobject/kobject-example.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/kobject/kobject-example.c b/samples/kobject/kobject-example.c
index e6d7fc18e..36d87ca0b 100644
--- a/samples/kobject/kobject-example.c
+++ b/samples/kobject/kobject-example.c
@@ -102,7 +102,7 @@ static struct attribute *attrs[] = {
  * created for the attributes with the directory being the name of the
  * attribute group.
  */
-static struct attribute_group attr_group = {
+static const struct attribute_group attr_group = {
 	.attrs = attrs,
 };
 
-- 
2.43.0


