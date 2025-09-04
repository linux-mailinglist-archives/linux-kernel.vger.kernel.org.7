Return-Path: <linux-kernel+bounces-801024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E657EB43EE0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52079189F40C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B961EB9F2;
	Thu,  4 Sep 2025 14:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QuD8cdC6"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAD51E3DED
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996216; cv=none; b=OKKGSJmVSAtO2cgvIYiGgP7HJjTLV3bNB2uSCsKLD/vrSqLtOocsmjpSls7dprwg7OXgccCH6W4YnLiLTpPXRxeOLesqq53Bl8eC5t0wKD0SgsBOvXK6dKyDb/+tCxEeSl4hTwCLG/rSteNNPQqOU9dkBfcyUKiP89TRoi4bPFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996216; c=relaxed/simple;
	bh=SMoy4r7xOhWUzWXa8yXnIHpdTbtLR2ZUgQJWwSCvs0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I3lccHyNuGa3wf6MVdCURj+o46EhKhbfiZpeGiYDgBfDB4Aq1SlC13zxFJsMEjH08g06lHaeYNoQKg9N7BROJXwNIzWrO/NnLuRe4Oa6Le3+gfmkyzqSyLRMyDk4zScdwH2VO3tzY3jKeHu+CB6mzjNVgHQeiGuZQ0O17N4mx0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QuD8cdC6; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b046fc9f359so196600166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1756996212; x=1757601012; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ibm8MiGolZEtVcQJ/uFYwNOa8WIjrqmA8IkiSwtzKTA=;
        b=QuD8cdC6kzbuEXynViVZDoCIbYhpJnZaJNCtKRcMz1gWSNibTQkBxoAKnfupvZD85n
         fJv20NQQaTu4ryfNEoQ8yyGwCdPI3L4wAeWqaSKJA9onlLXMjr6d7cqJF001+G6RY7+X
         VazTB2wRs+zxjpvw2WWTw06WhUqTdT9S7q/Cb2yYG7qNVfiHfZPqjmYiVU37xC877w77
         R848UyyVER9GgL7beldM0xrekvSI86R0SZ7LIm3SwW4Jb/5xghR7ohpTSZR+8mD+TekR
         7Q1jq4Uxd2K1JNsNsU6S57mEJPAUHicKwlvm2vws6ynp+KxH4JC1QvlXsgzlJrv4qfve
         ZfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756996212; x=1757601012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ibm8MiGolZEtVcQJ/uFYwNOa8WIjrqmA8IkiSwtzKTA=;
        b=MEVh3c3aIkvhriZ1FtVStoZAHIOz3S4wXNexEs9wKQWVG60WsV0IQxsoxTw+kVwHrw
         0lZnJ2E+IbVEMO7eLXsEq2mAGykv37/3lPgrqjtBGRrHZlIZM2ZoZWZaAuU43A+JkfPz
         BE0+9+7psEWFNy4AjPxGSwX56Wdpet7LQheSSxR+Pd6r/Pq22UcQ7QJmPWf8qPpMpOLB
         2W7H25fPfuXeH4OVrvyM11W59pmYk3pSNarJyDMHL8dbtKU3lFgpDy+MDM/hQBOLlfnX
         nbmBQB1HrAXMFNu9WXaxOrtmGyzoLaEfwMdFluCix360LxVivsqvj7/+totELRn/SVea
         iq2g==
X-Gm-Message-State: AOJu0YzUPxQNpYEpTLfNIhAkFHrZx40EBnfa1LsvKNW1dXUf9/Nbj0Ht
	nBTQ/eH6KvsmUwIIgeBmD13vnhCguCYhd704IPKXawp1x3rtQkltf7ONCs5bQBx7Dc8=
X-Gm-Gg: ASbGnctX/vDnzpsgGsIqE5U2NW48aRSHDUowvoXqAzwbTdmC00em54qZAjCMY+mWLeG
	JGu4UK5pULhZqgJKDfOVwTg6reDXFHgNFpKNYB+/AjQtJYsyERbdNBLEPPJCa96p+sBMYbsZYVl
	GlYeojQRi9IM99UgvdU7TA6255GSFAnL6sWzttr7BrGxsd0TuKWvC8cek2seWQYXK0F3YCHonDC
	GwCxz0+X4suKYwuRDZPvtkKbL8xadglLfEhJ+HlPb5DeIL1Ya45xGsbBhoQGqeT0M+nL34Q02Pc
	5oyP7TwX64wd+n98JRjD1jazlCcH3N4iIjxE9hDxpN9rxvSu1+79e/p9RQeusnTrbMKRufz0Oag
	sUH0LNtquP/gDCrom7nAloEmKlEv7fVQ/A2GCJUl/
X-Google-Smtp-Source: AGHT+IH15AqAG18xK1WJ6gQeKWM2ERwwIasBMS30fm3u7dd3TTvINnMiofmBAvJ3aud/F2dcC+hlhw==
X-Received: by 2002:a17:907:7ba0:b0:ae3:b2b7:7f2f with SMTP id a640c23a62f3a-b01d9718d2dmr2193413666b.40.1756996211487;
        Thu, 04 Sep 2025 07:30:11 -0700 (PDT)
Received: from pathway (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b043fd772bcsm841707866b.14.2025.09.04.07.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 07:30:11 -0700 (PDT)
Date: Thu, 4 Sep 2025 16:30:09 +0200
From: Petr Mladek <pmladek@suse.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1] printk_ringbuffer: don't needlessly wrap data blocks
 around
Message-ID: <aLmicQkB5RRJaxCE@pathway>
References: <20250903001008.6720-1-d-tatianin@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903001008.6720-1-d-tatianin@yandex-team.ru>

On Wed 2025-09-03 03:10:08, Daniil Tatianin wrote:
> Previously, data blocks that perfectly fit the data ring buffer would
> get wrapped around to the beginning for no reason since the calculated
> offset of the next data block would belong to the next wrap. Since this
> offset is not actually part of the data block, but rather the offset of
> where the next data block is going to start, there is no reason to
> include it when deciding whether the current block fits the buffer.

I am afraid to touch this code. I am curious how you found this ;-)

> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index d9fb053cff67..f885ba8be5e6 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -1002,6 +1002,18 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>  	return true;
>  }
>  
> +static bool same_lpos_wraps(struct prb_data_ring *data_ring,
> +			     unsigned long begin_lpos, unsigned long next_lpos)

The name might be slightly confusing because it might return true
even when the two given values do not belong into the same wrap.

I would make more clear that it is about the data block starting
on begin_lpos. Either I would call it

	same_wrap_data_block()

or I would invert the logic and call it:

	is_wrapped_data_block()

The 2nd variant looks more self-explanatory to me.


Otherwise the patch looks good to me. I was not able to find
any scenario when it would blow up just by reading the code.

Well, I would still like to do some tests.

Best Regards,
Petr

