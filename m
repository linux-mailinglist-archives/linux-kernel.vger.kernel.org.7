Return-Path: <linux-kernel+bounces-788737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E15B38971
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 20:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313DC1B24841
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD2A2D9797;
	Wed, 27 Aug 2025 18:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="am6v6yvO"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940502D94A7
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756318978; cv=none; b=CiiUNDKOL+r+U7CY3cp+GUvLrgWIkSyAl1DXXN57fiNkUcaqdZvknZusZzzTTq3E0FX/vBgHb8xJLSknJj1+1cp4IGME3j4AOBMXtM14fIyUBvas2ufHhgppI2uru4fr9P2Mr1H4S349mHy59a/AYmkQctosFzFadYPqqBxXnto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756318978; c=relaxed/simple;
	bh=C6mLbA17DVXgOmUVD/fXVnmhI4fIImOkB4OrKziGHDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oASD8u2HmMXWAdqZv/9Un9GyG75NxTQws4DMDKRerGK0wchOmQr8OCDEXV6VoW2HV4mGoDtwjEoNxttxmyh0kLtQMNRLXGfHgAJkbw8eHAPFXJxcCnwVMlP7eLZzwcywBf1huaLs4E2kZmsMkfY6m+N9MN71yNOewih5pZbogCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=am6v6yvO; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1756318969; x=1756923769;
	i=markus.stockhausen@gmx.de;
	bh=C6mLbA17DVXgOmUVD/fXVnmhI4fIImOkB4OrKziGHDQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=am6v6yvOZRO6ixk1SqeEpeXGGgLKNOVwsbu/VKqmS/zr19ZMrkhgqpWHUAvYgBhQ
	 Yhui0ZrwznItk6P+W9s3RWi9EuY3+vn08/e9OapTalakuG2pCEenGSjS5+aG1Q5as
	 i35Afmbhc6/Q3kq+V9jdJQ9KK5w5+qt4aFCC9EZwovzTJPr8/J51y7pM4kRJzpTjE
	 MTa29KNYH3FyH5cw0uUIZ18ovwvAWJC9mJBnTsLBSTUA2mUG0p0y9R8EUQmnj6e3n
	 2KAatbiu9RG2tD5eEsJsSYT3uJDA2T6+FBEWqIQpKvaIbNED2ZAvyCXz70IdXXJVX
	 2FyHsbvTmyv6lTY6Iw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from colnote55 ([94.31.70.55]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1v6wEo0Jvj-00U38A; Wed, 27
 Aug 2025 20:22:49 +0200
From: <markus.stockhausen@gmx.de>
To: <daniel.lezcano@linaro.org>,
	<tglx@linutronix.de>
Cc: <linux-kernel@vger.kernel.org>,
	<howels@allthatwemight.be>,
	<bjorn@mork.no>
Subject: Re: [PATCH 0/4] clocksource/drivers/timer-rtl-otto: enhancements
Date: Wed, 27 Aug 2025 20:22:48 +0200
Message-ID: <08da01dc177f$981a0600$c84e1200$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AdwXf5CGPb8kP55HQBaDzU67JtyQCw==
X-Provags-ID: V03:K1:qNh2ERebCdQMdQ6cEpMd1/JQtFrf2vLVzUWpg+lh16LnwnUqehU
 oLk4JqMlM1cvqCQo7i9JvI1VTP9/YgVKP1Bbf5DEWkbFFiH9QZ1oluKakZbUXcqXfBWOwxG
 KkQT7MG+Ynl7ZW6MJpEOoDBza9+/yJCTu8sQPyKig0dyn8AbRFY+9vEAVrz7DAVxYOhyFkp
 SMvLX1zz7xwD4xYxiAF5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C6G1ndaoBDY=;BcEbMDZcRf83WyKYyiPOrKaVw3i
 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
 NWr1yys=

> Von: Markus Stockhausen <markus.stockhausen@gmx.de>=20
> Gesendet: Montag, 4. August 2025 10:03
> Betreff: [PATCH 0/4] clocksource/drivers/timer-rtl-otto: enhancements
>=20
> This series fixes some shortcomings of the Realtek Otto timer driver.
> These became evident after switching to longterm kernel 6.12. Devices
> were randomly rebooted by the watchdog.

Hi,

gentle ping on this series.

Thanks in advance.

Markus



