Return-Path: <linux-kernel+bounces-851305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A4FBD6130
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:27:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 600A44EA155
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 20:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3E42FB998;
	Mon, 13 Oct 2025 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CJxT5+6T"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865192D46C6
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 20:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760387224; cv=none; b=ZCETYtzyl+C6OgyZE+IQJh45sgew1iivtKOZXr23jI0LGxdtqwL4EDiK7aUKsjLqnhi2QTtu9o04TTnjIdgx8suAQDZsKdCdqMUDnDEkJlKxPTBIY1GgN0gSbzSUERP8YMUzJ3jSrUxC2v4iL/gVjOYiE0NcdqPSH1lSZ2Cp+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760387224; c=relaxed/simple;
	bh=babBGhfXx1fPtsNfCx5hCEWBO9wdsLm3D8nBpU1zWoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYWqIUSWGcPog6QH/uY7RVgsF05xTH2Km18tteoEp1tkR4Edbtt/iP80SrWyMm5lDW+hyhtTUGA1m4CokIurRjdBXwovqqD9/goYAlgTacq7ZkZBrdM0v3gciD1Wh5oXYwsSS2mxG28eKTN4j08NBl31dPHW6RXpW6wKP0PVezU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CJxT5+6T; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-33b5a3e8ae2so3093941a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 13:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760387222; x=1760992022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=babBGhfXx1fPtsNfCx5hCEWBO9wdsLm3D8nBpU1zWoI=;
        b=CJxT5+6TaokJ/y+guIdlPVglEm0w81fTgvi+U+3UlXpHbaqVrDSzxSS5qVwiDwZxP7
         q51mvi4EjNdd20Z8DPjGyXGJRvnSaOBGBqHsxEWhHdj7S9uWCisd8uBOpUwNSkgxvf8y
         R5zpK4BqsQEALII7LuG/0LulSPurPl373rnMm+8opO9aqPuvP5NmSZ6mHEGOcNKg5Q1Q
         sZf+wNvMYOOR2sZETAXnjsYnqdz/wAElTc9CQ+TZSlS61iLAAcGFwsCo6k+rlL85Pf86
         tlTVpLP1+rF3XYhvalHxPc75sshf1qCvcLngaiGeIglI5sXtY4QDJaiMUdrE2vXGL4XD
         I5Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760387222; x=1760992022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=babBGhfXx1fPtsNfCx5hCEWBO9wdsLm3D8nBpU1zWoI=;
        b=VTCPtZ0XyKSvDa3ztcyqS3Muom1C4MSEq4qCQAlL4ISaBMWVuzAP5m9vBFyVGizHkl
         GvwEL6D+nKRDX2o6MTXz0aiwlrdyxHUJ3+Hsb3p+E5p2cw95z9q9eTY+e8BeXrForOMq
         t9M3c50I24qbIGalPe7XmuiuzxiOU4w1UP7EIznaiwVYoKVViyVLvhj6CgqXKJJB3JR5
         E/Za9ynSEhzYhVxYmnuO4Yd9tojDrzGerHRGq0Pa8rq3dhkDxHdPPPb2bNJ/G6YsQ/sm
         yr6kImpR7JoTB7DrQXXj2Qc+HCkgPIIf/2SUGDo9GsY59nEAKPVV1tLBhqWskmts5vfT
         nxkw==
X-Forwarded-Encrypted: i=1; AJvYcCXLJpLlTAr5CEdM+3a5V4SRaV2CxA63gZzmFEY0Ak3H+LsTcTIlN74Num0WFYkJJczr+niQmYe0Q51I/vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8XmOmPAtd2zhCyV5ms2EszZvJW6SYsEsUbNdMiaIldaxCV59H
	BhAniCMxvXUkAA1KYSAdp8uNdIcQGfgzIYLet47mrKl6J8U4nkNXyu6n3HNKUTlJZZeztIAW87R
	KujjeWKj8QMqJ+4IrRaVPQYzrtbTzyQ37LDxj28zU
X-Gm-Gg: ASbGncujA9fUcF92rlPiuflb1QX76Xb3XUomLR7Jpe/gUcxe8LjtsUoiU/Ed6ohaxfx
	hV3/JjDa79ZltrUiEtNNJSY0Tm1KLWh87KJL2dCzrieUfjLbamcr3r/3ew8jUTcD5DP4hQ60LoY
	NGbeGcPowRv39Q/iXBPVPB+iBJarEhAqttccxgr7OMxrYMCOkprobIMLq9/OIIqL0HUyRRLfBnZ
	0Gz1KEDQ5Ij5eNn9fGcpWj80g==
X-Google-Smtp-Source: AGHT+IGss2VDJO8x5HyqI5H573+UkHtTHLXgrJeCVBKZm5LGM/ts88b5TDQDn4YSXHwBmxi80eK/R3J0uWJkmg5SckU=
X-Received: by 2002:a17:90b:4d:b0:32e:11cc:d17a with SMTP id
 98e67ed59e1d1-339eda47424mr36047088a91.4.1760387221613; Mon, 13 Oct 2025
 13:27:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926193035.2158860-1-rrobaina@redhat.com> <aNfAKjRGXNUoSxQV@strlen.de>
 <CAABTaaDc_1N90BQP5mEHCoBEX5KkS=cyHV0FnY9H3deEbc7_Xw@mail.gmail.com>
 <CAHC9VhR+U3c_tH11wgQceov5aP_PwjPEX6bjCaowZ5Kcwv71rA@mail.gmail.com>
 <CAHC9VhR-EXz-w6QeX7NfyyO7B3KUXTnz-Jjhd=xbD9UpXnqr+w@mail.gmail.com> <CAABTaaBO2KBujB=bqvyumO2xW=JCxKP0hc87myqcLF3pbxSorA@mail.gmail.com>
In-Reply-To: <CAABTaaBO2KBujB=bqvyumO2xW=JCxKP0hc87myqcLF3pbxSorA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 13 Oct 2025 16:26:49 -0400
X-Gm-Features: AS18NWCUy4T8laMXtjmGm2u5DGufptm_DTkxgnp7osvagZXN3dVSC1WH5MNw9Qc
Message-ID: <CAHC9VhRL2mGrpzz9Eo3Hm+HQkUP36cDv_xx5BtjJjUqh2eZmug@mail.gmail.com>
Subject: Re: [PATCH v3] audit: include source and destination ports to NETFILTER_PKT
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org, eparis@redhat.com, 
	pablo@netfilter.org, kadlec@netfilter.org, ej@inai.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:11=E2=80=AFPM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Mon, Oct 13, 2025 at 3:51=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Mon, Oct 13, 2025 at 2:48=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > > On Fri, Oct 3, 2025 at 11:43=E2=80=AFAM Ricardo Robaina <rrobaina@red=
hat.com> wrote:
> > > > On Sat, Sep 27, 2025 at 7:45=E2=80=AFAM Florian Westphal <fw@strlen=
.de> wrote:
> > > > > Ricardo Robaina <rrobaina@redhat.com> wrote:
> > >
> > > ...
> > >
> > > > > Maybe Paul would be open to adding something like audit_log_packe=
t() to
> > > > > kernel/audit.c and then have xt_AUDIT.c and nft_log.c just call t=
he
> > > > > common helper.
> > > >
> > > > It sounds like a good idea to me. What do you think, Paul?
> > >
> > > Seems like a good idea to me too.
> >
> > A quick follow-up to this ... when you are doing the work Ricardo,
> > please do this as a two patch patchset; the first patch should
> > introduce a new common function called by both audit_tg() and
> > nft_log_eval_audit(), and the second patch should add new port
> > information to the audit record.
>
> Thanks for the tip, Paul! I'll work on it next week.

Great, thanks :)

--=20
paul-moore.com

