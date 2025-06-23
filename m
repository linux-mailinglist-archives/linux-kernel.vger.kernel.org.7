Return-Path: <linux-kernel+bounces-698939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 813C6AE4BFA
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 19:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C47E7A5CBB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 17:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5922D131A;
	Mon, 23 Jun 2025 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="h0IrKGpt"
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24CE29DB7F
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750700007; cv=none; b=mBqHFdnejeJU43i7M7QrVXONNoME35qA7hI5Xby3o/KrnHkevXSjLyoxnnm7cKFHftrvBrFWlYeIDWLLTnb4xvIm1IksuO7qiys4VXycIQqDQsEYkZfgWE9/wsYodz1zwLJhyl8c4w3TMAkrcxPKzu6PMo67n90VjOdNbIelzAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750700007; c=relaxed/simple;
	bh=9ESxItapZGpeX27bCqCWykYCjM+yU4vTWbwqb34xOmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja2xCneYI6rIiMHZ7/t7h9cx/Uy9qZ2jvH6TliuES+WmTaLiKCEVtexuyji4KTW4z1iFo2qcqOrCAsUO5jLYO+/EPM5dcWxyI0l2Vq7UqUkvD5QYZL2P/Sew/ZtXH6yYCOjonlRMxImDWSnVuuGjw2WbLo4+yJnWvJaimYXMjf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=h0IrKGpt; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-610d87553b6so1877048eaf.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1750700005; x=1751304805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ESxItapZGpeX27bCqCWykYCjM+yU4vTWbwqb34xOmU=;
        b=h0IrKGptlbQ3xJYJdVcMeNuvAU3V/0m/vNdgsvWh0YWWduIvJPA1cn10puFAC5xIHq
         CM0bxMYXcugphbm8XwxfEQUry+FlqESiwJnQwVzAPZOFKwP9iJ0NG40lgFyAkOKYoYeA
         Kth78elC4E/yFdTTjPyGGZHcKSoYTWJE6s2jbMUs0pMaEnUcmzwtqAIjdVvxnVOlJrE5
         cIeDi63m7LcVhQTcMAZeqZnZ4ZrgpYZAARX6TCoUOpm8XniCISuTlQD9CqyfAJ9sBPJ0
         CZ4gBp7o9CLHnlWzA8JyDH1SmdJYyNjCwkivd+JMVeGUiLgVarhjm0BUXG1oevJ0YvRO
         KEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750700005; x=1751304805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ESxItapZGpeX27bCqCWykYCjM+yU4vTWbwqb34xOmU=;
        b=XSQoOWzdTydxrThSXpK75lUoqg46/6UDW/efm+l5IwrSe5fImU+lpHypLn3IWuPoZ4
         RQEgL1w719p631wgN8OHDK1KOhkqqXLgC0mLNTeYb/FHcivYttLrfJuhRVY5iA9JKhft
         H4XErNgmhOS7DcBpWq9VD6staDkpszoHxInVqUktaXPVLT048UrtbF74fWGTvT2tWmfs
         YqOOsbRls31COn/cvx9DaI8JpKv3IKo5Uhq5AorgqIDrMBUro9QNNuk0ejUlW06oTnwj
         Wyyke5wvPDihT92qe4v2eylzorSSn3WZpgcxcFW/HInH3L5jri9fbXDnCnmNjaoQD+YU
         IsmA==
X-Forwarded-Encrypted: i=1; AJvYcCX3hXQmeibb4zTLh1gSxaPkMu68FUMALB31b7ateqY0OV3wNLltIU3DSWQnYUxw9gmyZqZDvEvdp78lR/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg0a8PvynSLzQUHP6sLgSFkyOYEI8q7klBpce9rg7yahv6a21P
	ct41jF74HyhkA5MBuVLpCYHKyCfealIjaMX/tTB4EEeV2bIrBmvmX5B+TnIktA7PehT+D18nykr
	F6sJAoU1jRbpW0aIXMWTRTWvSiOzRjrZTPnrscN88fw==
X-Gm-Gg: ASbGncuzIWlMZTP+xZTGDpXA+P0XooETuYKDRrrRGvl9sEOuoVReaqTOEj7DvfPEPtf
	fHfp+dBeFTfj8YgjS/w71D11IMle82V/mF4kjQRYA1ibIC7oD7nyOErUyiY4+yR1ePK0vlyglRp
	F2etQ+c+JgA2B04oq7+T51+ztpi4DxQ3zs4LTCdf0v1fs=
X-Google-Smtp-Source: AGHT+IEnQISZoeoPxj8JEGlUaibukW91WXz6xwGvL5sx8yj9FeldaqG5qJs0cowqWl1mZaAAU6aoFwKpwix2JbTKO8M=
X-Received: by 2002:a05:6820:1b07:b0:611:7f80:6474 with SMTP id
 006d021491bc7-6117f806825mr4229278eaf.3.1750700004712; Mon, 23 Jun 2025
 10:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616085742.2684742-1-hongxing.zhu@nxp.com>
 <20250616085742.2684742-2-hongxing.zhu@nxp.com> <kjsaipr2xq777dmiv2ac7qzrxw47nevc75j7ryma32vsnyr2le@mrwurn6rgnac>
In-Reply-To: <kjsaipr2xq777dmiv2ac7qzrxw47nevc75j7ryma32vsnyr2le@mrwurn6rgnac>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 23 Jun 2025 10:33:13 -0700
X-Gm-Features: AX0GCFtnkiV6JnGTj19oSXnEDcUfrmPAyTPCGVHfXU5cEeF-T0n_k13y5pEP9X4
Message-ID: <CAJ+vNU3mKiEE86SYFS0aEabkqRKADFDJN0giX73E0cA=GOyhjA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: imx6: Remove apps_reset toggle in _core_reset functions
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, frank.li@nxp.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 4:42=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Mon, Jun 16, 2025 at 04:57:41PM +0800, Richard Zhu wrote:
> > apps_reset is LTSSM_EN on i.MX7, i.MX8MQ, i.MX8MM and i.MX8MP platforms=
.
> > Since the assertion/de-assertion of apps_reset(LTSSM_EN bit) had been
> > wrappered in imx_pcie_ltssm_enable() and imx_pcie_ltssm_disable();
> >
>
> What about other i.MX chipsets like 6Q and its cousins? Wouldn't this cha=
nge
> affect them since they treat 'apps_reset' differently?
>
> - Mani

Hi Main,

This patch effectively brings back the behavior prior to commit
ef61c7d8d032 ("PCI: imx6: Deassert apps_reset in
imx_pcie_deassert_core_reset()") which caused the original
regressions.

To ease your concerns I've tested this patch on top of v6.16-rc3 with
the following IMX6 boards I have here with and without a PCI device
attached:
imx6q-gw51xx - no switch
imx6q-gw54xx - switch

I only have imx6qdl/imx8mm/imx8mp boards to test with.

From what I can tell it doesn't look like the original patch that
added the 'symmetric' apps_reset de-assert was necessarily well
tested. It started out being added because as far as I can tell it
'looked' like the right thing to do [1]. You requested changes to the
commit log for wording [2],[3] but I'm unclear that anyone tested
this.

Best Regards,

Tim
[1] https://patchwork.kernel.org/project/linux-pci/patch/1727148464-14341-6=
-git-send-email-hongxing.zhu@nxp.com/
[2] https://patchwork.kernel.org/project/linux-pci/patch/1728981213-8771-6-=
git-send-email-hongxing.zhu@nxp.com/
[3] https://patchwork.kernel.org/project/linux-pci/patch/20241101070610.126=
7391-6-hongxing.zhu@nxp.com/

