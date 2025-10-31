Return-Path: <linux-kernel+bounces-879739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2853EC23DBF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB793B4315
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBA42ED87C;
	Fri, 31 Oct 2025 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UiyKz3CI"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302571F5434
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900098; cv=none; b=rPUcAZSJM1ElmXn6ayfnDWN4sFR2Y2kXImaY6gpOs0Qz/IxkU/TPrTt+yfjA3wAtU01o2XAry9h4CR4nWt2TgIAJmOOV+X5UqXACVrSNuPL1lZu73+xH0M2mKqJ4j72UdCivzN4UhYclYRHHbmNk0A7rMfLZjf23cPuyZNuazMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900098; c=relaxed/simple;
	bh=CYRQF63TmSj0kIvLdKDBtxSpPXIpRL8qR0vZ1dpssRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BUSB5Vv9OLPQwQUZJwsaMmMvttP1XR4KB0Bpy1j0FZ7rY1ip/Ns5PzpVY65rFY3MW+AbQRK0FeKk0p0WDAqDeqAhzUStq70GAazM/DGthpbv0CIw6v4iY4HDY+sTappIj88mck9087fNK5frepIOEcwtuD4NYwaV+5qvbUuH1JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=UiyKz3CI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-29498a10972so3446585ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1761900096; x=1762504896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yPyVbe7btBrb/kbufU+DTPGJAkd1ax44z1PEdLO1daY=;
        b=UiyKz3CIWB4wR1fBW68UFpx50nP8DeApfppEbWuMCkNvDiBMA7sn9DtQZwTsSsd8LM
         /MdxgOKSNbS5gioExnQnOFbLR+wyUsHZ7T2jIBgpMquvnVxh6lkTwC9Ucu+Hou7+AlQF
         2D8iC5TRB+Y/qBhzN5e2Mm3Ts962yJZ/5J625Q1qhYpOgZeF/cYo+zLg6OuhTnC2s05N
         R1jgDABNQBRuUgu/DNExwv4v1u0xK4k3wWWyzb53XqCi7/LzGxkjdZkmB3HxtYCGOjlk
         acgbQM2ptbRE5r17llESnThHSTc0atEGhFmhpv0s4cxw5b1WNHfu4M919sHnuXKJnSCz
         /f4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900096; x=1762504896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yPyVbe7btBrb/kbufU+DTPGJAkd1ax44z1PEdLO1daY=;
        b=e2X2PUw8pcLuIJeeik64eRjW9qSxUr1S6iGltnXcqiJbifMi5bg8zGJhJxZiw25lxP
         ETuzJzK+dowm6ZAOZWgzzbbpxPzjNQKJvROBk/vSFdDD0OkvEcAmPR6rONN3b4DGM5yb
         ZzaBTogf2JjIdWZrJuY9JhAn2cX+Qc1RTnH2Wdunme6bq5mUQx76PoZsLAW/mZqkJ/nb
         ct/G7kMYJjKlgd+wOrAu3FyqCjfhPa9wSQf3oXSyCQF4HfW+IATzRtfjgZSiT8Gu30MY
         i7jl3buZY3nQO57opobo/cwFcFCS/Ucw/4GM0AYsmW50Z2cOirEiRi6h4ud4yMc76YDF
         L2PQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9EUzvCLYkm/aj/MqgHuPk5vegCSzoy+Wj0o72nBVMUvF3k9/2mv/Ag2rAvGDpupsV7G+mGHE7iw+10jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YybCOQznz3l92Vz8M4dCjcdnHKHMpR+Ymuj5jBJeEQR2Dof9WFg
	w1Mqs3xlIczWarAuHkc0HfD23M7IA3UU54vBZvZYi79BFki3vhG8Vd2O9IH65pu/Gw==
X-Gm-Gg: ASbGncvXXjCMTpPf/4IfQ01D7grG2gWbzZFoFZBdE+/xBZTcXGZSDB3UVsNBtX//Rxq
	o+YpbeD9dxzcjwZGGQ326sV0vpuEO1jNhf6MfU64ba7FiUmgRpmqPRSzz3ZroaDHzEbgCq8yx46
	l5fG/5aDSETN5zYSAQKpZ7LNhqxP4FPHHGaatFJxxFI9tsjtbpqRDexPtJPb5pNtaDt0tWxhw5h
	mT5Jf1d/QczhlBJKH0HgBNuERrkNdSM/HF7OIuvTsb0/THQVczbnRd27d1nKyy4cEPCOslsQhJ4
	MYMfN2hyzmVBAqxmihb+0LmIQRf5VnmztsiDs9ZxxAhUCZGB+ZrgcI6tEHgaawoqF+yVn6h2YQB
	SkVjjVLDqVuRLHlw7/1gCRfuNJYDn2ilJ71gh82dcrdGH/I3HtABP7JFJ7cfwclJGIgiujn8XB7
	ozsEgqRc2nKFwUK7k9WQTzSmr6rRl/rb1enHSkBpnEySVxGEk=
X-Google-Smtp-Source: AGHT+IFRjA11KiQtuDLyXpyzr+cH+MBZZXOEiapTRE2mqruvh26mmlGWuUYPHkHWLSUbX3DkbIXD+g==
X-Received: by 2002:a17:903:38c8:b0:295:37ac:8d54 with SMTP id d9443c01a7336-29537ac8ec7mr1773595ad.9.1761900096398;
        Fri, 31 Oct 2025 01:41:36 -0700 (PDT)
Received: from adriana-dmi-upstream.sjc.aristanetworks.com ([74.123.28.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699c9dbsm15333505ad.84.2025.10.31.01.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:41:35 -0700 (PDT)
From: adriana <adriana@arista.com>
To: ilias.apalodimas@linaro.org,
	ardb@kernel.org,
	trini@konsulko.com
Cc: robh@kernel.org,
	krzk@kernel.org,
	jdelvare@suse.com,
	frowand.list@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	vasilykh@arista.com,
	arm.ebbr-discuss@arm.com,
	boot-architecture@lists.linaro.org,
	linux-efi@vger.kernel.org,
	uefi-discuss@lists.uefi.org,
	linux-arm-kernel@lists.infradead.org,
	Adriana Nicolae <adriana@arista.com>
Subject: [PATCH v3 0/2] DMI: Scan for DMI table from DTS info
Date: Fri, 31 Oct 2025 01:40:59 -0700
Message-ID: <20251031084101.701159-1-adriana@arista.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022114527.618908-1-adriana@arista.com>
References: <20251022114527.618908-1-adriana@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Adriana Nicolae <adriana@arista.com>

Some bootloaders like U-boot, particularly for the ARM architecture,
provide SMBIOS/DMI tables at a specific memory address. However, these
systems often do not boot using a full UEFI environment, which means the
kernel's standard EFI DMI scanner cannot find these tables.

This series adds support for the kernel to find these tables by
reading the associated property from the Device Tree /chosen node. The
bootloader can specify the physical addresses using "linux,smbios3-table".

The first patch introduces the device tree binding documentation for this
new ABI, and the second patch implements the driver logic in dmi_scan.c.

Changes in v3:
  - Removed linux,smbios-table property, only keep the SMBIOSv3 property
    (Patch 1/2).
  - Search DT for linux,smbios3-table only, removed the code searching
    for the previous property (Patch 2/2).

Changes in v2:
  - Add missing Device Tree binding documentation (Patch 1/2).
  - Split the original patch into a 2-part series (binding + driver).
  - (No functional changes to the driver code in patch 2/2).

Adriana Nicolae (2):
  dt-bindings: firmware: Add binding for SMBIOS /chosen properties
  drivers: firmware: dmi_scan: Add support for reading SMBIOS from DT

 .../bindings/firmware/linux,smbios-table.yaml | 26 +++++++++
 drivers/firmware/dmi_scan.c                   | 58 +++++++++++++++++++
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/linux,smbios-table.yaml

-- 
2.51.0


