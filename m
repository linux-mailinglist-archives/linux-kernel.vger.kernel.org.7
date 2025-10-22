Return-Path: <linux-kernel+bounces-864670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC4BBFB4F2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 12:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0322502C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 10:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88B73191A7;
	Wed, 22 Oct 2025 10:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlAgmE1F"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50803128AC
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761127666; cv=none; b=nHPx8GZuvBNRoqMXhPyr+9ibfDl2rkTDLQ0ZWkrlD/N8pfqPvt3Xl+yVu+aM40HuDcbs3gk5hxgDgL/bBzeoN6bqXS9ZTHKAM6oqVTg77bw5sEl1gKcAbx5NqO92/8VOK6GLnGKoum1FvI82UHlkkPWTje28XBiqsxfX2muNnQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761127666; c=relaxed/simple;
	bh=CQGSJ9G5NTFb+nnyJMlZJY34ul4EgxAU+ZVsDLweE+c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KnxKvmXgPSdtcrleqq3ggxRH3N3glnZawBbsUGLOM2gE5/p86Rf76Ctl1VtNEII53fRZE2lQtjicym3cN5Bi+dwZVNuk9xgwpfBW3BVmeh27phJCv8jAUyhc8aL5b1eDfuuCLjbV1ZXjMTmxwQ9e7hsjHxCOPMDUTLBHabi4ccQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlAgmE1F; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b62e7221351so5602885a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 03:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761127664; x=1761732464; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f92XMf9NP7Tv9DocHywTTrf52jlw2PZ7QVnvZS/syHw=;
        b=WlAgmE1FH8Z4aGdwuuSBUPOQm1VCoXT5G+MwuH3nF1toJ8Uj5ev3SfsqpKrTbiUtuu
         cuzB4nAVsLQTD3/t2RSiEFCIzenXukv9D/2QZrUMiS30uh7gF6hY1KaV97CgmMQr0TDk
         eiAz956FkUBf2PFPo5VJgSYVqkBmIPS5g+8vR9mumEYTbEwZp81SrQBjt8YvqUGcovDF
         F4RMpJruNVR8q54CH6ewXqPVt1r+XbP3XsW84juwMu6hoqaPz9QFvx2JWJ6kYHsSFOdB
         YFww85LXNQhhJNKoBwx7m1DXn/1J46e+sZyCy83sp+IwoHuclPRPLJRrL4cILOn+zzCi
         wRmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761127664; x=1761732464;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f92XMf9NP7Tv9DocHywTTrf52jlw2PZ7QVnvZS/syHw=;
        b=MD6DUdWhgChjWb6WbyV0xNKaL8hXCcvIWjmRaYEhVfNGsfrmd7Bg6YkBWUze0QTqKv
         fLWEpXZ0ROpzw5TfXHMgfrnzKMJTnFDX/+chL8AAPuPWHNST7xe+gzV/0vnMzjhw+9FZ
         rDDx/bd8OF2MUi0kgQciZcYla5c1I5lkVNqTZL+r2fklfc5hg6g23sp32aBHRIt4iwEk
         YeEKYJ7hIZz5N8/yex/f4ZFab41/YWZzIN4KB/UPL+tUSDDkGI0Oyd2Sl1Q2gu3DjFXC
         y7OUbYFZXgAq9z6nNzXesf1+jADyZvVq2B0wGb47Kt3RLCBajXzG7QUjMCoMV73q+ntx
         MXMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVr/ukQc69MTcd83roRALpVBgTzTbhlKAT+XpeUMNAKkWm7CovwNiYattyVesjyPhH45Me4gJYKt2x7R7I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQQRll7prhhgupQEQuxsgVevxmyXs1nI1/f4ZHC7E2hW13U85G
	FuYyAnRlqU5qChBWq3miOKfK/dbFszT6VI9q5yv7G7YNuPbptZwdVVat
X-Gm-Gg: ASbGncuJekehpV2Uy3aqdJrS8WIqgYANn4402XeoD+5SnfKp4dlCAfYFa9mMAb1Z49n
	FVORxoT/8YJclUY5LWy2M4vfMkG1KtkEz9WswayDRP7A07+qBCK/9HSu50YW1Xjd7dNB4jddfZA
	c7NS/1/38BC1f1ObNWUAwLM0NhFwt42cQOL9tINsD62S+EHzj4XFV1r/UOz+NPL5So3dngNEyDW
	mQNpmicII0KM2Aca1JbOLMJe4v02kOzHhS50dvm2X6+r/Mj4nyINDxHQhgvAeKo761VADFCd+G8
	ItpnUJHZSf43iwuEjzpHcAbVMnCirZO5qRRRtXSY74iN7d7XA0/0HRMLURSRTeqr0bryMroutBb
	RCRK9AYfcN6A+tc8FKDyvda1x0J9j+G7YGI50s/Ppc/u0Fxuv1pFn8vDj3dekIz98q/qSp2xgnw
	ynU0sGsziDAYn1mgSWJeNiVrHQvtgBnUzNFZzTqCmlZwHllHF5LGPaqLbKIn6PyDUTrNBiNoCoS
	2GqMPs=
X-Google-Smtp-Source: AGHT+IEXr/LW8jVYa3wL+tCY+iIfEcYp5iQKeVrsH+ZUfi9WgSAQn6+2NR/op1D993OnUR3J85rNrw==
X-Received: by 2002:a17:902:cf0b:b0:24c:cb60:f6f0 with SMTP id d9443c01a7336-290cb66025amr274024445ad.58.1761127663928;
        Wed, 22 Oct 2025 03:07:43 -0700 (PDT)
Received: from ISCN5CG2520RPD.infineon.com (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdd10sm133774585ad.83.2025.10.22.03.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 03:07:43 -0700 (PDT)
From: Takahiro Kuwano <tkuw584924@gmail.com>
X-Google-Original-From: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
Subject: [PATCH 0/3] mtd: spi-nor: spansion: Add SMPT fixup for S25FS-S
Date: Wed, 22 Oct 2025 19:07:19 +0900
Message-Id: <20251022-s25fs-s-smpt-fixup-v1-0-ce26d4084b2d@infineon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANes+GgC/x2MSQqAQAwEvyI5G3CCg8tXxINL1BzUYaIiiH83S
 J2KovsB5SisUCcPRL5EZd9MXJrAsHTbzCijOVBG3mVEqOQnRWMNB05ynwHHoSq4dL7Iewc2DJE
 t/KdN+74fmEbdsWQAAAA=
X-Change-ID: 20251022-s25fs-s-smpt-fixup-dc97e81574b1
To: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Pratyush Yadav <pratyush@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Richard Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>, tkuw584924@gmail.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761127659; l=869;
 i=Takahiro.Kuwano@infineon.com; s=20250227; h=from:subject:message-id;
 bh=CQGSJ9G5NTFb+nnyJMlZJY34ul4EgxAU+ZVsDLweE+c=;
 b=qxSRzHnY8WxzKYNe7J1Rxe27i7izSPgca+sVC28ds80oyWATLJS5halsvk2LJMEN5pUauGEzE
 4IgELIparSCCyqUjKrBuCFswcrCoiP0BaSzuX9mfOHSCkytY/n2v11D
X-Developer-Key: i=Takahiro.Kuwano@infineon.com; a=ed25519;
 pk=aS8V9WLuMUkl0vmgD0xJU19ZajdJmuyFBnBfVj0dfDs=

Suggest new series as the result of discussion in the thread:
https://patchwork.ozlabs.org/project/linux-mtd/patch/20240914220859.128540-1-marek.vasut+renesas@mailbox.org/

Signed-off-by: Takahiro Kuwano <Takahiro.Kuwano@infineon.com>
---
Takahiro Kuwano (3):
      mtd: spi-nor: sfdp: introduce smpt_read_dummy fixup hook
      mtd: spi-nor: sfdp: introduce smpt_map_id fixup hook
      mtd: spi-nor: spansion: SMPT fixups for S25FS-S

 drivers/mtd/spi-nor/core.h     |  6 ++++++
 drivers/mtd/spi-nor/sfdp.c     | 30 ++++++++++++++++++++++++++++--
 drivers/mtd/spi-nor/spansion.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 2 deletions(-)
---
base-commit: 17926cd770ec837ed27d9856cf07f2da8dda4131
change-id: 20251022-s25fs-s-smpt-fixup-dc97e81574b1

Best regards,
-- 
Takahiro Kuwano <Takahiro.Kuwano@infineon.com>


