Return-Path: <linux-kernel+bounces-761995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72079B200E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 09:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BDC8189095E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 07:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26AB2DC327;
	Mon, 11 Aug 2025 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="jx5d7NOZ"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8665A2DAFB5;
	Mon, 11 Aug 2025 07:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754898748; cv=none; b=kjJgHCx6c+Ol4NIzezq1I+Z/DzlFPYwJQtuuHHqcwBeFE8zep8UXyEw88U5hoFMMlu7q0zHBLHFaUdCuPMunYksEMBvKwPasJ2DE8Z3JPLb9vXbpCsJ05RetT1U9DpGu5paduAjMTlNq+RQF4VKmoAhxdEENDFxsW5c1RkHGbeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754898748; c=relaxed/simple;
	bh=H3BlXpuRmGzxWDVlmDgIq1skjZL4GGuzTI7jdhUGHts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y0KjleoIp6WAD3MAx5m9Oejgi/rG7syKQAftxqRFvmI7G55UeWBlenc7lEKrGToCm8oyGR9lwfSKT9AwB09X7O607EFXqtKD+DYFYOS9oU9hfVoaYVFIgU7v/UHSeZhIeN96RXFln4GRdivOppqQYfgvA8TFFGn5JG+BMPOeFkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=jx5d7NOZ; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=lzMhHRGpCbBOS1Zky2Z7cYGjVA23RxQa2SFqJvnsliM=; b=jx5d7NOZopdW4QXZ9Eo13eSGz2
	oYvTgO+cGzBzlwKlI8auCtRDzu1lsOEQrGGpE0U6wAXwo3TIIv+fckQcjk0ZKXijtnvAWAJt34bfy
	sA6nbXHqQrv0iuAU6pw2zwRVtsgy3i5tbbbyzsMefdKg7kX2zVXmqasBljymYOXc4GFiRo+EWfWMj
	z9ZGf88P1G5TXZly8gs4AEIyScHgGmyz4zLvXX64zl5w2B/LAi29C+IrSbZ/MljiNende2E9YARLk
	gU9gzfK1R0LaQKk7YSUduK6BAPBobhTIn+Nb/z/ymv8NpKhdy+CD9vms67fuLrkPvh9ZKeNqqRhn6
	IsS0ivXQ==;
Received: from i53875a0c.versanet.de ([83.135.90.12] helo=localhost.localdomain)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1ulNKL-0007Ro-KC; Mon, 11 Aug 2025 09:52:17 +0200
From: Heiko Stuebner <heiko@sntech.de>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Andy Yan <andy.yan@rock-chips.com>,
	Detlev Casanova <detlev.casanova@collabora.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Chaoyi Chen <kernel@airkyi.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Enable eMMC on rk3576-evb1-v10
Date: Mon, 11 Aug 2025 09:52:03 +0200
Message-ID: <175489870463.808197.10726652758635074758.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250731062415.212-1-kernel@airkyi.com>
References: <20250731062415.212-1-kernel@airkyi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 31 Jul 2025 14:24:15 +0800, Chaoyi Chen wrote:
> Some rk3576-evb1 boards use eMMC instead of UFS. Enable eMMC for it.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Enable eMMC on rk3576-evb1-v10
      commit: 6294d0590d5f65725e505b89978895bd04b55650

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

