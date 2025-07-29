Return-Path: <linux-kernel+bounces-748984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60702B14867
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 08:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 256417A7F38
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 06:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F9D25F79A;
	Tue, 29 Jul 2025 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kcTu401M"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E649638F9C
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 06:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753771554; cv=none; b=B7DHAuAHlwxSz/RyVOw3R3J3S+gbSq0Ma/nLLKbUVoSp50su4Xi58PZcFICkV8R5eHVX5TrJTiJFqn2YXGj/nnckC8tSZ5Lvwj9ZhN8Pn4Dykbmsa1+36Mo9o5mjtJnJgoi9pn9NBFuz7dpMzZVTeAslOmMlrKxvxAdzaMXqm5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753771554; c=relaxed/simple;
	bh=PcTpL9aiWqsUnil6m9DsRT09aiu1VZaQCa31F05p/d0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWw9K7i/rgRZFNIgdkye0ExMd1NHLcsg7NJoO7w9AwSWicQpoOaPEQKwJyj2FW2cy6SC6vzkwpRHbN4a3eXU4W96D7wJW8BW7wix/DdL1XqLTedfvxZ0q8DrPz7goyCAnClmH07WQRF84IROHM/SdRuKTLlVLcSzFNbvFndd9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kcTu401M; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab39fb71dbso54500191cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 23:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753771552; x=1754376352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQoFGeyb1sa0etD/ehhA4Y9O6J1HPk2CYhsuhSG36cs=;
        b=kcTu401METupS5U0Cu/z1/ynmRaNgR/ZdoxLUk1GDzGkOvXMHOFuo6lf7mWDv11sla
         g0Rme4Q1IrJgeaww3xo2DcngwZpHMdG236QfQrl3okYutplMPGuxde0J6Lq8RP3WobBt
         0UP5NODZHz1K+DGQ9oj3PP3iO8UrIIEOviVZxfKvRmQ5myQFFjFHVvjuQB7RNjWFewN4
         TuSx2jXe5RiEvdao31obkOSU7WrNS30qbPw7SE/jhGaIst9zr++M555d88LYs9SycINV
         iktgMxKPHMZJQeMcIOtRDWVJ6kcdyBDfjEz9f2liFPzj+2xYFBSm0smE+3CB8VgHI95w
         e8Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753771552; x=1754376352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hQoFGeyb1sa0etD/ehhA4Y9O6J1HPk2CYhsuhSG36cs=;
        b=dfmYmYedMwCWqoTou9JDIVHCmcT6B3hesjAh/RuNTV2gs+PQVEa3WmQVhzh+9jWySy
         sdPYbN6WD+IAvzKoMPqOqsKldk1SaulZ1IJHN+Fp+8A3HfW5peorD38IOGS7yxxfBHmt
         2bC5jg/IVgWRhp+ol6oXsYdE13nCJMVGsZczsS329EWXMhc5QOk5HjSOfBb4JWGwd4dL
         dTjy9GRkIrzjj5VQi6PxjojlBSnFgWx7XE7+XZ2asZKLZwK5tSk/SmtHW2Fsj+oIBpji
         5XybjV+b+yZ65B3uRclzLt6sI7DqQM+2ls+wuqnXc97w7MhUVsF70U8tt99Gfz96UFBk
         Nhiw==
X-Forwarded-Encrypted: i=1; AJvYcCXykMo9SUReogw/BGdB14FGlYS+2+xGTrI3EJDuPke2NfJ88E3gwOsUNq6t4kvVRuIEAb2YqYOzztjUrCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3YL9EZDFA9y2GvY2u0c4qx5pI7/YarTDa8e4kbY2kPDBudAGZ
	uJfg64u0/Zwr+QVTsTCv5xlZUC6zDW7TT8VMdTmc6f5g5KaTMfH1miXy3k2ZQEM6Htb9XJ0cnWf
	Yq3VzrWfygDjZGHfDxJ5Lj+uyXD1z+BegGdj31VLH
X-Gm-Gg: ASbGnctP/XsJfaxcFzcCCGK9R1j2dgGpYEn+LLXPZZDps8UNwxOaiJC9fp+09q3D3j3
	o7xFvaS3a10q8pOkcNroTkKNkwNiPNI70Ei3yZ3q+1hYN5LO9DLqyVtL5Jq5ShYA8d3KHCuB158
	bfTCHo3DAekvqyWpL1UB1LerhjPrScjCvTErTjM2zDqg/C5euDg8MQllWQrRpQAwGm5nBRpIK6E
	ocOzw==
X-Google-Smtp-Source: AGHT+IHJGSa9BrDBGmv4AeJEGRr4VYK1jFw9YSODWnec8HNcZ0pj3L9SBPJOg6NsXnpbR5XSn3B/4FEGuMfMVsP4lIY=
X-Received: by 2002:a05:622a:130f:b0:494:b1f9:d683 with SMTP id
 d75a77b69052e-4ae8f14b8aemr192800181cf.49.1753771551558; Mon, 28 Jul 2025
 23:45:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729061034.3400624-1-vineeth.karumanchi@amd.com>
In-Reply-To: <20250729061034.3400624-1-vineeth.karumanchi@amd.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 Jul 2025 23:45:40 -0700
X-Gm-Features: Ac12FXzJv3RoIAVw7ZgeBTkccqUfjGYeQkbZlYWZf56ZMDuvnk7VBHW81XjCz40
Message-ID: <CANn89iLhSq4cq4sddOKuKkKsHGVCO7ocMiQ-16VVDyHjCixwgQ@mail.gmail.com>
Subject: Re: [RFC PATCH net] net: taprio: Validate offload support using
 NETIF_F_HW_TC in hw_features
To: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Cc: git@amd.com, vinicius.gomes@intel.com, jhs@mojatatu.com, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:10=E2=80=AFPM Vineeth Karumanchi
<vineeth.karumanchi@amd.com> wrote:
>
> The current taprio offload validation relies solely on the presence of
> .ndo_setup_tc, which is insufficient. Some IP versions of a driver expose
> .ndo_setup_tc but lack actual hardware offload support for taprio.
>
> To address this, add a check for NETIF_F_HW_TC in netdev->hw_features.
> This ensures that taprio offload is only enabled on devices that
> explicitly advertise hardware traffic control capabilities.
>
> Note: Some drivers already set NETIF_F_HW_TC alongside .ndo_setup_tc.
> Follow-up patches will be submitted to update remaining drivers if this
> approach is accepted.

Hi Vineeth

Could you give more details ? "Some IP versions of a driver" and "Some
drivers" are rather vague.

Also what happens without your patch ? Freeze / crash, or nothing at all ?

>
> Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>

Patches targeting net branch should include a Fixes: tag.

Thanks

> ---
>  net/sched/sch_taprio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index 2b14c81a87e5..a797995bdc8d 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c
> @@ -1506,7 +1506,7 @@ static int taprio_enable_offload(struct net_device =
*dev,
>         struct tc_taprio_caps caps;
>         int tc, err =3D 0;
>
> -       if (!ops->ndo_setup_tc) {
> +       if (!ops->ndo_setup_tc || !(dev->hw_features & NETIF_F_HW_TC)) {
>                 NL_SET_ERR_MSG(extack,
>                                "Device does not support taprio offload");
>                 return -EOPNOTSUPP;
> --
> 2.34.1
>

