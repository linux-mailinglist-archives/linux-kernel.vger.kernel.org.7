Return-Path: <linux-kernel+bounces-826586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AA6B8EDC9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 05:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 607771899946
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 03:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C742D94B3;
	Mon, 22 Sep 2025 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Rusvo56k"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A792F56;
	Mon, 22 Sep 2025 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758511879; cv=none; b=TVw0nur2Mk9GZYqp/2B1cGFDgMf1aV0/BCRUyjq7xiCQzXxfw37C+xyUTh5+Ulenh7D7uPxV7OUceBO8HKj0+0UAdvqIMj3ydq9jImDKkNZbzS+nMI19CsuMilh/5ChR8ULBn6nTfovLNuU1VGBEdZb/2xl806kqQfgEUNB0meM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758511879; c=relaxed/simple;
	bh=QaXrXcglDQfLa77iJyP30LKs4SsMIIVR73AzHuHaM78=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O96fvI6Hu/s1ynRsCkN9YXkoKZ7H5frvclw7xRXIeqjsbKJuN6jVQ81yUdHc4iXb/ebo42Fi5xK8KNa2j7UOw1wgXmb/n0FUrNMcG8HvJNoCJySRxwx3LjirKlz7F6DiPAMM/VpNvziPGy03DV90FmS6tTH1acVxgH9x7Vr9IIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Rusvo56k; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758511873;
	bh=QaXrXcglDQfLa77iJyP30LKs4SsMIIVR73AzHuHaM78=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Rusvo56ktjDEguZBuTQfb4AjQchdfV9edgcCgAodCW0W37mlsxIXeauzFhBKrrU0C
	 k3gXA+10jTzmnDLpUvyLWAj7MoJG06llM4u9tvjYRoIH12QgE56Iq0IOif2GxuhqYN
	 YuQ3EX0EV18WCOxX9Uwle00U2ufjWyrzFZQ6eFwqEz4wl5PNybQvGwF1HUMKfUowEu
	 arX7eQ7uKFhuXY7FjCeQ9Nf2Fn+2UxrDDzmSQjAxSmSOyL47VpHjcRmQy2OWu44kpL
	 YNpUJEo3U/kxZnBOCRDXDn7wkQ/Wkgafvh2m5x10f1fokQ/2cNH7f02yVCY7K3c/uQ
	 WWpPSzOdaz94g==
Received: from [192.168.68.113] (unknown [180.150.112.213])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id E6F7964755;
	Mon, 22 Sep 2025 11:31:12 +0800 (AWST)
Message-ID: <393411916e94245a9f3628c41ebee34c3dd95a98.camel@codeconstruct.com.au>
Subject: Re: [PATCH v1 0/4] Revise Meta(Facebook) Harma BMC(AST2600)
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
  Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 devicetree@vger.kernel.org, 	linux-arm-kernel@lists.infradead.org,
 linux-aspeed@lists.ozlabs.org, 	linux-kernel@vger.kernel.org
Date: Mon, 22 Sep 2025 13:01:11 +0930
In-Reply-To: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
References: <20250917101828.2589069-1-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Peter,

On Wed, 2025-09-17 at 18:18 +0800, Peter Yin wrote:
> Summary:
> Revise linux device tree entry related to Meta(Facebook) Harma
> specific devices connected to BMC(AST2600) SoC.
>=20
> follow-up:
> https://lore.kernel.org/all/3a65d568540e9ca43d3bfc24cfe5f72d2bb12b3b.came=
l@codeconstruct.com.au/
>=20
> v1
> =C2=A0 - Patch 0001 - add new line between the child nodes
> =C2=A0 - Patch 0002 - use power-monitor instead of power-sensor
> =C2=A0 - Patch 0003 - dd sq52206 power monitor device
> =C2=A0 - Patch 0004 - dd retimer sgpio
>=20
> Base: tags/v6.17-rc3-39-g07d9df80082b

Can you please rebase this on the aspeed/arm/dt branch of

https://git.kernel.org/pub/scm/linux/kernel/git/bmc/linux.git

Patch 2/4 fails to apply.

Cheers,

Andrew

