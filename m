Return-Path: <linux-kernel+bounces-875478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D14C1908E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E33EC34910F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9440A313531;
	Wed, 29 Oct 2025 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0HLRTty"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02A43128C6
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726067; cv=none; b=vDHAfvzxpfziRycj2/jKX+ltSzPvUUBu0HeHJ4wnatX8Yt03D1ER0+xZMvttnpkKN6EKLkkRsOSvux22lMQLpolASIV5rhMj/VAmQxXeygb/42YilVAidkqQABXAi+ErXe04yfnFD6q50F5Rv68GrZGrFv1EEVG9s+r2SPciSlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726067; c=relaxed/simple;
	bh=z4QNcF9Eyw4gYd86FpxSeDFA3Dt0WD6vaP2DFa/zU38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ec8YZ+yhytDSBVN6965Bf6GvEE/bQaQHtLP2qQradUpVGsj3xxv+vKxmK3J5uTSeIO/1b1lliyizXiRo7WYBUeSWxLXd+RZDX6Tf5WNB0eXtaDWbHsZn5ZJrAn0xepW/IO1fQcmnUEaFEJW9JA9LwPZbbxhKYaIK/7DLj4W8KEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0HLRTty; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47114a40161so77946155e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726064; x=1762330864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QS4cXKd9nHCeMiJrsvhtqK1LgpajA4mb3ahi9ySMK/o=;
        b=g0HLRTtyOyd/pRIoNTaXTJTZZFwHoiOyXgWilj8PYDHbzm1opaHhRCVAK6NWkwJYRL
         K22y3szhtgy9+feOF3dkV2KHj8vtNBZMGRZyCx6kSWH0FUUkLXPtxt8r/SNFofaHda7y
         M9DkJwGm8pWZQ99FYWOqWTJnYvfaflkHKqfbYEOPaGaQb8IPn0j6jADYZrsLPnx/tncT
         XQAqoEl9nE9PIZpn3AaRjtdOGitzpn9IIPj2mrzhsDAQnXAPwsD8iI9I00Ob1XG5iQ4x
         hkDDbEcWERb3r6QkPMCvf/QzrC10uKYQ+59haizha5CHroq4yfpNfz68Vsex7L5XYdyJ
         c8cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726064; x=1762330864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QS4cXKd9nHCeMiJrsvhtqK1LgpajA4mb3ahi9ySMK/o=;
        b=XnDGjCJfzmVmdkN5qF5spv4mAiDz+r03cqsllUEU4Co4twZ5BCIrFUrF0o5Po58PWh
         IBlMlGQDGSGcoQ4jbHOXoSiouyXYlVMWpv4OYzF4wHj7KvO5LmtFl0T2dFMBMycOU8mR
         NYxp3PZK4220hN4HkgH0locjz4usJTktL61zv0Zj77YnoFKqBpKqwSgCl4pQrToJQvY4
         Lym/p8hjxTrmx0cl8mSAa5NSPALgxtkpI04jgC00sZccbqHNyK3lZDEYONHuMVdTjFpn
         5+fM6hozpSczujs2RDlzy/NkLwoTaa0WgfAQdBCIsLc9lgCMGuFqxSOa6/DS71Nvp3nA
         PQ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUrT1s/xWjjJTgCDWqPyYNa6/rIwXzIqnktFY1zKJzzhTv26GtKuaWsIJmfnse+C1XPD0xuS+OAjTIpQgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1u8DTe3yncm2bzG4pe87Qo5o6H+F1K9ZrH8V3xyu6PhskCetc
	fFJkLnHeOMLfXSzZtcvSRrScX4vBQcVQM96ktDoDowZKbH0eM/Afh1/E
X-Gm-Gg: ASbGncukgPRrv2NvoCO8eTYoo+Vl2K7lQ7KKeVTjyNZetjvekVNbb3m69vgTN2fdYBn
	oTy2OzTJr0TloIbruWvGRnJDedY8DO9lm636bWM9E/Y9lsek6ZYWoyfYpqBNnHbEIGqJXlV9aOA
	panLQVyCmt5AT0khgQ7mCNQ97En1AcZhQei+dc2Z3f6afNCXUZJrc95zzDbmt/UwQ60E4KvVCme
	4OV75PiW/vLGh2mQ5hf/Wko1+EP9HmELu8qtPpEyiNgxT9xYSVQZXIjX/t2+G4/zvqIRFwe62Hx
	a682xmVvqJZqknThdX1OsTZb/+j7mwEhUmLcdsBsLpmT15OkWC763bSeEt+GmcrEuQhCnDzac5b
	PVohtv/+9edonOMOmDm7Ac8WyVMw5OsvXh1GEHw2zHUXkyphZabJV89Jhx9c6cLQaP9Mr+jblpL
	dyL8CxqJ1h1G+3E0sKv/F0ou+/qGszYXuNKTZ6YBS/Fwjrkk/XT40x1Zy2iPCb
X-Google-Smtp-Source: AGHT+IGpz04tUrXPPdzvPALWiB03f2PPa2ldKep1ogo1wBz96/Sv/MlNxLIMNVL8/snHnNzdUBSogQ==
X-Received: by 2002:a05:600d:8389:b0:475:da13:256b with SMTP id 5b1f17b1804b1-4771e3cb77cmr9172205e9.38.1761726064072;
        Wed, 29 Oct 2025 01:21:04 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e196a22sm35191915e9.5.2025.10.29.01.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:21:03 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>,
	stable@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: serial: rsci: Drop "uart-has-rtscts: false"
Date: Wed, 29 Oct 2025 08:20:56 +0000
Message-ID: <20251029082101.92156-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029082101.92156-1-biju.das.jz@bp.renesas.com>
References: <20251029082101.92156-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

Drop "uart-has-rtscts: false" from binding as the IP supports hardware
flow control on all SoCs.

Cc: stable@kernel.org
Fixes: 25422e8f46c1 ("dt-bindings: serial: Add compatible for Renesas RZ/T2H SoC in sci")
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * Updated commit message to make it clear that hardware flow control
   supported on all SoC
 * Added Ack from Conor
 * Added fixes tag
---
 Documentation/devicetree/bindings/serial/renesas,rsci.yaml | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
index f50d8e02f476..6b1f827a335b 100644
--- a/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
+++ b/Documentation/devicetree/bindings/serial/renesas,rsci.yaml
@@ -54,8 +54,6 @@ properties:
   power-domains:
     maxItems: 1
 
-  uart-has-rtscts: false
-
 required:
   - compatible
   - reg
-- 
2.43.0


