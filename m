Return-Path: <linux-kernel+bounces-776012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAC5B2C775
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 16:49:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A8B3A7C97
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015E62869E;
	Tue, 19 Aug 2025 14:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Xvn2E8EJ"
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5C527E060;
	Tue, 19 Aug 2025 14:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755614808; cv=none; b=GYMgVi0Ru4zVtz9ehbhEDwJRU1nrE1RVAnfTpwfgeDpjnvN1Yvo/0t271uzQCWeNQJKSmeKU5GxS1IY7rsEaQzMmUNPNhPmC67JNGf1CuSMC1AIrteNg0WT93mZ9EIxfpP5z2aQ6n1GABmmDyK+bUaSDUgITdQalXWrLzjGGMkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755614808; c=relaxed/simple;
	bh=lIQwI5HsEj/MNS6ooAEjHaJqIuOIhzaddWDiwenv7EA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Riz1tnXmYWYZYDmmcPeD0/OjzeVOKEkZaD0qUZPyJ0EU2aN2Clsz+kRDKlvHiV6O+0FJqoZ9q3AacZPOusAweRX1UdTVeQcQs3N/wa/JOqXRLORaJdW92GLrdohemDHMW6mG5N9M0Hg17y5a8aOWyW3iRVCn6+6GdS5hjAKHWS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Xvn2E8EJ; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D0DE31F47A;
	Tue, 19 Aug 2025 14:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1755614801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Nc/LQSMQfGgp1YRf3tUnRSaCb+wuSL3TiqDWsh2u7Q=;
	b=Xvn2E8EJKnK2mFkg85Mx73CYet081ujXFBzOiakOaRo2V2LGzVAvgvmw2dyNP6RODq8dzG
	ER8M0Hk40YfSelzHZBRU9PK/jvELYGwnT8ZtQnSuZXIlN+qK2b3DhAB0gw/cNq1x7+zhLI
	4oYIcL3wTQOxxNaIVXd2zOnyQCGwKODvImC2rdRuNXTcc9QJl0pbZvosjV3NLOg96UAONK
	NqPqI9ynkKqn/sFG3t4VSQF0cmy3hJF8BYkmMiTkleLZG6f/A1KRKhp5d529/OwuUJlGv5
	LxiedjIRiRYDouo1J7nL/jGRLhgKtHu7Z8+B5uyPwqFqORjgp+iRh3hX+Wnc2Q==
From: Romain Gantois <romain.gantois@bootlin.com>
To: heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
 Xichao Zhao <zhao.xichao@vivo.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Xichao Zhao <zhao.xichao@vivo.com>
Subject: Re: [PATCH] usb: typec: mux: Remove the use of dev_err_probe()
Date: Tue, 19 Aug 2025 16:46:39 +0200
Message-ID: <6186026.lOV4Wx5bFT@fw-rgant>
In-Reply-To: <20250819112451.587817-1-zhao.xichao@vivo.com>
References: <20250819112451.587817-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5034698.31r3eYUQgx";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehjeejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfgjfhggtgesghdtreertddtjeenucfhrhhomheptfhomhgrihhnucfirghnthhoihhsuceorhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeekffdvuefgkeejgeefhfdvteeuhfdtleeiudehieeludelvdetleeggfffffenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepfhifqdhrghgrnhhtrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpehrohhmrghinhdrghgrnhhtohhishessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohephedprhgtphhtthhopehhvghikhhkihdrkhhrohhgvghruhhssehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepiihhrghordigihgthhgrohesvhhivhhordgtohhmpdhrtghpthhtoheplhhinhhugidquhhssgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhop
 ehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: romain.gantois@bootlin.com

--nextPart5034698.31r3eYUQgx
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Tue, 19 Aug 2025 16:46:39 +0200
Message-ID: <6186026.lOV4Wx5bFT@fw-rgant>
In-Reply-To: <20250819112451.587817-1-zhao.xichao@vivo.com>
References: <20250819112451.587817-1-zhao.xichao@vivo.com>
MIME-Version: 1.0

On Tuesday, 19 August 2025 13:24:51 CEST Xichao Zhao wrote:
> The dev_err_probe() doesn't do anything when error is '-ENOMEM'.
> Therefore, remove the useless call to dev_err_probe(), and just
> return the value instead.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/usb/typec/mux/tusb1046.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/mux/tusb1046.c
> b/drivers/usb/typec/mux/tusb1046.c index b4f45c217b59..3c1a4551c2fb 100644
> --- a/drivers/usb/typec/mux/tusb1046.c
> +++ b/drivers/usb/typec/mux/tusb1046.c
> @@ -129,7 +129,7 @@ static int tusb1046_i2c_probe(struct i2c_client *client)
> 
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> -		return dev_err_probe(dev, -ENOMEM, "failed to allocate driver 
data\n");
> +		return -ENOMEM;
> 
>  	priv->client = client;

Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>



--nextPart5034698.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmikjk8ACgkQKCYAIARz
eA41AQ//QR8aTYlAaJQzQ4KHzYrI7WpumkxyF8uxkVvPMiCJHCsbpySePEn/sIGe
tY42RUyYkQ2P5+eWqjJwy5qwFTl3neTxjFzWoJqEwpUBOCzSkKsHfEDoT5MWW7wc
NUYKbxi73nvVawpfi5N762GxmWxBLgHxmmF0LnBVnldC16xcWCKB5F+PPOzgujk/
peymHaShLBh+p1R9vXP2a19+wXyoP1DxNb05pfmVUAKTbu4cjExUOpXRdc0Jwfd7
ZRXDJXyIN8Ahl9UI3alyia0nZkbUvpBpyWC0jpvsVDA7NljmUlGRfmtpQSwgFoR6
e7ojvmRDU7oJuV002s8T9DSTdMA6HPZofKXDr4jRx/MQeV3p7tfECI5PTqxSuwfC
kaJXU6b7H20GyIy5GV0J+WZb1cCMZrIVy6RJFUNWSAAb7G6EiIx1yz0H/dYKRAUJ
Ul59se2GbwBIEauOiuzrHDBzJzUCRSHAevz6jsaiJmMTJQ7BGd01HRO007oHSq5y
h7bX6ZBF5PHjW6vUWLS120UO4U6O9PAnNr5wF6MASMTU7SZrR0Z92MIblSBg7SyC
aGd7X74WRQHhy21ufnO2/8xYOi9MqwDb/ig01FKDfAG7iiBUlk9yhSgdP42luczD
bYWlXT02PR6u2TPeOzSbideSIy2zbdIOLDOVrYP5EkuIGRWUtq8=
=GBSg
-----END PGP SIGNATURE-----

--nextPart5034698.31r3eYUQgx--




