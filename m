Return-Path: <linux-kernel+bounces-831980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC59B9E105
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 10:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8AABB4E24FE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 08:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC11E17A2EB;
	Thu, 25 Sep 2025 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8puL2Eu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489941D8E10
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758789165; cv=none; b=P7PnWoPfG1i1QXcnWcqWQKKfeyQuTiegMRISiFkhRn1cU/43CJYb0N6ma96tQrUYirNX1u1EY43er8XixnDBaCvuaV2fBrAQLX2bh27RWAB7LZAoCY7+0lcgvyfllsk9BngS4MFiLZED6CaEpXpjBo1/PNQaAUyBTlxvKRiVUiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758789165; c=relaxed/simple;
	bh=1U+8ZCeOt54StVgsf4liIhu0wX+Pc0FpxnKK3mlY/jg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LxxeU4vm98QsTk3p6wWQ9VI5Jya+FVMCt6OX1pkgQZ7kzxUqziHj0PoulivsltskmJVZVdAK9r/kJxy7MqUzZduUnVahS04GBZsb0NuVyLyvuw4Y2CSQusSf8FEUEWEbFuTLdRKyRphnd3qbIyL/hfs/wPiLrsWLaQhueQPAYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8puL2Eu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC188C113CF
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 08:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758789165;
	bh=1U+8ZCeOt54StVgsf4liIhu0wX+Pc0FpxnKK3mlY/jg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G8puL2EuVs5X/0awxToGp6mHfAj8BW6LjFWch6z/hiuJBN8M/LLK6WMR91ImthH84
	 far1xdTkTLWyAo7wv98oT9mYkGmgfulEd+Bw2ehe5VmUPGhwSIy+NkHiydQBLiFh1z
	 t9tff5WwMdYdH76OiJM9s5Xf6vOU5bKfB1SFi0Y5BZwxpusMHWCHSb7/MKsBIrOQ8w
	 P6NvyYRCosouTcRq4qDBq4H28JPoX16ioqdaL4uh7S5zJQOTMNN1bI1dDZ5+zTJeQq
	 rTWyZCzTyxj2bQfG2Jz9gb9sHaGWdvG9kaT9RiNIXPi7AtWo5WpwEHWaKJAfwTwf+y
	 XRcjg/vrhQhEQ==
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2570bf605b1so7892135ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:32:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUrYTGUKBOOtNu/LxXaNyi1UCZCjbHgp5H9ZAGgGrnGLpED0DJpMae9o+rh9qO3Kj8X2r8VXoyPy9JiPl0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYgEbAKpdaMOXclr4AcKGPHl93UAv3hhOO5ayHDcrnOWH3b2Cy
	9hru95Erq5kakqB2S2/PeJ0bSAD8SAUle4pVkzFYBDGfRgfrcqfuosa0qw0vachpsQpbAmgd5ZW
	9UjPdlTINbhZ/gRT09Nm/WN0CIxTC9bM=
X-Google-Smtp-Source: AGHT+IHrvc9iLpq88k/Zf2/yoLib+v2N+khBqKsA2oA+V+eLxVmijCZXO8s6yPfX0FiHRvQikyL7AZmaklD7LlHAvYs=
X-Received: by 2002:a17:903:196b:b0:273:495d:53ab with SMTP id
 d9443c01a7336-27ed4a4bb29mr29165935ad.46.1758789164533; Thu, 25 Sep 2025
 01:32:44 -0700 (PDT)
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
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 25 Sep 2025 17:32:31 +0900
X-Gmail-Original-Message-ID: <CAJKOXPfGC=FK7AKOtmmSV7=3NNXAHe8A_PGjjhTKgRs4Jk25xA@mail.gmail.com>
X-Gm-Features: AS18NWA0tiWyortDfCg8UAI-zrEfvMwzuEt9g3SfxjzbYCGEe5OINQIMsodub3k
Message-ID: <CAJKOXPfGC=FK7AKOtmmSV7=3NNXAHe8A_PGjjhTKgRs4Jk25xA@mail.gmail.com>
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

That's why you send one node per patch? Multiple huge patch bombs land
the same time from Qualcomm, with patches adding one node. It's like
the "no more patch bombs" discussion and rule never existed (yeah, I
know it was removed but the spirit of keeping maintainers mailboxes
sane remains).


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

We don't care about your LWN stats.

Sending stuff like this for your stats, means that community and
reviewers pay with their time.

This is really just selfish. No care how maintainers need to scroll
through their mailboxes.

> > NAK and I'm really disappointed I have to repeat the same review .
> Currently, there are 10 SoC DTSI patches sent, structured as follows:

Why did you ignore all the feedback from 2024 and 2023? Every year it
has to be repeated?

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

I made very clear statements year and two years ago. We also discussed
it on IRC multiple times. Can you join discussions instead of ignoring
them?

>
> --
> Thx and BRs,
> Aiqun(Maria) Yu

