Return-Path: <linux-kernel+bounces-865752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C35BFDE96
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 20:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C797B355BCB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 18:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B9A34EEE5;
	Wed, 22 Oct 2025 18:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="L5gDZGF7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zEkprsMX"
Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47056348870;
	Wed, 22 Oct 2025 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761158625; cv=none; b=pXRqx6jRiF2sTLABj+gpz+unHxxkTd4zwkC8qer1JReX3qPqqLfZZpscnNGOMkVSAE9GndUXowRR1Qz8hF5meuSUe38zkrt8Y3UmjlBx1588E0BC5rLzmPgctawj1EuPHLBNH+HWGRu6CwuQ8OfDQF7wgVxcrG+0kS1MbAV60As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761158625; c=relaxed/simple;
	bh=SnpoFE5xVRVea+Sw7bk4vBkAKnlGJ1/m3pcGoKD3y/s=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=OUbKdKzysSxBZAo+cKx22TKP98eHVpFzD6mTruf+VYk0pjD2+S89/qJJek+NzNxZL4hr6Svpd61e2eqYkRQqDKQ9bk/V6IRkbHKzvI94qnFNrEEvPdx6WvP+qX3jXPKroPsXI03NpgKEEdI9fy1NBY78AtBnCEXqqxHQJHnpKIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=L5gDZGF7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zEkprsMX; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4AEA21400105;
	Wed, 22 Oct 2025 14:43:41 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-12.internal (MEProxy); Wed, 22 Oct 2025 14:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761158621;
	 x=1761245021; bh=a5gBAyzs5ZMXhns/nsTEBnOvmf2BeF0u5fAf5dTyws8=; b=
	L5gDZGF7jRuiCRvNw9fBGwJfR4apNfCgzzuyqi2vLUWcXfc82lUtGuwFnYYcDoqc
	hGl6/PEIR94Ah6sJU6udAS8aF0fp3HzxbBb1pu2fwh618DcmFaBkG7Cz6E+sMvFP
	qD06SU4vvtXRhvRYGiVl9kvuMZ9j0cP4g0l3U4cPFHd8D0iDmVippRTc66Vba1lR
	nYSt33TH3gShUwvineJL6BgiOTmPFYcZ7aKmAjg+KqIIK1im4Ln3D/lacEl0YN4j
	0k18VgON1UM59wnB2Zt8TGXD3QzkwkqLoCIdUQQL/bHpxu/aSCff8fSKBJN8YThT
	8Kyz1uV3dAQy5Y0bYLh/dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761158621; x=
	1761245021; bh=a5gBAyzs5ZMXhns/nsTEBnOvmf2BeF0u5fAf5dTyws8=; b=z
	EkprsMX0KK7YLaXFGGlFpzOvnCcoCeRQfTonrcX7936BQpnuklenjrmdzELw/7sT
	c2qhZYQ0uXrzcKRpNC267OWvPu/RR3o4j2xu7FbI+lExRdtOetCNi3IEGxuuBtlV
	c5aUI/jc/pZfqFCoTFFTIEyVH+Q0+Ygao3RBvqc1AkqPYJcPWDGtmSjROKB1m/sy
	Xc+bbDfQ7wgNurnTAVM0utW+lpHyC0Qq0y2f5K439Jv0R1la4BmwZCj/ies9ILlD
	9vGW7ZMnPvR2StHpr47LOWXwLIrqt+hsQ2VIxNLpjB6Z63+lbN8HeM1SzTD0cTV8
	umosIC6uMmm7FK46+Tj6g==
X-ME-Sender: <xms:3CX5aK-8YwXN0pguwQvWJ2JZseLf58kKq6_5ZnPnK0A2oiF36Kapiw>
    <xme:3CX5aFhk33UjBVonRl6O-JIHOiIf7CX6sDezTo7PZMJsYtWfHQ6qqxnmMm9RvzC_Y
    Yv4AbH9o8nm91woBkaA1fT1DTlKcLywROjZ44b2c6drYJg42dO9mQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeegfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrrhhk
    ucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtg
    grqeenucggtffrrghtthgvrhhnpefhuedvheetgeehtdehtdevheduvdejjefggfeijedv
    geekhfefleehkeehvdffheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrpdhn
    sggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghrvg
    hkjhhohhhnrdgtlhgrrhhksehgmhgrihhlrdgtohhmpdhrtghpthhtohepihhkvghprghn
    hhgtsehgmhgrihhlrdgtohhmpdhrtghpthhtohephhgrnhhsgheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepihhlphhordhjrghrvhhinhgvnheslhhinhhugidrihhnthgvlhdr
    tghomhdprhgtphhtthhopehisehrohhnghdrmhhovgdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehplhgrthhf
    ohhrmhdqughrihhvvghrqdigkeeisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3CX5aCh-9PIS9rM8vvCVcky8Ugn6P7i9mATUtrWcJQX97Uk_o51EWg>
    <xmx:3CX5aCGiuqYxOFaOtlhXJaDyJVY_kvZxPAJNlu-Nd3V753JXRhuR-w>
    <xmx:3CX5aARsGVOuLp29HxZtdkfCSn6CQmOm5pm7Vj24XyrBogvWx61D3Q>
    <xmx:3CX5aHyzd7nHP28BvF7YJRvLZhepMUNQLrVyOCtsjs2gUr76QWZ07w>
    <xmx:3SX5aMPDvQfaCLvYRdREBMYKPbxFihdU6toRgmTp8rNUVJGff8ZpaNvq>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id D09042CE0067; Wed, 22 Oct 2025 14:43:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ArVEV3phbwOF
Date: Wed, 22 Oct 2025 20:43:20 +0200
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Rong Zhang" <i@rong.moe>, "Ike Panhc" <ikepanhc@gmail.com>,
 "Derek J . Clark" <derekjohn.clark@gmail.com>,
 "Hans de Goede" <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: 
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Message-Id: <f0454d78-0fe9-431d-a0c9-6f7db7809039@app.fastmail.com>
In-Reply-To: <20251020192443.33088-3-i@rong.moe>
References: <20251020192443.33088-1-i@rong.moe>
 <20251020192443.33088-3-i@rong.moe>
Subject: Re: [PATCH 2/2] platform/x86: ideapad-laptop: Add charge_types:Fast (Rapid
 Charge)
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Rong

On Mon, Oct 20, 2025, at 9:24 PM, Rong Zhang wrote:
> The GBMD/SBMC interface supports Rapid Charge mode (charge_types: Fast)
> in addition to Conservation Mode (charge_types: Long_Life).
>
> Expose these two modes while carefully maintaining their mutually
> exclusive state, which aligns with the behavior of manufacturer
> utilities on Windows.
>
> Signed-off-by: Rong Zhang <i@rong.moe>
> ---
>  drivers/platform/x86/lenovo/ideapad-laptop.c | 61 ++++++++++++++++++--
>  1 file changed, 56 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/platform/x86/lenovo/ideapad-laptop.c 
> b/drivers/platform/x86/lenovo/ideapad-laptop.c
> index 9f956f51ec8db..d2bfaa532020a 100644
> --- a/drivers/platform/x86/lenovo/ideapad-laptop.c
> +++ b/drivers/platform/x86/lenovo/ideapad-laptop.c
> @@ -62,13 +62,26 @@ enum {
>  	CFG_OSD_CAM_BIT      = 31,
>  };
> 
> +/*
> + * There are two charge modes supported by the GBMD/SBMC interface:
> + * - "Rapid Charge": increase power to speed up charging
> + * - "Conservation Mode": stop charging at 60-80% (depends on model)
> + *
> + * The interface doesn't prohibit enabling both modes at the same time.
> + * However, doing so is essentially meaningless, and the manufacturer utilities
> + * on Windows always make them mutually exclusive.
> + */
> +
>  enum {
> +	GBMD_RAPID_CHARGE_STATE_BIT = 2,
>  	GBMD_CONSERVATION_STATE_BIT = 5,
>  };
> 
>  enum {
>  	SBMC_CONSERVATION_ON  = 3,
>  	SBMC_CONSERVATION_OFF = 5,
> +	SBMC_RAPID_CHARGE_ON  = 7,
> +	SBMC_RAPID_CHARGE_OFF = 8,
>  };
> 
>  enum {
> @@ -632,6 +645,10 @@ static ssize_t conservation_mode_show(struct device *dev,
>  			return err;
>  	}
> 
> +	/*
> +	 * For backward compatibility, ignore Rapid Charge while reporting the
> +	 * state of Conservation Mode.
> +	 */
>  	return sysfs_emit(buf, "%d\n", 
> !!test_bit(GBMD_CONSERVATION_STATE_BIT, &result));
>  }
> 
> @@ -651,6 +668,16 @@ static ssize_t conservation_mode_store(struct device *dev,
> 
>  	guard(mutex)(&priv->gbmd_sbmc_mutex);
> 
> +	/*
> +	 * Prevent mutually exclusive modes from being set at the same time,
> +	 * but do not disable Rapid Charge while disabling Conservation Mode.
> +	 */
> +	if (state) {
> +		err = exec_sbmc(priv->adev->handle, SBMC_RAPID_CHARGE_OFF);
> +		if (err)
> +			return err;
> +	}
> +
>  	err = exec_sbmc(priv->adev->handle, state ? SBMC_CONSERVATION_ON : 
> SBMC_CONSERVATION_OFF);
>  	if (err)
>  		return err;
> @@ -2015,14 +2042,21 @@ static int ideapad_psy_ext_set_prop(struct 
> power_supply *psy,
>  				    const union power_supply_propval *val)
>  {
>  	struct ideapad_private *priv = ext_data;
> -	unsigned long op;
> +	unsigned long op1, op2;
> +	int err;
> 
>  	switch (val->intval) {
> +	case POWER_SUPPLY_CHARGE_TYPE_FAST:
> +		op1 = SBMC_CONSERVATION_OFF;
> +		op2 = SBMC_RAPID_CHARGE_ON;
> +		break;
>  	case POWER_SUPPLY_CHARGE_TYPE_LONGLIFE:
> -		op = SBMC_CONSERVATION_ON;
> +		op1 = SBMC_RAPID_CHARGE_OFF;
> +		op2 = SBMC_CONSERVATION_ON;
>  		break;
>  	case POWER_SUPPLY_CHARGE_TYPE_STANDARD:
> -		op = SBMC_CONSERVATION_OFF;
> +		op1 = SBMC_RAPID_CHARGE_OFF;
> +		op2 = SBMC_CONSERVATION_OFF;
>  		break;
>  	default:
>  		return -EINVAL;
> @@ -2030,7 +2064,11 @@ static int ideapad_psy_ext_set_prop(struct 
> power_supply *psy,
> 
>  	guard(mutex)(&priv->gbmd_sbmc_mutex);
> 
> -	return exec_sbmc(priv->adev->handle, op);
> +	err = exec_sbmc(priv->adev->handle, op1);
> +	if (err)
> +		return err;
> +
> +	return exec_sbmc(priv->adev->handle, op2);
>  }
> 
>  static int ideapad_psy_ext_get_prop(struct power_supply *psy,
> @@ -2042,6 +2080,7 @@ static int ideapad_psy_ext_get_prop(struct 
> power_supply *psy,
>  	struct ideapad_private *priv = ext_data;
>  	unsigned long result;
>  	int err;
> +	bool is_rapid_charge, is_conservation;
> 
>  	scoped_guard(mutex, &priv->gbmd_sbmc_mutex) {
>  		err = eval_gbmd(priv->adev->handle, &result);
> @@ -2049,7 +2088,18 @@ static int ideapad_psy_ext_get_prop(struct 
> power_supply *psy,
>  			return err;
>  	}
> 
> -	if (test_bit(GBMD_CONSERVATION_STATE_BIT, &result))
> +	is_rapid_charge = test_bit(GBMD_RAPID_CHARGE_STATE_BIT, &result);
> +	is_conservation = test_bit(GBMD_CONSERVATION_STATE_BIT, &result);
> +
> +	if (unlikely(is_rapid_charge && is_conservation)) {
> +		dev_err(&priv->platform_device->dev,
> +			"unexpected charge_types: both [Fast] and [Long_Life] are 
> enabled\n");
> +		return -EINVAL;
> +	}
> +
> +	if (is_rapid_charge)
> +		val->intval = POWER_SUPPLY_CHARGE_TYPE_FAST;
> +	else if (is_conservation)
>  		val->intval = POWER_SUPPLY_CHARGE_TYPE_LONGLIFE;
>  	else
>  		val->intval = POWER_SUPPLY_CHARGE_TYPE_STANDARD;
> @@ -2074,6 +2124,7 @@ static const struct power_supply_ext 
> ideapad_battery_ext = {
>  	.properties		= ideapad_power_supply_props,
>  	.num_properties		= ARRAY_SIZE(ideapad_power_supply_props),
>  	.charge_types		= (BIT(POWER_SUPPLY_CHARGE_TYPE_STANDARD) |
> +				   BIT(POWER_SUPPLY_CHARGE_TYPE_FAST) |
>  				   BIT(POWER_SUPPLY_CHARGE_TYPE_LONGLIFE)),
>  	.get_property		= ideapad_psy_ext_get_prop,
>  	.set_property		= ideapad_psy_ext_set_prop,
> -- 
> 2.51.0

I can't comment on the functionality as I don't have hooks into the Ideapad team to confirm - but the implementation looks good to me.

Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>

