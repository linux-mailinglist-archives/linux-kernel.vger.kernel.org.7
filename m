Return-Path: <linux-kernel+bounces-878844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54D3C2196C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BD0D1A67B28
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA49536E34C;
	Thu, 30 Oct 2025 17:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JJxsvXJy"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C6436CA95
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846935; cv=none; b=fhhs92jhB2DehjHT5qG1SqboCi/6qPduXtILXn9rys4d9LZhcjyRiA7Iu1iV7/RpMoh4YwTyJOTEHsErSLYyhsEDiLon7LNLVfYvNO6Edf9XZyS3Q8JVPdQdfZNsByVXQzS5imcXOufj25iI0Sv4biX9O0iTegmbxoCqjLmyUSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846935; c=relaxed/simple;
	bh=KXgzGd6gNo09gi0VZSrUZARuDuGxlTCFI7gHi/TqNjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YnsM2GnS7K6DMq9IFXG9J6wNZRMjyWWnkylGh+70qnR27A39xDITOtW0TeW2B6p9u7xAuNvTfRQydOGx36lSOOs1Usx5SXRdI11SB/3i6eWMbldG7K4trUApnFP2Sey5HB532IIIzKWjeA0udRGlwiQpNXPjmGhym7EBtXrZIlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JJxsvXJy; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42557c5cedcso888061f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846931; x=1762451731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NV2npGkfv500PmnI9y9LBiyb4UX94aZHfGA0F6aPZeM=;
        b=JJxsvXJy8xGyi60rXx7saWafLF4CUHIy0MhtDrZxYJWXUbS3oekbNu01FzAOzQld47
         FMX7j4GMcj90L07+YyRQ4kGHznI6/O0lj8a+lA3muhDCHTMR07QvVdOkkAAaI7ebMKkn
         F80hlCO8RufaMl9A9UEpyzEGlWmwacZNhbqzm8NxBcoOOEdfl1WHOqgaNtiMuD9HrgQ3
         o7CsC4ckQ7Dm2SZu0mohcdpJt9AtwYmxxppYM+Byfb8Gl2Yg+WKn8ZeC2F4SKCjapOnB
         An5Oni7TdMwpFxD+blL1yqigB+OoCZWRjQmIvr0qo0AmseCr8XY05chIbSrAPQaRRiXq
         1a0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846931; x=1762451731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NV2npGkfv500PmnI9y9LBiyb4UX94aZHfGA0F6aPZeM=;
        b=EsERi2bgNKcODxaUPUw+bz3K1j5hXT4U2gXB5El48fpqTKaoHtOrIzqGlfe1+X4B2H
         A9Da/ExUfas3t3ABhV4WCrONjp4LrZpyxaL3ca6dtk4H0eWefc8SfRmMQfHw9OWAIW4X
         x08urHiCFExNWRq/5vD1u7D8ZbGkTFNVjwQL/ChYIcerUwyMxuKw97eSoSEM0NPLeBT6
         qQ+R+z3BDYrFoMURDOOQkG5AXFB3h6XXK5kyHuR9VgYw+r+Zvo/3iye6xjw6D4CUhm2l
         oMJacjDpByo/BiGdiMwUX5C77PGPEwm2HsCyEaxit56zkF6QSnJ3IiZLmxNvhsxvdQB9
         P29A==
X-Forwarded-Encrypted: i=1; AJvYcCV/BKYj4Zv084Mron5cCwvlkUaypgyxON+tioeE7cjgS6zmERd4xtPHkQRvHcG84x12YVsvk8m+vi/hunY=@vger.kernel.org
X-Gm-Message-State: AOJu0YysI0h64kUTl30XzgFLEDtT5iFWdL7uSFFSlhB2DOwPru+6Ty4o
	GsWWSkjnoRW5n3je7BxL8Ag3vQ02dGd7XYUX9a6rJXoHbUZR6GNrDeHE
X-Gm-Gg: ASbGncvBM1IGfHFq9nlJ6N5fr0hn4SCqMbfIUCrNPc3UfNt5N8c8vLBlBdPPWYPMlt7
	Yz1DbPHGMQCRFyN2lozWEmkGRJ9gtM0UltfMsQi/lXp0CkvS3dCl5SjoWNgUZ0TskWTEWA/rdxW
	QcjUO7K08XmckTX8wopg2pkHDG6f2ngJVWf5Snv2AwlSEIvyfwsYii1U1iWatLzRMaverfThERL
	ecFbrjuCyc5qtbNk1O0npDfF9iFTkHE1KQ7dGMlh3dvMm/SVRbnUZTotYyKjBk4250gCraHOu+U
	Xey08ONPs8exkErBF0DHJPuxM3GRHqPpLvZvORflHUVHRR7S/2SPZaKkC+m79MPRhs5K1Ws8Ifc
	TenHpKFUxchdgFNhUyUOm9/42ahCMLoF0WDAnddqfjrSVz9OqJEAnsKL36dFAsNDZE7NyYYwPy4
	dVqldWXIi9r8eD8hLcVPon+cjbo4OxxegIhJ/ZqiTne1HWttaUw0n4/Pjr6WqA+gJR+kdL5QE=
X-Google-Smtp-Source: AGHT+IHMkjvLfmwalDhCBBe8OAxHC/LlNBETUVjK4U+fGTxaXOKW/TVcRRYQUO/q05YhnrUanlIZGQ==
X-Received: by 2002:a05:6000:2306:b0:427:5eb:d82d with SMTP id ffacd0b85a97d-429bd68d047mr428378f8f.17.1761846930766;
        Thu, 30 Oct 2025 10:55:30 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:30 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH v2 04/13] serial: rsci: Drop unused macro DCR
Date: Thu, 30 Oct 2025 17:55:08 +0000
Message-ID: <20251030175526.607006-5-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
References: <20251030175526.607006-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop unused macro DCR and its bit definition.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/rsci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/rsci.c b/drivers/tty/serial/rsci.c
index 504361ed5ecc..470b5701cd67 100644
--- a/drivers/tty/serial/rsci.c
+++ b/drivers/tty/serial/rsci.c
@@ -24,7 +24,6 @@ MODULE_IMPORT_NS("SH_SCI");
 #define CCR3	0x14
 #define CCR4	0x18
 #define FCR	0x24
-#define DCR	0x30
 #define CSR	0x48
 #define FRSR	0x50
 #define FTSR	0x54
@@ -119,8 +118,6 @@ MODULE_IMPORT_NS("SH_SCI");
 /* FFCLR (FIFO Flag CLear Register) */
 #define FFCLR_DRC		BIT(0)	/* DR Clear */
 
-#define DCR_DEPOL		BIT(0)
-
 static u32 rsci_serial_in(struct uart_port *p, int offset)
 {
 	return readl(p->membase + offset);
-- 
2.43.0


