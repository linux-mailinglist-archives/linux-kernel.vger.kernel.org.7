Return-Path: <linux-kernel+bounces-840981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AACBB5E3A
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 06:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8442A34455A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 04:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6C1C7017;
	Fri,  3 Oct 2025 04:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OrCN+WPM"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B312213A3ED
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 04:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759464931; cv=none; b=KtFs6BBBAERLBrQSdUs/QbHAqTBvVbf5ddhM5w80SZtdngaiN82SPoR2sYyq/L6tWC9jJAPFom1LUfSHHZ0xRAS065wkQnyOI85BccnNMoNAfObHCPYDOyImEreHpwTWMJeIv8zoU9ywh4CZQm8RAiNT8bu8WWdPmlN3Xs3L1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759464931; c=relaxed/simple;
	bh=G85DL8v2r2+qHVH756TgppdFCEhhpAaDq1H+AtraN/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5jayI2ug2u/aj+hNmG4aQLujhB2eHNSK9qbXnJLQ5R5sxfSf/hDIWm1nt3L67UTZ53Du5YTAT3zy/TM/9LqKpcxoeecPTKzW3pp+N9vNnBDTiCQyFGyfoy3evcF8m5YB3l+mWnuysej5qqGPN9KmTCKJR3m6KjpLTf9QoRDRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OrCN+WPM; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-371e4858f74so19199371fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 21:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1759464927; x=1760069727; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjn8OgXaU5K1wFSTR6No5vtQmblOm/S8wCAtRj8MtV0=;
        b=OrCN+WPML97y8Ch1BX8kiVzC/lDLLL3ltmkkNAsgpGMu+C7x8XAsRjZKnQJgNNblxo
         oUmDv4x8+ToQ0TKpOmsmb19NmDEnxfKbBs5L/yvM4yEHB+4O/OtsKZTzX6+sxk0n0lTM
         5/+7DkWGl0RunYhTcudXc/+txvePhm3Y0yfffS3711BwO+mgdewyPdZWzE1OyNhd5fyx
         Nw013tumqTwjBSz1DNx07QZSVjvpExB0fCM5lb4SMbGgiluuHn/QhPEQh0F9s6PJsLvh
         +nz4rZX2ekefVEy2uaBfWh4YJ9vEm8MCPsYgCWCryBeMT6keNHEkh77q/Cy6QFAFuZys
         fCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759464927; x=1760069727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yjn8OgXaU5K1wFSTR6No5vtQmblOm/S8wCAtRj8MtV0=;
        b=qT7Y6rVMFVg5h4PnyUMrkuTfYbJ6YQsxMXiQCiMxD6qYLJS2nCpEsjUtYkGteH11LB
         +0KT9pee/r4+ONGI7UQhGU9wjH9ai5yGz4vYJEYULWcA8gcxfdhyOVOWvI6vaTyOtEyl
         BtLbwmHZDe7Te3r3IPkLARbieIJQZUqdzYy3jMTJJ8WTYFzMPfNKks6MerNovxVWKZse
         LQcj3ebVtCazhOLTyiAjYN5pF5t0wYNQMmcPSnSocrVQuamkEcGiojgVe9+Agu2iTu6v
         VtNn/TyssA5R9Fkc6lUesflmrrjGrE05t/czf8krUPlz0F0IayD3a7jEasQdycHd38Ez
         7sCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtQu61R5PMuUVWpYGIOrtzxHnar/2wCGycoy2oanUWouhbL3TYJLw3UBUaUmpx4368LmVwSKgyLfHY5q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjA69wd/hcVuQFZtGsiNVRtVzM2jjVAo36yDID9H2aRi0bcPa4
	+7F2y3W/GhiJ/W3h8OrRhWmpoGbyqUFxRDoLPQuNepPahHt+cG4WTU93Ngvnfl8Rvu8FTWXegPo
	RWw9687JLfH6YwJpa6pDg68I4Jm8hC2iRm7cpYWzUSA==
X-Gm-Gg: ASbGncvQ2ERLSqATavWl0xgEbTCk2CDA6myPQwkTxRt0MK9ldTRDoUz6mmqW38hvetJ
	iHq97MimYlQB0wJcdnnkYDsDvRwu/Vf0VU8pXHaVS5XKVai/UzBmiUTaAzwAOKYwYAllUtR4m8q
	5cQesm3S6xj7BtFiklIUOmfSH4iBusNSAi85q/YOTYNbC1NooFy4J6X2POEW0oScKQ72ipX3Q3L
	ToWHOetZRCM/jznp4sBmeN1yq2eBgzq
X-Google-Smtp-Source: AGHT+IHv8BGLAUrC90J0sK3NMTjOQ31CiSfYXIY0hQiE3tOeBGV6iKJ8BSFWipdy28vsBsFlMAlpKEvxI7FL6usEuyg=
X-Received: by 2002:a2e:be0f:0:b0:36b:2fab:fa6f with SMTP id
 38308e7fff4ca-373b8ca6ab8mr16482051fa.3.1759464926574; Thu, 02 Oct 2025
 21:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002060732.100213-1-apatel@ventanamicro.com>
 <2025100208-challenge-protrude-d6c3@gregkh> <CAK9=C2U9FV6crTL1G2X6tUM=RyRnPBm1dPeFc29n3vmrFTcfHw@mail.gmail.com>
 <2025100255-catcall-drinkable-23f5@gregkh> <30efd90b-ba9f-4291-b9a1-8739f1c5f24b@gmail.com>
In-Reply-To: <30efd90b-ba9f-4291-b9a1-8739f1c5f24b@gmail.com>
From: Anup Patel <apatel@ventanamicro.com>
Date: Fri, 3 Oct 2025 09:45:15 +0530
X-Gm-Features: AS18NWCV4kwPzdl3pVRzJuYKfCe4eENRKX3BJfzp0ornYWfxAm9sGwDdK5zEYFo
Message-ID: <CAK9=C2UPHf29DeLh6DikyLPAw-cQ+-FW8-uqzbjJWYaraJYO8w@mail.gmail.com>
Subject: Re: [PATCH 00/11] Linux RISC-V trace framework and drivers
To: Bo Gan <ganboing@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Ian Rogers <irogers@google.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Liang Kan <kan.liang@linux.intel.com>, 
	Mayuresh Chitale <mchitale@gmail.com>, Anup Patel <anup@brainfault.org>, 
	Atish Patra <atish.patra@linux.dev>, Andrew Jones <ajones@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, linux-riscv@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 2:13=E2=80=AFAM Bo Gan <ganboing@gmail.com> wrote:
>
> On 10/1/25 23:44, Greg KH wrote:
> > On Thu, Oct 02, 2025 at 12:09:23PM +0530, Anup Patel wrote:
> >> On Thu, Oct 2, 2025 at 11:56=E2=80=AFAM Greg KH <gregkh@linuxfoundatio=
n.org> wrote:
> >>>
> >>> On Thu, Oct 02, 2025 at 11:37:21AM +0530, Anup Patel wrote:
> >>>> This series adds initial support for RISC-V trace framework and driv=
ers.
> >>>> The RISC-V trace v1.0 specification is already ratified and can be f=
ound at:
> >>>> https://github.com/riscv-non-isa/e-trace-encap/releases/tag/v1.0.0-r=
atified
> >>>> https://github.com/riscv-non-isa/tg-nexus-trace/releases/tag/1.0_Rat=
ified
> >>>>
> >>>> The RISC-V trace framework and drivers are designed to be agnostic t=
o the
> >>>> underlying trace protocol hence both RISC-V E-trace and RISC-V N-tra=
ce should
> >>>> work fine. The discovery of trace protocl parameters are left to use=
r-space
> >>>> trace decoder.
> >>>>
> >>>> In ther future, there will be subsequent series adding:
> >>>> 1) Sysfs support
> >>>
> >>> why does "trace" need sysfs support?  No other cpu platform uses that
> >>> today, so why is a new user/kernel api needed?
> >>
> >> We saw trace support for other architectures (e.g. ARM coresight) allo=
wing
> >> trace start/stop through sysfs. If this is an obsolete or not preferre=
d approach
> >> then we will deprioritize and possibly never add it.
> >
> > Why is that needed for coresight and other arches do not need it?
> > Perhaps it should be deleted from that codebase instead?
> >
> > thanks,
> >
> > greg k-h
>
> Hi Greg,
>
> sysfs is helpful for controlling the trace if not utilized through perf
> framework. It can also be used by userspace to discover the topology of
> trace components and their capabilities. @Anup I assume this driver is
> designed with other sinks in mind (not just ramsink), so it can be used
> to emit trace to external probes, right?
>

The rvtrace driver framework is intended to support all types of trace
components and any topology between these components. The current
patchset only adds encoder and ramsink trace component drivers since
that is what we emulate in QEMU right now.

Regarding sysfs based tracing, the main use-case (like you mentioned)
is the enabling tracing when the sinks are external devices which capture
and store trace data somewhere outside. The perf based tracing is used
for hosted tracing where the ramsink stores trace data in ram and perf
tool captures it in the form of perf data.

Regards,
Anup

