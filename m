Return-Path: <linux-kernel+bounces-811046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97797B5235B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 23:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824893A8FD5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 21:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C7730F535;
	Wed, 10 Sep 2025 21:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="rDUhNNFO"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FAD30C63B
	for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757538914; cv=none; b=jaRCvDpFpyfg1LcR7sR+4JirynGTIlJ8O+n8dgyESgqoB4+hSlAZ9OG+oo8ezbeqKwtnVY2hAVgEjYzMTJPdEKvkLcT1rWrSixmYwAAgObU69F2mIC1iQzr5rByoJnKERcnAJ3k2eI8Tq9d+kwXnHJ+vLpeoSHgZHueVzMu2Kew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757538914; c=relaxed/simple;
	bh=iRljE4JeXe9dGlfnRlVUBW69X07lM9PEeaB4EHvMWtA=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=oGFEAiYeoXOS88w+xgAuvfBf/8frfbMgtt5UGOmVM4b+wykU3F4pYMUT5B1J0I91xdOyIviR/FPo4BoeuP/IsDG+nXOWy/aLFIiKVVW29aOthn4eGIzj+Y3Ir046XG82l5UIDhiUqyqWF2G7QcUj+8QIv1aPhVKzEWJBnxqcPq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=rDUhNNFO; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1757538905; x=1758143705;
	i=markus.stockhausen@gmx.de;
	bh=iRljE4JeXe9dGlfnRlVUBW69X07lM9PEeaB4EHvMWtA=;
	h=X-UI-Sender-Class:From:To:References:In-Reply-To:Subject:Date:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rDUhNNFORaNuesaFT7G1OhqyBWoSjbznfrVpH/9SOwGpckwpLuSfrlaFjseahifx
	 QaHOUk7EsCi2GryLr4W19NxM4TE48bNixQ0rJ+fv4D17j5rKjXamOxWDZloaUrH7j
	 rv8nUBhjti3GoGwuGpxrvpam4LgFe2By7gFR93Vy7icmRe3Z99WRsgQNuI+Kvgr5y
	 1vsJ4pKCZGYdxRaju0/4EFsUPltlO0fB7BeQCl1NByBdW7XOfwNC+us/6S/KpxobO
	 zjamLIZGzxvCN2QHKNB6p3QgtYmn13tQX55opSF7hrzXzy7n0ZUj1GaKZCpwHzlk2
	 A5hpZMAzNXuz+13wig==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from colnote55 ([94.31.70.55]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mv31W-1u5Rzl0f4a-0118FG; Wed, 10
 Sep 2025 23:15:05 +0200
From: <markus.stockhausen@gmx.de>
To: "'Daniel Lezcano'" <daniel.lezcano@linaro.org>,
	<tglx@linutronix.de>,
	<linux-kernel@vger.kernel.org>,
	<howels@allthatwemight.be>,
	<bjorn@mork.no>
References: <20250804080328.2609287-1-markus.stockhausen@gmx.de> <cf020451-115a-471a-bba0-4152015e7173@linaro.org>
In-Reply-To: <cf020451-115a-471a-bba0-4152015e7173@linaro.org>
Subject: AW: [PATCH 0/4] clocksource/drivers/timer-rtl-otto: enhancements
Date: Wed, 10 Sep 2025 23:15:04 +0200
Message-ID: <094b01dc2297$fa9977c0$efcc6740$@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: de
Thread-Index: AQHp8yyrgZ2WnUFiBUflLXXXxyaZiwJBMnb4tF8/0cA=
X-Provags-ID: V03:K1:NjveILSO7nRheauQopRRUoJ5NoR9Hg82V3lOFtAvX/lZuNtamdW
 k2IG2qomEpiE0mUjQwKuf/BZPybx010U4sJmRePYFNu/Zwpws0MV2Xx7fLM3HeulOJ9Mi4v
 60YQL88y+3NuS/VuJU9DrUCvuuYUeqWldL6ducaX1XJtv8mlEVwIx2LYbfzn3g6mCP+RrWD
 abrYZA8HHmuEHIQryQspg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aQ/VFK1ezfM=;dvRb6jzT8klsXvmfIKC73jOIU2s
 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
 ql2zUbEn68SSRP4G2GNy16xxE=

> Von: Daniel Lezcano <daniel.lezcano@linaro.org>=20
> Gesendet: Mittwoch, 10. September 2025 22:54
>=20
> > This series fixes some shortcomings of the Realtek Otto timer driver.
> > These became evident after switching to longterm kernel 6.12. Devices
> > were randomly rebooted by the watchdog.
>
> Applied, thanks

Thanks a lot.




