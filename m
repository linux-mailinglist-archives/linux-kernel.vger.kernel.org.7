Return-Path: <linux-kernel+bounces-783658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5250AB33053
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 16:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E542E446CE9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Aug 2025 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362461C4A0A;
	Sun, 24 Aug 2025 14:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Uhpwy7hv"
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3310C3207;
	Sun, 24 Aug 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756044997; cv=none; b=e7NPK/4EROrlb8B9OUc53ilYobKzcwWqC5qItgvyuNxic+Q1H24ArcA5b0bl79g+im0GU0I0IrjENjz3xrPkYjrx/LYIDTKV8zjX6Rtcs7LF5LiEayCJuwcDs10A+l4YFlCFbsnennhvTm5zgwJxGSpATQRaS/jXWXW7FmTSgQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756044997; c=relaxed/simple;
	bh=hDA1+sAAQznZuSvbhAqbA9uok3v3wVBCGUFLA2/9YtI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lTc5tnIlLFnq/rghpz6j2fY3VJNLjuK7S3PzJVzABItGYd5p7/1c0/pE3A9B5HjHrUSsfd5DKYWbAcwKDzmW2X5N6uwYBNCJbuQDBD8hqfq+wWxB7/RkRrrE/n5mG6jE4dkeVl0HJgbrZW75Op+HJ5uDuSxxrpJED+SZNHyhQVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Uhpwy7hv; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5CE754E40C49;
	Sun, 24 Aug 2025 14:16:32 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2D7D3605F1;
	Sun, 24 Aug 2025 14:16:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC2091C22CC97;
	Sun, 24 Aug 2025 16:16:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1756044991; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hDA1+sAAQznZuSvbhAqbA9uok3v3wVBCGUFLA2/9YtI=;
	b=Uhpwy7hv6gf2ew5zGwaCumzcPZ88Y+0YZnvCAQuKOGEnisEZ08ywOK5hfJgGwMtc8TGxt+
	1e9dEMHWC5h4KPjBceRUSuHEOmoQBNCTsLgDlIvuGe1l7fkHZ4ABjfbe+HCfLhOIrLV+ro
	g1dmG07Fe7KAvnpqXUp9cjhYW8Ge1AkZ5FDxeCheO7ZrvMONs2X9faYIjECm80EFWl172B
	BGtvgiyi/XbqCCh5NfX0/xD0P6PIcD7qKEBp/Z1papRcu9vYckbzMnX4QycvHYvuJlC5hi
	bqqVw8x9GtooYqCzWzJZgwawiuwmtZ+4XyG7cR90ZrPhjstT87VEyGptBM8L1w==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,  Rob Herring <robh@kernel.org>,
  Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>,  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  linux-kernel@vger.kernel.org,  devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: interrupt-controller: marvell,cp110-icu:
 Document address-cells
In-Reply-To: <20250823163258.49648-2-krzysztof.kozlowski@linaro.org>
	(Krzysztof Kozlowski's message of "Sat, 23 Aug 2025 18:32:59 +0200")
References: <20250823163258.49648-2-krzysztof.kozlowski@linaro.org>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Sun, 24 Aug 2025 16:14:42 +0200
Message-ID: <87qzx0n6wd.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 23/08/2025 at 18:32:59 +02, Krzysztof Kozlowski <krzysztof.kozlowski@lin=
aro.org> wrote:

> The CP110 ICU children are interrupt controllers and can be referenced
> in interrupt-map properties (e.g. in
> arch/arm64/boot/dts/marvell/armada-cp11x.dtsi), thus the nodes should
> have address-cells property.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

