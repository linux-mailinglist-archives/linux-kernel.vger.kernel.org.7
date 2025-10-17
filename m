Return-Path: <linux-kernel+bounces-857171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC15BE614B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 04:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF65483B69
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6F4238D3A;
	Fri, 17 Oct 2025 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pn+XXUkB"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30C1198A11
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760666910; cv=none; b=hi/5YKrW36uGeowHKX1lbl09SohE31QosAU2TsH0ssKWw9+yNKs/6KngAFzLUTe4aIPgwCWcSY5CXMefSoPNOYnNbnhUzabQjlra01hf8xZD49ETdMEw/ca17+lwz14YMJ6C3/01E2B/0Upd+zY+nGYUH8u5hKTePSHmhidR+Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760666910; c=relaxed/simple;
	bh=uFyNlaBM4GquxmWXZXnlDpJbJJ0E7RwkmEFm9e3w4Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQpx8v6ZtdhT6eLJVRKwFRFE8abcSGJv9pFjZDV2GXyhSn895N7/dISI828lOG1jJ6dItg5AIJp5J+4VJTpXgyqdpFyZR4y0FFrJuMWDJJgREM7gmgzBrd2dThVnehoewEkdwQFLBh/e3hbER9iH3jLsfVnr2sanioWM84/Ek+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pn+XXUkB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27eed7bdfeeso17024455ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 19:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760666908; x=1761271708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MxhH6lw9EEPxSD0k2eQCgE+8zTFFn25q7lomjcD/Htk=;
        b=Pn+XXUkBQMPeTkdpibsJ9rEtke6m1f8xG7FaMt26tXhLRKse9FkE9BXnfHoN+MGaF9
         K3cSFmHSwh5uOdTZLbnIH2XKNV8XoZkPU7D9yT2o53Q/Q+D17mefUE3D81TGQVaOAW/Z
         Kq+xVUBW7pVOhPAmX7nL1SknY4Njg0EVMMrl+COVCmC5SQvy8WW+6Rc1TPYym9h2XRny
         rPoN7CwY4XVSvsIx03D5ue/7Qe4hJj0P/q7fNlhkaBkz+BIt8zEXygYRcLV37A7UUfgz
         NZZCkvKj08vaQTBSdKhD5lOfXRw3Ov0oqiUUW34m9fvCWNwsQBgsVJpVlJMsQDCWgfh1
         GRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760666908; x=1761271708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxhH6lw9EEPxSD0k2eQCgE+8zTFFn25q7lomjcD/Htk=;
        b=e3jXVPWsueVket8XgNKl6BkUVabjigwC1AhpGAmpabqtdXIOau2CRmUIdg0Py0GHEm
         XfPxsRFu6xica6RsSAK7I9ttIx37e+S+J1MQxq3AZj72krpGj682V2Jd2XF+hLs3rCZE
         rqSWv6TNTjuyS7youvAUji9x8unz1k7JqzYb+H1LzYiVfj1iiQv4Gxk1BnCwgprTdSuY
         XC027p7l9+D4oX1k+q8BpthMBiiHQAEeILpOKml+q6Bqbhft3HrPOze+FZzEWVivs2xX
         kxjxIz3LFYpU46Q6U/1YBrev/T4WlUCRmXsqxFWCbimukBqsf8i1trffrYyYEaAhEFNx
         ysRg==
X-Forwarded-Encrypted: i=1; AJvYcCUbS+JjE6M+3YPxcMara32ESOmTELx+sLFNwJKENIq+0erEGBXZo8ZX9jpsQaE1pP1EDT8QeJApqNdXAsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGWWu9wMgnjeIXgrMx/YA5r9tYPc+YjscNPv2GKv8DI8PfvFBJ
	f0qJlXXo2YXFnWHTXwrUF7bNfC0z3FbLiUY3PZsAG8JLAlGrNKOUSsSB
X-Gm-Gg: ASbGnctWEqUEEeNeEa5DNwbv+4lMxATqsD9aS3jIPITiuNUlJvSyDGPMg/tOCmM3VtC
	UXOmQe0yy4nh4yf3y/Z+NOwac0gIuE0AbdP+H6EbpmArQ+Gno/dfCFlDtZxloLi6zYV5uUt/aJe
	2AemQlQZ9gbERrpk8yPByWaOjEu3LV614OETVPexNCGJleZ4g0pSAmAh51OA7KzpNzJP0AkIEbx
	qaadaq+dGU2FIz3I/C8XNpsQt3D9uY+DjqXQtytWOsQStfg08hbXk0ZbmpH52mf9A21GjesRBqa
	QucB9402nhve1GtkqOM62fgorN9gIotqrkWaiEcI+ympZfsfB64TrZxuhcln0m4/TjzkSR/BAH0
	dn3eQ3VIMvzJpyXgnd2R2D5mNE6841bt7b0wZhOUu3PsjpZNEqxW11GwTExFslQ850gK8ERoam+
	7gMkBEjeZM7rWKVm4v4Ti9
X-Google-Smtp-Source: AGHT+IGRk1XqmxqYB3GmxV+aJHnx95/Cb2yrslxtxSmrQaVgzp3J2jwQ+Wo8JdgXxNL7955wC+OXaQ==
X-Received: by 2002:a17:903:1a23:b0:271:9b0e:54c7 with SMTP id d9443c01a7336-29091af3a9cmr78700785ad.11.1760666907920;
        Thu, 16 Oct 2025 19:08:27 -0700 (PDT)
Received: from localhost ([2804:30c:402b:1a00:ec78:db53:a246:207a])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29099aaf693sm45021675ad.80.2025.10.16.19.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 19:08:26 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:09:31 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v13 2/2] iio: adc: max14001: New driver
Message-ID: <aPGlWznNdrPma4jZ@debian-BULLSEYE-live-builder-AMD64>
References: <830368e5bc303faf04f542268acb95e99d0d1cde.1760502331.git.marilene.agarcia@gmail.com>
 <2e0e5fadeb3083a79a31776d9e996b865c1b1f5f.1760502331.git.marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e0e5fadeb3083a79a31776d9e996b865c1b1f5f.1760502331.git.marilene.agarcia@gmail.com>

On 10/15, Marilene Andrade Garcia wrote:
> The MAX14001/MAX14002 is configurable, isolated 10-bit ADCs for multi-range
> binary inputs. In addition to ADC readings, the MAX14001/MAX14002 offers
> more features, like a binary comparator, a filtered reading that can
> provide the average of the last 2, 4, or 8 ADC readings, and an inrush
> comparator that triggers the inrush current. There is also a fault feature
> that can diagnose seven possible fault conditions. And an option to select
> an external or internal ADC voltage reference.
> 
> MAX14001/MAX14002 features implemented so far:
> - Raw ADC reading.
> - MV fault disable.
> - Selection of external or internal ADC voltage reference, depending on
> whether it is declared in the device tree.
> 
> Co-developed-by: Kim Seer Paller <kimseer.paller@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> Tested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Hmm, I don't know why, but I would have given a different order to the tags
Reviewed-by: M. S. <...> # new tag
Tested-by: M. S. <...>
Co-developed-by: K. S. P. <...>
Signed-off-by: K. S. P. <...>
Signed-off-by: M. A. G. <...>

Swapping tag lines will probably not be a reason for a v14, though.

Cheers,
Marcelo

