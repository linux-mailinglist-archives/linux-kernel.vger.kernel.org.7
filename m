Return-Path: <linux-kernel+bounces-741581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B919B0E60E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 00:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89A577B3B37
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 22:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 909E0285C89;
	Tue, 22 Jul 2025 22:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z1oiHa3C"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E71A95C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221811; cv=none; b=V1+HZSocTuOe8Q5IVa+WiAm1U7vVkU8A41oGitcpAUqWvq8t33RgyW6e4IO/K51hkOAkST+Sn8wdNLWj9Lr/1xzyYNC9TuP+yIEXLpBhHBElbh88+/7fmuoEZiHcq+Gd+oPMNRTZ+czqt4zyXPt6nr34uNY2BPPFSoeDnuk3O88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221811; c=relaxed/simple;
	bh=8gaRC/p4Q4aGxtDVDBYY4mEonX+wM6f6zjphXhzfSvI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JTj0fVBSSrO7jJp+zt3yd7qylvWAZGi3cn/h0MnMkAPaeU67+1GOdU8JUf6s6id0WqTXsPm2eRNPiRa16CCIEZSgWU27GbDB4xUFCud5EEW3q7x2AeT15v9G2J+EviIhffEma/7o++SoiETYT8LegSioLaFMKp+J0GzSa5rDPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z1oiHa3C; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4aba19f4398so76808141cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 15:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753221808; x=1753826608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8gaRC/p4Q4aGxtDVDBYY4mEonX+wM6f6zjphXhzfSvI=;
        b=Z1oiHa3CIeaCM0uvsbMkjzyl8tEcYiSDmMCsycvZGJgJjdHrwfls/2eBRWI6VDwnaV
         7/pKoGQoMco7nG0aPpyW/BCyHdHC4e7vycvoQEn7niXRPMDYQTgMBC8CA5K1bJ55vUP9
         htOg2SUsLhGF2g4BVm/VXFReshn+vY4BitMy235GPRBwC+lk0PtVvAYLac/XZVTgJSqM
         F14CONdUmOYCEtdMjpvbHhQbVcX8Pg8GnFvTraQ+jtF0i+/9SIy0BwXB+8oCbkfP/waY
         m6lo/8fst/xUCz3S5wlfUDSkWT2n7Zkkv6ljBf3CPidF0fsesTCoFGmjxF6dnJLzFfpG
         hUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221808; x=1753826608;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gaRC/p4Q4aGxtDVDBYY4mEonX+wM6f6zjphXhzfSvI=;
        b=P8pO0MWTfyyBNLuBtVdKxioUqjU+FGZRbqNJuLazEWIq5Nqt+CeqJMXZBrk5YoIGDk
         Q65Tx1MZAE5TPJbzCRfEVqf2FHzJ5CzZDAtglUDv/Bum8mgdiOcgkHDNO5Qaq7tHsY5g
         r0DYRFCccgvatvtQe24Zq+I6e/sMSRIt4LElLjaJKSbjiunhmCNs64hVXdQ2Rcrq/t0p
         z1B9+NygZt2/VahxZce8DGcB2K355u87vDYTjIwdFxfjo2s+DDUhXaGY4ztpmqM75uFB
         ku4TrkokeGNz0QGR1eHxulBsDvUhYJKF2q8Ti3e9D/oJ2YohXy3fdQVy3IqyfMvuCyDs
         hoDQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH9c1FPBfGb85uVMDUhQp00T0idPGTzMxJp3CfMSvZSV5WXQ5ZbrfnNGwsj75isRLWhnDIdBkoBfXcXog=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4erp5cMvSehGl3dO47kRKVt/tnvskZ/2f6lJalqXHqKmDpv6G
	5TEP065BVmPKjBH5LuuCvD/QyBkeabGbsaX/aV7to+JlITmV6IzjQnQU
X-Gm-Gg: ASbGncsGdf3+HiuEi5GX832hU1TT4S65WC9j7HIPROlhEuu1IYQOADucfhDgjDdLYel
	fBVO7G162qLrVNHGgnKZ774AEiD8/PJT59Kcfg07er51AgcO7ghYxxhw7zJgB9YhlT2OiPXcHu9
	3ARg9M+p9TvpyMqIvKt2t1OZwRD0IpedjAIjSBd14MDsC9Pi4OrKr+Gx6Qjj6ku6BNc+CApBtFa
	9BWUAD3UxvYmZsQX/lQl0de8hP6eTi3t/NkpVvv3kHCnZHxZ+fspRy0c/hJtWZr9xBFlONjNaO9
	23xIdqmSBW57F2thvbd4CJGtepYXeOheXIetO+x2ae+Zuk3te1abibO4bHu8GsodWBpehLZa84q
	OlH700I9obUl3zVC36ohA0PMPRtceYIY=
X-Google-Smtp-Source: AGHT+IEpNRQJ6T5vzv/FNgL39gSRzTBG2YyecWT7w994rp7SG04PiWOJwSGopyCWX528hfAKFDRFNg==
X-Received: by 2002:ac8:7d46:0:b0:4a6:f532:431b with SMTP id d75a77b69052e-4ae6de559dcmr9515681cf.5.1753221808232;
        Tue, 22 Jul 2025 15:03:28 -0700 (PDT)
Received: from Gentoo.localdomain ([37.19.198.68])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4abb4980305sm59143691cf.6.2025.07.22.15.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 15:03:27 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	unixbhaskar@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arch:powerpc:tools This file was missing shebang line, so added it
Date: Wed, 23 Jul 2025 03:29:36 +0530
Message-ID: <20250722220043.14862-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This file was missing the shebang line, so added it.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 arch/powerpc/tools/head_check.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/tools/head_check.sh b/arch/powerpc/tools/head_check.sh
index 689907cda996..a9cd06958921 100644
--- a/arch/powerpc/tools/head_check.sh
+++ b/arch/powerpc/tools/head_check.sh
@@ -1,3 +1,4 @@
+#!/bin/sh
 # Copyright © 2016 IBM Corporation

 # This program is free software; you can redistribute it and/or
--
2.49.1


