Return-Path: <linux-kernel+bounces-892502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EE932C45396
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF7E14E5B77
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06462EBB86;
	Mon, 10 Nov 2025 07:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAvEf1F9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4B223D7C8;
	Mon, 10 Nov 2025 07:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762760123; cv=none; b=c8iut3SrnjZuf+dvuFp6fuAXvHd/VbIY+7pG+k5ELbffI4a96LN4DoQVss32zKi9PB1UglFyT1wtPgmBWeowWwO+cX4Fyq71mgCiKv7m1X9h2c/Jnk4RTKqAojQ+VJ5cXfxLBt+3OUqOx3qa49wN3ay0lGCWTO2kp3EoO+HmDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762760123; c=relaxed/simple;
	bh=NioE0z/TnHHLeHRbGr40HQ1hYEJFopqzR/g2NIkYDvw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aCV9nSmWr4Aqf+WPihv2Hv1DOEtmGbdQfSeyelluyyBM/Dmx+PLe/ejmhuvimEJ8+gYI+V6Iek3rBbWiW8t5B20LmLYMVpbv2KXUqLJwAeputo9DlFdRBUGdUfvXAgVWLYBgfH3ldrjh6JFCBOI7tdSFGPFil0I5KBo1+9hTySs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAvEf1F9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF5DC19422;
	Mon, 10 Nov 2025 07:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762760121;
	bh=NioE0z/TnHHLeHRbGr40HQ1hYEJFopqzR/g2NIkYDvw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=hAvEf1F9glU6ESW3a/tF6Yd9Y7k3raLKGNukaO7J5YGk06h87G/GyX+bl1HScxYJr
	 M7d9PZG4jocPTZkzqx5JWk7l+gv37304W/fPpqjQ98DbXDegLjT9y3MdjZEdaLhBwR
	 VHK3+/S2sjCg9fApVvlNQ3EcsoLt93lKS5LH3ECLD/48iAtH0OaGfi9pBeZoDB8Ycg
	 YDtSsBYiDj/C5l/dEd5KyMg6ztQ0TNQV99moKM2g1NP97xafEvL/U+H7niYrThSbiF
	 wH81hhFLNE1YCAH307X1tg3qJ5sSh8nqzyMxdOeLIIPeZ5JX/r5OWzd4kJH8E2eByF
	 hl3wNEkxg4EgQ==
From: Srinivas Kandagatla <srini@kernel.org>
To: =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Jascha Sundaresan <flizarthanon@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251022230740.200742-1-flizarthanon@gmail.com>
References: <20251022230740.200742-1-flizarthanon@gmail.com>
Subject: Re: [PATCH v2] nvmem: layouts: u-boot-env: add optional "env-size"
 property
Message-Id: <176276011747.17393.17343678369277763827.b4-ty@kernel.org>
Date: Mon, 10 Nov 2025 07:35:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 23 Oct 2025 03:07:41 +0400, Jascha Sundaresan wrote:
> Some devices reserve a larger NVMEM region for the U-Boot environment
> than the actual environment data length used by U-Boot itself. The CRC32
> in the U-Boot header is calculated over the smaller data length, causing
> CRC validation to fail when Linux reads the full partition.
> 
> Allow an optional device tree property "env-size" to specify the
> environment data size to use for CRC computation.
> 
> [...]

Applied, thanks!

[1/1] nvmem: layouts: u-boot-env: add optional "env-size" property
      commit: 06e92afca89075628b12c9b4085b4cc7320081ac

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


