Return-Path: <linux-kernel+bounces-867784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48140C037D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E5824E6714
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD352275AFB;
	Thu, 23 Oct 2025 21:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LptrfI3D"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D000A26561E
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253667; cv=none; b=OssIua4Xso2+Pf4ZyHAsefCD/DB7DIzsBUBPoKfqcZJniDaYZeNoK1oWe0d8sCeqd66OG9HyxIQoK3bt3LqE7D8IlgwaooVtJD57BYuEVkYTJN2Pz6BQ5yEXRIEeLYpR+kk/lba2YNp/8qVnB6U1lY55dEjLpjNpS1TUltAZmE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253667; c=relaxed/simple;
	bh=QswsVxb7CR7KAytVqgYUW39GsQhUVHWw83KELUyhChI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kr/L+VOs96OnhymAIRF3I3Lh3h48wbjp1hiozgaENm62xiGgrURKllERqxnY+yajEmZzeaBFKOXWvtKMmfeZ6m1q2xA6tVOicGhp3rghE03zfI/t3awYiViL/ep35hPrFoRcKrI4/nTO0VsiewZdnh9iUvSMiqwksTjtFNmWKVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LptrfI3D; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7a28226dd13so383998b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761253665; x=1761858465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pRCHPQhpenSm0p43Ve07VuUVPD9MPencJKGnmFr85ho=;
        b=LptrfI3DJU2B9m/LWQwUB+RcOK07enwCBBdMk2Hmp/mDNmqVjVtc506VcONj4QtO48
         EjkSWMDlZpGmYT8Kt6iuW3f2548qLzwCq4+ErdGtIo0VtLs2SFJAgJr3zbt+coROAGRv
         rFKhjyRUN145dytkMeoZuXJiV1DRCuKOfuYfUCelL09Wx+m8Zb4wb43zTIL2wGACcArm
         yCth4DVUWmDZJ9vwPYmgrtnybHJNSJtXjigi2L2jzUdLQU0jroM/Rgx1EVEdPNlrO3WB
         6eoAmqCw6Prdp8f3pt00yZV96rAtgVtm+9tBavdpqywM46YvuGZ0F8ycspIHWId3a+13
         +Irw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761253665; x=1761858465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pRCHPQhpenSm0p43Ve07VuUVPD9MPencJKGnmFr85ho=;
        b=biVPvCJjFKSedo1098UKppCVdvfZX4XTfHtR6aOKCIErMoBiO/5M6wjTQEvP8+vkxy
         rlgj2XsY0bVlPjWapKCCr0rcwStlXLGbSSpTkeHV5pIjJPrBdC6YaQ1wxaWVD8F5Rn0j
         bh3iVPCh8aNhUxygU3+4XpjtyuvwMYyfRofECIknWXsWh1XNDnPfy5Yf5ACObNg9mRbj
         xvD1Fuwsx/lRHD/bYL5intRbpKRWcZXd49xsVbssGy7Cma1m6CyXL2olCyEQL74SOoP+
         skLdgFrVcLntTOIs22Oxug+3se3ci9wFDnfk2yne0tIs2tWHwf3lSBkg5evmTFcBJ2Am
         jNtA==
X-Forwarded-Encrypted: i=1; AJvYcCWT7z0KBTMnYyvGq2rLQjpvbUjJfqHRzlFHGcNK/h05CHm9IWQ1RhenFhtCC3ec/smUeXsZJiXKmCiAdSM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh86NvoMrWYhcpp3zz96jnKUt4xEMJ7lwihNcp/SspV7FPZoYL
	/me9+IRW1d/ptCkH/ddc8a9gnsczWfrQKgEtASqWm7yAlMOo4cJmSu53
X-Gm-Gg: ASbGncuhuz8VlzbhB9o78o03QPVnSXElbDoV1UFhPvcA7P8otDGxCBbwYYFnYsse7qc
	jrU8zsWSilkzKHZjILJ+96WhEozO2T5FPl7HkHumxcfKiajvXh+M/7aJqXTg487EARu+M3f3ebH
	xaAhXzoD0m9A0rRse1NG0qNk2U3/wJY0E0Pg7jS0PK5kEBHm2uhbXPZnsph/kyRVi95DxnaTTJD
	OnlMmqQAw3WAlL3OREuxC4HlEMfx5ok+5qbtmoaKQ7qBzmikCu0/41sQAx6F25gwLX/V0+kcKyW
	2+IjiJypbOgRrPgLDK9WcZv7fKQKq1xYbONjv/IKf9HQqZNnkCMpw5i/x+7qTseiAqDvpagQYb4
	37rYCHk+YSCAI/YN/sFkKFdOeg5T5wTzHW7NvzpePhn0v9VGeq1nH8w5ltBYnluzXSzw0aPDh8e
	BcV1dK3iCV9ceXpybzxHZ5vRkWd8bQReXr/L8fk/7D
X-Google-Smtp-Source: AGHT+IEC9IGbZpflD7H2AaKcdyAZ4qswSf16TABaK+UleDIIM56YdcbNkdDFASJD7aYBk8i1wn3Wnw==
X-Received: by 2002:a05:6a00:a15:b0:7a2:7964:64c0 with SMTP id d2e1a72fcca58-7a27964678amr4134281b3a.12.1761253664951;
        Thu, 23 Oct 2025 14:07:44 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:ef2:36b5:9454:6fa:e888])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274bb2fcasm3461246b3a.58.2025.10.23.14.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 14:07:43 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 0/3] clk: renesas: r9a09g056: Add DSI, CRU, ISP clock and reset support
Date: Thu, 23 Oct 2025 22:07:21 +0100
Message-ID: <20251023210724.666476-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi All,

This patch series adds clock and reset support for the DSI, LCDC, PLLVDO,
CRU clocks, and ISP modules in the Renesas R9A09G056 SoC

Note, patch 1/3 is dependent on series [0].
[0] https://lore.kernel.org/all/20251015192611.241920-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar

Lad Prabhakar (3):
  clk: renesas: r9a09g056: Add clocks and resets for DSI and LCDC
    modules
  clk: renesas: r9a09g056: Add support for PLLVDO, CRU clocks, and
    resets
  clk: renesas: r9a09g056: Add clock and reset entries for ISP

 drivers/clk/renesas/r9a09g056-cpg.c | 109 ++++++++++++++++++++++++++++
 1 file changed, 109 insertions(+)

-- 
2.43.0


