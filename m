Return-Path: <linux-kernel+bounces-794611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1732CB3E3F0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C07E9480C25
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD63014AD20;
	Mon,  1 Sep 2025 13:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FDQ0GLiH"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964C84207A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732110; cv=none; b=bzjqiV5GNOa6hxACFa7knCtTPml3rhjQCJmA/UYhdWi7vOZ3v0p69WkiLqZKNL7+N81CQIfmz0fDdHsEferXWkY6Ed1JBRZbX2/qv0QF4JEQ4J7hUwaQFWKG23+jh1JNPvdaX10JHhxPQKqYceicIlYruYzD+q2qLFqd39Pjl2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732110; c=relaxed/simple;
	bh=Gd3KXw1QQlS7MLd0apcsH+QWeJY2pnkwbuUIF6wyLYg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GI11HsaqamrNWwcWhTpWvoqXRrMvwEpnwaDcsT8zR7s+RbiZkA05CxWzyE0UU9/edOX0MbgGIoq4QaUEUslM2CWJn56E3yR9ocJa+4+kW0gPUnOFIrvHx6uEFcujYNxtZ277EKNxY7TvpDeP9L0LjIcF0WCSxRxDAuMJ+pz2Q4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FDQ0GLiH; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3d19699240dso1499347f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 06:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756732107; x=1757336907; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DaBqxA3nVfiucrNs4TUyEScLqswLf3VZ8Gyi43Fij2o=;
        b=FDQ0GLiH5ReyyfY8Z0hh47RtOXqMZI3pEFd1osVNuKWJa0/QYYNQGnCSZ4QY51S/WC
         YQkfniGAyaks7U5/23sYPiNn7QKs5icyabCtITVXZ62DFGrGvQ8g4xKisxoEbtJIHHoK
         1dFW5yNW8QImb4EJmM5DDYiMN0G6yneRs4pubkTO9CU9ISLTibIIx7eHzJBDD2AOJzNv
         8byGD5aHihB7ZXE57wb+xoc6mQ0pt1S8XwpF2M5BCPZqaIVoJAoBujkQCzYSt1Ma5nVG
         eFerR6n+CdLUmgLlQzgNPe16+gVW8SoLOA/A6GfAxC+jOZe8e47P5LoFWCEXzBAxzzTe
         epow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756732107; x=1757336907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaBqxA3nVfiucrNs4TUyEScLqswLf3VZ8Gyi43Fij2o=;
        b=nwD5Hrja9DDa0G8806/6pof2phDu5MIFoPGhxidyveZoUJH419F0Qfe9UYkmEGN5Ig
         9vN0GqC++PhLUbZ+6oWaBekYT1NohObKMPTrn3Kdju1G67C/tIj8aThry/3NJdoSTw35
         IaUq05d4ssDdpRucK6n+ZwUjP1tUH5O4iV8xaJL8Q1Sj2n5A+HWbvLfkuthjjHBEMyvl
         FzobFhA4/RCc/06CvYYsXm46AulZOfKOJnoDPg+T2jEDbesDAzUhQR8zmPbO7QbxRTBm
         DNtQkb7fvPjY2x434sJMQYxkBl4C9o0JeFTA2UR9yvdkQvotZmrIkc41ThdE/Fy9oJ99
         2LUg==
X-Forwarded-Encrypted: i=1; AJvYcCXOuGYhN5LBSrOldomQ6oOJG/9L4GY4g5p1XirbpgviEbRNeeKZx77SU7i3c2x2nhVkDK4DHmKhGDIPBN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpk1G2io5HTyTbqGZ0ZoVFwExYVh7XE0ZIbjPJ6pwoC7aA3viT
	dR0bfrBANTREcTFCAZJVYzTCMKEiWOpkcVadFjsSW5ip1wg/nP13k3PFdqY7dUthpC4=
X-Gm-Gg: ASbGncsXf+6E2SrE58TDl925nsCn6M+yec0Xx9qGtpctb2xKEUZrdctZd7f86rgu+aC
	2dOqN2Umx69h0F0P92b/GynDbeNiUZDbdRFiQIbTnbm2pSvdMQR1iOhsaUB9bcwgR6aKuy3cFly
	B7lGmQ8RVrV6YTyWQPYHI+vYXQ4p04510H2gpzSg1YKd7jl6y83wS1dFFjEJzaYnLTGGpqZ91xQ
	RPtAg2VuC9ODlyd4sjIu/sRoGQCM4qeysBSNEHy/PucljV/hIjqmo2KdN4z3EiveyKAIuhnJWr3
	7ebV6tfL8B0XLpD+JKEgUgcijNB0BRfgpnPyFHx2K/K1pETlim1GAEosyP/UexLLuCDzS/dRokS
	drxkiYBMBwM5X2wREghIIa3+gYJoWRSCxycjEQw==
X-Google-Smtp-Source: AGHT+IHoO22NHnLmGCEAuykdmrXfYz5c61cYkp/gae0iHULEguoVzXfknO0ldVQ3ZbksBt1rycB8NA==
X-Received: by 2002:a05:6000:26d3:b0:3c8:2667:4e25 with SMTP id ffacd0b85a97d-3d1b26d6cd7mr7464741f8f.31.1756732106826;
        Mon, 01 Sep 2025 06:08:26 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cf33add294sm16137899f8f.29.2025.09.01.06.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 06:08:26 -0700 (PDT)
Date: Mon, 1 Sep 2025 16:08:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mohammad Amin Hosseini <moahmmad.hosseinii@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: add mutex to serialize
 SPI/GPIO operations
Message-ID: <aLWaxoBLEVWlfzN7@stanley.mountain>
References: <20250901065445.8787-1-moahmmad.hosseinii@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901065445.8787-1-moahmmad.hosseinii@gmail.com>

On Mon, Sep 01, 2025 at 10:24:45AM +0330, Mohammad Amin Hosseini wrote:
> @@ -200,7 +204,9 @@ static ssize_t ad7816_store_channel(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> +	mutex_lock(&chip->io_lock);
>  	chip->channel_id = data;
> +	mutex_unlock(&chip->io_lock);
>  
>  	return len;
>  }

Unrelated, but what is the point of setting chip->channel_id to
AD7816_CS_MASK?  The only time where that is used is in
ad7816_spi_read() when we do:

	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));

So it's something in the hardware spec, I guess, but it isn't
documented.

regards,
dan carpenter

