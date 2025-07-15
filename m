Return-Path: <linux-kernel+bounces-732600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A930B0695B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 00:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B075F56496B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89E32D0278;
	Tue, 15 Jul 2025 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fROHe/ie"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA8E2C1786;
	Tue, 15 Jul 2025 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752619129; cv=none; b=lf1I+WU5r7d/CiKt5uyl1PS1mgNJ0cd5wjUcgmqJgv3TQAteMlacCzelpxjYvzRWG8pyQ2s2k5TFoLA/gR2NQML2RStiqG8NDFomZATz+CvZcUFvD/EB4pA1fCDJDMyTBRO06xbsu7L/ttfDQpyU1JqLTCwnM/Lni9NzNJPfyUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752619129; c=relaxed/simple;
	bh=kSh8rcNf5ojIJ4tUvmBVO6Riz084YDO9AXyv9jzz4Pg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiKPvBX9fvcGgGwhxCd+OzJrALvvMawO4DM3YeZKY2MBKngCLVEQKWayNnYDMMlO+Brp2kqN6kKipythv5qOHHOeiuxHlDRask6xzOJMIBaLXdq5gbROJPMujy5zO8SQPOiAow7f195kfHLhxiA6/z8OBc63n7eArOiFQ/q367I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fROHe/ie; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234bfe37cccso49780725ad.0;
        Tue, 15 Jul 2025 15:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752619127; x=1753223927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMHzguab1ISG60/Qj0OMV0c44NRNKay9hHw27b5AXY8=;
        b=fROHe/iei23E49oS9qKoUTZ9q4OZQt+EHOGjol773vr1q5RcgocB09m7KJ3r2vcB1H
         nZFJdnmGV2Pb7k8HRlqopkTzVnbfviNK24LOGaMtSWkpDZ2OtiLUVe0Zr1wPnzJdyiCy
         RCTBegMRB045ea27lkIVICVRdnLHFMFlAPa54Ng/y4aHaLpbHFtbwRKc6uGbDvkENQe7
         MHOwY2fhTleInTdn+CsNisv+1XUUjkk5q1tqfZ4olS8tBlRFoXTuMdf7r+xRtYDWK6Aw
         AKsDO7F8cVjSJ3UFf0/oGdvtaPcbAIwyXuGM1Xd15zNfNGwqWaha5pUKsx0vL0ti+uss
         EWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752619127; x=1753223927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMHzguab1ISG60/Qj0OMV0c44NRNKay9hHw27b5AXY8=;
        b=CUCTfG332wZMPix1Fh5vpSm5LNsoMi20ceLo5nHEI/HJyfKFqcpisd21/t5HUVVfr2
         9O0KUOuZCO2Dv9U/izgEfIrQEckhh/fZM8ApVuPXGkE6DnxuXf/IxUoSLolV9EjqcZwc
         mKTKyY/63gq/x6h+Hg/Sw8VC/iqh6FObYN+2sCnwbyankSTZ9uRaYRgCdYmO1PB0D4kV
         VbqcwKoLUchB3QJCRXP51LpG6NhrdN7fxscMiZJCOqUyvlMiRiB4pUjTPmNJkLJQCGhe
         eFLfbx609KPan8c1YqEh6rvTOunv3fwJL+k2ETxZqpeAMPiMfS2slNL/LDqA/ZLfBoMs
         uJTw==
X-Forwarded-Encrypted: i=1; AJvYcCUrplp26r+bhAFJAahlXZKie8whrHZ68zp+KOaSKMnbFB7DFI+PWBhk2sf0BN7lZocOAaza5dN7ndA7MlU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjd24ZIPKZmeNdF5sqjZ3Aq6eWsQBINfqWpxXUVTUY3ZsICxrj
	5drp8Kv8inRWotpy8KzmhuPuxGNa0R0GhFuNvjtB8etkhFhHhJMVaZTf
X-Gm-Gg: ASbGncvi+qS/HkCfx9Sd3XMQ0qYaNFPOADIXjQahix2xemBmsYGjzQ/EOXw0ccsZ6Nl
	XIglbjyNU8Xdihs1Qw3Q1U7LPnVnp6DD/YMQ4wpy7fqzUdhVugFrtwkXq0AjLSTur+B7SwZ5Oz6
	3sFxZe8S5fvGOvXyC6qKOMUrIn/xY70BSwRYAYtDAilm7Bx43MHzaoJkqebLd5lvvGvecSnWKC0
	nY7kBXR4HMgKX28Y0K9gQnFYl814uNh/rG7ZDujQw767JEniumDdmcpjd++ukWEnzobTBoPJWPe
	fjCZwUQdWznj10icXb/PH5SUZilRarfBFfOrGTrPwT5rvFl+G+m4t0jFx4/HQU7xeYEjfcBes4y
	JWygKHOYZ2OyxMmgTqqQfrg==
X-Google-Smtp-Source: AGHT+IH9n9nO7kec5bACwYWFm50WGXSEE20ljzK3YGhA8V2Hti9BIGctkVsu30lXV9YAdLdqJiq7mQ==
X-Received: by 2002:a17:902:ea0a:b0:235:2e0:aa9 with SMTP id d9443c01a7336-23e24ed635emr9028845ad.14.1752619126885;
        Tue, 15 Jul 2025 15:38:46 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de435d42dsm116929105ad.233.2025.07.15.15.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 15:38:46 -0700 (PDT)
From: Inochi Amaoto <inochiama@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Alexander Sverdlin <alexander.sverdlin@gmail.com>,
	Ze Huang <huangze@whut.edu.cn>,
	Yu Yuan <yu.yuan@sjtu.edu.cn>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Inochi Amaoto <inochiama@gmail.com>
Cc: devicetree@vger.kernel.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] riscv: dts: sophgo: fix mdio node name for CV180X
Date: Wed, 16 Jul 2025 06:38:25 +0800
Message-ID: <175261908156.94132.11302071914429106821.b4-ty@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250715221349.11034-1-inochiama@gmail.com>
References: <20250715221349.11034-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 16 Jul 2025 06:13:48 +0800, Inochi Amaoto wrote:
> As the mdio multipledxer is marked as mdio device, the check complains
> the mdio bus number exceed the maximum.
> 
> Change the node name to mdio-mux to remove the following warnings:
> mdio@3009800 (mdio-mux-mmioreg): mdio@80:reg:0:0: 128 is greater than
> the maximum of 31
> 
> [...]

Applied to for-next, thanks!

[1/1] riscv: dts: sophgo: fix mdio node name for CV180X
      https://github.com/sophgo/linux/commit/8727665368cd4af112146b650ec0ebac038b5cf5

Thanks,
Inochi


