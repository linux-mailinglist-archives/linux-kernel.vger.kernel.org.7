Return-Path: <linux-kernel+bounces-779909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D06ACB2FAFE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A15B17E47C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E83343D8A;
	Thu, 21 Aug 2025 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GXGEQuDK"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB6028DF36
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783445; cv=none; b=UfI/rx5oxkFYPpn/izWcN+mTM5Hb2Q12WM54UoOAY+/puv7YW+gHIulmu6QiX5nfe6Z7QZxd6uc+zIzDmjaqKoQZcoLLOod+VJ11Jq8n6h2haRg3skAshcGbvg0SVYCvtz0iim4d05DC0dBb7k2eyNiQ3+sxvQcAyxIgqk6G+48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783445; c=relaxed/simple;
	bh=S0tBL68alPBoiQhQgrLoetKbMqWhl6PN9VracU1Lsqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6u6h0lj1HyDVQU1duVQpqk31whnAmJ7XXiLOhkNwLFPLbSLA183lYC/Pk8LZB8e/szizV3GxAZWvrltue/AB4aEGAZxd5+AZDMe1QolzRU9pAWhrDh7kIy2wRQ0uh1HqKEjzb9/wXb1XretXCYkI1icctrWL1hlY872cz8Iy4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GXGEQuDK; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b476cfc2670so651618a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 06:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755783443; x=1756388243; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f6+lAEs4MsieSPVTZ/E6noXDmgaG1ojns092XrliUQI=;
        b=GXGEQuDKygPgA6sauxw3gpZWBZNFVB+EqqYHrcw4+wBMk4VHYiPU+PRAwNTFfPOEEN
         LiaC/JA4UanPO0VRj4Vwmf2F2B3s4Qeq0dRqzWQDGt2ifeFU6tRUai/2SsOIn1zIg5Mr
         kCw60fpZlQ999Ym28/UsWwj1iVOg0enFaTi/tnI6+NcrkRwUs0vgVBi2GCiupXU7IaBu
         pF5ebsngWkbsNa3sSNHcYhfWHqQw4CZWAscf6vmdm9r6Kw2KcgK2mUFXeZ8BDPDY62fZ
         tbtX13yAktIj2HNwaDGt0SnfuVFJi7t5PpC5ZJVQKyPjjtFs/SATgO2P09oFZkbCKAxC
         9ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755783443; x=1756388243;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f6+lAEs4MsieSPVTZ/E6noXDmgaG1ojns092XrliUQI=;
        b=Ph04r0iO3t4BXoDiD6gGb8F+0xqDZn5ZApYk97KnWaTFgB7ShmuZ654QR+VtYUOe/i
         qGqgm9ckx67dRgbhaelAKTs4NcR3aXDMquZCJOXXPi7Lof0brdN303VlUp5ujcJRYcHC
         0DHX7tBrSNQkFtyIkNhSDTnxEFn2WDmz5P2N93SUTUPOYK8XSzgYhHATJfcNA2KM+yv9
         fR9li5yxNFqxwrARD9q5Wn2KUD2XJceMV5mkvLaxCLolqvofCXPjjCXMfaVLCSsu9wCs
         Kz1j1W0Uorbq5TxnVolWeQEtGlBe7pPJzUgoez+zxMbfLZ2bRhUIQYxY/9sR4qIwmoso
         mjgg==
X-Forwarded-Encrypted: i=1; AJvYcCUF+rOlKLcaqlFCjvlr2vO/E4ACJigRnfYiZMNLQF7g+Q7vin3Sfb70wF4drLVMhly9y2IQTptUaEEnh00=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTcpkRId2Ydzz2xvR32JZupJCEZn+ElG+4WlnyIGhgV9Hpow+O
	XBpD0oFwBSTbQP3698e1dRHUJ8IZwAEEI2YiwDGl62x2Mp17c9eYjTMxvbqBpIHyoWCSY66U2bH
	K1jMNxfia3Nbok9b1h9D6HpnFPEx7hIYVTk/3J3AV
X-Gm-Gg: ASbGncus6r4cWQhZvkGRNV9/AsYuckTzav9+G4qDET50porlXxkw8cP9Xxn1zkTAHBx
	fUasH+nushx3Hc/0TY5GwrJAiGtiTkeOXXORncUObBEgDhcQ4A8bNFeFrN8ySC7IkebrkzVx3qq
	wwHctqLNsffJI4VUAkUFbB+ItnyC4yHCNt2hQ0heQ/vGUvbJrXrFwgoF1Mv08KgWYq+fzga3RUa
	1HW7o8WJqE6BLw2nWUAwm67TaLC5SJgIjujMZ7WR7nwhqhypj8Igg==
X-Google-Smtp-Source: AGHT+IFKuVeM8P/4fFTgJ9U8pzM7gkzc2YyF0U06MGypBG9yR59a576LajRenIcFYbHnNEUd1SatYN2HBujM5YeBS1c=
X-Received: by 2002:a17:902:cecb:b0:246:2703:87ae with SMTP id
 d9443c01a7336-246270392ccmr1041385ad.30.1755783442839; Thu, 21 Aug 2025
 06:37:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821070130.2581766-1-abarnas@google.com> <aKcRDWlRQ1gughvQ@stanley.mountain>
In-Reply-To: <aKcRDWlRQ1gughvQ@stanley.mountain>
From: =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>
Date: Thu, 21 Aug 2025 15:37:11 +0200
X-Gm-Features: Ac12FXxRWvefi0pFzenHIpwJbcSrmWtx4bZJqgVYzbGZBgzhqDHq0XNWj_bwV7s
Message-ID: <CAATBrPH-TTAdpCyCopZNsgTCqwnTBxjEiBg9HQ8KnJaPESA6Sg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] staging: media: atomisp: Remove unnecessary inline
 declaration in gdc.c
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Hans de Goede <hansg@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thank you Dan

Posted v3 applying your suggestions.

Best regards
Adrian Barna=C5=9B

On Thu, Aug 21, 2025 at 2:29=E2=80=AFPM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Thu, Aug 21, 2025 at 07:01:28AM +0000, Adrian Barna=C5=9B wrote:
> > Get rid of gdc_reg_store() forward declaration because it brings no val=
ue
>
> The subject should say "forward" instead of "inline".  Also add a period
> to the end of your sentences.
>
> regards,
> dan carpenter
>

