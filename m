Return-Path: <linux-kernel+bounces-889645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF76C3E227
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 02:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3184F4E6E3B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 01:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 547672F1FE1;
	Fri,  7 Nov 2025 01:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GfjFUcUX"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B5B2ECEA5
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 01:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762479157; cv=none; b=ln1BqEQM2RKXe4LEWWt/imtXWftWPaBF/z3XL6pVDpvqBAJfycfwyuBEH5U6XQvLwzpHpWwQ9+35a42+oMqaBAsfZNSP4tscKsLT3WeU0cYxj+M+5R6aINKyoGks+fEjD7J3YhJoEV8YtEFn7OlUmkuRqobltavyIbZUiH4ryEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762479157; c=relaxed/simple;
	bh=/Rc1S3UgMB9WnXm0w2Pdmn1pVdbwQaIgK4COQB6l498=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUyby3Y3rSYZCwssCctFNRav6y/b/rT4U4NXS9qwebiO1Va6Aqlyxv7jKfkw6FV9ydnnbh7SwCYaFt/u+tmvdVqctXhaHiH21yI6IvQD2UEt9IfUvI99eqPRX0pshWik6IE2+mAJy9/E4X/Y6lSQpfskIYHdOOLR+GocwUXCNIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GfjFUcUX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27c369f8986so2071885ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 17:32:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762479156; x=1763083956; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x4bXmwmarcggMBeI4uAlHgK7+FsvVPN4ytmfUmRpIcI=;
        b=GfjFUcUXJd2gWMs90LeppObIEwcdOlGjp7EWLi4Oi4QpoM54blbQPs+Pn96ItAcawi
         Pv4PzO4iDMzP8ncFDqPewP0VxgM1cCs5/ZCpCvEmEDw0gPLZU6bsgiqxO/DvSIjC1G5z
         4HPW0BSRAAWAbmrf6MjR0q8rpNjwDwDe5184Ng/wB8LhT+foN9dOkmtUq8NXegTPd1Ih
         iru9b+9optPDlgu1z0AEjjzlSIHm6cF6alzfpfxXH8wj7+sZfVAIxDljW/9ITdvVg+ZL
         ClulIE8Q8G0VUgi5tPL0BjNYkcTs6RC00YkKI/C6tVdACOvOw3a7LiCc0pHUlfUmsSI/
         +3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762479156; x=1763083956;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4bXmwmarcggMBeI4uAlHgK7+FsvVPN4ytmfUmRpIcI=;
        b=uDUmFGVIqTpPPfjZLVMJa+8CznExwoPJOch+B+RBufapNK1eTtTM+BSDUmC7kaj5xz
         yvqa4uKMRzl0N5fR3pn70VPEcOijN1h5DSYQbpMXcNG3HJP6CgjmFZNBFO7reQ9WYhvu
         asJ5z/xyQuIq5DTIPrQIfgMWhlGp6zCnFwqsfjkUQ9U5sKkJBU/5lKhnGelzXGGUhzeR
         pjhz4VYmqYrmcieco5o0C6kTholxRADTTNjwg5FLcJ7IDLfBLEzqy9v7ZG1cu7MOr8xj
         C6Cd9I84UhQyFxCE5B1OhQQMaHCulDCqW4Va2qXMLTOwOANxRZ0jmaUnez2VPMREB3ys
         c/4A==
X-Forwarded-Encrypted: i=1; AJvYcCVrEP7uRy5EO6IzN8tjUItITnWKbsJhVcGjHgwMH1NXJpeNAyWYK5WYBVYXTtcBk7nv/HI+bMpbmWT1Tb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxsajx+lD+9MseI4/bS7pUpsfdJ5VTL8NemIJ2lIGIGTKoFvh8Z
	QzCG9VpCFwHFMxquPIEgZ1SUjry/r/TyKMjZ1sCCwakY0fydmqCFqZIj
X-Gm-Gg: ASbGnctvZz73w8sqKoX3kbk0f73dlMxs+DrLJQn3LPOSInOiNcTocFxPVaXU9VupsSp
	glOJOGEf5eS19YR+vTvGOF+NLWXak1XH+J1GxGmoCZUaHwyBnMSAnnNeijzXR/1ELJIdI+zxnAI
	Aid3JzYkDyVTmpTk90l/l53SDYos9QXnnhOPRMsY7FzF+W+s1lDbO4icbwBo+e14LvCdc0/aQDL
	MhXQ0OWKxBcpre0lx8bOia/tO26G0SJ7YdllDOxUSO5IksZSQAqy5arxorqHq7+EPLyN0fmgdJb
	x8dEsAwZRc5jK12E40lkCXlKYgXjeojqlpjGplba2Nuc1Dg2ITzFdWIunbmDZnzdfAKV8SEI0Of
	jBI1CIZZ40AtoBmN5UVdgiNVpfrtIqCToc7iItdWKAhGGFepbE0j6z6eOHC1+puxDUX4NDqgOPA
	3ERbztUPpwSIp7zYIM5BuR
X-Google-Smtp-Source: AGHT+IEuOb6MZ6uwRqxv2u8kDKX7WSQVhjNXmCgCvwECDb39/Us2vO+phB5ffphUcz+ot/sBsdLRfg==
X-Received: by 2002:a17:903:f8c:b0:290:ac36:2ed6 with SMTP id d9443c01a7336-297c03ad419mr21806625ad.14.1762479155584;
        Thu, 06 Nov 2025 17:32:35 -0800 (PST)
Received: from localhost ([2804:30c:1653:6900:3b53:af9d:48d6:f107])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29651ca4257sm41496575ad.95.2025.11.06.17.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 17:32:34 -0800 (PST)
Date: Thu, 6 Nov 2025 22:33:49 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: mpl3115: use get_unaligned_be24 to retrieve
 pressure data
Message-ID: <aQ1MfTu24hhk-dKP@debian-BULLSEYE-live-builder-AMD64>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-2-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105095615.4310-2-apokusinski01@gmail.com>

On 11/05, Antoni Pokusinski wrote:
> The pressure measurement result is arranged as 20-bit unsigned value
> residing in three 8-bit registers. Hence, it can be retrieved using
> get_unaligned_be24 and by applying 4-bit shift.
> 
> Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> ---
>  drivers/iio/pressure/mpl3115.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
...
>  
> -		*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
> +		*val = get_unaligned_be24(tmp) >> 4;
hmm, now the number of bits shifted is dissociated from the channel characteristics.
We can do
		*val = get_unaligned_be24(tmp) >> (24 - chan->scan_type.realbits);
or maybe
		*val = get_unaligned_be24(tmp) >> (sizeof(tmp) - chan->scan_type.realbits);
but it starts becoming too long IMO. Even longer if `tmp` gets a more meaningful
name. Ah well, any of the three forms should work the same at the end of day so
no strong opinion.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

>  		return IIO_VAL_INT;
>  	}
>  	case IIO_TEMP: { /* in 0.0625 celsius / LSB */
> -- 
> 2.25.1
> 

