Return-Path: <linux-kernel+bounces-876668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A40C1C2E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 17:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B82A585408
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2F53502A7;
	Wed, 29 Oct 2025 16:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="FguPGCXN"
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903E934EF15
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761754166; cv=none; b=Wc2u2+a6pQbpukv7qM2yu94BElLvjgTtRv3NPMi7r2qNRGIOLJoRXai9rjzZT8UgUuIDRAVknvHvUePu4FyvZs58TCcx/yLCsC7RXBlMjjAXELpySjAc7PdkYxdSDGKtznl7c/kqb+hli8+rG7430yK2pHA1+QwGz0lywajrIq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761754166; c=relaxed/simple;
	bh=St+jGXqkVW2dPa/nwH3cBBQelX2l0ubCqkxUgbOntyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X0Da/Xzo2PsdGRAlEyVuf2NCo+7DrqMThVAKQa07EWfiAzbWPwPwiVZUCXbMTDMWsPwMUVy7FhLOB7Blm11U8DPZ4gwNTnpAuZ4G2whLiEYdVlcovVNuaI8Fg3bu/cCBd5Hf+KvHfiG99VaGQ9QaB5LbVmVgzcuiau7GEIMuv9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=FguPGCXN; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8909f01bd00so800220685a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761754163; x=1762358963; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ra6gE4GNLdWG7Tqyy4+9etzH3tIuFsSBjp83q0VcDV0=;
        b=FguPGCXNVN3tRYHin/XFMRv0xFbSQOcfBxYhJU4qwMVoD6v8Imfo9U40y/fyIcRzgu
         YAye1puM68ise1M+MVZp9JV+O7VXIx2rSbSwoLyJ0Y2dU4B6XpFj1a5VwoTKaKvQaHHb
         dQa1f7Q0UgKKEu1vvVMqlMUSj71KIIuDPENisvPiwU6pFzW8PaSXbG2/yZUHTsCGiWAk
         lJ5wcBrv/waUWjYbXtWF49zYNRWfgRI/QtxMMoDd+hoaOQSt/rTv+zcOI+r5PP1prd9M
         81g8Nr9UoE5YU5+n//LKhGu1Bqp3SWQcD+c81l4g9Z/eaHeAFWg4vDwYM8yCw0GV5Dud
         ufxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761754163; x=1762358963;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ra6gE4GNLdWG7Tqyy4+9etzH3tIuFsSBjp83q0VcDV0=;
        b=JUH4D46d1JYZpFEAlTpsW713ios+CFfDflUFiXUXPGEzwb50OBjvQtHC+cwhji7OAp
         ZhSOhWx3lODBKXtxJYnwt3rxasIjB+N6q0oriWB7xNFURzrjZl0tWlBIKL+hbLx9Rjl9
         knG1mQCmcYelXHyi618QYKNAY0vD2oR2v54BH6ZqtopIHg9CkWirk2+X++YmGKdZbAyU
         UC8cwLPseR4T75vpXHq/AJn4Hsuvwmy7VPvqktORyQCaer+arEYVoeylnpwF34iiNSjQ
         QaM2sB3BEKNpzOE5o9qr7CMzVBJdrBMk6ela8oecNXs6XJKCp/KxH0wdu4weBDOOd37M
         m68g==
X-Forwarded-Encrypted: i=1; AJvYcCWnrZ3CQ0Ahqevmv3RliaQFdqIuTFGmcYInjUE8l7dqIrm3a3Uyv6CnHEJ6hSstJpnQFCE5OF0Mp18uw8I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqos81VoJPcKa6RxHLs3Q429a31hdKJLPye/8tc0tIGvP9bhGs
	9/A46Ajw0eAce8Dl+3pgF7K3/fXrUs16jflBA1bmpSA4jgRQ2U39NXkb5AL7PysuM1I=
X-Gm-Gg: ASbGncvkcwIAGD2OgvqdW9bx1tUh7/emLa4Ljqh5PzZTVH/9oHSnVTr0Iz8GgJFdWyT
	DffP+RUDSwRaRBg/cN7oytiM0TpyNzwXUQ4FKRZZyd7o7L+01PhFOqHsbMlqPADnDf5scz3yLRB
	5EMpMLSus70YrBUup3AUFvsEJuCMrUX/AHTH7LC0BaaRxQvYVEw2kZwm6EitNPpknS2eiY0zXGE
	8tTXJgwsJs2pSqnV/xNm/hUyivaVNsA8YJKdnx1BXQa+U4d598aBvWvFJzoy1eTbigA970zEsJ2
	LAnDH1dhQRVLGtL/dz8z5EV6V3UTh197v3z6aObe4KgvdGAtM4RdEYG9Bei0UC4xQ2oVQPT5uDp
	jI2lT5uYS7ivKWB/dZopzhs/1RtX68Ml6z11xDyp5nTB7DvxdbLtrky7HtiFw1bRZImSpAP47cR
	GPQRwuSzHRkJt45709Y1N7gkFTNpNuw+UxUfEfW+wbJFOfzw==
X-Google-Smtp-Source: AGHT+IF6rFnidmIfY6Ro1wANLijusetvx4ngsO9eh8sfxCbTUwpnkArLo2xTU45YJpn8RBXsZSHBbA==
X-Received: by 2002:a05:620a:19a5:b0:866:73f7:25a2 with SMTP id af79cd13be357-8a8ef52d830mr451427585a.64.1761754162225;
        Wed, 29 Oct 2025 09:09:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89f254a41cdsm1078205885a.29.2025.10.29.09.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:09:21 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vE8jh-00000004ztF-0Awe;
	Wed, 29 Oct 2025 13:09:21 -0300
Date: Wed, 29 Oct 2025 13:09:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: David Matlack <dmatlack@google.com>, akpm@linux-foundation.org,
	brauner@kernel.org, corbet@lwn.net, graf@amazon.com,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org, masahiroy@kernel.org, ojeda@kernel.org,
	pratyush@kernel.org, rdunlap@infradead.org, rppt@kernel.org,
	tj@kernel.org, jasonmiu@google.com, skhawaja@google.com
Subject: Re: [PATCH v3 1/3] liveupdate: kho: warn and fail on metadata or
 preserved memory in scratch area
Message-ID: <20251029160921.GP760669@ziepe.ca>
References: <20251021000852.2924827-1-pasha.tatashin@soleen.com>
 <20251021000852.2924827-2-pasha.tatashin@soleen.com>
 <CALzav=egQiF6tanYxR9Tow7TnT_UK9bNAR_4DQ2P=2EJ+H4ZJA@mail.gmail.com>
 <CA+CK2bAibAPzTq+edRTXS9g7Cs0w-zCiSSrXUkoFAHe7=3C0QA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bAibAPzTq+edRTXS9g7Cs0w-zCiSSrXUkoFAHe7=3C0QA@mail.gmail.com>

On Mon, Oct 27, 2025 at 08:01:59PM -0400, Pasha Tatashin wrote:
> > >  static void *xa_load_or_alloc(struct xarray *xa, unsigned long index, size_t sz)
> > >  {
> > > -       void *elm, *res;
> > > +       void *res = xa_load(xa, index);
> > >
> > > -       elm = xa_load(xa, index);
> > > -       if (elm)
> > > -               return elm;
> > > +       if (res)
> > > +               return res;
> > > +
> > > +       void *elm __free(kfree) = kzalloc(sz, GFP_KERNEL);
> >
> > nit: This breaks the local style of always declaring variables at the
> > beginning of blocks.
> 
> I think this suggestion came from Mike, to me it looks alright, as it
> is only part of the clean-up path.

It is the recommended style for using cleanup.h stuff, declare and
assign in one statement.

Jason

