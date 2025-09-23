Return-Path: <linux-kernel+bounces-829785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA611B97D30
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 01:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD2419C1B65
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 23:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10C830DEBA;
	Tue, 23 Sep 2025 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBJn24tr"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93F42F5B
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 23:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758671517; cv=none; b=ZxOaT3LOkMzBPLhChKTvIWuwv4Ptl75SNwfH7wnexygxZ4sTKmpnx0db+orgQf7Cyn1JpxFoNccpCHp8RzAZs/hq+IZvbf3Ur9bi5arFoFy74GFrO5Jf6uHQq8GvnYrtbSNch0YloIMShvG2hwEN45PvE9MBE1v6bnofDvnaf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758671517; c=relaxed/simple;
	bh=ZGod+jJ1De5O3x2emxdUGMG8rhJo4sReRVQXSpiExM4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cz5F0YunXRgv3OIl3CxAl88HRYi/sVJRwmQpvusSXwwfR8E6Qmjwy/1G6qWZH/c+AMqvjhjy6ZcOAxYaxE/iVtrARG7cxXzfPd54FrWEuoC0P3LxXAiFeqzs5f64n86oKrmbY6Lflhkntdq6yKzVXUHw5IOvI3pjUiiJUH9TELM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lBJn24tr; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77f2e960728so3606552b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 16:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758671515; x=1759276315; darn=vger.kernel.org;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:from:to:cc:subject:date:message-id:reply-to;
        bh=krly78jms1sruv9/XadTy5gAIb5jk63ojUfswJkwWzY=;
        b=lBJn24trNvM5jnOmVWICcg96sy5R8tydJPj12hirOGMskKGn0NfY5oI46S48ygJnPG
         dUxbpkh9QfWQ2Y4mp6Pk2rUy//8LzrntkTtZeX+1JtubutpPavccQUPrhYOkemt/wZ43
         3c7Rso2m121MHk6/iSfGifn5N9tvsTah748hxUIFn8zaEEkJgC3BOnNGW1ulol/7GCd8
         N20ZG/39YA+6iNlGx5TBWFeNPCI4g8IGq1x/zdS8TN3fMen2vJIaxCpr/TKoqT+t4XlP
         jk6L+bv9hXzj5hS0CFhx5HlY3ONjou/ZBWf1fSWnJ+NpwdZ9PjItZvQNwA/AGtugD2Qj
         AfMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758671515; x=1759276315;
        h=mime-version:user-agent:references:in-reply-to:subject:cc:to:from
         :message-id:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=krly78jms1sruv9/XadTy5gAIb5jk63ojUfswJkwWzY=;
        b=B2P8bzByyvToKZdmhi+Yk8YrzBXi14cIFXUiy9StXVSNxPayHg5CAv/JX3IVSDURNv
         REGQoHXQlXHMBWlUDPYHJ1euoOE3RFi4wAI7Ho3DOns0Z5jTbGzl5m8dk8BQS3w7E73J
         5mDyxXBUZPMKdi8/34g5ahRCtmccB1p8MsGaG09j+hb9drn7kBajeRbIqOXjNdfpYKWu
         UbLqaWXGnII9GM81SEc3kfQCY3Q33Ik4UCEOnxY2WenJkRfg+4A4bC8wUkc3WZILIK69
         te1U3+UrfDxtemWA70Si745roXhdvTYtmUfRwukcRnnFcD1AiukzLEtrhRzezPlly7L0
         EzTA==
X-Forwarded-Encrypted: i=1; AJvYcCVvmXURVAvNx0bqhNLuDZ4aaIezPHFWyY1qBRxn0DrR0WYYdFHHDPDtxN2Wt+Q1M41eda06GS9rJwEzSbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhXU71qEE2+Tz0SGik5udIOu75y3trhjDf7uF6RBEdcKw2/uzR
	XGxMkDRJzUZKnNnMU/0vukyms/Vp4JS+RxosoowauAK1eUbOBIdi6ntk
X-Gm-Gg: ASbGncuiLbU+3SAq7Xvc2B3xnUAq5pLKzwnm1hFgK+sFReyBENT6luELiIeAClayCA3
	XFulW+DG3NckMaTeq2dvhieNjMu5r0JZm0sZjN88g6FXwtYeRWIwz1zcS6GagJ6kY9ox8vNErRQ
	uiYic0KpTvekeDZ1QSnNyGOHPXMftf0p3DrZofN1JXz6ByRUj+e+kvit4RU71O3OplIdC5eaCCb
	YIIDp6w5Vis/A6XFZaHEU3Ozz4KVgC2H/RW0XJQ14OMjUHLC0C298QgmiyfWBI/11t+hlOosKhz
	sB7C7MWhhQprVnkg/6JftXlQ8uicKbLtXFIaJHdRbBru7m/oHlkkgjaVGFTcnNdwpsRc62MDzj0
	v4g1oJPTTSvBgwIuZv0ul9ZBYFz3rYYFpvfRrqNOcIaaOrfwGkt/J1isq4YiAx21JpFSEPwtz4R
	TR1TSJndf7
X-Google-Smtp-Source: AGHT+IGJd40fbeCL7mt0AGb3l0yu5exWtbqkd4Ul5ggag0wEHkuE1unELJ6+RGpDizF17gDR3Dq0qQ==
X-Received: by 2002:a05:6a20:7345:b0:2b1:c9dc:6da0 with SMTP id adf61e73a8af0-2cfef316ed3mr6555170637.46.1758671514828;
        Tue, 23 Sep 2025 16:51:54 -0700 (PDT)
Received: from mars.local.gmail.com (221x241x217x81.ap221.ftth.ucom.ne.jp. [221.241.217.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77cfe7607c8sm16949307b3a.58.2025.09.23.16.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 16:51:54 -0700 (PDT)
Date: Wed, 24 Sep 2025 08:51:50 +0900
Message-ID: <m2zfak7mnd.wl-thehajime@gmail.com>
From: Hajime Tazaki <thehajime@gmail.com>
To: johannes@sipsolutions.net
Cc: geert@linux-m68k.org,
	linux-um@lists.infradead.org,
	ricarkol@google.com,
	Liam.Howlett@oracle.com,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de
Subject: Re: [PATCH RESEND v11 10/13] um: nommu: a work around for MMU dependency to PCI driver
In-Reply-To: <23adb61e95275251e459513a03ab7d2bcf1f2e07.camel@sipsolutions.net>
References: <cover.1758181109.git.thehajime@gmail.com>
	<4a9dde10c586883d20a8201ca7d76e6d7d52eaf4.1758181109.git.thehajime@gmail.com>
	<a58620ecefa207e141a435c36492647c3d5bd3df.camel@sipsolutions.net>
	<m28qib8g1r.wl-thehajime@gmail.com>
	<6b1abe384237c8129e8043ecdfdad77758d2fd2f.camel@sipsolutions.net>
	<m27bxu949d.wl-thehajime@gmail.com>
	<CAMuHMdWAdhiY=MiG5JtboffSo_=D7TD5vFM6Ui5E8eS_VJiJ=g@mail.gmail.com>
	<23adb61e95275251e459513a03ab7d2bcf1f2e07.camel@sipsolutions.net>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII


Hello Geert, Johannes,

On Wed, 24 Sep 2025 02:13:47 +0900,
Johannes Berg wrote:
> 
> On Tue, 2025-09-23 at 17:42 +0200, Geert Uytterhoeven wrote:
> > > 
> > > currently, drivers/pci/Kconfig (CONFIG_PCI) marks as depends on MMU,
> > > so we cannot select it when CONFIG_MMU=n.
> > 
> > That is a fairly recent change, see commit 8fe743b5eba0abfb ("PCI:
> > Add CONFIG_MMU dependency") in v6.16-rc1.  As this is not a "hard"
> > dependency, perhaps it should be reverted, iff you are willing to take
> > care of the casual breakage?
> 
> Why though? UML with PCI can't really be a functional thing, only a
> testing thing, and testing PCI on !MMU when that is actually impossible
> in non-simulation is pointless?

currently nommu UML doesn't come with using PCI except building under
kunit (ARCH=um), but I have in my mind to use it under !MMU
environment, so would be an option in the future.

and this series doesn't include PCI w/ !MMU.

so, I would propose the modification to revert the MMU dependency when
time has come.

btw, what do you mean by "hard" dependency in this context, Geert ? 

-- Hajime

