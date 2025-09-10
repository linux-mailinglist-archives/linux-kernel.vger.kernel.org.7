Return-Path: <linux-kernel+bounces-810227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4A7B51777
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 14:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE93F1C8423D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD892BE65A;
	Wed, 10 Sep 2025 12:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KlPcWQyM"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EA02877C1;
	Wed, 10 Sep 2025 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509117; cv=none; b=tssl3dpAK79QcZkXbYPmSbMQeV7l17IKh3wLO2OdAKJfF6kGQDKrAOnmP9nm9xPLvIAOrRKS/YMbJLbn1txqISi1xaY8dw02WTH7VY1usxMKCuWNVBYEZ/xpS4I0tRpwc67EuwNXiQXNXK4l++SDFYYF+EzyNPYj7wR6yRda7hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509117; c=relaxed/simple;
	bh=MLokNutgp7SBdYTGJYNkI/O0jF20QflWiwZPoYskg7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aFyd1NSpM3iymOLJETeDzA5IOVozq8CwPqSt881U7YidqjRxtg6Vx8U17VgDdmuMag5QS7PFeGKtPKhK91goVValK/TQBRTotZYD7BXjiZy5TR6TwetxuTBiDp1rsWh48/kZT/KGuSA+HISHCAMoRK1DBF3dbsMCMjuhM3saKxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KlPcWQyM; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z5aBzRy9SrXCcJ1rkx7TeZFNbpBmp0grZlwbuKu+WTg=; b=KlPcWQyMuHIw2RSFiHPkUTAg+i
	tWFfaCyb/S3jsoP37vt2y8BaMh65/Kb4eS0v1mMmNAn7c5Qh/YtyRQreMwwPk885AQsinLQSg3M/p
	CMXWeLiczT8ZLD7Yu90NNoFp+pbl/1i62enwSlxmX34MzJG6po0OP27saJNxncWOHiA0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwKP6-007wTF-UL; Wed, 10 Sep 2025 14:58:28 +0200
Date: Wed, 10 Sep 2025 14:58:28 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Donald Shannon <donalds@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org, etanous@nvidia.com
Subject: Re: [PATCH v9 2/2] ARM: dts: aspeed: Add NVIDIA GB200 UT3.0b board
Message-ID: <e51d1a9c-a54e-4fe4-9091-4f5ea29535ec@lunn.ch>
References: <20250910041736.245451-1-donalds@nvidia.com>
 <20250910041736.245451-3-donalds@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910041736.245451-3-donalds@nvidia.com>

> +&mac0 {
> +	pinctrl-names = "default";
> +	phy-handle = <&ethphy0>;
> +	pinctrl-0 = <&pinctrl_rgmii1_default>;
> +	status = "okay";
> +};

Same here. Please describe your PCB.

	Andrew

