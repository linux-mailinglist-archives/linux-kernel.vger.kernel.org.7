Return-Path: <linux-kernel+bounces-847217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFA5BCA437
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 18:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D9774E4628
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 16:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 178CE23817E;
	Thu,  9 Oct 2025 16:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc1PX2qs"
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236F42367CF
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 16:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760028955; cv=none; b=elXbZUaGyDEBr2JjhH/Y/Q6EfeXcD6GEP51dGAoOM6Dzr7/gvSpdFuaXjj6RJdM60x0iY5K3E+fy+qGIMz/vd+5TW1WM7yyq9HeSCFk1F/kqK+lFZD/rDTbjN7MoXm5Tu/m7O1GXVuYPZBCT8e+DjEHs6bgiuVmlWxFw+NtRRxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760028955; c=relaxed/simple;
	bh=R3CLaJhA7gq+Og3P/cSRClmlVF11WIVSyo2PEkqoTNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNGqwdD6xTbia/L54KK/EJ/g+RGJSpSAjdeR5lbfsRgj9nsR9LXh9hnyFe5FFnTG6NJt8Z1S3F6wQnp8SXMT0HbarcAlKqnpuW12Fzfit8iLN5uZRI1xW4Sel76uz7mInSTM2jOGNLO5XlpH+unCCT2lT0PEr8yz9CY0xlHc3Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc1PX2qs; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7abc631ae5cso896681a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 09:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760028953; x=1760633753; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3CLaJhA7gq+Og3P/cSRClmlVF11WIVSyo2PEkqoTNM=;
        b=Gc1PX2qsHRXZY4+c/sANi05Mt3H6Cxf4+Stk1CraSPr68I/fG7i4rXOr/PzL2XCrv+
         FZWrOvr5c3XMYUK/l+HlOocbm5+mTxRz0LpG8TSWsI6WQSTrlE6nSQlP4iOKzrrt6axW
         o+OJT/ebKZ8TZzGtZEULv6EQaONCu0XxouwCJC4AaVso+AzaQOPWRYZSH55lHB6bs4mA
         8esA9npHgMLdj4fzt3eg+Quc1jSBBp2jMS0QcAM/X4ldRlV5uosJB5E4IOOyUKy0Vwli
         trDc5JpklFl9fdKgcUDlPJcPDzdWJjm5i3uBiKZV4X/nPBLtG3/JEqyUWTwmAnaTNuAP
         jsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760028953; x=1760633753;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R3CLaJhA7gq+Og3P/cSRClmlVF11WIVSyo2PEkqoTNM=;
        b=K0P0zWThqiRj84mdYYkzEJ3DWDY/sAjjYz6SsJzhKFTvkKgVYEhuZQhrVU9RdtPLVe
         kqhDUrvxhH9VZz7tYhjWz0fo0EVGEOMVA+iLS7Ww3kPnqu5spUvCZgFXQePiHtLL7WpW
         Vww4/PFbn53lCHAeQv6ztjvpZSihM6lD961PkM7HOKao8khwRdeAFssnFP6AE0Lkf0Pk
         0RZoT4lk4IN/5xFadQU1WDHO6QQ+B9UOwF2E4zxDpGU+2ygvWjm56ibl0EUPZYCR5u4H
         6+JlNIKq6GV9CfpPK0pViGplAYE+yDbk3g35SLHxNSwnIVO4ZC6FbfB0HDoV2Uta1rnD
         2uNw==
X-Forwarded-Encrypted: i=1; AJvYcCWJLwOQN7QZ7bP86g6UpSn/Z5nDCUw8FI3LVZpNgeKGvNgPnZ1e2rmMtNebJTGasdDuMqQEUT1UoBtXqGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXMFIJUttk0iIIvzcrwuoOeaORivt59z1dyJItSnm+I6QwQccb
	oJfYcuF4+3DvZDjLattql8VXxE00hG6fNtixGBk/bhMh8OC8umSusGAwvF6cZsquXKXi1HBumhK
	bg9stzLvzolYV/Uz7zwFoTDwX9RQn3XQ=
X-Gm-Gg: ASbGnct8CxmgvrV+p+DrjXHmXQWRGFNRX9zAkJHFWLYW/aTB8JjaLoeVo2eNprewxal
	IqF+fOFW3ayT0Qi4RapqYkci8e76lbaiWfGl7YP2Ljf+QdrPF+M4Fd5/Cho4J+0ON1CmXkZ6iEr
	ypVN/FVNwQilW3gTUNhMR8LBaTG+X9NQsy8gIS4d1JSUVDv22dLiMYWyxmlMhFIq3KEQLaoEWYT
	FzHv0TVx9uDtLsh4cG/Voh3snNtmEleuV9Kg5fqRll4fdjOit7F
X-Google-Smtp-Source: AGHT+IHLf0hz1LIW9mLUgXnTIY3sM3Q0Cu7moc3MCOrYonSnvCG+5CrCxjzhF5mjp/OiNtzpnxefy8/ost3y9B9JgJI=
X-Received: by 2002:a05:6830:368b:b0:78a:1d62:ff20 with SMTP id
 46e09a7af769-7c0df7e01d5mr4719404a34.30.1760028953205; Thu, 09 Oct 2025
 09:55:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008205207.1781-1-briansune@gmail.com> <aOd9yUj9H4L4fbtc@opensource.cirrus.com>
 <CAN7C2SBd8tDXG8OkjRt0sDw1OmtrLgtuStEfr=f=JHZMRvjq9w@mail.gmail.com> <0167554b-c3b9-4cc6-9382-d378e5b1227f@sirena.org.uk>
In-Reply-To: <0167554b-c3b9-4cc6-9382-d378e5b1227f@sirena.org.uk>
From: Sune Brian <briansune@gmail.com>
Date: Fri, 10 Oct 2025 00:55:41 +0800
X-Gm-Features: AS18NWCG0agAAAno9JmFiOQg3dDw0wh1zt0svMJv0yHR5M3Ofn0geI28L4Z0CkQ
Message-ID: <CAN7C2SD+9Sto7LzFSe6McTSTaEhwHQP4L_yDAdzbRdELbBfFZw@mail.gmail.com>
Subject: Re: [PATCH v6] ASoC: wm8978: add missing BCLK divider setup
To: Mark Brown <broonie@kernel.org>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

TWFyayBCcm93biA8YnJvb25pZUBrZXJuZWwub3JnPiDmlrwgMjAyNeW5tDEw5pyIOeaXpSDpgLHl
m5sg5LiL5Y2IMTE6NDnlr6vpgZPvvJoNCg0KPiBOby4NCg0KUm91dGluZSBjb25maXJtYXRpb24u
DQpBcyBzdWNoLCBjYXNlIGNsb3NlZCBvbiB0aGlzIHBhdGNoLg0KDQpCcmlhbg0K

