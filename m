Return-Path: <linux-kernel+bounces-768845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC22B26639
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 15:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072CE1CC23BB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28BB3002B9;
	Thu, 14 Aug 2025 13:06:48 +0000 (UTC)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C93E3002B0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176808; cv=none; b=AQGWDZ5KfVB1l0voF8WJ/hpDmUf1LjPwYLT5FeeSkQO4/C3F8nAZq889v/xnWii7QA3z3CqVNJUAsvg3vlnARjlIKU78RrVbyLR9T495I4RYhYEvKxLrJZT3N3jWoaqbHzgYJ+HSUTPXZ5zgjtJLDtJ83DQZMQFPFHpheyUETtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176808; c=relaxed/simple;
	bh=rBSOaaGlQrBIbubiWvvRgdcKsQgmkod6l6U7O0ehnTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQVawo0KKtnSBKsHkJU6kCxaRr8zGO/HzIRl9sD/0yeWx8h6FKt786+cqwQ9ZyNkL0S/Vx+7v+QGZgg86djzyg0k3onJrnsBwEX6+0+0wC0u2e7yGvwVfw4hxeGztUjZlglgCb+nwF+kbr9ocvEtiN9Ua04IOEFEPW7Gq6pd+uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 14 Aug 2025 09:06:39 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] iio: mcp9600: Add support for IIR filter
Message-ID: <2025081408-umber-axolotl-e6c6dd@boujee-and-buff>
Mail-Followup-To: David Lechner <dlechner@baylibre.com>, 
	Ben Collins <bcollins@watter.com>, Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
References: <20250813151614.12098-1-bcollins@watter.com>
 <20250813151614.12098-6-bcollins@watter.com>
 <a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9c8457f-a364-46e2-9e31-ceab0e1c9894@baylibre.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 13, 2025 at 05:52:04PM -0500, David Lechner wrote:
> On 8/13/25 10:15 AM, Ben Collins wrote:
> > MCP9600 supports an IIR filter with 7 levels. Add IIR attribute
... 
> >  static int mcp9600_read(struct mcp9600_data *data,
> > @@ -186,6 +189,9 @@ static int mcp9600_read_raw(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_THERMOCOUPLE_TYPE:
> >  		*val = mcp9600_tc_types[data->thermocouple_type];
> >  		return IIO_VAL_CHAR;
> > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +		*val = data->filter_level;
> 
> We can't just pass the raw value through for this. The ABI is defined
> in Documentation/ABI/testing/sysfs-bus-iio and states that the value
> is the frequency in Hz.
...
> For example, for 3 Hz sample rate (18-bit samples), I got:
> 
>   n  f_3dB (Hz)
>   1  0.58774
>   2  0.24939
>   3  0.12063
>   4  0.05984
>   5  0.02986
>   6  0.01492
>   7  0.00746
> 
> I had to skip n=0 though since that is undefined. Not sure how we
> handle that since it means no filter. Maybe Jonathan can advise?

Thanks for notes. If I'm reading for datasheet formula right,

k = 2 / (2^n + 1)

So n=0 would be k=1. I did this formula for n=[0-7] and get:

n	k
0	1.00000
1	0.66667
2	0.40000
3	0.22222
4	0.11765
5	0.06061
6	0.03077
7	0.01550

I'm not versed in filter frequency, but would these be the correct
values to use for the coefficients?

-- 
 Ben Collins
 https://libjwt.io
 https://github.com/benmcollins
 --
 3EC9 7598 1672 961A 1139  173A 5D5A 57C7 242B 22CF

