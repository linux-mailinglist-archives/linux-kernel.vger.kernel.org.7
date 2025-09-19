Return-Path: <linux-kernel+bounces-824211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 248A4B8864A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 10:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035571C8400B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 08:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9262ECE95;
	Fri, 19 Sep 2025 08:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReD1NdMi"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767192D0622
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758270201; cv=none; b=EDq08uYPRgmUOSz3d2nSKD+aju1YQAft1uhKzLBMTqdWGeBoP92S7o1gLYZB5Mn5b19Zb4nKt1hDQ9LnaMG5o1FbRYdRfwgJlF1IcW4VdgMbvQQrGuCMGZS4pWbM/vJTv6qGphjNF3pdEOlw0VhrFfwnHE+IfmPEoCs1AfyXPIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758270201; c=relaxed/simple;
	bh=usjY+o/8CLlwfSa4Vymf4+fsSkyqM1VeZm3AMQMgllE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKFWVe2ChX2GLhiTjtPvSctpGFBedd4BNS09xEZ0MnXj+zVQg77QVfWu8IpIqKgX0PwVnuWz4lf6VKZTAVY1XDBKNalu0IMZRADMpBXp9+andSi4ps3oTtP2KKnRSickw03L2iMVqCKXSplyQbZtUGnLhALsG/qj4tYQOiYgiuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ReD1NdMi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-26058a9e3b5so13727485ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 01:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758270200; x=1758875000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVujP+zprKI6yaucjxQ+AnFkVr/LyLnb8WhpE7+IVts=;
        b=ReD1NdMihbvvhRTb9ehLxOmIBaTXzBb9LYzNbXi5Wv225oDnyHGfyZJYf4I1oZ8K3E
         f/YdE5aBFSG5VM9GVw47ZTZc+p+tJY6unwWgDuI4XAGsBxTI1dqS1rNBaYD1RWaPNFKQ
         W+GaU2h5m9idoA+T1y+1pCmfwpoHhvFJRo3U2rXdvnmZS5f91BiIBPIZJnKIfrTQqMEm
         hB6hn17BikAcyflOtdgO0DxAKLeGwazWm9Yf5tEXm98YvVZ8Rh7X5gYQu8M+NYy/aoor
         mRnvUuAlyh4ncHYC2w7SSvKh9UBEs3BSRafOOu/6rmZSYi4dPVs+uT12pbyholhKqbIO
         Jjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758270200; x=1758875000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVujP+zprKI6yaucjxQ+AnFkVr/LyLnb8WhpE7+IVts=;
        b=nSaJMPMHvJ5EQgROeVVwoV22kSytw01oA5Vox5vno5uhh5IVq0oZyTYgAvED+guvPe
         +jfrSn7FjywTwIm7OkPlDD1hrirAVkF6PZBRYmLTmyeAdKMcdaHkhllHVgTTso6rj1Ai
         cgk43D+CPkBcdXE7svnqI60cs0S7JWtjqG89CIXYNCNnFtwzXtkjkmDb91Y8PWflv0m2
         ClHZVN52wNxru0diyysDt0lwFiseOGHvIGkJ32KaKlbqR8sUjdqCxwpBJowxWRzwdXie
         4+5Di/Dg3NivWT2ZJfEN+5UL4G90iNams//qhwJ/LlqVwzxa/868F/J7l15UKzjIdaKg
         WFlw==
X-Forwarded-Encrypted: i=1; AJvYcCWRE7BLXv8DoQxRnYxBYyqvyES9hsLfWIxrOMlvc43P/GDmEKt5+c/6Uui5g6Its9tWR+vDvA1Imphe/7o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywkw5PY4tloQICYT8a3zvq6r67d6OrF/Vj/eHKccVQQzoEjF7PM
	j96C+STMPLqZ1g5XwGNYgffHtYUjPivOHSgQOWl9+qJdQSrjnfBoigIrJ5rcIMFXzV02RkHeUjf
	c3bvAJ7DfHuaXcw8vCYacdb+oZXmafuc=
X-Gm-Gg: ASbGncsayY6ewEEOuXtZPGFeEawAHKwgAUEcjivuclRhdLJWLWPCkdplk0OKmI3g4w5
	ewPNNADUW8xc1izNblGxHkCAJspi38ZHCunmcBeFWVnrCwsZOsTQmxry1Ygz5YZYsV+mjpgEzBf
	DmVCuDpCJ8w+MKixlkrfdQrRFyT0Rs5E9ihyJ6YhAs1rVPVkpmkuUzmScI6B4M4c+0Sf5h34D+b
	vxL5C6wBm00IYmkIO8xRMRR1pZ1XpVKmXfj
X-Google-Smtp-Source: AGHT+IGkUgFKopsVCvKH/I4NVsJnRweFemKrfKJemNsyC+3rmEF/RNRSqYb65QnzlOCE75UW6MFYdTLXvs3rT8z5p6M=
X-Received: by 2002:a17:903:24e:b0:267:e3af:ae38 with SMTP id
 d9443c01a7336-269ba4643bcmr39630535ad.24.1758270199791; Fri, 19 Sep 2025
 01:23:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918-imx_rproc_c2-v1-0-deec8183185f@nxp.com>
 <20250918-imx_rproc_c2-v1-1-deec8183185f@nxp.com> <CAEnQRZB2ZkcRirj1SZkfbsPHyyGr5PfnCDfv+ZuMu_Mj6XKBEQ@mail.gmail.com>
 <PAXPR04MB8459216DAA827DB05BF675AA8811A@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To: <PAXPR04MB8459216DAA827DB05BF675AA8811A@PAXPR04MB8459.eurprd04.prod.outlook.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Fri, 19 Sep 2025 11:25:38 +0300
X-Gm-Features: AS18NWA2ML_75oP-q69uMA6bYWYFWGOMeEfKy11gSalmyDGfNKtTFsYUY529N_o
Message-ID: <CAEnQRZC34KuJZDcv3TLJQrOcT9NFsYtD9q5Rj6+5MUKSBub6-w@mail.gmail.com>
Subject: Re: [PATCH 1/5] remoteproc: imx_rproc: Simplify clock enable logic
 using dcfg flags
To: Peng Fan <peng.fan@nxp.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Frank Li <frank.li@nxp.com>, 
	Daniel Baluta <daniel.baluta@nxp.com>, 
	"linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, 
	"imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 5:02=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> Hi Daniel,
>
> > Subject: Re: [PATCH 1/5] remoteproc: imx_rproc: Simplify clock enable
> > logic using dcfg flags
> > > +       /* Remote core is under control of Linux or clock is not
> > > + managed by firmware */
> >
> > I see that you negate the comment from imx_rproc_clk_enable but
> > with the negation OR becomes AND.
> >
> > So, the comment should be:
> >
> > /* Handle clocks when remote core is under control of Linux AND the
> > clocks are not managed by remote side  FW */
>
> I thought this flag is clear that clk should be managed by driver.
> I will update the comment.
>
> >
> > Also, do we really need this flag?
> > Shouldn't we just make a decision based on the fact that clk is in the
> > device tree or not?
>
> From hardware perspective, there is always clk for the remote cores.
> So DT describe hardware, a clk property should be there.
>
> But NXP system firmware manages the CLK automatically, no need
> driver to do that.  So this flag is required here.


OK, makes sense. Thanks. With comment changed you can add my

Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>


thanks,
Daniel.

