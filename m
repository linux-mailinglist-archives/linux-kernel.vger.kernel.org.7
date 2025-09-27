Return-Path: <linux-kernel+bounces-834999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE25BA6005
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 15:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C349E4C24EC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682A82E0B74;
	Sat, 27 Sep 2025 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="oH+Ba3zt"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5BE22083
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981462; cv=none; b=qpBORED2EgS7qDJOhayH3Ra7TU8WDnEp76Uykp3lGVicdHAvSxQOjrmwXdU4FvHo09y2qLZ8/F1O1a76Zad0sSoj/1f2rOdo14fs5FH7H1bdTUWiHbf9fGWchE/zERJkYxU/OlsUPDAIscFaSFEznE4wSGf3l0jVYGN20JCz/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981462; c=relaxed/simple;
	bh=odZJScnngEm+S3AtxQrvpSQkKV7osaJFzsa1SO+IUKA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GsFtMF1OzvZDLXr52u4B0ushf0PG4vtpmlVJK68UUdWntjlY7RGIWHKbxf6tyPXuK3e1cM03vTH4FfY6HBIyVBLQVbId3iSJeE0nszjkn6faQyv95S5fkAK05Ke2qWzVak+I1E/8X1yAvqxIwSdLScut0c59aU2yUcADmB7u4UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=oH+Ba3zt; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758981457; x=1759586257; i=markus.elfring@web.de;
	bh=odZJScnngEm+S3AtxQrvpSQkKV7osaJFzsa1SO+IUKA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=oH+Ba3zt0+dGiYrIR2WM0YBhFoc70T1i3hRznjrp8QyqGPS4QLddjKiUNnjoItGl
	 yNYrypUNBoa/6l9Yy9deXPIxq+iRrmQjr1Flbc5348AQaK5dHQLvsN3V3qWrzPiLk
	 ZH3j6IO7JKbIIW3bmoBFRBoyfL/IstSemIWsYU5NsjAey0vn/RNf6DDi3bOmH4hir
	 0n2oxG6poLIs0HIRS07/+0FFYm6+uqTYpv7SY/kBiJ3r7cr6zud912+CBYyR4Fytz
	 KDVrGM2k6Ibnr2ZIlXMjBZY3StnS/2UiUEV6Ak85H0EikrI02kgMk9LNR4uVYioc9
	 Sf+zZiTlbI8QmyCjvg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.221]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M5QqN-1v17qu2Caj-00FIhH; Sat, 27
 Sep 2025 15:57:37 +0200
Message-ID: <1bc9a4b3-7a8d-4bcf-9481-36fdc76e066c@web.de>
Date: Sat, 27 Sep 2025 15:57:36 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Janne Grunau <j@jannau.net>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, Lee Jones <lee@kernel.org>,
 Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>
References: <20250925-macsmc-mutex_init-v1-1-416e9e644735@jannau.net>
Subject: Re: [PATCH] mfd: macsmc: Initialize mutex
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250925-macsmc-mutex_init-v1-1-416e9e644735@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:NP8BtfQimdEvXv9Rq7e//xfDrOyxRsxFbOjcZln17pFcUU25ON4
 01QEjVcgNfaTJiqNG74TimTsw2+MZj+3bWvyq1HELeHmdcSOrRGA/RNyiqjhuFFg2nwuvwB
 pg6rNtB+MYSqxA3JHX80TfCeicnMrDFyuFYwbcb4ELV1SPOaihhAPBNPS879GjrHhYYT4Ai
 t22PzWDqTBLP7Il49U0bA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:syKLplIkyV8=;m9npGcuZVIwJ/6WdKlV27+G+lGw
 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
 S

> Struct apple_smc's mutex was not initialized before use. Surprisingly
> this only resulted in occasional NULL pointer dereferences in
> apple_smc_read() calls from the probe() functions of sub devices.

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.17-rc7#n94

Regards,
Markus

