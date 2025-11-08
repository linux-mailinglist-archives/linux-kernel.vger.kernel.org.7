Return-Path: <linux-kernel+bounces-891674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C585C43392
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 20:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 897224E0716
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 19:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16655279334;
	Sat,  8 Nov 2025 19:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cIOCembX"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5DB2557A
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 19:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762628661; cv=none; b=T1DwvJEnAFKsagvUaWxAdp+BN9rSddKi2JI3gsqy9qdEAnH05ZYV8P6133+G/uEcaRJJMP1doyNgkrO0gYgYmq5+IhMRtcko+wN18hB+842QC9Rl28+w2sR1C05qi7dgBOp2YR1sD5qNiwc+j/VALM8t6ye/hpRFTtiwU/c8CmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762628661; c=relaxed/simple;
	bh=ZnXCe3slB/+La9FFt8FMvzhu8yXnuS6lOiGVsn0Cuuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVqkzc4nVhfSGdhCowzrIrRm/QLfiFQMwJQ6+FVS0UDzjvdjxV9HQBvjWpJ5RPpXeKyObiW+Z4Q37LeOxfgy89y9eeGY/xINChkCKwf8iNCVOw+YfW3FQbSO14O2o3KKl70wu2YHBes6zZfETXuc4oMJ9vmqN2HKHnPtfHS4zuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cIOCembX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29633fdb2bcso18453555ad.3
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 11:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762628659; x=1763233459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dzMLE3EYtbU4A3oZ/jZyZMkI9O11eehJl7ny+5w5lfI=;
        b=cIOCembXDk8uM33Klxu8PbQ+FB75frZVCunbWvqXnSwtsdDmmFmuytBm5Jo5OZoa9U
         VhbPPgEOkNIgJgmzqmA83dbkwrQjVMi72KL2U/ZqYQxGT+wm1SwIAlQu9lMGyHvJVerP
         q66U2KBVPhow4dB5VfDmHBFv6UcOR9TXJ9xG92gjAc9ZPhNv3NA6HxmtgsYvwharuoDg
         KKYj1889kUtgoVFlvFDuQoXYPxd5TicozXv1HZz3TiwWLMaYO50ryyAefuZmphGT0GE9
         frLXeeSmHuc+dCreKS66UtLbuDCqRm3KweRWmZWSc5+oXj6MOpu1RcF7iMv5Aov5VVVU
         Dl0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762628659; x=1763233459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dzMLE3EYtbU4A3oZ/jZyZMkI9O11eehJl7ny+5w5lfI=;
        b=X/TS5KZb3QlJDo6uATUJ+g9dmAc2ulZ40B4HxFdFQx+Bgx7s0FKrVOQjd1BHjusx66
         by1bt/JhFUTV1NtzHG64P7ZZc6jOad/fD1GBE0g/uqnriDxoQh3Vjt91OU3qYCgEJxUs
         js7V1NDAYCK2hvHxXGISZWm8ysWDk65F7LE45rrgdK7G9mK7MmpRiFqVQTyRSjggUqzK
         F0+ePd9SeW8uN25wzvOWioEmCAtPOCW7G0vb/CG9/JsmAWTehajuoMBMXXv1DwvIa8Nc
         1HBu8SDEr+/mfxwFG1Vu11st26XLTS/GiTV847NC+OK9rogS0U3OwVD53hhB44/vcivM
         qF7g==
X-Forwarded-Encrypted: i=1; AJvYcCXI9ESFcCZLMPnhuFNSwSy8fBxpWvijKjRHGx+v5GfkLGojmUxK8QgbSfjvtJnIe8m5N353sMhAu2i1BqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAlsjRdKeUD699GchPCT64ceR4M/Rq1weETd77Jllx8IQ2ou3Z
	TWreqg0VDwfLhBsCEJ5rU1i20It9PAbdT/LGIizPlvtVMxldBaJbaxIT
X-Gm-Gg: ASbGncu3sf7lwOkwCOQ4g0pPc8lQJ2aNczIcYinmYLRIAJPTkQnCohPl3UmWO+VTJQK
	8bUyNzsN8AmyBPhflvW9QXhVi9LnnX0v13LHTbWf5fC5Np0lHaGDgrhcy90eG0oU45P4OqUlZ1x
	CQKa4Zifqv65tTMwNr4yYkzIWyq183DWEgTaQ+PzXuJWJmenIwUabOAgNZfdYPmjo9UOF9YxHtP
	30oodg2zbWzBP5RHA7jajL5RUsBEpxRY6jGvHAXKAQOQhde/jRUY/tbffoDk8utB3B2KYjVfCTa
	PdnhlJHucg4S4UnADDd0yEAJD31dbYoFAu0RfWuzqh9WJ1uh56rsLIeFh537LqvEtNs0NHiahtA
	Arke+7JB/ZDhzBLsHFZdOLhOCFL+xmy5qbdBvs04q6ExyLkGyFyfsnZfkVquc3K8UKcvB15xYAa
	LGlgMMrK1Md2p9RMipxKMV
X-Google-Smtp-Source: AGHT+IEztg+YPHMPHcH6FjnzLW/Rc12+PWWrybeAs007JujoskqVttmiPI8dUMgJekSCdSs3mWNweA==
X-Received: by 2002:a17:903:2c06:b0:295:62d:503c with SMTP id d9443c01a7336-297e5627aecmr40584265ad.16.1762628659396;
        Sat, 08 Nov 2025 11:04:19 -0800 (PST)
Received: from localhost ([2804:30c:1661:8a00:578a:911c:ac25:24a6])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29651c7445dsm95293565ad.62.2025.11.08.11.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 11:04:18 -0800 (PST)
Date: Sat, 8 Nov 2025 16:05:34 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: mpl3115: add threshold events support
Message-ID: <aQ-UfmTkRX75BOfg@debian-BULLSEYE-live-builder-AMD64>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-3-apokusinski01@gmail.com>
 <aQ1Rdcbi3e8lzOvM@debian-BULLSEYE-live-builder-AMD64>
 <20251107220106.ihk6e46paxmyfqgg@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107220106.ihk6e46paxmyfqgg@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>

...
> > > +	switch (chan->type) {
> > > +	case IIO_PRESSURE:
> > > +		val >>= 1;
> > > +
> > > +		if (val < 0 || val > U16_MAX)
> > Alternatively, could use in_range() for the check.
> > 
> > > +			return -EINVAL;
> > > +
> > > +		tmp = cpu_to_be16(val);
> > > +
> > > +		return i2c_smbus_write_i2c_block_data(data->client,
> > > +						      MPL3115_PRESS_TGT,
> > > +						      sizeof(tmp), (u8 *)&tmp);
> > > +	case IIO_TEMP:
> > > +		if (val < S8_MIN || val > S8_MAX)
> > this could also use in_range().
> > 
> > If you opt for the macro,
> > #include <linux/minmax.h>
> >
> I see that the in_range() macro operates only on unsigned values, so
> placing it here would be wrong I guess. In order to keep the style
> consistenc in this function, I'd keep both checks as "val < x || val > y"
> 
Ah, good point. Okay, no objection. 

> > > +			return -EINVAL;
> > > +
> > > +		return i2c_smbus_write_byte_data(data->client,
> > > +						 MPL3115_TEMP_TGT, val);
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +}
> > > +
> Kind regards,
> Antoni Pokusinski
> 

