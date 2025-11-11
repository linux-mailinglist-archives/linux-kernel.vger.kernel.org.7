Return-Path: <linux-kernel+bounces-896231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD14C4FED8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2218C3B12EC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 21:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9648A2E62A6;
	Tue, 11 Nov 2025 21:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DYVgh0nx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i/xICTU6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5773E2E54CC
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 21:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762898112; cv=none; b=ocFpv/0h9GZvnU4t6Sm5pwTjUHKHz0UMQvw3yg+3X4vcXtFenqn3lzNAUJuugZzI8cTgHpjLm9J7JrVE6e7nEKBDcTtIqe8MBWF4pVQnqae+mxU9OA2Ux0nt7f0em2FAxCS7vd0enG3dsBoibcydPZt5i/SZKRqhZhesLcra/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762898112; c=relaxed/simple;
	bh=MdOVB+m45rMEFDn+Bq+cwePT0GndRxWDbiIFqpt2YCc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sr60kwXRPQ9nCqT0KPXEzwycN/NdYrnuXPAYXfYzt77ol9SiHdQBGpGRLcHx90PY/7Rq8n5oBtcpuC6ly5eraXR1SupsKfYYrKctshJp3Tp8TEhn3dPB5gsORfNodrJJ2hGdiy1VHszvBIb+rRH45x2wM9fZtd3XQEWKaVOE1zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DYVgh0nx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/xICTU6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762898110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sekYXjOrhbrEeTR1KVQQRJq/2k2UhXo++7CMidIcSxc=;
	b=DYVgh0nx7Wx8iAw/pxev1Z9Rfnxpdqedcte/3fPO5h4cYL9gtAoCVTgIyuJeDvW8GjCyfN
	uiQ7v7QuQKQNFUyHEdCOYE9H6OQpG6OOUonWhFehgiVblsPPWkAYpl+argkrNGsdfpYBxM
	nptBJwOAskctZ6SW4AcCcse5SUp8YMs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-U5PXUTQVOxm6wWWyMi7Piw-1; Tue, 11 Nov 2025 16:55:09 -0500
X-MC-Unique: U5PXUTQVOxm6wWWyMi7Piw-1
X-Mimecast-MFC-AGG-ID: U5PXUTQVOxm6wWWyMi7Piw_1762898109
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8b29b4864b7so56917485a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 13:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762898108; x=1763502908; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sekYXjOrhbrEeTR1KVQQRJq/2k2UhXo++7CMidIcSxc=;
        b=i/xICTU6a9PFbTZ67fJO7jqs2qoiVXOdu4HOeWIrWrjtjMPX7EwLUxBkiL7pGwcg99
         6dP2VdrRRgGJgpKedNGDkgZgrgfTJ+rCd3L/blWfeirY254x/tqwQM27ZLyf3r4gFvEA
         0S7GZMp42JceWiGk1Xa+8kOvmPiJwcknRE2T2OPeoccPY9bddi6APktRpxmqpmldapAs
         SIqHw9JyF27DNppQDvCbV+WH9x1bxvyJdFR2DLAxi7YQ67NeoN9Y/yZwglML+gwx4OFt
         oc4GtdGCteMZqUkcHjMopny/5QR9TeG3Bgbg2glYE2Xx+bWtUaw2QnmQzeDgF1Y3cFL9
         jf0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762898108; x=1763502908;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sekYXjOrhbrEeTR1KVQQRJq/2k2UhXo++7CMidIcSxc=;
        b=Q+i6/z0Z3VwzHaL6Ssfh3yDoAZvE3NTpKZBAX+eYxiL32SZ/eoojdOHQ/695LvgCTz
         A5RXvPJfIlfdck6hsGyud+oJz11U8EbDA3gww3nTTddLcXp2C1i4XoI4tKVXvUVSBws0
         uW2vEKcCqV6/mdt6++CPvYgiZDb2MfoawCLCBoQVTMKLnbOisdkLou9aOcNmiuKqItGP
         4gyQx3gO+F+J7/pN9ZfPTXGcTVbxcWtsQhjtSQe7ruRu3B8N1q3vjYWkGKWqMgG37V7V
         tlJKhgPrz4GLVxzDiAuSmLVRmZbzE9Go7w0l9N9uUuiUqsZxwvMnSrRyd3XU0CCVO4ty
         0Y1w==
X-Forwarded-Encrypted: i=1; AJvYcCUBfxDo+vDFz6tZOgCYMo//WSCnUN/Ar8UH5Px60acym3MZYb2jR484VNxjY1E9HzD2v2SSDdtUdPQlRFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKsQUOB71Bxyj2jhQhxFdhigXDXntQKlEFqg4D9VVG5fejQq5D
	zUfwVvWSXbQ9QvHl9MdCzOzjWDam4u3a+6EEPtwklQW11dEyIPt/ZN1ikUAIJtKtGVzNGzcDX53
	690YdqayA5s6YP7UAObFdsF5hg4FD/lh29hQyvRskvuyEFghB2CNeuxMrq61r9y6AMw==
X-Gm-Gg: ASbGncsCwKhBQ6eZ5fnMmf2sIleEqCrVdZdJpciXt02/H6kIw0pkk6twEs/JjIUVTHr
	vWxECW+bpY/28TaMDqMUceejQY6ZKd8kgq+cTbCpmORj0FWFihnFjHpoNGUvRfc/efqNdlgfpBV
	SnMyN4rjFORDyfdgnTcmsGJoB/KO5R/g4LoWrmLOm3TCv4prwlBFauKJ+rP9lPUMJYMd9XzVuuM
	csLKUltid6ujPwGTt7cZgC0CBHOV71uFGJku7WegXaJVXFRwCX+VWAUWXlin2sSrhUk6+k0+Wyj
	pLN1ZKXEbuoEssSsx2E8A2aVUXGl1ehB6VaUfeqrSHxT4CLiL1vmjSEneQCi9PGT7SnIlnv9tdE
	+sFgeU8MyWzGVO1OGL+uWAmyI4igejjw=
X-Received: by 2002:a05:620a:1997:b0:891:c122:4296 with SMTP id af79cd13be357-8b29b7daae7mr119516885a.41.1762898108655;
        Tue, 11 Nov 2025 13:55:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3q6RJGL4tXdFv0MBpLJ0zIlSCrqGboU4B0wfcb2rJgjVxJ9n2CSCtq7Mqu5LGBcREsoJ/Cw==
X-Received: by 2002:a05:620a:1997:b0:891:c122:4296 with SMTP id af79cd13be357-8b29b7daae7mr119514385a.41.1762898108252;
        Tue, 11 Nov 2025 13:55:08 -0800 (PST)
Received: from jkangas-thinkpadp1gen3.rmtuswa.csb ([2601:1c2:4403:8750:d964:d6a9:f204:ed2b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa032fcsm61335085a.49.2025.11.11.13.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 13:55:07 -0800 (PST)
From: Jared Kangas <jkangas@redhat.com>
Subject: [PATCH 0/2] pinctrl: s32cc: fix uninitialized memory issues
Date: Tue, 11 Nov 2025 13:54:10 -0800
Message-Id: <20251111-pinctrl-s32cc-alloc-init-v1-0-071b3485b776@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIKwE2kC/x3MSQqAMAxA0atI1gY6OIBXERc1phooVVoRQby7x
 eVb/P9A5iScYageSHxJlj0W6LoC2lxcGWUpBqNMq7Xq8JBIZwqYrSFCF8JOKFFOpFk1PBP1xls
 o+ZHYy/2vx+l9P8MHwpZqAAAA
X-Change-ID: 20251106-pinctrl-s32cc-alloc-init-cb04ebcc72f3
To: Dong Aisheng <aisheng.dong@nxp.com>, Fabio Estevam <festevam@gmail.com>, 
 Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 NXP S32 Linux Team <s32@nxp.com>, Chester Lin <chester62515@gmail.com>, 
 Matthias Brugger <mbrugger@suse.com>, 
 Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Jared Kangas <jkangas@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762898106; l=2516;
 i=jkangas@redhat.com; s=20251111; h=from:subject:message-id;
 bh=MdOVB+m45rMEFDn+Bq+cwePT0GndRxWDbiIFqpt2YCc=;
 b=AdTasHXTJYSkS585uvDHRJ55IZFnrgZJSfaxnaDSGB/RTgB+JoI7jS7M+GDTllmpRwiXRd6KK
 tUaoDvX0B3UCOC4ZPo6dQSBEoeXz6M5/Hr0bB51+McJESjBxOOOBew7
X-Developer-Key: i=jkangas@redhat.com; a=ed25519;
 pk=eFM2Mqcfarb4qox390655bUATO0fG9gwgaw7kGmOEZQ=

This is a small series that fixes some uninitialized memory issues in
pinctrl-s32cc. As an example of how these can affect the kernel, when
probing i2c-imx, a memory allocation may fail because of the
uninitialized memory giving a junk allocation size, which prevents chips
on one of the I2C buses from being detected:

        # i2cdetect -l
        i2c-1   i2c             401ec000.i2c                            I2C adapter
        i2c-2   i2c             402dc000.i2c                            I2C adapter
        i2c-0   i2c             401e4000.i2c                            I2C adapter
        # i2cdetect -y 0
             0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
        00:          -- -- -- -- -- -- -- -- -- -- -- -- --
        10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        20: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        40: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        70: -- -- -- -- -- -- -- --

Compared to when no failure occurs:

        # i2cdetect -l
        i2c-1   i2c             401ec000.i2c                            I2C adapter
        i2c-2   i2c             402dc000.i2c                            I2C adapter
        i2c-0   i2c             401e4000.i2c                            I2C adapter
        # i2cdetect -y 0
             0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
        00:          -- -- -- -- -- -- -- -- -- -- -- -- --
        10: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        20: -- -- UU -- -- -- -- -- -- -- -- -- -- -- -- --
        30: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        40: -- -- -- -- -- -- -- -- 48 -- -- -- -- -- -- --
        50: -- 51 -- -- -- -- -- -- -- -- -- -- -- -- -- --
        60: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
        70: -- -- -- -- -- -- -- --

Signed-off-by: Jared Kangas <jkangas@redhat.com>
---
Jared Kangas (2):
      pinctrl: s32cc: fix uninitialized memory in s32_pinctrl_desc
      pinctrl: s32cc: initialize gpio_pin_config::list after kmalloc()

 drivers/pinctrl/nxp/pinctrl-s32cc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
---
base-commit: e9a6fb0bcdd7609be6969112f3fbfcce3b1d4a7c
change-id: 20251106-pinctrl-s32cc-alloc-init-cb04ebcc72f3

Best regards,
-- 
Jared Kangas <jkangas@redhat.com>


