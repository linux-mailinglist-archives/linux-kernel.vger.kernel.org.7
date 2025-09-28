Return-Path: <linux-kernel+bounces-835574-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2366BA77D7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 22:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 829A53B1013
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 20:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08424296BC2;
	Sun, 28 Sep 2025 20:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="UsiuXEBp"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD4128E5F3
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 20:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759092966; cv=none; b=DX2YFMT8JnJqVFexsA0kvqFNqfZ21AUEM4JCcVMpN6y+3MWhqYyKuZxgAhnnLQmLvsEr3hNZFNrnD26lRPqnUXDXnn3PBHDBejRsQBKqHjR8eNsgNXjWht0+aMCkY9m5RcunVdm49c6X0fElqnVBlf4cC3g7gKk1P7MjZWGyv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759092966; c=relaxed/simple;
	bh=c6JNU7cxtn4GGl1RKmZ+N+dQYleaxUy2TWlL0Y8HPys=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NzSOqYeDQO9qYEJn9W0nuL4ciKXWPpGbw/cf74GvedfhAx+6A1Lg3E8j1NpYiifJT61a7bQB7KGMblgIOkHaHbDAFr5PMjGkBDmdiPjoQAdOmJfu7AvHkVviJc0useOivVPU8yG4CpS/AP6920EHr2cnlW8x+limXqoThuQ6yDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=UsiuXEBp; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-28a5b8b12a1so1231495ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 13:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1759092961; x=1759697761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UiGIGqDPqEAG/fx/GyBcjXyYsr3F4pTYCf0xPL9HStc=;
        b=UsiuXEBpTnHMW5N7NOplrywx1l911vxXDeqAL3geeba6p9IC4s9wkTWPx9xrywv8xK
         +zAHP5WannZsT+PppriC9in0EOooSmdX28a6Q6VWdCp1yq33GlxvQa+rWr79J4vWDT+5
         WOO0diAo06ptXUj9YheOMR0hs+Hbj+PSrMsczFjrsq9W3XcH7onMYkqh4pFkS+mHuPhJ
         PjdUs+F3ADztkOjfpljlWlF5BMH9urucsZuEBQ3flahOvAzmiWfmE+H56ebxYxAZ1PdK
         O0EwbOXWA5Kg9eRHrv8dsDbKdAW8J9Zz11Ead/4darMkPFEsZeQ78eYTR83pFHMZROPH
         D6gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759092961; x=1759697761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiGIGqDPqEAG/fx/GyBcjXyYsr3F4pTYCf0xPL9HStc=;
        b=RQJaQEKSNUV4WsbyI/PlsZCL+GYHUtcc2hILpAkmKRxFPzi1+TvEA2EA4bdqUR8PDd
         3JpknuvU6sA1M6xIR88e+OjYtZo3cazryAcwM7HS68VGclZxIpYecvOfH+J02U92Y7sU
         fiQ/ffxZv8O8UeqKD+TNvW+RbTczfbU6tImZFPSOZ/bf2df9tSeHUNmXXbP3hvgYWC8i
         xQ/n8lUBNXl2B0SFrTqPmDZcvudtxMTX+s6tdcH6PlWf5mr/hPe+UgKG6NnyMPKlm+Oo
         fCJHAMiYyu93ysIgnN1X9dJEICgEhwTXYjbsmeUztVSRK9V7DqV2h3J1NQqXBpKiuP2e
         sf6A==
X-Forwarded-Encrypted: i=1; AJvYcCW4jIZOOYa39EyspolnEs44llGaUKNmAoNpKIrGkd+EiDdBQGkj/MRENN44CDp6dDuOGmoLL7SXBz8qAeE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXp1b97mrcH+eJslnIYc9AZOrX4qdoGqGGPGXanLmHg22upCin
	vkXX5JXWQZplRZurtswp6Kp2qdsjVfvRfhB3BOcO8RCevFn+v8XAkRMc8+v02mYY3n/IU9n7nf/
	UR31JnnyRlf/nXbBTqByYB1Jp/bBlib8=
X-Gm-Gg: ASbGncuwjeTxVHCNH46ixGwOQxSI8ba3DgS7067BvD0m3LpCQ7WKsDnL/lwa1rl9mYG
	AjGgWeooysvSszH/f6nvozh3jZ54Uvp3RMgANYPs/DkYcYrUrUqqECWoSDsXpeITQntnPMcOpD0
	RqtGTx6SLeF7l8I6QkWeC2HOY4/cXlB5sIcpaC19IR3iRHzESzoQZaKELbBNcSFJEHfCrTJ92ix
	/m7b6E9Jolc6cC596eSZgZZ27QEApwCBtzh4EPlAKU3X0Sj8aE=
X-Google-Smtp-Source: AGHT+IF7c1Vuxskwry28TIxl0fMtYzqbtx+tBLSfDt71UAkuiIb3LaxfXzXjmqXnRcWpmOVNDKsjmYs5K4EhIxamz+w=
X-Received: by 2002:a17:903:22cc:b0:248:ff5a:b768 with SMTP id
 d9443c01a7336-27ed4a29f9amr152736995ad.10.1759092961471; Sun, 28 Sep 2025
 13:56:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240929-fix_glitch_free-v1-0-22f9c36b7edf@amlogic.com>
 <20240929-fix_glitch_free-v1-2-22f9c36b7edf@amlogic.com> <CAFBinCBd5-s6vaBoJNerXavQiHgsv4Fm3v0svUX7geL=kJvVYg@mail.gmail.com>
 <20178015-4075-40e9-bbf4-20ae558c2bef@amlogic.com> <1jldyzrv2t.fsf@starbuckisacylon.baylibre.com>
 <e70e9aaa-f448-4f67-9149-cb5970c9bbd6@amlogic.com> <9834c7c5-9334-4c78-a2fe-588ff03cf935@amlogic.com>
In-Reply-To: <9834c7c5-9334-4c78-a2fe-588ff03cf935@amlogic.com>
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date: Sun, 28 Sep 2025 22:55:50 +0200
X-Gm-Features: AS18NWCJbZWjP8ynFS6Veu9yFpZpvyV0QmDxpZo6qHFoQpkPGQRYQgKjOrmkB50
Message-ID: <CAFBinCCoX5+6+KQAtbhKx9KdSZhXVxS=cz8DfMVhjPX1c0iSPw@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: meson: Fix glitch free mux related issues
To: Chuan Liu <chuan.liu@amlogic.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Sep 28, 2025 at 8:41=E2=80=AFAM Chuan Liu <chuan.liu@amlogic.com> w=
rote:
>
>
> On 9/28/2025 2:05 PM, Chuan Liu wrote:
> > Hi Jerome & Martin:
> >
> > Sorry for the imprecise description of the glitch-free mux earlier.
> >
> > Recently, while troubleshooting a CPU hang issue caused by glitches,
> > I realized there was a discrepancy from our previous understanding,
> > so I'd like to clarify it here.
[...]
> An example of the clock waveform is shown below:
>
>
>         __    __    __    __    __    __    __    __
> ori:  =E2=86=91  |__=E2=86=91  |__=E2=86=91  |__=E2=86=91  |__=E2=86=91  =
|__=E2=86=91  |__=E2=86=91  |__=E2=86=91  |__=E2=86=91
>                    ^
>                    1 * cycle original channel.
>         _   _   _   _   _   _   _   _   _   _   _   _
> new:  =E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=
=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91=
 |_=E2=86=91
>                                        ^
>                                        5 * cycles new channel.
>         __    __                        _   _   _   _
> out:  =E2=86=91  |__=E2=86=91  |______________________=E2=86=91 |_=E2=86=
=91 |_=E2=86=91 |_=E2=86=91 |_=E2=86=91
>               ^                        ^
>               start switching mux.     switch to new channel.
Thank you for the detailed report!
This is indeed problematic behavior. I guess the result is somewhat
random: depending on load (power draw), silicon lottery (quality),
temperature, voltage supply, ... - one may or may not see crashes
caused by this.

Based on the previous discussion on this topic, my suggestion is to
split the original patch:
- one to add CLK_SET_RATE_GATE where needed (I think the meson8b.c
driver already has this where needed) to actually enable the
glitch-free mux behavior
- another one with the CLK_OPS_PARENT_ENABLE change (meson8b.c would
also need to be updated) to prevent the glitch-free mux from
temporarily outputting an electrical low signal. Jerome also asked to
document the behavior so we don't forget why we set this flag

Both patches should get the proper "Fixes" tags.
I think it would also be great if you could include the waveform
example in at least the commit message as it helps understand the
problem.

Let's also give Jerome some time to comment before you send patches.


Best regards,
Martin

