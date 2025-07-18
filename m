Return-Path: <linux-kernel+bounces-737211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D46B0A942
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 19:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D11D1C47D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423DA29C338;
	Fri, 18 Jul 2025 17:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b="W9Kw6bKp"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA04503B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752859073; cv=none; b=uKCsu8LjNJ7MfuzwFnjo949HhwP78Nl+kqZ4movJkI/Kwsm2fhEanHerxuTJ5rK7nhnZPR19lM2fIaa9X2TZowQXMhvqu32RUszjCKmP/fnv0wCUPUgS8lWPASe8AY3hyqoMRynbPkHb0Th7BOHUDRkKcZAJBiYaMcqrPTHckGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752859073; c=relaxed/simple;
	bh=JUlQrI+fknuidygvc0QVhNjmP0Fn5UPuVWMQ9E41q1s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nqTO7Cf6SGO1iCU920i0fx3IzjhjcL9Lva3y3VKe9ozyicMp9XysLkYUft+ihbvmo6vVL7umzvkj39PWUe3VlttSiwLnr2YNsls/sPCNNGlVe/6oEcrWISuC+ik4eo8r5eadY1BPRDW2RBlvJ9gidzONs4OmDejs/B8/vr4WO1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com; spf=pass smtp.mailfrom=brighamcampbell.com; dkim=pass (2048-bit key) header.d=brighamcampbell.com header.i=@brighamcampbell.com header.b=W9Kw6bKp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=brighamcampbell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=brighamcampbell.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-234b9dfb842so19912165ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 10:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brighamcampbell.com; s=google; t=1752859071; x=1753463871; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQsUdI99uVdv1G5VrfovBfE2ouV4UkpQzyyZDykQuDw=;
        b=W9Kw6bKpYxcq+T7UAVjFy3KRpgsXAc7ldPpIk+0x4HC1h9QQabqjXwPgI61ZIJUWFz
         rVC+RJ5a3GKaS/5Aiip9w9FsvGIhna8hxZGs1P0z8GtqPII5OdeOL45RZFYRPt+Ma4rf
         T+XTXMNvgBAu4G64sZuxo1C71JjiXXv9XouGOWs4Hv5TfMXUhLnZPL0SSIj0CF5xCU4r
         2DNJR+8jvchqwTdlHjqHTrMR3rnRPAb91AIwPSHkbc/g/5rwGvGPoKVyWZvW+yHfP6kw
         Lgl5vtJk13IpB7kwhPBCKkYrVBvDWBIQJ3yUlJJk2F0WQ3y5WoSZ2dlS4MtRQHMiOaAe
         6lQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752859071; x=1753463871;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aQsUdI99uVdv1G5VrfovBfE2ouV4UkpQzyyZDykQuDw=;
        b=Pxf1uCNO6I9l8LN8ARPWBIJueolQjQeRH8Dd4Q/+BLff5fsco5hkTYWpBCQpyLqlrd
         Q8UKfc/ImJGBL6tIqQmBLx0nTO8YDntJMhWiobRWXHdkuFzLw8B+2wAGLFN3tccfCwX7
         CD5eRgMISCARxyUA/ku0WSR6fjDw2YEKNd9dlH5tUlrXOUutDpqXV9PlCWnRgMJNFyBd
         3N4KhC0eujIr65/OTEEpx9v/fx3tnP5OJeSMUskPEkKs6exPjvmvJD7vahclqFGwpPyP
         X9K7DDFYRVfXYVvlB1m0W32YOPij06Ved+8FGDkf3mnqs4QTTFVwgyUZXyNBmQ+9Omd5
         6Ojg==
X-Forwarded-Encrypted: i=1; AJvYcCVIdXRt3yKy43I3Rp1vv3L8N4QEzEuQNJeEfjU7jzeMBQSsxjkRWMpN3ESEZPaynR3ukTLGjT/kViMUFCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGqzso6lEWUvRq0GAyV29F0tktJXD401iboDvuJPL9pf68dsYx
	5aO1PhZvlaRLZRF6afkBv41STfv6mQBMlboL3P6sY4OhljAnByMSis3643OpCdS7hRI+qFOCC48
	pc+qtOnNeLQ==
X-Gm-Gg: ASbGnctO83s+r0cTgJHv82EkSH3wY0t88fkzNhBgV6Tpj43lOayuEW9ThmYvNMMz+HO
	jks/z9Nc2NUopvnFkO4B7vyREiM/3sLrnZxwoHlKdQBVjCAOIU89kmvXiT8Xa7Rb0Im6vSiuHED
	bHbh0NGLjd/bMlRAp+/ZQO0upMuLpePhuiwbpUu+BSV1jTsnC+fFmuBHGHJ6un4Wifsc5IlNoxx
	jQXB8hjP9wgIQ3+4/CS9kAuyfsGNuS+lxWVBK2jKRSrB4ROl9kWCUzXdos4CLUqs4UIIwkJGq5i
	JhpCSXLlKsqn5HalfiJhovyL8R/UBPH5bEAA1//EVGdNJq7vtFAWNHR73qaX5QPSNd/GYK78Bvf
	+u2RGkqUVeLLgHnT6J3U=
X-Google-Smtp-Source: AGHT+IEY9VDKHPJfWeHWvEU5wqF+TlZwRpsDoYx13B2warjVxgd6exSsfIi7OB5Q426MGYSgEP16xg==
X-Received: by 2002:a17:903:8c8:b0:236:94ac:cc11 with SMTP id d9443c01a7336-23e2566b0d9mr164068795ad.7.1752859071385;
        Fri, 18 Jul 2025 10:17:51 -0700 (PDT)
Received: from localhost ([64.71.154.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3b6f2184sm15987755ad.224.2025.07.18.10.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 10:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Jul 2025 11:17:48 -0600
Message-Id: <DBFCOJFGI5HB.1RNJBDPNTEL2U@brighamcampbell.com>
Cc: <tejasvipin76@gmail.com>, <diogo.ivo@tecnico.ulisboa.pt>,
 <skhan@linuxfoundation.org>, <linux-kernel-mentees@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Subject: Re: [PATCH v4 1/4] drm: Create mipi_dsi_dual macro
From: "Brigham Campbell" <me@brighamcampbell.com>
To: "Doug Anderson" <dianders@chromium.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250717164053.284969-1-me@brighamcampbell.com>
 <20250717164053.284969-2-me@brighamcampbell.com>
 <CAD=FV=WYBFrm-J55BTEJ7s=Jk4EFuMVAkahVZfdzW6V8mxE7Tg@mail.gmail.com>
In-Reply-To: <CAD=FV=WYBFrm-J55BTEJ7s=Jk4EFuMVAkahVZfdzW6V8mxE7Tg@mail.gmail.com>

On Fri Jul 18, 2025 at 10:10 AM MDT, Doug Anderson wrote:
>> +#define mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ...)           \
>> +       _mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ##__VA_ARGS__)
>> +
>> +#define _mipi_dsi_dual(_func, _dsi1, _dsi2, _ctx, ...) \
>> +       do {                                           \
>> +               (_ctx)->dsi =3D (_dsi1);                 \
>> +               _func((_ctx), ##__VA_ARGS__);          \
>
> nit: shouldn't func be in parenthesis for safety? It's unlikely to
> really matter, but just in case it's somehow a calculated value that
> would make it safe from an order-of-operations point of view.

My assumption is that wrapping _func in parenthesis would cause a
compilation error in the case of _func being a macro (more on that
later...). I'll test that later today.

>> +               (_ctx)->dsi =3D (_dsi2);                 \
>> +               _func((_ctx), ##__VA_ARGS__);          \
>> +       } while (0)
>
> Can you explain why you need the extra level of indirection here (in
> other words, why do you need to define _mipi_dsi_dual() and then use
> it in mipi_dsi_dual())? I don't see it buying anything, but maybe it's
> performing some magic trick I'm not aware of?

I mentioned this in v3 after the changelog and prompty forgot to include
that information in v4: The extra indirection between mipi_dsi_dual()
and _mipi_dsi_dual() is to allow for the expansion of _func in the case
that _func is also a macro (as is the case with
mipi_dsi_generic_write_seq_multi, i believe). Compilation fails after
removing the indirection.

There may very well be a better solution to this problem. I'd appreciate
your thoughts.

> Reading this with a fresh set of eyes, I also realize that this macro
> is probably vulnerable to issues where arguments have side effects
> since we have to repeat them. I don't think there's a way around this
> and I think the macro is still worthwhile, but something to go into
> with open eyes. Possibly worth noting in the macro description? We
> could probably at least eliminate the need to reference "_ctx" more
> than once by assigning it to a local variable. I think referencing
> "_func" and "__VA_ARGS__" more than once is unavoidable...

I'm using _func, _ctx, and __VA_ARGS__ more than once in this macro and
I don't expect the indirection to fix the potential issue of unintended
side effects. I believe we can use GNU extensions to eliminate side
effects to _ctx, but especially since _func can be a macro, I don't
think there's much to be done about it. Not sure about __VA_ARGS__.

I fear my inexperience is made sorely manifest here.

Happy Friday,
Brigham

