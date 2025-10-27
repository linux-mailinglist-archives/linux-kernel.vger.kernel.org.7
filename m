Return-Path: <linux-kernel+bounces-872655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FE0C11B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 23:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58015466D82
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE7132D0C5;
	Mon, 27 Oct 2025 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnG2PwBE"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52DB30C37C
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604177; cv=none; b=M0IGxL5NLxX9aKJgCBm+zSfXw2DGvRic/dUu/DyN3/uE8PVG1q91HKjPjlj4caCC+I6bsGFnKQn399YKPtcmvtUCxXk3LjeNRqxLFcG936U6F1hND7RDmhsh7K/uICvXRcp5gXVCjIvN1ss6Z28PSkccKEKKx16x7nLZtasz5xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604177; c=relaxed/simple;
	bh=0C1yl0AA49JmE9XLwRyxffj0R5guaYcIk3f9PZ1hd+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPKwh80qcaA51UMN6EbYHPGVhroZiKlyq2iaKE794mqPHxPniadmlPEtseJkXHQ+0z7PCGmidnVtY79Ma6v8uoU6BcGjGl2VaPCehPWyzRGSiCn3oqL+e2lwds8/Tmo5E27H6KmqQ9pFd4FjiN+ErPDM4HAh/mr+mNFQ7eNOLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnG2PwBE; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b6d8b70197cso51508466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761604174; x=1762208974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RE56wPPSVhzI0oadNjkluabeK5GwNJ3pnD3l3rW33bI=;
        b=JnG2PwBETF8wvT2ZcvOCs4655f3/PEA7WPpHBAfeVkYJCJZ/4zu3OPZr8IM28MqeHB
         XK5M/I+bCzHZ0joMqS6C899uuVIBax7Hll3Poxyw6wKWrw8kynwD8V/S+IzWWTee+/md
         1ocKTwqHoQu9Smf0VFNevIMrhcJJ4LV58QwOICElPEIXxudBBJNYLj3sle2tWsiVUB/7
         wyBCJCzY//hEDnTzy1TcWlRD3H9bzhVdrdIKYc49S+3YeHOqwWwHl3vYFPGXKh2SjHZJ
         wxjpl2849RoxDq3QCN30j5kJuVA4PLsxpTzHOJGUSlH43TMcTv3XS1mh5uYDbRQNVKCy
         rMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761604174; x=1762208974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RE56wPPSVhzI0oadNjkluabeK5GwNJ3pnD3l3rW33bI=;
        b=gByYsL3Sqm17T7PfPPhrjncigG3WA47fSZJyVoKj+XNuOKSMagUHkK76zN6iHTQRnt
         U7bplzfX86CackDcXdMtpSWKkW/tQRnVXeVqGZEnQBx0t+BMuHgmiGf62MCXl2WEVy4e
         bBEAz3ZUuVCdD9IHtRzw/q/nj2E91r9aqkfVnPs1jts//0jxCT3wVxVhZ88UrgFYS8zf
         bGr1OamkRBpS/xMHdRTXQlZ03vPDnEFIAsbu4295N/03WjXy0OOjGHdJBV5bgmPG+l05
         4iWM/pC+gBVjfTi+5ilG+yiNEQ06lsI79T+ZoZ5lHwA9oP5h2FNxkAua6fNglEAwkd/V
         ufGg==
X-Forwarded-Encrypted: i=1; AJvYcCVWDFjHkMhYFufnaFWyLw7xaM3t59rqOvDRmdOA3tXYU6I7Kx1fdKVsB2DBZhzbN89Bu9DH15Tfotii8Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YziKX54/hu68moAiFRsACybV1vw9/Ghn4o2vgMCDXx0WFNAh1Nr
	KtOAFEgtJ1uY28q7PY/c84fH+dNLjRhYZOy1WHieveFXFZcdYmNZezPS
X-Gm-Gg: ASbGnctNjGT4PpTJxl/oezpLpVhnIokVzr/xhoGYFhHLM2eRHFr0hOjcJ6rvX7L963D
	iDXrZAmqBQl6aHWgXC8rQCgELHV/e0uZrf8HsOaIqkDF51kd6ihTGrSFZvmONwDuOTTGOrjbJaT
	T4qn/HUI7+Z6zjS0uQjh/ls5dXqZ9SsxNHAdoaPEafkCc7MZOjPAwHz7Xpa16LC5hSAhO4HQHsC
	uv/uSNTCI/hXoehpR7NutVljHrRKistah10a/dNhgkq/QP5/eG93iW+F31lPIxB7F1zeTk9exIZ
	KW+4nABAuwLQDXz65qtdM41MKSwv3t0GMCJaUkVMuk9Zas1BcL7Z5uuodgoc08yuRpK68ODeu9W
	mnJdaDeU7MLt7kFujSrwUE8GHWm0eCFzD3kaWjDp7K807tTIf8Wp6VjiEfJAqcgVhFANUfVVQU9
	Nqxp4=
X-Google-Smtp-Source: AGHT+IFNb/PYIFtOJ/7JMMnUbjO9bbIUFWO6ORtTCt2r4/hNn2eMPmn5diQOKKm+4iULlasCLfApLg==
X-Received: by 2002:a17:907:d8a:b0:b41:873d:e215 with SMTP id a640c23a62f3a-b6dba45b0a1mr82457466b.1.1761604173725;
        Mon, 27 Oct 2025 15:29:33 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d406:ee00:3eb9:f316:6516:8b90])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d8ceeaffasm835503466b.45.2025.10.27.15.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 15:29:33 -0700 (PDT)
Date: Tue, 28 Oct 2025 00:29:29 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v3 02/12] net: dsa: lantiq_gswip: support
 enable/disable learning
Message-ID: <20251027222929.7fhlf63e2piwityt@skbuf>
References: <cover.1761521845.git.daniel@makrotopia.org>
 <cover.1761521845.git.daniel@makrotopia.org>
 <816b2e277d22dae9b3e9e3c4828309a17a3fad7b.1761521845.git.daniel@makrotopia.org>
 <816b2e277d22dae9b3e9e3c4828309a17a3fad7b.1761521845.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <816b2e277d22dae9b3e9e3c4828309a17a3fad7b.1761521845.git.daniel@makrotopia.org>
 <816b2e277d22dae9b3e9e3c4828309a17a3fad7b.1761521845.git.daniel@makrotopia.org>

On Sun, Oct 26, 2025 at 11:44:03PM +0000, Daniel Golle wrote:
> Switch API 2.2 or later supports enabling or disabling learning on each
> port. Implement support for BR_LEARNING bridge flag and announce support
> for BR_LEARNING on GSWIP 2.2 or later.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v2: initialize supported flags with 0

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

