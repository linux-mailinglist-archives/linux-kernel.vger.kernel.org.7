Return-Path: <linux-kernel+bounces-794231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D60FB3DEAE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD94518953D4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CB83002C0;
	Mon,  1 Sep 2025 09:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q09hES+q"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E053E2FE58C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719492; cv=none; b=Xy0mCs3l4apdbfVHICsIgHb8cAFjc9U0wxKJET0EA7kELML/4olawAVdwVbgDfeckLQqjnBAZ7lBTIIAyG+IQ+//EL7R2VrR0/g78KJF7/+35/JESHaBIhkU6ha+PlgF7mRBuJfTxSJuhhj952QY/SefvaBsPymcrhDWPchhOaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719492; c=relaxed/simple;
	bh=PoWmp6BTuJf52NGuYT9JTcAkjotRrjBMjDMhdQU+LDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrLTDZ6VpoTVvrPu+02XwVubJaduCxCYJ4k2ZSLPzTRuEMUb9HOThfkVzRlYPFpSbbNsuv28Ud9w788R2o31UFFsZA+Fn+JdHohsbKFyUsLixKPSG8oQofY8b/CF1PcQL9ChXqP9ZMHtTsUar4OFhHgVKcizEnT+kDYF0pOUU8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q09hES+q; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3d4dcf3863dso723350f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756719489; x=1757324289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pzu1kAbdXkRLJdQeBmyDCvvHq0+JzBfy9qWh/xcbHzY=;
        b=Q09hES+qKFTEl8vo9QcG8GLkrnddj64eDAnwmya+PxG8dLj1gQOet/dXzZXeixzog/
         E1UeCsyf3rp1vgeKj7xBs3B1CGN9Hn097jhxcSfTFsVivUUtG/zDqfNm/LQXkGQ7CZLU
         NPCLWztJ0s/CWSZufVE6ZwJHY++n50XpYWBa6nHTQEEDNVFhR72MYDBTLkikL5T4gEXh
         pUhO6/WyvDbG2VVQI1URvG2UoANLmon4TudXxTVDGjQc38m8QJSK3bDWUSK11RpMXHu3
         u11dHoIDNEhRBRcgGr+S/kMA5oYEQpfiSMkZUAuhuBsvzt5mX16lzplC+WlUQx+1L3fw
         /k1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756719489; x=1757324289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pzu1kAbdXkRLJdQeBmyDCvvHq0+JzBfy9qWh/xcbHzY=;
        b=X8Vex6yfPTwelY5wFuYRvmAIH49uLnkRdLR1YguUQ3fdZxV5PkUQf/ZzB1RQ8DZsOc
         wfz8bZwemcQxEgjPhG222C9j4K8GidVv8vkEPJBeb3vKzWwQVFmzfUwE1DX8ei1KyPai
         YJGKc8cXO+zYKc/8O2hT3hZr5q9PoZp+Fg3bJB8MxLOObR5+jxs39sBf3Bwtx/Er3wZi
         aT4Ae7rYG6i/3hfSVaAyE60UGeganYR9qok2RSaAHDJ1QmTDo7ardjavYtikkaJ91+uF
         9pFiK/lZJn5rD1XGvBxV/Ha02KSzbCLcqlZm582CiDtmfcKiJndetGzOpCVv3oBgTvHX
         68JA==
X-Forwarded-Encrypted: i=1; AJvYcCUScSrTXnlLdKOqWRfhGPZUhwI0pth8yA5K4mSY0ddiYzku9xQkgkxKlw+v8ZG10TFQvo/RUSmPJUp8KmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYt95WG2JKnSFvS8DjjdMpV0Aqho93el3EEtdOjTBV0aXHNJsE
	X0VZy4SW9ghp0B9Vw70cJIVX2ypCLztyBdzWkqUERsCEYGRlkGJI2dSL
X-Gm-Gg: ASbGnctRqgQyW1MPSwBPcEnX5k2JszYsVftUNUnmOCcZOevuKz+EXcW2FPllvBSZJMk
	Njxhj447OuVA5TlVcHHBw/JKKV8lIwCFatYSwJTFvbUETrHhVk0v2WSmPX6EKZZXV1JbMEUoHkz
	1buQmjynIW3lbMceMTyRiL8wmnvCNX1nWKl/COqvPLiSCh25kWTh1VHM597MNhj775jsh3Db7e7
	hjyFS/d9UqX+JZAX6bo5zGpUZmhP2oERDf2Xqfnqvm1Ng3dALxpceUtsjXirf95bnC7iollD0W+
	8HSWlK8D3bz2wP4lE2k9XvrT1D95E9GyZOG2x0bxjctiym/m7k7yNtIJQWa32vACTJttdUM1ZSq
	aMr6ryFePyzp8Srt1dDfb0d2dsekTq65g4J22Sfv+x6Qs/vks
X-Google-Smtp-Source: AGHT+IF2TZk7fxatgeUxLw/qv7wlqnSjQwQXJdLzdyRAIZVXdjblMD2gLpYR4LPKSoJ9LYijZ/AY7g==
X-Received: by 2002:a05:6000:1a8c:b0:3cd:96bb:b948 with SMTP id ffacd0b85a97d-3d1df15a131mr5335377f8f.47.1756719488910;
        Mon, 01 Sep 2025 02:38:08 -0700 (PDT)
Received: from egonzo (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33add294sm15218970f8f.29.2025.09.01.02.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 02:38:07 -0700 (PDT)
Date: Mon, 1 Sep 2025 11:38:05 +0200
From: Dave Penkler <dpenkler@gmail.com>
To: Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, gregkh@linuxfoundation.org,
	matchstick@neverthere.org, arnd@arndb.de,
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
	marcello.carla@gmx.com
Subject: Re: [PATCH v2] staging: gpib: simplify and fix get_data_lines
Message-ID: <aLVpfRLyri4K_WFK@egonzo>
References: <20250827113858.17265-1-osama.abdelkader@gmail.com>
 <aK73HPDKu6rqg9Ya@stanley.mountain>
 <aK8SGpevZsGM5CCF@egonzo>
 <20ed561b-aba1-432c-9fdc-103e724852d9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20ed561b-aba1-432c-9fdc-103e724852d9@gmail.com>

On Fri, Aug 29, 2025 at 04:34:05PM +0200, Osama Abdelkader wrote:
> 
> On 8/27/25 4:11 PM, Dave Penkler wrote:
> > On Wed, Aug 27, 2025 at 03:16:28PM +0300, Dan Carpenter wrote:
> >> On Wed, Aug 27, 2025 at 01:38:57PM +0200, Osama Abdelkader wrote:
> >>> The function `get_data_lines()` in gpib_bitbang.c currently reads 8
> >>> GPIO descriptors individually and combines them into a byte.
> >>> This has two issues:
> >>>
> >>>   * `gpiod_get_value()` returns an `int` which may be negative on
> >>>     error. Assigning it directly into a `u8` may propagate unexpected
> >>>     values. Masking ensures only the LSB is used.
> >> This part isn't really true any more.
> >>
> >>>   * The code is repetitive and harder to extend.
> >>>
> >>> Fix this by introducing a local array of GPIO descriptors and looping
> >>> over them, while masking the return value to its least significant bit.
> >> There really isn't any need to mask now that we're checking for
> >> negatives.
> >>
> >>> This reduces duplication, makes the code more maintainable, and avoids
> >>> possible data corruption from negative `gpiod_get_value()` returns.
> >>>
> >>> Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> >>> ---
> >>> v2:
> >>> Just print the gpio pin error and leave the bit as zero
> >>> ---
> >>>  drivers/staging/gpib/gpio/gpib_bitbang.c | 28 ++++++++++++++----------
> >>>  1 file changed, 17 insertions(+), 11 deletions(-)
> >>>
> >>> diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
> >>> index 17884810fd69..f4ca59c007dd 100644
> >>> --- a/drivers/staging/gpib/gpio/gpib_bitbang.c
> >>> +++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
> >>> @@ -1403,17 +1403,23 @@ static void set_data_lines(u8 byte)
> >>>  
> >>>  static u8 get_data_lines(void)
> >>>  {
> >>> -	u8 ret;
> >>> -
> >>> -	ret = gpiod_get_value(D01);
> >>> -	ret |= gpiod_get_value(D02) << 1;
> >>> -	ret |= gpiod_get_value(D03) << 2;
> >>> -	ret |= gpiod_get_value(D04) << 3;
> >>> -	ret |= gpiod_get_value(D05) << 4;
> >>> -	ret |= gpiod_get_value(D06) << 5;
> >>> -	ret |= gpiod_get_value(D07) << 6;
> >>> -	ret |= gpiod_get_value(D08) << 7;
> >>> -	return ~ret;
> >>> +	struct gpio_desc *lines[8] = {
> >>> +		D01, D02, D03, D04, D05, D06, D07, D08
> >>> +	};
> >>> +
> >> Delete this blank line.
> >>
> >>> +	u8 val = 0;
> >>> +	int ret, i;
> >>> +
> >>> +	for (i = 0; i < 8; i++) {
> >>> +		ret = gpiod_get_value(lines[i]);
> >>> +		if (ret < 0) {
> >>> +			pr_err("get GPIO pin %d error: %d\n", i, ret);
> >>> +			continue;
> >>> +		}
> >>> +		val |= (ret & 1) << i;
> >> Delete the mask.
> >>
> >> (I wavered on whether I should comment on the nit picky things I've
> >> said in this email, but in the end it was the out of date commit
> >> message which pushed me over the edge.  I would have ignored the
> >> other things otherwise).
> >>
> >> regards,
> >> dan carpenter
> >>
> >>
> > This patch seems unnecessary.
> > The code will never be extended.
> 
> But using for loop is more readable than writing 8 similar lines, or?
> 
> > In the unlikely case of errors it will produce a huge streams of console spam.
> > It negatively impacts performance:  114209 bytes/sec vs 118274 bytes/sec.
> 
> We can remove that error message to not impact the performance, but storing errors even unlikely cases
> as gpio data is a bug, or?

Hi again,
Even with the following code, eliminating the error test, the
performance is still negatively impacted: 114865 vs 118274 bytes/sec.

static u8 get_data_lines(void)
{
  struct gpio_desc *lines[8] = {D01, D02, D03, D04, D05, D06, D07, D08}; 
  u8 val = 0;
  int i;

  for (i = 0; i < 8; i++)
             val |= gpiod_get_value(lines[i]) << i;
   return ~val;
}

Variable shifts are just slower than hardcoded shifts. Most of the
delay for GPIB reads and writes comes from the relatively long
interrupt latency on the pi's (> 2 usecs). There are 2 interrupts per
byte read. Even so the loop implementation causes a noticeable
degradation in performance which we want to avoid.

Regarding testing for error returns:
We won't get ENODEV since on the raspberry pi the gpios are
implemented on the SoC so cannot "disappear" once allocated.

In the case of a direction bug (which we don't have) the gpiod subsystem
will emit a warning.

Further it is not worth checking for error returns on the
gpiod_get/set_value calls with the bcma_gpio_get/set_value
implementations since the latter do not return negative values.




