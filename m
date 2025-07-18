Return-Path: <linux-kernel+bounces-736510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B06B09DDB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 10:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 570967BE12F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 08:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EA1224891;
	Fri, 18 Jul 2025 08:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="zUn3DGRL"
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E1B20B7F4
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.238.236.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752827176; cv=none; b=fxowp2EOI/QM/EdZgtMpDMNEfZacMnMVDpfaYVnA8c2GMerpG7oNQB3QkdlBuNEBF4WHlxLVZL7tfqS1XI1eBj47XIpPMoZbswesWm2+77Z07SdoQcSXnyu921VSi74hypIIlKuacgCCoUJDKW7B7KGr9oM3k8b8MLFpKChjz5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752827176; c=relaxed/simple;
	bh=C+k8XDqV1NFilwD/fFmfClM2h5itOLPf8n+geMf0sMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PH6JQln8nv0hkBK5XD1CG+CqH2ci6ZRIf5cXbOxsrM0j8dK0AWqkk8PII7hK5+B8AxeYljrLTRRMFm5dF1tJ6pFFqLffDB3SS4zLHviZzehwQFa/VNcX6omgNf0k2qd2b/aJZW7zZBZ+ZKY4CPPd0E2eZRulfNMqZxpSygYt+Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info; spf=pass smtp.mailfrom=kemnade.info; dkim=pass (2048-bit key) header.d=kemnade.info header.i=@kemnade.info header.b=zUn3DGRL; arc=none smtp.client-ip=178.238.236.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kemnade.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kemnade.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=kemnade.info; s=20220719; h=References:In-Reply-To:Cc:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=isKHZnlk51GPsLmLgEvCCDlYZVrxDlDNVIsM5Dc1NOc=; b=zUn3DGRLNQWsAnNn7gC7zncCGg
	vDt8ltuqqr4WHq+ur3zpUd6d1Y08QNDWZfjEtRdbRPiuOyqd5Jl717Lx1BbXx3MLAXeeJNs7M2Tbc
	1C7RaLVWBWOzRnaPuB+IIc+fr5T29mTbvicCczzWuW2Pe+tmVV2tWqenlbK3Z85QSXE5bXsIAroXS
	ap4EVuN3KWaabMHT3OK5fCuJRY9P8YgQ70ttXE/p8jwFYe1s96Jz078SrhQAv1dt03Nm0D8ee9lpE
	mCFzRY0cebe2bvVz/6Ka+P2KKmE1x+kv9cV5ZgfCsMyEFcO2xyULybe2xMs4a2L+j8k8HhetvzhIB
	Ybk1TdnQ==;
Date: Fri, 18 Jul 2025 10:11:47 +0200
From: Andreas Kemnade <andreas@kemnade.info>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman
 <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, Tony Lindgren
 <tony@atomide.com>, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpio: Convert ti,twl4030-gpio to DT schema
Message-ID: <20250718101147.4906bd60@akair>
In-Reply-To: <20250714202829.3011298-1-robh@kernel.org>
References: <20250714202829.3011298-1-robh@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Am Mon, 14 Jul 2025 15:28:28 -0500
schrieb "Rob Herring (Arm)" <robh@kernel.org>:

> Convert the TI TWL4030 PMIC GPIO binding to DT schema format. The number
> of #interrupt-cells was wrong compared to what is in use. Correct it to
> be 1.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

Thanks for taking care of it. Now it is in, but anyway:

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>

