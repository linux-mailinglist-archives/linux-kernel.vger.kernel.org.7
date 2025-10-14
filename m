Return-Path: <linux-kernel+bounces-852252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B67BD88E0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:49:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3911423F99
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCB82ECD3F;
	Tue, 14 Oct 2025 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jWcRx9c/"
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDEA2EB5A1
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760435152; cv=none; b=LQkEFdEv94XIC785/xcxWH8H4ym2zFEXzPjMtH640OA1Wy+834MJLMMEH3CzCANscu1SDrdw/Jv4BMlWbuiMnDSaabtZUCRHErYKX6iHWK+IZu4B22T2SMzUixPgWBC0fvNRNzMvj15NSqHvuS+blnmlizuhCgowKQHZ4FQkOLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760435152; c=relaxed/simple;
	bh=D4al88LL8q+XHjrCSJII1dctsBxIMEvTBINPRZs5xRI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sZvI8PGwINDc63WjSCx5NDl1JjILu7AJcREUXlamsLaUi+kC6z6pP201ghKC1sqD9LSjOrFCgwCGMrtqbjyg9sv22ZhaU01wGG2QlvLwoKSBEGS/Rjxa6QEDrZqkmos4qVANzNjxq/3YxT4rIobCiuzTh0SSe//YyY4A0bQC/j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jWcRx9c/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id CDBD5C09F80;
	Tue, 14 Oct 2025 09:45:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A570F606EC;
	Tue, 14 Oct 2025 09:45:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0CCA7102F228B;
	Tue, 14 Oct 2025 11:45:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1760435146; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pS7S3KjjjVMBjFt3EILRfWOqjVjZmOnxzSm17MhSyeA=;
	b=jWcRx9c/oN7rXNJkrTS3XvTf3Yj7U2V6UQucGtHJWdNsTKRX0GujBStzYYNWHLLgkPLBml
	DpWDxhT2pQvP+xFAeGKA8AEk5nCOzZvfmDpQfM7A5YWcNlt3x5Uc3zwWMYXRnlZzH2YK8T
	0o62way7LOZThsMmD0pImhigEEsU9YQPHTJrSqIVZ8LcjbpFQnphIrVXZhziOPnJU/spfg
	t12gFk4qj49MP4fZBjgrfiobz2I1Aas/FNllUoMGPzGeEVFT+lKep+2ktWPnuYvWY6I3io
	86UEB0vJLmmvUiaERj+HJ8gQF3Z0aObmxF4cTP2RiKOaIIorO1zCL4yTf/HeVg==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: "Rob Herring (Arm)" <robh@kernel.org>, Wim Van Sebroeck
 <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Andrew
 Lunn <andrew@lunn.ch>
Cc: linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: Convert marvell,orion-wdt to DT
 schema
In-Reply-To: <20251013213146.695195-1-robh@kernel.org>
References: <20251013213146.695195-1-robh@kernel.org>
Date: Tue, 14 Oct 2025 11:45:39 +0200
Message-ID: <87o6q9g6kc.fsf@BLaptop.bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Rob,

Thank you for your work. I have one question:

> +  reg:
> +    minItems: 2

Should we also include this constraint here?

    maxItems: 3

This would further restrict the binding.

Gregory

> +    items:
> +      - description: Timer control register address.
> +      - description: RSTOUT enable register address.
> +      - description: Shared mask/unmask RSTOUT register address.
> +

[...]

> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - marvell,armada-375-wdt
> +              - marvell,armada-380-wdt
> +    then:
> +      properties:
> +        reg:
> +          minItems: 3
> +    else:
> +      properties:
> +        reg:
> +          maxItems: 2
> +

--=20
Gr=C3=A9gory CLEMENT, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

