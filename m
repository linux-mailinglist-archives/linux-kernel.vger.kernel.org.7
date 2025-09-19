Return-Path: <linux-kernel+bounces-824726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3CDB89FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 16:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94F0C3AF89F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 14:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3525D3164B1;
	Fri, 19 Sep 2025 14:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Gq56a7d"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF23314B85
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 14:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292417; cv=none; b=LY85fj1iudx/zWKKb6Y1V4Yf2uYsFnU/1OT+Oyu39szpBEqp55HFKnFcMSUi5nxHlPA6VeVHwYUuqzhRNgMO9+m26kIyeNExOLWcisMZHTW77rhht7BHuzu4EkJTJiMlZUy+u05vEewKc+h8GgAGBfaMndV2+e+ByPB+VuHG1Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292417; c=relaxed/simple;
	bh=e4UBUt6lR4A0mwQEEq4xjqzMIANLj8niyjojOgxFoI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNmxZ+f41uGTD9BOPV8D+rR1CBb0tSPoaK2o4VezfIyyf5I5fUynkRE1LeU0lyubmexjLYRfqO4yeLDfGQHaEpeI0q/GRcR76zrzMwTQiLFQ38grN2F5fGtAfJ+g7V+bzdvD19Me7RF1N1BwPpmrl1wNx/L7WvokY8x37LXxRcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Gq56a7d; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2445805aa2eso22113615ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 07:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758292415; x=1758897215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2gym8TYp/ovo8G/55zCJFXd/aU/zbsFHKBPG4aVbvE=;
        b=0Gq56a7dcWgKwVzWSvZVd02q3nKJi7LcU+PktMhXWJf6DDFlsyQ5mtLAhM4u30PnOe
         vo4tY204IWtbaJ4kVpZn1BwVw5gPXk+XEGcTGb9916FwTBGyKcOKw24ZqWcM75C513Wb
         3AJLIeuFlJfqM3SgZig7COpgTa6xC6MfWNqYQbbv+4E8lxjtRUYow1s0AV9j1l9bpu3y
         oyI+5EWAC6zBSnUg0P7L363uchFS7wH5/P4qHmQHuEJXOil9UcfuggWxzoRhxerElH2c
         sEZVZ0nORrgxn29rh2OXdBtcc/oBu7SK37EgM5dQBUIpZ+NOEiVs+mZU8tDzMUa8wV2Z
         +cmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758292415; x=1758897215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2gym8TYp/ovo8G/55zCJFXd/aU/zbsFHKBPG4aVbvE=;
        b=G9kl7afnwgx3aqt0AM7Ex8a9ceFwnLMiVTo6Ecq7tmuJS0RJPA8/jfI18Vhds2pqiS
         wSVlJEVBEptDxgURHi5Y8fq0Sl5siuVI1lk7U8yQWRijRfdDjyM7GNxjcFfTEvnmWX8y
         lkzq7DA8zlbmEisKE9CGOlkWQ/NOYLN6U/7JzpUoqIEr9KVTN0UV/8ctaz1nGFLXv59O
         43FysUfkgyNFHFoEM0nobA2V6qbZ26MmCpwyxfDzowoPajBWdRYAZONU7qLN4NNPwVa9
         5KQb/np8NBGvMbIR1uTsh01X7fw0aBGjL7NDMN4GM3sY3G/aR4AJJb18Kyt8+rSFFxoL
         yRlw==
X-Forwarded-Encrypted: i=1; AJvYcCV1Fr3qXnwzcKYDcMkJAwvQP1xs+RTEL80BA62229kYizJW9gyE70p9OheldKRqPZwUyX2GzW18bnXipP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT31CEZovOP+TBo4l4Q0VWivhCIVIxshhBgYkxDZ4ZI24jjXSh
	o9ayjXTjtZXMmvxLzPLcNZjJ0IpGSf//ntJlgsc8/MDCa5ecVtOZuA0Y8OpnU4N2lmUwnnbM83S
	CWmenf+KPQCEqgZV+T1LhinQeoFNVtdk3cu7320jl
X-Gm-Gg: ASbGncs8kqEt2X0DKveTrrbx0lux8Mp/S/rZGvqGroaswMvbVP1A3b5kUJ31ZwmrFA5
	AbQOa2yIQqvr8WLua3/sKcBY4V6BXsUzBiacu6N+j5iygNuITKK5xAy8bvxV/RqXQcS42T2PcN8
	zhYSUZQcK9vS3T6iH1BeZY4XZhmpvrv1gk1HydBLvN613t1UTDmmCib6GJAAhBNzgw1YjOzwBRM
	SI2UlIzxOararScnnPlMoXsAt43uLRmCk2PDOkpHwhXvjs=
X-Google-Smtp-Source: AGHT+IGoZM0jnVTt1Y2CJHZqnYGBoUxj4B49GMuB7/9WxT3I0dZXKe1ddSPAgfCVn0IDJ7MGh4cZz1erCcimfhFsdfE=
X-Received: by 2002:a17:902:e787:b0:269:9a71:dc4a with SMTP id
 d9443c01a7336-269ba562469mr40478525ad.41.1758292414956; Fri, 19 Sep 2025
 07:33:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919111101.2955536-1-yanzhijian@huaqin.corp-partner.google.com>
In-Reply-To: <20250919111101.2955536-1-yanzhijian@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Fri, 19 Sep 2025 07:33:23 -0700
X-Gm-Features: AS18NWD7sjIWHslodAybxfuXYKhfB9xyIPTlMG3JfDBvZbYFN3An-yBQPnL5d3I
Message-ID: <CAD=FV=VDChmUn50S7FKUumEDXZS-S4YZyyV4B1-HiHAiiDEn8A@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: Add support for KD116N3730A12
To: Zhijian Yan <yanzhijian@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Sep 19, 2025 at 4:11=E2=80=AFAM Zhijian Yan
<yanzhijian@huaqin.corp-partner.google.com> wrote:
>
> Add panel driver support for the KD116N3730A12 eDP panel.
> This includes initialization sequence and compatible string, the
> enable timimg required 50ms.
>
> KD116N3730A12:
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 2c 83 97 03 00 00 00 00
> 02 23 01 04 95 1a 0e 78 03 3a 75 9b 5d 5b 96 28
> 19 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 09 1e 56 dc 50 00 28 30 30 20
> 36 00 00 90 10 00 00 1a 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe
> 00 4b 44 31 31 36 4e 33 37 33 30 41 31 32 00 a9
>
> Signed-off-by: Zhijian Yan <yanzhijian@huaqin.corp-partner.google.com>
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel: Add support for KD116N3730A12
      commit: 048deed5faf012c6ecf6057ddf1340c41f69fdb0

