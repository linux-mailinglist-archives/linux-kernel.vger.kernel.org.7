Return-Path: <linux-kernel+bounces-858281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B239BE9D8C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 17:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B4BB6E7E1E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 15:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C503328E3;
	Fri, 17 Oct 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="foes8srf"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E831B337112
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714011; cv=none; b=fxENerlRynH3/hr3W3CHFZPNvjAPXbzsKiPFV9sbq6fj98fxI96PzSRtPSEbfAZ7XRXA/UhGeusdhljjkrw31fbS43mNgLwauw/pP1CVKLuEQDxY5saH08eZXWahNRPCAC8b+rC4GfC/+k5/enkLVGA+kMGs5XO9NaMX0kp4rTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714011; c=relaxed/simple;
	bh=h1vSaeMkrN6H8hwYfVzjt+o4IKkESrHOBhkN1Xl16MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lPDtbl3Q1yC65xaWtubSUTrtF+vdB5tD7iRGax21vP0C2oevtoWzMMxCM8+HPHRyHPEmse2cYYkC0XM9aOEShIkOPdS/TV3xMw+gJFbWkQMektgfgiTlLTkEQpk7AXUqKos1KqUP3Us/zWVJr1qnlRabEczZcVOCC2xWLT2OP/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=foes8srf; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-58877f30cd4so6737e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760714008; x=1761318808; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rSsE1dDRHw3HK9cZwjvWv+2rdYfMTeH9WPkRsLkpr8c=;
        b=foes8srf5tsDu+qKgdbD8IqSRYpCOcycJQDQyWj/JzSgxF8J1QHriMY7U3ahktkx/j
         0kMihX5EX1U7b+4iYrnqREvvascY4nuww1RQ8JsA+uIRqaVZceSUOuBRHwaOJ1xapA0G
         u2pARSrhx+3GhdXvB7itizzpYkbrNQ4iC9uGNW1JMNj+LPpcyDayXj6GqjfhC1D+f4JI
         tOKZNa0eG/UiPp5qZjkTdZyBv5HXRB6RGwJs81LgXBuG4xq/hQrVo5a8JrB8yBwey6gp
         wp+IlooHtZW+FrHMdWhz2mRT6VdEegVus4KTGP7y1rMa+pHRReWS4wzc1z1iUtYzuOrs
         +bnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760714008; x=1761318808;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rSsE1dDRHw3HK9cZwjvWv+2rdYfMTeH9WPkRsLkpr8c=;
        b=faxMjes0YzHTTLKi5F+aKArnyVS5HBE9RX0byHqr7JawFzeCWI4Gn/ibn4yj1UCKrs
         l6r/AT4rdA+6Rd+1/4av7iyYu9h8yxuFue39wBb8SeAxBDu3l2xCjcE42jdwRv92iNy0
         Q5+V4bnvqoY3lpOUETRlRYlAv+xTy5n3WCFMB/NjpGgmVeKdKKj1o4Pe/rtH40R4J2kf
         3cmJ7RwIRt4OMs3CKJ3iau++5KI80vdTz/mfE9nWftaP9DXwpPkh2CZZ5EbH8W1NTbqy
         AyyeD8nSt5eQoKv4/KA1axG62z1ldQzjgwkc7MMAVXlRCa5Rc5CGfdQyXXRwfLdLAK4d
         ilgw==
X-Forwarded-Encrypted: i=1; AJvYcCV+TmeTEDJ0yC1lW6i/v5Ou1Ws2Hy/1vOC/msNn76zWQ8HIDjJuUOZ6XRfgUiWIzRO8TZSod0OcD5sJ75s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwh6IfY9M2Dr6ogX25E4t2b539Oo/DrcoHl1ybcwE8rj1HZVS4
	aH2J38l8UefhGi0k/w/2CasSLnFTGKVLojfwehplkQSKWRrcdZOXNrsufjC2efatH4XJAkmefbA
	YF/h4a3I5doKfW0a2+2xUBFKZPcGpS7HOb1isjBNL
X-Gm-Gg: ASbGncsgBuM5j5kv33ooziUOCLIALADIr+YalDIrWj54r8u18qVNRSZGqJIsT7lnsrE
	S1fJ93jQrW4d03/Icda9RFQMqDhfwr7fxmFzbxg1jvNgOikVTSN+ekH3aWQZWwGNaglichJVYJH
	bWDurN8QZAhvg3O8BHgEx/hrvkCiSWsOl4gIZrQl91l9LGeDcGPbzGncBshgsewnBvUbLTA6UQ+
	RqSS5hMysKbs3QFyIzXXgeKVyEmCTOBRACmY1VyQY6JyPilSzd6Tvd6mtDcIA==
X-Google-Smtp-Source: AGHT+IG2yYV1soOtTVbTodBl20gDiFrFLFitvWrizx0r35BbLhSYj1Ej+lir5/F2pMqQChZwo3lfBx+k+TttDJiVSEc=
X-Received: by 2002:ac2:5617:0:b0:591:c7a5:2d1f with SMTP id
 2adb3069b0e04-591c9ff1e5fmr900210e87.5.1760714007654; Fri, 17 Oct 2025
 08:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016063657.81064-1-byungchul@sk.com> <20251016072132.GA19434@system.software.com>
 <8d833a3f-ae18-4ea6-9092-ddaa48290a63@gmail.com>
In-Reply-To: <8d833a3f-ae18-4ea6-9092-ddaa48290a63@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 17 Oct 2025 08:13:14 -0700
X-Gm-Features: AS18NWDrNTee2iN7Yt-3RFBdnvbfwlm0owIMUwyA6-MIhPexgaRgEJJMm-KEnqI
Message-ID: <CAHS8izMdwiijk_15NgecSOi_VD3M7cx5M0XLAWxQqWnZgJksjg@mail.gmail.com>
Subject: Re: [PATCH net-next] page_pool: check if nmdesc->pp is !NULL to
 confirm its usage as pp for net_iov
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Byungchul Park <byungchul@sk.com>, axboe@kernel.dk, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, sdf@fomichev.me, dw@davidwei.uk, 
	ap420073@gmail.com, dtatulea@nvidia.com, toke@redhat.com, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, kernel_team@skhynix.com, max.byungchul.park@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 5:32=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 10/16/25 08:21, Byungchul Park wrote:
> > On Thu, Oct 16, 2025 at 03:36:57PM +0900, Byungchul Park wrote:
> >> ->pp_magic field in struct page is current used to identify if a page
> >> belongs to a page pool.  However, ->pp_magic will be removed and page
> >> type bit in struct page e.g. PGTY_netpp should be used for that purpos=
e.
> >>
> >> As a preparation, the check for net_iov, that is not page-backed, shou=
ld
> >> avoid using ->pp_magic since net_iov doens't have to do with page type=
.
> >> Instead, nmdesc->pp can be used if a net_iov or its nmdesc belongs to =
a
> >> page pool, by making sure nmdesc->pp is NULL otherwise.
> >>
> >> For page-backed netmem, just leave unchanged as is, while for net_iov,
> >> make sure nmdesc->pp is initialized to NULL and use nmdesc->pp for the
> >> check.
> >
> > IIRC,
> >
> > Suggested-by: Pavel Begunkov <asml.silence@gmail.com>
>
> Pointing out a problem in a patch with a fix doesn't qualify to
> me as "suggested-by", you don't need to worry about that.
>
> Did you get the PGTY bits merged? There is some uneasiness about
> this patch as it does nothing good by itself, it'd be much better
> to have it in a series finalising the page_pool conversion. And
> I don't think it simplify merging anyhow, hmm?
>

+1 honestly.

If you want to 'extract the networking bits' into its own patch,  let
it be a patch series where this is a patch doing pre-work, and the
next patches in the series are adding the page_flag.

I don't want added netmem_is_net_iov checks unnecessarily tbh. These
checks are bad and only used when absolutely necessary, so let the
patch series that adds them also do something useful (i.e. add the
page flag), if possible. But I honestly think this patch was almost
good as-is:

https://lore.kernel.org/all/20250729110210.48313-1-byungchul@sk.com/

You just need to address Jakub's review comments and resubmit? Not
sure why we want to split, but if you want let it be a patch series
that does something useful.

--=20
Thanks,
Mina

