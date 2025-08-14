Return-Path: <linux-kernel+bounces-768022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE52AB25BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAF715C4BBE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 06:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1142325392B;
	Thu, 14 Aug 2025 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsmU129R"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161D424EA90;
	Thu, 14 Aug 2025 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755153609; cv=none; b=c1WM6IhiiLDp98oYI3ebklsR4l3uzpNLWD3dm6um7fpaWoDc0V+RobhfYpiPPjHWFTGN0Nn/gj1GMy0S1pQMTf+dsvdBjWeq5LbtPdfKuHzvX129t0oN9quzGtfv0yrkhrGJp5C/lzfQEyB19hbdk7kOS2QLvisSv3HuqHCOTco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755153609; c=relaxed/simple;
	bh=9qq39J6TAfgBIo5A/7D+X5XQWuPaginntNad9ch/PIA=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PAbMX/uKXetvIwgMBcxvcAtGoHDm94apD1h04o89qoWrlYZcUXiaZNLUQ+5QfpATAczqaVH3dvCsQQuDZX7z2FmwEplMvhS7NkJlblyToXo04sNjxyPPcCelMbhypOiKHGui1Wk43PWYY8DDyg9yMhunodWIR1xfvQNQAYGgstw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsmU129R; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-24458298aedso5100785ad.3;
        Wed, 13 Aug 2025 23:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755153607; x=1755758407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nmRoWzoVo1QnWkVePgxtwsQXkfJPU79BgAD+Y8C8IU8=;
        b=DsmU129RM8BP6aQzuAPfq+2bD3YGRxM1ma1p3fjlEW0mdG19F/0Z+m9wp55+YEHcoJ
         f0dxv+gxg2vQ4R6QPjjcPBuXZfMi0zyx/7Lnc5n5x2QkD+ATUp5bqEtK1btGDaCWXeCV
         OHQbjQXvrOgjRjpUUWkj5M37T1XXh2hpQcBMIJT0OTPWOFm3+vTWmlGXdCww8tPkrNfb
         WfNrMAeTMT08dwBgBKXpPoI23jwyrhv2N/Zo0RxW48mGCGHOwk1L7uywNlR/JirvUVz0
         u7lh6RdIuPYOG1Gs9sNpVBAc5y72rN/UEAEjDOmx6/oY3nFA0tr9RzzbYzQ5GP7AHGEl
         HIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755153607; x=1755758407;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nmRoWzoVo1QnWkVePgxtwsQXkfJPU79BgAD+Y8C8IU8=;
        b=K0yaIY0C/T9Gt60OV9FabVkNePMmvUWY/r+x3fxEK6g8esCBMdm0gOrbAJOTQKtz9C
         2tpMLrTZyHCsZia82pxtHXJmYu/AVCFTxHYtjvLhR5mJH6AjTfgaW/zxwMcb97XaxDV6
         0037X29mX6v9Xj+XHowEE3GPWPaLdgtFRoNkC5sudcg0N5qwDS9Z9Kv52sQVth9Z+ZJ/
         ZN55tZ3pAIP0d4YLEwZMWnYDCjI+nXb+mzFhnlOIVtyG3j9M5dgwf6ZDQrBNbKvK6wX7
         pmthHbtx3fPt28HIF7dVFGerHqHEFHMq6YGs8NPGnvtv1l3iC3oy7eAqF3/yVzKnRaVE
         99zg==
X-Forwarded-Encrypted: i=1; AJvYcCUawSllRZ4sEOhI2S6fG9y8uEBNbSMGv/KvAaUKjN9wFHIq6YU1xXyaBOWQ2ZRKIAoGRrXkj2spMJWEfLM=@vger.kernel.org, AJvYcCX3pYIOoHGftBplG7DM/zttMBZj51MvifNfTSnPp33koy0AOWzZmBiDZgj7A54kidFyBgHL67MOqPrK4RUoF0E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfvHSnj2f1FS+JBPqE0PO5eT6ZYcKOjVzlaGjXF9p9sE9mPIi3
	zaImcGomoV8f0+GNPLNE/odYP0zKpTyzbhQZKo1ykhbUVoWTRPCAVrWe
X-Gm-Gg: ASbGncthMFuK9+WyP+zSkkB2e4OkI8Vi+Z/JjzIxh6sbwe/GK/eSYj/BjtLGc4rgSOi
	IC5wlp0eZAHV+y3ZVAjFyU8kEH2Lv6xVo02QHGGUSnajIOwkWTvd6EJKBHnKvRy/OfBumXNH58l
	LRau7/q3p3Rc2qO+qzeYMeRAj3Z2QfaOXj8KtDzZRPT2ActJ3B6JlMbkPi9lkSpZqAw6VHzGT1n
	sc39/eefxCOi2UofpOSjgFlk7kIY3Co2TtWop0S0dGmylJU+XYCgpe/mrHWnYDVtRnIj5YjtBzG
	ANZBnvhWPMvXEdeFTPpPxFctXdifeP4NiyvQw2N3wuz0DUzGayFsOZ1d88PhMjK+LOUUikF56Zo
	+0uTq+40+iSdLTVKLgKBoC2OP9jtXCtakuSIpSKYzsl95jlCAum3AKDUVwqmZDWRtCar/ckhe1T
	v2
X-Google-Smtp-Source: AGHT+IEUSzlygFdaIwOnz6MVy/50EPts59pSY7Za1A40GKW78hDWxxTfkKgD1n0OlPO+Q45k7QvdaQ==
X-Received: by 2002:a17:902:f68d:b0:242:9bc4:f1c9 with SMTP id d9443c01a7336-244586e30c9mr27116935ad.56.1755153607219;
        Wed, 13 Aug 2025 23:40:07 -0700 (PDT)
Received: from localhost (p5332007-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.120.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8977345sm341314745ad.108.2025.08.13.23.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 23:40:06 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:39:51 +0900 (JST)
Message-Id: <20250814.153951.1907355400690553428.fujita.tomonori@gmail.com>
To: acourbot@nvidia.com
Cc: fujita.tomonori@gmail.com, a.hindborg@kernel.org,
 alex.gaynor@gmail.com, ojeda@kernel.org, aliceryhl@google.com,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 dakr@kernel.org, frederic@kernel.org, gary@garyguo.net,
 jstultz@google.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 lyude@redhat.com, rust-for-linux@vger.kernel.org, sboyd@kernel.org,
 tglx@linutronix.de, tmgross@umich.edu, daniel.almeida@collabora.com,
 me@kloenk.dev
Subject: Re: [PATCH v1 2/2] rust: Add read_poll_timeout functions
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <DC0YN6WQFUQY.3PKYK23ESRJQL@nvidia.com>
References: <20250811041039.3231548-1-fujita.tomonori@gmail.com>
	<20250811041039.3231548-3-fujita.tomonori@gmail.com>
	<DC0YN6WQFUQY.3PKYK23ESRJQL@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 11:56:26 +0900
"Alexandre Courbot" <acourbot@nvidia.com> wrote:

> On Mon Aug 11, 2025 at 1:10 PM JST, FUJITA Tomonori wrote:
>> Add read_poll_timeout functions which poll periodically until a
> 
> "functions" should be the singular "function" as this patch only adds
> one function.

Oops, thanks. I'll fix.

> <snip>
>> +/// # Examples
>> +///
>> +/// ```no_run
>> +/// use kernel::io::Io;
>> +/// use kernel::time::{poll::read_poll_timeout, Delta};
>> +///
>> +/// const HW_READY: u16 = 0x01;
>> +///
>> +/// fn wait_for_hardware<const SIZE: usize>(io: &Io<SIZE>) -> Result<()> {
>> +///     // The `op` closure reads the value of a specific status register.
>> +///     let op = || -> Result<u16> { io.try_read16(0x1000) };
>> +///
>> +///     // The `cond` closure takes a reference to the value returned by `op`
>> +///     // and checks whether the hardware is ready.
>> +///     let cond = |val: &u16| *val == HW_READY;
>> +///
>> +///     match read_poll_timeout(op, cond, Delta::from_millis(50), Some(Delta::from_secs(3))) {
> 
> Is there a reason for not writing the closures directly inline? I.e.
> 
>   match read_poll_timeout(
>       // The `op` closure reads the value of a specific status register.
>       || io.try_read16(0x1000),
>       // The `cond` closure takes a reference to the value returned by `op`
>       // and checks whether the hardware is ready.
>       |val| *val == HW_READY,
>       Delta::from_millis(50),
>       Some(Delta::from_secs(3))
>   )
> 
> I think it is closer to how people will actually use this function, and
> the expected types for the closures are available right in the function
> definition if they need more details.

Either is fine by me. I thought that not writing directly is more
readable.

Anyone else have an opinion?


