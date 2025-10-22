Return-Path: <linux-kernel+bounces-865600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23460BFD91E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D0A3A1EC0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFAF275B16;
	Wed, 22 Oct 2025 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJpXCiIu"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0BC2472AA
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761153531; cv=none; b=URQUGZwLflaXLWwDATWhbj7T/47aAA2nL64AciVaAy7/qrR9dmWKoAGvQR43WnnBztqWeq3Len+2SJ60aJPN2AM4gzhlkduHcr528h8VP/8w7p0IJWVG7Mm/Kq1isYywoH/PyF4e5qDQFmesX66m3NFleRu+mZ/+/gfwpmn0HIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761153531; c=relaxed/simple;
	bh=9nDv38hCGbawjqulRgNJdaybqnPPjLmt1oHyNKm03DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOICg6YULwD/AL+2EnaYlaaAgRFk5YMJWySJMIKSGcFP4/FIB/J46fX+VZqTpp3DksAHPqKmrYrjpqJkAWqgL/0SvS4iMHdv/wnD3hOUE2WKE9SbCIIEOnznkxVWvie3oRf/lVEwX+MLvyh6HSpB5zr4jmtDhaEXejSUtTaac2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IJpXCiIu; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-426ff4f3ad4so3849355f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761153526; x=1761758326; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UZd7NXk0kvOiCANiny7CPaVuKiR6qb7JU5QnvdLSwI4=;
        b=IJpXCiIuwGLquPR66mO3rqLU6wRoWvaCBrp0PYqwIMGOWBCEMaP26aTpmAligg/ZID
         shcPxnvCC10FNeGvdRE6E5DqPbs9YEPIyna3hlVKv4ObtF+n3TwmO+1kvBdVPDby/qZW
         6lfU8FV92aEsJK/I2btdiGlFwOWNCg93rlI78yQ0MFg9A7cN+xdmNBQOI9eUQFEGbVSO
         +dMr/vwTM3bHVrFkKjVHxSh4A6duvVU55fyyZtoTYXbcfUIr9yX/9Nybag1xPzBvKEZw
         yJ8MXKsExDNEZkeKKEjEjD9JtEPC/tpzwMNuXDC3VTn8xaWXHqB+cFAsRQlBYuxDr4HV
         w4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761153526; x=1761758326;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZd7NXk0kvOiCANiny7CPaVuKiR6qb7JU5QnvdLSwI4=;
        b=Y2abzWD22+8xabtdA9b6HkQDMsZ69baeDtGqpDtPc0wkviGXPNcKQh9jOti4UyMvLT
         PmoZ+lAILYR/mBIIQ7J4HOQdYDC98AtcDDqmomBE+jfjxgHK0mehnLfXJi1JQvdxfhUg
         /zQ++/1TOGbfciv+XZs8ehuieuR361hz2HWMMX/ela/eukUKGSbqev7iVCw4RiC21HkU
         lP+b/rMvSimLVCeZAvlF2aYPVAibSPEwHAKay8VOXMJ+b5pqQAXsGDgmdD5SE6jSdIfr
         Z96Kb08hjeTSaJ5C9TJhscL8T1X0JZ1po9sXgLiujcJGNcquGpc2zcQQ20wc8WyBC95U
         E7Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUUQejzImvtkkFr4aWmu+HREGvgsHnkp20LiVoifyDQLoClSfd1qh1haXJnI+ULviKnA32BIt4wSilUBEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY7A27wiNZQ4VXSmHRlxqD8LFLP/t+ccRcT4bH3HxoW2puqP/e
	JosqAARhI0dmlV2RA3rzpohdhXe7mLQOUVzataqrNxR1GBuAajMUDGu+qdSh0WxcwHc=
X-Gm-Gg: ASbGncvMk9ux1Jqp6S+0/ZIY4rqBX/nMTMMYN/YLk2SpDaptZE/lx5NihRp9LMMpuWw
	PmJ4/fevv3PidqrowSEWccwXMswu8e+/kkEpwYnMmscpVAo2Qp/ImLlmRZm/mr7v70FT4Bf2NFB
	yklr0htdzdW1lTEP0b5i5H9BHuvxGD/HDNEcW79+LxrB+gO22DXTWylWeFo3sPCvngxRzVvaj9u
	uY4GohkV9s1ljiOMZr7YYY0jY5vYtTKlpG7vkdx4xm/QTVlUV1yVUctJyeK85Zs6/6A04PUU0MA
	1N7l78IdFoJcO86IaHvatsu4A02UG+kzJRVO3hHxh2yvJXl1H+epFDhIrhR5RrSRcqiq9u2uuuU
	VmVX4olt6OB+4jptpKaFHnkjLaBUWI2X0+srURoQrcEaIMB9E/tX33vPlZITovF92t4T31QPN6+
	21t550YU8ua75yTMsp
X-Google-Smtp-Source: AGHT+IF/18UTLbuAPy5mzziER/Bg1lMDCNNls6lTgLx/+erLteq4Yb3HlU/Bpe27lriZCde9I0QYvg==
X-Received: by 2002:a05:6000:605:b0:3ea:c893:95c6 with SMTP id ffacd0b85a97d-42704d86b82mr13969661f8f.18.1761153526491;
        Wed, 22 Oct 2025 10:18:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-427f009a96asm26486677f8f.31.2025.10.22.10.18.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 10:18:46 -0700 (PDT)
Date: Wed, 22 Oct 2025 20:18:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: David Lechner <dlechner@baylibre.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7124: fix possible OOB array access
Message-ID: <aPkR8imukdrZLdfk@stanley.mountain>
References: <20251022-iio-adc-ad7124-fix-possible-oob-array-access-v1-1-2552062cc8e6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022-iio-adc-ad7124-fix-possible-oob-array-access-v1-1-2552062cc8e6@baylibre.com>

On Wed, Oct 22, 2025 at 10:15:05AM -0500, David Lechner wrote:
> Reorder the channel bounds check before using it to index into the
> channels array in ad7124_release_config_slot(). This prevents reading
> past the end of the array.
> 
> The value read from invalid memory was not used, so this was mostly
> harmless,

I didn't spend a lot of time looking at the callers, but an out of bounds
read will cause a KASAN warning at runtime (hopefully) and if the page
we're reading from isn't mapped then it can cause a crash.

So, it's not like we can exploit this to get root but it potentially
could be annoying.

> but we still should not be reading out of bounds in the first place.

Thanks!

regards,
dan carpenter


