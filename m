Return-Path: <linux-kernel+bounces-875479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 718DBC1912A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1071C824AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4837C3161AA;
	Wed, 29 Oct 2025 08:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBaLoI6F"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39E30FC05
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726068; cv=none; b=rw0UrE0bBwmuiarKnojf0XDLfYJV0qEg2GO99m0K7IshJZ0amfLC8lfW5wLfGlD+hLZFiyWJ0/BtkZRPXbi2xJhNsJTQtWFEo4XpyCywWZ+Pr1PoB4TmfDgEvkRRfzyoyrNvJc6DiMqrOxMvtAX4zltcGpEq/z7dMiCY8UkDy/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726068; c=relaxed/simple;
	bh=qZoW7N0sN2JRmXRUOLhAa6wR0SjQGEcDLutTGWrtq4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FZ/0tZib5UFHz8pfX21w637LKGRcdmIhQmh4nS4JInBb0zUe3po4+nunuOQL5lGO/8ycTym5F0fAr30fVS3Uqzvm5gNDgIuVsg3Zrky5Qg3iPo6AZVikabAlTJmuxrV5kB3kHklFAC8joEx7ogJYP5GS80SNlNVXNxhBxZVRrG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBaLoI6F; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4710022571cso71696675e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761726064; x=1762330864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6pJvu/AhBQH/Vqyc2G8OkoZZLbCOtPgyePdybPKTWJk=;
        b=XBaLoI6FmnZ4QW/331CUZpS4EexBHt/2D8+y6ePD0kETOZjf0893sAgjvBGcftQ8nb
         QJUSzCzC6VohBkDK8fZ6WOYyIDZQWiKX3SmZcwGh1rSxgtxCGu6+V1cCrUOh1WI1cw1i
         G/PEOzBmm+BRKbOH9uiagSmOVWmyBV499W1E5/nN/LrYZqvHUXP60ezCMVUXAghE2ZZp
         o2aSxku9CsOxA//EwggqEx4ZVsJuaR8wJUC+CNVcX7uXechBSHdh8RtEqRfOHCVqCLgT
         iyUHQHQvC1CKI92QBLW/fSHnTmB85rsKkfEntZrzqJ8gXiZv0yf6XNuXaA5VdHjBmxyo
         4WPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726064; x=1762330864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6pJvu/AhBQH/Vqyc2G8OkoZZLbCOtPgyePdybPKTWJk=;
        b=wVeAUYbus/vdoeF//pZXeQUC+p3OHWXxMNOJncQY6aKnI6Zkb6k2B9miXmZlJsQZR5
         Z3OlXRO4gUO2FNaA3/5pnIfM4XpRKdPHJ8j5BSw54DFaTFi/BtgSRR+Xqa2SXard2cFS
         4xJI3KjLWBP315U/A+YDfiZU8TFa1FsLPcrS7op7t4J1AkqwnLLcwflmVMGZenQG3lOM
         QDxx6QjzEydRx4uPUy22nDbU3NB2oJbGcyB6o+G6QAFjbc9rB2BUZibe8HjlYrP+H597
         q5ebkZ/le9gZd77Yr1f89Rse40TlprwnI2z7KXBAye1peYLoRQqJ0zkpBKiG71HWGn1W
         Xbaw==
X-Forwarded-Encrypted: i=1; AJvYcCVksOcePOHH+5COwoU6olGTnr8pn6y3Mxo6qXVv7oeiQtydCC4VvquzIgshiMcs7MSFmdLlfQnDE37OcjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4a5bEqB2AxEAlg3g5kWuOkT+UXHbaUCeBEVHpqjYqDbR99eks
	PR3SUCrKSLSfoC8YsFwbrrDPnONMJH2lPkZlY5jmHcq2oDs3GNB0/PGf
X-Gm-Gg: ASbGncv2FkI2NBdwaDLhgOed4qlWOeG6gOBp1vefFtFfHao1lj7mVEcjzISDF7rjRTg
	2HnVElWrRQ30CmUMRVSQaiI5gFcXnrSZQKvoCNpk3ahjmHEk40b3RK5vplcD0tgd2uNLEVQQvbK
	T63iUbjFVDQiZvTIcIiVbnWJE8tE0tW/sTifYmP0HbCh77rsOosfjfmRQMckxfd0EfM9raxLY+Z
	f49QPF3q19kcF9BXIHKnSt3ERkoDm3xIFbwWwVE8RNZc0WlDsbFqISjUEKGEZZKABlLX3ZokmPi
	UcN+xHxmDeOsgs8yGSEhNwainmrVWDtK1AA1RZBRVg8Nz3j2ZIKKaZWIJGzL5qJKNfMxAaTpn1V
	SD1rBeYz14OOA15qBUPzMoWC5ha1235ZnaKv1SjRMehVvPAtuJq0R4VgrmiNkutJah6d22yeikB
	qAvixNR+A2cIaGtvdhSU3Y3tBdsVdpXyC8tPCdlVy+XxHjdeOQt8aWb3rmniQu
X-Google-Smtp-Source: AGHT+IHuZVrK8iLdLDMqrJhiJBdDaaYTleDzT7XKu/JdrTppl/2IYxy2VXVcdkJYm65pKirVPO41JQ==
X-Received: by 2002:a05:600c:4511:b0:46d:cfc9:1d0f with SMTP id 5b1f17b1804b1-4771e1de278mr21430785e9.19.1761726063434;
        Wed, 29 Oct 2025 01:21:03 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e196a22sm35191915e9.5.2025.10.29.01.21.02
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
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 0/2] Fix deadlock during RSCI FIFO overrun error
Date: Wed, 29 Oct 2025 08:20:55 +0000
Message-ID: <20251029082101.92156-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

This patch series aims to fix 2 issues
 1) Fix deadlock during RSCI FIFO overrun error, as wrong register used to
    clear the status.
 2) Hardware flow control is supported on all SoCs. Fix the binding.

v1->v2:
 * Split the fixes patches from original series [1]
 * Updated commit message to make it clear that hardware flow control
   supported on all SoC for patch#1
 * Added Ack from Conor for patch#1
 * Added fixes tag for patch#1

[1] https://lore.kernel.org/all/20251027154615.115759-1-biju.das.jz@bp.renesas.com/

Biju Das (2):
  dt-bindings: serial: rsci: Drop "uart-has-rtscts: false"
  serial: sh-sci: Fix deadlock during RSCI FIFO overrun error

 .../devicetree/bindings/serial/renesas,rsci.yaml          | 2 --
 drivers/tty/serial/rsci.c                                 | 1 +
 drivers/tty/serial/sh-sci-common.h                        | 1 +
 drivers/tty/serial/sh-sci.c                               | 8 ++++++--
 4 files changed, 8 insertions(+), 4 deletions(-)

-- 
2.43.0


