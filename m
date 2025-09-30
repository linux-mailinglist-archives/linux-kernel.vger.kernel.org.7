Return-Path: <linux-kernel+bounces-837770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 110AEBAD25C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 16:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E93019222AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 14:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1263009D5;
	Tue, 30 Sep 2025 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6sZMkJG"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D0172617
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 14:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759241501; cv=none; b=SU+kcHrfpe1Np2eygKNjPjUNDgKgrdHcm5zW18K4mKhu5V3viRIuJpLk8KCOhCBpky3ZZzifvBfHANTc3CL9uyACw0Z5zl3BMOI1FNyke6oGSPTHsZgved4R4u1PnHiZ95kVRg5ftQ4yz2LI4PugI49AO3DkGsZpUZ5tdL3Dr6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759241501; c=relaxed/simple;
	bh=dhNbw1G9mRAhXIMH6LfDAwAjDDHBYJXFE5PoFaulK7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wh+iMyeJ9rcLX2LpQlFreKttb5DJsmVvZpSMjLnEDMR3lvHV3cd8V5gN0MVaoHApM6T8w7Q666Y6cayLrONR3ZAKoW3tPbkmm/VK/W/l6wfAk11zwQcpb/xLp8WjzWfT/oiiwx7OoNdI2FueswxiFz4Rt3ElJhaofC3JBqiDSiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6sZMkJG; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-74c7d98935eso3066212a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759241498; x=1759846298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lge6WsJENV2SAB1G3klNifvxV/9+1PlDakEtvWakN8U=;
        b=Y6sZMkJG0hfQeh959F2i9uddsFiMyNcgEy8PgFRxeZCImg+q3AJn6xNf6g++O+tAiy
         yGpHs5DKfAtirkn7Pq6rX7/WRNyHmZAuRItxQrDL4KFM/mSZx0xJHO9zqyLKFG8nIBoV
         IWSuhScrY6bUBOFniKlSNP3PR1ir2ZYBOuJIrp2cvUXYl18+VJxDdje/N/MaR73ULvFE
         Zcc5UluZFdG6PKipXwuRuZGMLGIKl4OLuLKmYdUMbiHTMp+yj4DAz/hwM7+dQnN8BnpA
         kWgnLnU7h/Pdrh5PPPbRBsNMFL6EJ2O+/Gd1EVbekxlUdsc+XBGycjCMVubbsarX4I5n
         M0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759241498; x=1759846298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lge6WsJENV2SAB1G3klNifvxV/9+1PlDakEtvWakN8U=;
        b=XH5TdGjZbQ26qCaoLZ1UuwRRluuzo7SzWxysXninCaGFUHohgjYDxza/JBGbBOkHNG
         UKksb/zEBQG6ng/xiXBORdaRTQoyuUQZV6DNNbyBRkTU+VQjQ3T/Tfuxs3TO5nnogiVZ
         PtnvWUeIxmLW4TDdss/ksm5FAvkww14P/GBPwkZQMhsDbqsIT1wzBSinIxr+j1FuFo30
         VDSmJCTRvLfk6uInY2V64gnJChOwVeu4P7pr4/YCD8e31FfJkDAggof2fVBmNd0DNcEN
         M2tXY8FauHkqRr13Tj6ddzcRV8nBI0b8RvE9ShBaCRcWtazZD+vvybHiPukrG1fYADtr
         q0yg==
X-Forwarded-Encrypted: i=1; AJvYcCU0RbCm+FtdX3XQ4v/1rL34FABV7rL5TVkODhJSGRzyArsEHamzap4oFlHLzMfSt9+gFqoeY2JUZOZixj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/wJRmzzV7T8cF7lyxdGgGsEuVLLlzIAPZi4UejOS1yq2XuXhu
	BIHqblPE5jdMtqbZyoaPzi3r3r04dtVIGdlufWTGz7iNM0n75y7TlN7MjxLcVLSGxbB7BaVSxPl
	QBerlNTE90/dUB1Zczgp0ALEd51vtQDs=
X-Gm-Gg: ASbGncsjw1lCCjN/iFwg+BPZkDWVxUN1xZRJFh3vMEW1ueapxzocIg5bpg24pSEh7r/
	f44bhRpZRf+Mi7PS7oM7/qgLbx091b5lqW3LH80RrZ7qIiEHycU1msLoVzbW/EFR5jULcXHRDYh
	bt+KgSSR5LthkHW3sJOjkgAmLN+UB6SenkrcxiU4y+GKgRghWQBoly/Po3ekkxcLHM13FnnUN0m
	ILlUz8bJP6By1AS3oDPlHPK6J5mtQboS8PrT7xdQ8g=
X-Google-Smtp-Source: AGHT+IF5F14UVS2FUhVkyyg79GjNg4gxVLmQKIXHM/iI8Ip3DpRL4npXCJODa44vQo+toLYyiB+ieDwef4Qk9Lr9qQs=
X-Received: by 2002:a05:6808:6f8d:b0:43f:63cc:aed9 with SMTP id
 5614622812f47-43f63ccb29emr6926980b6e.31.1759241498389; Tue, 30 Sep 2025
 07:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925185043.3013388-1-tanmay.shah@amd.com>
In-Reply-To: <20250925185043.3013388-1-tanmay.shah@amd.com>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 30 Sep 2025 09:11:26 -0500
X-Gm-Features: AS18NWDWAkPUsh6oysM6acgT4GeTUBESdySKZCWeJWSjZWGR1nFeq4C9PeRKmz8
Message-ID: <CABb+yY0MzJWOGtS=ocphpUVcJ-gb6_ENCjSmJQiWfRiOhxrpCg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: check mailbox queue is full or not
To: Tanmay Shah <tanmay.shah@amd.com>
Cc: andersson@kernel.org, mathieu.poirier@linaro.org, 
	linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 1:51=E2=80=AFPM Tanmay Shah <tanmay.shah@amd.com> w=
rote:
>
> Sometimes clients need to know if mailbox queue is full or not before
> posting new message via mailbox. If mailbox queue is full clients can
> choose not to post new message. This doesn't mean current queue length
> should be increased, but clients may want to wait till previous Tx is
> done. This API can help avoid false positive warning from mailbox
> framework "Try increasing MBOX_TX_QUEUE_LEN".
>
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>  drivers/mailbox/mailbox.c               | 24 ++++++++++++++++++++++++
>  drivers/remoteproc/xlnx_r5_remoteproc.c |  4 ++++
>  include/linux/mailbox_client.h          |  1 +
>  3 files changed, 29 insertions(+)
>
> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
> index 5cd8ae222073..7afdb2c9006d 100644
> --- a/drivers/mailbox/mailbox.c
> +++ b/drivers/mailbox/mailbox.c
> @@ -217,6 +217,30 @@ bool mbox_client_peek_data(struct mbox_chan *chan)
>  }
>  EXPORT_SYMBOL_GPL(mbox_client_peek_data);
>
> +/**
> + * mbox_queue_full - check if mailbox queue is full or not
> + * @chan: Mailbox channel assigned to this client.
> + *
> + * Clients can choose not to send new msg if mbox queue is full.
> + *
> + * Return: true if queue is full else false. < 0 for error
> + */
> +int mbox_queue_full(struct mbox_chan *chan)
> +{
> +       unsigned long flags;
> +       int res;
> +
> +       if (!chan)
> +               return -EINVAL;
> +
> +       spin_lock_irqsave(&chan->lock, flags);
> +       res =3D (chan->msg_count =3D=3D (MBOX_TX_QUEUE_LEN - 1));
>
1) If we really need this, it should be
        res =3D (chan->msg_count =3D=3D MBOX_TX_QUEUE_LEN);

2) I am thinking instead, introduce a
       struct mbox_client.msg_slots_ro;
  Which is a read-only field for the client, denoting how many message
slots are currently available.
  The mailbox api will always adjust it when msg_count changes...
      chan->cl->msg_slots_ro =3D MBOX_TX_QUEUE_LEN - chan->msg_count;

-jassi

