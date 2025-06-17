Return-Path: <linux-kernel+bounces-690639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70380ADDA0D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 19:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4CDE4056C1
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 16:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33882FA64A;
	Tue, 17 Jun 2025 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JsjqHIS6"
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF4A2FA62A
	for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750179238; cv=none; b=b9G4SJUSxSF1HKvByJzf7rAtd8H0mgaqHLb9pa8jLTem7A4UnR5DrUztnyUTFISNK1+xsPivE8AgV056th6/Bv0jfVJl3RuH5beG0R3qjMLw9vUWIWX39U+jJSwf4kM5Afc/GAcKsHkNhxDQmQiY0VjEbiBFVloHn1I8caAXMZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750179238; c=relaxed/simple;
	bh=sBlsNW8rrToWOrhajHMtR7bPZcZNRFXKCV4kuxSCtGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R20FKNcrzu8Qd4IOdA50ldzLNTZAHKGQGUtI/Y5vSgLdRUZpKt0HHW2wqGDTtd7/585y9Yk/zscijFy9vryjWjVHrhXlBlL+lhcEqLg8K7JfwB+GgYzRDga6oy8tpBG/HAHDja9KlN1ztK9LNG3abtm3tWg2NXQ6ZtE54cX0MOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JsjqHIS6; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3ddc99e0b77so10745ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jun 2025 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750179236; x=1750784036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYJnE0bLpXfGXAhOdoPj9sjJfon5avZzMzwtb4GEZQ8=;
        b=JsjqHIS6SrWvTtPqEamX+rE8oY28eN10IhMp96WR+Tk6jtltlVBUQjtWjeUwbofjp/
         wvwQxo/ENAGIKRzmacn3b794E36sHE7jvFc6uSq2qatRzCa+3HMSWXYLtGU94hLfQTHd
         4snu3DkcsFAPwEpaPkJe0uDWD5aPJqEJUUE5Tk3kDteSFvP/BNeLAGPnKaRL8IyjeExb
         l7Q5DlioBpMPt7uL0PvotRD09ijzSuyRVZkfKrLB6LxUk5kcO8zcuK41S5Tp5Nb1wFW9
         3Sin0djqSVY7FSeKtRkMOHz4vpupA0H/XYBqQmZRFrDVwjraHkfFUTWA8T79H8oPsJHt
         MhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750179236; x=1750784036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VYJnE0bLpXfGXAhOdoPj9sjJfon5avZzMzwtb4GEZQ8=;
        b=dbrKjJR5+FsA8eMZKm+17bQt0zbRJELECCA63NmYZDwuFe7t2Xl23dB2oObAsyTzH6
         gdEruqzNRUhh5oxPo99NDcWMnWXg9ATaugCkRUmKmfEFUv0GHJUSocYcHNI91RrNYqt1
         Xelt4mG/jz2fByK+/ELDWLEM+UO5Zq0lTnmbIDixQM70ak7tPzge43vdxuYFKd7TxTfh
         /7YuEE3SHbtnIg3YLYU6RocZWS54LH2MZtIYQ6Jgt8jEHWnZ9QHEI94jUthUAvn4Uwd7
         HQ1PJiD6tMKra/PnyaN4aUbTb7DQt4PsgAdNozs2ecd+bPjRFc5NusMbNg3opr294IG8
         GPcA==
X-Forwarded-Encrypted: i=1; AJvYcCWWMERnm/FG23/G3GmYnTk53Swdj8aAu5u/IUmvn1LMaq4A5E+A8Bw0kV8Hiz5ba4ZhFtdJn/9tuV3GhIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyThvPBa4WheiEmSADwczDv/1RlMqCcuKeK2McWYL+gWRaoj5/L
	uv01LtVoh0MpUzKEFiMNMECKq39U6u7ea0LmdIpuD8LQjr48PJiHXdCZkmwJg8Y9n+UsT8WNY3I
	R4aETtSRrGlbiojzrPS5baAg4CXFW4KewG7xrbz1g
X-Gm-Gg: ASbGnctqwwBxnrT/7zJ1+QghtaqQUwybMJmyxWJPmfcmgBDPPC/1IF6WFSV6xcCUWwz
	ecZRWZGZBSVUEHEdXp1LXm7MCboZN/dipxbHbHsVKKLdPnjxQTrVYptBYogDwRD/m2yfNQoRxMz
	4YQZ7vGgnAtYDMiIm5qrrRkohHbcH/w+55pZBv6v3hFGVcU/Wk2d9qjaegqrlytL/IUbIXjEZp
X-Google-Smtp-Source: AGHT+IFxzIYnRwPkTPGsw15J0FvFqBPucLmLVdUh15Kwq1Q2Op1ssWJY8RG0XKYKAwujDL/N2ht0/4WAcdskUuxdyGc=
X-Received: by 2002:a05:6e02:4819:b0:3de:20ec:5c71 with SMTP id
 e9e14a558f8ab-3de20ec5f19mr5234075ab.6.1750179235473; Tue, 17 Jun 2025
 09:53:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616-apple-cpmu-v7-0-df2778a44d5c@gmail.com>
 <CAP-5=fXSwgxMc+uh=PBAFh4Zm96tL5RDyKPOJ8Q40O4s=EaArA@mail.gmail.com>
 <20250616102945.GA17431@willie-the-truck> <CAP-5=fVjJyV2eA1aDnk6cqAhJGc9FZVyHhP7-f=1OyWmzxjN8w@mail.gmail.com>
 <20250617141649.GA19021@willie-the-truck> <86msa6co21.wl-maz@kernel.org>
In-Reply-To: <86msa6co21.wl-maz@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 17 Jun 2025 09:53:44 -0700
X-Gm-Features: AX0GCFugvPzuB-Difn5EDUPVkKbvplUqcVBXc7z721G-mrMOHZ8e5lOvCFsdSTo
Message-ID: <CAP-5=fW51G0Wc227K1o0T==wF_3DN-UhBrU1VzncwmfPcWP3fw@mail.gmail.com>
Subject: Re: [PATCH RESEND v7 00/21] drivers/perf: apple_m1: Add Apple A7-A11,
 T2 SoC support
To: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>, Nick Chan <towinchenmi@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Janne Grunau <j@jannau.net>, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, Sven Peter <sven@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	devicetree@vger.kernel.org, asahi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 9:47=E2=80=AFAM Marc Zyngier <maz@kernel.org> wrote=
:
>
> On Tue, 17 Jun 2025 15:16:50 +0100,
> Will Deacon <will@kernel.org> wrote:
> >
> > On Mon, Jun 16, 2025 at 03:44:49AM -0700, Ian Rogers wrote:
> > > On Mon, Jun 16, 2025 at 3:29=E2=80=AFAM Will Deacon <will@kernel.org>=
 wrote:
> > > >
> > > > On Mon, Jun 16, 2025 at 02:36:18AM -0700, Ian Rogers wrote:
> > > > > On Sun, Jun 15, 2025 at 6:32=E2=80=AFPM Nick Chan <towinchenmi@gm=
ail.com> wrote:
> > > > > >
> > > > > > This series adds support for the CPU PMU in the older Apple A7-=
A11, T2
> > > > > > SoCs. These PMUs may have a different event layout, less counte=
rs, or
> > > > > > deliver their interrupts via IRQ instead of a FIQ. Since some o=
f those
> > > > > > older SoCs support 32-bit EL0, counting for 32-bit EL0 also nee=
d to
> > > > > > be enabled by the driver where applicable.
> > > > > >
> > > > > > Patch 1 adds the DT bindings.
> > > > > > Patch 2-7 prepares the driver to allow adding support for those
> > > > > > older SoCs.
> > > > > > Patch 8-12 adds support for the older SoCs.
> > > > > > Patch 13-21 are the DT changes.
> > > > > >
> > > > > > Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> > > > >
> > > > > Hi Nick,
> > > > >
> > > > > This is substantial work and it looks good to me. Do you know why
> > > > > there's been little progress on landing these patches? Buggy Appl=
e ARM
> > > > > PMU support in the kernel has led to reworking the perf tool. It =
seems
> > > > > best that we can have the best drivers possible.
> > > >
> > > > You reworked the perf tool to support these things? Why? These chan=
ges
> > > > are targetting chips in old iPhones afaict (as opposed to "Apple Si=
licon").
> > > > I think that (a) most people don't particularly care about them and=
 (b)
> > > > they're not fully supported _anyway_ because of crazy stuff like [1=
].
> > >
> > > I was meaning that we reworked the perf tool to work around the Apple
> > > ARM PMU driver expecting to work as if it were an uncore rather than =
a
> > > core PMU driver. More context here:
> > > "[REGRESSION] Perf (userspace) broken on big.LITTLE systems since v6.=
5"
> > > https://lore.kernel.org/lkml/08f1f185-e259-4014-9ca4-6411d5c1bc65@mar=
can.st/
> > > But in general it would be nice Apple ARM PMU support were well loved=
.
> > > I think we went 2 or 3 minor releases with the perf tool not working,
> > > threats of substantial reverts to avoid the PMU driver bug being
> > > exposed, etc.
> >
> > It's unfortunate that you've had a torrid time with the Apple PMU drive=
r,
> > but I think it's important to realise that it's both unmaintained (it
> > ends up with me via the catch-all for drivers/perf/) and was written
> > based off whatever reverse-engineering people could be bothered to do i=
n
> > their spare time. It's frankly remarkable that it works as well as it
> > does.
>
> Also, the "broken" driver actually works as expected. Ian blames the
> userspace breakage on that driver, but that's only because the way we
> deal with PMUs on ARM doesn't match his mental model. Oh well.

I'm not sure what this is in reference to or what you mean by my
mental model. The linked patch was that legacy events didn't support
the extended type bits added by Intel for hybrid. Prior to this legacy
events were broken on ARM BIG.little PMUs and would select an
arbitrary PMU - not good by anybody's mental model.

I'm happy to chat with whatever issues you think I'm creating. I think
you are making reference to situations where I've cleaned up a mess
with Intel hybrid and then cleaned up a mess on ARM. I continue to try
to clean up a mess for RISC-V. Sorry this makes you think I'm a bad
guy.

Ian

>         M.
>
> --
> Without deviation from the norm, progress is not possible.

