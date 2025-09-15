Return-Path: <linux-kernel+bounces-817245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BDAB57FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 16:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E89353AD233
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 14:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF532D7DCE;
	Mon, 15 Sep 2025 14:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O/h0bUi0"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC8030BF63
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757948267; cv=none; b=FjSKRNf7MmSJUh+umFAlLhHs4eDWOKdYWP7C13V3iNy0S/gnlAu17F0NjBfqJB7bNJWSa6yGgHpkXOcRube7Yoo7wpv7D5UYplc4oKRu1YOrvNRQPL3/SPHIEeLCDuTpjEBeENe/q2HP2uSf+6g/goVqtmRTiADiJM9Fm3zGe4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757948267; c=relaxed/simple;
	bh=8IynsGzsgz7X180dzhNxE6PK1i2vkr9WAjXS5vs2w24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mBMc6PHMnMzegZpR2UY7/3lmSpyjM/0akAQqFR6hC9G+5o5THlnK48xukkhobi2BlrG9X9cuRTJTMrAdc1/TSNJfZLvdqyIdWSEuzTyayq33BLERWy2ugDCmuMpgxbUXDAmrojFF1ujjcG/wV8QCoxwkNccKMZhCspfygjh4JE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O/h0bUi0; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2445826fd9dso51077235ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757948264; x=1758553064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWnOZJSewnsdDRnB5iGIXYYv++Gnu1xZmA3g/PLQf9k=;
        b=O/h0bUi0Bv2qcFJgzQ46OfRK8OI1U2iZ1A4m2P4FOvAaV67dya9pW5EU5fFf1dxQyw
         1cjwOT72dzlIutVnt3mdbi+RopllpivVOhOlZNChxDg7nLyyg8/BFdO2Wyq9LfJrHmAH
         mZ9283VfurcslXseuth8nRgLHv1y1wkYRRER20ymVtuThcDOraO9Q72xiJ63XGbSCUwo
         W6JjRMh+luk3Ptw9FKf2KHTjAOpMiV9QaSR1W38iN09LlmhspxhFYpv7uSpa1a7CKyWr
         m1qcK3zfqOsUmtrJMLOwMNhyi5m47Ybs7R7TRPoELXDtiXQOmHLuus0g9RsU5mGdFm5w
         H0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757948264; x=1758553064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bWnOZJSewnsdDRnB5iGIXYYv++Gnu1xZmA3g/PLQf9k=;
        b=tRAoG7ROhhgIOX01oLF1Y1lFA0mZITyyZ2VRJGYlmIpG2P5r+I0dGZDfef3an5MbWs
         hgeLq3GqsG576UnYwSgVen1emYqQWkBL11zNY6PUDl+XNhDvY6VErwwT5Abts1AlofPM
         IaDe5ZR9dor3SAf4Bh7F+SBKAV+kjv83g81kKkWUngqZhJu83t/k/aITJMls0u97i/w4
         bS9Sm19b3zkz0bXKRHbEJHl8gSg9IrSlQwqCo2Pxc48SXjT3TZKkCWWRWijW9hV4muRm
         2c43aiUgls30DmXNsOitZ+pze1fXoiIy/F/FtCbVaph98A6jgf9B05DE3aCJ3gtN5VRn
         Ahtw==
X-Forwarded-Encrypted: i=1; AJvYcCWtlnv8A53IC6GF5gvKwTvZh/sF1KuF7z5hCfpXzT669PouKR2R+RRRPYAsft+B0jIMB8f0eSAIhcbpzYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfcOGEOpcNtCmIOgBXtEeEqzHUfOnwC0q4cVR86FFgatfKAERZ
	ybQCh6Mdo3npMpIeEfGsevPk6qICwF5fiNDYQQhPMAUr1h96KA8gqIYRW/K88mYv8UwzyaXiXYh
	xEIfUyP7RrQqm1sRT4s3xvg4XWUlLCssppov7rqxz
X-Gm-Gg: ASbGncsIlEyqPGgMfLQgLXAd4zuWLPO0ZNvVDC7RRZhnD7eNbxLM1XjwyXdcnPPDmYi
	hBhci3PSQ60Yk09y5KzZvk7TqpqXDcBAZqsAc0F3vyHwobp6VKx7Hark3drG95MnA7M12HYwMYE
	/jEHxhz2hUQ3O0ePa/NKCa0oGR8B8Ddju7OGXWlOMH5PfL9QnYLXZ+pgs7hYGvIU5Y/V3VF9KxO
	cFxojtJ9Wm9goV6zDffur0pdVY/2U0B7s3iwsIfPFk=
X-Google-Smtp-Source: AGHT+IHnj6/TLndLwM8EyXwEuk/YJ9EdWGwOpk4CWXv+kwz1bKWJkqFmdEGI1fqwhaJAaM5FG2Rg3VduvcabMBwKZmE=
X-Received: by 2002:a17:903:478d:b0:264:8a8d:92dd with SMTP id
 d9443c01a7336-2648a8da428mr77672995ad.20.1757948263212; Mon, 15 Sep 2025
 07:57:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915064715.662312-1-yanzhijian@huaqin.corp-partner.google.com>
In-Reply-To: <20250915064715.662312-1-yanzhijian@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Mon, 15 Sep 2025 07:57:30 -0700
X-Gm-Features: Ac12FXxQXW-Con-zpsPtv_VMeeXMu-aegpq7H-CjBeLPv29-bp9mRKCGUG3xxe0
Message-ID: <CAD=FV=W8HGEa6FJ_NApH7V-NiJhiiaA3czXPJTbff6vWKBoy=Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panel: Add support for KD116N3730A07
To: Zhijian Yan <yanzhijian@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Sep 14, 2025 at 11:48=E2=80=AFPM Zhijian Yan
<yanzhijian@huaqin.corp-partner.google.com> wrote:
>
> Add panel driver support for the KD116N3730A07 11.6" eDP panel.
> This includes initialization sequence and compatible string, the
> enable timimg required 50ms.
>
> KD116N3730A07:
> edid-decode (hex):
>
> 00 ff ff ff ff ff ff 00 2c 83 10 01 00 00 00 00
> 02 23 01 04 95 1a 0e 78 03 3a 75 9b 5d 5b 96 28
> 19 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 09 1e 56 dc 50 00 28 30 30 20
> 36 00 00 90 10 00 00 1a 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 fe
> 00 4b 44 31 31 36 4e 33 37 33 30 41 30 37 00 2e
>
> Signed-off-by: Zhijian Yan <yanzhijian@huaqin.corp-partner.google.com>
> ---
> Change since V1:
>
> -Add edid in commit message.
>
> V1:https://lore.kernel.org/all/20250912131104.1726775-1-yanzhijian@huaqin=
.corp-partner.google.com/
> ---
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Pushed to drm-misc-next:

[1/1] drm/panel: Add support for KD116N3730A07
      commit: 65afe8b647a7c2e5c508eb28c93baddaa40812f4

-Doug

