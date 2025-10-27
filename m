Return-Path: <linux-kernel+bounces-871938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D5AC0ED30
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7B82434864E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 15:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C369306D26;
	Mon, 27 Oct 2025 15:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GmYOQkyR"
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751E42E7645
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577861; cv=none; b=tNMTZIYEJzWJA5HC3VdBBzAeS5GrWmYQGokj/gKgC4kiQimr0hVdE7OAvnBHQOUCriNmtuYfxTFXmazWZe9Q5uY09h6sYZWGI5gHlQY/5aNqmieUyNvCExLyNC+yTsYfAVb0yayzi3tFYeltWZLyCuOaKaPhJkJ/vf/inw6S300=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577861; c=relaxed/simple;
	bh=EAoPt6jv7RYVLe51KJHBeGBxB13CL2PFw+2NcmecyJo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LVEfVC9XbwEbtq14KM41wzZCH3b43OxZIH8dtim5tiCHyixMPWchvOI4m+9RrRKyTHU+Xo9CAADLKVoY4vUQp6K0ofbtosZw9uh7XRm9yOgjEAidM/TqVtHUTs0ItMCRp0bfC8Qfww177TH+4Q3SZKgWOeHy44bjOL5brAYMRpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GmYOQkyR; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-3d37c1fb05aso447466fac.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761577858; x=1762182658; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DMx/DtxK2+AXbHtbFOgTT8Th+LDWX/DlurisQVihNgA=;
        b=GmYOQkyRyB4gCvtCHjsZAqrRcL9IRUU65wWy+XC6rOhmcw17MG4FNFiQskzvwGoTF8
         krAeC8Z6ks9seQGu72rUdPTASi+1gMHxUcYYWWZo8rMCGhJzwScLj6ki9KvGn6gstbQB
         Bs1kraj1TMKuFPph44WgGDDIlm/9mjYxGKu1efF+5uVvb7OdvDVYsZDZPRaXfOX9HDFD
         PB7trGBlBV9kTbSs4QlhWxQ2UHuy6mj+jQwqbCguuWgqK+DBBxNphLc0Fueq1hDVZskU
         +yIk5IdncTy5dHmz5659WxD1B7KC54iaXhFBj/J94fdsFuU7o9K5NuadE5Vf8/7gZRUl
         jsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577858; x=1762182658;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DMx/DtxK2+AXbHtbFOgTT8Th+LDWX/DlurisQVihNgA=;
        b=PwLUcfom4luRFMWEHfVgbnYNlV90Ph+xJEIB9TrvT7+vOzdXKUzJM/hL9V1LUumKXE
         eTA9s+Ofs1ik4DugLUToZlZUxxxCyxqCcUkGfWeeSSFcMG5uUnkSRWz2zXHdIg01/83O
         NX3UjkQtAbeRayLu0PNuA+gL05aIksapWNzkxlpQDVJ+kyWbStVoeKHyF22fei0mxryk
         tFDiRv8rIjIEgHZbR2xvuugQbKRfh4V555n00iat168iRABeh/3PEBQenTnHQ6uQ9jBm
         WsXbNE0DlxonPoqM2UQpbLK1jrvn2EYNY7oIuxYLnlMYoiXRkkCk0ZiQa+03sE4X8NKx
         po5w==
X-Forwarded-Encrypted: i=1; AJvYcCU+++bDWo9+xK2dPiyWeuXq1xJrAE7vlc9mFHu0Bd2HtwwdxKoMo5BGs1T3nom1eZRlDw0X54k4zPHrdIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbTGIcN7GF7JFrzC+BnREKfsvJCpaKSghNdrgXC5YLfYHNB2Gw
	n1BOcH9F4eyQGTGllK3LaIDLLm71/Rfwwzh6DNjnPUhAarOdINYkCxQCTmyiSFZnClOk67pGjuZ
	MALV5nj4IUBaqZuSEiDrUKgW+tfrXnc306dr+C9/DRA==
X-Gm-Gg: ASbGncu+6/pwsak7CTmleOf9ptkS9w6PtPewZYdWO4F/+yu0wlbRJhBu8pTfsEIb3px
	st6LPFwxRQt1Nyg1m8VkrEwzPAfFC3k4VDraL//6uF+icOCtb40z34umv9DmQ5x7mPAs8aTD1QX
	tFoQivtlPgGkh233x60tsbkqKEcv4EzCDh6EUlpqdiYs32NSokJZrxo0xnR/NHys6wAM5r73kz+
	2Du4zhgU1OFHtkHYw+M7fEjCh8lD0biehEmJaNo0ncTUgEl26wu5y2X6GN3IX5mS18ks7Do
X-Google-Smtp-Source: AGHT+IHd+W4IcFgJ85hqjhm+BkDqXnza/5grh6+beTj8ol5IgsaZlL3T/yI5duqd9WMVuK7QnVMu5fYn0lx+pNPIZGo=
X-Received: by 2002:a05:6870:de10:b0:3cd:aa5b:9d1f with SMTP id
 586e51a60fabf-3d17757ce8cmr4451260fac.51.1761577858254; Mon, 27 Oct 2025
 08:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923151605.17689-1-johan@kernel.org> <aP91OoGkrSxxpsf1@hovoldconsulting.com>
 <8487acd9-3c8f-4eba-99e4-6a937618aa55@foss.st.com>
In-Reply-To: <8487acd9-3c8f-4eba-99e4-6a937618aa55@foss.st.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 27 Oct 2025 15:10:46 +0000
X-Gm-Features: AWmQ_bk8-GIOj3a66ntdRL-XYsBVqfxaejexXxbTpzCfX6YeH3gwqk-lE3Q3OUY
Message-ID: <CADrjBPrez1Zi3njGMUVgKeyYu_XCt3qNWATfpsrJZk3ALevOVg@mail.gmail.com>
Subject: Re: [PATCH] media: c8sectpfe: fix probe device leaks
To: Patrice CHOTARD <patrice.chotard@foss.st.com>
Cc: Johan Hovold <johan@kernel.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi folks,

On Mon, 27 Oct 2025 at 14:34, Patrice CHOTARD
<patrice.chotard@foss.st.com> wrote:
>
>
>
> On 10/27/25 14:35, Johan Hovold wrote:
> > On Tue, Sep 23, 2025 at 05:16:05PM +0200, Johan Hovold wrote:
> >> Make sure to drop the references taken to the I2C adapters during probe
> >> on probe failure (e.g. probe deferral) and on driver unbind.
> >>
> >> Fixes: c5f5d0f99794 ("[media] c8sectpfe: STiH407/10 Linux DVB demux support")
> >> Cc: stable@vger.kernel.org   # 4.3
> >> Cc: Peter Griffin <peter.griffin@linaro.org>
> >> Signed-off-by: Johan Hovold <johan@kernel.org>
> >> ---
> >
> > Can this one be picked up for 6.19?
> >
> > Johan
>
>
> Hi Johan
>
> The removal of c8sectpfe driver has been initiated see https://lore.kernel.org/linux-media/c3a35ad6-c4f6-46ad-9b5b-1fe43385ecc5@foss.st.com/

Interesting, I hadn't seen that. I guess I should dispose of my b2120
board then!

Peter.

