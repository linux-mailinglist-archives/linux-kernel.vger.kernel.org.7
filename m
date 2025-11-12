Return-Path: <linux-kernel+bounces-898205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FBEC54984
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:17:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6F23A7B2E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59CCB2D97BD;
	Wed, 12 Nov 2025 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzF0QpP5"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC62D5944
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762981974; cv=none; b=FJS1X6V3wksMBBe9vL0MblhVr5slIXfYlXIw1LOjgUUFX7PEXYoHujLXBbkZp/S6q3cBnIG/tsHpDu9iSkueTk1UWIH/VWpHH/C4Fxr9HtsxRpWK2gPyXPVS2ukAcuQFhWFVlZQ+JHWC6ZebaZ1p78Q8LCEOBJNwiGiEH7S9vFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762981974; c=relaxed/simple;
	bh=RZJdhn1bhOKDxWDWTYIA7jJWtzp2FszzhJrftJY1t94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HqadMbxXtr3KQCMaY5cWPF9DyXjL36y5uopRek0PPy5bc25V5uoIv9emTllcqbfrZiY3CJ8ZuSLpfCM4K6lwcBYCjvnYEcvf+4OxcgK12su55GaEe+sALf9Id6r1jKhYWZJXNR4J9QFJ6+Wx2JelpDqpYuCCH020svmQdlmPtcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzF0QpP5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-bc29d64b39dso59100a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:12:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762981973; x=1763586773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RZJdhn1bhOKDxWDWTYIA7jJWtzp2FszzhJrftJY1t94=;
        b=CzF0QpP5y82GGttXhB7Mx1lSOlSSIPXBG6Gx3cP6ZuLuByUg6xNeJzD9m8G2yVmXDP
         0ioSC3P9DEbRYBXa9ZchtthmGJ0BIFVYD1oo5L4hmHzstHzgxV6zUOouV1DFdX3EYXOo
         Ogvu9eBzDg9yBhBNhCRTzjAwXcze9N9IQG2/5lViE8SPn3DBQFCFxMLdOh/LbqJLMTdc
         YRcn4mZXL4WJY/pbyIm5Vj7mSi2UTqv+rlAuwOXQbOipJUoD8ve7ojgAR8ckveHH4hIv
         cBJwwqlUIrJV31LL72IX/xyts75SG6vZZzyTgJq+8PO8r3hbIa8/Bu93Za8g6er4DuFy
         OFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762981973; x=1763586773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RZJdhn1bhOKDxWDWTYIA7jJWtzp2FszzhJrftJY1t94=;
        b=XqfP/biBKztHYnqwIq34VHGmrmW8rbtZfFKkFbbN9WrfRoEeDtpHM10LbdxyFSGWdL
         MSUvFvwX6X+EFJngsOirb/197lBOazk6mrhixWjnqR7naY1dbaSv9gYBc6ZX7thFR6Ug
         lpUklIVLIbIe8Ax0uo6tEUMkK2Z5J3ZpHkiNpLs6lkgBHfhuqWMYv4//Hxp2JTLDtha0
         USOnBsGFHPttYGMMWYrHdTSpMlVDih1Ogct3HmXrk2zqXWUUy1u42xa4/b09esjcJRLt
         SSkhz3BthLRKo3BfSgYQaY7+mcCm615hFml/aFZWQHETDnb6bf3QK1Zvn0Ec9+ByoR/k
         7Nuw==
X-Forwarded-Encrypted: i=1; AJvYcCV6ZlaUqlU4pOqiv7jjqpnJXbKEdnFnQzoYheZVLXkW5BGJ0dBUcC99PzTSOB5xJCOo3fxI96eobrHvruQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0+8vZuevrnwQbON1/AiVW4c+tUn7w++38ms8FAQppbbM8IOyB
	LmPgvzYqhL4WF1BLpHNiy9R3ZObD3Dw3ySb5gZxL/TPG8GHIWpEfD8+WFkAR3MSXmV0=
X-Gm-Gg: ASbGncuJlkvg2FzeHMbtiaHGcegKzVewA+yz0hcEu6LRkiddQKMUFiYk+3auv1GoOdg
	j4xFskGqN7o36vzFpcujj97qKbS/ov8xZvR/MSHsgO3SjH6AsekS4GMbjLfgm9fkaloXmHEiXhw
	hgsU169xC3ludv0xTTEKMqz9cybsIWvkd2/tUAWbPGRGYiJ6gwzCBWvZzhUHvdntzBzvGvTj3aS
	4Eb9+XmE91ll8I/qA0e+4lpAHyc39inE/yHBSGm5o1QMWc+EFkJmk9FBLH2c88coj3nycPrgplY
	HKEBqSN2rzwO8HOfG+D9bxYF89EfwyxJb5caIwvtu3WQjgCQKXwefRLM4dDc+1lGqSxDDis8mfk
	m65tCom1DZONt9O+aTVVdTYQliep99cOJ/vr+Q729S5qB+46NDTClAYLnxe2Rg8KdXpU=
X-Google-Smtp-Source: AGHT+IFeIihBkU77ETtw+XHaa6KFXIJgpjHeG0dAkdR6b1vkSG3JvHMNOQ74vp6k+nYvvBf1xBPKlg==
X-Received: by 2002:a17:903:2f88:b0:295:557e:746a with SMTP id d9443c01a7336-2984ed34126mr48888625ad.13.1762981972686;
        Wed, 12 Nov 2025 13:12:52 -0800 (PST)
Received: from gmail.com ([218.32.81.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c245ecdsm1011525ad.32.2025.11.12.13.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 13:12:51 -0800 (PST)
From: Peter Shen <sjg168@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	peter.shen@amd.com
Subject: [PATCH v6 0/2] ARM: dts: aspeed: Add Device Tree for Facebook Anacapa BMC
Date: Thu, 13 Nov 2025 05:12:46 +0800
Message-Id: <20251112211248.3711889-1-sjg168@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds the device tree binding and the initial device tree
source file for the Facebook Anacapa BMC, which utilizes the Aspeed AST2600
SoC.

The patches configure the necessary platform peripherals and aliases for
OpenBMC usage.

---
Changes in v6:
- Rebased onto the latest upstream kernel (v6.18-rc5+) to minimize potential merge conflicts.
- Restarted the patch series submission as a **NEW THREAD** to fix the incorrect threading/In-Reply-To usage in v5, as advised by the maintainer.
- The email sender address (From:) is now corrected to fully match the Signed-off-by: and Author: address (sjg168@gmail.com), fixing the DCO mismatch issue reported against v3/v4.
- Corrected all previous style issues: fixed block comment styles, line length issues, and removed un-documented/unused device tree nodes (amd,helios_cpld and eeprom@53).

