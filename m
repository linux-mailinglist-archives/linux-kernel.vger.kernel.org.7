Return-Path: <linux-kernel+bounces-783690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21849B33149
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 17:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FD37440F86
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 15:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E452D6E67;
	Sun, 24 Aug 2025 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="xGvqGf7R"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D52D1E5B72
	for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 15:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756050679; cv=none; b=SJFUMCgHq1ZKTQT0/GaZUejI7Ud6WyfnGR72NFfuz+WHYvZwnT+ArIVmsfsHPKNixhxPl+TGRwVE5ACaaVyC5VC1cy8qeQH8MU++SzBMC7I5iLN0gtczoc6g/c2lJjBJVm3zzWhydRrvvqq8W3gf8njEmtf/YkJUyLxGjIr988k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756050679; c=relaxed/simple;
	bh=N8TnPVsESid2cQ1hhF98BtD+FAEy1qWNfNCLT8zQ3XY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CMoc/r07+NM9S7+09r77DHBYjlvc/Zjj1X2Vkq5SciF8vr5SS/UqqO46/oKxqutGa098QiYmGPo2a0VcpzbqQ5HASZmuoHwYkSKgiZiQQ46S62+eTnmePsjbTmc6v3QVI42saPKyZ0+LWcfSBwSYYoDOL2z/vuQGLpWuC0/LTSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=xGvqGf7R; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 29DECC653ED;
	Sun, 24 Aug 2025 15:51:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 092EE605F1;
	Sun, 24 Aug 2025 15:51:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6C5A1C228A5B;
	Sun, 24 Aug 2025 17:50:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756050674; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=N8TnPVsESid2cQ1hhF98BtD+FAEy1qWNfNCLT8zQ3XY=;
	b=xGvqGf7RUIbvnFHVKYwyDxsvhN4cpVYRJdpCk068CKtchXKw29FhSGK9ubTRudt41vNmuo
	RNeqCEwo6Jea8JbdC+CeptKrmAXbyr9tvmM4GyzAY2iLXG9t3+G5A0toPdWcRJdybjl+AJ
	FcrFjY8NolfvDVaZW2qZOwNB4fnoBdBeRwXgcKPpk3+uaS19knB1dWK8KwEI0BdAnWzkrf
	bLnlmOgQNbw704qsR9jlBfh9ytUyKUhm/fM8IQRRmSOBVO2XGQoXwpJ+Mi9VlCsGhczfTs
	HqMke15N7FYJXtvy9Ythj9ewNzLHeby+Pw2HK+7znGITVrZAAtgrKhQT3tSxlQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Cc: Mark Brown <broonie@kernel.org>,  Richard Weinberger <richard@nod.at>,
  Vignesh Raghavendra <vigneshr@ti.com>,  Lorenzo Bianconi
 <lorenzo@kernel.org>,  Ray Liu <ray.liu@airoha.com>,  Tudor Ambarus
 <tudor.ambarus@linaro.org>,  Martin Kurbanov
 <mmkurbanov@salutedevices.com>,  Takahiro Kuwano
 <Takahiro.Kuwano@infineon.com>,  Cheng Ming Lin
 <chengminglin@mxic.com.tw>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-spi@vger.kernel.org
Subject: Re: [PATCH RESEND v2 4/4] spi: spi-airoha-snfi: return an error for
 continuous mode dirmap creation cases
In-Reply-To: <e8f77b06-b47c-456e-8671-ac8ae573af64@iopsys.eu> (Mikhail
	Kshevetskiy's message of "Thu, 14 Aug 2025 18:33:25 +0300")
References: <20250814065423.3980305-1-mikhail.kshevetskiy@iopsys.eu>
	<20250814065423.3980305-5-mikhail.kshevetskiy@iopsys.eu>
	<78542bbe-1def-4aca-8424-cc26542d9762@sirena.org.uk>
	<e8f77b06-b47c-456e-8671-ac8ae573af64@iopsys.eu>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Sun, 24 Aug 2025 17:50:56 +0200
Message-ID: <87o6s4k9b3.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 14/08/2025 at 18:33:25 +03, Mikhail Kshevetskiy <mikhail.kshevetskiy@iop=
sys.eu> wrote:

> On 14.08.2025 18:29, Mark Brown wrote:
>> On Thu, Aug 14, 2025 at 09:54:23AM +0300, Mikhail Kshevetskiy wrote:
>>> This driver can accelerate single page operations only, thus
>>> continuous reading mode should not be used.
>>>
>>> Continuous reading will use sizes up to the size of one erase block.
>>> This size is much larger than the size of single flash page. Use this
>>> difference to identify continuous reading and return an error.
>> This seems like it just applies anyway regardless of the rest of the
>> series?
>
> Could you provide a link? I do not see this in upstream linux repo.

No link, Mark can apply this without the rest of the series it seems. If
that's the case, it's best to send two series because these patches
apply to different trees.

Thanks,
Miqu=C3=A8l

