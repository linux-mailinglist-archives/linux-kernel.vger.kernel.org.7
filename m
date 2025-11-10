Return-Path: <linux-kernel+bounces-892833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EE0C45EC8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 11:28:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46043188FC25
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 10:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEE3307AE6;
	Mon, 10 Nov 2025 10:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dswybd67"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99536305E3A
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 10:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762770322; cv=none; b=S/pVAZHlIQXSYKgym0SHmOUrawxfjlbkO/4HLI+epn7ZcaehfvD5G54c8/ePjKFkCVi2MlHCoAxEovH1M3sBXB8h3DYBdHQOrVq2Wu4s1iEDVn3LwXfhoH8He/oKud9PQMangtui+aH2IvFp7NAlGVmC8qlGw7zMcL21WgzOx20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762770322; c=relaxed/simple;
	bh=FXUqYMZnfN5Gi7RWXxlAVrm8ut3iIYY/hLIiU/JBhX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qsa2LQxlOY6XDUmub2OrTpK45wdeK7clK3Jc9PFK7jwi7q4OBEgD0C1a6yRUrhYwtw9lQB/WP1Km7gfmTapUv8/lGKQTHE1jM6/PjpYmvlnij+FWE8xdnoJxV2yBcXFeycJnXvmlpN/fJwwm9kqXFjLhO2JKRtbyy2H1HtDZrx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dswybd67; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-477775d3728so12141215e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 02:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762770319; x=1763375119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75jPLUceKbQFKC4sC1cLZmAKzBwPWWFzrFIBzJ/58I8=;
        b=Dswybd67lqgHb77x4f2JLxO/OK1QDqzkbyOl1QoJHqHGPu3PoHLMdbXerKz1e0yKvv
         +9vdO+9TkJgkeyQdo7FgShLP0B8dXp2kLZDp/77nRojGmuP8cL4NDG4ar8KRkf6V33V4
         zIcwhxoXdmWoFVe6jGvpHRe/1b/u2n2LJUkQZTqLQYi7ETCT4px8AnlzOZBkHCe1wZXT
         yecX0/UlbGs7OJhftd9D3GX6+C040aUPCy1fM8nC0p/NXuLIQvhYHPxaNnRSfwowDIDm
         0+WMofyO1sKYjFzKrGLhzZGPKcwqe+J0SKwt79/ZPG9xu/myBMra7Pyjx+lSiuGKxIMD
         e1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762770319; x=1763375119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=75jPLUceKbQFKC4sC1cLZmAKzBwPWWFzrFIBzJ/58I8=;
        b=sxQk9EfemV+OjibW7KmRrlQ57SYT+Y3urULV/TK2oijvQJ83BJ/1aJNpMeBm2zIc32
         0/oQlP/CMCuW0qGFrmCMbkWREUzKAhSRMUrqs7G9s8GMg3r1RZkS4wklG1izTfSq5RDn
         MlG35gkQT6J3DoxKTJv83J7uqWsDtPWCfHTHajzKimh1PYTglcEXOEX9ipFVmgbhhXCo
         OAIY6ZvwQY4K30zlL4vq4FihJ5Td+EZmcrcyg0crk6JXotQCsy4vmjIEGXhl+i4pS006
         Wr5DRNqZNSnNBMTFpBMB+Gd1KXQe+DAob0E/M7ZUUrRXurCxxDy2qPIAQK8m7wehvygV
         d0ig==
X-Forwarded-Encrypted: i=1; AJvYcCU7lhDJsma+Ar5n5zzohFcjfFIsTrg/QXam6YJPVO7bD1Uzk6rVwidjnjcHNtR6fOgUiS/Ip/adhjhW2TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzamXoOtHsM8mDgaLcZ/yGOe9G9QKKFPwq7KBrIlcY1TqIxL45U
	e7MlazVYKYrHSthh8+H85KCFsplbS6QngiEYcb8CN/fRP4UEUo7zdW2D
X-Gm-Gg: ASbGncsRz+llvj2cm/g0pqh7DXFElI5I7hvV1yCs2ntMEwn2KGM+dbWWm5yqj8qMKD0
	rOamCO2FS0XzI01xT0iafgyHsQIypEDsj3WWc/TLcDKH1FelDRNsTtqGfEwvlZ8oJSq8QVkzMAH
	TkHvmG2L0LY1xuXgaDwHpxhKIzfV8NYCy2YY9jJRqXWZH/QQYIaCaOQUPc8lxIertgYuInvtjpL
	6cFh7evmNLp1EK8kTg4tqB6YwpthpaWLPW5psoSkH1P/RDhIgXC/KtICVqVZNnu7PnKEyCppZn4
	tyOWDPJ1L6Q7FtFF1k7Aa7cNnA2+Ly9iUr+xg1N7xmjY8RRu3Nm7HSRXerHjTdym32neqQ/mhoL
	RTnllKktMM+UIvkO3i4gKvtccX9cd9xcjvgviEGuUXHrSSdAHUYbmSIvf4CeA5IlZs8WJORzwur
	bIogjdcNrlRnfk3Ylw
X-Google-Smtp-Source: AGHT+IF2/wLGF8U7IqobaReUdjkP+2v9OJwuJLYTpHefOZ7znmN+FVB5SLuCNT5E2bJ1o6OOY3CNzQ==
X-Received: by 2002:a05:600c:1d1c:b0:471:115e:624b with SMTP id 5b1f17b1804b1-4777323ec6dmr58832445e9.17.1762770318704;
        Mon, 10 Nov 2025 02:25:18 -0800 (PST)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777a96e7f8sm67326715e9.13.2025.11.10.02.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 02:25:18 -0800 (PST)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 02/11] staging: Remove build of gpib drivers from Makefile
Date: Mon, 10 Nov 2025 11:24:58 +0100
Message-ID: <20251110102507.1445-3-dpenkler@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251110102507.1445-1-dpenkler@gmail.com>
References: <20251110102507.1445-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once the gpib drivers have moved out of staging/ the build
rule for the gpib drivers in staging is no longer required.

Signed-off-by: Dave Penkler <dpenkler@gmail.com>
---
 drivers/staging/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index e681e403509c..f5b8876aa536 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -13,4 +13,3 @@ obj-$(CONFIG_MOST)		+= most/
 obj-$(CONFIG_GREYBUS)		+= greybus/
 obj-$(CONFIG_BCM2835_VCHIQ)	+= vc04_services/
 obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
-obj-$(CONFIG_GPIB)	 	+= gpib/
-- 
2.51.2


