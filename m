Return-Path: <linux-kernel+bounces-884983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30042C31A73
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 15:57:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 94E464EFD54
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 14:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECCD32E75C;
	Tue,  4 Nov 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dRjlkx0y"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF975325702
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268081; cv=none; b=G7MFqy/FUYIRK5WZyezWNoPKBUWh33cC63Gl2pyXaRNEC4/TiM+k+B/jC1Ie6kQphsHkBb1uAe1OW17iXo3nwMUgXHfY4iIhG63hE0qpa9qDZNWwzQeBFKozycALkTfOQurGtYjnW2yRDqGx7CXoPvApNsNAHWov1obB9eCn7lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268081; c=relaxed/simple;
	bh=tMM0FrpzOwdKfNoqgk0wHyasTgBqPHWdw6Pw56pYrVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CDUB80dcR0sS4t1wbMC3abrZBYYBrajBoD+TkXIgYdq1VSarX1xR62DCGlhxWNC60N/Y4qixUc1xx5J1ujzclSI7bWaR/QOGl2Nb/asAQjKtxRyxeBeFcCUtPR5Qnd7wU2SMiKKpaXpBXceB23IqplxqcHBCCFZIscnKHN+CXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dRjlkx0y; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6408f9cb1dcso5571780a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:54:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762268078; x=1762872878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jOvGyS+AFA2b2XdOCri8ZZ+CLzTz/OL3oewIg+xXlA0=;
        b=dRjlkx0yU6pzOoC519joE9J+h+xZoJkVobX0AtrbtvaTaNnl+MSYiQ16nbbNnF7mTn
         Jvw8kuxXZt9yaoToRv2LciPhe6unBbfMvRZuDHQBgSQiQ3OnxnWJKMwv1B/tBl8WoU3L
         pCev17Ix05M53H3KeR7NzMn257XymA4wB/XtE6srRUL5+UJDlWueNVjhOF6EcNcKey/G
         AVN/uztT0ywaJ0Aw5+KOR8hWLNA5EehQi6JmszyfMCVqAXhQpxOPFsLBOcc9SmKnj+jx
         3kkBMuldzz6IWkih+TB8Z3lSHnMEt4J13iTIyT3B1mhSHTLvtrDzTZrHsgTD2+fEnosH
         cYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762268078; x=1762872878;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jOvGyS+AFA2b2XdOCri8ZZ+CLzTz/OL3oewIg+xXlA0=;
        b=jOZ6W8LRaSgAvYDXwRiRlThlq0JrjZ4xFCLkFPoxg2hB549AfFJY5ca2fZbo/4If6q
         PUAiDOJY8wNy05m8IKM35vTmpNdbpGo7YuJlOCEESxOOqlYi8Xbr3/JNrV9N0gFthBGa
         bTfZDLRuEjEWYvcurjbS9dC0HQ5DuGfEt8zo6n0f/dM1cBoqpEGmWlFgDMBGontG+5z7
         jeduMVFE4xhBznUgEtjgfdDXHUh9HjtDPGcaGR4BplxBMbJXuTWtgScajNDFX3428uoA
         Bzkd5upWEq2ToffysweLJiJxuOCaRwV6oiS8FY4xh+r3PgdJmYxkREdTn22aknr3t34E
         8jqg==
X-Forwarded-Encrypted: i=1; AJvYcCXpmbvB9gVvIaCyOq7BQ2Nk3K7wH5QSOcY0apa64wSMxS4DQhggOnYxmBlseIZzmguPBJn9FnI/+dRr/vE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw42pdtHVaYD/ikdYxLAs0sWZibhYMNHTP755IThwBPGCaoinp9
	nPB8k+Su8WW6aqzJaECZkL/GWxB0MUhoukZ1I4u0Ss/A5c3X9udwHaEu
X-Gm-Gg: ASbGnctjWbqzs3wIF6eMitRSSXj3ztrkFETG+GAhEFTB6W1tWx1sHziWZym4k/8EQzZ
	c1L/oWdBkYKJIm/vDXlgHOeHFdle6wL7x8bMLMq3nZNRZ/8smkRzOG/d6euH2juKzmG3e90g581
	sazlu/dNL01/0q+pXPGhpNS5+PeNeYcvgPsZsLJylTbXb31ybMSH5BpumIZ3deALNf56K2MAdyp
	qzusBFq9hGLTudkAfnpRNJPT2QSTeZIL5uL4Jm0Y0kAskuJey4NzE/keuKTEwkgE7waaIrbl8k/
	EcD/HRU5XC/bIcLFa91j42cCj0Uk3wFb5wv6XslGx4whFMf+95O2BGOY9cn8zeQBfcFqTHcEtmN
	oCyVM1q7abJurDl6xftlSjPBzES7VHMcZCxGPCdriZMDb25kkoH1EUvEuqzxZm549R4MYJNL1bk
	qV
X-Google-Smtp-Source: AGHT+IHwgA9FO5GGp+/OCTCuFBuQnKQEnDtnj8IkU1asVMEJd7eMujGCpXNexpCTZo8mqU/8fJq3lw==
X-Received: by 2002:a05:6402:42c9:b0:640:da69:334c with SMTP id 4fb4d7f45d1cf-640da693f92mr4046621a12.35.1762268077784;
        Tue, 04 Nov 2025 06:54:37 -0800 (PST)
Received: from NB-6746.. ([188.243.183.84])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a70b50sm2235016a12.25.2025.11.04.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:54:37 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: ilpo.jarvinen@linux.intel.com,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 0/2] serial: 8250_dw: Fix runtime PM and use _DEFINE_DEV_PM_OPS
Date: Tue,  4 Nov 2025 17:54:24 +0300
Message-ID: <20251104145433.2316165-1-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear maintainers and reviewers,

This patch series enhances runtime power management error handling
in the 8250_dw driver and updates the PM ops initialization to
modern kernel standards.

The first patch adds proper error checking for clock enable operations
in runtime_resume, ensuring that failures are properly propagated
rather than silently ignored.

The second patch reorganizes the runtime PM initialization sequence
to simplify error handling and prevent potential suspend during
device probe.

Thank you for your consideration.

--
Best regards,
Artem Shimko

---

ChangeLog:
v1: https://lore.kernel.org/all/20251030174142.2039122-1-a.shimko.dev@gmail.com/T/#u
v2:
  * Split combined changes into separate logical commits
  * Added detailed commit messages explaining the changes

Artem Shimko (2):
  serial: 8250_dw: handle clock enable errors in runtime_resume
  serial: 8250_dw: fix runtime PM initialization sequence

 drivers/tty/serial/8250/8250_dw.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

-- 
2.43.0


