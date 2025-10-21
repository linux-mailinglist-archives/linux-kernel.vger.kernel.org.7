Return-Path: <linux-kernel+bounces-862825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 811EEBF652B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 10E51502488
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6004535505E;
	Tue, 21 Oct 2025 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Iw+p9UuG"
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00617355049
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047371; cv=none; b=RnRiixU6AGyUvkk6EvV1XR1yGSLZVBC6dzOldxIhi4TLtMVdCbpF3+VeLSTJ0GZ3mkg6ktgbAlWWqmxaPrmz01RaODKH6V5ijTLd5GH4uIKrrdbZO/7wDyoDN4sppu+vOpHeupiOysPkRgzOQfPzviegrBT+dyvZDoBAT1dZpnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047371; c=relaxed/simple;
	bh=LDchOofmyAyCe0IJhGnwj68f427MSYzlnLLRgYWuj94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YA666oUBdGARtzs4v/0pR+qyKXxwQuuE4wYj8CbtoCA6wkPipnIw8ON57VryA5fk7onBo8BdxnVjile6oRSKABzkzZKopjoMNKCs+0gVtNmJQdcVkxKqvyWpa1J3nYReHGuyjeemCoaUrS3pRJzEqOVVclJIHkaPB/JD7th1II4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Iw+p9UuG; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-63e2c7a3d10so2861777d50.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 04:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761047369; x=1761652169; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fubOwqEF5m4iTEgESAo4RAy9nm9IW5bMGuJtgWmpc2A=;
        b=Iw+p9UuGc3kTJdz3isJNexsx4bL5gVvznj3IyFgkliSFpgyYjwUlCrPem8fsaKDND4
         9bQgCyVp0mWFjxpLGnlD0QzNtzSdlX+gY8NPhsG2NX2RJFTLpkaVRbMHGJgJFGoLCU+8
         mqPnb7f7Di9ydB0IkzSCBvJuhYMHuMsFgFuFkoTz1hmR1Y6gX+NOo8oGk6RcLkFs8P9i
         T6h8NQJq5Azv1YL/jkXUbJFA9M+4T2K20m6koHfHKRNHR3UZO2GRkVEVlMKi3gznahFO
         ciSfMIdCy9XHp/2fwsaDcEOz9Yz+SxBtKj9jEYYeo5isfY7IR2ETvmHTO9Zx7ICKyMJm
         yCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761047369; x=1761652169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fubOwqEF5m4iTEgESAo4RAy9nm9IW5bMGuJtgWmpc2A=;
        b=DB6g4hAIAqQAS5aEfyUABvRppcU6G92d3c/0TDdJTiGl7TfROy0yODt3moqXTuohJA
         NtEZ4TBrgmYt7FsGydOpgLHEbtf+86MtYrUD8fyRxBAx+ICcFTqM9cLOvOt8rZhBOL0M
         C4MlTjSOCtuYxhr2CUyEFaOcMYoQkoWsWhFbJfBT8MXXBwdTO6XczvX0TJGi/6EKSEjC
         WkpCaj5f05PwpWciJnR8QXQNRzX90uHKwBIdChLPrRvtFaom3dVo7vdPHWW6oouaAXSi
         Gi38m1q5RhUCT2QK0eocZaMPypH16oLn4z19AzeG8IPFolcvFzZu+XCLYYOnp+1/yHqH
         8DJA==
X-Forwarded-Encrypted: i=1; AJvYcCX/qMtw0/DJ8RYCs1EJc3X2W87qxru6UfhGYPX2wA9qw0BJarVQlIGAfSeuZyWX4Oa6zi+G1h2ZbkulkFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWGuNs4/azv7b6XH8xRxXAaqSmcp2/GZJTqpTNQBS8he1oVmjO
	6vyVgJF0rIDovUQse+UkziRf+nA2g/f+nMYBN8MRe7zpMg27DCkwZi1432Tvoh/fkIIDlGoMKoZ
	bwa9PwTWymCfY7SWackpZRQ5561yNmKD0V1x9TszDHQ==
X-Gm-Gg: ASbGncsY6Ehb9AM1DqYVYC4Fz/gkQRcxZ84iuy0+SppNZ0b+SEE2BPTGjlD06UHNUh+
	X2SPEkyDMefKxoOyjHsjrss43dPWaV+ydRH5MI3YOJlslzDJFueIwT6B1bqb5DX4Z5o3AxIr8dT
	Zl2DN2syEeJZzxUGVRgO5P14GzTguiGehzqTZQYvGZAymSTZGxGsQVVFv2DrBkF82eIL/xNV/uB
	ysB4ixVA0zoO9uNMSBpdpyzO5LIar1fcNPvs1vvc/CVvXkMyUm7dALndSm0Hkxl1kSDpgbc
X-Google-Smtp-Source: AGHT+IEX5EIQW00Uhs2bIpyFF0ijaBeRJMzLKujj9MqrtO2tueAMtW7djGBXmY2z8UScupISr1c9QvatdHv47ULSwbw=
X-Received: by 2002:a05:690e:429a:20b0:63c:f5a6:f30d with SMTP id
 956f58d0204a3-63e1625d3a2mr11019453d50.55.1761047369000; Tue, 21 Oct 2025
 04:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5fc18699-74ae-4f31-8794-bcbdc5ae6008@web.de>
In-Reply-To: <5fc18699-74ae-4f31-8794-bcbdc5ae6008@web.de>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 21 Oct 2025 13:48:52 +0200
X-Gm-Features: AS18NWDTVlWL2LNpyLMYdbOrlY3koMXJk_7WrqzsLLVdbjx3f9u6XYsg7juwU3E
Message-ID: <CAPDyKForizdooge04ez+cDhLW6XFHwhDPSE9fR-2ueXej=J3pQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-of-arasan: Omit a variable reassignment in sdhci_arasan_probe()
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	Adrian Hunter <adrian.hunter@intel.com>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Michal Simek <michal.simek@amd.com>, 
	Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
	Anand Moon <linux.amoon@gmail.com>, Christophe Jaillet <christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset="UTF-8"

On Mon, 20 Oct 2025 at 15:22, Markus Elfring <Markus.Elfring@web.de> wrote:
>
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 20 Oct 2025 15:15:07 +0200
>
> An error code was assigned to a variable and checked accordingly.
> This value was passed to a dev_err_probe() call in an if branch.
> This function is documented in the way that the same value is returned.
> Thus delete a redundant variable reassignment.
>
> The source code was transformed by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied for next, thanks!

Kind regards
Uffe

> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c6f09b53325d..b97d042897ad 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -1991,7 +1991,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>
>         ret = mmc_of_parse(host->mmc);
>         if (ret) {
> -               ret = dev_err_probe(dev, ret, "parsing dt failed.\n");
> +               dev_err_probe(dev, ret, "parsing dt failed.\n");
>                 goto unreg_clk;
>         }
>
> --
> 2.51.1
>
>

