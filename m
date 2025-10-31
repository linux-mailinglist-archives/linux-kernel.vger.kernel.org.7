Return-Path: <linux-kernel+bounces-880997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E599AC2726B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 23:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D0CF1A22D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 22:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9773195FC;
	Fri, 31 Oct 2025 22:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="xgwXqGFK"
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECF332A3D4;
	Fri, 31 Oct 2025 22:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761951245; cv=none; b=OMxtXpNLJgIJej2Do1ADyKr8mi/LFtkZudUijqmJ4tEwgwVBwjyez0F3M7oFeZGaEglhZiqBoaKMl8ojXBsUnDFosoNH9buLyTz4qZtciMiow4p+EO22iT5DTlfR68azZQdI4ZTVFTMyQPM0drcQfGEPz/IXxQQfHiiNe4bIDjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761951245; c=relaxed/simple;
	bh=6Wqf++XLTMHjisyj9HNYe5hEzbNQnXL3weWh2kqgg5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qjbal+1//txbq/bgURN3VB7YFvUPsyPggtsdEeTvETBov8/EGRkO+nn++4zrazUdhrH28wtZk+adFwwBZEuckv8fat11/ZwneKxC0N/JllaqVLb75MFq1fuOwxWteznP+lF1Yi1RlV0zyeYaMzb9QJ9wCdjjyyb+d4mqhaz3QQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=xgwXqGFK; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=lRpBRBWaIHX6eIuECYCQwXUzbJ82+e6Wq9lqx2nwbRs=; b=xgwXqGFKSBKVZuxYEma799JQZb
	VtGDMgxEaTNZkC8hCr3EtN+fkIsXPNlUXkO+ZVxF0HRWOI2b1tLYZs9PMbD/WwM5/qZ7JF+njeAjS
	omAfGpJ/lnK6jd5sTJWwGl6xJAu/OUbq5gYtc30bOwCd0KSvmt2jogOGyrxtFAnostK6GMadnx7p7
	7bbAPXxj4qBZiJ1v9Qu815We0SytOFeR+VvypBqcydkwbGhfPnOOjjyLkNZTyUEiXsQlFS53YFErw
	l0/xxoZcErsEvGT+HqgTwr5jwYeoi/dq13RUHcBrm6niYxUo2ewiO+K725p033wnavkobNLzZB14z
	Lz7nG8Zw==;
Received: from i53875bca.versanet.de ([83.135.91.202] helo=phil.fritz.box)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1vExzs-0004vM-CO; Fri, 31 Oct 2025 23:53:28 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Johan Jonker <jbx6244@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	robh@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] arm: dts: rockchip: rk3288-veyron: add spi_flash label
Date: Fri, 31 Oct 2025 23:53:23 +0100
Message-ID: <176195118795.233084.13649684258296887756.b4-ty@sntech.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <8a423a6f-bfdc-4947-aef9-35ee7c4f6ca2@gmail.com>
References: <8a423a6f-bfdc-4947-aef9-35ee7c4f6ca2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 30 Oct 2025 18:52:34 +0100, Johan Jonker wrote:
> The u-boot,spl-boot-order property requires a label at a boot
> device node. In order to migrate to OF_UPSTREAM more easier
> add a spi_flash label to the rk3288-veyron.dtsi file.
> 
> 

Applied, thanks!

[1/1] arm: dts: rockchip: rk3288-veyron: add spi_flash label
      commit: ac7116a626e00d3024adedb43b74bdf2ce45efc2

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>

