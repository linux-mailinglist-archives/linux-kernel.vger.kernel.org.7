Return-Path: <linux-kernel+bounces-874267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F137DC15DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 17:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9C32835564B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 16:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A7A286887;
	Tue, 28 Oct 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNvCqsB/"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410517081E
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761669598; cv=none; b=XJ1akfVwh6M6qPyiEp4uljc8lCdVbTtmExY3xcxMgO8fRyf8S7df3tMyGkIehCR2hkAllQsT0oFvlphwyLo+BYZ+XVLwfptPuAku4T8LCYRIyWtevGDxTPqv/GgEMG8AQQFtZkccN4W2GQSRhPP7aS3sbbnrbq+HTZBVA5do4Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761669598; c=relaxed/simple;
	bh=KDVtgMrR4QbHV8q6n3burehK4NNi/MNvE4NZoYP4CRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1x6wdGkVepr83DyQz2n5iDtEOGJX1ZEBf/n/gDEJhv1Z/BCwez4NTTUMlrIQh0WAycsGJts3yZ06EPYWs5me4vh+w2Ar+M4Jf/Svrq9kAY1eNT0Wr71ZEbFMgRCx9iG/f21K3WAKTIVJZJMzzYo3vymf0I9mDJsUbA4Z2l+8n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GNvCqsB/; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3f0ae439bc3so3940593f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 09:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761669595; x=1762274395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ayPvp3aUy7A0NXAfeV1Yvb5EM2oZXjw1a3kGQLQFivg=;
        b=GNvCqsB/TDGm0z3wDS5rD8wiGQbtyEEW9t9nTb7x8uE2jWdiOdH93eBRjNWVy4jo01
         nuNNCNVGdNbIbgPRI15G/nR03WMACUhc+g9jRP+Pv6Zrdnw28mLsTgqtS8OO0YlX7ogY
         xiGHgDuuJkgrhEFrspssfixdM6qCyH98fx5QP3l9lMbpdNcDfPMAU0Fdj3F8rfnmFTV6
         dTRNZ2S20Yd/W1laHQYJxaiTAwt8ssDZTMyLT7Zi1IsqyBqM1pUoUHvVN8ky3TPv5tQT
         IxQzj1LfczkIX8Wapmws/jbN2NBokuFO5X33jNscDhveydU03bx0+Xp794jmJiVB3hzF
         mkfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761669595; x=1762274395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayPvp3aUy7A0NXAfeV1Yvb5EM2oZXjw1a3kGQLQFivg=;
        b=vss8gzuerDuW30/W6n5lLcXCtCjMAGyCXdlz/dSpeyQ4z6yZeOyfSGMKONs0Y3gjq/
         aMTSPd5K70L+8r4yhKJci0lU0LfZsTjAFakiJbhqQVAQJ+lFobeGWrDr0m0cvm5h+2pW
         KQpU7Mhi7LFMpvbSJIvRoIEGSW/oADDOS9R/l2Ss3xYiB6T614sXzV3iAFppFVCGumu7
         QMGf5Im5U65kmlORpZUgxhpGW3Rs4j6gIuC1mi6ZLUxtz3capWmkq/gYFY3bHxWVOa1O
         iQseFGnihbjzDVIbt89osZ8is+ZnwvQqnpa/fdHHTfrVPYfv2V7G5FMhbugQGRLHtPXs
         Y8yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIkpAusjlrAU2SPQa2yjprfKZF/CTaJnBVhMS4jnaMwK2cTh+nEHOlw83XHknLwTDw7PgpLyvDTyuDJf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIR6+b5NZgMFEoRoFRQxiZdrRKAi9dUsBReuDPErqTAd4VDoKj
	T7GMH0MthqUtiQbrdoBI1k7avdv3g+Eo0oItepu2O69nLK/dGSF8Zw21xXllyc0uGvg=
X-Gm-Gg: ASbGncuK2/0k/enVVUQooqxI71Ij8w4AXA3pNfiPQILUYp5hHkCL0OeJQtE94jxuOqo
	wtdCIapEfNGRevGWjpMxUS1QgbnCKEcqGUsK32PR65jy20y2u+alrvielSx5vtb7Qo68wbdeD0+
	3eb++VD0acdwYXuqbsA2ewU7jZS7981J5OgeoglHCw5KH6axXnYaQZSXWC46MBY8G6vZNglZhcB
	7EZPd6Tn/FhZ/CMnShB8o5BKZJypku3pKoPzaQ3BEYHG9G9GDuJ8swwZMTRUTiNCsIHD2FY+iLa
	tiAs3CuwFuTuXyBiKxGtmdrZxglLh7lKnwH4hWok40h6f6SWmRjA41v8l/KX3nbWW/avmfd9ZC4
	GxxbZK7+Knro6FlEk09Rq2+9Hpf3CDeRnhbUr7rQ1BUiGCaZtnAe9bkSH4/EWx9rPdpGgmRuT
X-Google-Smtp-Source: AGHT+IEZ87hHsKDJtSMUjmPMjPg22H5KbMPCymadPgJhxFMPAVNlY+zHp3R2l0vulAvPGoVtFB6kTQ==
X-Received: by 2002:a05:6000:2383:b0:426:d5a0:bac8 with SMTP id ffacd0b85a97d-429a7e8a487mr3398217f8f.56.1761669595108;
        Tue, 28 Oct 2025 09:39:55 -0700 (PDT)
Received: from linaro.org ([86.121.7.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cbb2bsm21530050f8f.13.2025.10.28.09.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:39:54 -0700 (PDT)
Date: Tue, 28 Oct 2025 18:39:53 +0200
From: Abel Vesa <abel.vesa@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Set orientation_aware if UCSI version
 is 2.x and above
Message-ID: <7jpghdq6so4mxarb22r75gxwxxutcixzkxdshfeyvvfbsazn2l@4mpklf2xw3ww>
References: <20251028-b4-ucsi-set-orientation-aware-on-version-2-and-above-v1-1-d3425f5679af@linaro.org>
 <23b6e21b-40e1-419f-9314-97eb685b9aef@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23b6e21b-40e1-419f-9314-97eb685b9aef@oss.qualcomm.com>

On 25-10-28 18:24:21, Dmitry Baryshkov wrote:
> On 28/10/2025 17:43, Abel Vesa wrote:
> > For UCSI 2.0 and above, since the orientation is part of the paylad,
> > set the orientation_aware by default and let the implementation specific
> > update_connector op override if necessary.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >   drivers/usb/typec/ucsi/ucsi.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> > index ed23edab776354f08452c539d75d27132b8c44dd..84afa9bfc65b6e6ad0a8c1856252299c16562baf 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -1637,6 +1637,9 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
> >   	cap->driver_data = con;
> >   	cap->ops = &ucsi_ops;
> > +	if (ucsi->version >= UCSI_VERSION_2_0)
> > +		con->typec_cap.orientation_aware = true;
> 
> This is not enough. You should also parse the data and call
> typec_set_orientation().

Actually no. That is done by the following patch:

https://lore.kernel.org/all/20251028-usb-typec-ucsi-orientation-v2-1-9330478bb6c1@linaro.org

Which has been already applied.

And no, we don't need Fixes tag as this is an improvement.

