Return-Path: <linux-kernel+bounces-737030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD90DB0A6C9
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E1FB3B9EFE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7AE22DCC02;
	Fri, 18 Jul 2025 15:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkUwnIJ6"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2E918024;
	Fri, 18 Jul 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752851013; cv=none; b=evZX3rhkBaj2Ev2FBuO0YD8tRTGesvrmrKgDwZcMeXqUSff7RtBNXTlWToKUqzhO8zTxwT32jZYhtR7TAZIJi1gjW72aeGnWDEkJ0qfb06kRoXbd3dMWIZ8m/RZhNxz7W/9fS1vBSUiZoscYCSgffUColpIRsEdREGP4rsi91Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752851013; c=relaxed/simple;
	bh=IaPqhmr8I8MG3sHhnHr618dEFB92sPQdSnz5qoyYh/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JpMNZpsGWfyKmzBzff4PKGfVZy86B7ewaoatvimv5TPZ4O/bNYQ5+MtesFAA6+B5sWu64GPXaano5qBf2TZipkuQxxQYgEQNPVr343ZxCk7NzR1HbMSsGywAZbgWQJqK/ooxeV7FlWgX2r5uugqIminqvBWxzAgc9xrMQ8osuSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkUwnIJ6; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ab3fb340e7so38968791cf.1;
        Fri, 18 Jul 2025 08:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752851010; x=1753455810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IaPqhmr8I8MG3sHhnHr618dEFB92sPQdSnz5qoyYh/o=;
        b=SkUwnIJ6Zed8ZmjO1XS4sB40Mhl7pJnrZWp7Q56pYp7LXqXca3GNEHPP30TcVuQY3X
         2clBdKsQC1vlEEw/wdAkGoHsos6ZJaM9lqTfYoKzrr4w/RbohLGVT8Mjnhlf3EW3fto7
         atJL1DHT0EAvBKoKpmKBTroouSd6UHbWBWmLqTdY8W50MpeCS0MM3doZhenEU8j1gJwu
         9HVnXPUsUTNlPh2u8txxFWPbEIorIc0M8QTlueGoo9Qaec3ksj0bdB8Vpt2Mk4j+UP4d
         hIX9lqr/DwcztKVueOGPBXCAQvOuArY1PcD/InJHiDFOgPe+Jrmd9XkC/5WCraGk0Gxi
         JYdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752851010; x=1753455810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IaPqhmr8I8MG3sHhnHr618dEFB92sPQdSnz5qoyYh/o=;
        b=mWSqov9qKxADHVIHiuYqyXc5P1kf1U1Z3xl0NebZlAsFDGHXRMR8Tu99RUBIRd6eiM
         OnTmnQ2zGJZA5S0FWtCTm105WEhSwQoq0sQ9wmbumacS43wzrK5z3iE28AfGUxItZJHm
         mWPcwElUkAF59uPrBkqnKGRfiUKaj9EIspxIvR5JejWQVS/VVDbdwSNcDhoopO2+bois
         iU/AMeWPSj4TXOkDaH6xQlCOYID4LNeVIWiMTbD09Gon/YbLn7/3kmz7eIdM2nRm50FT
         rKxcmCouGhxlYdlxhVcx7Zr4tQzW58aLlLdKMyR6NrRDFge56w5zA9HvDRkz5P4C696T
         OHQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmFWFczKuaWpV/Vu5vH5e3ETCiwcQ3dbQZU7PG0RMq+4xiFVYGKeSLumXFg9vdpr3FUxOqBrT+a7vF@vger.kernel.org, AJvYcCWoNTsPFt3l/DR05TqmL+UVKnj8w5E83jreIS4v3rQT+h0FuYHd1PELbdO7Z//65B1lOOi/rMbuTHTra7aT@vger.kernel.org
X-Gm-Message-State: AOJu0YyDJcg5+G30YsPXG6MUJ8uy6tZ6ZS4DzVQLSEHUIGmW6Q7qcRdP
	zeGRFCIzVKANU6riJDh/W9tohPWt3e2mMST3JadfQxOO/8ftFntbHiNiKbtSX0umo4WAT4fOwyr
	pFcpr8zSELtunnGHA3Dqb3flxdOjIIuu4nfg8
X-Gm-Gg: ASbGnctxxnctRmq1FrSPCGATVjOP6j9Js+zWP2RE0yXeKIAsvdiy/iTep2ZRaZ65q4x
	apkluYR5+nh01shfKhE882bSQuqlDdFCDlTATF1hfH+/udbMPMaQd+ELnrCLHFK3JFOxkSIizBD
	a4Ruz8XHQDMFoyS9kvmhZLxywVemrqcsiv9b0XRwVMzgwXQmTcvCy8mWJ0MN3aqqd/t3bvy6KGf
	xaNmoTS
X-Google-Smtp-Source: AGHT+IGa8swPXXVAGbewHZ/SdoCPvBaIYn9opH5hqxkroYSjw7vm/HyHQEtmf/m9BpPT+G/u/pQ40OxmjrLtqI9uzx4=
X-Received: by 2002:a05:622a:648:b0:4aa:df09:133f with SMTP id
 d75a77b69052e-4abb4578b0dmr39626691cf.50.1752851008967; Fri, 18 Jul 2025
 08:03:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABjd4Yxz=mrNpqgnHSgD0tr4ALH3YW9MvLULES568yHNFiPB_w@mail.gmail.com>
 <20250718140110.308996-1-amadeus@jmu.edu.cn>
In-Reply-To: <20250718140110.308996-1-amadeus@jmu.edu.cn>
From: Alexey Charkov <alchark@gmail.com>
Date: Fri, 18 Jul 2025 19:03:17 +0400
X-Gm-Features: Ac12FXy8oFQyajABj_LuZ7IBJacD8iw-8MfdCYFevfgzhAwQT7Tsgn3fiksLCw8
Message-ID: <CABjd4YzLaAgd-5Cg9fMSAgCS6Wt6=uC8K3WRhcAtnjjg1je87Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] arm64: dts: rockchip: rk3528: Add CPU frequency
 scaling support
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, heiko@sntech.de, 
	jonas@kwiboo.se, krzk+dt@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	ziyao@disroot.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 6:01=E2=80=AFPM Chukun Pan <amadeus@jmu.edu.cn> wro=
te:
>
> Hi,
>
> > > Alexey suggested that we remove 408MHz, 600MHz and 816MHz from the
> > > opp-table. Do you think it is acceptable to use 850mV for 1008MHz?
> >
> > But why 850 mV? Vendor .dtsi [1] implies that chips with leakage
> > values of L0..L4 might be unstable at this frequency with a 850 mV
> > supply and need 875 mV instead.
>
> Because the actual frequency generated by 850mV is closer to 1008MHz.

Which likely means that you have an -L5 chip. It will be different on
other chips - it's a lottery of silicon quality.

> Since we removed frequencies below 1GHz, all remaining frequencies are
> generated by PVTPLL. I think it may not be necessary to use the maximum
> values of opp-microvolt* ?

Only if we deliberately ignore the unlucky users who got lower quality
silicon (-L0 to -L4). They might have problems if we run 1008 MHz at
850 mV, which PVTPLL may or may not be able to make up for (depends on
which ring length gets applied for this frequency by bl31). If those
chips didn't need higher voltage to run stable at 1008 MHz then I
doubt Rockchip engineers would have put 875 mV in their .dtsi

Best regards,
Alexey

