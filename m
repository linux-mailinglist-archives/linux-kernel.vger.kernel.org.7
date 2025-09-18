Return-Path: <linux-kernel+bounces-822953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 501E9B852BE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7831C871C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5017530BBB7;
	Thu, 18 Sep 2025 14:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huI2qQ0T"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C6D2236F2
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204446; cv=none; b=s+noUwKnDe84eedJWO8Qk9z5H475lHytDsGVbguph6m9h7IaUrMc92qwLGe66++TtrMAIlsXbhvt5w0Bnf+DtpUhABx0PwMMbcjtglL9/pQH+BVm/7k1/zSTS+K3l2gQD2RKupOh4DFq4NtM41jhF+OeITZRMAMTi1yp5bn8kVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204446; c=relaxed/simple;
	bh=TtaMkorK6y/ViD3v4dH2n/FXURQ95Hfn288XMWkH4w8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p1Z1d5DpsuVdQKr2l4784r7DBfdQG3Z8bwI7ECW4ze03jgKGwsQtRsvqeERZnKj70Xb6AX4jZs9klekxIMehuai1oc9biTxqCBYuPjelsR9+X/L1MsEvtBKTTCVpUCTgjcen0t618pFZvViqsg7gCK7h5C+v4MmjRJpfwXy6TZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=huI2qQ0T; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3eb0a50a60aso673319f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758204443; x=1758809243; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AeLknM6GuG1stF03g8JSLkIXNteDhdcQSt5KI463r4s=;
        b=huI2qQ0T8x5drdHpdnL1ULCbeumsDk4xhPf1AhgKv2GCNBdTaoxhHsTwuHYWTfwVuD
         U+cOYssW5VbEATCVG+sBjUmosm19BmoPml9k+5P0pooZH11BJTg+XM111wHRMYgmEFtR
         Yg3YSvkXwn7eL2Vu4+iIuVTyYpU9QGoy0dXYNA/X8lXRhUI+AiS776J7zUSaVFfGbj+z
         84LYejpxmt0jK3SYx11ypwCAkMGi/ns4O/aCHh3Pr+LbAcLC5cdh7q7nOF9s60NZIlH9
         3FTYrNObfAIDWeJFQPY9uqVPHCLkWamMIYxuQOYNPTVHEzufpC+2eCInIhwcy3m9BsSD
         pOTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204443; x=1758809243;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AeLknM6GuG1stF03g8JSLkIXNteDhdcQSt5KI463r4s=;
        b=SNySEozzQiF1oDpVMIyy0Sh5dR+up3qNxosr56j2Gjjj5l2Af9Yg2TE04nGQaVETKm
         3Ox2wIQWXF8/+eNJ+CEbtmlWv79jADEsRZCI+xkZcOx9qpYlP4UYj2rw4XPP3cE327Uy
         l8m1GRtaOvz42eAUusWQCmAdjVmQiQRg/YpCb4DSchGTX5GhqaRU1XNoiWSfVsfQqqgZ
         gzGZJhD/ELDT1S/yzGR7Ac4R18hp4caSlv9sgwJldH1dbh2D6PjGeDYqZLonHV/+kcgy
         t3VFjXvXcP+Mpqi1Sm90TA60y67Qe/vw9CtJHcCJfkklnr54arc+k2KSGmwGVZbbVVGJ
         WG5A==
X-Forwarded-Encrypted: i=1; AJvYcCVlye3ykB/CzLviHpncQjYzAwsqRIcj4jFgpdyTiunUG7Cc9FjVpcTy6A4xzjTku7X+odR6IaddJmsO3mU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wbX2lDk8bb+4K9S/ObPNNfBNu3rIQfRYO66gZgXyjyoWV8RQ
	t/+D5thJM7vy8z/qV5R/Td/mkGORT16tWLiSYVAKS1gLcFIXadiVjnqa
X-Gm-Gg: ASbGncvafP112wKkbBsR7HP7S41jhBO7AOMQJl8B2waRX7l72X3pSyNzakvPf/6jTDE
	nX3BchhYouASR4cF8Ay28B5lMnwvLyfv+zCfLANwXzkPYHJ6n4O2LtlDCn0/khkPa9EZ6IhGq4N
	kJKIa45TNo87MIdycWMYn3P0Sdua0cwu9ySFCIXYY4kaj3ltWjmdM0GD5UJm19+KGIkT8OTSNvp
	iCbE3cnjz3Hrlbf55UdGNnKUH4L6F1QSOw/AHGlVUiuKhJfkAVZXph9ltw2K254rca7Bik4SOpF
	TRhr6AhitO9vGCh+bnqL4p4jP/LPaAo+Vu4RYCcAP0xYS/jwR04+YX4cE3OsbD1l85F//0+N8YH
	biRBLqwXtClaDFWDisdGXnLs/Rjzq3r+bOiCbcTPomciQPZ/yO+84
X-Google-Smtp-Source: AGHT+IHw1wRaMktc687AhwO2IhYmWFpTzAk/5SOs2fVSHYFRb+rEV7EYji2faH3d7fjaCU1a7rGnXw==
X-Received: by 2002:a05:6000:2486:b0:3ec:1fff:3b25 with SMTP id ffacd0b85a97d-3ecdf94a43cmr5556954f8f.0.1758204442546;
        Thu, 18 Sep 2025 07:07:22 -0700 (PDT)
Received: from [10.5.0.2] ([45.94.208.151])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbd64dbsm3658315f8f.50.2025.09.18.07.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:07:22 -0700 (PDT)
Message-ID: <8f412c82cfd511b95d4b19a70d86d151ff666d1b.camel@gmail.com>
Subject: Re: [PATCH] iio: adc: ad7124: change setup reg allocation strategy
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 18 Sep 2025 15:07:48 +0100
In-Reply-To: <649643ac-525f-4a82-9591-021983b00b70@baylibre.com>
References: 
	<20250917-iio-adc-ad7124-change-setup-reg-allocation-strategy-v1-1-4e17b3de046b@baylibre.com>
	 <c0a22d97282f71b2fb946f877e23d410d485d1be.camel@gmail.com>
	 <649643ac-525f-4a82-9591-021983b00b70@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-09-18 at 08:16 -0500, David Lechner wrote:
> On 9/18/25 7:24 AM, Nuno S=C3=A1 wrote:
> > On Wed, 2025-09-17 at 17:05 -0500, David Lechner wrote:
> > > Change the allocation strategy of the 8 SETUP registers from a least-
> > > recently-used (LRU) to a first-come-first-served basis.
> > >=20
>=20
> ...
>=20
> > > -	/*
> > > -	 * This is just to make sure that the comparison is adapted after
> > > -	 * struct ad7124_channel_config was changed.
> > > -	 */
> > > -	static_assert(sizeof_field(struct ad7124_channel_config,
> > > config_props) =3D=3D
> > > -		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct {
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 enum ad7124_ref_sel refsel;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 bool bipolar;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 bool buf_positive;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 bool buf_negative;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int vref_mv;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int pga_bits;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int odr_sel_bits;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 enum ad7124_filter_type filter_type;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int calibration_offset;
> > > -				=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int calibration_gain;
> > > -			=C2=A0=C2=A0=C2=A0=C2=A0 }));
> > > -
> > > -	for (i =3D 0; i < st->num_channels; i++) {
> > > -		cfg_aux =3D &st->channels[i].cfg;
> > > -
> > > -		if (cfg_aux->live &&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->refsel =3D=3D cfg_aux->refsel &&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->bipolar =3D=3D cfg_aux->bipolar &&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->buf_positive =3D=3D cfg_aux->buf_positive =
&&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->buf_negative =3D=3D cfg_aux->buf_negative =
&&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->vref_mv =3D=3D cfg_aux->vref_mv &&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->pga_bits =3D=3D cfg_aux->pga_bits &&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->odr_sel_bits =3D=3D cfg_aux->odr_sel_bits =
&&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->filter_type =3D=3D cfg_aux->filter_type &&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->calibration_offset =3D=3D cfg_aux-
> > > >calibration_offset &&
> > > -		=C2=A0=C2=A0=C2=A0 cfg->calibration_gain =3D=3D cfg_aux->calibrati=
on_gain)
> > > -			return cfg_aux;
> > > -	}
> > > -
> > > -	return NULL;
> > > -}
> > > -
> > > -static int ad7124_find_free_config_slot(struct ad7124_state *st)
> > > -{
> > > -	unsigned int free_cfg_slot;
> > > -
> > > -	free_cfg_slot =3D find_first_zero_bit(&st->cfg_slots_status,
> > > AD7124_MAX_CONFIGS);
> > > -	if (free_cfg_slot =3D=3D AD7124_MAX_CONFIGS)
> > > -		return -1;
> > > -
> > > -	return free_cfg_slot;
> > > -}
> > > -
> > > =C2=A0/* Only called during probe, so dev_err_probe() can be used */
> > > =C2=A0static int ad7124_init_config_vref(struct ad7124_state *st, str=
uct
> > > ad7124_channel_config *cfg)
> > > =C2=A0{
> > > @@ -485,6 +427,21 @@ static int ad7124_init_config_vref(struct
> > > ad7124_state
> > > *st, struct ad7124_channe
> > > =C2=A0	}
> > > =C2=A0}
> > > =C2=A0
> > > +static bool ad7124_config_equal(struct ad7124_channel_config *a,
> > > +				struct ad7124_channel_config *b)
> > > +{
> > > +	return a->refsel =3D=3D b->refsel &&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->bipolar =3D=3D b->bipolar &=
&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->buf_positive =3D=3D b->buf_=
positive &&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->buf_negative =3D=3D b->buf_=
negative &&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->vref_mv =3D=3D b->vref_mv &=
&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->pga_bits =3D=3D b->pga_bits=
 &&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->odr_sel_bits =3D=3D b->odr_=
sel_bits &&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->filter_type =3D=3D b->filte=
r_type &&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->calibration_offset =3D=3D b=
->calibration_offset &&
> > > +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a->calibration_gain =3D=3D b->=
calibration_gain;
> > > +}
> >=20
> > Why not keeping the static_assert()? IIRC, Uwe felt fairly strong about
> > having
> > it.
>=20
> I thought by now that we had implemented all of the possible
> values so nothing else would be added so we didn't really need
> the check anymore. But I guess there are a few bits left in the
> CONFIG register that aren't accounted for.
>=20
> TBH, when making the other recent changes it just felt like a
> chore keeping it up to date and not particularly helpful. There
> is already a comment where the fields are declared that was
> enough to remind me to update this as well.

I brought it up because I remember Uwe kind of really wanted it (or maybe i=
t was
requested by someone reviewing). Not sure now :).

I'm fine with removing it anyways.

>=20
> > > +		/* Find the first channel using this slot, if any. */
> > > +		for (j =3D 0; j < st->num_channels; j++) {
> > > +			if (st->channels[j].cfg.cfg_slot !=3D i)
> > > +				continue;
> > > =C2=A0
> > > -	/* mark slot as free */
> > > -	assign_bit(lru_cfg->cfg_slot, &st->cfg_slots_status, 0);
> > > +			/*
> > > +			 * If there is a match, increase the use count
> > > and
> > > share
> > > +			 * the slot with the requesting channel.
> > > +			 */
> > > +			if (ad7124_config_equal(&st->channels[j].cfg,
> > > +						&st-
> > > >channels[channel].cfg))
> > > {
> > > +				st->cfg_slot_use_count[i]++;
> > > +				st->channels[channel].cfg.cfg_slot =3D i;
> > > =C2=A0
> > > -	/* invalidate all other configs that pointed to this one */
> > > -	for (i =3D 0; i < st->num_channels; i++) {
> > > -		cfg =3D &st->channels[i].cfg;
> > > +				dev_dbg(&st->sd.spi->dev,
> > > +					"Re-using config slot %u for
> > > channel
> > > %u, use count now %u\n",
> > > +					i, channel, st-
> > > > cfg_slot_use_count[i]);
> > > +
> > > +				return 0;
> > > +			}
> > > +		}
> > > +	}
> >=20
> > I think we could have the above a bit simpler. Something like:
> >=20
> > for (j =3D 0; j < st->num_channels; j++) {
> > 	if (st->channels[j].cfg.cfg_slot =3D=3D AD7124_CFG_SLOT_UNASSIGNED)
> > 		continue;
> > 	if (!ad7124_config_equal(&st->channels[j].cfg,
> > 	=C2=A0=C2=A0=C2=A0 &st->channels[channel].cfg))
> > 		continue;
> > =09
> > 	i =3D st->channels[j].cfg.cfg_slot;
> > 	st->cfg_slot_use_count[i]++;
> > 	st->channels[channel].cfg.cfg_slot =3D i;
> > }
> >=20
> > Am I missing something?
>=20
> I like it. I should also rename the i and j variables to slot and channel
> to make it a bit more clear.
>=20

Sure...

>=20
- Nuno S=C3=A1

