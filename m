Return-Path: <linux-kernel+bounces-865621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EF1BFD9CC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 19:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773D61A058E2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283A1285C8B;
	Wed, 22 Oct 2025 17:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jiRFhE2G"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D152C9460
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761154600; cv=none; b=E7YERyMdn56llr099BRtSODHT8wuRWRUYSDHQtPqlgF/sumwoVbEX5ga/BY5log2gXC0jO8udU/GDx1LR5RDtePP990Px0JhL6NuzCA5wRafYPTxxAjol3zAPT1BM/pQPBG/bCLRC5twMlSJQJehWlvRmBHHvsIXq9OMJXycKX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761154600; c=relaxed/simple;
	bh=KDc9uPnFWHQPszDBfTgovarXp9ZLs359mjL10f9fGio=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rSb9W87X4HLQf92g7teM39iQS7aN1fr6KOurH58XbqhM2x/y1BsZO7hhLLjrgR2gMeuo/oWO3O0PlknunERUqtEb//Ke05F9V6zdzFXtE1rSE0wgysS8jj8MU0/EuTOjMEFZpZxomTD57SU7nLoj8iQ8xECdjwN739aAnaTNKxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jiRFhE2G; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b48d8deafaeso1614936766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 10:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761154597; x=1761759397; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KDc9uPnFWHQPszDBfTgovarXp9ZLs359mjL10f9fGio=;
        b=jiRFhE2GH1dwz4xgUSdJQrHGJgsR0xqL67w3waR1MVeKsaOOBkCa45bRpKf1V+OALS
         tTyLDMqfqUE0GonJ7nFv+p9E9UnUo/e/HEhJVNP1QXZAhpyWItMOuZpbZf+QK9nqLskH
         AmraSOPhJzku2fUvFh9JRVUVsBaUSGsLNEvTQ+J7pHQVxBetMdahO6E2ZKgnbdp2j6Wc
         AcruDE6RgkajbQ/gtWUAwKokw1kk/PCBgJXubob1Va05SgvZYLIt+rCaEY5WDz7TYPw7
         GzS0cPNh0AxkHKzw0MPPZS+XAmq+R6v4qJ6JxEZtt4DfJLi/R2obaKKWKDU6JYLyuSxl
         D/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761154597; x=1761759397;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KDc9uPnFWHQPszDBfTgovarXp9ZLs359mjL10f9fGio=;
        b=OSHfOUL27SVAEbyOfU5Xz+mIMb5fh9fqqnL83wiMVPoQZiOlGJ+VS5j7QgfCiq+5IW
         bEktu1pdzrkt9/dQlThAGAER3U3v5lutZzy+3ZhFz99JYAJLYwgRkRwICCfO2ix1VLrN
         p+XObkWP1IIMroqRzkZBBTWRKRXhVL66+Pw1NJfRJ6z1MkfZzI82LpVeWT2FID9seUN4
         veCm/qrXtDeRtO4z2zkiCOZXRBBObC3RZDYue0oKB761PP2q+JChckOoN4ISYLghbTw5
         VRuDgFLjGaiCEih1Z8U+JxHtJ1dcnFc3oKMkgi5MAt8XQulU9TWiJvjE9C7ySf76zRSh
         z8Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWmIZ8hrd+0sdXroNKwvnzBNM83rnIPIudQ4bsSd03viZeNF1VeUmT/x9O4s7aJbCdcJsQvzPJdY0P7kB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvfPG3dVy1yRVP3BP4CFs9wZKqdc+UFZvihyZlhlhpGyg55jP3
	dQ49dFGTXc5HNcSeB4S7sOa84fp0IKDIMG4PgtqNd7e8Fok9UOclbmsDzlRglXBTNS1pcD5aQ7z
	ahhRQcl5Fqfc0GZP5XI0GLradwIl8SLu0bm9cV/Q=
X-Gm-Gg: ASbGnctHY53gA5ulxh7AAcDklbHVhIB59kkHFGO4cpytBf0k4KLpVtIoKdD44vsDNZv
	KvkjPIBs8YVChF+ilmCugMIKrCqsXimm+ANCcmvwdwNeoIFMYiz9XeE1qzQt7YlGQEvVsYS1khp
	OPTc5Cuxu/ChK7f7pwdL8i1cymfN2aRndcEJHbe5Nx4l6JCDi955U4g1a1CfRKEme61tJgWt5vD
	gDehYlajiBM6z0LkzKwy0bLtS8Kcxk2P+sKHOLpJFDo9+YGGJn0GGRo5UxS/7sD5VavAv2pXRbd
	STBa9IDnYzT22km9iJQpyk3f
X-Google-Smtp-Source: AGHT+IHRIKvSw3QZyyMuq3QEZYW4E6PeOxMLoRxS4Z20xDGy+IgP6M7w9dWSdCVm1bLEYiapH6PTfAxhxGWjK774Ohc=
X-Received: by 2002:a17:907:720b:b0:b54:981c:405c with SMTP id
 a640c23a62f3a-b647482e031mr2321145466b.65.1761154596837; Wed, 22 Oct 2025
 10:36:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022114438.1096382-1-madhurkumar004@gmail.com>
In-Reply-To: <20251022114438.1096382-1-madhurkumar004@gmail.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 22 Oct 2025 10:36:23 -0700
X-Gm-Features: AS18NWBuOs6ve0VWpktYwGR0S4Z3DxPaoZbD_xAQcyerWbGB8XP823s39evNbcI
Message-ID: <CANDhNCp4+QPhBkWgFkM-3QkFCdb80RCB=fa_7DUDO1N53F_1ZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/hisilicon: kirin: Convert to drmm_mode_config_init()
 and drop manual cleanup
To: Madhur Kumar <madhurkumar004@gmail.com>
Cc: xinliang.liu@linaro.org, tiantao6@hisilicon.com, 
	kong.kongxinwei@hisilicon.com, sumit.semwal@linaro.org, 
	yongqin.liu@linaro.org, maarten.lankhorst@linux.intel.com, mripard@kernel.org, 
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 4:44=E2=80=AFAM Madhur Kumar <madhurkumar004@gmail.=
com> wrote:
>
> switch mode_config initialization to drmm_mode_config_init() so that the
> lifetime is tied to drm_device. Remove explicit drm_mode_config_cleanup()
> from error and cleanup path since cleanup is now managed by DRM.
>
> Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>

I think YongQin may be the only one who can still test it, but no
objection from me.

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

