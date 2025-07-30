Return-Path: <linux-kernel+bounces-750248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFA4B15910
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 08:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989FA544CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 06:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB58D1F78E6;
	Wed, 30 Jul 2025 06:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="PzHzzkiy"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791C58F66;
	Wed, 30 Jul 2025 06:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753857938; cv=none; b=M3zuz402JwZ7MK001YM+CFjIDw6EWAHVsxJf8Zi2DdrJyCrbY35Az348jegB+A+j88eJy7Xzg2ZRBmA1zgL+6I83wDcypIzU6LznauXo//37qfcwAbbtHwAGTUsmmWmu+IDXETBp69veM5B/2d+yhESYxiWisCdo19XEShqo0Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753857938; c=relaxed/simple;
	bh=HCyzQ8a3VN4v6kdVioWqrCWuReY43dsMay3j9Tuyy1E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=McVLTOCbETqt4s2Lc66J5gX5mjlgSeeOEh34FklYpQYiJLPsA4PMDzR/qnGc1yjEjGFSzH7c+24uVBhMf9zWJhfRrST1rWPxhgUMQ6/1BkOPJ3z10J2PaYEMXs7wE/bYEiIQSmyDNFUM4RdDmjCAFeF3yIkRi0bIchi1w1iXTp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=PzHzzkiy; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753857931; x=1754462731; i=markus.elfring@web.de;
	bh=HCyzQ8a3VN4v6kdVioWqrCWuReY43dsMay3j9Tuyy1E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:Cc:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PzHzzkiyxAqdYNkbRAPdCnNVGR92JGhw7Qu+5RvmBEgBmyGNSm0BXweC+FYNePSP
	 08o2AFmuM6b+GBnYwlnLtDW4ekrAJNw9QDMj+ahfwYhNXioLI+hHDMe9iE7TncvM0
	 wQ2KA4R4NAsWT6yHussTucgfLti4Ap4LAoeny3/EzMo+ljRX+FSjJfx29e5WM7O40
	 aJvFnqmdrhGUuIPYwh6ZbfSdteNMJqRitPcH+pU6gw/Srgrq9Fv4t9x5Noh76adHf
	 jQKvrVvyFSngKxBeMZAhgaFLhwXJuYc0/lJap3F2pGS4KnjetMjACld+XsUXuMnfq
	 GcLkEQjAdJmc1YzSHg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.238]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N79N8-1ubNKA3aIe-00yZ6e; Wed, 30
 Jul 2025 08:45:30 +0200
Message-ID: <f0c7dbf1-b3a7-477a-acfd-2ae90340d4b3@web.de>
Date: Wed, 30 Jul 2025 08:45:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/1] genirq/devres: Add dev_err_probe() in
 devm_request_threaded_irq() and devm_request_any_context_irq()
To: Pan Chuang <panchuang@vivo.com>, Yangtao Li <frank.li@vivo.com>,
 kernel-janitors@vger.kernel.org
References: <20250730062554.269151-1-panchuang@vivo.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 Angelo Gioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
In-Reply-To: <20250730062554.269151-1-panchuang@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KwE4PqM8+qSAD4Xbs9YE4MVl8vGmJyfYOiE0Wa991yGt7sgglUE
 NsCBejuFJeafXGhJb04S45pBkT3cQwzQ8zXXoYefRJZe6/yXvflIHwPXKPxRKA0hcQj0yi0
 5QBdcK44slmd4SBjsymtFra1RENtl+3MHHS1dDH+qsUWjYXzzZ3F99GOeyC+x4zNfycDDtN
 F0p1h+SmzFpLDaBYfBdqQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:UHx2beVbgaI=;zJWqsdBTESjpsMLAdIVamKU76I5
 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

=E2=80=A6
> This patch implements a standardized error reporting approach[1]:
=E2=80=A6

Do you imagine that another patch series would become helpful
for the presented software transformation approach?

Regards,
Markus

