Return-Path: <linux-kernel+bounces-866746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E41C008D3
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4599D4FD3E4
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 10:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5379D3064BB;
	Thu, 23 Oct 2025 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgtmlB1Q"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4902319F115
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 10:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761216209; cv=none; b=GNAR33KB7IHiC5gbKSS5QqKy5HCNR7ea1kyeJS9VvObEn0DRk0YaTZPDURfMCb/W22ToD0AVJcAmL0HiO0oE3BgKFYElU9kjYKNACqj5sGwS3qKnzd3BD+YV1jc55nlkeeo2hYTzdINSwuVeg0JCEWsTCbOYfEhuX6FwmXVEtxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761216209; c=relaxed/simple;
	bh=yfiZ/v4sjNEPealFn/6obw9kLQ8DcjpygkxhwfB5aQs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iun23wa69ES5fU0e7AcBks2+6I7NHbDHYcnAH5KMZE7b0JAEvcBE8Cyixyw1qn7933WHzjRm0Ze9OwreDo5+Nz5l79EpSEToC4J7Jp16zpZgHLiBbhsltRggTtkMGUXc6cZD1OWyye429lxzo6UWa8l26pPXmp4B/yAdo07zwfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgtmlB1Q; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b55517e74e3so615996a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 03:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761216207; x=1761821007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oimtdy4jzaui5mD86nBtASLISt4Nnfmett/2NBvJrk4=;
        b=GgtmlB1QZQNg5PWJMc9C5LDGB0XRumfVb4tvMDijqYHJyexYH3wNrYJ3bzl2x1SMTC
         WHo5wca33LktR9OPfq6PYwLanBverSSm89YgO3hho44cKK2v1/6jRmkDfw8osCDItn7E
         ZSqkHnkqUAH4yl/j1RuUKl3fMggBu5UBNuOpvMoJiqshxujT1whbl7DJCX8vvRXcbR9Q
         wOVT6oWJROy/nMeAfgY6/Af/1OFTCMGrXuFfqNrrNQhBIx2zifmpVmwvqX4Kz5rUGCQW
         y0ve86SzAYMBkbVGfp3BxUa1eAjSKmoVFPxpMWjhqJKQUd5CAh//PXjpNg0NORtcnI8E
         ARiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761216207; x=1761821007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oimtdy4jzaui5mD86nBtASLISt4Nnfmett/2NBvJrk4=;
        b=Z9QgiFBQIisxzXRqItEpO4v3rZZO49z1HeJ1gscuVpteR5K3Ex2KXTAKJ2kCTQlobL
         7jZfwKVdM2zJxyQHkG9a8QfEVdKGQkns2L8cndMEdZD0ZM3pMGQwP07V5FByh0BPPiPq
         gYq9DQMBGe0f+fa0voOQvPXBnadMPK2owjjFes6hA0W87NZbGc873pO/zgXZLU1gIu+w
         jKFmFz5mBtOMbvGzU5PBvKFE2V3wLGKpJftGwdEPl6A+i2S0HIwI+biKGzUYEJOD9IIQ
         8z09EFFEYvPweDi8A2PwKAGuqaSqjJkAk9fhVEb4tB5NyiSICKr+8CsUTiI1O8vCZnoG
         Zt5g==
X-Gm-Message-State: AOJu0YwlyPAvtttZ3WGmn54j3HoJC7ecWnyllXsD29kIRqozXhCYs2Q2
	X2tVFk2qoy+Z+tB+5dURJuYHmFKdpYgv+rdiq/7S3ViAcQX6R73TyS2L
X-Gm-Gg: ASbGncuPdoZFLJGQnZJLMsxaDCZR0Nn3KN4ZKsfQumYuixKy5gzHe8CEEg7w2ygl/lA
	//UKgL4jM/ecayrMlWHNsU8ojb1jug9qtoV4FhNTIH0pCTBRE5bYPYm62I1y1XztSGyaB9jlM00
	9q0skaihupzqGSOU12frIVUwu5X3LU0Cgy1V1XjYsZNd3D/CU6vUhB/EYQyj+hPmFmd//pSpv2O
	LKklsoSn++MND9HfhKx62H5sIsSHafK3pXASICgniy0GbA6eCaR2cT32a2YDwT1Ml+sZ5UyqPWM
	I1b9agtWO26j2zrnLZ6JG58sNYinK04PXO7ii0fdu5i0tk+6tQkAnjQyca5YzWhtalqdgY2BC2O
	j1RgR7pWgjArTpxqfFKIptzOlga0oTKm6wFJShSJFAmFai6HOF6wdCyLtVtIlsK2Z9tXjfPn4HC
	cFpo8+KLFAW66UBVJgZ0g=
X-Google-Smtp-Source: AGHT+IH/gs6+8CFlO2G87tCtAtLvUgrD/2n3++PXEeHzzYkJTjhzcKeN8bij7zgjnMAfHtOTCePOQg==
X-Received: by 2002:a17:903:19e6:b0:267:d0fa:5f75 with SMTP id d9443c01a7336-290c9c8a5b0mr338020675ad.1.1761216207465;
        Thu, 23 Oct 2025 03:43:27 -0700 (PDT)
Received: from iku.. ([2401:4900:1c06:ef2:36b5:9454:6fa:e888])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddec426sm19240945ad.34.2025.10.23.03.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 03:43:26 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 0/2] SH-SCI serial driver code cleanup
Date: Thu, 23 Oct 2025 11:43:11 +0100
Message-ID: <20251023104313.210989-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This patch series contains two patches for the SH-SCI serial driver.
The first patch sorts the include files alphabetically, which has no
impact on code behavior. The second patch merges the contents of sh-sci.h
into sh-sci.c to reduce file clutter and improve maintainability.

v1->v2:
- Sorted the include files alphabetically in the first patch.

Cheers,
Prabhakar

Lad Prabhakar (2):
  serial: sh-sci: Sort include files alphabetically
  serial: sh-sci: Merge sh-sci.h into sh-sci.c

 drivers/tty/serial/sh-sci.c | 184 +++++++++++++++++++++++++++++++++++-
 drivers/tty/serial/sh-sci.h | 178 ----------------------------------
 2 files changed, 179 insertions(+), 183 deletions(-)
 delete mode 100644 drivers/tty/serial/sh-sci.h

-- 
2.43.0


