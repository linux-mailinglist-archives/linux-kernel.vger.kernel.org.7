Return-Path: <linux-kernel+bounces-845528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F9B3BC540F
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 15:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C9C3B9786
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Oct 2025 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C64285CAD;
	Wed,  8 Oct 2025 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HU2mQtX8"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C3528488F
	for <linux-kernel@vger.kernel.org>; Wed,  8 Oct 2025 13:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931181; cv=none; b=VF6pm9GpSALiOWz7YjvTLJZODQ4oLlTmlYdI7A94byUakSU4r8+H7zwY+gVZWEvnoA1X/P+2FNW7/CcYeWyX1UOvrzuAimp1wnIOMN/P0Z4EJJc5EICRrpNiam36taAdGeKtCd7cQDaAs+lF0ZHGjWHRBytOcTmhIBmPChyowIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931181; c=relaxed/simple;
	bh=poKv+El8BG8/UMjQs2D9OZaAQnBxbGVnPy1big55qfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qFtX8vE9xt3N11h1RorQwynZMbbn6QB6K53GfUqaeq0ohTs1YXv59KxUg3eJ7b5TXTSZ1+28hTQ8FYGGn/0InasTsevdH36o9xyl47BTA+BU78ZZ5O4JRy+8+RVXQF0T+8H8d2nfoyLCiBE3gkOjchVftT06zEWDbAsAa9yvZ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HU2mQtX8; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7abbdf3c476so5545084a34.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 06:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759931178; x=1760535978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poKv+El8BG8/UMjQs2D9OZaAQnBxbGVnPy1big55qfk=;
        b=HU2mQtX8P1KLkbdeSKI7LJ17YuAtyWgb4gjw4NlYi1zgAtWblKuRMdnl8zPRqdhK52
         e2dWqRVe9cr4xle6tc9Xsz3qgRSjf0Oo3antNNHnBZRpMHyf3yCwjvbK3oz+F21gFwds
         vmjwPhsdjARkAShqtyr68pIarikoh/EY5et/DROk/C/E3i+yGebrP9EVMKWHBUqarg8B
         fnlsp4eAZTmnS1tJHrAS1cAYEiTMPCfwGXUDKYgobtjtDIcskfFbZhgaBCHz7bBJxNPi
         WlMtw4j6KGSmcwQkBngnkUY1LgQ1Y5uqXC8guq9MS9NtK654znLtYmULP2vGvwfR0gnh
         8uKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759931178; x=1760535978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poKv+El8BG8/UMjQs2D9OZaAQnBxbGVnPy1big55qfk=;
        b=D5NbxbhQcQmdjkAzDQMN5lqM97ule/RfCtYmcmmbCT54zV2s3QFfqQyXS8GBi7sqzf
         vTFOImtw3mqx+JdARjlt1X16uf8FvdywI/YA6MolOXnx7s0FvyHiBI29fiBGGEvgfTQj
         Xmrs/X24/iAAw1lqS0yriks7rrx8spDzq8mgRCWmJwBBAp9x0Lgvv1xL2DQVVeW86eRk
         w3ZSBe3j0SSaT3IgTxAlpo5FqQCOyxFun9IItea1/s2OYuxz06GIpkVwpUzQ6FGYSn87
         a5dtUG+DX5Dmknz8F/lmwaaSMOvjbWNlcdQn3SC/EmLm4s11plmLpPDip2tZN7VtGZO9
         l+QA==
X-Forwarded-Encrypted: i=1; AJvYcCU5Zy6JmKnD2i4hcy/gNdIu/8T5uMArPEWYxX9PzMoc90sIlvaxQ5XijkQhwCHY5WZP+va6UtFMyLOdFHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzprnU/n8Ka/h49suLKjemceas/AEayktAdKOxf5d12ovjrmnKS
	KNPh+xNVTkloD1A1/ul2i2KxOuA/z+wqJsHKx2cMJg8U8+xbErWOqBZRyfTscASNSqTrjx1cv1r
	rEnkH2g8Qu7sun85oYfACKYQjZhVvNtY=
X-Gm-Gg: ASbGncuKSMbdb2MsXYoS2bepO1SIWuohEBvIPUcBdfYUJyYmTyf01og8Typ3Q3ncl2G
	DYqj+7ywTWh9TDPlVv5Ek54dTPz1t3+jzv8+c4m8oAk6NOG9pGK2oexxoY12/MQDndC62NHym5n
	9mHBAmUtWpbSrsPkyxKhw5nXkjYWiaFy05EfDbCKzE8tnyDG6rKwuVxG310fMtOS8AJTRr12JtS
	zzuqwDBucz6LvYpO0zS4OJZ5Aj90Kw=
X-Google-Smtp-Source: AGHT+IGs2Oe6LXjYsx6ntjtHgrPiHn8AfOkKNvKB686IELrwhJDW+6bgzbT0XoCi4qIJ9Yn13pmmAnxaNgqtVWHPS+U=
X-Received: by 2002:a05:6830:83ac:b0:745:9769:ea43 with SMTP id
 46e09a7af769-7c0df784ba3mr2595142a34.11.1759931178367; Wed, 08 Oct 2025
 06:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007145028.1845-1-briansune@gmail.com> <aOUv69rMkyYFiHae@opensource.cirrus.com>
 <CAN7C2SDUiuMfPs_X5r0RDC56313aJsfhfx0-juhZRKGTb1OKuA@mail.gmail.com>
 <e78c9cc0-4a1f-4a22-9cba-a8213a7b9301@sirena.org.uk> <CAN7C2SDMB8_b-m0ZMzuSmhHxWpA10mcxxxDMKWuNe6wfiEXo-g@mail.gmail.com>
 <58756837-9be7-4027-b951-401ceeb69e4c@sirena.org.uk>
In-Reply-To: <58756837-9be7-4027-b951-401ceeb69e4c@sirena.org.uk>
From: Sune Brian <briansune@gmail.com>
Date: Wed, 8 Oct 2025 21:46:07 +0800
X-Gm-Features: AS18NWBa5ANTHrUAqNvkDfkjRFyAvcKCEAi2XdlduwOIaXw3SPikZaTxQGwIoic
Message-ID: <CAN7C2SBG2EZ4CJKR_vWKBGsKpZTF_9VJXj7ysLx38nJW3dFxeQ@mail.gmail.com>
Subject: Re: [PATCH v3] ASoC: wm8978: add missing BCLK divider setup
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mark Brown <broonie@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=888=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:40=E5=AF=AB=E9=81=93=EF=BC=9A

> This is not OK, BCLK is 99 which is less than 100 so there are not
> enough BCLK cycles to clock the samples.

With all do respect.
This is not how IIS, left/right-just works my friend.
LRCLK and BCLK must follows.
This is no pure sample rate concept.
I hate to explain my self.
If this patch is not good I just give up.

