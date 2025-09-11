Return-Path: <linux-kernel+bounces-812715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42370B53BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 20:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01AB15A15E0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 18:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 843B7DDC3;
	Thu, 11 Sep 2025 18:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAqPG4ZC"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909D92DC778
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757616356; cv=none; b=YgvlgLvlicd//2gV7C/kN2oTZ7YqvImCgMHXijd0F75kjuv/jtCftuBMRACe8yB5NWnALGqx0lM3u/wIqjC66+Moh8VJVAfWlpieBA7ZAmAgdkS6gi+WppnHLlM2xa6pXkodQE+09YOc/JJVdPsznYWdbaxv07aBKJFipvZ4LkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757616356; c=relaxed/simple;
	bh=TuLHTjFykUilhUZnT3fFY7LhO9LUKhtWGTRGhNjPoAg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NcwF2YwaQq6sYW471fIxPGq7wqbSHMmq8klU8qHWt08k4vuvN5IVPSaTtfQ4+Nhqio2ZeHWpveL5ILc5ZKYO+yd1cIsSHaEyWqUA/Cp7gVj0uXmNfTq6oMYfkN/4SN9kZeV/G+iKV6gcL+X5xU/UYio54GHQ8Sxy+iqwkySSuCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAqPG4ZC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-772481b2329so1268473b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 11:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757616354; x=1758221154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zac0gA5hNMKVbpgn/Yg6guyOmUi0xcryzjiA7m1Jwg0=;
        b=gAqPG4ZCw3JAzkDy4ajED2oD7jCaDDMYjsb7b8igaXdWamPCviMyo82CrIIdbcCujH
         jlXLTOdzH58hX4hLwKduUq5/2ZgbDoU6PxS02QOHsFegUUI9BvkTYB2Ggw6F8mczE9hl
         s195pWuOrdiN6W0YP4/zB7Nkyt2ez9Aej9a86fiUSZv+8hWH4RFsP9luE0Ox/3o+LURa
         lMAOkfE5gPr6LLtzAz9diLavPWXrLbeN06FS9mX3oS+iSAJO441k5peLxrbnSYkijq/L
         GWF4hPHYgHQHqVYlRqeEtKqtng10Zc/ELSdXOl0TabsxJMHQi4wp2RO9wNzLGV9mLUQG
         LGRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757616354; x=1758221154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zac0gA5hNMKVbpgn/Yg6guyOmUi0xcryzjiA7m1Jwg0=;
        b=CC7YcmhJFwVuMXbtKptQUubjZADL2nDagJxaGu4et6e3DMXTbCfhSt1E7d8RcFGRYB
         XuCzGtVdnPR6TIhF4FTdFFo6sKypE6z99FY4hCy7PvllnEJdbs0peCqLKJ1eomtI8vYc
         TWIA7nUORcVnvcrmF3VZMdzaCHo8Hc3oBUpd+54afU2U3+ltyBgU3HC5GSsPXBMkNnvB
         gUZTcU+ZuwfIDz5ZWjxerBEBv1iadEBw7syExgwfyKX+/A3WOFl2zKcD3LoD/GdEgNC9
         MNw7cOwS0dZ1ZfHGXB0QFKnPlMDxbKy84/HbqA5N82cvKpFkw+EaybnptCV65N65oKgc
         7xTQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuzzeZ+QwOsevKOZFroC4qcQR/CdRLtCxytyswBrioKg7w1ISJ+KiIiwy3tuRyKpkV5NKymJmEUfGbkpA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYgqu0gge3EcLM4rTPsLl53xsSfZBJ8csXovX38ZgXxTKeBd65
	sgQohK5U/dXW5abVY0+leBOG12jmi01TA3ThF1tuYtQ7IC+3BzofXYl3
X-Gm-Gg: ASbGncsI289Fb5/5jI2e941GUn1KCLEleM8JkoIzPX17ZE2A53taJ0omjUZaOdEiloC
	VBxeTrVGoKoJZ5W5rXOhsETxOE7j1p+sW9BEKZaOKKxdWhTei29nFC6W4KpMst3OAokfnX1PIYQ
	69DwA0KJQGNKdiCk76ptWtbH3OkEbtcSjpfDgDPvQmWjScLkZAeSt5nGv3HMreCUvKM2fZCRHaN
	LBQUawMn2ESZ/lSQLAknr/LDxjlfmjFdqSPiXE2cJum5Y8qHsZpsrF2IgbIoIT1SyFLzPWHdpdv
	Hc21vKTqyt6ijd72n9QMM1WjHr7jgWKxa6P58DsEni5kqedNk5Ljku1xmpKj2krjPL1XNOHK9DR
	7VEV8ypWH4s0WI94eFBtBD+PeU+XVFmxF3Yc0wQRqfxBJtbXOPY6f8710p1S2gVjnmNY4gaoATj
	jgDSqsZCTGJ9KgAUMdNWAULw==
X-Google-Smtp-Source: AGHT+IH5VlnojxWoH8JIuuaFn5H79HN4d5aux1SvTMyGC3y//bGWrfCGI5TTIL0/XlPldxFHDOB0Mw==
X-Received: by 2002:a05:6a00:1389:b0:776:2e3:a95b with SMTP id d2e1a72fcca58-77612064904mr567574b3a.1.1757616353247;
        Thu, 11 Sep 2025 11:45:53 -0700 (PDT)
Received: from localhost.localdomain (static.148.173.216.95.clients.your-server.de. [95.216.173.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b34790sm2762616b3a.81.2025.09.11.11.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 11:45:52 -0700 (PDT)
From: Han Gao <rabenda.cn@gmail.com>
To: devicetree@vger.kernel.org,
	Drew Fustini <fustini@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Han Gao <rabenda.cn@gmail.com>
Cc: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] riscv: dts: thead: add more th1520 isa extension support
Date: Fri, 12 Sep 2025 02:45:25 +0800
Message-ID: <20250911184528.1512543-1-rabenda.cn@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add xtheadvector & ziccrse & zfh for th1520

Thanks,
Han

Han Gao (3):
  riscv: dts: thead: add xtheadvector to the th1520 devicetree
  riscv: dts: thead: add ziccrse for th1520
  riscv: dts: thead: add zfh for th1520

 arch/riscv/boot/dts/thead/th1520.dtsi | 28 +++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

-- 
2.47.3


