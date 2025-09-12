Return-Path: <linux-kernel+bounces-812998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88210B53F79
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 02:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4291B264DF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 00:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF91147F4A;
	Fri, 12 Sep 2025 00:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+K5SNqO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A172282E1;
	Fri, 12 Sep 2025 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757636270; cv=none; b=NFehd0ZcrjeGopeA1nqISznV935IMPlSHvPNVqtg5B/sZMAqE5sbzVkmvAd/WqGtxrr0ZTywLy6K8K2Hrmxvcg4XGclbgMvD1VGI4GcuOxaPzv5QQ5FGEB9xmTNORwKIPhkDphoXTzkemCcQQLhv/jn5PvAscGvRY3f8AdqsJWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757636270; c=relaxed/simple;
	bh=fP819yzC++terNL5njurIGiZuDLG/mrh8iOD390UL+c=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=fbaUB+FLbYOx9vT4/Mirv3YpyM8C439nJHMouJ5TT4A8q2sJj8nteyo+ZSFnHu2Fhv1LsXN/K0YBmiiPHDcRpCyikVgipXn9PLwmGimfj4xI/eYGK0TrSJRjX5HzSsI3PM+mtFpWPsPvF/kN0p0aCn+lnfEs6kgARJlkuRnrgk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+K5SNqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6887AC4CEF0;
	Fri, 12 Sep 2025 00:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757636269;
	bh=fP819yzC++terNL5njurIGiZuDLG/mrh8iOD390UL+c=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=Z+K5SNqOm48bLUz+5A0IdXO3ZrmlYGCGFqNEQskaI39MSeUvM8tpANgoWRFME8Uqz
	 1kJkC9d3Jy9sivSVn+JhJmKyP/PNC1lvTCCamRJLKaZB2rTcsIb/aSg0RAP8OReilK
	 boIHP0lauH3St8EBfPNHVwn6Wotuzzx5VCWxhSP8dEfjmP2a5ap/Q7HhZqvfjSyIXC
	 0i1ZuIAKs9kaCzGvGb0helOnCBGZDDmNCywMBaJbx8K7MTvz+vYLhNQFZBYJd1qQAr
	 TcAqky5RlS6QqnWlwLQqPfPEKfKl63yZVZGJ3ZYJdwKIgrnGkOkTanlZ1hk/nzTTEp
	 94uewcfhU55rg==
Date: Thu, 11 Sep 2025 19:17:48 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor+dt@kernel.org>, 
 devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Matthias Kaehlcke <mka@chromium.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, 
 Mark Brown <broonie@kernel.org>
To: Marco Felsch <m.felsch@pengutronix.de>
In-Reply-To: <20250911-v6-16-topic-usb-onboard-dev-v4-4-1af288125d74@pengutronix.de>
References: <20250911-v6-16-topic-usb-onboard-dev-v4-0-1af288125d74@pengutronix.de>
 <20250911-v6-16-topic-usb-onboard-dev-v4-4-1af288125d74@pengutronix.de>
Message-Id: <175763620958.1187267.14091957840948870392.robh@kernel.org>
Subject: Re: [PATCH v4 4/5] dt-bindings: usb: microchip,usb2514: add
 vbus-supply example


On Thu, 11 Sep 2025 22:22:45 +0200, Marco Felsch wrote:
> Add an usb hub vbus-supply example to make it easier for users to
> understand the binding, after the usb-device.yaml gained the support for
> it.
> 
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  Documentation/devicetree/bindings/usb/microchip,usb2514.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/usb/microchip,usb2514.example.dtb: ethernet@2 (usbb95,772b): 'vbus-supply' does not match any of the regexes: '^pinctrl-[0-9]+$'
	from schema $id: http://devicetree.org/schemas/net/asix,ax88178.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250911-v6-16-topic-usb-onboard-dev-v4-4-1af288125d74@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


