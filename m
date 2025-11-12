Return-Path: <linux-kernel+bounces-896970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F264AC51A54
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 11:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8F041897E04
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 10:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D25307AD3;
	Wed, 12 Nov 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crb3PhBQ"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F75303CA3
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762943079; cv=none; b=DbDWNZ+BWYTxuG4Iz/lbVFxsIbxa4hRAKazZQI+LDF96qUPQwO6isdCEByP0/9AIRObcZVrXb3upMY92Zx3375zojafFMxVJ2tX5Fi5V+ezUMk17HxWx1S6xhhAwVoyJs63IEoBzL85H4v/6YLeiJ/Gay6WMWcGPjZgsQXRFTpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762943079; c=relaxed/simple;
	bh=TSihLUp500EyLAY4SEa7kifFx2y3QU41/npOaDx+y2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2mwEWImd5ZT5vWrp2kkSzG8hjkR4l6NRKuBe5FoDAdA2rLlFzfJxp7kpLTIsoPgbwS2w8O7jp4QYWHmUdRz4KPEvVng08mHmueHbE056OuqljmUJfolR0ImnzFzp1BgWrpx1H9Kx5+66iwKKQOButp57wchW12T9/4AzoBEoJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crb3PhBQ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-297f2c718a8so664225ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 02:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762943077; x=1763547877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thRGHA7lZ4WvBhWmfKrR34oGBTmy7fpmtkgJ42jHEO0=;
        b=crb3PhBQyzm6KXbKhOXYVtQTvo3n08sBbdrnt9np5UTZzIdEJlADC74KV7flWmSL49
         GCyQnvIDZLEfEeAX1xh2OvqbBLryq9M8TF398fBIMzPxipwrULjCd6bxDMPkeksf2JMR
         tb70i+G2FEMMfJIStEdULo1WWlO5UeXuTdHmbrIdfCCZZCGX1CkEusSPgw/nVc0jMknH
         Kk6shyto9CICk8yBWHUBOESyhjT7MlPdd5z1kxB3YiTKeMod5KG7nLDE29CfZljdLBKa
         MvOz/tLq9eUUJ/vDGqTwrXDxGFpj6SU0P/7FWRHPg/0eHML40CZAOBKVLtF6AoMdKMPW
         OkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762943077; x=1763547877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=thRGHA7lZ4WvBhWmfKrR34oGBTmy7fpmtkgJ42jHEO0=;
        b=GqMAQsNUpOx+3VRTUV/jA3E8FCRm0t7L2o4MhtPTNoajqCQOY91G1zy1S0E3jsXGD+
         TN336Q6Lqq0sRwOux+32n6unyWT7NgPDQUhPhFBjU2pLTzOdSwp2egj4XURH6co0CbJd
         gXbf22nMQNtOKcPsBNz3HTUWlr9gjtwGZfIT+pZoHv37RYpWZQcXKlzA4oLogedY+a5s
         oS23Veqyn9CyMVvAmyMMYaIl7iPmW3BFwziYWEYha61BW5mq1zdAZghE6SAcYO2jpzi1
         2783hfKggh9Lo+EFOIReuVKsLu2MRNq64C1Dseiw419S9scQEKw9Llm8r10ESG7adQDk
         HEwQ==
X-Forwarded-Encrypted: i=1; AJvYcCULJMuvKHH/ByvGRXPMIxklYnMOtn32yuEvNLEvVydwcvH4vzV4n5rDHhaF6GaeOQc3R+QC/xUnN5J7GA4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCnYofxmi0hnL4hgoe+fWuSTwaQEdSZ+eqU2NadIybwjHIZzec
	y7BaAfFThipUhiuPjicLft7oRuGS0umAxwSXRajfRDaJcFSd40On6rlCkkEPqR+FTcWesgrahle
	SXckC3HuCxwdP8NhCpWI2S/WfsdPQGEw=
X-Gm-Gg: ASbGncslrnHG9X5ZSMKe8E+Dq8nOMvKpsrFeDzznPZpsV6SyjYzMz3SbvEib4Mdko//
	sstTVamMXLq8AH1gNmM/J8bhU91U134Cq89EexLOgzg1Jif/C0HhnjKh4Rr15sstWAU2muU8cFP
	61I7cZzEVLyxBo/NfC3JlmT7WAWRau/NbVX4SfVAFeyQehv7HEvmc8QmT5R52jRloGPjTNkRGvy
	061H4o1ZUbXMTwcjyUQBtR+CY+dcXsZEqhwyW6u8V5nkGG4jEM1+N5LA/9ey29cV6p+3K7dfC7M
	tD3Rz5tTBwtgss5LttfEovBSgorqPbDNPUur2y+kNJStB0TXPgIZOVVs6R0ei1PcwC1T4iuhD1P
	gbIA=
X-Google-Smtp-Source: AGHT+IFXdt0eC/TNJMhVwjtz0jzvWJqBrfAxSOIG+Uex6LRyLb1AH62t6/E7Goh+RdshjhJ2iPlgpXN/tE1L0o8I8Os=
X-Received: by 2002:a17:902:e84c:b0:296:53b:fcd3 with SMTP id
 d9443c01a7336-2984ede5835mr19538865ad.9.1762943077201; Wed, 12 Nov 2025
 02:24:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101214629.10718-1-mt@markoturk.info> <aRRJPZVkCv2i7kt2@vps.markoturk.info>
 <CANiq72kfy3RvCwxp7Y++fKTMrviP5CqC_Zts_NjtEtNCnpU3Mg@mail.gmail.com> <7f3bb267-7cff-45e1-84a7-15245cffd99f@de.bosch.com>
In-Reply-To: <7f3bb267-7cff-45e1-84a7-15245cffd99f@de.bosch.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 11:24:25 +0100
X-Gm-Features: AWmQ_blvUG-sHnAQM0zxhw6lztFvEbWamDmMnEK-LJSwP8G6De2JOOAOnCidHdE
Message-ID: <CANiq72=xZ08i3MFqXyxFG63gq29EUggoyb57SJWPNW-Y_VFqqg@mail.gmail.com>
Subject: Re: [PATCH] samples: rust: fix endianness issue in rust_driver_pci
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Marko Turk <mt@markoturk.info>, dakr@kernel.org, bhelgaas@google.com, 
	kwilczynski@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 11:17=E2=80=AFAM Dirk Behme <dirk.behme@de.bosch.co=
m> wrote:
>
> Hmm, I can't find the initial patch in my Inbox. Even
>
> https://lore.kernel.org/rust-for-linux/aRRJPZVkCv2i7kt2@vps.markoturk.inf=
o/
>
> doesn't seem to have it?

It was only sent to the linux-pci list -- for situations like this,
you can click in the "[not found]" message at the bottom, and then on

    Message-ID: <20251101214629.10718-1-mt@markoturk.info>
    found in another inbox:

    ../../linux-pci/20251101214629.10718-1-mt@markoturk.info/

where that last line is a link to the other list that you can click to find=
 it.

I hope that helps!

Cheers,
Miguel

