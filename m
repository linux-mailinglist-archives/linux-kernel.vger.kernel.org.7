Return-Path: <linux-kernel+bounces-751006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 857A3B163FA
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5A377AFEEE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 15:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D5F2DCC05;
	Wed, 30 Jul 2025 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U+h+MsTr"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7392264CC
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753890981; cv=none; b=oW5idDq+5vYCim00bZtLSqm8Ce98sk8aZFWpHcVUqKGOCVs/1DpBpQNxJU2qwsahAIoy3s+YW0xzkKr5fCsndLlE6Q8qeg0igMztzfySl5vCTZbWbPe8lZzNBvf0L1qfRM/tk9Dj6EeeSbM/WFl9I7bAQdNI9z8rq4D9AJP55Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753890981; c=relaxed/simple;
	bh=qPRfPAdwxSF9cJgzAeKxMbGmeL4lpPBLEqUlY8pDLms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R4y2NqI9SMT9ENIBdqApp5g7ixoRLa58GwqHjxezW51l7ZO7eXLmZlyyaa3Apt0MG1Phngz9YfbDRCr5GDLjqrQBBnr3ZGWolHsI6VkxR2rRr2HPiwpDwwbMuSWnAwLZbfQriOzXj7Kr/HBvS2ZdTRXFQrwcXvjerDG5Tlm70UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U+h+MsTr; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b3220c39cffso7213514a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753890975; x=1754495775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ac5jc5iSuVh5ffwFsIe3xf2fxESMA6NIz6igvIuJEDk=;
        b=U+h+MsTrduTecW15zFbE3pFsjiYZuYCucv6lW5JQ9RNHofX/CbvLqADEYbWP2LMS8A
         8Duy+YrwXLsGYJNMFb+TBCFGOt3tx5jVX5dj8aVIpJZyz9fjTprQ1vDiO0LoflItb5O9
         yJesZAFNSkZs8hGOF9dFCFE2/5TKVkY7UjZzk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753890975; x=1754495775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ac5jc5iSuVh5ffwFsIe3xf2fxESMA6NIz6igvIuJEDk=;
        b=JMCaWc1rHRDbjXsT58GwXLKf2u5Df8/6QYT493AGMoF7zEht0KOoDw3uQrIqP0ExBl
         H4Z2nT21nxxNl68g5LwENW6z2aGHGRvTA+HGlPUViHfstZaqIMsWG0SxQJnSZyv3gtmb
         8Qb6TR3rSEXH6Cj+V9xWbqLUc+DL4XZeTq8hi1rr8F4G7Q6TskTmMF0n90Mnx9Wgp/SC
         lXu0PJcP3NcXtv7H5Oc0DhcTzu+gor6L7cYD1ZIYMbI/3sbMGD+QCe/Mv9LElIXjFUxX
         XZNIXAlK/yQgHNTWgiqIOBKgZa/NKruGq1m0XZMdv5XqQG9ONP5S2CawRgJO6wHFoDpD
         024w==
X-Forwarded-Encrypted: i=1; AJvYcCXMpYXrxcYO94ylWULFG/gJun8QF72LFQik4X1BFvrDUvqZoTFoAk2cI8fEvL/zFhOUF8uXdNt9dGfJJQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxghnKr67bXdryI2Ae8ssc5MBAJQh4G9Sq9L1CBeYNRScHWGse1
	CbBizPC/yh3FrU2xghixFz7zUuNLZc4u8YcPck4sOf1gMWePS83SItmaN2kGSqqPBYjDg502qdC
	t2Ag=
X-Gm-Gg: ASbGncsUkBUSIAUSDGYzdG9l6WMsbJe5xxau1NwCQPpQPSao/zRpSNLf23VLCZiHwMC
	3ByQtW4VwMUjYe5HqHy6Cx+aQUAuRhh+Tm4HGnfMQLEjiX8wBhupKUbZjJYT2r/uy5v7qrCu0rD
	CpgBceXhL8Z1ozmpU9jNY8CwmR2BjmC0voQRK4hWLiqFwRIyIkxZqxohabu8fICSC2zq3nl7bmW
	DVa2wFqN6A+2VuKeU5p7Waj0HIFsupTG6ZpTSChI/HEjA9efCp3icp0IIrqnAEsi9t5Fuacccsk
	wYb3ce+ZAUQnIlGTD1StyEGxdPUItmksN530IwOQTQMm24laWTk7rDF0igNzWMZa0dnLWCEUB97
	DWoaZGb5snLVT4q4Z11dupucGTAOWxM0KXxHPHUzmwbZNfwtQB8GBk04jRzeCxEbRQRaVA2f/Rv
	eU/+HfuII=
X-Google-Smtp-Source: AGHT+IGCWhkZwAKKcogv7ZhD2Bqtr3pMdO/Tx48aEkCr7oVQNSiHohctoboyTg7Ot75mx0L+tqd7vg==
X-Received: by 2002:a05:6a20:6a10:b0:218:59b:b2f4 with SMTP id adf61e73a8af0-23dc0eb2b8bmr5974663637.42.1753890975453;
        Wed, 30 Jul 2025 08:56:15 -0700 (PDT)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com. [209.85.216.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b421635cc44sm2592969a12.40.2025.07.30.08.56.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 08:56:13 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-315f6b20cf9so34234a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 08:56:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQW5GEXnwiAPWQSThrOO9/Bn8XNU2oQLa2swDmI/0Ii9wGdmSo9omDUqpmUwmRG/cWkpB0t9u99bydtjA=@vger.kernel.org
X-Received: by 2002:a17:90b:1b48:b0:31f:4a91:4e97 with SMTP id
 98e67ed59e1d1-31f5de1ea3cmr5307381a91.7.1753890972855; Wed, 30 Jul 2025
 08:56:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730061748.1227643-1-me@brighamcampbell.com> <20250730061748.1227643-3-me@brighamcampbell.com>
In-Reply-To: <20250730061748.1227643-3-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 Jul 2025 08:56:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WpbU-iuEDVRuMm87H48PKQ3pz5aBwTRyedguFQA3dvTQ@mail.gmail.com>
X-Gm-Features: Ac12FXywEUfNlazykPXpS0so8Utrbf7RYxdVRu4_QjEIfWrjs2DXSKQ83cwp0WY
Message-ID: <CAD=FV=WpbU-iuEDVRuMm87H48PKQ3pz5aBwTRyedguFQA3dvTQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] drm: Add MIPI read_multi func and two write macros
To: Brigham Campbell <me@brighamcampbell.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, linus.walleij@linaro.org, 
	neil.armstrong@linaro.org, jessica.zhang@oss.qualcomm.com, sam@ravnborg.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 29, 2025 at 11:18=E2=80=AFPM Brigham Campbell
<me@brighamcampbell.com> wrote:
>
> Create mipi_dsi_dcs_read_multi(), which accepts a mipi_dsi_multi_context
> struct for improved error handling and cleaner panel driver code.
>
> Create mipi_dsi_dcs_write_var_seq_multi() and
> mipi_dsi_generic_write_var_seq_multi() macros which allow MIPI panel
> drivers to write non-static data to display controllers.
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>
> Doug, you had suggested a slightly different shortlog for this patch. I
> adjusted your suggestion to fit within the canonical recommended
> shortlog length of 50 characters. I understand that the 50 character
> limit isn't a rule as much as it is a guideline, but the current
> shortlog seems to me like a good compromise.

Looks good.


> @@ -431,6 +449,23 @@ void mipi_dsi_dcs_set_tear_off_multi(struct mipi_dsi=
_multi_context *ctx);
>                 mipi_dsi_dcs_write_buffer_multi(ctx, d, ARRAY_SIZE(d)); \
>         } while (0)
>
> +/**
> + * mipi_dsi_dcs_write_var_seq_multi - transmit a DCS command with non-st=
atic
> + * payload

I should have been explicit, but the above "non-static" should also be
"non-constant". ;-)

I could probably fix that when applying, or you could send a v4. Up to you.

Speaking of applying this, I'll be on vacation next week, so I won't
be able to apply the patches until the week after. That will also give
anyone else on the list a chance to comment if they want...

-Doug

