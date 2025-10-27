Return-Path: <linux-kernel+bounces-871170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DF4C0C935
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEE1C3A1EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3922F6930;
	Mon, 27 Oct 2025 09:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZzNWtaWR"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D382EF667
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555800; cv=none; b=l43ns7Na2hg0c932/DaDdZyxmrHaI5+uPDeUN3TpYH/HNI/geJJkwZRY3R90PqYilSaSLiHLjeH+1MwOUOrOmoKM2Odf6yJaDXJUpMzLCuHz+ACq11mWQacYePl7dHfybU17zlPRFP6s88wiQH+4LAcNbFDZAND94cS9MXtMeNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555800; c=relaxed/simple;
	bh=39JSbHmlk2Zr3lfvER7UAMC1eMXf7kaYCS5xIFrjxks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbRIdXWlGVu/SNiCq0n0KfmlodzPudbM4X7Yhvn/I4xD5oQbMQnynANXWk6toi62yZq+5nYDDvvqZ06nohxH0felGxolf3ieoHYKsO8z5qJJZlYXpEGvn5LxYWhh0kHWsaYh4k4TLxU++9gR6E6OOlFEp7TjCLX/1KGc/Cdus9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZzNWtaWR; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-27d3540a43fso44634245ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761555798; x=1762160598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G2Xvuh0I/opmY/ziCGQafTK7nM7PxgpGRf3XOAE2Yhw=;
        b=ZzNWtaWRYmLgwI9k3YBLb+T1N9jJdjYIVjdts5PR7spwERLViiQHh4NkjoGOEQMdsc
         zSL4EoO0CB+Nysc7i7sPhJ6iaj4vUtyvgFTD+xEiYxUAuRnlEC4tU+pCmVU8UwwX7mYD
         sk4B+eSjiZPoC5/UHbiJQienmXvZIDXThBv2TdDBBxFnU19OWM+WhKnAJby/T7AbMG8a
         FDdq1oPMfP+pT6jb5PiLF/+pzTUK4HM+99BZhYtUFCHgXePuU+TDb8byyKvO+2FCch7w
         6ck/QzLriJeCEx/7menunNc/DBqfobox3lYU7i6nnOumer7Ed3WZQMvInKWNKMI++ruT
         xFfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761555798; x=1762160598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G2Xvuh0I/opmY/ziCGQafTK7nM7PxgpGRf3XOAE2Yhw=;
        b=Rx4//5rJu1a04O2mP4RhSHT4mG3cUzlfbwJ1/8b7MS4YD+YuQ/DBnxu8vBX5M02xda
         mYRZKYbbBX4E2gOnV9rLV8oNApbMlT5hAErWP0sxwEv3df4zE0z3duNMm7EzW2Ebgs0Q
         TkkI29cd5o0OG7LWV+Pkb2cscpu9h2iwhEdP+4Dd1rcuugUN/UUKHPvqhiimwcNhFZUm
         cREVr9cA+jP4R4GXuRVPFEflqShfeqdpc1d0Ylkc5aicGL2XEytEw0mJr/lzbg0AEf13
         MOx266az3pZzkRf4KN4rc9S82tIVk84r4PIZ93+pBD0qx7HosrGtxvuWLu/fJWsW4+1Z
         X9dg==
X-Forwarded-Encrypted: i=1; AJvYcCWsUpTTMx2YXxqwjUQO1gOTieICoZPyaVNzEkSn8h+QttRW4P4JtNLUOOsmjfKX0z2uxaIATcRN1FOocWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhG6nlaJiMFLOs5GsQg18yZtJvEj/vC0TdpjAWw7loi7Kw6ti0
	7f895tmd9MS320JIkDvMGsgvwyJ+1NzHnVsg+L+ZXMyEqjEuJJLWDP1m
X-Gm-Gg: ASbGncvuFmtzvWs5JlPhHqhYD7C7CAgZf2RK/aw3h6Tafwbem5hhCLtnhSeJ2wNieS0
	l60hxvLMOvdDXFLoeouyf0tMhKlOCquzzqP4CkHKS09luCF2dL7E5PHSPrLpDMlqai7HdrbazMp
	s122eEH1I+/PUBkt/9kX2q1VzucB2rsXS+9+rkyRLdNIQ+tsjC6o2waNKaxftjcNQZpJBkmLo5E
	lMCB0DYisie8qbubdFyQ6rwnghExpzFZmy7TeSTC8qC2aAvicpHAucMGu1c6xW6QZMNDrL880Ml
	jN4kKG2ieTiUW/aqP2EtqWIoSPtp1fwuW1CFEY+TI7pgTK675ueHt7FsiJxTMat1Of4y6pmv9JE
	SzJ9YA+I5vWRZhjoRiBwg/k+u9gVVIfrJu8mOiZ0SNrHi/7zoPbmKp4BrjBFYHRtqnz3rODMoH6
	PLjIvLothK
X-Google-Smtp-Source: AGHT+IGxRWBU+fTBAW0RgqmP8oSsQAfOzUEn3iCBlYhHwERcOsccVd8fAGBDoZpy6feb1Z5JjqF9+g==
X-Received: by 2002:a17:902:e5c2:b0:26d:72f8:8d0a with SMTP id d9443c01a7336-290c9c8c7c2mr441668685ad.12.1761555798089;
        Mon, 27 Oct 2025 02:03:18 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.108])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3433sm73881335ad.21.2025.10.27.02.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 02:03:17 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-omap@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR TI DRA7XX/J721E),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Markus Elfring <Markus.Elfring@web.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH v3 0/2] PCI: j721e: A couple of cleanups
Date: Mon, 27 Oct 2025 14:33:04 +0530
Message-ID: <20251027090310.38999-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the J721e probe function to use devres helpers for resource
management. This replaces manual clock handling with
devm_clk_get_optional_enabled() and assigns the reset GPIO directly
to the struct members, eliminating unnecessary local variables.

These patches have been compile-tested only, as I do not have access
to the hardware for runtime verification.

v2  : https://lore.kernel.org/all/20251025074336.26743-1-linux.amoon@gmail.com/
v1  : https://lore.kernel.org/all/20251014113234.44418-1-linux.amoon@gmail.com/
RFC : https://lore.kernel.org/all/20251013101727.129260-1-linux.amoon@gmail.com/

Changes
v2  Drop the dev_err_probe return patch.
    Fix small issue address issue by Dan and Markus.
v1:
   Add new patch for dev_err_probe return.
   dropped unsesary clk_disable_unprepare as its handle by
   devm_clk_get_optional_enabled.

Thanks
-Anand

*** BLURB HERE ***

Anand Moon (2):
  PCI: j721e: Use devm_clk_get_optional_enabled() to get the clock
  PCI: j721e: Use inline reset GPIO assignment and drop local variable

 drivers/pci/controller/cadence/pci-j721e.c | 33 ++++++++--------------
 1 file changed, 11 insertions(+), 22 deletions(-)


base-commit: dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa
-- 
2.50.1


