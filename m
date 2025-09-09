Return-Path: <linux-kernel+bounces-809009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A376AB5076C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11E25172822
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D969305979;
	Tue,  9 Sep 2025 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b="QLH5XICg"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7717080B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757450883; cv=none; b=oBNcMAbo3zhXg4GZOycrqGllqDNBXjCrhiJZqX8Lxs6JuxI4HuMKigCVqId0sDFt0S7nFW/xyx+EyH66mpkO6AUeuunYVrLCRc6dmo3beHFbvl8rcOBkrLlNHdvzNNzKACbSct7LXKSuuIZ6Kv6GiO5EsMfhqOyDsTKIS48vE24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757450883; c=relaxed/simple;
	bh=RC9okxu/Jm/dJnbaUvGthBPFjfdF42t2fy5WU4Sou1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMHIxHQX5jEae0D23G5xsEpx0vRMWPqTdhXH4MShITvZ+qjgcH4PcwgHjCL45ThJbXhmYLl/mm7RyXBJydlr90VjeWrV5N6VgJgYxn84G24H9y9UqqcwQC0d8lJ5XhDzgaySXFUzkdRqLxzdb7HpDFWcNay7job3XUsgaeSjgoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk; spf=pass smtp.mailfrom=philpotter.co.uk; dkim=pass (2048-bit key) header.d=philpotter-co-uk.20230601.gappssmtp.com header.i=@philpotter-co-uk.20230601.gappssmtp.com header.b=QLH5XICg; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=philpotter.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=philpotter.co.uk
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3e3aafe06a7so3010615f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20230601.gappssmtp.com; s=20230601; t=1757450880; x=1758055680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=184ZXw3B1fn1QIX/eTt15yZremezaIB+YosahNqj9uc=;
        b=QLH5XICg+s5pE2rrQ5fqMBHgjcQh7//uxGegl/8cWd+GhGoamXUg5R6wiAp3gVA3Yr
         89BHVanzFegQLMtAu5PJBwu1OwZVXwYTN1W3EvV/QmPrE84ecVIj4dk+oOlh+pnkSk+1
         WejITDvRmt/ZDjBwsQMb+8vhnD2siynHEsYoa1svxVsAA9eeLoDtuibnR9EzYQmxJbaJ
         aKdYAK4aFZklBHhrAagboZXhHmQQ40MpDkas45qsW2ExXdadknXqrqj6cx93PUTAr0e+
         OtJ12LH3oDaD7RtzTZbXiXOnDI+AT33ESR8nqqwkVesw+9mC7CrGkmcam9b7kqNh39z8
         Fd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757450880; x=1758055680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=184ZXw3B1fn1QIX/eTt15yZremezaIB+YosahNqj9uc=;
        b=noE5tcbCXxuu5gxMupo0IQBnwkuYF0aFkz0ll8EVs2Ln1Qg9xgtieIR3WEYmxAet2V
         F/Qmy+ajgCj0Lkur50GjaFA/n563NywAU1K2ClUaboz0WJhIrj4wiCRXiolCz5mg3tz3
         su/pYpSmuZPah5xSmqZqnQHA+C3mcRKBMCA3drgXAytNWXQkPMYZRTMEPwl3mKetezM5
         MbkHGBCBk55Ou2Xv8qD5YObL/9qd9+wy9ORtnM/3y1qeezkK0igVhSqCGV3RJdFVLDda
         wRt2mlM5ncpu3eqEWk0mmytjrIKYePoQ+0bDWp3lcZ6yWyIoTWd6+nW9bKQP8Qc41Yjx
         i9oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQ4CYab1hNS/kTunFdPMYwg5Bz9k2RBwDfhicM3VQyHe088EeX8t5NPcEZauwMWjgFAUlZNW/pmuM5xG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFwBo46bTw1InbPkmNyeSEetfLb4tfwFged5HpR9XsNuLs8+Vx
	bwdT6zejFPI9Hgg8qAnMol9UCaGYuVNvLeQVJUrN2UHWQiUDOMH+DWs7VCHkoIcu6IU=
X-Gm-Gg: ASbGncs+wuPU9uCLP4qYHyqH6t9yjIZ7p0vAFTL4eYBQ46fAq3BtokE5SDZULsdVENJ
	AzpN8ldx6HqQuid0DYUZeEY7lkrfjMj8haEeQ7XiULc9CGgcFJXDzYN0HOK9pR/Decl5xt2dliA
	Hi2hYhr7PuhprJdnJ1mMxsP1MR5RmpExVs4764dpgvDxzwsDlMahBQwpQQyrUsw7CpB0mrwQXp7
	/bMskhKzXgFVA0m2k8+oiUFw38tth5R2KKpJ6sDi0F+gwkpCBHg9QZk42thT0Mq1UzLBAH1RNdg
	CKeYRil/SsxZJTF/QNMFpHadhpSZ48Vh3DkdJ5RoaiLO5SGlGzBiXHfzR8c740RyNTjQKfw6FUu
	Pk81TvaHjbjdYCIEMqVQSPJJpiIWHQghmPhpGzMyWDSEn4C+guVM/OUM7xoL8SVQhUEILJAtEbw
	3+sDAD9W53H2v5gj0kpLjxOms7FG7DfxNBm7A/MuZf3ZUsFTDO
X-Google-Smtp-Source: AGHT+IHpgWSPy2hmAWlb3Obg1WsWKgJxeyxZPxZ8ipr0REfO3A0egoHq6HngOEaEDjUet4Asy1EwNw==
X-Received: by 2002:a05:6000:240b:b0:3e1:7964:2c17 with SMTP id ffacd0b85a97d-3e64bfd7025mr8785420f8f.62.1757450879812;
        Tue, 09 Sep 2025 13:47:59 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238760sm3891629f8f.34.2025.09.09.13.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 13:47:59 -0700 (PDT)
Date: Tue, 9 Sep 2025 21:47:57 +0100
From: Phillip Potter <phil@philpotter.co.uk>
To: joeypabalinas@gmail.com
Cc: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cdrom: add parentheses around macro arguments
Message-ID: <aMCSfRXYHkYsJES8@equinox>
References: <13378f5c9cafc29425b6e420cad8b513f4a9f1e1.1757095005.git.joeypabalinas@gmail.com>
 <20250906062819.GU39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906062819.GU39973@ZenIV>

On Sat, Sep 06, 2025 at 07:28:19AM +0100, Al Viro wrote:
> On Fri, Sep 05, 2025 at 07:59:40AM -1000, Joey Pabalinas wrote:
> > Signed-off-by: Joey Pabalinas <joeypabalinas@gmail.com>
> > ---
> >  drivers/cdrom/cdrom.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
> > index 31ba1f8c1f7865dc99..462ee74621da6f32da 100644
> > --- a/drivers/cdrom/cdrom.c
> > +++ b/drivers/cdrom/cdrom.c
> > @@ -408,11 +408,11 @@ static int cdrom_get_disc_info(struct cdrom_device_info *cdi,
> >   * hack to have the capability flags defined const, while we can still
> >   * change it here without gcc complaining at every line.
> >   */
> >  #define ENSURE(cdo, call, bits)					\
> >  do {								\
> > -	if (cdo->call == NULL)					\
> > +	if ((cdo)->(call) == NULL)				\
> 
> You do realize that the right-hand argument of . and -> is *not* an
> expression, right?  How would anything other than identifier work, anyway?
> Note, BTW, that such identifier would not work as a standalone expression -
> its meaning depends upon the structure of union you are dealing with...
> 
> General advise, from painful personal experience: before posting a patch,
> make sure that you have
> 	* got enough caffeine in your bloodstream
> 	* looked through the patch
> 	* tried to compile the results
> The order of the last two may vary, but the first one really needs to go
> before anything else.

Hi Joey,

Thank you for sending the patch. I must add however (in addition to Al's
advice) that there doesn't seem to be a proper commit description
either - just a subject line and a Signed-off-by tag. All commits should
individually contain a description too. I appreciate the effort though,
and I encourage you to make further submissions should you choose to do
so. All the best.

Regards,
Phil
Uniform CDROM Maintainer

