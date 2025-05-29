Return-Path: <linux-kernel+bounces-667007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18799AC7F44
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 15:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CB2A23D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 May 2025 13:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8F5233152;
	Thu, 29 May 2025 13:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DSlmVOqC"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C618E22F166
	for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748526575; cv=none; b=EKWam7oC76CNN3imcPJBnzKsXMupkxezrTtm7P8IfRYQG8NjChHFAZ+qVo1iNMJFU8iEkEkD5IuGnYTJarFXYU5FyWtDYu+fx4UKDJfPoueDRNc1qYFY3qK1JSQezz+97QVOf1txMnaOwJOG56eIVfefXPHRzf6fip+5Bp0aaOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748526575; c=relaxed/simple;
	bh=RRM404hdZVflbCbuZ7OBxFTgWWaneCmtEfkgg/Xp1Lk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lgzwZbVw4WjHRiZe/SF3n6Ml9ZmhMQU6dXXAVWjapDgqkERAiyK0vzHYDXfNSZReftBGqh3odAyqn3L6J4IDYUO7VHH455CfhiREOhjoNh/A36Y7HE+y+bsn8D7NzgcxoT6pxwXTjpIqts3LuWN9Z1DTy+AXYxLKagl82iwzgsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DSlmVOqC; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-602346b1997so1470160a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 May 2025 06:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748526570; x=1749131370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hTCgL7Vlc0a5ielumzwkk7bjVhaA3TYeVWaUN3CkeyQ=;
        b=DSlmVOqC8tFVQh9PifCTO3dTVQm7c6Ym5Gi16t2dMktNE9kuYyieUwCXmlr6S4rx/9
         8A8EUa8sl0ij+fUKAuKFufNPS/wr463IKXnhy2oqeIFaJYyIcpcaiErYPrTndmH3Qcja
         ayW9TsUaamZ+5IQpG1qiqwdShEsSCEIRSuZ9bvzH4ne2yAgM/IJcoSdg5rWCODAM0/l0
         klUoJDyEBkqn1pSSeyPjZvMVK2YrOO31IogRzLp0Z1yMq8uuLHnTw4HhJaLWHtnVnBSD
         bjFF0za6Pd9a+h92ezd9CkSjE+S4GJunZdCDpMFalAbsn/X6Ddhlt9gfQhN4e4xoWbPj
         XypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748526570; x=1749131370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hTCgL7Vlc0a5ielumzwkk7bjVhaA3TYeVWaUN3CkeyQ=;
        b=ucQ+fnk5v7Vw50FzawwxdCx1+6uF/OfJb5ZCgkEIOT4NIxXKo3WGeawkwXwexC/89p
         jOO33K/dK6PIQfc5X1BA8romF8yTG0npZIapF01s0moG41Rdr+v9lWoBTCuVdskJHQ79
         0fomEOSuRtd1at9eX/7prQ5e0VkRuvI3ssZKQpXfj0JdGj71lQDXgLFydr3Aja4n/nyP
         AetPftwbLmYF9LClG34Xf3ppwmKucJ2FJ3gEommjDSxuXX6TJyHneGlG/anA96r/dIih
         Te85K9afvKK8TaGzyhOvs6nTtPjdwDgqxlmFMmNEN+rBNpfMuiEeC3FFgfp0oa6s3AHW
         tafQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgHE08uDQgFefChOxH6kCnbtzXZ5or8T0pKjOcItlPy1zaub25H8POFMjWeYDh09MW076Yfjnh6Zu3o/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFrKVdQeOHDDvRn2lxjXnbcnhcqj6EWqohZC+XNetZVNmRBpUc
	pvqww+buPtQlhM9Far2wAHk0VrX5qqEyaGqrhHyMufE8PZWmpgwsMUUpmJMoFUlCbZY=
X-Gm-Gg: ASbGncuKsGDog0w5+xBbR1GcKH97Wijt+kR+fOBHb/1qrM2Qx1j/ecaNo524rFOVSYq
	Ta/8y4aQzs8yBTKinW2rizAtQvR7rOSABM08UYHgDkEPqnr8jwim2htiIg83o/OTn2mvykDAX6y
	rEnFINDGq/4FT35XcDW02p8NHJQybBJvBrgl+Y2dVzscjQZfmcrrl1yc5R19jdYPclZMIbin8Ky
	ueH4Z7mooyvSMgTDAJvNJv0ZoxltEFID2MqD7AIaL2BdUX9dRoCHmHXQ+5yXzWUbdH+shH+C6sy
	srD0PJY3KPMsDtrnhdVgqhDL1Rs16U37e+77JmVqk+sVwLBcOPYaD027wOmUoTWAg8c0IE9hrQF
	oK/9ClHi3Qn7SkyQ3Xl/S+A==
X-Google-Smtp-Source: AGHT+IG4MzMu82x8TfpgUN9WiYCMM5FeHzKNEVK3ejORnoVUR1rTDmcODCtdcmtp8bgBgoEd5vCLFA==
X-Received: by 2002:a17:907:9410:b0:ad8:a935:b90f with SMTP id a640c23a62f3a-ad8a935c99bmr503129766b.7.1748526569836;
        Thu, 29 May 2025 06:49:29 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82becbsm147641366b.39.2025.05.29.06.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 06:49:29 -0700 (PDT)
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
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
	Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v12 12/13] arm64: defconfig: Enable OF_OVERLAY option
Date: Thu, 29 May 2025 15:50:49 +0200
Message-ID: <20250529135052.28398-12-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1748526284.git.andrea.porta@suse.com>
References: <cover.1748526284.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RP1 driver uses the infrastructure enabled by OF_OVERLAY config
option. Enable that option in defconfig in order to produce a kernel
usable on RaspberryPi5 avoiding to enable it separately.

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index f6e9bb2a3578..ccf2f50673a3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1659,6 +1659,7 @@ CONFIG_FPGA_BRIDGE=m
 CONFIG_ALTERA_FREEZE_BRIDGE=m
 CONFIG_FPGA_REGION=m
 CONFIG_OF_FPGA_REGION=m
+CONFIG_OF_OVERLAY=y
 CONFIG_TEE=y
 CONFIG_OPTEE=y
 CONFIG_MUX_GPIO=m
-- 
2.35.3


