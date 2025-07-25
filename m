Return-Path: <linux-kernel+bounces-745176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC21B11619
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 03:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D53CE544B2C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 01:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38551F0E3E;
	Fri, 25 Jul 2025 01:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="07Zs9xEU"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476A510E4
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 01:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753408562; cv=none; b=QlVh6v+SqN8t4p4lHAXn1pe7jXHRXHKLacDp6n/zD6z74T7WvO5dZLMnF2KHfmUlhrVsJUifuY1D0GRFn6HBc4jsPUGbxrXRvJpf7R7M95/9HU6uR4tJ5hdpcaWS/8W7g+WyCvvlJaEDmeNONV17cKuNT+LGzhFh/y2mn/RScAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753408562; c=relaxed/simple;
	bh=tcWSEMLkdnyh9aSLiaRBtq7lBNnDoTyyz9lHUiNPlc0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lGmzhHyz33aV8qlBhQnHNxOgfqBSWX1CzP5248Mfe2kN4d4jX3t8AoLU2AuDncdFIbEmQy1tbbnyu7f5w16UqWrYis66ch8ma+Ow9EPVJ/0em1bUuuH3rPXFgdJmZq3UlJ3Tbhwq0NtJQZoqVu4sLWUOLVKssojXqfJ+wvY4mwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inventec.corp-partner.google.com; spf=pass smtp.mailfrom=inventec.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=07Zs9xEU; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=inventec.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inventec.corp-partner.google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ae3703c2a8bso328130566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 18:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753408558; x=1754013358; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jBluRc4AqYa9mwEBFMC/KLTpnRIQOHur+1Rtne5kToE=;
        b=07Zs9xEU3WQVD9Idga8fI/K3jv/n9+9SVUfAoFigfwy3OrAcOgJZIGe7hOroEUU05s
         HYThl4MhMdy8nmiUbEUZtmIzHhCO0PnW5A4EQzuS9EGu/UUmmJ6Ngiavnb6cxKYPhgxG
         f7h2I1NEIlzDyc1ndFhNUa7w65ka5VzQ8n0y0e99v90eOEViGQ9ShQv71ZjncKEkl0yQ
         7j49XtUYFRG+5E+Ge+VH4k9e9qyI15RhPkSxDYQmMXzYLKsEQQWxIzQQj/Roe++/9R16
         lCX4vH7eUxUSO+/6W2aU88JGf6Fx01HZb7EyFUIkGqpXadMDhkD7Mxf1EOCzZGy86xha
         XxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753408558; x=1754013358;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jBluRc4AqYa9mwEBFMC/KLTpnRIQOHur+1Rtne5kToE=;
        b=gVnVUSUpj6okmJgynVVZhL8zt0Nx/+cSAO47rtJ5jWDQ8Od6I4XnbmjOBuagKuSbi9
         ktHtBTXb14X00rAoy4Wqxi/PhmQuKXeHF3kH2VX9XiPCl6UtnAKq5nsZtKJGBoBAWOkR
         9KXNT57SiszazKJi2sjACNk/uQ4PYxfVYS6dKgyLCvJX4vWHx1Ag0quHetEar23UH/l/
         HskeAxiwcS6Jt9d5iW8mHND0LjDzXA35COjhvQXwAOvyN4XZxU8v8B7zWlt3Y3Ag4/ty
         wyYkJfEIpjqY7Ec1/G4HqCotXGKSWgnOUI2Mdqkg7kRswFyZdCEs9k3jS3okMfVX4zAw
         3ZFg==
X-Forwarded-Encrypted: i=1; AJvYcCUEjDZ4C1aC5hd/XN6Qeq1KdMbueMR/vBOjdmCr8arutdpN/l2Xcs99sxul9mt21KITmQ8LuzpIK1b0zmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhpZFITtF6oyV/J/g6UZKkcEze1duZ7OxptK6uePluCdfb5Nb7
	0j7ESjDeH3yHjOFvE+u2ezMaUB5K+m8jdo5r7t04+GjKjEeuqRhdG1E/Zt3vcAOLKaZh0eL8F8R
	pC4eZXNo2AclzuwHlhMLoiD9+RZ2DLIrBLU48z9y8SA==
X-Gm-Gg: ASbGncv8Ru91iH11OWlmU6yEP04VqsTIuDPtgNSRAt7kI8/dhOj4I63kbCu/8xUwam3
	1sUtHdLsNzR8oUoZp7X1gH9lnmF6ewHPQNHNTIPvMzGm3ufSS4+Tsr64QvK5ZeBB8+GHBISD3ux
	Njunwlq3vBUzmjMOvmjzSQI7pkNlREMxxUNfX8wr/NiqbPavuJcycvrYp+4T7mapM6bhdrCZ5jH
	vDG5ae/
X-Google-Smtp-Source: AGHT+IHJrq4VBdfI6Nqmu4pqZEfaWm4CrQW+bqbn01Yhkhymbt8Rfxp8TOPk0fUV2NdWzI06k8NeP6tQWLP55DzcysI=
X-Received: by 2002:a17:907:3d02:b0:ae0:66e8:9ddb with SMTP id
 a640c23a62f3a-af617705483mr27696066b.19.1753408558508; Thu, 24 Jul 2025
 18:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Kerry Kang <kang.kerry@inventec.corp-partner.google.com>
Date: Fri, 25 Jul 2025 09:55:46 +0800
X-Gm-Features: Ac12FXxDU5D-UiU7IOkHfr3KZQP0idtJyLB1qSw9Lcx_i6IPlXyGrNTUQJpBxUs
Message-ID: <CALNGHDA5Lb_8d+Hywv2S+Ks0J+n7kZb3Hme5gnkPf=MKYKhfOw@mail.gmail.com>
Subject: [PATCH RESEND] mtd: spi-nor: Add Winbond w25q512jvdtr
To: llvm@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Similar to the other ones, different size. The "JV-DTR" suffix is in
the datasheet, I haven't seen mentions of a different one.

The datasheet indicates DUAL and QUAD are supported.

https://www.winbond.com/resource-files/W25Q512JV%20DTR%20RevD%2006292020%20133.pdf

Signed-off-by: Kang.Kerry <kang.kerry@inventec.corp-partner.google.com>
---

This modification is add BIOS W25Q512JV-DTR chip to winbond list

---
 drivers/mtd/spi-nor/winbond.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi-nor/winbond.c b/drivers/mtd/spi-nor/winbond.c
index 8d0a00d69e12..6ce5f70bc11a 100644
--- a/drivers/mtd/spi-nor/winbond.c
+++ b/drivers/mtd/spi-nor/winbond.c
@@ -146,6 +146,11 @@ static const struct flash_info winbond_nor_parts[] = {
  .name = "w25q512jvq",
  .size = SZ_64M,
  .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
+ }, {
+ .id = SNOR_ID(0xef, 0x70, 0x20),
+ .name = "w25q512jvdtr",
+ .szie = SZ_64M,
+ .no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
  }, {
  .id = SNOR_ID(0xef, 0x50, 0x12),
  .name = "w25q20bw",
--
2.43.0

