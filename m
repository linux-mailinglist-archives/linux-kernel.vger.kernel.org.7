Return-Path: <linux-kernel+bounces-814864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2E7B559E7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 01:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FBB57B6753
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 23:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8973D288CA6;
	Fri, 12 Sep 2025 23:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oSfxH+7I"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3D7286413
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757718599; cv=none; b=gHeOkjnFaEpTcYoVc+9N1r+xE74SasVvHVbyU/wbVyBRwJk4GW7PGr4R2NZNE38AcBXpZCeg7ho2cnjqnV+VVobvP6JH4t3v2//aELCnGYOQk2PVoRUiwQKzWrwSgbf/3L8kcfnKSErK8b1YF35MWG6WkozOabx9QIF5xPwi+PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757718599; c=relaxed/simple;
	bh=wk+cDFX3JYEG9AqRvbMYfzyBlK7TsevKhe8uR7IxhbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oPObGMJU4KC6xEz+ueReBcN75NDPDhFv+frE5IS3YZa7nSONXYB5+DSKHGmAwtP8ypQb3w+sGV1MPGtAc15WdxzL2W0YUsMOZnzXkNurOGR26AT0Dq9e9B2s8BryRYv5FYrD4QCP3wgTUO8G2C6aKmViNyESc3FpPpp6yL/j20o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oSfxH+7I; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so2945364a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757718597; x=1758323397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8EcyIGZa+6ToxzyxPuYk0yjX8tMoF6H8xGiBH9NLpZE=;
        b=oSfxH+7IGNGd4n6yensMZUHuSbXJ85ZRxqQ6AIN4hRhTUgIhz3PWx6rIbKq8FlOwB0
         3VWJmMPXWDRI1BumxDz7UkuPKrdNol6M3Psrloco6IzdRdHGtbh6SSD+cRFp9SaK2ejq
         q/Yl9ueMaqDzQbOVM/wBXwa88RixXeI0ZAGJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757718597; x=1758323397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8EcyIGZa+6ToxzyxPuYk0yjX8tMoF6H8xGiBH9NLpZE=;
        b=r2z5Ezg7itN8NwZFBRQrNJtjXwhbBj+AViZLWAqZsPTFUqXFBmAn86TZIeFQqICWAA
         mHI0qfaGMUAHH/QPEtZhqZzy+ntAmAg9fihrMP7q57iudhiCLG5qWttKbOx4FGMbHJu+
         6cXV+bHTsIaTrAil4t98ND/HblH/pYvKGU8i2dTWkWN82UuudGRAVkTM96VMiHS8Bztg
         9A59eNv8Oo+4hVZZE13ADw2naUMCJ+CRCqMMpCJNtjjvQ5uGN/IRn+GdX1kGtdOwxWmH
         cvNTYESootc7uRAVpkQuSzHnnelbTtnUpF2S0csd4DTYX5XGzU8L9GEUIj2ize4iG15G
         hfAg==
X-Forwarded-Encrypted: i=1; AJvYcCXfWmqWaBMl0FK6SDfnuHsc3X8HjEuS2XfDeP/ZrYp0WDmi4Tt7cuvP/3GIIE0wC9e6NE1wUPjqYsFUjRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK4BgHwaeDrS4fnTXm+19xOQg76YC7ZO+SoiCvxYuhnV3aYkOl
	UD3pCaFkqrP5hh/Lnffe9UWM2qvFTQzM34NCbXtqZkjs/FyTeGgganvwdTFdE0N+n5WnTvB5LgL
	VVn0=
X-Gm-Gg: ASbGnctDMo4RW/MeEZgLjrf5MJp2w+yxIA2VMnFO/5YLmsa2DAIyoiTIAWsAFkJPR06
	tDKdIUteVdizMXjXfSJChZ821ELiNnx7WdTeaaEnP/PhqVXk1W6GC/iftcN3Ep9uusl0YVFgqkk
	uwPUvFOj998j3rhRrQJ6Yy69dTp4OqZeHxUw1BP+iQ9E53QTPNkiCMiO9/K4p5fwA9WlHsXbZio
	Ji//1Wv9BbCU6f4AfEU13i8NPVd0FKwpwzdqGYOSdX+s7GF9+oXtejVeEJ2z5Uxfdr0LyI30fgR
	dmDv/qDiamn2Lu5epKWzBWT9WgauQcvizPuhughifPjmaDCNquEu6zwk5qqnTxiU4MfZhwL2xab
	TbbS09zKBslD4K5WXRtMdVwYMJGZEJ1ub+6rV2TUE0gSE3zEPNJ1rwUeSXD8=
X-Google-Smtp-Source: AGHT+IF2cmiYrFQ1xKWdEqefxU7NdVKHQQ304cYE/Le3s9iB7z7uuIXrlH2bNcZ2AM03GLoo+rEoOg==
X-Received: by 2002:a17:90a:fc4d:b0:329:e729:b2a1 with SMTP id 98e67ed59e1d1-32de4fa1c8bmr5042000a91.35.1757718597437;
        Fri, 12 Sep 2025 16:09:57 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:e464:c3f:39d8:1bab])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-32dea223ddasm1310790a91.2.2025.09.12.16.09.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 16:09:56 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: linux-pci@vger.kernel.org,
	David Gow <davidgow@google.com>,
	Rae Moar <rmoar@google.com>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	Sami Tolvanen <samitolvanen@google.com>,
	Richard Weinberger <richard@nod.at>,
	Wei Liu <wei.liu@kernel.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	kunit-dev@googlegroups.com,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	linux-um@lists.infradead.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH 3/4] um: Select PCI_DOMAINS_GENERIC
Date: Fri, 12 Sep 2025 15:59:34 -0700
Message-ID: <20250912230208.967129-4-briannorris@chromium.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
In-Reply-To: <20250912230208.967129-1-briannorris@chromium.org>
References: <20250912230208.967129-1-briannorris@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is useful especially for KUnit tests, where we may want to
dynamically add/remove PCI domains.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 arch/um/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9083bfdb7735..7fccd63c3229 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -38,6 +38,7 @@ config UML
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_SYSCALL_TRACEPOINTS
 	select THREAD_INFO_IN_TASK
+	select PCI_DOMAINS_GENERIC if PCI
 
 config MMU
 	bool
-- 
2.51.0.384.g4c02a37b29-goog


