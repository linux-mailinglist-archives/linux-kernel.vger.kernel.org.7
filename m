Return-Path: <linux-kernel+bounces-731729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D42B058B5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 13:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA951A6583E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD272DC33D;
	Tue, 15 Jul 2025 11:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6Lne2/Q"
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CFF2D9EEA
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 11:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752578727; cv=none; b=lUESGxC0VIxr2z3bwUSudupPGWVul+PT6/QpWQi1IPhbzTQXb9e7WVWFSF1dwoi2t0xfpIk30uhPGXslaFDc8OWfzjP6fGSlVoe41bbsKKt57VHj5CrFOJqaxCVyA94snbD4iv3ufhc9wo6atuFfJgbLRyVi08uu6E0cXmMEneo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752578727; c=relaxed/simple;
	bh=jHbaE+DWOPVlLwbyTIAvmC8OzDURw4LfeUDIJ89w3Jg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HrNcPnqVvbLMMpAvjAKLDmnjspEPnhJREBKCBlTIRuCAGqYqOGV6V4uHcdNQlnX2Qe4cmjkwR89FaRGVcScjzjzIZiUfQpMI08Mw2WCeRTpLc3hhT01iriygjl9hlYX3oFn8NepCi/GXMeRKDSNwytN7NQ6gmtds1L1H9GVqAH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6Lne2/Q; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-717a2ef8943so52998657b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 04:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752578725; x=1753183525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vo34cMBbfu5ZCEstKlXmULPS9HKFY7p6hoApDHlHdqo=;
        b=C6Lne2/Qu2TEj+12XLHNLvaJYbBGHcA5xVBIwdbJZFIC3QFbEugeFG7GjFd+0GaFRh
         7JQ9rncy4IjQny4iCs1v7MLy7sXxmVxamJLJcV8fxXxuc5ra+M5SqtELa8x7Ce2jNjGp
         UPQ23ch7hNxSiKoQzIGLPeDId9iY+JP3tSNwdIE5Pjt++ea0OUIcpefJPn4R5ScvVB4E
         q6KIo3AEQiBvgxwJQzThkBJOea9+1/qTU7XQ3SlLMg5zLDRAPIbEPAQb68ctFNSK4Xp7
         ba4AIXv6sN6L2Q8RuuU4KByb9Gbv4+Y4cECHHlwDAuYQID3MuCumB7sjy8AWfYKe/BHw
         F/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752578725; x=1753183525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vo34cMBbfu5ZCEstKlXmULPS9HKFY7p6hoApDHlHdqo=;
        b=GJcy9YOcJOjlCni7hl/D6fljRxLgCuzHCbIAPn9sDcdPU2abGNby0A8p/r7Kxe4Na0
         A93pgVt7OwhCav310/lzTNt0713q+qAg+XxPg0d4HE+3U2tApHVR+QMg+Jd+8/lTIBzb
         XRvkIsE3dbgW1Ksj8CY3Sy7cXspleLHP7Z/3FguwZR8TRz2zLxwlD4QVfUuQWLjH1zke
         MBBWQGdiYQX1aDrMFWN5mXYbkB+MgK7XVzos6CXiStLbGUsY26dBQ+4TR8IWX/Wm8DIQ
         7atUdk/xlugRCMjHeD/GC/MIqOT2l2T8dK9ZYXiDoIOcF8Ju1dWIwaESCdxDRNlAHXT1
         ZGSw==
X-Forwarded-Encrypted: i=1; AJvYcCXAgam7V8a8WtZWQmsFdjwlYjHMmbCyWDhKGDm4jwYqBfcxzhIxeEkGIcON3DBz3b+hRC898sYTMPZ+6ww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3vgxGWjx87bUPdkCbahaDl3tTV9GtlKPWa6/0PCrHDMN4QslK
	iL7r1gGoPqFKthgr3k1y3njtH5XPJnSuHILubM8qXgILk73ZAvN4RVOP
X-Gm-Gg: ASbGncuaFq+J3H/JFYcYCfrDUqedzco+R7ldseN82bM51A6u0BrrMZvNPHQ2OHzG5H2
	Xd0NOIBrDZ39Z+G08BAZR9spQV+/uLqWz7fpQzzbenLZM2pOdcY5Mu29Mbthe4iCBUcZq0cW8RU
	3uefx4u8gBosPiQXfd/Jp8Dpb31GD8vTTg5MDM31MVBmV9GKMiSx8MTygm/uZyJWf92TQtht8K7
	1lqu82ggO7/Porrn6Fu8zFVpKypEIRvBUWfHYv0i5D9ZbrW33yCuBd7fTc+ftX4IgYdRruxq7Ys
	cE+f0idKuZ5IOwgkMyn1oI41YPlJKHEAXGoP9HBGvkYtv/DHDhk3oFv1fvjN1G2GYN9YFFiHdvG
	YM3VW9EP8M/NFBpnSeRbxYXZdaGnUY1xHQCvPug==
X-Google-Smtp-Source: AGHT+IH0IhETsj8P/JA08XcPMH7nWCokuLPtF1IOgO6LXzPBkyRklzIaRUiZn1jEXAuM/Zxi5H9xEw==
X-Received: by 2002:a05:690c:46ca:b0:710:d950:e70c with SMTP id 00721157ae682-71824c44966mr32166897b3.28.1752578724786;
        Tue, 15 Jul 2025 04:25:24 -0700 (PDT)
Received: from DebAmplar.DebAmplar ([2a00:5881:3041:2700:501a:6a32:a864:a47])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-717c5d891fesm23810387b3.52.2025.07.15.04.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 04:25:24 -0700 (PDT)
From: Ana Oliveira <anac.amplar@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: ~lkcamp/patches@lists.sr.ht,
	koike@igalia.com,
	Ana Oliveira <anac.amplar@gmail.com>
Subject: [PATCH] staging: rtl8723bs: os_dep: remove blank line before close brace '}'
Date: Tue, 15 Jul 2025 08:25:13 -0300
Message-Id: <20250715112513.4541-1-anac.amplar@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix checkpatch error "CHECK: Blank lines aren't necessary before
a close brace '}'" in sdio_ops_linux.c:309.

Signed-off-by: Ana Oliveira <anac.amplar@gmail.com>

---

Hey, this is my first patch, I appreciate any feedback, thanks
---
 drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
index 4a7c0c9cc7ef..5dc00e9117ae 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_ops_linux.c
@@ -305,7 +305,6 @@ void sd_write32(struct intf_hdl *pintfhdl, u32 addr, u32 v, s32 *err)
 				}
 			}
 		}
-
 	}
 }
 
-- 
2.39.5


