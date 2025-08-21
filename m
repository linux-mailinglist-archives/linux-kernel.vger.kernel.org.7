Return-Path: <linux-kernel+bounces-780056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B856BB2FD13
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2285F1D256D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15D671D8DFB;
	Thu, 21 Aug 2025 14:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m05cM8RI"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F82C1E49F
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786608; cv=none; b=uvFpl+weL3RDJzGDqQGh1t9EeZNItYIr5GW86X+s9/Z6aNCZ80iOWDGdEBnaVsnnfvl/MKbH6+qgx75eNs1/CPTY0c4nEf5FB48vesYWf2WtrrMEI5Uq0tYD7g/3RbvbW4gjokUF1EyorDYGjC2n58gE37G6fq/360rM2JFKeD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786608; c=relaxed/simple;
	bh=DrLvhhxqjDy9OjOvGrvNpOWVRgN/uFtVRiHdl8KLoa0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mAFI951VBOEh6Ky3J48kAUIckzOGhWCpnjtF1P3xhpinU2qUEKrzv210YFC2RGlr8nU/Jz+qH32iuveo5b7urVMeMMyxOsrVOjvNO1hw/igQJ7/YQUQnH0SbroW8tC8Onj4lnuJ0wEYlLDPb/K6R5BhUO+t978MONGeWWqc4l2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m05cM8RI; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea94c7dso1139428b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755786603; x=1756391403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPG1XhgfF5Y/ggPoRvqsUax+jmouXC7rqUmLB6NWpdA=;
        b=m05cM8RIUFggiQ7tR1Ja03si/Me/w09ItaeKUs9RGK8+TkNPvA83sdl1WYcdww3lsu
         jcikBK77mNdnL/wE5JEPPxAQv4ITgf+3Z/tdBx7Ost/at4qa/szkSuwbBf+/1a/4wsBu
         0PI4ow+BmlHGyhC3v+FPwYwOZPiWbC6kzB2Cw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755786603; x=1756391403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPG1XhgfF5Y/ggPoRvqsUax+jmouXC7rqUmLB6NWpdA=;
        b=IscTshn/ziOce5rqYElTCIew4OmGUNWu6WCcf9cRaHwfMpdr99Y+CSxu7bttPg+JUI
         aGi0mzkLvWBYhEIwBxsEg1E67LDBj7xF9Msp9dkmfJfEJj7Y3a4X55Ywxro593G/bJ0s
         AMrHj/S3/VeaFewpDbhhcdZzoPGgp++vanp+iboAdA0sMiJV0IF/jmexptXUHqKfQpEe
         /E3ZHVROxF7tYs4Hk7RAzApAs+59tcsKyHdKnl98NDQmfreQIsuk76QlExCfCqc2CpLu
         PRKAWcYCShiwdF422mgcLr8+JpiEGzM6VJidci3AjJ1i/erefP8932A43zXXJNulIta4
         pYUw==
X-Forwarded-Encrypted: i=1; AJvYcCWSUbYoAHyhWHTMZ1SWfJp4+GHXFFSsoWQBdnjIM/J0Sp0XRJRPmICKYbXsPXuSa8wK6cHNLBbhqayk8oM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2ONr/SJ6ySGp94AZxRaHrjS689/ogBfKxvg1b80YIFSVGtJ9p
	pRbFzPX7tL6amcMnKzraFlqhkoOdUDhoLajhhfbgqhEzC3zOxFXkxd4jJU+zUOcGDD0BCJgC1uJ
	3XUg8JQ==
X-Gm-Gg: ASbGnctOvDygS6DwhmOqFlHY/7EjbQYtwwYqWuc5fEW1DWbr63pzeEic3HGjUq2Wb2G
	oGd1Npn/YJ7SCphgif1gOZ8iSMYP3mG/A0+1CX+X9coQpTmLX9oElAqwUzjvKdBVQhnx21+KHUZ
	raeKXSmtvCdrZe4Nhf51BpqYRnNOQZqg4XXqYcUEQBn+N1yekB0CGlv54teAtZZd9o9lfOdsmS+
	ectyijKwxntsM916nWsyEA+rucy4/xZJ84biwxuyrzMOwOAzzLUJMXy+uRPfxccSMR9M2YYg35I
	JSqawn80DAR4BahuMFUcmYDm4iP3vJ5I5asdrjpg065FWFMQ2GpQskQKzq36sgSBmdAyFdwj8H5
	aKeC7ME77aRfs8wWiuuvHe9YM7ePbqrJjfisfSFbFoPYjktmdqvBpg93f3ZJsRZCUaw==
X-Google-Smtp-Source: AGHT+IHFwqipu5BQUCjBia4BmnCWn6ke2xh+G2x+GFaMe9IJ9FMhsU9b8HuekVb4mnCbeX7PIwuzew==
X-Received: by 2002:a05:6a00:2e85:b0:74e:ac5b:17ff with SMTP id d2e1a72fcca58-76ea3117caemr3394997b3a.13.1755786603071;
        Thu, 21 Aug 2025 07:30:03 -0700 (PDT)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com. [209.85.214.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0fbe95sm8249121b3a.25.2025.08.21.07.30.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 07:30:01 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445806e03cso12483925ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:30:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAIlWAbOu6kL85irafT8pd7h/8SUe26QOpWPZO04u7Yxa3beC1AAArKvAgQQq54D2oEdICEmvMQDSLZWU=@vger.kernel.org
X-Received: by 2002:a17:902:c410:b0:243:7cf:9bcf with SMTP id
 d9443c01a7336-245febd6a76mr44126015ad.2.1755786600878; Thu, 21 Aug 2025
 07:30:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821031514.49497-1-yelangyan@huaqin.corp-partner.google.com> <20250821031514.49497-3-yelangyan@huaqin.corp-partner.google.com>
In-Reply-To: <20250821031514.49497-3-yelangyan@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 21 Aug 2025 07:29:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wv9czjES-xADVSLP_m7aQuuBht9vEyFRZwJC_drxdL+A@mail.gmail.com>
X-Gm-Features: Ac12FXxcomzywXeVkuRLJiRQa5Km14yR-Mbb8Mxu-Qo9E3qk5NCycqUXiWipDN8
Message-ID: <CAD=FV=Wv9czjES-xADVSLP_m7aQuuBht9vEyFRZwJC_drxdL+A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] HID: i2c-hid: elan: Add parade-tc3408 timing
To: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, jikos@kernel.org, bentiss@kernel.org, 
	linux-input@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 20, 2025 at 8:15=E2=80=AFPM Langyan Ye
<yelangyan@huaqin.corp-partner.google.com> wrote:
>
> Parade-tc3408 requires reset to pull down time greater than 10ms,
> so the configuration post_power_delay_ms is 10, and the chipset
> initial time is required to be greater than 300ms,
> so the post_gpio_reset_on_delay_ms is set to 300.
>
> Signed-off-by: Langyan Ye <yelangyan@huaqin.corp-partner.google.com>
> ---
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Whoops, I guess I should have realized that the commit description
(300ms) didn't match the contents of the patch (100ms) in your
previous version. Sorry about that. This version looks fine.

Reviewed-by: Douglas Anderson <dianders@chromium.org>

