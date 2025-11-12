Return-Path: <linux-kernel+bounces-898283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5ADC54C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F155F3AA17C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D4D2E7198;
	Wed, 12 Nov 2025 22:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeyGCtIp"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8226F2BF017
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762988245; cv=none; b=eprYakr1xesVY0ovV4EVzJvwaqR5Ec1EXxNZjcoVoAqzqzwR3Rb6GDspMiHPKU9D8SEVoqdN9gqLIbhICVUV1YrqaPcF2abHM+5/UXKadMQ2pewTHjAjmbbX0brj2I1kfP6Cos1JNiABzmR9rP5W8k4zEV2Mi+QDFftrgzxVNyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762988245; c=relaxed/simple;
	bh=vGkHHaiy3MOyxLXpItzTUmCw6cPMAJKBLTMBmp9fJvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kam8z3odVFW6huG/a82KxFoKKNihi07wgMMXf3tAoWdo5DpOwU4Z0E/lvJRMWsincmKv35nOcqaegBDcoaB44XxZVnOa9yw3xTTH+T4ewzNYvWbk5bmrIltoq6mJ8sdQ7saQ2GpNtxUrNsu3lm3CYUVJCxlAMt8by58QIhBRAWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeyGCtIp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42b3720e58eso116132f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762988242; x=1763593042; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4XAHcY8QOlmnRNr0WHp8n4Z1UHEJ+UhQLLpBoP3WxWw=;
        b=BeyGCtIpgA3XcAhPQz9KGsqYJNAeHzi6h1fefetCMgNeNyOATyWpFrv+fM7QkM348b
         iYMmaAjIwcRNYNf1Ve9xR6HgQhHkq6DbNSVf4JkKQ3TCWdoX/zS+fVpXkJLnA4nNVrKZ
         Qux0H4jI6jLjbRuE8ZXolNsXo2FvCFJcUdHt7aE5+mwm1VVMAd+YTrqBt+KS9QGwEj5l
         enqcuMQvL5zm+sZVTFyAFsqRakmrNMN2zUhHl+ohBGQrs/Whk4u/HmzqdaeQJkUkQXFv
         Ib0t8FR/HAxCHJzY/j57oKVCY6kDJMMd45x3TO5D8SZ/V+XZAT1wB38bgIVqsBWaW6J2
         sJbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762988242; x=1763593042;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4XAHcY8QOlmnRNr0WHp8n4Z1UHEJ+UhQLLpBoP3WxWw=;
        b=ILvQOikljJQHHcC5wEgWErnJAuP5exf9el3bu0gRAo73AqqzywzfaN/vEvqowxH35o
         E+yjTYb7iIbe2RCAHwSeBvuJj9MKFOr9RdLu2qH18XJFAlYS1Lk5lx9RRME2hMFQkpGG
         4/ImJoaM/nFaS1ZESMuRHostZxmq3Vst9WkxRcV+5WtIFmk2PiqrQVSfi9RBbZq8Jxlr
         KW4i2Ss4sbqqVcel417q+BrfNgfFgMsvsf5D5OG6+8+f3+1dqOqJq6Ok//QglLr4fDZL
         mzblAAQFvVrZnSgYPC6Nn/rVggX8hyPgbz3dTyDbk5oVj6BLaa3wABGg5fPlM1TwIKpE
         gzBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGcEgtwTiWhXaTTil7+IPNLHtGAkQYDc8Me5zHgKKvL77rHtd0Zu2zFJ33Ly4Q89wk7JLEJIB48P/a4bs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLYB/kpF+Q7s6BU8r5xoD6X1pP4y9I7GYS5+3DnzPC4IfuE1he
	wDYCwxT2+h9N3FgEop1o3MLFJVZZ/RPgfihG705J9ztOMqs/ddsFWWZg
X-Gm-Gg: ASbGncvN2gvYu2LZg4Q5XBwAr9E4kixHMI3eVMtNeNFy4szBAm28rtYW6guhiSwEQrk
	PH08EAfSiyoZntc/FYq9cWnuR9TJhMLbr4UD7grn5M1p4dGsHawmfhtbj5jPg+BBYmXa/yunqRB
	5eCmx6t7Zxt+5KWp7KEFlQU0E63eomFi063zeGlI1IRx8d2Oz4iFacvnG7D0Mrr3YVlVyjcLFbA
	bsuRHH/kaOEVxlCRvc7wnm8+9WhERSNIqMG6OnvJXBIjoLFUGl+8VfrQuVSEwOtMIYWHbjlJOmS
	zr4vtyOje3rjQH2vmKU3DydWNSS2uq2IKwaElslpr7Hz+dzGx7fc/IyDTku1yUjuDqPMnhgA6pf
	5f2WcfNJwkK6SCOVmQN+S3lIZLBJuZ0NbxnM+1J750koKuSKYAxQ+FbL5f12mFiOHmk8rGOI3
X-Google-Smtp-Source: AGHT+IFXMDCLxFuuc4wUyJhDEvYIta/DJd7NNDT/1TjJrbWKKGa/j3geMAGKKaRYDGMbM1sA9IzI/Q==
X-Received: by 2002:a05:6000:459a:b0:42b:2dfd:5350 with SMTP id ffacd0b85a97d-42b4bdd90e1mr3323681f8f.56.1762988241533;
        Wed, 12 Nov 2025 14:57:21 -0800 (PST)
Received: from localhost.localdomain ([78.209.131.33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm236979f8f.17.2025.11.12.14.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 14:57:21 -0800 (PST)
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Antoni Pokusinski <apokusinski01@gmail.com>
Subject: [PATCH v4 0/3] iio: mpl3115: support for events
Date: Wed, 12 Nov 2025 23:56:58 +0100
Message-Id: <20251112225701.32158-1-apokusinski01@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,
The mpl3115 device can raise interrupts when a pressure or temperature
threshold is crossed, this patchset adds support for them using IIO's
events interface.

In v4 mostly some minor variable rename changes and a comment in
read_info_raw according to the review in v3.

Kind regards,
Antoni Pokusinski

---
Changes since v3:
(patch 1/3 "use get_unaligned_be24() to retrieve pressure data")
* commit msg: "get_unaligned_be24" -> "get_unaligned_be24()"
* read_info_raw: renamed "tmp[3]" -> "press_be24[3]"
* read_info_raw: added comment at pressure val computation
(patch 2/3 "add threshold support")
* interrupt_handler: added sizeof() in a i2c_read_i2c_block call
* read_thresh: renamed "tmp" -> "press_tgt"
* write_thresh: renamed "tmp" -> "press_tgt"

Changes since v2:
(general)
* added the patch tidying up the pressure data retrieval (u8[3] used)
(patch 2/3 "add threshold support")
* includes: removed unused linux/units.h
* read_thresh: fixed comment formatting
* interrupt_handler: val_press is now u8[3] instead of __be32

Changes since v1:
(general)
* squashed the cleanup patch
* added the patch with the documentation update
(patch 1/2 "add threshold event support")
* patch description: explained changes in locking
* read_event_config: replaced switch with ifs
* read_event_config: return as early as possible, got rid of int_en_mask
* read/write_thresh: pressure: calculation changes to comply with raw ABI
* interrupt_handler: reordered the INT_SRC_* bits in if condition
* read/write_thresh: used sizeof() and values from limits.h
* write_thresh: replaced `u8 tmp[2]` with `__be16 tmp`
* dropped the space between casting `(u8 *) &tmp`


Antoni Pokusinski (3):
  iio: mpl3115: use get_unaligned_be24() to retrieve pressure data
  iio: mpl3115: add threshold events support
  iio: ABI: document pressure event attributes

 Documentation/ABI/testing/sysfs-bus-iio |   2 +
 drivers/iio/pressure/mpl3115.c          | 234 ++++++++++++++++++++++--
 2 files changed, 223 insertions(+), 13 deletions(-)


base-commit: 1d09cf18cc91d29f650ad9811ed4868d9304d6c7
-- 
2.25.1


