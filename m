Return-Path: <linux-kernel+bounces-898489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF42CC5564A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96383B4679
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 02:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1735329B776;
	Thu, 13 Nov 2025 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7nAoTd5"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89B5189BB6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762999724; cv=none; b=qjO1cXkeh/v1rquxtQEorn0tNP4ngwNaITWspCcbXkA8YUIBaMmu1ZeGR+LVTLTa/31m9Vne+NNcSVXFy876alyYdUFs+rVRninpQW/GHuOxe+DG8nIzO9O4caM//e4yaG3Z4xFBRHqU+Sy1NAeOpzcsMrwV1EaErZcVEB3pYgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762999724; c=relaxed/simple;
	bh=lpfYFXLVeUKxs+egWV3Ox5Z6NpCd53PQOChlDLG1wo4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=udTtvzLrvkk176PNxdBgm8KI1Tp2WnaHu8Rw1QeLJOtgZyi7ckAsZpIjbypaOwHIhYaBSV2agLuEiIPOpR/ANLaCLzJrB6zJZNlhYzIBG8iez3IlsDzjObpVE9e4hmz4XLV3tQd/z4tsyXrtpK3/RGmqSUXoIN3XNsFgP48ZlrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7nAoTd5; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b72dad1b713so34374266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:08:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762999721; x=1763604521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t65DqIpLR2XJc52MvkU8Zhi1oYYMgA74171ikGaz3IA=;
        b=J7nAoTd5Z4UH2fOXpVMoDajfLeEh2CgmWgPeCL9NV9tfSHXbNi5dKNtKBuTBMqiz4W
         B0oLDYOZjgPkSYik1diuKoBSrFxH1IQ31Hc3oFLoz1jYf5wdll/SupzxLx/h0i104twM
         3AhlYwDhwiqDp0vjAyCPE4oMdWUWwlCc9QOEB2PhqTuBnBB8lL9rfr/oJI1Mx2vhtsUw
         JnfEfjr7zKV0Yjc5rvLIqk1uVn7DVZJqxukap/SaW2GqQM4qB5jN6ivAHjnCkyuLFexn
         fGpCE9/po6+g9s9B8K7nVy6wKjkfrm4tb0AC62u/DpcB6Ncn5CafSe+MVnWdEgHc8/T2
         MGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762999721; x=1763604521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t65DqIpLR2XJc52MvkU8Zhi1oYYMgA74171ikGaz3IA=;
        b=QbYjNvCOilhpP8JaoEoAJSXiMtaONvPtgoDD786DnPMqk02xlwQ+YcL4BsGi3sxIp+
         Xe7yDeDY4dsgrnl8vcOwfu/cCh3iYkt16/Fm6HO5PlzhGnWwEoYkGP3my3aZPOlalPMb
         lJqxNnTJ1k8GVopOhBVrR9N01jkIHEOH2mLEGifX9S7slEDLfn3Ql4tpP2McFM9Ffx57
         MhF9Hm4G6XZSi/OHB4+UCIRCuSUWS9PmJ8XE713OPH+FEIiogSMzQ7N+GDBc+1Aa/SkK
         kc/sLqxs9ILQPt13NYfn6gtcjZ8OqUFjK+2RZZ3Y00l0HE95+Jlk35aanfoLf/WMbqzY
         6Nug==
X-Forwarded-Encrypted: i=1; AJvYcCWurNt5zLumtHMr5yhXaXjLeIW3fbIsq38vw7hCLy/+9iRmGgiH0WzoNNBDrrJrTX9HbD2lwoFYRMEhdls=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcP8RA40KK0XOQtfGVzyuL3rLn77Q3g13CwZKuUE6ir34iZZxB
	ua/3liEp8PcEAL05Gfz5BzuGF8f0fVZbfSJIDrd4qsTCBCKnNV99vaZyu1Bl4QASpUGZw3OxFhr
	Ed9fEadsJ2ioeP5BTBMgkqPUja/IxTCU=
X-Gm-Gg: ASbGncsOYk+Holb5Q89bw3UqdUSan0q8A5qdrTzM14yUPjYwYKlzlEQVe8tcs8P2v2Y
	a0Q5iYAvDpNF3FquNKPLUTCIRZz9XqhmwvzqyrK6arqaUkr50qwVq37rRFnSjeelLsBqZI1ZEpW
	A8IAH3ViiY0f42aJuV9sqKkZY7KjSO2oRj0N0f7W/iMgO5G4MuxytiMgUsiFabMuurm4v1KZZC1
	KIlNR+6xEBKf+jNz2vDdIPTgqYgayFQ7jpgL9YXzEBMk1/rMhaEolUb/p9XZZCiOaQJv9McMyuq
	yi8ubddgnilRulk=
X-Google-Smtp-Source: AGHT+IFyNWhr/4Git6cscpcGTem+aU8tvSmWDpBf45NHHKnDkHzsi0qx1de/+ZvskwSE8Sn5fra35DX3byqBpX8Be5Q=
X-Received: by 2002:a17:906:6a0a:b0:b72:b289:6de3 with SMTP id
 a640c23a62f3a-b7331af6e23mr526654966b.58.1762999720784; Wed, 12 Nov 2025
 18:08:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111234519.3467440-1-alistair.francis@wdc.com>
 <20251111234519.3467440-4-alistair.francis@wdc.com> <caadfcbb-8964-4447-a93d-8e49b4c14c7e@suse.de>
In-Reply-To: <caadfcbb-8964-4447-a93d-8e49b4c14c7e@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Nov 2025 12:08:14 +1000
X-Gm-Features: AWmQ_bkFf-G8MuLmGZPhefsEFyG89yAqq4VscB5fW2rNoawjSt9VITO75ff2oo8
Message-ID: <CAKmqyKNzi7OAq49b-aa1H8++ReTvWnHKBDwA88ionJshhOVp9g@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] nvme: Expose the tls_configured sysfs for secure
 concat connections
To: Hannes Reinecke <hare@suse.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, 
	kch@nvidia.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:08=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 11/12/25 00:45, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v2:
> >   - New patch
> >
> >   drivers/nvme/host/sysfs.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> > index 29430949ce2f..6d10e12136d0 100644
> > --- a/drivers/nvme/host/sysfs.c
> > +++ b/drivers/nvme/host/sysfs.c
> > @@ -838,7 +838,7 @@ static umode_t nvme_tls_attrs_are_visible(struct ko=
bject *kobj,
> >           !ctrl->opts->tls && !ctrl->opts->concat)
> >               return 0;
> >       if (a =3D=3D &dev_attr_tls_configured_key.attr &&
> > -         (!ctrl->opts->tls_key || ctrl->opts->concat))
> > +         !ctrl->opts->concat)
> >               return 0;
> >       if (a =3D=3D &dev_attr_tls_keyring.attr &&
> >           !ctrl->opts->keyring)
>
> ??
>
> How can you have a configured TLS Key for secure concatenation?

I'm not sure I follow

`ctrl->opts->tls_key` is directly set at the end of the
`nvme_auth_secure_concat()` function, so it will be set for secure
concatenation.

> We generate the keys from the DH-CHAP key material, don't we?

I haven't checked that closely, but the key seems to be generated from
the CHAP hash id

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

