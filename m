Return-Path: <linux-kernel+bounces-844714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEEEBC2922
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 21:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0136919A1310
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 19:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF8C230BE9;
	Tue,  7 Oct 2025 19:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J61NADb9"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4245223816C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759867126; cv=none; b=u7E8XynsS5NA4WOlzEdFH1g4FAknASOF+QX+CqhUnwWuXPplqEsEfj10XD4FuNyCT0eX90+xJwLfnvBPGtIcoEiYA2gBuhKtVd119gM1a82aUxVM5XaF/LDnsBDAZBI5iNWFaDZKMZwnXrGvjT8UuVFaFSGuySVTXt48DRDmLxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759867126; c=relaxed/simple;
	bh=xYb0rDMNB5Kqj/n23Zh6oRZBeZ6LOsmWTGefleryl6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNLdBiKnqE8RTTYe/DcgQdy9n/k9smljwp9rKxv/YNTIBfrY8Kk2saTQfrCHErYs4zC97B4ZW4EG0TdR5FEv9MR99ufbSRTPqyKSVH0PoPvNyLyJJKafsuKeJj67K+12Dqn5rFSo1M9MsCbqvL74RadqXoI7AG84rf/3QgsEkZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J61NADb9; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-364bd7cce53so4897007fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 12:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759867124; x=1760471924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9i+DaBHwLGUsHUY6K5jBAv25/GP5doDNsw2CwcVczb4=;
        b=J61NADb9jfR4z8kYp7/TMjaZ/NtBV5IG49ddpJPzTslPoHTbmrHVtedigQ+Y8aF567
         gaFCM5SQhXGxEteFvzdwPUbUug1ri+ryWbJjs0RfMc5XLeNgxPlYRcVl0z9EdCyyQcis
         PCWxICl/wSKmRd+EepFSm9QgZLPtasuVkY8hz2QLXHCtCMGsfo0re019qIu/keNCUanF
         Byehtd2PxtGYw61eWqO3OimoXDZe+Yae5seb+jH1cf2ci0S1XUVNSVa1GKwi0MoGwUJ6
         Q/Hl7UOKKorxwVkIlNXqIF51BGxqNP8+ZPgBtnSDRKqJM4f2CGDcirMhfI1ATnHxqPUH
         +vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759867124; x=1760471924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9i+DaBHwLGUsHUY6K5jBAv25/GP5doDNsw2CwcVczb4=;
        b=Qdcc6zEPmTnYiH6zvwfpk0f4hOseBEEbhfQEd6nQqu5+CghSCyv5QdB53tFGRSAiQ8
         MzuadAQDxc5FKmL9hruABoscIcTQVdbjS2ELMefdcaCpfAW4dgM3/c8L3sphEcCcOjMt
         x8kqzT0EpAK34ym7gqK3PxueC5zmTki+hmF1oM1EhOfm9jYPz2afb5WqH/C4T9skC+Ml
         R32XFDuN7ImUlvsM4X2wX38qaKXRj71bOpnCdbOxrQGhdKoZM0u2LRCofRwW0ZxHMWYu
         xPx3U1LrLbaoDqLegvPP7IA/+9Vn0r6KT/WDz/ZhFC+nSU76lK0K/9QBmW2c1ogJ2Vzf
         B5ZA==
X-Forwarded-Encrypted: i=1; AJvYcCX9+eur0IGaW6StwPyiwccl0AGhYdjFxucOWhLP43QdQyNuKUdt+UPIzMTmY4N4sbUroE5MywM5oqafouc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFePFIeOwIm0JTi2BFjuU4pQKNXMdDPpM5wANgwdOpTQQx/Mx7
	di4rp+nokHLLhvlFQvp7wFzmd4oCma648S7SILcRDWWQtdtxZ8uqFFcdLzMnijNVd66WvoCBYL3
	vPdqU0kzEGw0ureH9VVx4SnMUE4QRxm4UDoJk
X-Gm-Gg: ASbGncvx5cZJc+S6Oifu+SOiVPH+GpF0hEBwH7SQQ0P39dBBFmAN1M0CSsbQMngtX7m
	QDsT/EvlsDqTwScLB6bCATQYaxPP/IPXZfoEzntoQonab+F+X0tUSuZAgJu4fcEVV5IYui5eKu6
	M/ewNYAqRUYx5J9Wi2nsHUIYdlaHrx6LkCmtaOhjlmFrgnBp0LPIvl0680jceS+WVCmG9FISeLl
	ENg+6OU1GUqlevi3L4GM4x/H8ZlETKO
X-Google-Smtp-Source: AGHT+IGhQKkdli6ChcrJrimzDRILIPBEJx1WIJJeyZJZFyHu1VPQ3s0BSJb0Cf6sOL/i1+AZT6DQ2HmJtJquPatajTU=
X-Received: by 2002:a05:6808:1308:b0:43f:2b18:1612 with SMTP id
 5614622812f47-4417b3455dfmr434630b6e.1.1759867124222; Tue, 07 Oct 2025
 12:58:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007151828.1527105-1-tanmay.shah@amd.com> <20251007151828.1527105-2-tanmay.shah@amd.com>
In-Reply-To: <20251007151828.1527105-2-tanmay.shah@amd.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 7 Oct 2025 14:58:32 -0500
X-Gm-Features: AS18NWDxvii-SmcMeBcWQyfvAXfhvWegr7D7dXo5LN4u6HIGbavoNq9Ctlx_6e0
Message-ID: <CABb+yY0m_Whm1F7d2ub+vhn0eTb47UC9g=JvpLnWh-2E1oo52A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] mailbox: check mailbox queue is full or not
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, 
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 10:19=E2=80=AFAM Tanmay Shah <tanmay.shah@amd.com> w=
rote:
>
> Sometimes clients need to know if mailbox queue is full or not before
> posting new message via mailbox. If mailbox queue is full clients can
> choose not to post new message. This doesn't mean current queue length
> should be increased, but clients may want to wait till previous Tx is
> done. Introduce variable per channel to track available msg slots.
> Clients can check this variable and decide not to send new message if
> it is 0. This  can help avoid false positive warning from mailbox
> framework "Try increasing MBOX_TX_QUEUE_LEN".
>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>
> v2:
>   - Separate patch for remoteproc subsystem.
>   - Change design and introduce msg_slot_ro field for each channel
>     instead of API. Clients can use this variable directly.
>   - Remove mbox_queue_full API
>
>  drivers/mailbox/mailbox.c          | 3 +++
>  include/linux/mailbox_controller.h | 2 ++
>  2 files changed, 5 insertions(+)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 5cd8ae222073..c2e187aa5d22 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -35,6 +35,7 @@ static int add_to_rbuf(struct mbox_chan *chan, void *ms=
sg)
>         idx =3D chan->msg_free;
>         chan->msg_data[idx] =3D mssg;
>         chan->msg_count++;
> +       chan->msg_slot_ro =3D (MBOX_TX_QUEUE_LEN - chan->msg_count);
>
>         if (idx =3D=3D MBOX_TX_QUEUE_LEN - 1)
>                 chan->msg_free =3D 0;
> @@ -70,6 +71,7 @@ static void msg_submit(struct mbox_chan *chan)
>                 if (!err) {
>                         chan->active_req =3D data;
>                         chan->msg_count--;
> +                       chan->msg_slot_ro =3D (MBOX_TX_QUEUE_LEN - chan->=
msg_count);
>
No, I had suggested adding this info in client structure.
There is no point in carrying msg_count and msg_slot_ro in mbox_chan.
The client needs this info but can/should not access the chan internals.

thanks
jassi

