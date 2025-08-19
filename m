Return-Path: <linux-kernel+bounces-776058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1F3B2C7F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F266F1C25063
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 15:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA5327EFE3;
	Tue, 19 Aug 2025 15:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pvpOL58W"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFC02EB840
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615728; cv=none; b=g9oHobBIo6cC1hqYVvGCHPle/AQFr7UZsZxPdy3v5L4qnj52mYhBqhHjOEqPCjGSDbUXg/9tHHf0iNkNLZdX/kVO5KNm2VcnyEo4wmE03SlWa/WjF4ZsAHkW4CqieX/DjoEaf50niEjsmtiTKsVpam2oq4Voa+Fs4Os6QI7T6rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615728; c=relaxed/simple;
	bh=wgptnB2H9qnTUUT6jPDhuUrrnXCFncKWtJShnB5mGLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URMkntbOEC2GuaER//FTbg0+F8s+Si9UZldL3WpQM9SZnch/DGZBG5GS+UPpUCCe2RN5kd2fnshKIPwX9uAlJ36jxxinKb79IDGXvo77QTSv8Sqxs1tRwnYQIhojIy7i1X0Kyis0VjScb7NIzjnQ0nHGlvNhuJ3LE5tZ5NS4d/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pvpOL58W; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3b9d41cd38dso4139176f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755615725; x=1756220525; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nT1w+5e0mD/OXT08jYsZeNEMDZKcQ/cmvsGpsw6JbVE=;
        b=pvpOL58W5jyjhruSBvaShxDnGH8GtmPvGyBUs5b4HjH7QVW+9QtlFmAuO3pkKPPRtb
         DMB8rTDdxPuI9VmoAFB1Id43ur6cge27aR7koNCvpx5Z7oNUTIgZYWvu04z7VVuof8Vs
         B8qRPS0gxxnXRDofPCsvvJTqwdlkLsb1yjGdoYM0ffzGoO2VSJCLExPrW1AzQ9AP24N/
         mrIYEvWA0DMb4qfw0KiD3S7UwnKg7XyYsLKu+v5NGu6FilTdyaD8m7ikqEX5RX0M0pOM
         g4trL/V/XmWU3hrTp6i8wlVGDj4+zlL+FbHL0RrMozycPfCBkmHKpuMz11v0TYgk/HeG
         CW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615725; x=1756220525;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nT1w+5e0mD/OXT08jYsZeNEMDZKcQ/cmvsGpsw6JbVE=;
        b=fuRUefexFta6u1BGnfjqE1W5s0EtsY7m3xHxplKZR06o7eB/PTKP0rxPb7GESI/s43
         mdS5O9lRFXTw4GGjzlfQmmzuqzYRfw44pcbTxuQFZqtWeI/XaQ+iAOV4+4d/9NX5b5v3
         G0jb743sigyUeGTbhRs8YD3w1TlSJ9zUMgTAHF5sCGBPLle+A7ItsPpyuai4OwKnxReQ
         HgfUlc7fRmvfy7EQz5TwoOVG3FnUmccOPdYzIaRgrSI3acb2IptwDsHetL+najzmYk2I
         r2LyH7H+wsjLAYX446+nyGLRKNinZneoKh6gxB4WSR7ZctY1xhWC5CQxjQu/oN/dBp9w
         pmlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMQKo48g5KENvLhqVdXhAIKtrI63XQYjMXaPdt5aysEwxAmR6zT6ttrXSMdQdZ9vU3wrWF51OwvTP71Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNCYb7vD5bImt1HbADSlRvRvY6aYG4wkZxxIcnhN6b2uWNZsQb
	GgUisn6rCWfd71xUKDMSjGPrJX5FzF/Z4q283uyqVvLYtNihBUhsRry1o4j9mSOicbw=
X-Gm-Gg: ASbGnctXZCwwDhzSyb8YODLCxZhenEEGT8KMb7DM79sAEp0+4LfsKjVuT6WKbPyTlqC
	BTcMFaIHa4Z9v3GVJmO9vbXa9VJ6yIphWnfRKiHkh9JKD7YzQ6SDLGmRAtmNnvq8l8vot474Zc/
	Fl/sut8gf72+pI1WV8Hi0JSEiYYFeQn0KfrA9NUdF1cEL3B3ORO+JENKGc/kv4f96yQ8FoRwYjv
	FfADX1wsRK57JAd+HK3wxPoAKCuHNhnZuNqqiJqFkz4T8xJ6Q65bbYKbq8Mgohwyd7qW95Xvq35
	eadwyHhBCvJ1I1B6IkiwtZNsjjyX8IXCxOqjZGjFq9ATrLrfbcpupTGJ9v7YWip9KvOQgh9S3PN
	CjkUHMMIl70CbdFc1X445c5veZDzQIBsLnk1wb7r5Vjo=
X-Google-Smtp-Source: AGHT+IG9xBgfwY4xXs1ZR1sBwj23DK6i912COuTKguLY6aIpRkqXOcV+ILsGwy15iv1BwlYbHystyg==
X-Received: by 2002:a5d:64ed:0:b0:3b7:84fc:ef4c with SMTP id ffacd0b85a97d-3c0e00a27c2mr2292475f8f.6.1755615724584;
        Tue, 19 Aug 2025 08:02:04 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3c077789106sm4085293f8f.51.2025.08.19.08.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:02:04 -0700 (PDT)
Date: Tue, 19 Aug 2025 18:02:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Waqar Hameed <waqar.hameed@axis.com>,
	Song Qiang <songqiang1304521@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] io: proximity: vl53l0x-i2c: Fix error code in
 probe()
Message-ID: <aKSR6MMr9aKWw9ff@stanley.mountain>
References: <aKRGXFJxf2bdQE-Q@stanley.mountain>
 <CAHp75VeTL7mJ-Ttgpkjd5A04DgHqkkPY90LtJriQjoaUZ0TbhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VeTL7mJ-Ttgpkjd5A04DgHqkkPY90LtJriQjoaUZ0TbhQ@mail.gmail.com>

On Tue, Aug 19, 2025 at 01:18:35PM +0300, Andy Shevchenko wrote:
> On Tue, Aug 19, 2025 at 12:39 PM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > Commit 65e8202f0322 ("iio: Remove error prints for
> > devm_add_action_or_reset()") accidentally introduce a bug where we
> 
> introduced
> 
> > returned "ret" but the error code was stored in "error" if
> > devm_add_action_or_reset() failed.  Using two variables to store error
> > codes is unnecessary and confusing.  Delete the "error" variable and use
> > "ret" everywhere instead.
> 
> Agree, this is a good catch!
> But please, fix the Subject to start with "iio:".
> 
> With the above comments being addressed
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Yeah.  :(  Thanks.  Will do.

regards,
dan carpenter


