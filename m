Return-Path: <linux-kernel+bounces-771991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90980B28D90
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 14:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B261CE1D29
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 12:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA969291C1C;
	Sat, 16 Aug 2025 12:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeBWnzBj"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03182248F4E;
	Sat, 16 Aug 2025 12:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755346063; cv=none; b=Iz0FMdKEP3vU8VuFhb/xNuj7ONibBw5jQV4r3236K727exoY3FVAvtaBzzGGJGJeKCW87UdCf1U5LJ+VugDmc1uw97gOATm1NEikzWaXiX6pWHkEBXG8wSUVmxf85Jhgb7XltNucngb1l+QBVL+x9a1fDica5KA4/H/3v7hPfnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755346063; c=relaxed/simple;
	bh=MCxqwdCyd7LpWhm3XSDiCEWlq9JFShUDrWlnI2qNaYo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HQDourxamDQIEDwyOpUYo2b/hKNnrtu+Q0Q1YQDsw5jbozgnWV25TBdl2bRjcczcZZORDbTP7G62XFFwUHSyLpovn5V8uJ08rylw4rWzsZ/wiQXcv8TVCiTkC06/L7INF7kteqRRVRakgG5OnJnqrTvCFvKxqk8+AtMmN8eNDAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeBWnzBj; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-76e2eb3726cso1667100b3a.3;
        Sat, 16 Aug 2025 05:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755346061; x=1755950861; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rd+lX086uWwRHrUMcy9FeLMXxOxDloAhR19zDZS3vQo=;
        b=UeBWnzBjwJxFsodFPczkZHsM70XAxlHoq25uN5loV/VDRqpvrSQ8o4nMjhyTWsdqwX
         IPf3gjS3coOH4PS5TcAViSL6x2yFtF7vU4zdmK1MzM+XgR15m8XllwTRPc//L3JXb+UR
         +vh+6bAlLS/zok6NfeuJcL9YyAEbHJ6pWTW1sxMz8Fdm1LzRUfOQrlSbwR2vlipnzgNL
         CgUy1prMsZOMxRITvF/iSjWZCiIg6miFp9FpBsDCJrKjB/WzA3Tw8E34hDlqz332eG7t
         te9KNyksEz996dU8L/JFuiSI8D5AVLDWn168wbHdxeKr8+pd+seDYesBlTapR9KMvB3+
         KPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755346061; x=1755950861;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rd+lX086uWwRHrUMcy9FeLMXxOxDloAhR19zDZS3vQo=;
        b=fzS1ALEhgmXoFBKCdR/ryqknmLkJb2q+mcwc6q7SJ/p2l7IZUaIhEIXdG6V2g6IrR1
         S0VVuXvpvIISHP6Vf1dvtQPKNtwAqbQF6vDGkvMrP8Ph3FaB+fsl579HUjH3yB/36NRE
         rwU9ejxhFSbGSG+TUyUzSEwuNVA4hxksym/T2ub0DC0cCXGcNMiKkQtZ/ZsmD2Gcvs3O
         aBPIcGguDm1BcT74aYCCnnXweNhZDZwwEW54lHXe3ovPz/1x+NKKnUxNkkbOdozedjJH
         EhKaicB8MuY+ELTwuPdHFiY4wyKYq64MGxoo8uwli4Xb0KAAg6Njuncwm424MUsCEjbh
         E55g==
X-Forwarded-Encrypted: i=1; AJvYcCUw2lI4dhOFQLyf78zi8JisRlAG+x5sSpfJq2hfSpyZrJmWtPa8TKcfM1XzquWhScWJiMF3/HsethRd+3h3@vger.kernel.org, AJvYcCWkR9oSD2D99cZo5QBqzAwDpfKzgyEd2paHCKR/ESgIGn9SD+asceTtq4nl1p0HovpS7BDMYPBMN3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGixL76rUihpAzPGRYBH+k6n0O+JJq13l6TpSCBhUhpOxs+QzG
	KnAcJHHxj33+AavicEZvCtLAs0NUlRxEvlgbI0tqNKdRR7Bvpk5//gXI
X-Gm-Gg: ASbGncthJTdKElFUaZDnpX3Y3PYL/0TNwbCfNyff300nFJBG4AOpLZXIMDc8f3ierMl
	lAIL5KGIITGHTMT9Rc+FontA6KzAvxbdQWBJpDxaUMazFEpJc/MKSsXNDXGtmceCU75cjAEiRvW
	J6zQWXpI3ahG6tIxXmwoA5XeiOYwctKG0owZWnbErYmbvT2BQjcdsA908BDLK7k69yQjLEWbq93
	6wOJSZt6CA6SJdgwkFduRkfoEOCGCGPxISj8dCaE9LWaUEjeOHQfiaFSo107I3Do3+ULFZrpexQ
	obxN4AZhFoh9bosxopMVRljLKuYyNU9BzYEyfV+lwO6mvggljespX1rGFIHJZTfASGqxw8GU3q0
	5hE8Ghb7GsiPkla2VuykTpwtTvWF5UDxghem27w==
X-Google-Smtp-Source: AGHT+IGGu+nvEVyKJTO0ATFBAbBRPloz2WymqvooTN6HuWRwGHbfAk8osmiyq3lFM2jELNZHW0sksQ==
X-Received: by 2002:a05:6a00:4f85:b0:76b:6288:e2e7 with SMTP id d2e1a72fcca58-76e4480b995mr7802121b3a.20.1755346061214;
        Sat, 16 Aug 2025 05:07:41 -0700 (PDT)
Received: from gmail.com ([157.50.27.190])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e45589ca6sm3199943b3a.84.2025.08.16.05.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 05:07:40 -0700 (PDT)
From: hariconscious@gmail.com
To: shuah@kernel.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	corbet@lwn.net,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: HariKrishna <hariconscious@gmail.com>
Subject: [PATCH] documentation/arm64 : kdump fixed typo errors
Date: Sat, 16 Aug 2025 17:37:31 +0530
Message-ID: <20250816120731.24508-1-hariconscious@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: HariKrishna <hariconscious@gmail.com>

kdump.rst documentation typos corrected

Signed-off-by: HariKrishna <hariconscious@gmail.com>
---
 Documentation/arch/arm64/kdump.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/arm64/kdump.rst b/Documentation/arch/arm64/kdump.rst
index 56a89f45df28..d3195a93a066 100644
--- a/Documentation/arch/arm64/kdump.rst
+++ b/Documentation/arch/arm64/kdump.rst
@@ -5,7 +5,7 @@ crashkernel memory reservation on arm64
 Author: Baoquan He <bhe@redhat.com>
 
 Kdump mechanism is used to capture a corrupted kernel vmcore so that
-it can be subsequently analyzed. In order to do this, a preliminarily
+it can be subsequently analyzed. In order to do this, a preliminary
 reserved memory is needed to pre-load the kdump kernel and boot such
 kernel if corruption happens.
 
@@ -18,7 +18,7 @@ Kernel parameter
 
 Through the kernel parameters below, memory can be reserved accordingly
 during the early stage of the first kernel booting so that a continuous
-large chunk of memomy can be found. The low memory reservation needs to
+large chunk of memory can be found. The low memory reservation needs to
 be considered if the crashkernel is reserved from the high memory area.
 
 - crashkernel=size@offset
-- 
2.43.0


