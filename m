Return-Path: <linux-kernel+bounces-878847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6023CC2198D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E6CA24EEAA6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CFE36E376;
	Thu, 30 Oct 2025 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JGe/LOP6"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF6C36CDE4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 17:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761846937; cv=none; b=Fh4KYCId+qm9B2q8zi/UyxMZ+6wWnOfgiJbTYNBwkodi1RuQsSpvgTn/S3EvT/T2I9V08aYShAG2+e7PFUC4Q/lgrCDlW0BY2Enh7qnJYTY+8zls3wK34yy8Q0gTDJTEBHbc17yz2goXd81Ivtxf3q/CGlfGyVjIjLN7SXtHScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761846937; c=relaxed/simple;
	bh=hRGcrf757tBUlPVJghD36FxXRGKWF+Ddzd5vihoN5uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KD4+vwdDpQpllms95k3y84rjEQozoOHqcrxmGW+XjVnmnr8EP1jdOnS7Or+BHp0Gy4vSY5TKx4feHhx89is95t0doQ7hi5RGMVzZSNrzKV1ywsbDktCbIttE/nK3EfEWI80wR1Jipmz733zurgtGvH4LTRCG7qvZiDNVwvA9jR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JGe/LOP6; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47114a40161so15220345e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761846932; x=1762451732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7uqGmMoi1PPAQaFicRlny+AD/MJGroEdg5O4X9kuPbw=;
        b=JGe/LOP6kP0kR3YkY8Zb3tovTrvToZP561qYcPgDTZTAhjepk14eHemg5Yf1+lX4hc
         B6kXOVgC770FUX+5EnJhk/tYMqMh7QaN2KD1spjLFmyWj39Lm2vsbdAF1RcpeNSMm+4x
         Xr4enHaO5Fdxcl/hh/iMjfEOI2qDUE4TGc7CqepFDBejhlPBdxoz1Qh0GdXyFAoWcVvM
         RJrkMmGyVU2WKyyUjzb8YrKyyPbl5BS9a6+ZiEJvZh9ClX2hX1zme6GV1WYi3jo5HL4V
         QIlaaAZp5BELY7hS9AtYQ4GBSRH1r3cn07pTn2pVkiVHhrebYnnD2oFDLaNwnPhYYWWe
         0ODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761846932; x=1762451732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7uqGmMoi1PPAQaFicRlny+AD/MJGroEdg5O4X9kuPbw=;
        b=ZbzBh8WPmv9W2765nshphebX7gevY6qngIF9d+5CeIObRq+ubAo3SEnAiJRhJRZXQH
         kqko6Sskcy2oypP1B4iHffIbRFlVaue5faNOLwszV4K3B8EKS5bRu0XnhDEs/Jb1fA8y
         hIvXbDJF7b4ktQSEM0s8p0P0VCLR15GVqcuTtQWtjK+D6MzpT/6eBkYXwpgZxDnT8Ru3
         VF1hZ4/n1AnEKe75qr9sAMDwA1VFITNktL4fGyJBMqs0i4O1m7l8rpPoCfraXq5wFbLX
         30NTUkB4M1M8ktT1xJ1TuQhBKpgwO3ELnyG1ye/NtCzdtOZOkVqjjz8ZiIxCVz5/VtlX
         d+9A==
X-Forwarded-Encrypted: i=1; AJvYcCVyk2VZaEzbQFMADexr7WIPigWfp4l7O5n142wUqqMGhPLuuiB1bg+n4Qy5udQQP7jWqRs77h7l0YLPxH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTSMFsMDXcTCUb/Na6L3pdKkgLMJW4613Y6uramnvvZcRgm1WY
	+CE6pS2VENgU/9cL0AcjFJDF/i9zS8onIihbvYgcumqpQVCSJ603++DY
X-Gm-Gg: ASbGncuNpcEjeAhYsmYLCjhxegMZ6+H3G1crXP+g5nKKMPZ3UCC5lc1z/FdhpZbQKQR
	beuAm2Kk4gkOXXBcsJ6xUxNBjUVK/drlNpWak99943RqFbu+gg2VMRIDIizAp9WL0bQueY/y2g8
	5Nl5XRgMrBkfrQMu6c19p5/D4FdXNve6jblCPRd9hmClQ7nDbK3xaaFt4JLhS1IXv1QkzpTO151
	xFRxZrmTOHB88sBVjb3g9DP68s/oKsZyy2dFBGLElfW1oyQ54xZXrhmMsOIRrGp3ACMfDDBokh5
	sWAFSzGNOi90rXzOStc5Ye3ILWD2U90CCfglnJ7orljpLIcEcPGxUauD+rUBVYz4KBoH5v7Qi3P
	NVxYZbUFss6fW+/zFR4AjKqUFpDahC7cvH5hpVcGAx5INw15NhZWyCcexu0YpKdIDJvP/K53h62
	sBuV4ivDj1vazTf4Id7ek8goA9fTR75JjEV9J+vX7+rcBohushqRSihKTulVgd
X-Google-Smtp-Source: AGHT+IHhalSgP2kmhosVrLIAl+xUpJ8DATCni255mO2cl/2W+LygbY8oRYqgCijoqXjlLsSWAJ/x0Q==
X-Received: by 2002:a05:600c:3e17:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-477308aec8amr6285475e9.31.1761846932213;
        Thu, 30 Oct 2025 10:55:32 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de5f9sm33384041f8f.38.2025.10.30.10.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 10:55:32 -0700 (PDT)
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
Subject: [PATCH v2 07/13] serial: sh-sci: Add RSCI_PORT_{SCI,SCIF} port IDs
Date: Thu, 30 Oct 2025 17:55:11 +0000
Message-ID: <20251030175526.607006-8-biju.das.jz@bp.renesas.com>
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

RZ/G3E RSCI tx/rx supports both FIFO and non-FIFO mode. It has 32-stage
FIFO. Add RSCI_PORT_SCI port ID for non-FIFO mode and RSCI_PORT_SCIF port
ID for FIFO mode. Update the rx_trigger for both these modes.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v1->v2:
 * No change.
---
 drivers/tty/serial/sh-sci-common.h | 2 ++
 drivers/tty/serial/sh-sci.c        | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/tty/serial/sh-sci-common.h b/drivers/tty/serial/sh-sci-common.h
index bcdb41ddc15d..ef1d94ae8b5c 100644
--- a/drivers/tty/serial/sh-sci-common.h
+++ b/drivers/tty/serial/sh-sci-common.h
@@ -8,6 +8,8 @@
 /* Private port IDs */
 enum SCI_PORT_TYPE {
 	SCI_PORT_RSCI = BIT(7) | 0,
+	RSCI_PORT_SCI = BIT(7) | 1,
+	RSCI_PORT_SCIF = BIT(7) | 2,
 };
 
 enum SCI_CLKS {
diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index d07424caeeab..6f396e1151d8 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3149,6 +3149,9 @@ static int sci_init_single(struct platform_device *dev,
 	case SCI_PORT_RSCI:
 		sci_port->rx_trigger = 15;
 		break;
+	case RSCI_PORT_SCIF:
+		sci_port->rx_trigger = 32;
+		break;
 	default:
 		sci_port->rx_trigger = 1;
 		break;
-- 
2.43.0


