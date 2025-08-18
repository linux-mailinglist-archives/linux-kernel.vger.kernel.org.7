Return-Path: <linux-kernel+bounces-773426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EE6B29FD8
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63B53B53A2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73E7261B9B;
	Mon, 18 Aug 2025 10:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YZiegpXC"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A516C261B98
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755514568; cv=none; b=eCKKVJcm9CfemzZpuHX2CsRGVtKHtJGqRdzultM4+icmZ3o7Hz0Ds1YbKUxfUMAS5dhZFsI/+RCIRbZCxWGaI5HVppBPt+MQD+85R3NgQkfvrrRbykS/5YL/dqOSeNWrufDMVhUcnKKysceaoMuzGpLv6INUGAhsrUCsKF1cse4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755514568; c=relaxed/simple;
	bh=jxnu/FEhDIb+0x6qULMoBWUNLjUiRBXs0W3MtieNfUg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCxAAe6c/ODDyckcMPloWOIa2fIynhuVLUTKy4j6MDZJOdYp+kOA6DUp279YmamBAHyRmTKEkpA0TQFrkvF4LW1f6hAzxwWoexsU0v0wlYiT9ozsbNyz4LysHvsqIXQJTxC3c2qHbcJ5z3VreLEcM3E87HZBUHqXvG8R0NUrnZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YZiegpXC; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d603b60cbso31019667b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755514566; x=1756119366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1b8N64MqBxtdg6Md3INHXM2YASwrOfNIX/lKR/8J+KM=;
        b=YZiegpXCulLsU4XmcakeiwDIx9ChQntdLnJBhl/mS6H7G+RsM7marWno4jHEj+ZK1d
         9+GHUX9jj3xpcAPFTCstwwuKj3Gw5YsZJ4vvg5cX2P9h3pUKk8aIL5HLTJ8kl2Qf8ovS
         zVjsyS6QJmeMgMpl9k6rsoNtKy+N7CQ1EiJNA1Vwq+5duY3f+MNBRGyc8eFPfecXLC/W
         7HhLeOlmijNJZcuQ2tD8vNlSOzXkZ3MtumnpOFSZcZA3L3W4pSsv4QlR8El7cwh9ddph
         8k9oKhPaNQF93ptmeTsGQ189SBH1/Ap6Kk42AIUILtEaIYpfwk6h/XBJWi2FiuVgSBaE
         w09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755514566; x=1756119366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1b8N64MqBxtdg6Md3INHXM2YASwrOfNIX/lKR/8J+KM=;
        b=OPFxvhSK/zLdgbZfGC+aHaRE8VQ4/8zqU6J6l/GiWQ3DUBb6sdDT0Tyr3EIdW4aYrd
         miDel0p2vl12j+aPSTYd3pGkoNbqB/+Bu5FPEZ3xLLxUeoJRmZUxBSRUYs9nkOqjGE3N
         PGzK3NtzOEZrCEJY/79A4qL8osQmLkkdheuYtJ/utacWm28wlJ0qGid89jjP2YRFbPC7
         Z+c0CJluj4MbiO0ny01Drcc/vCqLluExpu/gqzzUQRhFre3EpEM4yzvwUk8OsVydsW2Y
         1ditpXJFL6WubUDYFS1CYsDfy3yZR7Ro+dcmMo41aGmYfRMIZFj1Rp6PDtXJNLFxmUPO
         +HgQ==
X-Gm-Message-State: AOJu0Yxeu0q5/siKvJN7DfqYTyMD6W8pUu79jQ6sLBy2Mbji5drrmOnw
	vEv6KuaaMzLzqrSOYmfuy7cvuAWTfKgkwsqMABTACACsk+PjlFrq/1lUg9Pzz18b3Fols96B5Iv
	oMZvqrkWZ0jIIFMxrcPVCXElXnqNNF9440cMBvJSZWg==
X-Gm-Gg: ASbGncuGPMUukNlt5YnzFwe7a//puEzHtf3H4pHSHbWTahovoPW7SH9HPt73+aotekJ
	wHMErx6/VoWqJEJ9t0YvhJMy/5ygPj81k/2/nEIDowrf14FvKZnAKrMbdIGPej0RMdGc39zNACp
	Een12qTd44d8AjZFpZ42fIgF9UWelUOgV21bQ3mIFnU4fx6vOm+eKkAJtjGDh5FZhpGcgjuyjyd
	mhlujg4
X-Google-Smtp-Source: AGHT+IH15gkPWwCvc5PywNU5D/QK0nGxHhRHiumu/lEM3Txj8hZO2Y340R+Kfm/qCGDXBKcQw9v3YihoNtgwIe7LbYU=
X-Received: by 2002:a05:690c:74c8:b0:71b:f500:70c0 with SMTP id
 00721157ae682-71e6d9f2fe0mr141459777b3.6.1755514565675; Mon, 18 Aug 2025
 03:56:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250813161517.4746-1-wsa+renesas@sang-engineering.com> <20250813161517.4746-11-wsa+renesas@sang-engineering.com>
In-Reply-To: <20250813161517.4746-11-wsa+renesas@sang-engineering.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 18 Aug 2025 12:55:30 +0200
X-Gm-Features: Ac12FXzrKO2nm0jcbAZqxzbeAAtZHnjZ63sxktJhx4Uo6D36k115qSOwu0HiS6c
Message-ID: <CAPDyKFqiF2b-LOr8aGgy--u76=z14dCwUveTN_zQOKLpjyhY3A@mail.gmail.com>
Subject: Re: [PATCH 10/21] mmc: remove unneeded 'fast_io' parameter in regmap_config
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Aug 2025 at 18:16, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> When using MMIO with regmap, fast_io is implied. No need to set it
> again.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> No dependencies, can be applied directly to the subsystem tree. Buildbot is
> happy, too.
>
>  drivers/mmc/host/sdhci_am654.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
> index e4fc345be7e5..8a099508b939 100644
> --- a/drivers/mmc/host/sdhci_am654.c
> +++ b/drivers/mmc/host/sdhci_am654.c
> @@ -95,7 +95,6 @@ static const struct regmap_config sdhci_am654_regmap_config = {
>         .reg_bits = 32,
>         .val_bits = 32,
>         .reg_stride = 4,
> -       .fast_io = true,
>  };
>
>  struct timing_data {
> --
> 2.47.2
>

