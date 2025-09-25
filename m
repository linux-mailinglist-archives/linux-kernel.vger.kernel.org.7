Return-Path: <linux-kernel+bounces-832531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E72B9F992
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 15:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E47189700A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 13:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B276C26F44C;
	Thu, 25 Sep 2025 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqlKBzYh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19831261B7F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758807305; cv=none; b=GkPE1tU2/Q7UtPTqn0YgfQrNTTvKG/7wU1PEpxSLTEEh1vElOvGUyJ/N1vUX2x7kt208rnEXScXskMcP3lDLM/QjAPQzD2Tx4sik51d2ob6yK0HgQu8eBEK4fMsLwGwL7GKFBIbHA8LqdDlIjGeXPLFM++F0ynVo4GFRcWq0UZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758807305; c=relaxed/simple;
	bh=U0zBqrOVz2aVyIkOdhN/c5ZsuFUDGjUs9oZhG9G8cd8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFd+umhzM655nv+vsyxDdIEf8rg1aaS7FuzuHbuFQAUF4Mp/5n8iCm9EGlrlqwYSioB/rIavXhLUt0w160m0Yke1sBLauYY1eAXPde7dx/RVb3xSXrkrmL/xe5PtPFf8uRm35knykAPNZOia+CanDEM+C3H7oqxPUfG8Ma6zvwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jqlKBzYh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE29EC4CEF7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 13:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758807305;
	bh=U0zBqrOVz2aVyIkOdhN/c5ZsuFUDGjUs9oZhG9G8cd8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=jqlKBzYhSbMB0AooEHcEffkJvc0PEdsZ/KBlWX8H8DqGvLlZaJSfJG5SIr17yPK+G
	 IvGn02h9tleWaSYK+Dt6YBF7owTwu5Jfdk50OlB9DHBD5AxMuKQmHFBdlgG2XZZcgx
	 rEnapeSxjIIA34DEAUBL7DIW4nPVlACR/Piwe9PqBLR2k7v+110bfaW+RSKOMIsnbv
	 KY1cnK5ByavUBKReyr/W2C9Lx1bZvaM8SHDrZ+uLh558MNVhL+eEEzntQkeVIQYT00
	 kJ5R0gA8joPtc+zpyTCgLe6yGoa/chR4RPgs+YK/srgLgLcP4CJOg4AmwWwm4763my
	 MS7pQl+ZOvgTQ==
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b555b0fb839so732065a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 06:35:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUt43MbSX4hmkh3BXbpPKyrWMxGOmaoFmf3uJazmJjnSex7PtstwJO6cqKPku6rprzS8Off1FB/NOP8Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYvLcSbW85BCHc7he8xVqDGAKFxOhRpy3+mwfex4BTRK4a/grO
	thGgY7aN93UyNmwOLG6x0RrPgg9C61a4aJGIbZugRq69ZyIxSXJhE+Od90SpSx/1tJE10bAJK0a
	jqRopZibCyg323AmZeGmFc+2b507htOs=
X-Google-Smtp-Source: AGHT+IF2gfRSMbhEJa8nvrh+JpQ+A2ctdyaVqt5YxJDoqNHuurr02R6K0ugrO5eiCQDnx8VVAz7RofYZkW98Xl+uAW4=
X-Received: by 2002:a17:903:2c9:b0:259:5fdf:d79c with SMTP id
 d9443c01a7336-27ed4ad65e1mr32294745ad.51.1758807304473; Thu, 25 Sep 2025
 06:35:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925-v3_glymur_introduction-v1-0-24b601bbecc0@oss.qualcomm.com>
 <20250925-v3_glymur_introduction-v1-14-24b601bbecc0@oss.qualcomm.com>
 <CAJKOXPdQH2jXcEY6ZpkmixvUt26SqdzYgDAiJ3RHMG7xkPyi_A@mail.gmail.com> <lcbcjpoazpwbltedkiqlw4l3aomwvi3qsfwvmwghb6uf5wvnme@kh7qdpunfuwr>
In-Reply-To: <lcbcjpoazpwbltedkiqlw4l3aomwvi3qsfwvmwghb6uf5wvnme@kh7qdpunfuwr>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 25 Sep 2025 22:34:52 +0900
X-Gmail-Original-Message-ID: <CAJKOXPcyhDdFW_u4YQLiHYj8gM7wYB-LOmB_PJs+5OOgn8WZFw@mail.gmail.com>
X-Gm-Features: AS18NWC4qEyHuPYqOFoEoG1CnyL6J8LaE_ysvRuMlpyTnvkn7ftx1v5-lrNiYqU
Message-ID: <CAJKOXPcyhDdFW_u4YQLiHYj8gM7wYB-LOmB_PJs+5OOgn8WZFw@mail.gmail.com>
Subject: Re: [PATCH 14/24] arm64: dts: qcom: Update the pmh0110.dtsi for Glymur
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Pankaj Patil <pankaj.patil@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 22:14, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> wrote:
>
> On Thu, Sep 25, 2025 at 05:08:54PM +0900, Krzysztof Kozlowski wrote:
> > On Thu, 25 Sept 2025 at 15:34, Pankaj Patil
> > <pankaj.patil@oss.qualcomm.com> wrote:
> > >
> > > From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > >
> > > Add multiple instance of PMH0110 DT node, one for each assigned
> > > SID for this PMIC on the spmi_bus0 and spmi_bus1 on the Glymur
> > > CRD.
> > >
> > > Take care to avoid compilation issue with the existing nodes by
> > > gaurding each PMH0110 nodes with `#ifdef` for its corresponding
> > > SID macro. So that only the nodes which have the their SID macro
> > > defined are the only ones picked for compilation.
> > >
> > > Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
> > > Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> > > ---
> > >  arch/arm64/boot/dts/qcom/pmh0110.dtsi | 66 ++++++++++++++++++++++++++++++++++-
> > >  1 file changed, 65 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/pmh0110.dtsi b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
> > > index b99c33cba8860f1852231db33a127646c08c1e23..4a5c66e5c9fbc35cedb67601f4568844dc41fbea 100644
> > > --- a/arch/arm64/boot/dts/qcom/pmh0110.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/pmh0110.dtsi
> > > @@ -7,6 +7,8 @@
> > >  #include <dt-bindings/spmi/spmi.h>
> > >
> > >  &spmi_bus0 {
> > > +
> > > +#ifdef PMH0110_D_E0_SID
> >
> > NAK
> >
> > I already explained on IRC in great details why.
>
> A short summary or a link to a channel / date would be nice in order to
> include other people into the discussion.
>

Of course but:
1. You were there so maybe you remember the arguments, and:
2. I'm offline, using phone, not having laptop, replying during my
personal time off just before merge window so any emergency time
should be spent on important matters instead these two huge patch
bombs adding such usage I already said: NO, don't do this.

