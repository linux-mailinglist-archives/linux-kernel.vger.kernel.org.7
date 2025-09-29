Return-Path: <linux-kernel+bounces-836520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7B5BA9EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 18:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045243B10AD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBAA30C104;
	Mon, 29 Sep 2025 16:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEhEzgtl"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F061F5847
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161717; cv=none; b=CCW5VPAz8KdPYPGIbf5lR5Yjs//TWNwlZB7gSA1BZL//5qiikloCX8Ve18LAe/aQlM0LwYdx7F229Wfm6BwQ5t9Wik21VYfHOLSl37zVoeJvJQseT4UBt5ybYliAgfwxNCNecg14nsFBnguFGNu4dPK7wqDM6q8R6ijg3R2qRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161717; c=relaxed/simple;
	bh=oadeOqdjiKMeev8PewOUiOhaRXh7jvid763ETEvZDMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6drKqnZ+K4Qe9A5T09SM3JiYd/KgxLDlN78xceruEbaywpGIrWkwTblftrlKOrTrplkf/1B74ym7bjNu2JUMJs+R/mIbj+yHhdetwxWiYUEv5OpmuZaIh5dyPZfcgy6BQ2ShlH2gElosXwqmICr26AeslpUWasnCrn3XLLVgtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEhEzgtl; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3635bd94f3eso44900091fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 09:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759161714; x=1759766514; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74Rsk0zhOTuyxjtX5jVC1PFwqE1QJ68IfeopCcWou6k=;
        b=iEhEzgtl82/CO/YBmOPpu5+e10gSYv53lCxSED2qj5rhyxaxwEk3/Ch/UX9e/KId7z
         YHGNLWjYGvniDAhuu9Hew0JaeR5kt35BC82hFbCCreNgPvU05UsCdw2FZliV4UeaEaSm
         BFLHVqGm/Y/d0L17St1NkuI4A8y6AMdl+Cs21rVxBif3H8/M3dCcj2uqmAO8vtxEmyTJ
         ITle15J2Bk0bLNKpd20thYgQJ4bj8DIosf9ih23dpC8QSXvhpBJx0MtU28InsU+PIcn/
         1jTKoJ227+WC4RbAUp7UgNcCJqlNIE4y8O7rTWh7D3k0SqIbpx+vLbIPvsHOn//nuYBg
         eRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161714; x=1759766514;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74Rsk0zhOTuyxjtX5jVC1PFwqE1QJ68IfeopCcWou6k=;
        b=b/b1bwmci9/VNzLuxKLSheZ/UDx1AsByWXiEYWpnCXjXVVs5N+dXE0wW7ouUCR+Sc2
         IToERCLULkAUO+nsoiGGv+oV5+SYrk6ykCGmD3bC7x/1EJ5tU1GQF4YcluD2WEO4rBKW
         1JpAVOOtBgR0Vvnms6WTCwXWd4OFvBDxtPXkTCrL/49rIwHIQfMPEAvCoyng/sw75Z/p
         4Uvkx4H6IK6tDgZs3/WoDebTf6CmUf9DR0pHuSIQ8wc7lAHxtgmobV/rU2GXDb8Jbigq
         pvv3g/lZAEPIzvGF/Ji4rQSyjYZLHTNOymYcGMP+40srOSdUGhxnf9jovETAl/S4RYNO
         ebEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbIXVVoUB6kORtfyeGTKScOoTnWnAEHE9pkE1VzlqxZRKa3lVz5Em2Ei8xWH/tqmdbDfY/Dq4ICtG8R1Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyp3PMm70KTiYL8NgpokzyHFROtzkJaHVQLAyPISiFXVvHMmPP
	GyPhD8C/NB0rUgFAlVRQQVkPBXZLnyv2AggGHxMVv3nJX7F7kisbNL9stID6se7KoLRag+KcG9u
	yhQLhKiKq7KoHUkU76EnUzqoAHW3bblZ/MAbik1s/Yg==
X-Gm-Gg: ASbGncuwfkNkC8BSLSQ1vgpgL/daiDlTCdoJBBkAt+GVNbjj7t2QzaRCVDNMIfBv38M
	UIMV0e+AzFD5UH8aEuDg4cmDNvnzxWtWuE97Ow2LrshtN7nFgosg724GVbkSG2eGwSoIrR3bk8L
	+KWAloUitCPDU/nvAcySx6YUfn60Hc+vwDwB14ouTW7y0mNqe/MNPq61D4ETH4mxBkSc8tmL0ej
	7dxt0YrSRp4XHTI
X-Google-Smtp-Source: AGHT+IEwWC1V3nTvpmB+f+dIHO2ycq0Vs80iBUr3gJGVBaqbUlUNUlbBslyfGp0tDefml7Q2l/E51kEGs3f8lqmqYc8=
X-Received: by 2002:a05:651c:3608:b0:333:7e5b:15c0 with SMTP id
 38308e7fff4ca-36f7dab3512mr48089181fa.13.1759161714014; Mon, 29 Sep 2025
 09:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827043254.26611-1-jgnieto@cs.stanford.edu>
 <a261ed13-4c0b-43cf-b177-d33272626d25@molgen.mpg.de> <aLUC3u3ZrF35nIb6@macbookair.lan>
In-Reply-To: <aLUC3u3ZrF35nIb6@macbookair.lan>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 29 Sep 2025 12:01:41 -0400
X-Gm-Features: AS18NWDROgcD9G9WWK-cUVeJOEWEqbKRC5wZ4GLZhXOeG8o6ocnum9b96niQbW0
Message-ID: <CABBYNZLqcdNTh_aMe3JVKBLauNkXq=6n+xTt7q798cDkZGaO9Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_h5: implement CRC data integrity
To: Javier Nieto <jgnieto@cs.stanford.edu>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, marcel@holtmann.org, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Sun, Aug 31, 2025 at 10:20=E2=80=AFPM Javier Nieto <jgnieto@cs.stanford.=
edu> wrote:
>
> Dear Paul,
>
> Thanks for the review!
>
> On Wed, Aug 27, 2025 at 12:56:50PM +0200, Paul Menzel wrote:
>
> > Any btmon trace?
>
> The presence of CRC is limited to the H5 layer, so it is not visible on
> btmon. However, I did advertise and connect to a few devices while
> running btmon and everything worked and looked as normal. I also ensured
> that CRC was being used by adding temporary debugging prints.
>
> > I=C2=B4d add the above to the proper commit message.
>
> Should I resubmit the patch as v2?
>
> > >   static u8 h5_cfg_field(struct h5 *h5)
> > >   {
> > > -   /* Sliding window size (first 3 bits) */
> > > -   return h5->tx_win & 0x07;
> > > +   /* Sliding window size (first 3 bits) and CRC request (fifth bit)=
. */
> > > +   return (h5->tx_win & 0x07) | 0x10;
> >
> > Could a macro be defined for the CRC request bit?
>
> I thought about this, but decided against it since 0x10 is only used
> here and in one other place. Also, the existing code does not define a
> macro for the window size bits 0x07. I am not opposed to adding it if
> someone feels strongly about it though.
>
> > The diff looks good. Feel free to carry:
> >
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> >
> >
> > Kind regards,
> >
> > Paul
>
> I see that my patch fails a few test cases because it fails to link
> crc-ccitt. Do you know whether this is a problem with my patch or the
> test environment and where the code for the tests is found?

Yeah, this seems really a problem you are introducing:

ld: vmlinux.o: in function `h5_rx_crc':
hci_h5.c:(.text+0xd938d9): undefined reference to `crc_ccitt'
ld: vmlinux.o: in function `h5_prepare_pkt':
hci_h5.c:(.text+0xd94798): undefined reference to `crc_ccitt'
ld: hci_h5.c:(.text+0xd947a6): undefined reference to `crc_ccitt'

I guess we are missing something like select CRC_CCITT on Kconfig.

> Thanks again for your feedback.
>
> Javier



--=20
Luiz Augusto von Dentz

