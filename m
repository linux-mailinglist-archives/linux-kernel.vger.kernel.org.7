Return-Path: <linux-kernel+bounces-888775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F5DC3BE08
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 15:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549241B23754
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9ED3451B2;
	Thu,  6 Nov 2025 14:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nDJCPqvF"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7335F3043D2
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 14:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762440419; cv=none; b=bbKCg+jaUAbb0cX/Ey2mjWjN0TRdn+I8fAOwuDR7Qhgcut1ol4fmPT33h4FpRgiEsXY9tobe9gEYV8xa+R4RLpSjMs1/z+HVwdV0gtGPVktCd0o939Zl4Rk2qzHBVMQbrzIOhwLCYZV6qX0C9JeV+Z9B3lHDo0pP6Dprmtbqa8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762440419; c=relaxed/simple;
	bh=DZ1XWRZMG/rus3+GxD8gyTLsrgLZ8TB4RSOF8k7/V+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j06bGPVRrd+uaYlaqmwkg2eXCQ6ZsIFp4nR7uFNV6E41R+lvjKzGbkp7pvG/ihg8GzOLZIHvz8ezwTBs1FnsTJAq0dTQxLurTPVeum324lZdoXjyaQyA05R54AMj3lAVaq9AxY5UF8eEk9QSX7XBr4+cChMBWscTxx4Jiju/P9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nDJCPqvF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b472842981fso83963766b.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 06:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762440416; x=1763045216; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HduGiVleo4x3CODKWMmmltGT7D7OCw+rAdg6aPlkN5E=;
        b=nDJCPqvFJW+LdeRgWtXwv/hBDf/B/acffR+qhA2mQknXIOLeoJitI/HkAmd/pZiCik
         tETNeEZFPKkiiuwQz6TUrFvSVkVhk1L7V5/iw0MqT7ZdXA/z6aU6RNhJRElOQnvukiYV
         OPEa+jypANZTI9P/aY0rZFpzaI/OcjTgBs15IHS7fn8sj+oNDb0Dws8Ls/7t+O5iTQbb
         R6Rn7uR4B2n73uBQcHPMaG3B8pRRJ9llDTSs+Tf9rFkpMe/1Kyha0Tl5/PmD+mdxumWG
         CBdbCCW+9Xvq0PSHRIzw1OKe5kJUqUWZpjSZK5iFIEdGBgJ4lvZjPUOInDIzJdx8634T
         jQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762440416; x=1763045216;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HduGiVleo4x3CODKWMmmltGT7D7OCw+rAdg6aPlkN5E=;
        b=tOf0Tcw6IiOxRVS0FLig2BhI2hyLp4BN51jRWKKa4zDHHI0PSO6X5rnxHJO6t22mfA
         jVSBbYl30nlieYNCsM5RpggLXpfsDBcaFt9WQ+HkRg4DbuDq36hmK3rl3yFwzJ4IaHr4
         1zk62Fda0kxgnKSRJ4dn/8RfiC5VAcGe03nZOfdJLWC90LhYXHosifRUFNNfK9z5g3yU
         XyXRTxCvaVG43xpAa8wsf17DQcl0T1MEBTSSoKXKS0COotmeDZxZSly3JTP3/ceSApiE
         3eY5oCab1s7Me276/xBVOF7FaU09ELkcJZU+SFbpkda9Io29n1Fay9YQzGosiEbomKLh
         VUSA==
X-Forwarded-Encrypted: i=1; AJvYcCV7KQLGXOpTElTCRa+Iy104pIAuPCeLQNKVQAIS2ZoL+fyHHJ4pHVAdxtdaqpIDdNhT4AwgM2MAlCOtMI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKH+aNF2Sm9Cno8vE8JQcuBNIV+dCgtdqGSZTmdKGhsJPL3Ftc
	MWlq0JBkW9G9mOHqV3I83sxsfC+CRzbDZZ+XqU3iUEV6ePdK0adXKbGUMG/lsvuHBGA=
X-Gm-Gg: ASbGncvAoocsW+2t9ZF9TLFg0LTOm4+y+WWhTrFWt2+t8lfGqH9WlV6oQJSFoRwFRQ1
	tXAPA9BIi7esJcBavBvpOsCAwA/zvZvC+u5tcL5w/dg1Ihw3/p9RgF97K6vftp4iYScld0YdJ6l
	Z115L6tytiAZtf1ZeA15GL3istu4xl3F0FX9+BAXMriXw/iKy0tOx+GZvvht3Q+sE0yEXlkoSk5
	/NzINRFdkeH9+FEv5Z3yBOeWNg6EsoY+gzA9QaN9ZxjQBhkxzHvfvq5rsBloAU5VL/FGahWc6Rd
	uOOEaMHBfbXyOQBGVmGoyKWzj8lXppj5dYzwnFT+7pvIDxVLU3e8fygeftAo3PoRWQ+CT7YDwUN
	Bn3cOQ1pKwYj0CIjm15TaJG71ZwKF/oAE56KIhNq7lVQyOfv5g6XdXPl73npkiMJj8yiGLMOyLP
	XSBjJZVNgV/yBZDr2YzJIym14=
X-Google-Smtp-Source: AGHT+IGw86hMYPFdWOfs9zaI9D4V+iRGEIxPznCLyxNtZbZMWrDmTzsSFfcLKNbOfZ7cLvXixIL/BQ==
X-Received: by 2002:a17:906:794c:b0:b6d:2edf:ac5d with SMTP id a640c23a62f3a-b72655a269fmr751504566b.51.1762440415808;
        Thu, 06 Nov 2025 06:46:55 -0800 (PST)
Received: from localhost ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b729d359360sm133796266b.37.2025.11.06.06.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 06:46:55 -0800 (PST)
Date: Thu, 6 Nov 2025 17:46:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Ally Heev <allyheev@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: fix uninitialized pointers with free attr
Message-ID: <f7f26ae6-31d7-4793-8daa-331622460833@suswa.mountain>
References: <20251105-aheev-uninitialized-free-attr-scsi-v1-1-d28435a0a7ea@gmail.com>
 <6d199d062b16abfbf083750820d7a39cb2ebf144.camel@HansenPartnership.com>
 <f6592ccc-155d-48ba-bac6-6e2b719a5c3e@suswa.mountain>
 <407aed0ff7be4fdcafebd09e58e25496b6b4fec0.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <407aed0ff7be4fdcafebd09e58e25496b6b4fec0.camel@HansenPartnership.com>

On Wed, Nov 05, 2025 at 10:32:19AM -0500, James Bottomley wrote:
> > > > diff --git a/drivers/scsi/scsi_debug.c
> > > > b/drivers/scsi/scsi_debug.c
> > > > index
> > > > b2ab97be5db3d43d5a5647968623b8db72448379..89b36d65926bdd15c0ae93a
> > > > 6bd2
> > > > ea968e25c0e74 100644
> > > > --- a/drivers/scsi/scsi_debug.c
> > > > +++ b/drivers/scsi/scsi_debug.c
> > > > @@ -2961,11 +2961,11 @@ static int resp_mode_sense(struct
> > > > scsi_cmnd
> > > > *scp,
> > > >  	int target_dev_id;
> > > >  	int target = scp->device->id;
> > > >  	unsigned char *ap;
> > > > -	unsigned char *arr __free(kfree);
> > > >  	unsigned char *cmd = scp->cmnd;
> > > >  	bool dbd, llbaa, msense_6, is_disk, is_zbc, is_tape;
> > > >  
> > > > -	arr = kzalloc(SDEBUG_MAX_MSENSE_SZ, GFP_ATOMIC);
> > > > +	unsigned char *arr __free(kfree) =
> > > > kzalloc(SDEBUG_MAX_MSENSE_SZ, GFP_ATOMIC);
> > > > +
> > > 
> > > Moving variable assignments inside code makes it way harder to
> > > read. Given that compilers will eventually detect if we do a return
> > > before initialization, can't you have smatch do the same rather
> > > than trying to force something like this?
> > 
> > This isn't a Smatch thing, it's a change to checkpatch.
> > 
> > (Smatch does work as you describe).
> 
> So why are we bothering with something like this in checkpatch if we
> can detect the true problem condition and we expect compilers to catch
> up?  Encouraging people to write code like the above isn't in anyone's
> best interest.

Initializing __free variables has been considered best practice for a
long time.  Reviewers often will complain even if it doesn't cause a
bug.

regards,
dan carpenter


