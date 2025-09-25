Return-Path: <linux-kernel+bounces-831965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0553B9E07E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E096F1BC0A22
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336B4155C88;
	Thu, 25 Sep 2025 08:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qsl01IfI"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BC428F4
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758788679; cv=none; b=TFOt7zy5cTs4d9aRS2dXKSCtWzu13e7cLdAhKUNUnlVsmdxwxpVhIvkF+o9SsuCAQAciF/SO1j6N2IFZL+ysWz6xUzpIOJ4U5xkiSy7t7bKUj25xfrg6RKPW971+XrYZGHdhGaePSC1p+PCPCUD9kE99dJjB0bexbhHzxP9cU2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758788679; c=relaxed/simple;
	bh=sTAR1grncL68dTEELBlinnV4e/5cxUfPyddmz586pzg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ab5f44l+r5t0JR7eN/nl3EoK9avUka+hwBlMcB6Nq9ML9Fjlbv3yyr80VQDD1CoBd6mqcb5M372vqBprk6aqdKn1GfhwUM4uhqaT9dKOo+jDGrarjgfmygS2Tbr+NrQLoRNeH8+zi0OXui9rPqgJuh+SEEaW55gWl0gVg6OxZ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qsl01IfI; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-24457f581aeso7698615ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758788677; x=1759393477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6V4Dh7tKP33MFC/qEDuqzXdiriXrPzKRW29udUVBt0U=;
        b=Qsl01IfIZIZwB76KPIosUg0a6osOo3O4VhTMMtQzMm3PUlzQrQ25k3N+mjZkdQdk7j
         U3QSWNNRUQw9gfs2VJJa+wPSqelUV0CeO2JpBhqMdP8KMAuoGlRViDVRJfW6JpiV0DTk
         owxeS7XD1BSXgegCvu32SWQGef2BnnwPat23VC2jCy+FtOMSYSu5JnHZ2blkjBY8fBSv
         H/vLbYmEi3cju8tJ+wP09mnuF9ssY1tQvZQuNfK5CWtm5D1quLWn3/oql/EPJfsmpEQ7
         bqRLGh4v+LOQ1qmLwKUFnip0J2xgVOvEhvWTUzDeghDenPig91Q677J8vlTdBmgljIEV
         DSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758788677; x=1759393477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6V4Dh7tKP33MFC/qEDuqzXdiriXrPzKRW29udUVBt0U=;
        b=F0tU3KkNtjp9kAIRowBfHRU+QqOzBt37iMphWoMQATfEAWJ7L5Q/uqXwuwoNjOqK1G
         pVkxbkw7EQbgFRoMfWqEaMgqCCo39HADnaFgRWwF3OuGHiPr0tY2656mRWLL+C4g3WBx
         z4ZEFrycpAjQUrAM+AxcPbsu318hWVGubP1jHeulBTOKNChE4gteNSfBxbnTj1B7JxfY
         jTpJfL32LqdbNTX/6IOBeVCK6rTrLLv8yf/npWvI8JKNaA9cpAP/J8iXD0if6KIGF/TP
         OzzPMTmokn/WhOJF+d8AWOWA0ZfwOReSQa8DuhFb/vmsGDmBt7zNVzkbQ2hd670q8pye
         PZ6A==
X-Forwarded-Encrypted: i=1; AJvYcCU/ZE5DouRFNwG2RB8rE6XCGY/CQU0iyn2FSuiMUfsKakcjyPlwhBVEgQ/9hYtb0RjhK3p+aMyTECWg4Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YztzbukZZ4KzhSqZyuG/k5M6oSt3F3lnBAnh9uwc6irsbrqQ6Ag
	/TVGI+5EsA31/fS3nmZww47jbRSFeO42lL6kpNeqIGcAFEyX3V1D18cUBTgZL3ASd76+8LETtmZ
	v84gCH+h6Ct/XwAoQ69iDfSaCD2Znv+M=
X-Gm-Gg: ASbGncuDn7cGLoLrbLShvnyEs3O6cZqk5PHYwAff8UXUafhTmKDoSZUx0bC7VLqInJx
	rbwLVQiMeKmf/1iz50idDozL4yuBKPLBR/2u7F5h6swES9CcRtS0MyNYxJtvxwuEwQU2ECeqtfz
	y+gU8qqmMv4RJIVM+47hAK0xV/BC1NpVMkIex6JTD6go0mxFhXa4LPepHQYawzWSn1EYmJ0be1r
	6FQBKJhKFbyr7Zg5MUXkJQns8WTiEe97mJ5A72Na4M10i2h
X-Google-Smtp-Source: AGHT+IGscpAzAZePJIei4M74SY6t3g5clNF77QW53FQZcP/FV0TyOxZ6EHRVDKib2OHnN3hszfUnxw4zg4b0WsneSec=
X-Received: by 2002:a17:903:8c8:b0:267:f099:c687 with SMTP id
 d9443c01a7336-27ed4a29e1bmr33522235ad.1.1758788677041; Thu, 25 Sep 2025
 01:24:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924-knp-dts-v1-0-3fdbc4b9e1b1@oss.qualcomm.com>
 <20250924-knp-dts-v1-6-3fdbc4b9e1b1@oss.qualcomm.com> <CAJKOXPcbJY4JEjfZLvOAXEWCTYFpe7En+Riis2t3K5fWJgNU5A@mail.gmail.com>
 <53d63dd6-a022-4e80-a317-3218976a7474@oss.qualcomm.com>
In-Reply-To: <53d63dd6-a022-4e80-a317-3218976a7474@oss.qualcomm.com>
From: =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski.k@gmail.com>
Date: Thu, 25 Sep 2025 17:24:24 +0900
X-Gm-Features: AS18NWBrs_SxQohXhwS32-u616VxPcXUdBxvUwQGruDi4ncYM81jJN8M3_KFGEM
Message-ID: <CAJKOXPcsVvb2gNUdYYvm2AP90AjGUCGpT9jVU243E7C_N764rg@mail.gmail.com>
Subject: Re: [PATCH 06/20] arm64: dts: qcom: kaanapali: Add USB support for
 Kaanapali SoC
To: "Aiqun(Maria) Yu" <aiqun.yu@oss.qualcomm.com>
Cc: Jingyi Wang <jingyi.wang@oss.qualcomm.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com, 
	yijie.yang@oss.qualcomm.com, Ronak Raheja <ronak.raheja@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Sept 2025 at 16:39, Aiqun(Maria) Yu
<aiqun.yu@oss.qualcomm.com> wrote:
>
> On 9/25/2025 9:50 AM, Krzysztof Koz=C5=82owski wrote:
> > On Thu, 25 Sept 2025 at 09:17, Jingyi Wang <jingyi.wang@oss.qualcomm.co=
m> wrote:
> >>
> >> From: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
> >>
> >> Add the base USB devicetree definitions for Kaanapali platform. The ov=
erall
> >> chipset contains a single DWC3 USB3 controller (rev. 200a), SS QMP PHY
> >> (rev. v8) and M31 eUSB2 PHY.
> >>
> >> Signed-off-by: Ronak Raheja <ronak.raheja@oss.qualcomm.com>
> >> Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/kaanapali.dtsi | 155 +++++++++++++++++++++++=
+++++++++
> >>  1 file changed, 155 insertions(+)
> >>
> >
> >
> > Second try, without HTML:
> >
> > I really don't understand why you created such huge patchset. Year
> > ago, two years ago, we were discussing it already and explained that's
> > just inflating the patchset without reason.
> >
> > New Soc is one logical change. Maybe two. Not 18!
>
> It was previously squashed into the base soc dtsi patch and mark like:
> Written with help from Jyothi Kumar Seerapu(added bus), Ronak Raheja
> (added USB), Manish Pandey(added SDHCI), Gaurav Kashyap(added crypto),
> Manaf Meethalavalappu Pallikunhi(added tsens), Qiang Yu(added PCIE) and
> Jinlong Mao(added coresight).
>
> While it is over 4000+ lines when we squash it together.
> Also as offline reviewed with Bjorn, he suggested us to split out the
> USB and other parts.
>
> >
> > Not one patch per node or feature.
> >
> > This hides big picture, makes difficult to review everything,
> > difficult to test. Your patch count for LWN stats doesn't matter to
> > us.
>
> With the current splitting, the different author as each co-developer
> can get the meaningful LWN stats.>
> > NAK and I'm really disappointed I have to repeat the same review .
> Currently, there are 10 SoC DTSI patches sent, structured as follows:
>
> SoC initial
> Base MTP board
> SoC PCIe0
> SoC SDC2
> SoC USB
> SoC remoteproc
> SoC SPMI bus, TSENS, RNG, QCrypto, and Coresight
> SoC additional features
> SoC audio
> SoC CAMSS
> SoC video
>
> Which parts would you prefer to squash into pls?
>
> --
> Thx and BRs,
> Aiqun(Maria) Yu

