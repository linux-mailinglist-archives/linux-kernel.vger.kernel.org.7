Return-Path: <linux-kernel+bounces-871931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AFFC0EDCC
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E43361895F34
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0E12ECE80;
	Mon, 27 Oct 2025 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tbz1cVqZ"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9091E3074B4
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577656; cv=none; b=JNSq2HHe/lKI+AO5VSObSJSJUASPbWXH0oPNAWsX4gcwbhll9hHAEe1QuCf7m+DgRaq5K9tfPwgEHlF/hSZsLaB+281L97j5e3AkxIF/7GkHy2ZAdqnsjV6JyX8XfKMWLL1SVHt93TlYrOSoA6ekg8ziZnmsIJ3hdHNrqL++Ruk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577656; c=relaxed/simple;
	bh=4KYywOgTHGEIz3ZCocUr/rj1P+mUN7k7cfPlJwv4luk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s5DFyZ2dYwFB/dv3+/WHuhesZwn7qcqAmvW6Bx+Nx/CoLFxAt6TQ2IIXIATW/wPvCYhO8VGw3t7TcQLfkOBsNQZWZtBTd+/eQDE7lykipOdHtH8s8ij/tI4LivgFpPsjIR5r/bu+fQScOg8GsHWfVnr7wvIYO4Cx1wHVh6JA4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tbz1cVqZ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b6cf1a95273so3507337a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577654; x=1762182454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qz3ecQyWxC7VNS5GAYBhcfKzMJ8mPoJ6wolDlF8Nh4U=;
        b=Tbz1cVqZGseSwkIvYl/wlayY15FjFoE2rDnTwV0OruwzSlj4x4LuWngEEAf3cMNaK4
         M/SCCf0W0Awo57RdGfDSyBh4L7DeUPJPkEB4KgV/okxGDwIp8imcBeNDmnw0JtDGLL4i
         Otj6XBGoOk1Tp0QNr2hkAyDRh3Aaw7DTBPlLj5DXcXnlVYyhUUTGJt2lpnoPB1QPf+Qp
         /bdKfs2N6qrJ5QCWNmpgQaNeYT+GrLLSz151I4TUNdxReaMpzsGt7Df0Mmu1rvYKlTA0
         V3YeB5qM5SaOvhOOkJ3xYgRH6sv1ffXOncYMPE8tKKY2lElCwfi+YTQRIx7nifmZ8Fc/
         NjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577654; x=1762182454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qz3ecQyWxC7VNS5GAYBhcfKzMJ8mPoJ6wolDlF8Nh4U=;
        b=qN3RWQ4wZLuivl1amJRgpfpbAK1pQJkb2wcwYdDodBtkGh5ZOrWMIevIMTdYkgBue1
         BCDgwPocAGuSQjaBntwDPip9hHfdMmPAkAdvj6XQhl7kz/NG2NhoV8rg/yUI+sqbgy3c
         2Vm5ZXgCQj90OzjHHQux/i6NhtZgH+d/6p5KrN9jhdGyWG4Fus1n+vBCTqKroaifgfp7
         rvUzf2G/RfYg/byVH66ByQCP8Wk/cQp4dNbb7HpANv/5VrnZG7Eta1jZCnN42On43V40
         z/jN9KbNMjd239t8hdTzpVoyzlq42Gt+9ZS9uj34kJjuTpmys0Pjs+V3NTOsUMCDZ9ya
         Mbng==
X-Forwarded-Encrypted: i=1; AJvYcCVfVkaO+snwIfmw7d8ikPFPo2hxnf/JLLP4DvC7WhIFzeLyR+g9nkHplOWtm17liXPlonT1d3YxtQdprK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCVftYR5AKvb5fW5aqhtuu+slJeWW86pD2VmLWngavVSPWa+HA
	J1JepsRaJxKFCDhWIAYdX/H9RkSmrWy9pkP8nHajUKe7exCHX6JKh2Ap
X-Gm-Gg: ASbGncsm4+6KHw79hV5hlvvEyF2TssJYELQ8KJ7JA9Y6qn2m+UyGEXbrIa1nCcmpzBO
	/LTPVi+QLZKdV9aR1Q0P5jq+dcirkUMtBEhdCP0Sd98Td4nGj7iDfoggD5+anTFlgdCsrfeTBn0
	3/XOOGk4rYwUnA2WU7Xf0pA7gT4wJh2ZVrn21VGthLB2PL1huWyj9natYwwt1pI2epmLGY9WQwE
	gw5KT737rJ0NmB663A0FJQVBnn5etsuXgH2TZ5C9JqWHY6ggDvPLpkjUsIw8xn/TWh6fMNPGbKT
	vks5Dj5j2bRKHnvat/rJo8edvegCwyxthBnJxQvDZd+to9RXHWOeyA0uNzOnywhIoXAErebeEjS
	IFaJXmoAQ4qj06yBYqxtfecwZrSuvZvwgEMgoSiCfx5IvVG+psVnuD+RPymn+88GoTan9/UaPsE
	ApnlkFGeGkCHCMX77QuzFrux8It+nr8Mdc
X-Google-Smtp-Source: AGHT+IHFy+IMljdrhVQ66DQvOfteh6iHx3cumDuMAgc7JMxc9hldJM3AHM32ikGVgmmr//G+ptdz1g==
X-Received: by 2002:a17:902:e805:b0:24c:cc32:788b with SMTP id d9443c01a7336-294cb3693b5mr2991405ad.3.1761577653775;
        Mon, 27 Oct 2025 08:07:33 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d44db4sm86422035ad.86.2025.10.27.08.07.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 08:07:30 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Dureghello <adureghello@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in ad3552r_hs_write_data_source
Date: Mon, 27 Oct 2025 23:07:13 +0800
Message-Id: <20251027150713.59067-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When simple_write_to_buffer() succeeds, it returns the number of bytes
actually copied to the buffer, which may be less than the requested
'count' if the buffer size is insufficient. However, the current code
incorrectly uses 'count' as the index for null termination instead of
the actual bytes copied, leading to out-of-bound write.

Add a check for the count and use the return value as the index.

Found via static analysis. This is similar to the
commit da9374819eb3 ("iio: backend: fix out-of-bound write")

Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iio/dac/ad3552r-hs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 41b96b48ba98..a9578afa7015 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -549,12 +549,15 @@ static ssize_t ad3552r_hs_write_data_source(struct file *f,
 
 	guard(mutex)(&st->lock);
 
+	if (count >= sizeof(buf))
+		return -ENOSPC;
+
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
 				     count);
 	if (ret < 0)
 		return ret;
 
-	buf[count] = '\0';
+	buf[ret] = '\0';
 
 	ret = match_string(dbgfs_attr_source, ARRAY_SIZE(dbgfs_attr_source),
 			   buf);
-- 
2.39.5 (Apple Git-154)


