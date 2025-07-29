Return-Path: <linux-kernel+bounces-749783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F27B152E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 20:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C084218A5D6D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222352512D7;
	Tue, 29 Jul 2025 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ApCMKitD"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E76524A067;
	Tue, 29 Jul 2025 18:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814191; cv=none; b=t/r4O6TYoUJRg2XEmJ2Jib0yY8fTI9U2X297PsVlyvMRjaW4004NegwSB0Y4Qj36c68/sXfIg7N3xdNubdNeLUDH3b8MX8ALTWd6ZqU0XrV2kOHu2JixTMlKq8ocXKQ9xb52ZJo0YrOvWxb6rD0Yjec+q6NXooA7k5inIdV3zWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814191; c=relaxed/simple;
	bh=Tde8ijZup+rXyfRUwOfpNmgw7CUr7ThT4/Th66G11Ww=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=iIjbxb7+vWSxfx6OFVKF4Qj60m9J9QDjbqO/L/bRn6hOUGMUsNbJ5+HvopPR/1Nuylz+XWfYhPuYkJqE3WGHpE5TE67q/T5NVvttoibNBFEqlnyVLh+JTRGHp+WiumnGW5x6MopdYWo/8c9W2oqCyl8aCBDlv6IlwHZoHcOPGKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ApCMKitD; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753814156; x=1754418956; i=markus.elfring@web.de;
	bh=Tde8ijZup+rXyfRUwOfpNmgw7CUr7ThT4/Th66G11Ww=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ApCMKitDn/+kUlFMKoqInJ+T3wHlnB4puqU73gBkdQgfypsSxUOs9pbP104cvcKa
	 7q3osTAr/41Jlcwk7kKeM2S/5G6hzxiPKfX9t7V18r2OLXTKMYnDZoi7/CMoSNhlR
	 CljYC2HEyt+/vVRPN87EKKSRKkyrqi1ano+r9wS5hRO7P9kh7v6TTKDBRpEDi70sl
	 YtknHVWTw9to2jUairChscwcC6pD+JkuH29FfHwbiJqanLn3dUmM2GXKMZXVA1ZWR
	 zsDtQZ9OtdiAwIoB0/LWzG6sswgPYg6IR2ouQtl/8fWdyKOIRWfC3dTztL0CLCn9/
	 lxCYumOlqNLY7GYTiA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.201]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MoeY7-1uIVzW37JR-00hgOA; Tue, 29
 Jul 2025 20:35:55 +0200
Message-ID: <5c0837b5-b3d3-48c2-a028-97cfcd1ec4fe@web.de>
Date: Tue, 29 Jul 2025 20:35:53 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Pan Chuang <panchuang@vivo.com>, Yangtao Li <frank.li@vivo.com>,
 kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <20250729081434.497716-1-panchuang@vivo.com>
Subject: Re: [PATCH v8 0/1] genirq/devres: Add dev_err_probe() in
 devm_request_threaded_irq() and devm_request_any_context_irq()
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250729081434.497716-1-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MFT91td6ZfKVy2MmtjRXlXj6wV7mYmyt6UzZe7n4TEz89/vIoY5
 moPBmh8wZy9jklSBOVSlfC0FwV3y3MdWyU2AQAsUbX2uSqHhLNWy7ItB7YUDWQMFaSmCojY
 m3RWZxU+uMY1EGCgXCYiOijTeGq1CJx2YRdZOmFRPKBbcj4vlugtM5pvKaruz1QTSNKL811
 Nts9bt35dFjspgLIYfv0g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9iktlITj2B8=;W/VULgq03cw4rCis+OfwYeMaayW
 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

=E2=80=A6
> This patch implements a standardized error reporting approach[1]:
=E2=80=A6

Would it become helpful to move any information from the cover letter
to the (single) patch?
How do you think about to avoid the presentation of duplicate data?

Regards,
Markus

