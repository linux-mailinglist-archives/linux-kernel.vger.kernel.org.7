Return-Path: <linux-kernel+bounces-868202-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F718C04A26
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 09:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6081A6560B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA1329C33D;
	Fri, 24 Oct 2025 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYZY+aXO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E717C21B;
	Fri, 24 Oct 2025 07:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289897; cv=none; b=Rwx9bJS7egsuPN20PwFMcvrxt2Y/VMGSfkazZJms9MiTcYLulGtObYsnun2gdToDN/h19IR7xJPLZFcEB1GPObYvB/tTUF4zuoB/AjyyVlWljts69JA6nKZMsS5H+eDsGQJi6WX9eG6IgLBI5Kd6plkZtsbJ7fx5eQLjDcvBKag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289897; c=relaxed/simple;
	bh=pKuXs8LJPpfcgV1cTk9R33us5rHvZ4OoZySGmnLcnMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKnEkzwJo3+u5dECdZlewYNXam4OrfErUvm7k7phI5jcCA7lXVS9+BSK09w4jUdF7xnY7WwCNgggIjVY1ZBzhuCRv6FgzXnJZSlf2DqJuxVLHoWIpGA3AkKisPJ39l+OB1Utj3VCDwGCk+AvA//6l+MgMNeCDjjCRbGugUpIbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYZY+aXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A6DC4CEF1;
	Fri, 24 Oct 2025 07:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761289897;
	bh=pKuXs8LJPpfcgV1cTk9R33us5rHvZ4OoZySGmnLcnMs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OYZY+aXOXnhuSBEgJI/RE/7O9pjLKir2zs8DCNDWxWRufsBCOigxm20uQ8hZlWgIH
	 LCBiR7x6ZnrE8Edcm8IgZKPGCv1iMaKCD/x2Mmy+iykTxqzTmt0w0p3W6LDa0ch1KX
	 BBhnqoxDXs+yxaaavt6d/SPpiO4VrUTSL5tRQ5blEC705Hz8E1IWzW7geseeY1aN0P
	 leGvU7wjyWrl6lh6+rbqkbq6bUaBKfApGIapNY6xJL1Wkpx3WxR20n2UfdFt5eKJU3
	 a6E6KlqfFp1RTbGhSYkW+53wnTKCauleKrCFR/MS4081Bgi6f+KuYChlkQ+ySxHFcN
	 ODYUxDvP5dG/g==
Date: Fri, 24 Oct 2025 09:11:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Joan-Na-adi <joan.na.devcode@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Joan Na <joan.na@analog.com>
Subject: Re: [PATCH v4 2/2] regulator: max77675: Add MAX77675 regulator driver
Message-ID: <20251024-aquatic-real-butterfly-f5d445@kuoka>
References: <20251021050830.185626-1-joan.na@analog.com>
 <20251021050830.185626-3-joan.na@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251021050830.185626-3-joan.na@analog.com>

On Tue, Oct 21, 2025 at 02:08:30PM +0900, Joan-Na-adi wrote:
 +
> +		config.of_node = of_get_child_by_name(regulators_np, desc->name);
> +		if (!config.of_node) {
> +			dev_warn(maxreg->dev, "No DT node for regulator %s\n", desc->name);
> +			continue;
> +		}
> +
> +		rdev = devm_regulator_register(&client->dev, desc, &config);

You need to respond to the comments, not ignore them. I asked to drop
the reference here.

Best regards,
Krzysztof


