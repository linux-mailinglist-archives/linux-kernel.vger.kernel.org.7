Return-Path: <linux-kernel+bounces-896727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6A6C5112B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 09:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5536C4F264C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668DC2F12C4;
	Wed, 12 Nov 2025 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EYm3OOIK"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577912C08C2
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762935211; cv=none; b=ebaURBPCByyy+SOSUs4gzykLA7mjCrkeBMyHAIJiKqNmcjuii5BKY5iFTuGnaK7SaIIPsPPmk/KyzSuYWkfV71cJCgzs2EHX0RQNH7rJg9OZXiRGL5BydwOCBSqTYMLzjkrAC0XhLK8SCEtoN/kKit0mfGGGT0ZaOD1hu1IV9kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762935211; c=relaxed/simple;
	bh=qLBafia/PKtEtA26Adnrbq1J4wPUztP9+12xCkx0pVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kEsTsmrpwhDj4c1ENGFxmp7rU0UTktbGkTYIKrtepkShDgOfS2CTlrJuV96CL0a4mTsZb5PxGssW+k96JowFITuSaJz70uJkheatJdVyEAf5geAxyxeVEZ3erbLUP2n9r8WGzWF4t0wjZZghjRvp8fGB6h4U8VYaIB5g5Ot3MbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EYm3OOIK; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b98a619f020so470961a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 00:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762935210; x=1763540010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qLBafia/PKtEtA26Adnrbq1J4wPUztP9+12xCkx0pVM=;
        b=EYm3OOIKouzUfIvsndgG5kC13qDFyZ+OaxHph4kCFhjd2oLSSgOmp83KfY+GkYNs+r
         ySMsDuprl6457LbQVHp4d+Y+0Wsypo2OtBaEWDO1TjIw/MPrWzBRE1idQeR1JdRWFhxh
         aGbeTmSk9cSjr+JeKcYutIbdfjaEdMv4PU8jaMIgK2JtOc8DQyN+bl5vBlibKbR8Xv0p
         9Cn2oxQGWug3yS8/oFb/TU7JOCjg3RDy4HggV9ZFDfyqWcFwk7a0XmFRjBHG5FWlgZfa
         X53HauSDDY7znqNA1EipFMHZ7uu03jiCyTO34MRc+3kOQLk76/ZwzwArsjbbO0DegfMO
         Jy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762935210; x=1763540010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qLBafia/PKtEtA26Adnrbq1J4wPUztP9+12xCkx0pVM=;
        b=iXAKtGiGufqm2xgFLPYp14vKGzaAfTTCZPG56C4JQ67+pS2jVrUADFwTcvAK/OP8aF
         +o0Wlxtdaj7fUSiP84SibFFhTOZWwkbFCcEj/gvQ4bdRw3IfQklVJcC15x+g4DYoS7NA
         bBnyYCmjrZ4afdQnzUmzC88ahOd+YFHpe0mqRGRJ6rA2d7UmKEaAEOhM2aCh17+zElu+
         V1zIkHS+qv2nnV2t5zm15eyI3UHqE9Y/frO43/Izn9yF4dRQiV00zdN3EroSJCJK2Flq
         eafdXATNv/Ipa8j/vfNhm5ULyNURouk5CLylAN1Lw4e0Hp8Y6PaB4SDpw6nf8uB7s/aU
         9CiA==
X-Forwarded-Encrypted: i=1; AJvYcCVo1ifDKUgLPkgueIpDtmzPOjfDiHV69NpI/nwWNMJS+SCfGN9FMGB3LZTI2f0fnV8A7Ax9NFLDHnRs2jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSgi2gFpRpk7LPcsKeDkRBxD8PLrillCb7iNGc/j9jufcyUNwK
	Und2yNJg7v4f4g2QEv5g7bC85ZvsHIofuZHnhGfLuMVaI4Hlo6358wyP6ngei2aBL5ZdB4uW/aL
	jeDwlDjmUzGiKoV0PniTynO2xjRN1qys=
X-Gm-Gg: ASbGncvU4pkBu31KSmAWOXdhf1E5Sipoi8nkfq8vv0mUFQxwVgQLNWACRnOnFVuTTbb
	h9+cTV+NNxP+4RJY0ZOAY9KuoaiejuseXNYt9k1AzKXRWeFCeEcx+d4rprHRvd43Uad0kp7je9G
	cqqYKpybQgaTfztE/qK6IVyTu5LO2IE0j+8AVQdGzhzuyJbmxCRZg592eaEbtA3Dvn6izI8m72E
	WMitBoQcDpAoDlMDr+JR7airf+A0WCv8OcL2eZ7QwQ44VqhSEw7Ww0CrQ==
X-Google-Smtp-Source: AGHT+IFnRin4gbmaFXUeI1BQiFdRCsNStgXxem0kbVw96MxrNLtIH0I6wkHre4CD95K+KCuFYtCNaztTRJvt/f8NODg=
X-Received: by 2002:a17:902:ef48:b0:295:6d30:e263 with SMTP id
 d9443c01a7336-2984ee02133mr29024415ad.40.1762935209636; Wed, 12 Nov 2025
 00:13:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109214515.121742-1-rpimentel.silva@gmail.com>
 <20251109214515.121742-2-rpimentel.silva@gmail.com> <9d48a54c-0585-4524-b9d5-30696f5ecc8b@kernel.org>
 <CAEnQRZCvpXzGt=7NGv7-s+y0gvOg7Jx4OqbfbW3uv8jDp-jroQ@mail.gmail.com>
 <CAOMZO5CU09fcBB8oUOO=qC=Du3Q9gnJOQacK=6v+pnSQViex3g@mail.gmail.com> <CAEnQRZCHKemw2YVT=WVJvUMr9CCWoZ3MORt_mU1V-62C53n-3w@mail.gmail.com>
In-Reply-To: <CAEnQRZCHKemw2YVT=WVJvUMr9CCWoZ3MORt_mU1V-62C53n-3w@mail.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 12 Nov 2025 10:15:53 +0200
X-Gm-Features: AWmQ_blLufo9e8_weYIhkdYf5Y61ajIvynO_fKPgAnclvKt8xEjxER44mrl124g
Message-ID: <CAEnQRZBBJ4PGDOk7hBP_qsk7bBiec8pHb0DYKs2mhOAahNyKww@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] arm64: dts: add support for NXP i.MX8MP FRDM board
To: Fabio Estevam <festevam@gmail.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Rogerio Pimentel <rpimentel.silva@gmail.com>, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, 
	alexander.stein@ew.tq-group.com, dario.binacchi@amarulasolutions.com, 
	marex@denx.de, Markus.Niebel@tq-group.com, y.moog@phytec.de, 
	joao.goncalves@toradex.com, frieder.schrempf@kontron.de, josua@solid-run.com, 
	francesco.dolcini@toradex.com, primoz.fiser@norik.com, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Xiaofeng Wei <xiaofeng.wei@nxp.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>, Joseph Guo <qijian.guo@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 2:49=E2=80=AFPM Daniel Baluta <daniel.baluta@gmail.=
com> wrote:
>
> On Tue, Nov 11, 2025 at 1:50=E2=80=AFPM Fabio Estevam <festevam@gmail.com=
> wrote:
> >
> > Hi Daniel,
> >
> > On Tue, Nov 11, 2025 at 5:45=E2=80=AFAM Daniel Baluta <daniel.baluta@gm=
ail.com> wrote:
> >
> > > In addition to that, Rogerio please read:
> > >
> > > https://docs.kernel.org/process/submitting-patches.html
> > >
> > > At this moment I think you should keep the original author of the
> > > patch.
> >
> > Right, but NXP makes a total mess with authorship.
>
> I cannot disagree with you on this, let me clarify it internally with
> NXP colleagues
> and sort everything out.

Hi Fabio & Rogerio,

Checked internally and to track the correct authorship and development work
here is how NXP would prefer to get credit.

#Use git commit --amend --author=3D"Xiaofeng Wei <xiaofeng.wei@nxp.com>"
Author: Xiaofeng Wei <xiaofeng.wei@nxp.com>

Signed-off-by: Xiaofeng Wei <xiaofeng.wei@nxp.com>

Co-developed-by: Joseph Guo <qijian.guo@nxp.com>
Signed-off-by: Joseph Guo <qijian.guo@nxp.com>

Co-developed-by: Steven Yang <steven.yang@nxp.com>
Signed-off-by: Steven Yang <steven.yang@nxp.com>

Co-developed-by: Lei Xu <lei.xu@nxp.com>
Signed-off-by: Lei Xu <lei.xu@nxp.com>

Then you can add your own C-d-b and S-o-b.

Thanks,
Daniel.

