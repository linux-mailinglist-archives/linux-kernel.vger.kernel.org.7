Return-Path: <linux-kernel+bounces-635703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F84AAAC0FF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 12:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 239D33AC4FB
	for <lists+linux-kernel@lfdr.de>; Tue,  6 May 2025 10:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC35A2749FB;
	Tue,  6 May 2025 10:11:36 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35B7275117
	for <linux-kernel@vger.kernel.org>; Tue,  6 May 2025 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746526296; cv=none; b=WJx3fKl/zVe4Sa9ka+UIvpgvWnvROitm/CCaCwJiV1dDYcn+hhKzQqLlXcADsYQU8KFPeFLs+lYLbtDCFtWc8y7p8YZtK58KQMlh5ILv+N/GW35caSnRr5C6Y0FJtCBysdtWb6DF33ZXILF0zI+7bfkFKuqBlJErFl0/RVN6PLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746526296; c=relaxed/simple;
	bh=/14muUSnjrguA3XDoHQcGk3OKFUssHvmhKsZnJ4M/DM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JwaGEK9JlQU18CR8bZjc7mdWwjNflOCmElFgMouo0gfUIAnjFoDyEc2dSwOmc/VFPBGD2qfoN87beXDv4TOcbsu9FWKkzluPy0Ww+a1ZckwR+9P4pRUem3lyG5Ib02mGsd3ky8C6szDHVp+/dLveuwjjxkstYcElP1hUUxKuHkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uCFGh-0002Dd-2d; Tue, 06 May 2025 12:11:19 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uCFGg-001NTB-1n;
	Tue, 06 May 2025 12:11:18 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1uCFGg-0005kT-1X;
	Tue, 06 May 2025 12:11:18 +0200
Message-ID: <bce05a662787134194d20951b8de7f6defb4f9bb.camel@pengutronix.de>
Subject: Re: [PATCH 1/4] dt-bindings: i2c: Specify reset as optional
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Akhil R <akhilrajeev@nvidia.com>, andi.shyti@kernel.org,
 robh@kernel.org,  krzk+dt@kernel.org, onor+dt@kernel.org,
 thierry.reding@gmail.com,  jonathanh@nvidia.com, ldewangan@nvidia.com,
 digetx@gmail.com,  linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 06 May 2025 12:11:18 +0200
In-Reply-To: <20250506095936.10687-1-akhilrajeev@nvidia.com>
References: <20250506095936.10687-1-akhilrajeev@nvidia.com>
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

On Di, 2025-05-06 at 15:29 +0530, Akhil R wrote:
> Specify reset as optional in the description for controllers that has an
> internal software reset available
>=20
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
>  Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yam=
l b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yaml
> index b57ae6963e62..19aefc022c8b 100644
> --- a/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yaml
> +++ b/Documentation/devicetree/bindings/i2c/nvidia,tegra20-i2c.yaml
> @@ -97,7 +97,9 @@ properties:
> =20
>    resets:
>      items:
> -      - description: module reset
> +      - description: |
> +          Module reset. This property is optional for controllers in Teg=
ra194 and later
> +          chips where an internal software reset is available as an alte=
rnative.

If the module reset was not optional before, shouldn't the resets
property have been marked as required? Then, instead of the comment,
you could conditionally remove the required status for nvidia,tegra194-
i2c.

regards
Philipp

