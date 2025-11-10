Return-Path: <linux-kernel+bounces-893591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49227C47C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 17:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF97188789A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC083274B51;
	Mon, 10 Nov 2025 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hdxdSnPE"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B651F2749C7
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790389; cv=none; b=Q/BSinQ4ZZ82QMsBoAElALZuLYiIbRJDNuK00xcdArw/L/RonrkjFmlTgOHUcaw0Vqv7tV1nU6PhVoGnq2ZcY6D77LaV1l7lYWANfvKW5k7ic/lyT56OiPJJqQ9ucuxgZWrGjwkR3A+pkNm0Vj8iEsmgkFC9A+cNCpKFmcJuHU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790389; c=relaxed/simple;
	bh=3XR5xOZFw7m7F99cDS59uJSVbCi5klWDCylfHhnjIJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ny6sxjBj9GCBIDnTgK970WbTI77/ivFjcvk0yGuUZxq/W9007pBkW780SfUK1tMuqoR8T6R3io7pKPwD5235tgibpFrYijs3L+XMOxsYSW0JXWzJDjlLURg84zsDry7zx8681ihHYX3BFUXc2n1chm+YW5r4y+lxqcbIyJpe7iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hdxdSnPE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-477775d3728so16005075e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 07:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790385; x=1763395185; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/8OtEDzPninIAmrIyyW9v/oj/TtbUvCgO2RuWZGfmfg=;
        b=hdxdSnPEZVbJAWImgyGWFhXHqkpqiSG3XNnSQ9XwjMQ3WvkO0hrMB6yWy8FMf5L9eE
         8rRCcYTJVzm8hwFs/zKsNoY+/t5IZfUj9sQrdu0/fdGgbisnz3Xdg2lFeRL0CoWZZbFV
         vVE/5gPJRNSxpqfwLvjQnGGCexQnqdLAk8WFe3owDYEjXjKLUf0RKHAKvwebyyZzcOL4
         uOjdBSCFrtGyR9eHCj0joc48LxDshmcjznvZUdN3lRRBvSDHY+8+XACSPVKgrFjD1IFC
         KzOLBxsDQn1k3pne4Qc/ohqERNizLp3vFMqa9uVCBPrRR+au5GGdGjXeBhkV1/LW2g6U
         /YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790385; x=1763395185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8OtEDzPninIAmrIyyW9v/oj/TtbUvCgO2RuWZGfmfg=;
        b=nsD64uXoSLwTjmalQBrQl6H+5CQgXDPPh+QdHJISDOqK5enb9nx7Sgm89hNDbcX0wE
         Wh7GdWWp0txrwN2m9Ce4yjydbIgCXoK+eJOTfQ6V/qSzf/Ork0DcyIvK0nwCkPZsKbG2
         PO/hsjHoDD4/2BFe5Z11t8r1lj3iYl3uNePnc+YWrq+WAI+gy5bcxZPEVfSZ3wuLuzh3
         PfQzS1C0Ql9qMUHATUCKqIscTXsAlO8rweumn1tkUSTh+fgRG0ocPuXvGwUxAzIL5rut
         t/JpYKT9omNxNV77vJP4XRF79PDgT/khDMkbeVG2Vmv0JHAD58S71vE7NqEUa13PsYt2
         46gw==
X-Forwarded-Encrypted: i=1; AJvYcCWWzqHaiubmhctNkXm83/REmBiypu9wJBvvE1k6TAUOl+trj7Tj92zTgf179bNcUTtwP6/BNNkLceFZdfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfA8P8LNHrdPXawOLdntffpxser3XMdx9Ez7F/LVOqrrKB2pW7
	bTxyDFz6nUXF7TKBJDk6nr138pBNNvTRwSIL60BDO1OhYUMiXS+sAKNN
X-Gm-Gg: ASbGncvWajqlGUJ1jTdtXw/9ctSj3tRVWosqPuJ18m6kHqunsL55lkqULmdNO1ps+cS
	I+atgBtQ84hr4v1yabJxFqnhmsku6XhaBcwvpRS6POkXItubkl30Z0bc+onh5scyVKulKv+Eahe
	ZCkrtba9KHusNtJB6yOM7ImLB9hrDipE+h1CxLWgiUnnPWoeZzzZ0lRbil7oy9OP+C+3ARtiRTp
	cYBeXa6B4pXJU4PFLgqVml3S7vXx/6GdH3tysUogYPnykXoJyh3O+QXdbLzYKqvhHljJfKx/p8G
	LDVpBBtTluhQ7bLE7MheeQNPamsKEQ8PCZggIvpdQti6oB9fsdJYyUHboqvQnULINartxDjmxCU
	UcQXuX8SReXFpv0coLAudHiD5vN/NmZNhgUFOwASO2m/DIdIemcFVvXUdDYzlmuViF0G4Ub7Eh8
	EFMzfRKpONTRMCS+rYEyX0k5Wxrixyf1x666mEeGFFJDRgQcP/mA/v1w==
X-Google-Smtp-Source: AGHT+IGfuwlyQtxVjwr9CEgE9pocum/nwloht2L5pCeLUj0SFtQpO9BEkf5q4jSMf+Ykwzb+AJV7AA==
X-Received: by 2002:a05:600c:1c8e:b0:475:dd53:6c06 with SMTP id 5b1f17b1804b1-477732892b4mr78053345e9.40.1762790384755;
        Mon, 10 Nov 2025 07:59:44 -0800 (PST)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([78.209.76.229])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777a96e7f8sm82334945e9.13.2025.11.10.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 07:59:44 -0800 (PST)
Date: Mon, 10 Nov 2025 16:59:32 +0100
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, marcelo.schmitt1@gmail.com
Cc: andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: mpl3115: use get_unaligned_be24 to retrieve
 pressure data
Message-ID: <20251110155932.o2oipfzuxhgq4vn4@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-2-apokusinski01@gmail.com>
 <aQ1MfTu24hhk-dKP@debian-BULLSEYE-live-builder-AMD64>
 <20251109163840.64144586@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109163840.64144586@jic23-huawei>

On Sun, Nov 09, 2025 at 04:38:40PM +0000, Jonathan Cameron wrote:
> On Thu, 6 Nov 2025 22:33:49 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > On 11/05, Antoni Pokusinski wrote:
> > > The pressure measurement result is arranged as 20-bit unsigned value
> > > residing in three 8-bit registers. Hence, it can be retrieved using
> > > get_unaligned_be24 and by applying 4-bit shift.
> > > 
> > > Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> > > ---
> > >  drivers/iio/pressure/mpl3115.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c  
> > ...
> > >  
> > > -		*val = be32_to_cpu(tmp) >> chan->scan_type.shift;
> > > +		*val = get_unaligned_be24(tmp) >> 4;  
> > hmm, now the number of bits shifted is dissociated from the channel characteristics.
> > We can do
> > 		*val = get_unaligned_be24(tmp) >> (24 - chan->scan_type.realbits);
> This encodes that the field is always aligned to the maximum bit. Whilst it might
> be true, there is nothing inherent that says it must be.
> 
> I'm not sure why we aren't using chan->scan_type.shift though.
The chan->scan_type.shift is 12 for the pressure channel, because
.realbits is 32. In order to better reflect the actual data format,
the pressure .shift and .realbits should be changed to 4 and 24 respectively
and the we could use the chan->scan_type.shift in here indeed.

But then the `iio_generic_buffer` tool should also be updated so that it
can manage the scan_data with realbits not being in the form 2^n.
Currently it supports only scan sizes of 1,2,4,8 bytes [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/tree/tools/iio/iio_generic_buffer.c#n189
> 
> > or maybe
> > 		*val = get_unaligned_be24(tmp) >> (sizeof(tmp) - chan->scan_type.realbits);
> 
> That one needs a BYTES_TO_BITS factor too.
> 
> > but it starts becoming too long IMO. Even longer if `tmp` gets a more meaningful
> > name. Ah well, any of the three forms should work the same at the end of day so
> > no strong opinion.
> > 
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > 
> > >  		return IIO_VAL_INT;
> > >  	}
> > >  	case IIO_TEMP: { /* in 0.0625 celsius / LSB */
> > > -- 
> > > 2.25.1
> > >   
>
Kind regards,
Antoni Pokusinski


