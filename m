Return-Path: <linux-kernel+bounces-751225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B40EB16693
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C185A163524
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 18:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9254A2E0B79;
	Wed, 30 Jul 2025 18:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MwMFVs2Z"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66862DCC11
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 18:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753901569; cv=none; b=mv0hdmGyN7kqHD86I3gtxj3hau+C9wFKr2RzCt/hiUk2kyQH9TDebETYi/PvjDo/XzTMwsJYQB/XMZ94G3hu2zDwwfD2hebHcshBJiKCe+iJ2WZNd96Oj8tHkW1jkfBh49/XBocCykPtZ0CrYMmn55NnwzMk6w1KlNNOE7P47b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753901569; c=relaxed/simple;
	bh=tpddjbFeE3p3zUkTtUjkjP/V4559OzhrUQ2QMEp2efY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ev1GbDdlEIywCL1bDbhO3Z8o5LrYfQZK12RtxMnxQaz/C3e1TKB/hosjtiKWslunzQfsvQi4pGjF54wSxSkIsdAULx2jKR4DOj+w92SaoooKz5o9I7HHtd6a18Tu/TMVU1u94shyARrldqmrHjVqSNHP5UBl3yB3RzLdu40FY9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MwMFVs2Z; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61521cd7be2so96045a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753901566; x=1754506366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=slAyeWyqtgn0qVMjTiorxiyOrDOZnrQB9QTmFJ0CFeE=;
        b=MwMFVs2ZS/o6tGWVJjqL41FPds96mGf4D5h2U/6LvAcWQb8h4/kd85t8G7Ezz19tYj
         hmNieFG3xL3MFFB+CQT7U50VsjHMQT8gojBsezmrzwDe2AMFwHV8ES++Rg/yzrkpWrpk
         BOCECO5K2hlNovG+WRvFTVUllh8+xYqDZICW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753901566; x=1754506366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=slAyeWyqtgn0qVMjTiorxiyOrDOZnrQB9QTmFJ0CFeE=;
        b=NQeU9Ku86RiOvtduIq7/t+Xe13QxAlvWttMgyNmVjPOtii+sLi9ZBhNXPdzqunKqSy
         mjifjk66xXKCotxYkHar2I16/NEAphxe9udD6K58XORyC0SNfRaz5Mqh6eliXj4noIcL
         wU7ZKY5qWJMD+BcJdjKArxhzqc8002wTylcr8YB65UN5pLaTNmpKxETXKiSFTfFQySOB
         V44WokQxhMX/v4TYZjfBJ4wscWnwpsskD6gDIPKHNY3Iq/mBQlGmuo0eUbpbHzaneJNG
         gy0Sb8OK3TQV169rI7X5qKf2vXsswEStU26VTZqBNTrwu/lCvAEQdOC6dHdNmvTXEJ3/
         6Exw==
X-Forwarded-Encrypted: i=1; AJvYcCXObcY6vmPToC1UTbG7UfisA+N8tnlZJDp1HJwWqQF5vUXjfABrYuHY977+pSL8Kx5hqoctdjcK3rup6f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG1CGBmnhEKgg3qjZMWK1O6LgGEcitX632/O736GbNZfjzN/S/
	KKEH6qN5DlctFAWYqS6vQpyE8o23SOp1N3Zi/Ui+icBxNbag1S8i14Qr0ZNAq0Cg7mRKnbUQhAh
	aR9/RVwk=
X-Gm-Gg: ASbGncs28tFev1xsBKle0yPV8On07wEQ2eJanO29JyxAcm3Q6X9ooJZR69dtvr/C792
	MkkNybueBkaz0n2LJq8cEEoQCGthvZkiyVZIO9LTu7Lb/c+qDJG2IFlV4z29mq2cVJ2B8W63AMY
	XpzwDOylQMC55I82RlNwRtgWP3HeN9hc8/F6sWjk9VJPRb/rT3fdE7pT/XaNpzi2XEfIPgL7FNH
	mhOOeonsmTwNZAiR2CikratczRXLUQSePpP5W9GUG2VsceXZIAnM3Sx+aYHhhxeC+8U+DZPXHQW
	/JMCHu33KnV/LhhzreNRbpTkwXZOpFVxhElnyjpj9ZXzJhedBxdmPgL8XGrfgLjInpkY+D5+Gq1
	xEvNtcy2CYyfQhKfG1FNSegpOiqbhRccIEd+bfosw/wie5brcTpc5anQ/8Br1Xatxw3grWg+E
X-Google-Smtp-Source: AGHT+IHasHapd82Q1lJsA4BURbjIcguYzGRKLAgtowWxQWFWZ2kVZ8qC+fT2U5fje00O5BSzRMsrOA==
X-Received: by 2002:a05:6402:1ed5:b0:615:905a:3d47 with SMTP id 4fb4d7f45d1cf-615905a3fa0mr3059683a12.21.1753901565823;
        Wed, 30 Jul 2025 11:52:45 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a17f1d45sm484673a12.34.2025.07.30.11.52.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 11:52:45 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-61521cd7be2so96001a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:52:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW00cNv6D65YqtCQIY9l/HH99Lf4Bt/Lc6436FeggO2Raj7YN1BApMuMU7ylrd2DgXTi6/5bT0Zp9MtGaQ=@vger.kernel.org
X-Received: by 2002:a05:6402:2708:b0:612:dfdd:46fc with SMTP id
 4fb4d7f45d1cf-61586eecd21mr4741613a12.11.1753901564582; Wed, 30 Jul 2025
 11:52:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <450d3876-90a9-4b1c-8d73-62ac19048991@suse.cz> <CAHk-=wg70=mihHE3_Te=t1Fmvrh22bcEs8bvH3tDEXZd6q+4_g@mail.gmail.com>
 <20250730184724.GC89283@nvidia.com>
In-Reply-To: <20250730184724.GC89283@nvidia.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 30 Jul 2025 11:52:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh_ukn6ESXTLKR9+g9hxVdop0sMe-Hu7AS8dinXGvYhJg@mail.gmail.com>
X-Gm-Features: Ac12FXzOpWstClby8n_gZ1wN_LSRv3bSws6YzxdQ9YiX4spwxDywE66Yp6AB2ZU
Message-ID: <CAHk-=wh_ukn6ESXTLKR9+g9hxVdop0sMe-Hu7AS8dinXGvYhJg@mail.gmail.com>
Subject: Re: [GIT PULL] slab updates for 6.17
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Harry Yoo <harry.yoo@oracle.com>, David Rientjes <rientjes@google.com>, 
	Christoph Lameter <cl@gentwo.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Pedro Falcato <pfalcato@suse.de>, 
	Bernard Metzler <bernard.metzler@linux.dev>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 30 Jul 2025 at 11:47, Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> I think it will be easiest for all if I send a one patch PR after you pick up
> the main RDMA PR in the next few days. siw is not so critical that we
> need to rush.

Ack, sounds good.

            Linus

