Return-Path: <linux-kernel+bounces-769501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CA7B26F7F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C25CF5E39DB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050C923236D;
	Thu, 14 Aug 2025 19:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L8IBiQoN"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE771E7C1C
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 19:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755198582; cv=none; b=MPvuP1xGCx7xkcceRWWPt/vXlNSk1BFGk1CmmJjkqyvp+CpW+ejamC5GkaNCLjffIvZEcX3T/73McyM1wIaF5HBx/h9f+J3LRdZxA6r+8YmFc8NqcKL1ECxoONyyehHGnL07EXZyM165lqL7kqHaJA6IqpDqwLfw3SUjkF0tgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755198582; c=relaxed/simple;
	bh=KNio4ODVkMb2Dwa7TlchK+3QYEgjDtRYbY0284Nxpgg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=tPmO7XmeQhTUpniuL5mK/11Mqr5TGUwWTSSPGbb1/YEjEPUg/oeucgTk7O+9baHwm7nOZd+2fz7iQk8os1zv5P0S3MEfMcppT+izsj5BXXeiEkzbX6QEjkg8aybuTw5Pwv0ye8+HCY0O8tRSOt6E2huBUoDocAJWsurqU8cmrOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L8IBiQoN; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-76e2eb20a64so1614773b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755198580; x=1755803380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OEjnFUI1OWJiYFgFirOakE5jC0jpwBgJAeHvFVm1J5w=;
        b=L8IBiQoNokYn28sHX9Y2OpAN4wfMLwCFOldyfIt9ITVDPJI6Kl08grzGBvbKy6m/5h
         ZeqBsctk1x9j4i1JpmM21s+xUHZB4/5jta34vDvz7K/0/6/2rYZTcS0fTd18N8mKTQMM
         WCmuBXHLb6UVQIUIaGIirrm3uMJfB1x4ICX1oUgFvtpquwYg2G5nULka/GEmBV4PdVYZ
         Qr88QTzYftArGCypZ54VOfJZeEQkrr/QVYeJSJovz4SoG9G9GnfGlJe+031b0mzz3WX2
         /a5XpOzJDFmKgcbqIMYU6QLxVLVbxDtThYs1Fajv9e4rJ1ZJNlvexdtWOAh1XeIe/SXF
         dEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755198580; x=1755803380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OEjnFUI1OWJiYFgFirOakE5jC0jpwBgJAeHvFVm1J5w=;
        b=QEdj4q6XSDOdJmk8TsOiwWR2P6T+UVkuoYh5wckfLQN5sHFRz7E+DXYd6Qr39KAC4W
         9cuhzwXGyn9GrS1fFQRJwRxCfNOFeu0uTKw7GxKfeed7qg6RF6ua9WPKM7xDHjWH1BWt
         tDrWmEjcXna0gzF/He2+QbVbqSwahpWg9JM39RKUhZ8Y/1rFzVum/a2TovY/QvhmEyF1
         cW/6d8yNGc8d/QKyAf9xE7Ar+pFn1U7HVrB7qlVyGekkwlbRp6XGMvqjrkOoe5G8uTxs
         xG/wq7GtYUSCggeWAY+o/sXBgOjA849IiR9QjEnSGBzIKA7svbEaqQXAY9K1GbDAWz8+
         4BZw==
X-Forwarded-Encrypted: i=1; AJvYcCXtyLacfnDnMdkKYXj/gLSJ5JMEcMR//d6/vMiG3JHbkoStdQ/NMnF2f4r/kZof7u9ZkkuO9bllVijjuL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCwFu7EC2IHN6yKnbqmdSuk4rgYbIFHOwMbU5m50lIHwdGdPnz
	E+a1p7boAdK57g4wno7xjNNM/EyAa/XOM75N2gn+ZSNlTzAsSbNB6mSW
X-Gm-Gg: ASbGncu1utH2yJL5TZE+Qu3cNm4iBtcI0sdXtwEswNLPCWl4h3vFhwv0BNpQlqTrf03
	a48O+6lDVoQlSwz+Vg9ocO4uhrWTEGDDBaDTHsDavsfEzAYpuF+2c5EOM7Q+ca10IC/iDON7wL7
	MAdz5pdf9xHS4OdvELZ5AAuztLFG1ABlzANskn/IZFhTLnDFaGim4vnwoImLqllYo62eB9ebMQ8
	KNbr/7vT9kMrS5ry94uRKB9/K8SQvyI8qg8M95+7kFgfvA8QjQcYGw0fmu7v4yMpB2Ntm6DG8pA
	EaDjfwjZTEZl4NJ4q8+AJaBAOOf8TEzbV1wFR2u/XHkSiAW7BP/+c999h/0zoSbwytt7H2tn5cN
	VTthkPf/KY0VWcpiAaO4E7g==
X-Google-Smtp-Source: AGHT+IE+0R8hlzof8m9PTZ8eJ4++ekq0pQ9jTHSvihFazWvHoo7zDXSu7TPbpDxldz8fdKJk1QmaKQ==
X-Received: by 2002:a05:6a20:432a:b0:224:c067:66f8 with SMTP id adf61e73a8af0-240bd282706mr6776227637.37.1755198580291;
        Thu, 14 Aug 2025 12:09:40 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bd7887522sm34144602b3a.20.2025.08.14.12.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 12:09:39 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Barrat <fbarrat@linux.ibm.com>,
	Andrew Donnellan <ajd@linux.ibm.com>,
	Yury Norov <yury.norov@gmail.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] powerpc: pci-ioda: Rework pnv_ioda_pick_m64_pe()
Date: Thu, 14 Aug 2025 15:09:34 -0400
Message-ID: <20250814190936.381346-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use cleanup functionality and better bitmap API in the function

v1: https://lore.kernel.org/all/20250720010552.427903-1-yury.norov@gmail.com/
v2: https://lore.kernel.org/all/20250811165130.37552-1-yury.norov@gmail.com/
v3:
 - use bitmap_zalloc in #1 (Andrew);

Yury Norov (NVIDIA) (2):
  powerpc: pci-ioda: use bitmap_alloc() in pnv_ioda_pick_m64_pe()
  powerpc: pci-ioda: Optimize pnv_ioda_pick_m64_pe()

 arch/powerpc/platforms/powernv/pci-ioda.c | 27 +++++++----------------
 1 file changed, 8 insertions(+), 19 deletions(-)

-- 
2.43.0


