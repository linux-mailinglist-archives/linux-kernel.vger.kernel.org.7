Return-Path: <linux-kernel+bounces-852209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04348BD8709
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:31:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C693188A054
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 09:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19752DCF6B;
	Tue, 14 Oct 2025 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zqKcNixX"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824032AEF5
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 09:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760434302; cv=none; b=f6Ow73PJFsvIYJQ41fPLuMSmihU6Zz2gpGZ+A/zx0rqOYXjrkTK3eOtofn2wmWUjjPsRR0QQ2zCSTJla9djrY6ISLQ773r4P4HLhKKjc7HxovIhqRGiQ8TpyV8qyPe9ZLngsOGnGMdXZdiAABYRoAIO2i6t+p5+NvTCFaMZpnXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760434302; c=relaxed/simple;
	bh=8cvKIarSkBijJe+UuuzaIt5vygtV6rMdWJ+oHNw2EJI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WHh6rWaIHfPZBBBTSyJfpg+DcxZoxAt3sdJ1LNf6pAJIYkbq+Hb4nFQKOY9FoIpnA1KkZG4YDYdOXzlMfohRZt25K8+Km88+6JuUhY5Gku0vm6EQNPcydQKw0uK7v7UHOsrkdy9wFo/JeqCwGs87ruooU3JFW/QIgDir40xWy8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zqKcNixX; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-635380a4a67so6197210d50.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760434299; x=1761039099; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8cvKIarSkBijJe+UuuzaIt5vygtV6rMdWJ+oHNw2EJI=;
        b=zqKcNixXy2zj19jwqD2ac91sF9hgouUhrnx0xNDue8Alffa8X9+A1hM7H4UIhNbF2X
         mha6CJ6z0uejcims8dL2SrOdwJhRqaJ2EW1XdJwfdOZxCSGNC+YzHJsKBTqLP4UfMEP3
         BcXZd0Aa/n4nYBk530lS7aLQjk8+MJhUvEWGeGVk2AW4/625hSdpWRX22TvPLbLTe27K
         n1Nhwf4/00sOQf6NqtX4siZud1Ulm+YZKqP4xrWi+3ouqg4u+O6lJ1Ocee4ZynvFFPR+
         ps/92Tn063ZP1cZjukGqbcME91nlJ2FEjwX1q+lEUB3BlhGLQQz3NDTLV2LTgto/9lqq
         E9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760434299; x=1761039099;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8cvKIarSkBijJe+UuuzaIt5vygtV6rMdWJ+oHNw2EJI=;
        b=E9k8tKjnhk/wMFiAUUqyziNJaTTtK0Csx8A2Y6tPslTOI/PJk8oPHAXYAwXsh5YUuV
         vSsNqpRr3Va7/PllIQ6eLMuiBdNBI5h1+Su22NKf4isM7WNEH16e+B3fxlpd37DxdzsE
         uH/P5y7gPozmajvsSUFiG2DY5GYrNFn10z2AW3xdGglbeUUmvIiCwyVPtS5dFTr3ffFn
         vMGj8BIrpCivIMfeyevmUJKAny4Ni0ewBzfTau8wGBxp1NaE62qxE8qmJKNVjqFB52Qo
         TcvSAo24WWSJm4OwtCsYG7d15NYoe1XGVUrf+pdsg4A8yzJO5wUK12F/UMdPOXamIxDC
         a5IQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBs9tolDex963B/eNZ+095C+TXKdg4s6LVk4LhTY3lZMNXsXhpfK3Qyea9AcRXSKl/0EHRVp99/840tZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJfxXJy4wrhWEMRRsEOzfYInMKW0lj/k6Cm4UfAlr5x/BXxDh7
	k//By05veeO7PBfS9zb3+G2HVVHqd9RGhmo+Hw/1FSditTx9TdrRgaJtqPB0O4SHDAWPigwJohh
	N5MGDs3fiUnPh7HFUxl23YQZ2wpAPfEXXM4WynbxdwQ==
X-Gm-Gg: ASbGncs4OsH2wAwxESHeBq0ZiDm3HDj4fvvswBnfCm2yq+Sb7xh0mqgVOL0fs5gIcCX
	9pPpepmXOWvOwCFF1taBSEdbXqQK5thZpEVgpo9WWvJlQQeVFTZY921DMrJLEmaB14ntu/wL7Mw
	mn9zYN8UsSUJCWd41SmC9UE6oTE19N/8+JqtZvNYaBuoncds+ABCqqMXS8z+ikQD8jf98fQAA7C
	A2/dQ6utsdbrEmZDNe0MZN7llH2CxQ=
X-Google-Smtp-Source: AGHT+IGpfT1cl8woYMQjpU4Hfvq9tR+YuLgZGpBnk++5ZO2YaY91O5P1sxo8/L5tsI4hAc1GBqgPgrvYoCRQYmV9EAA=
X-Received: by 2002:a53:a146:0:b0:630:e716:e358 with SMTP id
 956f58d0204a3-63ccb854dd7mr15136764d50.14.1760434299398; Tue, 14 Oct 2025
 02:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008201955.3919537-1-salil.mehta@opnsrc.net>
 <86v7koxk1z.wl-maz@kernel.org> <CAFEAcA8=yhQ-ygoA-fqxzwg69OkdW2nBM0O9X3Lmww4eXuVMWA@mail.gmail.com>
 <867bwzxe9r.wl-maz@kernel.org> <CAFEAcA8FhgcaM_OsHKB3+3Z7B_oZJqU4LHX_j9p-ZQrHfWGX7g@mail.gmail.com>
 <CAJ7pxebGOj5Z1iW6VPjzj73eY1hZFjS5uXMkee8XCm09DtFcKQ@mail.gmail.com>
In-Reply-To: <CAJ7pxebGOj5Z1iW6VPjzj73eY1hZFjS5uXMkee8XCm09DtFcKQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Oct 2025 10:31:28 +0100
X-Gm-Features: AS18NWAJX94qy4FaMKCiJ2t5Jr7n_3WauLvwbqWyfMVGv2EBw5_zyhfXEJWTZIA
Message-ID: <CAFEAcA8VL4wE2w9PegPD_AVSKCZzzzx-jFru7dDOq4Tz5xs76A@mail.gmail.com>
Subject: Re: [RFC PATCH] KVM: arm64: vgic-v3: Cache ICC_CTLR_EL1 and allow
 lockless read when ready
To: Salil Mehta <salil.mehta@opnsrc.net>
Cc: Marc Zyngier <maz@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, salil.mehta@huawei.com, 
	jonathan.cameron@huawei.com, will@kernel.org, catalin.marinas@arm.com, 
	mark.rutland@arm.com, james.morse@arm.com, sudeep.holla@arm.com, 
	lpieralisi@kernel.org, jean-philippe@linaro.org, tglx@linutronix.de, 
	oliver.upton@linux.dev, richard.henderson@linaro.org, andrew.jones@linux.dev, 
	mst@redhat.com, david@redhat.com, philmd@linaro.org, ardb@kernel.org, 
	borntraeger@linux.ibm.com, alex.bennee@linaro.org, gustavo.romero@linaro.org, 
	npiggin@gmail.com, linux@armlinux.org.uk, karl.heubaum@oracle.com, 
	miguel.luis@oracle.com, darren@os.amperecomputing.com, 
	ilkka@os.amperecomputing.com, vishnu@os.amperecomputing.com, 
	gankulkarni@os.amperecomputing.com, wangyanan55@huawei.com, 
	wangzhou1@hisilicon.com, linuxarm@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Oct 2025 at 04:02, Salil Mehta <salil.mehta@opnsrc.net> wrote:
> On Mon, Oct 13, 2025 at 4:48=E2=80=AFPM Peter Maydell <peter.maydell@lina=
ro.org> wrote:
> > That said, QEMU's current code for this could be refactored
> > to avoid the reset-time read of ICC_CTLR_EL1 from the kernel.
> > We do this so we can set the userspace struct field for this
> > register to the right value. But we could ask the kernel for
> > that value once on VM startup since it's not going to change mid-run.
> >
> > That would bring ICC_CTLR_EL1 into line with the other cpuif
> > registers, where QEMU assumes it knows what the kernel's
> > reset value of them is (mostly "0") and doesn't bother to ask.
> > This is different from how we handle ONE_REG sysregs, where
> > I'm pretty sure we do ask the kernel the value of all of them
> > on a vcpu reset. (And then write the values back again, which
> > is a bit silly but nobody's ever said it was a performance
> > problem for them :-))
>
>
> This is effectively what the mentioned patch in the commit-log is doing.
> Pasting here again:
>
> https://lore.kernel.org/qemu-devel/20251001010127.3092631-22-salil.mehta@=
opnsrc.net/

No, that is not what I have in mind. What I mean is that
we can just read the ICC_CTLR_EL1 value once on startup
(in our realize method, I think) and then use that value in
reset. That should not require any of that machinery to pause
the VM and keep retrying.

-- PMM

