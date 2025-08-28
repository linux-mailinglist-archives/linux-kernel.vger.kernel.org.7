Return-Path: <linux-kernel+bounces-790010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B794B39E39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 15:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72AFF3B46EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D0E3112A3;
	Thu, 28 Aug 2025 13:10:21 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF178462
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756386621; cv=none; b=At4tMleuwBqoRAsV49nr7mMcgl6PPVbBXYwM7gLX3IaH95BfPcOFm1ttDO55zdVwjtK3RUil1LU/jNy7P4Mokn9eul177/XVzIxHcPIOgp/Gq+t1U7YFTEHFhvsYc796eRIcksXR0/jX6su9uHpeCfU+RbNuziLXr52E6RGoTgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756386621; c=relaxed/simple;
	bh=uybcLJy6aMbd1c4GMpwxx22VyqBVu7UA6gHg7i51zAQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u8w5n1QvE4yzRZfUg84GazkRcpp1SDKmMKLzPwRvwc6G7YwZDoWgzCL7+N6K3Qxfz9pl3y24/nku2Q0LA5HSlTYcrqMoJVIOqo6p3GBUYPl6u4C8sHay/1V2ZESQUNJONxJNNnkksWAZLtGeSarjVkAMjLC7YrQ2y0PWFqUpdOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1urcOK-0002dm-Tn; Thu, 28 Aug 2025 15:10:12 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1urcOK-002Z29-1u;
	Thu, 28 Aug 2025 15:10:12 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1urcOK-000Kfj-1g;
	Thu, 28 Aug 2025 15:10:12 +0200
Message-ID: <eca2aee2cc628a4a67b39c284c1be643592c1905.camel@pengutronix.de>
Subject: Re: [PATCH] reset: canaan: Remove redundant ternary operators
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Liao Yuanhong <liaoyuanhong@vivo.com>, open list
	 <linux-kernel@vger.kernel.org>
Date: Thu, 28 Aug 2025 15:10:12 +0200
In-Reply-To: <20250828122843.48722-1-liaoyuanhong@vivo.com>
References: <20250828122843.48722-1-liaoyuanhong@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Do, 2025-08-28 at 20:28 +0800, Liao Yuanhong wrote:
> For ternary operators in the form of "a ? true : false", if 'a' itself
> returns a boolean result, the ternary operator can be omitted.

Here you are replacing "a ? false : true" with "!a", though.

> Remove
> redundant ternary operators to clean up the code.
>=20
> Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
> ---
>  drivers/reset/reset-k230.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/reset/reset-k230.c b/drivers/reset/reset-k230.c
> index c81045bb4a14..2eb16aac60c0 100644
> --- a/drivers/reset/reset-k230.c
> +++ b/drivers/reset/reset-k230.c
> @@ -218,7 +218,7 @@ static int k230_rst_assert(struct reset_controller_de=
v *rcdev, unsigned long id)
>  		break;
>  	case RST_TYPE_SW_DONE:
>  		k230_rst_update(rstc, id, true, false,
> -				id =3D=3D RST_SPI2AXI ? false : true);
> +				id !=3D RST_SPI2AXI);

Remove the line break. The line is short enough. Same for the other
occurrence.

regards
Philipp

