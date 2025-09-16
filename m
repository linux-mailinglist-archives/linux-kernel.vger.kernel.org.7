Return-Path: <linux-kernel+bounces-819430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E40FB5A08A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 20:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE1F174C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 18:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCE02C0F84;
	Tue, 16 Sep 2025 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VFhBGG5Q"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4699C22758F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758047603; cv=none; b=HVsRlHZh06cn4gnkxhtNHBmT64CQZUMUWwhDSiTL+9mNLtLEAHi+6kbtS0zA8b5cxxGg9ivLleS5NZQnCMzQjy8kCjeYj/2cudSMyVjtINxHhyrZYFOOtcamoO5RUCq6RhNu0RBF0Ezvl1AvzQNT89eR67a76FVKWnTf3Zj0m3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758047603; c=relaxed/simple;
	bh=3UYdzezrnAbWicx/EkzOHKw8TZPWI8saYWaHMqOH29Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LN35+yh2m6E9sc7f6QX2qV4PRhSvHUlE7HXUB1xP7OP5HIwgtiN3n59ZfMyiinau85xb7koJVsgZC34io2/NAIe7I3aN4LJiBw206LtLPfqPbYrspajCRbUKw2nM6R84KFRd9P4Gj/JcM1HqJe/AlbiMkGBdhek5XH91jQT8Kc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VFhBGG5Q; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-77615d6af4fso5429102b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 11:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758047601; x=1758652401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5dZ9MXF98QAzc2XsUubA8DhGV0oGfqHkurab3qXPRaw=;
        b=VFhBGG5QFPBjjuhbpy8C7wR/9GkokesW7cG/fnEplvZcMoOZFF/O/nBmi/ASPkgh76
         fN729lMtQNMArpXcYS4u92RhkC8p01c/ZqjHIJj25+uzIsT27lkXxq2oqeRbZHJqh1bm
         SqCbNMijvcZYDd9lFGfHXCKBm3JtlT9o8sBPo4dGG1nVePKrZ1tYgDZ6eB5s4cQ6QeBv
         RqR19XjtPIjD14LOIgXVbhkcYIPC6/xyJ9y4lpuykTdclxX6jFTnqpD6fGVj81LB7QJ5
         oTazWE7p92mhP5DJu5hZ8D7AXLu25W46W58JZ1OLM5yeAiGVd+wOb7pUd9sGjMz38Jf7
         ZbmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758047601; x=1758652401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5dZ9MXF98QAzc2XsUubA8DhGV0oGfqHkurab3qXPRaw=;
        b=v9f228pH6IHQ6CzgM4S3izVEOXOu6v9vsCuOoCR2V8mQi2WCDVYr74Z5EPNryfSbBg
         PlEhEfnyZocfNvoZ5bpzJNuPpYOqC/a5mWCCOAhb+ZYg9aWLkkFXi1wdrzf9LqcwNcZH
         NNHauT+3fm0hTzNi+RswPpit5dTRudayBVQwX+wXKtAF/1dagIA0XHHSshfRa4I1YwCY
         bQ1jf+uxYW6wA4cy+G36cbhxeTG5SXFTTYCUnaDDo7z4tqhxOXGTGM+wruYvZ4V+QCQ+
         CtVJ+5I1hSKO1u1arch3C6SHm1KUTR1ExRNxLQjkwy11R/09j65Q97/BzViRD/7ouA/D
         19EA==
X-Forwarded-Encrypted: i=1; AJvYcCUzAwZ0xMIyvvuUXkDpaT7D1qDzAuTeAEK9tyyCVkCSwsedke3nnvO/9tAT2tzxGSojQpG2/CIJt1S+DiM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAhyfY9qemI/a8piZSR+KQPhsMdwKnn6BRE/vUZPw2BZzK/tJn
	Gyqk+xdqhgt+PJEpqTRfQLasg4PkROYCLHvpVeoDGbKtq+TJC2pKZjcr
X-Gm-Gg: ASbGncurD7+jI6E6vXmmPCBw4vnjH/qewo4JbuxkZFoyfoLUOlZtCVhssYdIfSIa8w3
	MWQ8X/icZn1ukgvO2qSgLJF5RQGx+lW0Dsiji52PmloXLVClTPLVyFK38T19GKedel0GcPD6di6
	zMWp7LlkMTgcLAZdgjstSga463Hn7o3Upk9NoTMceafc0bn8QYxNfrsRKBEczjX6hfqCIItiz59
	bIjI4/2JVHiYftv+6mrDD4crjHPwnoLkkM1woFcSWflIyB8UXSxCDgFTE8yv62TT8neMeRMCdx0
	Rk8owaCpE+go3PxMsbq1DQgYlg3qpwFIp5S765EgU87tZ4csq0uttp5WUurOYAZy1kjFwBxOKeT
	jcbVN2EmC0OnE5DpBPuyg9eEs53r5rgxmzaxoao3Gr/VSK4OTp2q28pT6
X-Google-Smtp-Source: AGHT+IE3Kwjmnkly+bdnBWDnePVbr+VLoHO6JP0k6Rq89c063UHcBeWsHjCbOuj/rEGtZxW20QBHKQ==
X-Received: by 2002:a05:6a20:1586:b0:240:328c:1225 with SMTP id adf61e73a8af0-2602a49d995mr21766555637.12.1758047601511;
        Tue, 16 Sep 2025 11:33:21 -0700 (PDT)
Received: from mythos-cloud ([121.159.229.173])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a387b543sm14915968a12.33.2025.09.16.11.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 11:33:21 -0700 (PDT)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net v3 0/2] net: dlink: handle copy_thresh allocation
Date: Wed, 17 Sep 2025 03:33:03 +0900
Message-ID: <20250916183305.2808-1-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains two patches:

1. clean up whitespace around function calls to follow coding style.
(No functional change intended.)

2. Fix the memory handling issue with copybreak in the rx path.

Both patches have been tested on hardware.

Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
Changelog:
v1: https://lore.kernel.org/netdev/20250912145339.67448-2-yyyynoom@gmail.com/
v2: https://lore.kernel.org/netdev/20250914182653.3152-4-yyyynoom@gmail.com/
- split into two patches: whitespace cleanup and functional fix
v3:
- change confusing label name
---

Yeounsu Moon (2):
  net: dlink: fix whitespace around function call
  net: dlink: handle copy_thresh allocation failure

 drivers/net/ethernet/dlink/dl2k.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

-- 
2.51.0


