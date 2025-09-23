Return-Path: <linux-kernel+bounces-829223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA41B968E9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 17:23:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A4A1899E97
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 15:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3942257842;
	Tue, 23 Sep 2025 15:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Rp+1sSWO"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D40246764
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758641012; cv=none; b=uhI6Fcf+ujHYai9X0PC5K0VUT5D5OXbEpHoQW9DIbDIIkcwvn1cTU4B/K83Yk56urgXRdFLHeeg8U06NvwoH/98CIccXL+cSSHIwBWAbPO7F/ZiKUVb2wOC0UTlNiTXvqiLOoqC8KrxnRTLEDVorGBy6FYTnp1p1GfzxpEVgufc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758641012; c=relaxed/simple;
	bh=eAHUTNg4x6jx2BBwztgbdyoHwf4FUKdIu3EQxzUoE3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u6KvuZ8hdYBcH5DItHwI7LecvDDwUTOQPwpeSLMs6M85r0DMjUh/iwRRzvHHVF0CJY4so/atzAgRMnE72YqAaRSSTN86I1+GWo3ia1xAlIXJJopd4Fhy6Dcf900jomejKmkJRKeIvTxxV68031dD67ORlhvjGqg0ijzufb2Df3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Rp+1sSWO; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3307de086d8so5072113a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758641010; x=1759245810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oOzyUryAW2PcUwkR2rwYRfULL04GmVoUwMgRRRRXNBY=;
        b=Rp+1sSWOdS3RWaESXxkOWCdLXxWSk5kgTMj8mpZBhJEPTnFPRdAuftujaDyNY18IZJ
         R+Rq+svCQu5z3gVtNCK4OKXd/UTJxTpxzKu2JGfsbqFPlDPj/ov5t1zyXtz5AyD27AjS
         YCy4qUkB49kud/2s0swUxz9rzUDM1+eeMKcHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758641010; x=1759245810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOzyUryAW2PcUwkR2rwYRfULL04GmVoUwMgRRRRXNBY=;
        b=jGGK7dyoU0fNyNb1fA46KlfQkJhL0K1vCZD1ezq9crl7bgJH1VBMe0KKFIyp+AS+YQ
         /cMOC2VOfoW4EuvkcxS3Epz8VPKyZqcaOjnS5GAOn02aRcFH8fXKCbW/2RHjaWG+h0hv
         cs0lVSlF7gCEbthZJG7agXZON2rYOsxaGCpgKpDbykKmPrjwA0W35s1Vkkxs+DRoGh3U
         Ps6y9NkVktl0qDlwDMJLkN027FVhom60vk3WrRlM3BPNX4VZCQJr2PpvNvloI25+D372
         J1V2iFIpzOFhwLKrbTDNetL0vxoOPr8hobOwAZJECrM5V83SucqDTe+4Kx94M+sP1PMw
         ZJTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWUN/CUhifOQ4C8kYHhXVBnU2NlQVXj8HyErWRPrYe4jbh1P+baEVuaArSnyy7lL6NGCCUNGjnSmITIrpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCP8+ENt330SOwSl7SRzHJCF6+MmHj81V2IXbrLIjzjSX5hOhA
	L8mSdf8W4ihABDsIb1cA2CftaMl73WgDUuffwEBMSx4uTBDbXxkUIztJm2rrZsZLZdaOqMYMEno
	T7P8=
X-Gm-Gg: ASbGnctAaS4c8LTSnm0Axf1tTuhGGep7F42BMp21h7dDdu1WidykDGnpHzYYPcrt3fL
	MJ766iaMKqBSeHhpkafO/LbEm65xtX8PjpwjefXoOGs+7VnYiR0Nilye8KJG/mD3bVdz60Ju9jv
	aLdQGH0a3khEAWFhjMSK2rTEXAabupk9KXYQ+UHkvQKGim8817wKPfVza6kwqsFjrry4a0nUIoG
	k0tAfmRqCOti/2agc6Yq2dSkJqj512oNBkFhMYX4ZHVQ07JTccTrWn/Liut/5j1+nQqH7XT69QP
	1CclnCtPlRGdMhF2at4RAeCrMaHKFGc2YUEjVSiQE+Mw7BvHTVGDtDON/59LBcNd7zUkm1m8pvU
	4c+dPaADC0kOiXqJbWaPdT9zHNG5v3W5s5/1QEObqkihYk0x+r4uyeMQ21UzWkGxHgHfBget5cp
	rtB41hEaJSw24f5+1dLwE=
X-Google-Smtp-Source: AGHT+IGssx/ikVuXRtnt51yEueVO6OfTW7Z0Ns0pT6FjaCQ0tDVT7ySWGcdxBAfxj3zTXNzpw748kQ==
X-Received: by 2002:a17:90b:58c5:b0:32e:a4d:41cb with SMTP id 98e67ed59e1d1-332a94f5397mr3375958a91.1.1758641009814;
        Tue, 23 Sep 2025 08:23:29 -0700 (PDT)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com. [209.85.214.180])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33060828031sm16605337a91.26.2025.09.23.08.23.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Sep 2025 08:23:29 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-279e2554c8fso23909885ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:23:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUm1zXLpGW+G0Rkvg4Xra+4plaKKU2CYgKd3Hm68wwR9DrMRpm403wCxKeGfUIoiRAD8t7HRQs9r+VqiQc=@vger.kernel.org
X-Received: by 2002:a17:902:da83:b0:268:5892:6a2e with SMTP id
 d9443c01a7336-27cc9f5d729mr34898035ad.56.1758641008349; Tue, 23 Sep 2025
 08:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915165055.2366020-1-john.ripple@keysight.com>
 <20250915174543.2564994-1-john.ripple@keysight.com> <CAD=FV=Xhd+0ZsUE3pkkii-Gijrwx0_Oh6WfRKrutqPQT3Jm_rA@mail.gmail.com>
In-Reply-To: <CAD=FV=Xhd+0ZsUE3pkkii-Gijrwx0_Oh6WfRKrutqPQT3Jm_rA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 23 Sep 2025 08:23:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WkvqRwOPJE9Jnjv1Bpde_ZKQ=crPTKgZLgWrjZO=e5dg@mail.gmail.com>
X-Gm-Features: AS18NWDCNAxWqU3shx8ybqX4YZuREmtbu0ce5ordOjrPqtwQMdsjdMtRaPtv8DE
Message-ID: <CAD=FV=WkvqRwOPJE9Jnjv1Bpde_ZKQ=crPTKgZLgWrjZO=e5dg@mail.gmail.com>
Subject: Re: [PATCH V7] drm/bridge: ti-sn65dsi86: Add support for DisplayPort
 mode with HPD
To: John Ripple <john.ripple@keysight.com>
Cc: Laurent.pinchart@ideasonboard.com, airlied@gmail.com, 
	andrzej.hajda@intel.com, blake.vermeer@keysight.com, 
	dri-devel@lists.freedesktop.org, jernej.skrabec@gmail.com, jonas@kwiboo.se, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	matt_laubhan@keysight.com, mripard@kernel.org, neil.armstrong@linaro.org, 
	rfoss@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 15, 2025 at 10:57=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
>
> Hi,
>
> On Mon, Sep 15, 2025 at 10:46=E2=80=AFAM John Ripple <john.ripple@keysigh=
t.com> wrote:
> >
> > Add support for DisplayPort to the bridge, which entails the following:
> > - Get and use an interrupt for HPD;
> > - Properly clear all status bits in the interrupt handler;
> >
> > Signed-off-by: John Ripple <john.ripple@keysight.com>
> > ---
> > V1 -> V2: Cleaned up coding style and addressed review comments
> > V2 -> V3:
> > - Removed unused HPD IRQs
> > - Added mutex around HPD enable/disable and IRQ handler.
> > - Cleaned up error handling and variable declarations
> > - Only enable IRQs if the i2c client has an IRQ
> > - Moved IRQ_EN to ti_sn65dsi86_resume()
> > - Created ti_sn65dsi86_read_u8() helper function
> > V3 -> V4:
> > - Formatting
> > - Allow device tree to set interrupt type.
> > - Use hpd_mutex over less code.
> > V4 -> V5:
> > - Formatting.
> > - Symmetric mutex use in hpd enable/disable functions.
> > - Only set and clear specific bits for IRQ enable and disable.
> > - Better error handling in interrupt.
> > V5 -> V6:
> > - Formatting.
> > - Convert pr_ to dev_ for printing.
> > - Add error check to regmap_clear_bits() call.
> > V7:
> > - Move status check in interrupt.
> > ---
> >  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 112 ++++++++++++++++++++++++++
> >  1 file changed, 112 insertions(+)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
>
> I'll plan to apply to drm-misc-next next week unless anything else comes =
up.

Pushed to drm-misc-next:

[1/1] drm/bridge: ti-sn65dsi86: Add support for DisplayPort mode with HPD
      commit: 9133bc3f0564890218cbba6cc7e81ebc0841a6f1

