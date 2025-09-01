Return-Path: <linux-kernel+bounces-794162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4242AB3DDB0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:11:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8560D1887286
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9067B30505F;
	Mon,  1 Sep 2025 09:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s5KnLJy0"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49579259C9C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756717858; cv=none; b=Sp6SwcDOythJQx1fDCHZU7uhW9alSRs4Vtr9zlH0YBGZ2gtanp1zPwnXzOt8SDxKPiYauQ2P1SS1NK6yF6N9vHySizDclIIMj1JMhLgpgxY4Sjb6huwTx23w1vzkisieagtI36pXusHUCTl8Voam7DsvFJeKJUe5kOsAKEcwa1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756717858; c=relaxed/simple;
	bh=ACP8MZnAlAb5InMjYQgm922aUo2YjOy4WzsnXNakYg4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cJbX7g/F2EpQR79WE6umNx1U7KrUkbTTpBe357NHB9RM4nkyLmAsnGp7XWRPZ8/mfO/lqQsagIBexDPhwDPdN5MNs+geXkq9Ma3nvBbC2qEdY6UOBGzk/mYe46Iqudx5pLyCCdDRywpIkkbiiwDA8L9RnKjd/ReUarnshzihFFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s5KnLJy0; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abarnas.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-45b7c01a6d3so22341755e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756717856; x=1757322656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hDxtfYjlB+z7OHUF4dwiWALUYeYYqi6hQFXH7mpSg+o=;
        b=s5KnLJy04UCvVhswMejLhz5X0YNPTIf4bzPp0kXXppzQ6/bf9B0t1zvDW8h+w4bS8g
         kepkVuRfX8VD2TclCx1hQmrpjUVHf/gUnQGQB03a/TOOxNR2yG+2bdrxNNTzdMPcfTLj
         TAE8VNde+DirPI6O4eNJdTljSXu0uZvb6l+0DG/eNYXLDr06Ax3sQole2e7I+xRx19Kk
         eOaj7tSv9AKTYZw7MpIxB0Kvcky6RzQPyOaWgMMaN39SlbrKsTA3KyOnw7uXXzKCGbdd
         aWYoFA00Xz/zmfW6agWw0PDAaqc7bv3geT20iDWQA/meHUDmw6hfi9uiO65d9AjTvTIQ
         69iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756717856; x=1757322656;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hDxtfYjlB+z7OHUF4dwiWALUYeYYqi6hQFXH7mpSg+o=;
        b=E6Sva2U0e5uz+LKbdhh5jtGRlcZLGstUOwb6X7LicAxzo5bqQf1r3WfEbhVuhu/8QI
         P1iTNApINtOt7TD39xINwzlAeY8ccQIHHKbNSS3aw0l9WsUzFgbjNVJp4xpqZZegoKDj
         5AEBgGH4FPDowMjEtr61QTY+JgjS8fl5sT+EiY1uIcjRjEqD4ei0kJhGGipJC4MEXYYL
         NXQsz/d6LAIfiVUW+tsAGZmWVDaIzwV+8G316cIcpHtl8t3AiAG5eLNqSIwdnm58w9H3
         M93RzyOyrS35HJE3ZdRGib9PfJc63eJolO2cVGXJVIH2mZwn4ERuI04iMNVE5QPnJaGe
         HM6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWrpLnt8pjpwrzjIUUYpRAxKw/NlV+WcbD2Hhh1EH3EeWFomGu0WvRZsRhOCNw1+tN+lh5dLTewZ/e/UR8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/+dVrMRgOOgGj00H8ormSTt+JW/07jhb0WPEIz9EOUQnIx9y4
	muA2PjSPBlFnJnZK+P+4vVQOULg6pFT1szS/KBT/22cBohZJPUZV9Nzp6L3pTlxQwF0iJ93XfxD
	t9v6y7siiUg==
X-Google-Smtp-Source: AGHT+IGOfALiy9m2ZadFM7Lqo/znox4/GCfzOHB+U0RHpZwPYSarW0J3a2cBE64h5xyOJH4bR9NboaXjLbqI
X-Received: from wmbez7.prod.google.com ([2002:a05:600c:83c7:b0:459:10dd:2e55])
 (user=abarnas job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:3b9a:b0:45b:629b:dc1e
 with SMTP id 5b1f17b1804b1-45b88525cf2mr46556505e9.1.1756717855565; Mon, 01
 Sep 2025 02:10:55 -0700 (PDT)
Date: Mon,  1 Sep 2025 09:10:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.318.gd7df087d1a-goog
Message-ID: <20250901091050.1935505-1-abarnas@google.com>
Subject: [PATCH 0/2] staging: media: atomisp: Style fixes for vmem.c
From: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
To: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev
Cc: "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Style fixes for pci/hive/isp/css/common/host/vmem.c. First patch
triggers check issues in checkpatch.pl that are fixed in the second one.

Adrian Barna=C5=9B (2):
  staging: media: atomisp: Remove typedefs for basic types in vmem.c
  staging:media: atomisp: Whitespaces cleanup in vmem.c

 .../pci/hive_isp_css_common/host/vmem.c       | 111 ++++++------------
 1 file changed, 36 insertions(+), 75 deletions(-)

--=20
2.51.0.318.gd7df087d1a-goog


