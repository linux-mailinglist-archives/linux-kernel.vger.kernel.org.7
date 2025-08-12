Return-Path: <linux-kernel+bounces-765385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A51B23189
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42821AA57CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 18:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC8B2FDC30;
	Tue, 12 Aug 2025 18:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J7gVwB7w"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF72DE6E9
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021781; cv=none; b=n6mmNknVltIQAp8A78WHZ+Eu8dTO5BRaAYlAP4XFs1DPIwDH2qc/lCVIzQM5S2tg79lZoHFO+pOxoUmVKcwmoBS4xCju8z0Ux2mINLIj2XtDfvzPFt4ECmV9oriJ7q6JdIJYVsW9MWXfK388yPhv1lcxNIVwokzi1ICx0uEsy/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021781; c=relaxed/simple;
	bh=m9izr/7WK/GC4Qm2APCJyfl9nGGZTNF7pKxjDaE9CBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gibxd82531GxvJKXbYkAQ/ec7buw8OXcKj7IjOab1igdwk+k3hYr8NA1oBQFb7DSim1RmID/tw1CBz6EIC6vRsKO4o+oHw/Oc0xZbiAbBwR3wLJ02iMXmjQPahn0SD95qWtiAA1HJmbaTS3Tn2TGpg+iKk4Qq/FOcqvE2aKXc2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=J7gVwB7w; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-31efc10bb03so4990550a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755021777; x=1755626577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6swKV1GrcMf33s31ax2gRwHXvR8uLRuUveaWyWM23M=;
        b=J7gVwB7wFe/V35S1a6kaoYSg/XHsexggkEL8p5yrd8jLRU2nfcMnOaN8cxYZmZU1sD
         uLXyBjw/QZ0bGYnM7oOUJNFtqAFDJQG7/IfiOqullWVoJec0mbokecTDh7Mkn6diFl/9
         WDUK9XGbay0KTkQUtDMAXjweorqxWeyXBqSww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021777; x=1755626577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6swKV1GrcMf33s31ax2gRwHXvR8uLRuUveaWyWM23M=;
        b=VtSJtqS809F4e+4pk0kI5pRjqkdxngMM6wAvaS+er28948WzQ9R1hHAcMblBn0oeVm
         QfQi87t4bJscSG9MEMxo5rJpwJrAST4VFXx9/7K2CGTLRlW1fchULE2nG7s2rAKiAXF0
         jybQ9+EZpha9zAw06cJMFx+/D1U4jXNjmNkjjOzlv6DNIF10HsiB9nui0+sTHwdY7R3b
         7XmxCTNrSqgwSplEPX4NyqloT9r6ADmqqOUUMY5mTWb5vxpGs5fbe+4ZThaTnBL1EvOS
         gozU9mQH2XeBjCzNrk8OxkUdaCH/eHsbffQmndsFWisknqRDvBPBBUNLVeBcr1M6ryQU
         fauQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3T08e0+bQx6cDZuHPBvmD68eOVbPNXWgI5GoEBP3A6oXKqg+ouCxiSs0lK7IbGVI7NAaMmJ47I7klqgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNJSLSAq9c7YWHw43K+JdVKXMFhgyLHMFS/eVyJmlPJM0lChFH
	XYNzflUc/eJkJExGDhmZQ/z2YoEeAQHji3YWBbjpSP69mdd0SY/fVQUFS96B0KZIQEC/HIXRQ5E
	BWdk=
X-Gm-Gg: ASbGncvCZo5i6BtYKjXGd6X2m72qrYEVWMUZf5UA4P9LeJ6XZTGFMWziHHURrD0R5W9
	B1vVoPRpMz5hO98ShlCc+7mP/ZDq/2Y3gpYg3U2LdQ4VmWGHTv+HIxvdXjtqiVsLVfUhf+ZUL8G
	XrmTe2Bg60i2itu3W5W7NIMvYbG9AnT4pChLQacJ3JEHdHPTt506rdTT6rPFzqBnpWFlxZcpfl2
	gu5fpVxlBbnVbF+l+dy0CWTCO7XrPSV9BWBb0SiCl3RR+Yu+Vgj60AemCLeRxC+bgcp8KXpOwIg
	N6ulJ18Fz8A5KVbOuF9j8m/6a3gfHo1IV6ZD77j0qnDnelLXwieZwjWVGkvykj3lMTCXhN8sqUt
	fP0erWr8Fq3p4efbmWK+OZrN94I6+xF+Ky1SqBugDRD2MiqOd+WiB/ykmz0U5CHV3bA==
X-Google-Smtp-Source: AGHT+IEhM5UBhjhivwJXzAN65jMG70CVypxIUmxwVMbYtt1+QInDf4uFnMMzejtVqBV/hdqT8qHFNA==
X-Received: by 2002:a17:90b:5543:b0:312:e9bd:5d37 with SMTP id 98e67ed59e1d1-321d0d6719bmr14765a91.6.1755021777258;
        Tue, 12 Aug 2025 11:02:57 -0700 (PDT)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com. [209.85.210.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-321b95a241dsm4511227a91.9.2025.08.12.11.02.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 11:02:56 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76bc5e68d96so5174304b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 11:02:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXv5YEFMRs6KyCo8djYgNxJYy7jKw0RX6m8PzS/GsYZAffwpYsCAhLkuDvxtFYEhgYR/HNT6Zk4tCzbkwQ=@vger.kernel.org
X-Received: by 2002:a17:903:228f:b0:242:accd:bbe8 with SMTP id
 d9443c01a7336-2430d224501mr1684825ad.36.1755021774560; Tue, 12 Aug 2025
 11:02:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812082135.3351172-1-fshao@chromium.org>
In-Reply-To: <20250812082135.3351172-1-fshao@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 12 Aug 2025 11:02:42 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U+Zh2V2r-THx25Qw7W-Fu_qM4v-+Evi+1tBCg92ieYKg@mail.gmail.com>
X-Gm-Features: Ac12FXzKfc-gYV3a4i5ca9iS6TBOZ22AxjGIHa2U4MsH1-9Cx6Q2aSnXXfpz5PU
Message-ID: <CAD=FV=U+Zh2V2r-THx25Qw7W-Fu_qM4v-+Evi+1tBCg92ieYKg@mail.gmail.com>
Subject: Re: [PATCH v8 0/2] drm_bridge: Add HDCP support
To: Fei Shao <fshao@chromium.org>
Cc: Hubert Mazur <hmazur@google.com>, Sean Paul <seanpaul@chromium.org>, 
	Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 12, 2025 at 1:22=E2=80=AFAM Fei Shao <fshao@chromium.org> wrote=
:
>
> Hi Doug,
>
> This is a refreshed series to add HDCP support to DRM bridge.
>
> This v8 revision is based on [v7] and rebased on top of next-20250731.
> Note that v7 includes 3 patches, while v8 has only 2. The rationale for
> this change is provided below.
>
> In this series:
> - Patch 1 registers the content protection property to the bridge
>   connector if a bridge supports HDCP.
> - Patch 2 sets the HDCP bit in the ANX7625 bridge driver.
>
> Both Patch 1 and Patch 2 were previously reviewed and acked (sort of,
> see [ref]). The Reviewed-by tags are carried over as there are no major
> changes in v8, except for the rebase.
>
> The third patch from v7, which was specific to the ite-it6505 driver,
> isn't included in this series. Discussion on that patch had stalled, and
> it was later reverted in the downstream ChromeOS tree, meaning no
> manufactured Chromebook devices in the field currently use it.
>
> As a result, I think we can only focus on the first two patches which
> have already undergone review.
>
> Please take a look. Thank you.
>
> [v7]: https://lore.kernel.org/all/20221123100529.3943662-1-hsinyi@chromiu=
m.org/
> [v6]: https://lore.kernel.org/all/20221117110804.1431024-1-hsinyi@chromiu=
m.org/
> [v5]: https://lore.kernel.org/all/20221115062835.3785083-1-hsinyi@chromiu=
m.org/
> [ref]: https://lore.kernel.org/all/CAD=3DFV=3DVoF5PyeNWX+4_3sseyRemZVsr5W=
tQVeg-8mhfgm40w3g@mail.gmail.com/
>
> Regards,
> Fei
>
> Changes in v8:
> - rebase on top of next-20250731
>
> Fei Shao (2):
>   drm_bridge: register content protect property
>   drm/bridge: anx7625: register content protect property
>
>  drivers/gpu/drm/bridge/analogix/anx7625.c      | 1 +
>  drivers/gpu/drm/display/drm_bridge_connector.c | 9 +++++++++
>  include/drm/drm_bridge.h                       | 4 ++++
>  3 files changed, 14 insertions(+)

These seem OK to me. I checked offline with Sean and he was OK with
his Reviewed-by tag being carried forward on these two patches.

...so I'm fine with landing these patches after some bake time on the
list. Unless I hear objections, I'll land them midway through next
week. Please yell if you object or simply would like more bake time.
Thanks!

-Doug

