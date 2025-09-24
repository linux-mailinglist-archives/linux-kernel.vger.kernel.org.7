Return-Path: <linux-kernel+bounces-830274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 199BAB99431
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 11:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1286619C15B7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 09:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679BD2D9EFB;
	Wed, 24 Sep 2025 09:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AOFfHhty"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828BA2D9EFC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758707803; cv=none; b=fWgN/m8VaGFm6eBUosk3wt/Aa1P764lSF2jAUqmdilpCDQLcWkVei+eaZy3mXp6GT6yGHcV/iMozLnXTiH9F6yEqgdOFFR+kLBwUxHirhCTdasgr6vrDvtaKzdi613La2Wj9qmNwTTdmMduuM+V75Txx1jQ52P6junEFnt/RXcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758707803; c=relaxed/simple;
	bh=IBAEgyTXCqwNyhGaSkgFoFNYkK8oRthrsdqFIeVuTmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/o3G3sgJ5LYMdKVhiW/TYKSJSpQlerw/8QuDT+y3MoRn8pfgcNoNbR00+fXQ2W7/jzROYxAUjEci9RaolDAoy2Cytj+gII5ju5nOWnO4RPmMTxahQMBjVpgmp498SLI/29vcmAwzdPBHLaJcn+eRW5KwVyNgWhEi8/OtYQHTPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AOFfHhty; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46b7580f09eso22752415e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 02:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758707796; x=1759312596; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PRSL/1nJSQ5kI07UrUanYwK66jzdWfPHTpIh5wL8rXk=;
        b=AOFfHhtymdaEpoWhLwhHTfshOgWHi7xxDrunar23lXqhIy4rMPklm6GAU98HIyiWba
         j76mmLgrZScAyiS9Q8gNRLJVEwaud5YHSakV5/EzjPxX9/1p7IrreesewMbx5FfGxMzr
         JAyuadmgiYFO2aKcwwyxkI3kf/pNMGZphsLFS+I0EOw3DFf/WzR8TlW2+jOZ96Ewk+Pg
         rR9SEujg/+1+/B7mTrZJVgkcqdmPxHvmHcJCNsVdGd1YVzTeRkpHpO+3AmhT7uR1VBQB
         jWgodtGRfv0PWKjKAIMy38UUmSa1XhejhTk4+qqVVdg3WmCApC/FHrfCmosDogawPPRu
         dqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758707796; x=1759312596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRSL/1nJSQ5kI07UrUanYwK66jzdWfPHTpIh5wL8rXk=;
        b=Q0EwHoo9XSKWN2LZLqggKCksr/YziQYLFV9mMFOmnEOy6krsD7LNeydKXIlY3WXkmC
         eRrkCoO+GWojGJYn5AIVCArbKW169wgeEiPmKYH7YPhThPuG5LBRQpsVcP95kZcQ8roN
         WnR/LYJtKWR/PpjeRg7WUGkgyuMManYBGTNNq94Be8kO+IzqTVWlOFqWipFLDGuIT8WP
         k4PNqmYjdT3DexzMr/ILREtjcThbx4eUSWpyX5fCh3BQbGTvjo7k3km9VqlQw0yUJrfA
         /hbmN5MGreJzHkSDZ61BmJXubXWuqccEl+Mwhweo3H/2taczCppii73e6VslGJGz0E3p
         uf0w==
X-Forwarded-Encrypted: i=1; AJvYcCUtc082jqb41nI24FZgrbji4KoDNpZpuRqMHoiIiygoud0Scv+a7kGsVR3qjokVQnymZqtP5RDADdjLADQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxdczjaSXQvMQvCbG8yoDhsRJ9Cwgr3hg3GBIjSJhzAtzWkxdw
	/j3HqXZAAoYbEq/AM8nDR5vIw2YLhA+s6mSLN3xXNy3LjSFU3QZZeCP73h3ZBKf8nyw=
X-Gm-Gg: ASbGnctHkMCA7tVb3yHxX8tgqmEE16bVv5IqcC7QXn3swd9fNsoS5Ms/m5QpOIYwgl6
	k3W8vz34iL+CSDKtLY0ixRqMmugBNzKF92pcBTtrMdd/5ix4fOJj043SoJCoqUJbmbIFpI5yYnO
	2qWXZIPF0nSVd0+JJqZcdoTDRGpKB0nPcA8n6msIoRY7lv/j/+Jf+NNS5E68s6kvV12qOmmQ3tg
	1WBoAJrDAiii6XbaDo9kvDzv7FfWMH16MAaN3VanhswYNYWK+O7XqtlbqcbdvOkoqcmlcdqbAj2
	DhubNzWV6r7w+6Mg/k3kp2BpoZ5FA/u5kJJGtBEyJZdcHIqKgtMz9+TKx9VWMOo2wvXOiogGwQi
	Dq2RYJ+XMN1L87eKWe5NBmQZy+pA2bTvtIxCN+10=
X-Google-Smtp-Source: AGHT+IEV83QRdmbsMqgiTy+g6mdP+Mx8Vek5R5nQm/u5KqDUFtolGSlsI9sVken95Qe9w/ozF+U6xg==
X-Received: by 2002:a05:600c:3b11:b0:46d:1046:d356 with SMTP id 5b1f17b1804b1-46e1dac2e1cmr45790995e9.27.1758707795692;
        Wed, 24 Sep 2025 02:56:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3f70b47ca57sm16940084f8f.0.2025.09.24.02.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 02:56:35 -0700 (PDT)
Date: Wed, 24 Sep 2025 12:56:31 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
	Sumit Garg <sumit.garg@kernel.org>, linux-arm-msm@vger.kernel.org,
	op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] tee: qcom: prevent potential off by one read
Message-ID: <aNPAT_uf-JFvBvkV@stanley.mountain>
References: <aMvV4kK386Sni10i@stanley.mountain>
 <adbccfc0-0f9c-4b71-9fb5-5582c8180ac7@oss.qualcomm.com>
 <bb776102-310b-4a84-943a-86d4138592d8@oss.qualcomm.com>
 <aNOfXlG21HIBR18E@stanley.mountain>
 <CAHUa44G2yaB28sd0FjkjyCNJKXjx2Jg9j-9HXytyvsmiQ3ThAA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHUa44G2yaB28sd0FjkjyCNJKXjx2Jg9j-9HXytyvsmiQ3ThAA@mail.gmail.com>

On Wed, Sep 24, 2025 at 11:21:34AM +0200, Jens Wiklander wrote:
> On Wed, Sep 24, 2025 at 9:36 AM Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > On Wed, Sep 24, 2025 at 08:58:45AM +1000, Amirreza Zarrabi wrote:
> > >
> > >
> > > On 9/24/2025 8:48 AM, Amirreza Zarrabi wrote:
> > > > On 9/18/2025 7:50 PM, Dan Carpenter wrote:
> > > >> Re-order these checks to check if "i" is a valid array index before using
> > > >> it.  This prevents a potential off by one read access.
> > > >>
> > > >> Fixes: d6e290837e50 ("tee: add Qualcomm TEE driver")
> > > >> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > >> ---
> > > >>  drivers/tee/qcomtee/call.c | 2 +-
> > > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/drivers/tee/qcomtee/call.c b/drivers/tee/qcomtee/call.c
> > > >> index cc17a48d0ab7..ac134452cc9c 100644
> > > >> --- a/drivers/tee/qcomtee/call.c
> > > >> +++ b/drivers/tee/qcomtee/call.c
> > > >> @@ -308,7 +308,7 @@ static int qcomtee_params_from_args(struct tee_param *params,
> > > >>    }
> > > >>
> > > >>    /* Release any IO and OO objects not processed. */
> > > >> -  for (; u[i].type && i < num_params; i++) {
> > > >> +  for (; i < num_params && u[i].type; i++) {
> > > >>            if (u[i].type == QCOMTEE_ARG_TYPE_OO ||
> > > >>                u[i].type == QCOMTEE_ARG_TYPE_IO)
> > > >>                    qcomtee_object_put(u[i].o);
> > > >
> > > > This is not required, considering the sequence of clean up, this
> > > > would never happen. `i` at least have been accessed once in the
> > > > switch above.
> > > >
> > > > Regards,
> > > > Amir
> > > >
> > > >
> > >
> > > Also, size of u is always num_params + 1 for the ending 0.
> > > (basically means `i < num_params` can be removed).
> > >
> >
> > Yes.  This is true.
> 
> So this patch isn't needed. I'll drop it if no one objects.

The patch makes the code better though...  It never really makes sense
to use a variable first and then check if it's valid later.  In this
case the check isn't required.

Ideally the code would only have one limit.  We could either do:

	for (; i < num_params; i++) {
Or:
	for (; u[i].type != QCOMTEE_ARG_TYPE_INV; i++) {

Either way works...

regards,
dan carpenter


