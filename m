Return-Path: <linux-kernel+bounces-851846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D571BD76D4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 07:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1ED18A284E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 05:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C810C26FDA9;
	Tue, 14 Oct 2025 05:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOGdogld"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA30022DFB8
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 05:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419964; cv=none; b=dCh3DmqaarVj8vFGKRjYTX2ECda1l/Z8xvG2MmPu9Sp/y8HGyJhVS8dnUj5FxUk7iLNZFNp8FHuqbAHdv4zm3vjfIDmeTaBSO4QxHU9WlWw0cyK8pzaIr8EAJWhQlRFU8rF9ceUVPw7q3OmqyyKAyBPh+nwW51fQQ5Hi8cxLajI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419964; c=relaxed/simple;
	bh=hzo49Ka/mFjKA/H3SWa4obvcXKQktgs7Ghe2hJguy5A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JSsPfuEy+9/cTIFnInb0pCbroR46yF8UQobn1koRTc5/TX0L3tyNXPAn/MuinQXadFo6aKd6o4YpLBkBKIkp1MCwGVeOCyJJb7wQ2OLmqIDnl/RQyl9yfB3wFXX/V/vg4ZSE58cRbHOIfnWomeD76yBOz/jgB5O4AeAIXJX53Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOGdogld; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-78af743c232so4436151b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760419962; x=1761024762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ea5NSCkOYMJk/IQhcF97hrapZkhykXrBU8oYzRy5ZM=;
        b=KOGdogldCERSFIgcgN8uL8ebqT2+z3WXPIuIURuEmk7fxPQ6pHouFEmBdnkB8nyEHD
         QIJdU94j5M5MptGnKSKbebv/pAESTsWiu4TNsreYNcwxUMqlvby8kShF8kztAiWboRx+
         uSXZ+BovUaP2S9mdUwH5/9uE2iKtnRykM0xAsUahv/aW2woCDoe0qkZkNWxIePYMaB19
         nog5DgGe3t3MgTQLUviqSZIp2BuvFh7pGXgEHd3wRAcHLvkNbOC2nKfWvQjUPsIvbJRJ
         jN8lleEQw5ifvj+nZoXF1ycgwAY2EUALC9JA5/y3kgOLjvsf3kFc2yboljnLtsDGKpe8
         FQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760419962; x=1761024762;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Ea5NSCkOYMJk/IQhcF97hrapZkhykXrBU8oYzRy5ZM=;
        b=MgDn/a9YvB8cyhLoytgLOjM8AX/hRpV9NmZ7Sqgp6iJyESpmwXMr8vaL47RLgrEtgx
         dFR4dbxaafuAYXZkMEktHzldXpeYs9pKzRgfBMwH22OYA75EyeJL7RgpBHqtprbgDznx
         N56APi4PAM6JBWcwLdmVVYNDoS+oJf/BwolXENo8Ity7PLbfoyUFTBngNke0MjUrQ0S5
         8hicJbnsO2+U1Hg/gaVuSCYy45Q8aWbkE3XjzPkT8r5ITXlWz2X3H5era/yiCJNyBQds
         OuL+s1+PvYG1lFhOZ/9QhLwCYEQqlVCHOdnQeeTQy3tSiYM8Amf80ZIQLPA5dA5gDJK/
         fNPA==
X-Forwarded-Encrypted: i=1; AJvYcCVbsQKKXbkkMvcCVpzBzq4cydlHR4BSZ2UPObyqfSpMjqa7cZICZzaD+ewz8qYIutHe/uFSYnW03Qv1liw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoG9SPL0nOtozAvHmYAACpsnS7mMgpwSxGG/kDO8v5gJRzb9q0
	7yi2wEU/UcfTPR9MBZw6jEzBcbL+a3/DQdTnk7OSdd/0/ZSPxzgG+2Aj
X-Gm-Gg: ASbGncvWHaxmNfY1JoqBegjH8zPe4TwfSaTF63OjnBY1dtOWkGpk2rU8VxuDYZv0d/s
	ox8/GlJT5z4z3bKrfXMg/tuNQEJ+pGJe5sYfG5wV3X/An8wGNCHD0j+NgzauWoP8OsOhErurnZl
	QneewGTuxlV1ZeHo72EIq5WCTCPKfqrk2P2craKoJBxhnoeazHrUkJ0t2U8XBNbGO+H9qw3GQXP
	kNMwRGEUNfTRC12bdofHOqgOxqp6/8POWRWxuQllpgCPKioK8dY8eJlMVR11tuUBf7H2pJlOjwO
	EvaR0fnudAfBLuEmuUAT76xi4F6EQ7bExrSgUTk6TnvswAQSL5i119SkboqKGtqwNWd7qqqmK/0
	oMR5HbA6RQpuaT99slcCqZ1OKWolBZsxEU59VSwF7Ogfz/oc03il76j/v0AnqVahx84DHeCY=
X-Google-Smtp-Source: AGHT+IE5opfw1ALI+fPEvrYyq3kqHeGMmNoJ41xh3ry6iaCObXcYfOfolts5xRoqBqA9T5qTHi3ETg==
X-Received: by 2002:a05:6a00:92a2:b0:783:c2c4:9aa5 with SMTP id d2e1a72fcca58-79387d0f5aamr31864888b3a.32.1760419962148;
        Mon, 13 Oct 2025 22:32:42 -0700 (PDT)
Received: from HYB-iPCgmhaB8Cy.ad.analog.com ([59.9.235.253])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992bb11ca0sm13707518b3a.32.2025.10.13.22.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 22:32:41 -0700 (PDT)
From: Joan-Na-adi <joan.na.devcode@gmail.com>
X-Google-Original-From: Joan-Na-adi <joan.na@analog.com>
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Joan Na <joan.na@analog.com>
Subject: [PATCH v3 0/3] MAX77675 regulator driver: Add support for MAX77675 device
Date: Tue, 14 Oct 2025 14:31:39 +0900
Message-Id: <20251014053142.15835-1-joan.na@analog.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Joan Na <joan.na@analog.com>

MAX77675 regulator driver and device tree bindings

Joan Na (3):
  dt-bindings: regulator: Add MAX77675 binding header
  regulator: max77675: Add MAX77675 regulator driver
  dt-bindings: regulator: Add MAX77675 regulator binding

 .../bindings/regulator/maxim,max77675.yaml    | 205 +++++
 drivers/regulator/Kconfig                     |   9 +
 drivers/regulator/Makefile                    |   1 +
 drivers/regulator/max77675-regulator.c        | 868 ++++++++++++++++++
 drivers/regulator/max77675-regulator.h        | 220 +++++
 .../regulator/maxim,max77675-regulator.h      |  52 ++
 6 files changed, 1355 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/maxim,max77675.yaml
 create mode 100644 drivers/regulator/max77675-regulator.c
 create mode 100644 drivers/regulator/max77675-regulator.h
 create mode 100644 include/dt-bindings/regulator/maxim,max77675-regulator.h


base-commit: bf40f4b87761e2ec16efc8e49b9ca0d81f4115d8
--
2.34.1


