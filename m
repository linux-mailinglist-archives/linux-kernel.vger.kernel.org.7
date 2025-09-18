Return-Path: <linux-kernel+bounces-822835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E66B84C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 15:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AF9163240
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 13:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F73306B1B;
	Thu, 18 Sep 2025 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GZkbTTXp"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3552C1A9FB8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758201390; cv=none; b=eELk4R+kPy2ra953TQG5tz8QmzWSKdwwO7ycmr4DUXWIPCKkvfTN1V5LTj3KjcKnWnM9Q5Dw3akoclmhdcOARkQN+Qm0bVK3l556F3LJ2clrdBuTuemk71WyT9W8ExZbCMEPOH2Ys9b+sljwyt64EEBQ1L8sO/X9g5nyUxJcFoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758201390; c=relaxed/simple;
	bh=caaQcELfRKwZvcZCiR1uqNEBStSPhyp6hTHcEAa1QDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o73+KQl+oRM8X0rajwxLrlfvpqu3hdBmhlggHxlbeSVsmbip+Hby4QSgnYKhUFcXLXvZn/9pE2wXcTCwTjpn2UBMkifY2/MkK4T3f1J9DBOAyaUBbYjv7nB9vehEuipp1c4nIjaEyU7+HeQ0ZRxg9sWL6unD7miwZ2PEiUq046g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GZkbTTXp; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-30cce872d9cso774459fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 06:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758201386; x=1758806186; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0WgC7juqmgbAQio0JJywI1WVG2osnULkc1KY4lL8rVw=;
        b=GZkbTTXp38LpyrctODlLjjBmE6Lu74Xo0vmaHbeRxmYh/TRYgQDDMQOO2/PH89ETKB
         Vd1xm3XaR7+H8gRHTIXzEtOBMA8ynhYLLjqtK1YdeFXtg4sTrnv3Ukbt0Yogf0Lqmtv0
         jhKazmVKyffxaUwz3TfZv9lfzLt8lAoxO6J+PDuuGLiuT0dG86J3+H3OahfbmHMtlvwV
         kdRMU+0/jCQ6Nmzs34S34R/bvRmGk8b6OVdUQZwVK3cz1uhsbBr/LGmDBWOPUCWo3BIB
         SCi0MpA3+bG6c0qFPXD7nQ86zCM5IwUe+2yqigyC7QJDjC8Nu3HXej+39s4q6RMc79mp
         sGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758201386; x=1758806186;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WgC7juqmgbAQio0JJywI1WVG2osnULkc1KY4lL8rVw=;
        b=KRL4KqYWMmDDG1wb1B5s3KN9zpIB4ZLAtISs7Y6q++4nVF87G6lihOtxTR6jezbSAu
         rw10vWBh0BPKbedQei62zboHOLZWW1RYhvIG+/MHppF3uENLkY4yaL2Xs4UOK37cp2pt
         NH6HjZOtQ4LA79zWjDSKK6IDOuyPBCK2NvTrnD3pdyksTRs+RBRp6R6Nn/coq5c7GzAM
         A6zjjaspKHSUhVgjkvKQcFcavreN7bsWngVLssyMbjuJa1LiYA4kD8FEA1sWbQKnF8IX
         S6xL/reVTAXkI/PG4Oc+pjgHLgdmM+h2/nnyAPD08mgiKt3uOEMo75t3CTyAXUiou25M
         dLwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxir3pC3nueeEv5AIx4J+RUZJTIOhnZyz2nIdR9eq0jhaVsIwiM6xmOdNYfljmrT5ddqg5OkfTuQ7Zsk0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDS2xF+/1+z7L3QwQIbq9aQrUq9YtqMMM/FoFsPOP4iF8w9biY
	2Iy1SxOy1RYLQh65B/G/x0tr2ses67iLUEkdvTtSTg30x0ttIJcKpdcNh8zt28Hv9kk=
X-Gm-Gg: ASbGncseHwualZPZZjuwhNBPgJ6rPPjanzIXdL0Iugdv03y7n04YbHmW2OwF3La3eiY
	nfbE39KUcp0359U4MljTHKNm3jG7f5c0X7YMc8G8UKVb6Ga2OiAt2sqpKbBNpk9lqXc7eK0cugo
	AqkBTSQJViAlsMVwk5Qx3tW/m77+fSUxikQA5YNQ6gHwFH+FBUe5Wr7qLlVMlkI+haCNWg/TojI
	k7gXOvzkMDh5GZJedK3f10wQ4uHHO+b4hzMDdS3roD2KEm5rnOBfyEU9xeLCXmfRL7pDc1L5Puv
	KYXdYAdeSxqi0IJ7ot0eRHWk9B9Rvd5CS9YwnGMddT4XRWdO/WwsYpbSap/aTi4oCV5rjzLmaKr
	yAgejsExEM6dc/1ajUoO18MOGZ5C2t/vUt1McHVxiPGiQQJZbKEy5Iiqmjbc9tsSLiPxPxgL27f
	gFVVKgu4ejuRR5goRAgQ==
X-Google-Smtp-Source: AGHT+IEUCQGYHyBdtLulkOJIEu8D8w32MXls1gv+z2qypBINrBqp/s6q72X2Ugr4LwXXVgu+7F+u2w==
X-Received: by 2002:a05:6870:718a:b0:319:c30d:10ba with SMTP id 586e51a60fabf-335bf5250b9mr2622461fac.23.1758201385889;
        Thu, 18 Sep 2025 06:16:25 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e? ([2600:8803:e7e4:1d00:55b7:b662:4c5b:a28e])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e637ed09sm1471448fac.32.2025.09.18.06.16.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Sep 2025 06:16:24 -0700 (PDT)
Message-ID: <649643ac-525f-4a82-9591-021983b00b70@baylibre.com>
Date: Thu, 18 Sep 2025 08:16:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iio: adc: ad7124: change setup reg allocation strategy
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250917-iio-adc-ad7124-change-setup-reg-allocation-strategy-v1-1-4e17b3de046b@baylibre.com>
 <c0a22d97282f71b2fb946f877e23d410d485d1be.camel@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <c0a22d97282f71b2fb946f877e23d410d485d1be.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/18/25 7:24 AM, Nuno Sá wrote:
> On Wed, 2025-09-17 at 17:05 -0500, David Lechner wrote:
>> Change the allocation strategy of the 8 SETUP registers from a least-
>> recently-used (LRU) to a first-come-first-served basis.
>>

...

>> -	/*
>> -	 * This is just to make sure that the comparison is adapted after
>> -	 * struct ad7124_channel_config was changed.
>> -	 */
>> -	static_assert(sizeof_field(struct ad7124_channel_config,
>> config_props) ==
>> -		      sizeof(struct {
>> -				     enum ad7124_ref_sel refsel;
>> -				     bool bipolar;
>> -				     bool buf_positive;
>> -				     bool buf_negative;
>> -				     unsigned int vref_mv;
>> -				     unsigned int pga_bits;
>> -				     unsigned int odr_sel_bits;
>> -				     enum ad7124_filter_type filter_type;
>> -				     unsigned int calibration_offset;
>> -				     unsigned int calibration_gain;
>> -			     }));
>> -
>> -	for (i = 0; i < st->num_channels; i++) {
>> -		cfg_aux = &st->channels[i].cfg;
>> -
>> -		if (cfg_aux->live &&
>> -		    cfg->refsel == cfg_aux->refsel &&
>> -		    cfg->bipolar == cfg_aux->bipolar &&
>> -		    cfg->buf_positive == cfg_aux->buf_positive &&
>> -		    cfg->buf_negative == cfg_aux->buf_negative &&
>> -		    cfg->vref_mv == cfg_aux->vref_mv &&
>> -		    cfg->pga_bits == cfg_aux->pga_bits &&
>> -		    cfg->odr_sel_bits == cfg_aux->odr_sel_bits &&
>> -		    cfg->filter_type == cfg_aux->filter_type &&
>> -		    cfg->calibration_offset == cfg_aux->calibration_offset &&
>> -		    cfg->calibration_gain == cfg_aux->calibration_gain)
>> -			return cfg_aux;
>> -	}
>> -
>> -	return NULL;
>> -}
>> -
>> -static int ad7124_find_free_config_slot(struct ad7124_state *st)
>> -{
>> -	unsigned int free_cfg_slot;
>> -
>> -	free_cfg_slot = find_first_zero_bit(&st->cfg_slots_status,
>> AD7124_MAX_CONFIGS);
>> -	if (free_cfg_slot == AD7124_MAX_CONFIGS)
>> -		return -1;
>> -
>> -	return free_cfg_slot;
>> -}
>> -
>>  /* Only called during probe, so dev_err_probe() can be used */
>>  static int ad7124_init_config_vref(struct ad7124_state *st, struct
>> ad7124_channel_config *cfg)
>>  {
>> @@ -485,6 +427,21 @@ static int ad7124_init_config_vref(struct ad7124_state
>> *st, struct ad7124_channe
>>  	}
>>  }
>>  
>> +static bool ad7124_config_equal(struct ad7124_channel_config *a,
>> +				struct ad7124_channel_config *b)
>> +{
>> +	return a->refsel == b->refsel &&
>> +	       a->bipolar == b->bipolar &&
>> +	       a->buf_positive == b->buf_positive &&
>> +	       a->buf_negative == b->buf_negative &&
>> +	       a->vref_mv == b->vref_mv &&
>> +	       a->pga_bits == b->pga_bits &&
>> +	       a->odr_sel_bits == b->odr_sel_bits &&
>> +	       a->filter_type == b->filter_type &&
>> +	       a->calibration_offset == b->calibration_offset &&
>> +	       a->calibration_gain == b->calibration_gain;
>> +}
> 
> Why not keeping the static_assert()? IIRC, Uwe felt fairly strong about having
> it.

I thought by now that we had implemented all of the possible
values so nothing else would be added so we didn't really need
the check anymore. But I guess there are a few bits left in the
CONFIG register that aren't accounted for.

TBH, when making the other recent changes it just felt like a
chore keeping it up to date and not particularly helpful. There
is already a comment where the fields are declared that was
enough to remind me to update this as well.

>> +		/* Find the first channel using this slot, if any. */
>> +		for (j = 0; j < st->num_channels; j++) {
>> +			if (st->channels[j].cfg.cfg_slot != i)
>> +				continue;
>>  
>> -	/* mark slot as free */
>> -	assign_bit(lru_cfg->cfg_slot, &st->cfg_slots_status, 0);
>> +			/*
>> +			 * If there is a match, increase the use count and
>> share
>> +			 * the slot with the requesting channel.
>> +			 */
>> +			if (ad7124_config_equal(&st->channels[j].cfg,
>> +						&st->channels[channel].cfg))
>> {
>> +				st->cfg_slot_use_count[i]++;
>> +				st->channels[channel].cfg.cfg_slot = i;
>>  
>> -	/* invalidate all other configs that pointed to this one */
>> -	for (i = 0; i < st->num_channels; i++) {
>> -		cfg = &st->channels[i].cfg;
>> +				dev_dbg(&st->sd.spi->dev,
>> +					"Re-using config slot %u for channel
>> %u, use count now %u\n",
>> +					i, channel, st-
>>> cfg_slot_use_count[i]);
>> +
>> +				return 0;
>> +			}
>> +		}
>> +	}
> 
> I think we could have the above a bit simpler. Something like:
> 
> for (j = 0; j < st->num_channels; j++) {
> 	if (st->channels[j].cfg.cfg_slot == AD7124_CFG_SLOT_UNASSIGNED)
> 		continue;
> 	if (!ad7124_config_equal(&st->channels[j].cfg,
> 	    &st->channels[channel].cfg))
> 		continue;
> 	
> 	i = st->channels[j].cfg.cfg_slot;
> 	st->cfg_slot_use_count[i]++;
> 	st->channels[channel].cfg.cfg_slot = i;
> }
> 
> Am I missing something?

I like it. I should also rename the i and j variables to slot and channel
to make it a bit more clear.

> 
>>  
>> -		if (cfg->cfg_slot == lru_cfg->cfg_slot)
>> -			cfg->live = false;
>> +	/* Find a free slot and write setup to ADC. */
>> +	for (i = 0; i < AD7124_MAX_CONFIGS; i++) {
>> +		if (st->cfg_slot_use_count[i] == 0) {
>> +			st->cfg_slot_use_count[i]++;
>> +			st->channels[channel].cfg.cfg_slot = i;
>> +
>> +			dev_dbg(&st->sd.spi->dev,
>> +				"Allocated config slot %u for channel %u, use
>> count now %u\n",
>> +				i, channel, st->cfg_slot_use_count[i]);
>> +
>> +			return ad7124_write_config(st, &st-
>>> channels[channel].cfg, i);
>> +		}
> 
> nit: I tend to prefer
> 
> if (st->cfg_slot_use_count[i] != 0) // or omit the != 0 part
> 	continue;
> 

Me too.

> ...
> 
> - Nuno Sá
> 

