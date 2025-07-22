Return-Path: <linux-kernel+bounces-740732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0304B0D85E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D71195471BD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402612E613C;
	Tue, 22 Jul 2025 11:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5DD64ps"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4062E62AD
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753184238; cv=none; b=LqYaTaa06jbnNFJjcRaisEXseXD06vnToH9GzLhD4Gkkb4spLNAubKp3rB+MhJav/H3523M/eFtLojMGc3bdzNuI+PxdmqL9eZHo0LAxaOeypEdPF/x22UoCkGqYWqfylvvyTIXFhdMp2gmA9KbxIJFl292x+zW5MVJP+tlUljo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753184238; c=relaxed/simple;
	bh=YqecPqyoaL02sSldrpSJs3Jn/xHZ1BWIinfXca6Y6EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DNpiparK/NjWQrd997Tn46hDtEU2t95H1TtKNJxinpHYlaUJYxvVvcL8OYja84ffCVby75Sa8SD57hoKw/FAP5umwyC2RQCbRN0Wt/Yck8zymcSao1mpvz1ddVMBhU/H/LugwDTI1DbQETJjhr2xovzLWvpr+7600YoSbbbW6Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5DD64ps; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4aaaf1a63c1so40738581cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 04:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753184236; x=1753789036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFWmR+mgSz3mw9gW/sdVCR0JOBB/eekxLWWx2jA3Uvk=;
        b=f5DD64psvXquDYrNTIt5OquKjVaAeD8047ZgugzEBBI8+INLODrAWWAVd2asdKnZ/v
         q8EJyQeBcdeXoy8czhHKH941QrFruHI4Mh6bydNj/FO7fzpTXIATUHSYReTowhQvl9Iy
         z94lWwPVVUk+lFr8zEE8dFj50Po4WdzjvS95GjGasDV4+TkpIjcOnb/YBJonyAGmq8uW
         uHXP8CKhqku2ypu4A8p3hsq+EmbxzLQxVy2G6cpc9xvjVMQkFw7tcBOsNrUVwrVeXUG2
         LPeWXaEJpCfdbXI3N8Zuh88v8cDqB7F8xXWp6SliPtfvD9tSmU6P6O6YvSfWtJiQt+BV
         soAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753184236; x=1753789036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFWmR+mgSz3mw9gW/sdVCR0JOBB/eekxLWWx2jA3Uvk=;
        b=oT6tSVIXeLxoWiG26CC47tdpL/HLGXBjxq7lun4ayPLeaKhq9wZjXgFOC0FLTzeY5Z
         fa9Uc6EbfCGKJ1utGh50YI7jW0Ee+7wz/ujn0ilIQSFSBc9BEdPzR+TQOYmGPTJzLsXj
         nIPPJpTGLNdxHdSLtNK+/qMXa+sqx4v8gdLzzSGANYtD10GdlXUOtwaIJLZLeg9ZVijJ
         AwQPbxLLPVltPLf2LKiJZsX3EiogfyY4fGaI0kP0aIHOL2JZodlPTd0musE2S49L4GL/
         LCVRlsCCba0V9W6EHSvZXXKlQui1yM8a0KAYbyKtr5api0kY3gZkG5wMsmFsoadCZQZ9
         N5Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUZshRW3iM2o31iobH8wlF+P/RJm9ux4ACcfIzlmSEKKRblzK8LJ8VcfpdM4l8Pkbj6nlgroRczbS0b7tM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQORgV2olYD1xvv857sX3qgEc/VZxNztdYGhNSWzWq6Wiiw8H
	sk/B6Hlmulm7DoU24dadmgQEDs/QDF0KlIQ728yiWzuHBytQ9GbUaRp8
X-Gm-Gg: ASbGncv5GY///kDxejEzBxaU9gpw7DWbSZvU/htxPZASTFP5hMAtbfz+5uSGV8NznO+
	D7vRyUefHFQCUIVO+9cW8MhO0efZbduvH+Sm8H6T8JnxpxpBOwD5nYEMbUVOhIx/MUqW+JHPOcM
	kFq0zKNZ8Mg+nzcKgdIm27494BZ/vreJDqM79WwV889kWdc+yVwOOGeDjQ/M7vHrkd8T/nHTXXS
	Dahk5PdWnVd75Cz42+HEmdvpJT3B0M7kfqwBvMAYi7dLGfzw6SMa7rfW8D6Xo9IeRx8+OAspcas
	tyMFA7VPWpxabQD8lnmb9jo4pEI+pnIHf7sZUKQeHXUhU7THTPhYdXu2rFQE2VmTv+aF1Q4prAu
	LAyQEChbODFJAx0aCI59vv3D14AkXHoPbNQ==
X-Google-Smtp-Source: AGHT+IGNuDp4MyAmrhzlRuz4wwS0+hbtcVNVPZ8qqWGcaCm64leoXPeoCiI9lsu/tIBJAiU7qCSXuQ==
X-Received: by 2002:ac8:598b:0:b0:4a9:a3ff:28bb with SMTP id d75a77b69052e-4ab93d4870bmr325506361cf.25.1753184236014;
        Tue, 22 Jul 2025 04:37:16 -0700 (PDT)
Received: from Gentoo.localdomain ([191.96.227.162])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4b25a18sm52457651cf.59.2025.07.22.04.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 04:37:15 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: rdunlap@infradead.org,
	linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH 09/11] Shebang line was missing,fixed
Date: Tue, 22 Jul 2025 16:47:05 +0530
Message-ID: <fd28a8b827ddf6afd86b22117efc27ef1768640a.1753182971.git.unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <cover.1753182971.git.unixbhaskar@gmail.com>
References: <cover.1753182971.git.unixbhaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added the shebang line at the top of file.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/perf/tests/shell/common/init.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
index 26c7525651e0..9e9d4247ada3 100644
--- a/tools/perf/tests/shell/common/init.sh
+++ b/tools/perf/tests/shell/common/init.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
 #
 #	init.sh
--
2.49.1


