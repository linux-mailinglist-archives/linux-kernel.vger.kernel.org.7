Return-Path: <linux-kernel+bounces-882420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 147BEC2A6B0
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 08:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D2C104F0429
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 07:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780CB2BE64C;
	Mon,  3 Nov 2025 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="rO9IiVFx"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7C34D38A
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 07:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762156338; cv=none; b=Rpsk196+EfhXOqtHBbD6AjONoo1OQNqS5Sr3RM9B5tl09Zryr2yBP90LA1lxZ+jITYjJyMORGvhs/LjHE1slyz1oAIkdNI3cUv9bnz3MhKqrFx3z2aTgoYIFpybxBlVRkQ2algQNH1xnGk6ycM2mQ8jExBq2NUrlhrLSJofKkcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762156338; c=relaxed/simple;
	bh=xPw/EkaLjlYdn9ZRdoZnxkDOXDBERxtHMo4O7WD9kas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X6PdvWivr3+u8h/s7nVWHgxfAkY7bg3ZHQ8KZzcCbdon3rGkDo/TS6PYmY/fPF9huDC4rSMYH5ii58mNdkyBIMcHK89+HssnUApbSuhTwaPKIlKx4a71X/Uz8jVREasWztmmCmkxn6cwVHzcu/3l4G3SLsZMNLenibQF2aWR+Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=rO9IiVFx; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-78488cdc20aso51872007b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 23:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1762156336; x=1762761136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PTPGXxwQZWvCNLJWtuoJDZzQORR3WU9efpFiIKez7WU=;
        b=rO9IiVFxmaSjqsEn2pFNiGITE1/Zj5oaL/wZ2GWhQ2DTHLaM+MmUHcGKUgwZy3XY7S
         jObW1RWJXBw9DbkIw9aGsGWs7G8iUkQ+6APstUadYfmfV8duAuykBpZBgIuc3fz+oic4
         t6cSa9II69jiAsnBCQeHJOk3J5+vuOsFC+DqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762156336; x=1762761136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PTPGXxwQZWvCNLJWtuoJDZzQORR3WU9efpFiIKez7WU=;
        b=ZvUUam/UJGop9smSO0xFa2fwnPhYx9fCmX+1w0kQIO5IRR9G0tjpluxNj4+I0+2GGA
         XwuFoEDGAlWGcjV+8r0zSSsr46vJAFoWeBZck4OFaLEjQNthkFV5T+8sqkU8RBishdsw
         rfQBLByKgJwq0I8oGsee7VRZ9DrXxCy4QFK84+gvSFsW6Wyn2T3L7M3VJuZK98GD99Qh
         RT3IEmcTFzj1BHPcCo/TXO8M6zOaLIhw4WPZJWiae0VA6yCX3iO42fza26qrT/TuWgOe
         j0ewf/3rKRVj+hOx3DdHtiacS6Uakvgp2JND2ks49H9797XVv9NexnKl6Ocasa+J2td0
         yI6A==
X-Forwarded-Encrypted: i=1; AJvYcCXb6vb7N5oaNirxPQ7igl96vMFY5jdeGJVZPD3CRe5Iu0Wdfe6jvDKCXriDT8llJzJz7LbEtstOhx7x244=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj494gP09kSCkH9XUXKzDopJLWsc4iNFHNDyLbwApJLazFP2p0
	o+tv0wqXQqQIRLD0rWPso4bha4LC9SqOxjKOUQcJUGI75z9QoJ3g3J6wl/OfgpmA8gbn41Guqeo
	jaBNWxuxpJAIcWAdPyyheyhKqE3YYerkXJkVdIixzfFEwysy1szpkHhE=
X-Gm-Gg: ASbGncvosID+seYhE+WTUhQwe40/7/P7m4a299NxoLNKHxQ+0vvStsPB+GW1ZrBueSD
	7Nz6PKXzquw301jXemFz027zdqIu2aVQmlDfb7444VasyaEW9lPGOepWE8fhrTJUfo1BOrNRPSA
	6XBQi2lap9vXLLPpBv16RalCeeZuzLTvu8WFBB6Zw+XBMp/gxUh9PBtvc+vVh0qA8/uyUltACT1
	JG9jWrQnRi5Ai3SQmKh33ox1xDBetad8Cj1c07EvMwzaqAraZcg2EXf+HACbN8MOpa8Xw==
X-Google-Smtp-Source: AGHT+IGAfPzDZnSjcBo5Myj2OK8PIIoNEoQ7eah85P2JO/xYi8s9Xp3EhC8UeEUW1VJ503f9rhh6wA8w2vjiPiymoIo=
X-Received: by 2002:a05:690c:6009:b0:783:7143:d825 with SMTP id
 00721157ae682-78648435e5amr116889117b3.25.1762156335783; Sun, 02 Nov 2025
 23:52:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251103074009.4708-1-chuguangqing@inspur.com>
In-Reply-To: <20251103074009.4708-1-chuguangqing@inspur.com>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Mon, 3 Nov 2025 08:52:05 +0100
X-Gm-Features: AWmQ_bkybyhH8oApHqkt8s9JknLUAj7abzsc0GKdxF_HV51l07GhZgwMyQ-_55Y
Message-ID: <CABGWkvr0qA+xCLgfU37agbSS7O78u-GGpLjakcWjozR4QWYv=Q@mail.gmail.com>
Subject: Re: [PATCH] can: bxcan: Fix a typo error for assign
To: Chu Guangqing <chuguangqing@inspur.com>
Cc: mkl@pengutronix.de, mailhol@kernel.org, linux-can@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 3, 2025 at 8:42=E2=80=AFAM Chu Guangqing <chuguangqing@inspur.c=
om> wrote:
>
> Fix the spelling error of "assign".
>
> Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> ---
>  drivers/net/can/bxcan.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/bxcan.c b/drivers/net/can/bxcan.c
> index 0b579e7bb3b6..baf494d20bef 100644
> --- a/drivers/net/can/bxcan.c
> +++ b/drivers/net/can/bxcan.c
> @@ -227,7 +227,7 @@ static void bxcan_enable_filters(struct bxcan_priv *p=
riv, enum bxcan_cfg cfg)
>          * mask mode with 32 bits width.
>          */
>
> -       /* Enter filter initialization mode and assing filters to CAN
> +       /* Enter filter initialization mode and assign filters to CAN
>          * controllers.
>          */
>         regmap_update_bits(priv->gcan, BXCAN_FMR_REG,
> --
> 2.43.7
>

Reviewed-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

