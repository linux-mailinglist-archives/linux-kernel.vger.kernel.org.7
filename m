Return-Path: <linux-kernel+bounces-829856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14875B98107
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 04:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95662A765F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 02:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AF921D3CA;
	Wed, 24 Sep 2025 02:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="NVcwZUij"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AE41DD9D3;
	Wed, 24 Sep 2025 02:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758680224; cv=none; b=E21krGp8lSRKb2I1QcIORqlkVlRuxchUvOV9Dd0vDlX2/bkKtlq4N558gHa5Y5oh6syQoqksdZehyWDO/MwD6ilxYsYoNqBe3TehKIkz52FIdv7sKcfTu2fS/vIAiiAnC6Igj0CIL9Nk7kh/GH8CvwG4x+NLjqSwb1jzn0nzMus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758680224; c=relaxed/simple;
	bh=o86uR5LMiT+hV3SmPRKcbqfcrdavxLeiGsYGrCWjtn8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O7tfbibrEiHOHIaejHED7O9jqQjjMS8In23gDCraV0MlbadSZduenM4ByLscp/sJdoWEsXHwVDdpsmgVXCeYKxNTx1hDb5iJwvy+izHCwi8GNwJFjJrYRJyHhuQuIb4NFxm2fH95eqSPe70GbCam+HeIvY4AE5LaWEgxhbiR7/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=NVcwZUij; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1758680220;
	bh=o86uR5LMiT+hV3SmPRKcbqfcrdavxLeiGsYGrCWjtn8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NVcwZUijQuewnTTWXH/HwuKOdQOniu3CnCeSgCJS6CEOQdhRR2PPy7tf9fRR67doi
	 XXQXHzDxe4GRVIpHwCHPDFv5DzG+iWdc7uq31HePz1HYcvL9cPNPLk23l9MaNOYCFN
	 wE2eNwdy8haEZg/qXh9A2ycJxMU3Cc6unjBtvcPWXj5GjxVKLRrcwEcVnlzsLghDst
	 UyS1EGdqx1uhBmy6U27hJojdDzDLyRZcSaqULHrcAQvUfbKkXXna81PnFCkKiSvn6p
	 NVopGc6QrmO5anbsh9s/AbKUI7U9Lm+vWtsy8E5nU58Vc5WWnGVOV4+vWU/vx22JxH
	 1if9cC6lDKt+g==
Received: from [IPv6:2405:6e00:243d:a853:dbe5:4849:b82e:5665] (unknown [120.20.205.123])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 15EAC647A7;
	Wed, 24 Sep 2025 10:16:56 +0800 (AWST)
Message-ID: <e970c1693af3a612d9eccac2932e2e0be3d37453.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2] ARM: dts: aspeed: clemente: add MCTP over I2C support
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Leo Wang <leo.jt.wang@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	 <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	george.kw.lee@fii-foxconn.com, bruce.jy.hung@fii-foxconn.com, 
	leo.jt.wang@fii-foxconn.com
Date: Wed, 24 Sep 2025 11:46:55 +0930
In-Reply-To: <20250922-leo-dts-transceiver-v2-1-d2dc0e24a70b@fii-foxconn.com>
References: <20250922-leo-dts-transceiver-v2-1-d2dc0e24a70b@fii-foxconn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Leo,

On Mon, 2025-09-22 at 15:02 +0800, Leo Wang wrote:
> From: Leo Wang <leo.jt.wang@gmail.com>
>=20
> Enable MCTP communication on the Meta Clemente BMC board:
>=20
> - Add an MCTP I2C controller node at address 0x10 on I2C0
> - Mark selected I2C mux channels as MCTP controllers
> - Remove unused "i2c-mux-idle-disconnect" properties
>=20
> This allows MCTP devices to be discovered and used for
> management communication on the Clemente platform.
>=20
> Signed-off-by: Leo Wang <leo.jt.wang@gmail.com>
> ---
> Please consider the patch "[PATCH v1 1/1] ARM: dts: aspeed: clemente: add=
 MCTP over I2C support"
> withdrawn.
>=20
> After further review we determined that enabling MCTP in the Clemente dev=
ice-tree is not
> required; the affected devices are managed through other mechanisms and a=
dding MCTP nodes
> would be unnecessary. To avoid confusion and noise, please ignore the pre=
vious patch.
>=20
> Original patch message-id: <20250918-leo-dts-transceiver-v1-1-3e2580325ed=
c@gmail.com>
> ---
> Changes in v2:
> - Withdraw patch; no functional changes
> - Link to v1: https://lore.kernel.org/r/20250918-leo-dts-transceiver-v1-1=
-3e2580325edc@gmail.com
> ---

Please do not post a new revision of a series to announce withdrawal of
the series.

Rather, reply to the original series saying as much.

Thanks.

Andrew

