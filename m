Return-Path: <linux-kernel+bounces-874240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7AFCC15D2B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BD60F54327C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9310296BBB;
	Tue, 28 Oct 2025 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AFgGzI8d"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5BD29617D
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761668816; cv=none; b=foAAawDDcBaQtla5J/MUQ04lAc0oy78eCvrEJ6NmunWB9Sdau1CBmtZESKwUsWihUqheRHIY6zyZ8lLqNNvhUOnUIyLqM+1RCTIBYB4+6d4h+23O5xE1u9trCMgpm94zJ3bOdmBbM9popoCwtRLVnW7FGkTR3X6hEUg2YOs1yOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761668816; c=relaxed/simple;
	bh=TTeQEQh/zyoqxmgIjaCqSLAZ1hRahpSzJWYP5Njbevg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LkBgPN+J2tyI3EF2GhpiNhcD8XE2jkRILbKHT2HcOZWtmrMH6dngiGd0jx9ERiSE3oaR6ZmiGytb+FfCUykJPIjOpxfE2cus5J6HYxUFUWqHB8q8neOYOHPn0xQZ2I4Fv8z9cfsHD6/n8wdJfqCslFq/0zcPO68BTImEpJZfgLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AFgGzI8d; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4770c2cd96fso23813225e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761668811; x=1762273611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mTQDtoLg5tD2EhtUFx8lnwkECbPu6ioaI2sy2RREcrY=;
        b=AFgGzI8d3HLS+LkMyxlAnZ0dSFSqnNtBbSzk4zR6ri6amKQMfZCmmiwdOaNqKD+EAx
         oSsIdCXlneN+97gjGQr0qfBzbTCxPINx+8h6MnhIIjmzZPipsVCPK+30Zf2tAMWAlfTH
         60pYFfJFqmZz3Zx/ZLZXay8jlKLVLNXys04FWAqTAVTGPEsNg2F5EfeHqEme+QmwMcO4
         Qh8Ag8Eci6ylDxr33GgutzYysWEZWM1XTc/wjywTXQxYUM2tBVvxuH66fPnNbJ73jcxp
         dWqjyu5DvkkWNFDxwu8BauHSIGbdyXi6l6zXYB9Hm52lKvEbt71b1lV0iKJUdG5oZPoe
         2g/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761668811; x=1762273611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTQDtoLg5tD2EhtUFx8lnwkECbPu6ioaI2sy2RREcrY=;
        b=uUpTTdI607jkYcxV1WbdKfvfKmEf73safXo0hzYGUw0lO4PjI8MSUJRaCffSK4QGI9
         sg4Xs+Ap543Lnb3lZZv+aoP0XHbJPi6hAynhwY7QqVhn8RRY1aOEj8YIR+QhINTmxhRu
         qZ81RCpJLvg4VHy767L1QxYeXtjdiYmgsrQKtq5mwQ1EKadKFffEhyopVf+HSoKPyjR4
         XWfsP7V5gHcBYZ/zt9yzdkz3tg/fGpEo6N0ba2clufPuy5SfO8yNVH+Ih6P0D6mkyYbW
         BAOvyw0IVRZiaG/KoieUT/4pntvGG+0bPPAL1tipUlKa+ZYIwcN8oiL2dCtPeThXu6xG
         UCDw==
X-Forwarded-Encrypted: i=1; AJvYcCVKwDG1ffetRGYhRnNx8I0NUu3VdUS246Nd3oERSFDOscqI1VVdtjNy3YM/POiiK5aP/vpdUCauEgCdVZc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ul+YkAMdnhFiU2BiGXhO5KVy29Rg+I9lGM9NoGMrQxmvnk1c
	cJbs7rtfoZXuAJGxXenXcIPaLcnqr3baSCxQTpbIJDnU9QtYp50GhrH7svxqRlrDwbo=
X-Gm-Gg: ASbGnctYxFyRFm+4gVazJRlt59cbI0WFttU+uhxGWy5cxdhD8Tkgu2DJp6P0xukmdbs
	LKqs1YC9ZP8CCVIXq0NSaiK7XOfNvbNr5lpsf/Zv2f2o8aPrsf2qxk1yHnEoFsbxU5Lifg9baHa
	ugfQcVPq5oH0GhK0p0fTGWOaMg1U1n2C+mZPwhoKIybMd8fIN4xjuMMpvD3WkVVq7pJYSCYGrJw
	zceh08SIL0T00uCHWyBBtqCD69w1lwQrHGp1oq85bvMcgPDzPTIUtnsnYPz5cvpPf7YPJLeqnuN
	GJKDBjdayJoxqLEOO0rhryPF8KVMYdgsN15BZCJzC4hgolV+xj0XW+V2epMBElWNV8nmVwNkHvW
	iAGj63vwbDj/W8VuKCaX7oW8+tg1wdWk/Sx3bfUjTNGBtgIIU2UfKv/uXfs2LR3fN0AQ+Rwva
X-Google-Smtp-Source: AGHT+IGuRgJO13xk2Jpb25G3vg2qNdxnqTK43mT6WFXMrJoTuSIWNrgPsq5EVG0SCzEdej0faMV8Bg==
X-Received: by 2002:a05:600c:64cc:b0:475:d944:2053 with SMTP id 5b1f17b1804b1-4771e171a36mr991005e9.2.1761668810763;
        Tue, 28 Oct 2025 09:26:50 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771e202093sm530835e9.11.2025.10.28.09.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:26:49 -0700 (PDT)
Date: Tue, 28 Oct 2025 18:26:48 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Skip setting orientation for UCSI
 version 2.0 and above
Message-ID: <fetxo2ij7rstq52kxzad4yj76l25kzanzaccjrfso4bklcb5ra@mym55zc26icw>
References: <20251028-ucsi-glink-skip-orientation-for-ucsi-v2-v1-1-93e936ac59b4@linaro.org>
 <mjgwv3soxgdcybkoo6xglxfpusswmjoyit4z3qpbnyhatj73od@ywmnx6vyupsi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mjgwv3soxgdcybkoo6xglxfpusswmjoyit4z3qpbnyhatj73od@ywmnx6vyupsi>

On 25-10-28 17:30:08, Dmitry Baryshkov wrote:
> On Tue, Oct 28, 2025 at 04:39:19PM +0200, Abel Vesa wrote:
> > In case of UCSI version 2.0 and above, if the orientation is set from
> > glink as well, it will trigger the consumers along the graph (PHYs,
> > repeaters and so on) to reconfigure a second time. This might break
> > the consumer drivers which aren't currently implemented to drop the
> > second request of setting the same orientation.
> 
> Might or breaks? What happens if the driver doesn't ignore the request?

So I do not have a very specific usecase in mind, but my point is more
about complex LTTPRs or repeaters which might misbehave if you trigger
multiple orientation setting.

Anyway, we currently do so on platforms where orientation is determined
by a gpio level. So I think requesting multiple same orientation settings
is definitely not a problem currently.

I still think we should stick to the UCSI payload value if available,
and ignore everything else.

