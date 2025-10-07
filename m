Return-Path: <linux-kernel+bounces-844272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C67EABC16DF
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 15:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A47201886F97
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 13:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C82C2DFA54;
	Tue,  7 Oct 2025 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c5XRvevG"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF95128819
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759842230; cv=none; b=fGTS7h29jB0Hy28GN9D0aY0mcY0PFgZkP92/KZUj26cLkKm4tynY4Z0ePL2QPloGD56IAlUbcYdpeBSjzobqYc9dpjPavE1oH766DAxd5vK9bjc9YjXK7GJy6m7blkz40eOT6OR1MlcCOZ4TWGlYiSYfjPdfAX62YWBs8GJqH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759842230; c=relaxed/simple;
	bh=mT8VWekIFVcoXu/yqvLJuwobiSiZiiPaFFIOk5E5vVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdcTRQrXlDV0lJa+MWtR+nuDJX7T6iSDKyQvwRfJfVQyNykyGXT6mLzOUSWx3Dy+g2A412u5qth6FRpTbE8ScRys8KAdYjy6ILu+ESG+WhM6isBd+0tnfzs+cQmTmljSJUphbgYOhELAQut+/WZAU0EewC6NKmNS15gyz4LvqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c5XRvevG; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-646f75551e7so2461889eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759842228; x=1760447028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ISbSv/si7GhQxuZJ0+Mx59HypLlRtEwXTQlx2jMvq2o=;
        b=c5XRvevGt9uqwuRvPaqnBy2HvtboMJ1fF1KdreKNrlfTO6Km/oQ9nnOPZ4RKRwoCx3
         jAl94VAJidUNLXQshh7m6LI2N9ztpZ/0jJLU9lIsXwjzHnByW3UnrqMklfxXY7/zBu4h
         NdFtjapsc0xP9CfSXTBTceiDPq0x2/XOHEsW76aecs0A5vWtwvZVDEnZzmI6YqRO9e17
         aHolys5j3cdiG7FO5RdgY4cXLk8orCboOg2tU/C3OqZoDkR7arLY54PtnyHXjyE7SgnQ
         fcAA0olJ96PwYrGQ+7p6POj2aGH0zycjuLsAJqP2Yrdt8CpvmFFUnEzHhE3VQSfHM7o3
         JAOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759842228; x=1760447028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ISbSv/si7GhQxuZJ0+Mx59HypLlRtEwXTQlx2jMvq2o=;
        b=GxfP6rMn4gApvqybo9559ZHL7VrwVQh7wEsrq/mnzA/ordtUt1iSkEKtT0OUn5GzVQ
         dSd+nft2EBtqDWE5k9Bcg2+4RURUps0xXwxRpgHO7U6TcvTM5o/MjDfnk0F2Z/JUapAv
         +wZKQs4msFOQzmf6nr12G1Y9zhBStNFlA2Yxm5++m35R7VEo3lEs8PVqkVcLOgDPewG8
         YqfZjQl7ouT/RthVZGhtiCTMh9zCboSq/PNqKcVAqK0DNoQwk8fnIIOF3vllp1lBUhnk
         rrDdO00Bu9RE/VygYa8oEDKG2RSjK7ZbIgdhTPhj8YT/locMiQCwrfaDDzbXEtwoAewJ
         UtAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVO24DMqelGlZ7kbN4zo/2s8XysvFMO37Yy9ClYP1wxiDFEox7sz9x04oItuPEGlaAYMIXsThVALbVPa4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKIwRkuE9uaDugZXF049P7x+NCP4LArYDMTEzPgvgZeKLcY03q
	qoXLD2y5QgAkVO7eJVviR2Yzo0Cg5ydUhqtSXkb0t36ChitWVZnA6HMRAjDe4h5hQgaeBNWAzQb
	5hyzLFgp2J0RvEjemQgpAc6A5Ahfydtw=
X-Gm-Gg: ASbGncsW6Hhv2TH+tN8BBDOPsc3MWT4SQkdPBkYWmFjju156acgxdLfna8Oq3ZEUySp
	GQndbCefoztoOZ4y5yGPqbrPcKjBO1m/hX1yPKZTS23HygPJOewnRzSda+/gAy7YKy+9KiQsjWG
	R/NhPTJ4db3G+DIc5etVn4zNQmx95qmutoSGiyjGyl6K6IaaVf/Ji6Wl6zWj/dvOEca17PaLpdA
	F1xGk5RuUprvUwP+3JplQFbrszFJV8=
X-Google-Smtp-Source: AGHT+IHMjaDzMJ+goOCNybWe+pEdxaMgHR3ggTEddsjk0aVtjGIjb5OoyVz2H4ioVsnpFH5rC2pWnOkHn8nS7zeZHDw=
X-Received: by 2002:a05:6820:612:b0:641:4a5d:d84d with SMTP id
 006d021491bc7-64e6014cc46mr7322676eaf.0.1759842228043; Tue, 07 Oct 2025
 06:03:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003091304.3686-1-briansune@gmail.com> <20251007113305.1337-1-briansune@gmail.com>
 <5a71fdac-f6cf-4557-9bc8-d416a033263e@sirena.org.uk> <CAN7C2SCHirxurUA0n2VZKEEiYCt-NUKgspGFfZLNurHhACZkBQ@mail.gmail.com>
 <3266559a-8403-4a26-bbd9-c54e27fc59f8@sirena.org.uk> <CAN7C2SC96jZYYGP=DFrSKgtEfxy+MYpM7=-iW8YKhDG81ufw+Q@mail.gmail.com>
 <6963ab04-d0d2-42ee-9fc3-19f9c298849b@sirena.org.uk>
In-Reply-To: <6963ab04-d0d2-42ee-9fc3-19f9c298849b@sirena.org.uk>
From: Sune Brian <briansune@gmail.com>
Date: Tue, 7 Oct 2025 21:03:37 +0800
X-Gm-Features: AS18NWCJV2ZpDfSRZMrocjBbOFe7dIZ3vWKMlbjnLq4Xm4UFSDLeHAKB2STTj5k
Message-ID: <CAN7C2SBAPMG1-0huf+3NcUAULZmHTM4idcytShNDs-iiseZm5g@mail.gmail.com>
Subject: Re: [PATCH v2] ASoC: wm8978: add missing BCLK divider setup
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, 
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Understood, so in this situation.
What is the proper way to fix it?
Leave it as such or create a new thread?

Thank you

Mark Brown <broonie@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=888:10=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Tue, Oct 07, 2025 at 07:56:31PM +0800, Sune Brian wrote:
> > Mark Brown <broonie@kernel.org> =E6=96=BC 2025=E5=B9=B410=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=887:52=E5=AF=AB=E9=81=93=EF=BC=9A
>
> > > > > Please don't send new patches in reply to old patches or serieses=
, this
> > > > > makes it harder for both people and tools to understand what is g=
oing
> > > > > on - it can bury things in mailboxes and make it difficult to kee=
p track
> > > > > of what current patches are, both for the new patches and the old=
 ones.
>
> > > The title is fine, the above is about sending the patch as a reply.
>
> > Got it, when title amended version is sent, need no reply with
> > previous revision ID.
>
> No.  You sent the new version as a reply to the prior verison which
> nearly got it binned.  You should send new versions as new threads, not
> as replies to other serieses.

