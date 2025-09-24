Return-Path: <linux-kernel+bounces-830636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D58B9A303
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E404C6DC9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF50305962;
	Wed, 24 Sep 2025 14:13:21 +0000 (UTC)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04A72135D7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758723201; cv=none; b=aBeXBIhvmeiiwh9TRkgr+0SvFZGczf3E/9VVshUdfHRD8yoaubqa79GIbIomIiaZTEa/NncQ+JKaa6QWYw6E9HyXAMMXmEfI+9M1v/cs2Cs1R/DT3OMCnT666vMIOgh/KUqtk7DNNpATET4rsr0znD1WLr2pI6MmDJIPvV4qFtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758723201; c=relaxed/simple;
	bh=RAQppiXjWIWyTOC11PHSe910HHT72uEJpzqGu/pPfgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fxN/+1GF8KrJf40rKrsTeqsKN6rujimGCfhiZfUviQH8cPYqsZkfblgaDfnfwdY9M5ly99HV2PbTp5b7QJcFQtg1ynBHwn4ZnqALWsgyXuprseY6lbgBR55JWsSJfFpz7B/C951JKAEFAMzlKEGktvEXopNvxfBgjGfOUN2CgXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-826311c1774so728878485a.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:13:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758723195; x=1759327995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43BZO3RAppnebCnCAQY4LIb5j3YiQqsMBJqVptEFktE=;
        b=X7EJ13XZghC9SdMqiRjraWVAAbzhoS/q9sNJ3gPXy529Ebd0Kg1yWf8JJvLNA/8VEu
         4yhLzolBgzuD26iYLJfBYUcGxDWZgl/N+8RsCmIpXtIitZnT9oEM7mIQUPRnDA/2C55Q
         wEmhC5E9cBO4UywUWrd1PqEnr0a8Vym89NkknfU3F3hz6rwvHPxWW3X8wW/h1iUWtnFn
         ianEJPbyQIB7eL4adrPzydsarQpJ7t9jebwoZMyQ1A9JXXMrlUM+Oa8riCs1+xncbz0y
         /6iuIqiAN1+VYQ1J3gl5SXdkf2ne1P9IeE1DsYAJF8/1rpKzdV2uUR175WloX/faDew7
         wU7g==
X-Forwarded-Encrypted: i=1; AJvYcCU3oCEaYjIcvoN0YHA1GaYWsdgClJE1G76nmjnCmdZL9KgX+HovRfDJ95STl1Q9HgcBfIInpvbe49ApwRo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKgaLga6GtRAMY4q0IEIuIsT2bnHaOXLbJqMcwcgY9K9EtOarO
	4bEyGBrNtQ37n9zw+skIVUgkV+YHki4ws3mQLJoVswucWR5oQYNtyS4Xhi9JJtYg
X-Gm-Gg: ASbGncsqAQhV/CRArO03VDcGJq1JFA6Nctn+kwnRI6r8dc9t4rOzKfzuD0QISyRXR36
	nKJC5i5j19o0KKnvxNTFR1LWRR/umZ2wY5R4Qeg1Esbfl6rVkQCWh24eiHz1xY4zSRDkFjNJvvZ
	ZBL367AEJlADS9Pi4/4yiNmLmXmvUT5GA//+B5sSGNGO9uHrGjbkenXv6XCyEFbUMmrC7PJRb9g
	dURYrg5qH5WKqkfZ+qvlD3JOCyJSlpKBfV/xkpaBMD4u2Pm0BCOnfo7uUOwYz19E0fq/dQnB0Vd
	/13hpwIz8XhfVAHOWnNf2fSuTO+S5Gc3vloh0er/habQLj2cXyXZH4vHORhOSQFwgXj4Y9bc8Mz
	Z+aWflNENAo+9VIuAWsT0aIjq0DOfkC79h1TZt39o0U8ZoYk+IUWNpdegxtvsXxFP
X-Google-Smtp-Source: AGHT+IF4wzL/y4gI7fdcgb34tQrYPJqBZTXimYqXXpKn0hI2kJLnDOmUIyqANegxUP1/x1Vrhwft4g==
X-Received: by 2002:a05:620a:17a3:b0:83f:c3a7:dc62 with SMTP id af79cd13be357-85174b292aamr853586685a.40.1758723195002;
        Wed, 24 Sep 2025 07:13:15 -0700 (PDT)
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com. [209.85.222.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84b64fc9dc6sm504060185a.16.2025.09.24.07.13.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 07:13:14 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-854585036e8so158331885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:13:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAR/X2dzaFFWVPk2qyibnrR3YqysnF+qEfh1IcNAE8VITsC03YtlPhZB9ZcOv++NimOLqfuMeSNNwxOw4=@vger.kernel.org
X-Received: by 2002:a05:690e:d4b:b0:635:4ed0:5717 with SMTP id
 956f58d0204a3-63604666409mr5129283d50.49.1758722693635; Wed, 24 Sep 2025
 07:04:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250909113840.122785-1-john.madieu.xa@bp.renesas.com> <20250909113840.122785-4-john.madieu.xa@bp.renesas.com>
In-Reply-To: <20250909113840.122785-4-john.madieu.xa@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Sep 2025 16:04:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXfN2qK-Yd=ZAaLek=UMkLK+NzdU5aFr0ET3o9m8RB4pA@mail.gmail.com>
X-Gm-Features: AS18NWC4NdZL83Kq7qZvbj_wBXjrH_GSLKGUTwSbCh3zlppgYZIteZzcvWX4tWU
Message-ID: <CAMuHMdXfN2qK-Yd=ZAaLek=UMkLK+NzdU5aFr0ET3o9m8RB4pA@mail.gmail.com>
Subject: Re: [PATCH v8 3/4] arm64: dts: renesas: r9a09g047: Add TSU node
To: John Madieu <john.madieu.xa@bp.renesas.com>
Cc: catalin.marinas@arm.com, conor+dt@kernel.org, daniel.lezcano@linaro.org, 
	krzk+dt@kernel.org, lukasz.luba@arm.com, magnus.damm@gmail.com, 
	mturquette@baylibre.com, p.zabel@pengutronix.de, robh@kernel.org, 
	rui.zhang@intel.com, sboyd@kernel.org, will@kernel.org, 
	biju.das.jz@bp.renesas.com, devicetree@vger.kernel.org, john.madieu@gmail.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Sept 2025 at 13:39, John Madieu <john.madieu.xa@bp.renesas.com> wrote:
> Add TSU node along with thermal zones and keep it enabled in the SoC DTSI.
>
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

LGTM, so
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

