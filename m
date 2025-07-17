Return-Path: <linux-kernel+bounces-734633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6932B0842C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20ABD1A60FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 04:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4360A202F8E;
	Thu, 17 Jul 2025 04:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vePLrTIz"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5257BE5E
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 04:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728167; cv=none; b=sz8OIWtGb2y/LbXcStj0xRQLtb//Qp48ZWHU0DY6QbMMAkYOKCc2GnRPFkhSM6FimoK8XW3G+ODBbN3sAKHFIEbUnmbHaqGyR3kH+zkZLKDc2k2HAmHBGTvkQZz6sPblroFhgaF9i1MRwFeK61Q0EE7TeaRkUCPy5htNHElC4sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728167; c=relaxed/simple;
	bh=QSPPpdjiCgbm71LufB9qfPMayTfg7vGy5VVrEX1c/B8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZDcIa23s+LGToEykOsvlC2AUmk4Z11+zehrT8j7acx9pj7M4SWqmmzj1PEMvj+D4J1UA0OcXiLlrvWEhMe6S7dFd3Qfx6kxYjzL4X4VDYkDUuHTMyN+oYFB52VbXEtTX9aSxTi47+XAEnhI8uoWeECjwk2+EjKwkK3BXAZIEMmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vePLrTIz; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2ea34731c5dso478201fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 21:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752728165; x=1753332965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wA9OwdCE8eIhbOlePq6ADzlr/9GCVKPNA4d/k7TtyMI=;
        b=vePLrTIzPbviP6AVoE787fgchLw384a41d1VFw9sZc/eKR7l/m7/iFGXSlczySYbK/
         dZ1QaTMPBz2OsRVpnKWi56IMSjzb+NY3AKzkE2ayBJ3zFW3XIQBH9fYQLD5Dk4PjTa/2
         KHp3P1rpVYuvYLZYSLKrmeAHuQ4CGj2iUaqG3CB/0g/hWaYKC9sncoa5GZy6hJjUkVUl
         dvc0rRJ8111MiyXKWNUt1cKC3Tdh6f9cs6i/UiXYJSyNKm0uXmcFzfSsw8HvchdH2rqT
         4Z5ui0PF2BNruVI/BaidpgWp83sL9oIrPViy+lyyLxa5+Cd7+MqFzzzFiZ04xeIe26lP
         asGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752728165; x=1753332965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA9OwdCE8eIhbOlePq6ADzlr/9GCVKPNA4d/k7TtyMI=;
        b=NT86OVadeeZ3TO1pfzOajkPFb9yGoVklY5gojm15ZVqY2On2e/EvpCHh8GVS3Mvyki
         +LImMTgvAbk6b45f4ENGLooAhtfdd2Dg64x9Fmg+/+0sXA3wkqsfikG0Gfe3RtCZ5Idx
         rIA70ETyNUV+cmoZ1nqIqydyp7NgzQIE8USTqGmLj0plNTWXEvcnpryqgobH9Xy/SDbU
         vzFSjUAOOKq5dYSN+yA1PObybe2p7/ZosYEdFf2dRXcRAHoJ5r+vA5/tl7EsTcYoe5eu
         ALZ2zJNsfmECKg7AEQ/2D1xxRCDey1RLapXxDpcVAd6Aui8LThxAH3MvdfpfNyeqw6zu
         GC/w==
X-Forwarded-Encrypted: i=1; AJvYcCXzNSFjSGc5vkArND28MWbzdn6tRGu54GNh+EjxgjhfVAwgiGOFIIaG7mnOhe5DHHXL5nXj5C0Qod577c0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSxutP60pL81KJgaHHKGUAZmPXw7lidHKaRdrknHF8wPiiMS1p
	0/6RdANNrRDGrr5NRV4JpzgCfedsIaOpsKbYeBq5oqwOS9lU2MTCQuZVLLxZSRRXVGY=
X-Gm-Gg: ASbGncup+hPoNu4KfoEXpp0JEtgKTePQkTTr+l7SvAinY1LfXZGy0FTJVoUhr4YZiHc
	dfBfXEWlNsJYXFfB5sddfK2qEV1X0LqG2N7A8/QaTv89vDwsCAe3XENxxITXvOch3XyvWd/6SEH
	7gtyoEvwUe6XH6iwuoe39inyuinTjiJ4TMqoKVXr3iTP2SUm1SPGLP0GZaStbSaRw0kpzu8Dumm
	P95QBH/xA0ewcnHGb14PObOmHeYegdWhGM9B1IQ3fgDEHpnXQAgmlcpNeoVDr0b+oqZdjEcwwhb
	m3bIumI2GUhiBQVH4x6dvWGpHdg8jFOvHePZAUs8PuXKmHnNlQlcmjW7MdWDWevY8HjgsQm0IGF
	SIOVJLsMJoFDo1WO+YT3/QPnR4LC6DIuPqEhjpvQ=
X-Google-Smtp-Source: AGHT+IGR0DWY+RgBfgz02jJwa7z2iGG+/Sq+0RXAC0URhjVOZTXMc0+fpwm5U0mKQklYBMr0tBVsEg==
X-Received: by 2002:a05:6870:9626:b0:2d5:ba2d:80df with SMTP id 586e51a60fabf-2ffb21eb6a6mr3622667fac.8.1752728164899;
        Wed, 16 Jul 2025 21:56:04 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2c38:70d4:43e:b901])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff111c36a0sm4116929fac.2.2025.07.16.21.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 21:56:03 -0700 (PDT)
Date: Thu, 17 Jul 2025 07:56:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Antonio Quartulli <antonio@mandelbit.com>, linux-nfs@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Konstantin Evtushenko <koevtushenko@yandex.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pNFS: fix uninitialized pointer access
Message-ID: <b927d3dd-a4ed-46d7-b129-59eaf60305c7@suswa.mountain>
References: <20250716143848.14713-1-antonio@mandelbit.com>
 <h4ydkt7c23ha46j33i42wh2ecdwtcrgxnvfb6c7mo3dqc7l2kz@ng7fev5rbqmi>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h4ydkt7c23ha46j33i42wh2ecdwtcrgxnvfb6c7mo3dqc7l2kz@ng7fev5rbqmi>

On Thu, Jul 17, 2025 at 03:27:50AM +0300, Sergey Bashirov wrote:
> On Wed, Jul 16, 2025 at 04:38:48PM +0200, Antonio Quartulli wrote:
> > In ext_tree_encode_commit() if no block extent is encoded due to lack
> > of buffer space, ret is set to -ENOSPC and we end up accessing be_prev
> > despite it being uninitialized.
> 
> This static check warning appears to be a false positive. This is an
> internal static function that is not exported outside the module via
> an interface or API. Inside the module we always use a buffer size
> that is a multiple of PAGE_SIZE, so at least one page is provided.
> The block extent size does not exceed 44 bytes, so we can always
> encode at least one extent. Thus, we never fail on the first iteration.
> Either ret is zero, or ret is nonzero and at least one extent is encoded.
> 
> > Fix this behaviour by bailing out right away when no extent is encoded.
> >
> > Fixes: d84c4754f874 ("pNFS: Fix extent encoding in block/scsi layout")
> > Addresses-Coverity-ID: 1647611 ("Memory - illegal accesses  (UNINIT)")
> > Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
> > ---
> >  fs/nfs/blocklayout/extent_tree.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/fs/nfs/blocklayout/extent_tree.c b/fs/nfs/blocklayout/extent_tree.c
> > index 315949a7e92d..82e19205f425 100644
> > --- a/fs/nfs/blocklayout/extent_tree.c
> > +++ b/fs/nfs/blocklayout/extent_tree.c
> > @@ -598,6 +598,11 @@ ext_tree_encode_commit(struct pnfs_block_layout *bl, __be32 *p,
> >  		if (ext_tree_layoutupdate_size(bl, *count) > buffer_size) {
> >  			(*count)--;
> >  			ret = -ENOSPC;
> > +			/* bail out right away if no extent was encoded */
> > +			if (!*count) {
> 
> We can't exit here without setting the value of lastbyte, which is one
> of the function outputs. Please set it to U64_MAX to let upper layer
> logic handle it properly. Or, see the alternative solution at the end.
>   +				*lastbyte = U64_MAX;
> 
> > +				spin_unlock(&bl->bl_ext_lock);
> > +				return ret;
> > +			}
> >  			break;
> >  		}
> >
> 
> If we need to fix this, I'd rather add an early check whether the buffer
> size is large enough to encode at least one extent at the beginning of
> the function. Before spinlock is acquired and ext_tree traversed. This
> looks more natural to me. But I'm not sure if this will satisfy the
> static checker.
> 

No, it won't.  I feel like the code is confusing enough that maybe a
comment is warranted.  /* We always iterate through the loop at least
once so be_prev is correct. */

Another option would be to initialize the be_prev to NULL.  This will
silence the uninitialized variable warning.  And everyone sensible runs
with CONFIG_INIT_STACK_ALL_ZERO set in production so it doesn't affect
run time at all.  Btw, we changed our test systems to set
CONFIG_INIT_STACK_ALL_PATTERN=y a few months ago and immediately ran
into an uninitialized variable bug.  So I've heard there are a couple
distros which don't set CONFIG_INIT_STACK_ALL_ZERO which is very daring
when every single developer is testing with uninitialized variables
defaulting to zero.

regards,
dan carpenter


