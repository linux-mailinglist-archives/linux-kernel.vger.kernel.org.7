Return-Path: <linux-kernel+bounces-754825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA38B19D3B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 10:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE7A7A2A8D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 08:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F05523A58B;
	Mon,  4 Aug 2025 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="U9BO2+Iu"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B7117D346
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 08:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754294627; cv=none; b=quEkxCkLoCULNpRaQ4oyJ5raTT7CeXmdzQhFudYHTo/ytqG6ynWACrFINLw3FUF0s5QaB8FBTEwR0mJ/RvM9FnSHBJm6KUxSmseLE60uuZFwq8bTonoI2M+Zhiar02EeX8g/eBzJgy3ObHzQGzO03QU0tjNr42CSi0N8gWbJ9Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754294627; c=relaxed/simple;
	bh=CHplDiT3tvrllUrB9kw3QkZLw/AsjeIb82fgo/xPOrY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=c5MY7u/AkKnjgi/L/w6QELRIMcELrh/g4cMox53nBS+HreVDBRYzJWHM4hRlevawY/9CwOhhMwz+yc7McpYN1yIDZKIdf+uqEE5Y3NZwTm1ad7j7sObbcgDK68LF2tKld92W5fJvghNpH5TLNFQC5MA0ztrBshZCxEikpsZ7P+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=U9BO2+Iu; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1754294623; x=1754899423;
	i=markus.stockhausen@gmx.de;
	bh=CHplDiT3tvrllUrB9kw3QkZLw/AsjeIb82fgo/xPOrY=;
	h=X-UI-Sender-Class:From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=U9BO2+Iu5Rg1asVM7e67LNJGt9YgVEaRAsZ1C3+7Fmcr6Tq/mazRZv5yt1qFye8Q
	 Pg6fQa3e5+fwvMDrZ2oYeu2UaO0Wi0VG6Dax0YiBLiQGJh/nQ25mQMNndyaLYXzBC
	 irK4TDLeRT2eKb6QqfMAoCy7rYGZwY2eQOa+ra8DRxuv4wBdRojkKQ16E0a/y9yQ/
	 +Z/WkM+V/jW9uQinHmooYEjD5MKNTSLHNThxaoJyW4Z3ENC/nRx3HWTgWKvscnDbH
	 l0S86ktBL0h/eS2zJyy0Y/2AXT83JEv4gUacKUe2lE9nJeBSPaRDC85E12hIaemud
	 3hJFbgmfjaB0PQciXg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from openwrt ([94.31.70.55]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M42jK-1uiqAY3pQ0-00EBK1; Mon, 04
 Aug 2025 10:03:43 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: markus.stockhausen@gmx.de,
	daniel.lezcano@linaro.org,
	tglx@linutronix.de,
	linux-kernel@vger.kernel.org,
	howels@allthatwemight.be,
	bjorn@mork.no
Subject: [PATCH 0/4] clocksource/drivers/timer-rtl-otto: enhancements
Date: Mon,  4 Aug 2025 04:03:24 -0400
Message-ID: <20250804080328.2609287-1-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2AaOIbSf36dl9rjmG32oOBy25oO6u2d8iDEs4aNl9DnqB4uDvq0
 LyoC7JU4TsgyDpV9lXLKgjFxb8MdxpnRxGWGk4uNgphSD3quRV2ZufshzTYHICbxUe7DA86
 BtSukz+4kRmdfWk5d1uPakr3ftfjostcP2EcpwUNOmLEefKpQ5opR/wZ4lJg8L2Zm6Eaqkh
 nWpRZir9+u57QY6SaPjTA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4UoKpPwsT+o=;mUNcIx12DouzvSDj6y9pBqLqflV
 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
 rhn8BANU1tPBPkk7K8MQh7YcNLrIN7yY=

This series fixes some shortcomings of the Realtek Otto timer driver.
These became evident after switching to longterm kernel 6.12. Devices
were randomly rebooted by the watchdog.




