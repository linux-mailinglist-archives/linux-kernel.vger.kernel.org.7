Return-Path: <linux-kernel+bounces-844432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D64BC1E5D
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7770E4F10EC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE212E4247;
	Tue,  7 Oct 2025 15:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXqgaKxo"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5A32E5400
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759850434; cv=none; b=UiHTr8VJSdaZb34WyousjTfSbfX4E93yUZqjoemSTKud93ckdR9P1v0+eVpiPpnqEmd0ZLK91GJsLFIFIoncroHGV+PrcVw3tDt0XUCHuOQmmay5dP3jEkajjx8krEsXVFlLB6winanUAyrris7v32W8H1Jw73nTxR2j7r/AiBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759850434; c=relaxed/simple;
	bh=98NzBJIQUrqXcK8lJa5ab/WRAaAi41rD2LPalLK9pYo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CWpHCoc04X04wJTaLVcf06Znnf4V6fyyiawzzCwq+XJN8YCVlyZYTF3hS+f0GHd/5KoQjAlBVawWkqqoJHF/r+ETqWbTQDPBVcxUcdwp1/HCgqw3SaPP7MxnHQZEjqT34xteVI9wiNcTrq0dpF1vlWA4Jynr60jU0sKD+ywFsBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FXqgaKxo; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63605f6f926so5450391d50.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 08:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759850431; x=1760455231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98NzBJIQUrqXcK8lJa5ab/WRAaAi41rD2LPalLK9pYo=;
        b=FXqgaKxoQiXTGOXt6jJXsfKyWgCvOStSpzJNNlWE3itGywRKqBKpeLJcNilbvtcuSe
         KogGDid3gBr2B+NbsxsTnWMoAQn7PQsAgpoW1qCxwChRG1JgjMGdVw4uDg/ro+Hr915L
         skeXhsYGDi6m98/nLeqR14ByVTgnHTydBd3gFB/RYKSK6jj6zqYWZgOEI1oKMz8m+On3
         aMPWZCrq91mKg2IeJEIz26GWy45+RIegGmfS3VI1PiNpLLccX8Cgg4kY7Wyut4dly+FK
         CJwTDm7ZyUR6ldok72HgJQzijtAQvo+B2VlWp3tVNT3u1nm1DWfNsCvJPPhTaryD/PrU
         Hr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759850431; x=1760455231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=98NzBJIQUrqXcK8lJa5ab/WRAaAi41rD2LPalLK9pYo=;
        b=kFIXknPEOMXw8MHRfQTNACrb80dZW+B6Mz8GihoLrfINODQnOFlnHM/XXOB300E9TY
         dBg6KnxvHTvk5wy9kzMcGBQHU4sRvhaBrN4J4+RqbIQetKwyIU4pm0us6ui6f7/xpknE
         dD6qHCiJFTiyYaiSnDrmUpPVTdZTafvrFV/5k0e5witPSDyErvz2NVDvwiRmqwWXCRp9
         vI5NN0W5GKP8UBH6SZ/WhvsMdYnTVYlV8REtlo2oRyKJVgAXeCYE/JJliveTxaT2AsJ5
         ckbvTSbY6PSciKaU6rYGhYeYXHTTBOQcOkL1wZFDEeLXf5uYj40sFjammiiuii3vvDX9
         XVZg==
X-Forwarded-Encrypted: i=1; AJvYcCV6TgRRC47UeTXNqQRrGwuzoVSH5x2to9joJd4C/OEDlw7scf+Zch5evaLSQboWy7NbE61i0fypFDJ+Tcg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKMCiMAoHJEiAvJ5Xijfilf4pxC1d9oJuLgiNOjOztdBUwfw3g
	eCDXPdJJfdnVJmGAuhMcQchlPrgx9nQujtFliQ/sX6wDoagyeL3rqchnsugmPABLhlndas5WS3A
	887RJNWxCcubjXWE6OUbkzhUkJVnTnXBWXBvco2/wWw==
X-Gm-Gg: ASbGncsXjDJJZcnaB2bt5kK6DbRihmcmAvV1tPDsWwbJWu7GNTMreTCKvw/g/8selWW
	eyuDXFLKistjePUdOCavYuYz7yzIxqsjd/Bp0QXvOzjdHLj37qeeH5B/A7KBXIeL6HikcDiyplt
	zJswzrqdEBtdB3H7H/2x31DqszmKSL8lptYftL8+Ek/oqOW97sS7MF51WNGCxfr+uCDTVDGsBqm
	xWAp/Czu+EHwWyrGekggcU4mhRm/XoicugE
X-Google-Smtp-Source: AGHT+IExaCGrfrgm8yI9pnsqPGC9yiuujr1Byb7jHbFjQN/nXS0MZII4VZvwZ+cfzBBjnOYd8YHW2NtRylZdMJMJIHI=
X-Received: by 2002:a53:acc8:0:10b0:5fd:45a3:fe29 with SMTP id
 956f58d0204a3-63ccb8ebf56mr12948d50.24.1759850431574; Tue, 07 Oct 2025
 08:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87v7l03pqe.fsf@osv.gnss.ru> <CAOMZO5DG=cQtqyzihrFarEq6=1AOAPAMkeXajjGxiW0yvFRa0Q@mail.gmail.com>
 <CAOMZO5BtXsjFFWDbt=Zuy_sUS-HySkcjhrtAg3+k211VY8SMcw@mail.gmail.com>
 <87o6qjaiz7.fsf@osv.gnss.ru> <CAOMZO5BwoAzf36-L0uCTdKriGaUHg1MqZoKg56Fvob6S4coMBQ@mail.gmail.com>
 <87jz17afpb.fsf@osv.gnss.ru> <CAOMZO5Dvc9AhudPkEuM6BL7F4n=5S4M6d52jzomWnJvCOWVaaQ@mail.gmail.com>
 <87ldlngd0n.fsf@osv.gnss.ru>
In-Reply-To: <87ldlngd0n.fsf@osv.gnss.ru>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 7 Oct 2025 17:19:55 +0200
X-Gm-Features: AS18NWDMwiiHt000mfybTztUreGkUxAcuNvaYGI5u2aZISHGO-P7FmOXjJbH9gM
Message-ID: <CAPDyKFooV3zH+0egCQhefRxM_twG+MCkQdqWB=KaSkMXYNcD0Q@mail.gmail.com>
Subject: Re: ARM iMX6sx board fails to boot with kernel 6.17
To: Sergey Organov <sorganov@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>, linux-kernel@vger.kernel.org, 
	Shawn Guo <shawnguo@kernel.org>, "Rob Herring (Arm)" <robh@kernel.org>, Anson Huang <Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Oct 2025 at 13:35, Sergey Organov <sorganov@gmail.com> wrote:
>
> Fabio Estevam <festevam@gmail.com> writes:
>
> > On Mon, Oct 6, 2025 at 6:22=E2=80=AFPM Sergey Organov <sorganov@gmail.c=
om> wrote:
> >
> >> It is built form multiple .dtsi, so I figure I attach the one after
> >> pre-processing stage. Please let me know if you'd prefer I rather
> >> manually insert all the custom .dtsi into a single .dts, and send that
> >> one instead.
> >
> > This format is hard to follow.
> >
> > To make things easier for debugging, you could create a minimal board
> > dts file with only UART and eMMC nodes to reproduce the problem.
> >
> > It's not clear to me the relationship between the ANATOP regulators
> > and the eMMC power on your board.
>
> Thanks, Fabio! OK, I'll do, re-check, and get back to you.

FYI, we have had some strange issues cropping up in regards to the
so-called ->sync_state() support in genpd, that was added in
v6.17-rc1. Not sure if this could be related.

Most of the problems pointed to commit: 0e789b491ba0 "pmdomain: core:
Leave powered-on genpds on until sync_state".

Although, it's not possible to make a plain revert of the above
commit, one can opt-out from the new behavior in genpd, by setting
GENPD_FLAG_NO_STAY_ON for the corresponding genpds that are registered
with pm_genpd_init().

Kind regards
Uffe

