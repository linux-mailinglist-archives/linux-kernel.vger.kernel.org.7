Return-Path: <linux-kernel+bounces-741194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 028C1B0E150
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B77217C351
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 16:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B9C27A462;
	Tue, 22 Jul 2025 16:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="TTv+rfnE"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7E61E5B69
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 16:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200596; cv=none; b=MWnMV+KD8cNIE4bFyM6S7gnVjqsDvnqyb03xzAXcOCQf3zmXujjd/L38zUAlICLKt3kLWtq0A3xiNtw2s20NGxcDwBdy1sTJ+BTSeQi7sk/roG3j6+AwnQdY/qqzs7jfmJxk0txwSI7+3/X0qekpfytV7JhEMbtPhWIe8zrhUyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200596; c=relaxed/simple;
	bh=MUM9bEkNBXTu1TSP3H6L3Jnq64W1IH31tHRkg5JXE+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qGuc2X039d3GGi21CuJqcY2P0aLjVH6LgAb/cJfJDEguFQlDdPCqcyhTkYZ9MuM8wHKeaRl9wC4RSbdQ5WkEeVa2HbFd6Z5g7G38Zfknm2q9lM5Cyc+5r+cF3oBPSMrfzHmc2ZqtEtdOc6drHzH/ZFz53GSwNQpohIEAE5eNU0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=TTv+rfnE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4562421501fso1293235e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1753200592; x=1753805392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Or4wcFrh/g4bzgPrZR3GzuF5oudOjcYArQDvhE7cWaA=;
        b=TTv+rfnE90RdjFZpvrHFly2fMe35QJsAlpQFa1FE96kDz81zoHw7cG+vrhHy0bmsea
         el/rAzjSmZO6/GSzeDuHggNXCjX1O1gF52dci/t3Nib1D8FS+zfGPY+RxIjDj4GNtRL0
         VCI221vEeUbD+lUNBUD2nYNMP97x/NEDS53mjeCnDGFFIMFVJ93gmLbfevQCOwzX6hKr
         dX5PGP/JDw2MVXOvbICTm1y7YoSqIADWOm6zoaInhdNIIovLlP80Ygkys1TUgzp/isi4
         lFO5bTr5ylmo0j9NsogXWtHGm2G86zalUPJ8cXWbs7cu4AGchetB6aDwx1WmpmrgU5vv
         22PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753200592; x=1753805392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Or4wcFrh/g4bzgPrZR3GzuF5oudOjcYArQDvhE7cWaA=;
        b=s/U9EEWK/X4CcNEYDrrRvRD9DEysXQNDvccJ8gEVOIMFsbbMKbd2xKTIhAhZbdfa88
         iTPQHAwL8iucMFcxCccN8AWxYDUPNKlcBIVOhBj5uPHMwaa2ojn2tEHHXaXTxZ4xbzoE
         Suh48piMx70Q7Paq1FOjexTqrU3Min/jyM6ZlezSxOTuydd5YroP7J5a5w0AZgMb++XV
         Wf/WeGf/yNgC4+pHq5ndzr12asKCXoGUfoD/pw7Mwh8UP9y6/g+pooS0QuHj9722kMA8
         qHmMItMsuaJ8WnyOkCuEzvbXo+aKVdPmj3jlSuiZpAuE2/xZixIX+9eG3d4VNDy+qlag
         AYmA==
X-Gm-Message-State: AOJu0Yy8sE9DEFtevlq8vDFkP20Sww4Ks670WsA8Nyj0VSB852VRtzpR
	EiunGZZ+8O7RCyqVPyhQH10215oPN8lURN0Nexr8t7KvQ0MfCBOl39cz+HMGJ+AFlcY=
X-Gm-Gg: ASbGnctX4sOooGNiTZfZMyeoC0hjubIAXuv4cT2hML6+950DDXDVW23x2NzRK/t3wU2
	K4onVN8qf3o2DlUzUvRbumc0nNwxy9aaYhVPBEydV5s5UXomXsT1b2bWOzuSSfKD/pkOXpnTwVG
	rB4TkChFQ7qAqiUSsIKxYymlQk3eDTJ7mIh0ajQughHd0dpF+Ea/8atQFko/Q4zUXzj5IJkhMT+
	2mRgmnucvQgcBI9E1IybweiAhqheIt4hisdm9gNZL9TUHNPdzrRX5Sb/gvGc8EUtbrcSrB2GHiV
	AOvhgkJSU10ZHmuDoXMn9n96fW5hVIauFDlk4OcfoQEguWvCqD0bcjoRUotwAxrDOlmneMu81ml
	m+AizuhtdKHHoF1cTmBgCGga/d5HbtQ==
X-Google-Smtp-Source: AGHT+IFwNKjM9TFM2omjPd/pzpnGmAY79I7Fealj165kSTBll+PynRFFaKJikEPpsiXonJHrrlPEEg==
X-Received: by 2002:a05:600c:548b:b0:456:23d4:4ef9 with SMTP id 5b1f17b1804b1-4562e0462d4mr107484135e9.3.1753200591900;
        Tue, 22 Jul 2025 09:09:51 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:30d6:4986:8040:bb0a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b61ca4d755sm13702066f8f.68.2025.07.22.09.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 09:09:51 -0700 (PDT)
From: =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
To: linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Deepak Gupta <debug@rivosinc.com>
Subject: [PATCH 0/3] riscv: minor thread_info.cpu improvements
Date: Tue, 22 Jul 2025 18:05:54 +0200
Message-ID: <20250722160556.2216925-2-rkrcmar@ventanamicro.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

I noticed that we give thread_info.cpu two different names in the
assembly, load it as a wider type, and store it suboptimally.

The patches are split for easy review instead of easy backporting:
I could split [2/3] into two patches, and move them before [1/3].
Do we expect someone to actually backport the fixes?

Thanks.

Radim Krčmář (3):
  riscv: use TASK_TI_CPU instead of TASK_TI_CPU_NUM
  riscv: use lw instead of REG_L when reading int cpu
  riscv: pack rv64 thread_info better

 arch/riscv/include/asm/asm.h         | 2 +-
 arch/riscv/include/asm/thread_info.h | 2 +-
 arch/riscv/kernel/asm-offsets.c      | 1 -
 arch/riscv/kernel/entry.S            | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

-- 
2.50.0


