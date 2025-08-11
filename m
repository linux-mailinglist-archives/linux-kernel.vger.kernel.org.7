Return-Path: <linux-kernel+bounces-762848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C816AB20B64
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 16:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D7B51900BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 14:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F4E2459F0;
	Mon, 11 Aug 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cQoGNuii"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4FB1CD208
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921454; cv=none; b=ScNNCnAfbjIGyfnmz3xnhNM+R3iUYQwrQRHBZiLX3zadHZHsjz+iwvLJJj49fZTArS37+ZxKzJ+wG9MgXgRadoLinrStpCyO4cDdqVfohIkLxRwyo2gaP6zsu6Uvtufs9xzCTGPBQpHhSBWpn4k8NJLxuBFyeMTFzXxE5oAq5zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921454; c=relaxed/simple;
	bh=H6l53B4wZkFz+nYR8PTiIJtmbUzH50h27nGG3cRI8Sc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=o050EOaqY/pMHKhk1YDle8HVJg0NPXJNZ8W1/pSzpDKr7RCzDVRkh0DIWNozTrNTzBZWc+7ppzxfAWBESqlJ6s2tN7tlEMtDqBnDXuKfZLFOj+D0nlhtF/DGoSTc32V8M3tCYDENKG6U6RRDfOoPurecXKKoC9f1luIxIDYbg08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cQoGNuii; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae6f8d3bcd4so782183466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 07:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754921450; x=1755526250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ohexk0G5qQQ/U7tEXowxhsg85cDA9yyayQBpZFpm+6I=;
        b=cQoGNuii1t3wxQA/BCPJhFhNByfzmG8O3oqUORdG6CM5DLtEz0ls4mlVtpO2EwjHZ8
         oAKeEXSkZAPNUIV6SnxrBcGxnFvEBZ87PXST5iiIW39DFW8WKMndCpa/a9DVQcqPIY2Y
         KThSnT8S2f7z0ktfoV6Kmdg8GPLRcuM0M9ziCREypBQU++yAtNa2GYaY/QsR0Od07uiG
         CWZsyJfgoiJwfeDWwB1kg4kebItExrll3j5rJKduzKdniddtUDVIzbAQRnutwGGzqWsr
         hgwErzRUtmcX2DB+JF2EKGkyrXUJ1NbVyV8STgKVb1gQXOBRv4tENfBHmQkM9g92E2o8
         /Zow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754921450; x=1755526250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ohexk0G5qQQ/U7tEXowxhsg85cDA9yyayQBpZFpm+6I=;
        b=NFox+hdYw9KZ0TW/VgdwIP7nR3Myyv/qEBdCx8m8ErAtoiBkv1Yz4pI0MAFk6QLczY
         irze8ULBPNt/YlyOL3bHoDS29d1Y/7s6L0Rwp7SD2WYgIznAUPMG+Z8Ss/cqoBwtoUs+
         7TH4sh1u4RvF0Zb3ZxB7wkSQog2c4+FE3LuO5SfWhSHrvd3LpMkMl5ysZrerTGoGZ+5p
         tt1bb3VFCKsXuJ5eYsTIormGQDjYk/bsocesxpjb1w2B1sPcLcvmPNTmkHIWe/0CJioo
         yUqg0aE0LD+xwnayj0CGH6SLzpfje8/7/ssY5D8jfJRvKEz/bNfLLDiKQ2fb67DEkMvp
         Djvg==
X-Forwarded-Encrypted: i=1; AJvYcCX5NMglOMe5pIXVEQ0gn5q9Orx1Nnkmoxv0SiZhvQRPkUKKiuOBOr3VELVV9Qkq4dlYxQOwQh5WGg4dMZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnn4yeliWMWtm7XjcVPgXp15EWu67Koxt5wTPz+zVD6OtZjZVl
	2y5sJ//hdxizm+lQjooTI5tKi0iQ2+RBvch/mbcQCT8pf/2QXmxiyVehTBuOoAOCdWw=
X-Gm-Gg: ASbGncuws/50X9ANmCwQn4xc0jKdKN+eTsd2tX62tiPEBDXptGxEezSJwAxUGfygBWI
	GwkLN/ffNxT8jZnDzcNdR/5loI8+P1cVAKKxuFlzbrK7ldyEEBtRHwDk907gctv+KQ8zGqH6nT8
	GQKqv+IPemn+JfNHuotXy0CP4CMKURSRIIGXlsR1Z3QNgyctW/jvny3uUeI16j1h9buWDIvDYyl
	j1k3ZFuQkmoaHQMQqifTL78PHn9N5+iRMjlkoVbaqkiIEzLzi3lUXUBqWbnncFkPymgOmcjcQ/z
	KhhZJy97BS3hb/FeMcDBdu5VtenA9nhgMILx5vM1iKYKabtarlZajCA3iwdV94D4DltQB2cQyL0
	54kqX7CsDecztoMfAiA+MwOd1cF1KC1blMo0cJHEj+DMDYT2SsK14YuNLxlZ7Yb3+KQ==
X-Google-Smtp-Source: AGHT+IHdBKFk8Hdz0O5Qrkqv+q1AVcT+ToZrNVbbDng2NMf7Xf+fMHPhcyvkBGiKagZpBw13o0Tyeg==
X-Received: by 2002:a17:907:c1c:b0:af9:71c2:9c3 with SMTP id a640c23a62f3a-af9c647bce8mr1317574966b.35.1754921448512;
        Mon, 11 Aug 2025 07:10:48 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a23bedcsm2030552266b.120.2025.08.11.07.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:10:48 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com,
	Matthias Brugger <mbrugger@suse.com>,
	iivanov@suse.de,
	svarbanov@suse.de
Subject: [PATCH 0/2] Establish the roles of board DTSes for Raspberry Pi5
Date: Mon, 11 Aug 2025 16:12:33 +0200
Message-ID: <cover.1754914766.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this patchset is composed of the following:

- patch 1: just a cleanup to get rid of duplicated declarations in the
  board DTS for BCM2712.

- patch 2: explicitly states what BCM2712 board DTS will host the
  customized nodes that refer to RP1 internal peripherals. This is
  important so that followup patches add the nodes to the correct
  DTS file. For more information about why it has to be done, please
  take a look to the patch comment.

Andrea della Porta (2):
  arm64: dts: broadcom: delete redundant pcie enablement nodes
  arm64: dts: broadcom: amend the comment about the role of BCM2712
    board DTS

 .../boot/dts/broadcom/bcm2712-rpi-5-b.dts      | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.35.3


