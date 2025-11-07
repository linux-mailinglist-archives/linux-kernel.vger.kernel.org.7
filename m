Return-Path: <linux-kernel+bounces-891083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B29B0C41CA3
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 23:01:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 44CB44F3B60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 22:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8353101DB;
	Fri,  7 Nov 2025 22:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Av4MvMcN"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ECD30EF7F
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 22:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762552885; cv=none; b=einzpx0GE5hIOU93IUoI5SgXWKU5ZN+Kf9E0eZBH+tJkLKP8TvL2nn/ZDrpyVNm/giwJa3Csj1HFsm7HhaytNchSOl07Emgae0vsRGQMxOcHo+k6AHplXnUE6npOLZOmQ243xrQuyu78Cc71NhyIbHTnLljjnZ4Kx4vtOCHh3UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762552885; c=relaxed/simple;
	bh=ZvRRiQ8rvc30G23b9Bf39pSTr1/076pCJ7w6F4gS79g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTnyEGxbSMSJeQSoXGRrQGIdxee7+yYJntf6tBSh6XL3m7z+dDJdf5/bdgvgz/lTIeiJP6KWCHn+52mRTH1FCHAGNVwyonFpmp37rSD0KFj+DOJrWi+Iqe7kAx9iTiOF/9CdvTzV/0CO1/bRxo7J2TaWBN8bV3ziMtESFWON6Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Av4MvMcN; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4711810948aso8676625e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 14:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762552882; x=1763157682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7YwdZPYZiho3Subcd9u/9cmTkYwrhyDSdsl+gE3HRmw=;
        b=Av4MvMcN8wtmlHrAiemuQO0srtJ/2kjeMFxyIOu6iygRwZcre2Rog/2yhDFrz/FpOv
         JAcfJKCAvrzH9ppGA6BE2saq6QRePpFOFtSk7QLH6JmOAbJEOkVKxuyKy6ETI/Ku4dVD
         931DcWZw6r5ALhaTjnAncaDNsCwT0z25Msxcc0knp8lvQyLd2nwxt58FBfSpe3Dz9GO9
         X6hCozVP2WChk8HcbWElXcu8VuBRCh5bGhYqJI2E4YZKR6X3q+W1SBJQxL7Y6ZRTBwrj
         /P9U4a5XMPsRj4xNtxQZ+3FmnMPpsJ5WEHTeR3x0VJIcl9X8aqXiTCoQT1BtiRTkFzvm
         HyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762552882; x=1763157682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7YwdZPYZiho3Subcd9u/9cmTkYwrhyDSdsl+gE3HRmw=;
        b=XIVDOImxf8IgXgRXQAu2oy+fDSUZNFz8bv/pZ9X6hp/b1lid9vyp/KzxbyBGUzZhYW
         jT7RIzC0qlumI2Bn7v/wjxu9UVodkEIJw3P6oOi5V2aID1BpdJTtYn37P429pDjfNRyj
         tnv4Ca/Cc9DxDC/+Zf2hSTBRJJaAiZyMtKugJRt9VuhZBpeo9+E3h/Pe9Qj+AP7gh4CP
         /mmNjEcgfYAm4jWEzZnpZNIMfJPHehIJeMFEyDfcyaYpjCLbiOJ03Gl2vY4N9jkowChb
         ghYVNgBGaVez4ajuJi7nNR0EDdD2L1r0al2Dk391TeydDSXapycOqqcT6fRNEZHd/r2D
         vVTA==
X-Forwarded-Encrypted: i=1; AJvYcCW9l1q1Tiui4p9bm6M6nn++UELgln7ikh+hUUogoj3M2PEwugL5uSlw0SlI/Y/HYP9h2EFJ4lUAQ/2qY60=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaKBLGzIwL66lnpG7kd/4h2OkFO2flzOc05Ii42c18F42elVMt
	hIheivKLIvIHPUo7bjlPlWqawU77LdxNi1p1bphJ8LonfxOHvvVT7VpF
X-Gm-Gg: ASbGncsWHI6RQgggppdMGzoUneSJX/WwqptjQMfnXVK/lM0fXMdqE03/zK3XEHnLk6F
	YzLBqj3msXaIeMpYq//JxWURWupd0PkNe6sc0UxYZO1lY3Qay+zzyI7O1SNR2maTsJNf7rqIxl5
	KUV26GxpOHpIf5lqVeu4Ga8GHhsOTL7WQIlBei/Wp+Z9WBfd23yEzEP5OsmfsNE/wMIQ3EaxIkj
	SAD36ktfJVL2G/nxa6l6weDx5fQynuLBdjIVa4+2vIVgbs034sAC1/T30mE70hlS2xozjoOi4Fi
	yJ8HRr1wFr+62kQGQ0gWfJGqNN2AnM0XHYbI8omztMotrvWewdBYqngx7OuYj9ypAwTR6aDcng+
	ZIqHNiune+W5KV+XPX2DLKEa7bVr9XyNtSuTBObFX3SezU/UO1seXhsCE05aLwFVRcMdXlejbzT
	eQTkCht4wkC4mnq5qFNewWSgBpyht00MgZ8LHZI1V6Nw==
X-Google-Smtp-Source: AGHT+IETa6C6wu7fSXxfvpKHmlI5Z2mbLTetko1XH88Udj/UuTbG92MTj44YOV8YPsC3UCB7lVjncQ==
X-Received: by 2002:a05:600c:8010:b0:456:1b6f:c888 with SMTP id 5b1f17b1804b1-4777327709fmr4392515e9.23.1762552881794;
        Fri, 07 Nov 2025 14:01:21 -0800 (PST)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([37.160.63.21])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdce8d2sm186801765e9.8.2025.11.07.14.01.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 14:01:21 -0800 (PST)
Date: Fri, 7 Nov 2025 23:01:06 +0100
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] iio: mpl3115: add threshold events support
Message-ID: <20251107220106.ihk6e46paxmyfqgg@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-3-apokusinski01@gmail.com>
 <aQ1Rdcbi3e8lzOvM@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ1Rdcbi3e8lzOvM@debian-BULLSEYE-live-builder-AMD64>

On Thu, Nov 06, 2025 at 10:55:01PM -0300, Marcelo Schmitt wrote:
> Hi Antoni,
> 
> v3 looks mostly good to me.
> A couple of minor suggestions in addition to Andy's.
> 
> On 11/05, Antoni Pokusinski wrote:
> > +
> > +static int mpl3115_write_thresh(struct iio_dev *indio_dev,
> > +				const struct iio_chan_spec *chan,
> > +				enum iio_event_type type,
> > +				enum iio_event_direction dir,
> > +				enum iio_event_info info,
> > +				int val, int val2)
> > +{
> > +	struct mpl3115_data *data = iio_priv(indio_dev);
> > +	__be16 tmp;
> > +
> > +	if (info != IIO_EV_INFO_VALUE)
> > +		return -EINVAL;
> > +
> > +	switch (chan->type) {
> > +	case IIO_PRESSURE:
> > +		val >>= 1;
> > +
> > +		if (val < 0 || val > U16_MAX)
> Alternatively, could use in_range() for the check.
> 
> > +			return -EINVAL;
> > +
> > +		tmp = cpu_to_be16(val);
> > +
> > +		return i2c_smbus_write_i2c_block_data(data->client,
> > +						      MPL3115_PRESS_TGT,
> > +						      sizeof(tmp), (u8 *)&tmp);
> > +	case IIO_TEMP:
> > +		if (val < S8_MIN || val > S8_MAX)
> this could also use in_range().
> 
> If you opt for the macro,
> #include <linux/minmax.h>
>
I see that the in_range() macro operates only on unsigned values, so
placing it here would be wrong I guess. In order to keep the style
consistenc in this function, I'd keep both checks as "val < x || val > y"

> > +			return -EINVAL;
> > +
> > +		return i2c_smbus_write_byte_data(data->client,
> > +						 MPL3115_TEMP_TGT, val);
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
Kind regards,
Antoni Pokusinski


