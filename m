Return-Path: <linux-kernel+bounces-837775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 484E5BAD293
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B161927B63
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A2624DD09;
	Tue, 30 Sep 2025 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="P0pwmJV5"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100B014F121
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759242145; cv=none; b=UqIsC8a6F5edaTSfOFcqJytA49Rd3ilaYPE/2xPq5139waFi2uiwbVdw21qzTPIZXD0deoq5uGLxAgWlxa6yCugQNbsdh4/rkjPwIdGUd1wPj5Xu90sCxeoaYNwO7zC+mEi1Jikj12xTOGsRWQd2dMUzQvV/tnMoqqDtQNnDeiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759242145; c=relaxed/simple;
	bh=5AsASDTDX0EZBQgqeKMk0P8gAYO+8BwnqNiV4Qo/RNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4CLF+ofg0aJyA/68ezi3u/80AtqPcvSf4thczFDz5iilVkdSlyjUMxRuwW+Yu7wzJEzkhSQaRY7dQoVlLPKbFDAOpU10UgXI3N+Z0bmUdet0zzzKZ3GwTr4QqleLZVsA0B1siU5K+wUe0tlXmhmOPLNl+4YJELXgso2x7J81R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=P0pwmJV5; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4960C3FCEE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1759242135;
	bh=3pyHm8KyjFLN8BUel0C1d84/Bk/uPgP//s83pCFUOCE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=P0pwmJV5IHgN6c1SjuH4CweQ5ebENtAOXQrt2vARMYBsXKrMmfUt0bWHBDDgGUXfb
	 eCAE5DyqMLK5oVHCMOQ/hdjdDNKvZFwLYEPvyHZstAbymcfU05Hciungndrsy5emy2
	 qzkEQ/UKgCnWwIFTj1/NwUuJlL6k2pjLttoQoQB+/rDPWfmPaL+9apwJfyg05kE9eg
	 +oazjGpEv2jTdgc0B3Xt3zvDeUNMsKrr5gKmYAYdJOSholNWqckh5ZeO+ykVS6zjQd
	 zUZFCLVPD7P+O5t6vcmHu31OEP93+CANRu90l/0yioZT3arnuei7t3Nn0N0f/9lvYE
	 /ywA65kVOIbBw==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b3023c21e21so565981366b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759242134; x=1759846934;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pyHm8KyjFLN8BUel0C1d84/Bk/uPgP//s83pCFUOCE=;
        b=PY5WyGZnFDfXlHhpdyvF6jjgtUyVMuAqfP5Vkf8gaJW6Z6lmTVkFp6CpkRenmZ4jzS
         dBTCl+kP5Z9eAmxzLw49sMCXBpfKGbcnsd+7cpjp0XfUT1tfl9xIqCSyGnrKMcvsR67N
         MLN/vQD5ahAf7l1j0IiIftFMdXlYEmIC/5tX3NkGwfaMScnLztmMsy6OqkwbdNUf4TZ8
         HBpjOSdkeNt3GH3pc1vit1ZMeg220sP7wY6GbG8Sh6cK2TxHh1Zf+QLbK6LgQbwYnns/
         3x7stUZ1LsY3Ct7OTZxa6NiY4S7y2N62+NmIgy45v3sSKlx+r1SB5G78z8Ifs769NjLz
         n11Q==
X-Gm-Message-State: AOJu0YwHRMZMVtP+4vnHnQ1mH0V+PfhhyAJvLRdKJTnaJPfxN0q9sNkE
	91LcwOlloem1aubF5twer6PJr5q2unzLu5Hv7H4Y/nXM4vSatYIsvvEaRlVflhfhcKYVtFwi/an
	0DpE8NHn8S9LQ5qMDyjpd+GyExybD36/ljw/pGTzzdn4JKKST5vZX0hcvrtd1v6AMslj4FkB65g
	o8vw9gPSVkM9ED+w==
X-Gm-Gg: ASbGnctk0Hb5tqhcZkAhZzS5WwIPXCGpyijquwSZNHd9jlICQDOks77D3PqK5yKd6Ht
	Fk8/1d2iNZ7TnVL3QVSlJkoAl4+SR7O10xNfOinQ35pjfdzvc2wZjeaQl4ZyLmdl1WRbuNBUVjX
	zUoUKSyQuY2Bqrn/MkJUW5xPYlwkI//+XoaFyNUD65gItMYRjGGlRA2ONahMU/9v5slfWDxyz7n
	llKGJ6WGeEZ+FZDTl1zDsLZ9GuZI1xe5ozsoJBXZ9VJ3cH/zhdJ7ppGiE2U0QxMdOywZy7Kt1Ki
	N1gvg1G5p7cE1EL4V3sJL0ssWD4s95qokxlB8oXWGu6IcKkarUphwqNTRw==
X-Received: by 2002:a17:907:808:b0:b04:2533:e8dd with SMTP id a640c23a62f3a-b34beca14ccmr1913869766b.60.1759242134507;
        Tue, 30 Sep 2025 07:22:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfBer/QzZke9eGI2xluCIbFtC+ZX2DMbyqhp5u+G14wDWRdgtvPFJJZPnSDL8OghHbM2JuLw==
X-Received: by 2002:a17:907:808:b0:b04:2533:e8dd with SMTP id a640c23a62f3a-b34beca14ccmr1913867566b.60.1759242134079;
        Tue, 30 Sep 2025 07:22:14 -0700 (PDT)
Received: from stitch.. ([80.71.130.60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3fb818fb90sm374129566b.63.2025.09.30.07.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 07:22:13 -0700 (PDT)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: Srinivas Kandagatla <srini@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v1] nvmem: core: update cell->bytes after shifting bits
Date: Tue, 30 Sep 2025 16:22:11 +0200
Message-ID: <20250930142212.521925-1-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When support for bit offsets of more than one byte was added it
unfortunately left the cell->bytes value at the number of bytes read
including the offset. Make sure to update it to the proper number of
meaningful bytes in the returned data.

Fixes: 7a06ef751077 ("nvmem: core: fix bit offsets of more than one byte")
Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 drivers/nvmem/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 387c88c55259..5f6d22545e39 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1640,6 +1640,8 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void
 	/* clear msb bits if any leftover in the last byte */
 	if (cell->nbits % BITS_PER_BYTE)
 		*p &= GENMASK((cell->nbits % BITS_PER_BYTE) - 1, 0);
+
+	cell->bytes = (p - (u8 *)buf) + 1;
 }
 
 static int __nvmem_cell_read(struct nvmem_device *nvmem,
-- 
2.43.0


