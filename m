Return-Path: <linux-kernel+bounces-768874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1086DB266C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6532188E04D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751A62FE07B;
	Thu, 14 Aug 2025 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqNKiLlE"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940FE15E8B;
	Thu, 14 Aug 2025 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755177432; cv=none; b=UfzblNakQwT/zyNkD8/zOI8Q7NgetDQzUKE23Jv7706bfnCFW0QFgWFqWZiM7vhzh7EhuKoufBtEz/+rCMAKPdNNeR383E81Sj/3w2e1olI0VWE0hIJD1L2LQVikk/CXFqwJvMnhdZluqUhp75htJYwMQjdP0/KAeN8DCWbDzwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755177432; c=relaxed/simple;
	bh=beeVUQxqe7DuosrtIyRenH+B2lWiswk9HKRYr+2Awxs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c+scStiU3S2kybd0NfRfBGuCVql+idaRJkRXh23AUjDx2YhEZTzDFqQhSmsjr33mbGGOnSPF+6E9fJXZZSaXQBRExTF3YWokjYzDWRTM6EQa273oXoBchGarJ2R+yR27VS96Y7uwU4uqkTAaB20NNbXl+O/d9/SPBzwnp0HNNTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqNKiLlE; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b4716fb320cso691026a12.0;
        Thu, 14 Aug 2025 06:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755177431; x=1755782231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=vtNqM5cUWkHkJ7hl5Vy5tYw9YoAE/TzQUQgSXyn0i3U=;
        b=cqNKiLlEBXAMQK8sfiAnAFhDb0A4xtgGpvuM0iOcMVtlXr3IhEhFalAY0EXHNtEUKb
         5no4qbVR1HFUL3WzU3hD+3pWLG8Lj7MXcG/x5Eo63rj7IkYBkenR/ZBgINY1fPHjkoFB
         ACqHsqeNnXQWF4JCy3gSW52hq8ot0toCNFpTFTonsk1TtUYibvMVADSGRdejFFYC4bN0
         IzLbaW8FIEP5nhyhWs6zXj3yPfqHsM2EbLxWTkSVQuqKHfHhFQNOUroocTF8KOTu5XQn
         8mz3LYF0VnHYbb3N59dWzpBzzXBoQYm3MCO/qshJ+VwbNIDgg8bFyBQfFi+G7+xMIEXl
         zRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755177431; x=1755782231;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vtNqM5cUWkHkJ7hl5Vy5tYw9YoAE/TzQUQgSXyn0i3U=;
        b=CDehvJsk2swEGhuM1ohMSyfQLzDp0x7qIvLoF0bY71fnxWR0V/GeXikuuXTdq2RgN7
         A7YKnpgcrKpSbCwf8XqZzAwLuiqk3uOHGxCmqgYq0kEUhwN51YfH55h7tCoICvZGF5Hh
         VQzbHtWIZvk47uNeqwVkYwnyPNRKM5zcQH3oDI6z6Nta2P0+vNiPbh4nEjIsMELTB3lj
         hyzoOmtpufMh9w/5bol275p3lkDGgl1jI6mvz8SGSHE8F2N1WDYWsp/cgNLR8ZbL0KQv
         IiMVwJ+nVb0HG6502ntLcHGxYsVqeKwSNi14ZIfK+gw/KHC+7aK5GBXJ6dJIGm9RRvo2
         Fuew==
X-Forwarded-Encrypted: i=1; AJvYcCVjohxXfKwdXBRDWMT2Lvr3qgg8IMWdSd6d1/MOjtr77uh6RlRGW3msCUj7rSlwjSYY5wiqZuS/VI41@vger.kernel.org, AJvYcCX2z2z58HbtdOvlFGFEXjzrK0i2dxvwmqi/V/xiVR6IcYzu8tyY2SxVe4sbzqCNtm1DWRTDiu4ns4GEGPQ2@vger.kernel.org
X-Gm-Message-State: AOJu0Yzah5GkCdwewsJ0rPKPYPSyCbK1E3BmYKmnFgMAGtL+bh+d/Wjy
	Vd0XsTlzOUULlYe1jKGlbGpl/iHJ8PrOikzCDjCTHRCAMu1FM0zBWGKgAG9hKw==
X-Gm-Gg: ASbGnctS/KJIkQhfHVJ8W9X7TSDAUPrZyR/Qj/wLklzoIO6GoGEYw6t1bLoUdgNm+vC
	wtMEg86uRFSu2XtbX3yfjXdsIOi1+Ata0xN888f1nkHEdnbNp+Qp3ZPCzGsMRQAPBJZACdtY0fc
	5CyYY+Dc6KCVJvdgnUCu9XKwlx5fhZSWlVsQdhIZ4QG0OqbFeH0RcVqwr1jA5rMx0rJuXZIGQRf
	FLleCI1hsqtSLlfBNahly4XbFKjP9/v2Sr/ii+W8CHjWVI+/lhQIRa8c1FREnEwl5sPA2BSto0g
	Gai1It+4gr7qxdvcIlXEI0P8G1b7gzz+62vj45CdT9GHR/IWTaYh6ZyUuOF+V8DoLxSkut2ln+A
	DQBGcEcrzcGfuwRlGRf26fuwSwW2e7WP10YmZzq8e2aLKK36E1QAP7VDaHdaZ7t9E+Y1uH75HE1
	2sr+A3OV4eXnD/OeRqa95oDQ==
X-Google-Smtp-Source: AGHT+IFa7QfMuw5Y7JIUV4eh1A1Uc0XGu+XJ+9r3P5sIVVSAVSVpPVZ+2s3TAqMI+/lS4qOg8heSQg==
X-Received: by 2002:a17:903:1b03:b0:23f:e2e0:f89b with SMTP id d9443c01a7336-244584b4658mr43434605ad.3.1755177430731;
        Thu, 14 Aug 2025 06:17:10 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24218d8413asm335652995ad.63.2025.08.14.06.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 06:17:10 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/4] Revise Meta Santabarbara devicetree
Date: Thu, 14 Aug 2025 21:16:56 +0800
Message-ID: <20250814131706.1567067-1-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Summary:
Revise linux device tree entry related to Meta (Facebook) Santabarbara.

Change log
v1 -> v2:
  - add 'bmc_ready_noled' LED and update commit message
  - add sgpio line name for leak detection
v1:
  - add sensor nodes for extension board
  - add mctp node for NIC
  - adjust LED configuration

Fred Chen (4):
  ARM: dts: aspeed: santabarbara: add sensor support for extension
    boards
  ARM: dts: aspeed: santabarbara: Enable MCTP for frontend NIC
  ARM: dts: aspeed: santabarbara: Adjust LED configuration
  ARM: dts: aspeed: santabarbara: add sgpio line name for leak detection

 .../aspeed-bmc-facebook-santabarbara.dts      | 857 +++++++++++++++++-
 1 file changed, 853 insertions(+), 4 deletions(-)

-- 
2.49.0


