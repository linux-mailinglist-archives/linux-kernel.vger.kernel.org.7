Return-Path: <linux-kernel+bounces-773834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B01B2AB52
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 16:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 316E95A3C32
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FB135A2B3;
	Mon, 18 Aug 2025 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RtYxkDl2"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E3335A2A7
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 14:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755527071; cv=none; b=SGzPt0zPwerZ/0ofLaGHOoe8dFFeEz4EfmnsrcHOzHzl/upAeZayG74zAQHmVDCENrb1VQXnTRDNF/lxMTgtKPIjmT5cdxos4ukafAz7/Zfb1uPJxU+9sEMw1UqAvg8HZSctpr3DXT1GlR8RyhTYNjpVvPSje6P9jmUjqC0FOkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755527071; c=relaxed/simple;
	bh=/AB53n3mNUozDqKgqB2RQVl6CBqb8gN2SbGdPDqdb0Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LhRl2CsW3ySH5OyG4rlEsnk3Szd/ofGElQY2CE00DtzROH0oGH6YrdJQ9xaNSOS0KMZ9tadP5ytM7rxcn30q3CmSsDr8B+Lo5FivkSBSg+k6+7nSiFia+70AJvnrUloV5HX4Chimz4BCMO4BjR9UuFFja9PYPk5CdVMgbUGwwBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RtYxkDl2; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32326e2f184so7950273a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 07:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755527069; x=1756131869; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wGqHpggRQDFEy0YzoEr31QdRXGiwtQXJ5jTbO/aTvh4=;
        b=RtYxkDl2ASAZqWNobwcIWYfN6iVk0qu5oAOaNKDmqffcslT7sbdL1ZvylFWg7sC4MR
         EIjC5zdfYfBFyviBlHPg+TuI9nbNOkbIZ37lqTmOv1FHme4AcplPxUvtPz/Nyk8OqEoW
         4JLfv2n7AtgIzDqYqS5nN3D+wtEGybRmM9aGlfW1KYjVOhLjigqIDMThJWpsfiB65kOD
         9YdfGj9/tx36VwjeMfkU+WJhIVjKKnxg2tsZVggSrIHZ+ijqpKg04utwZsBE/M23HBDK
         rnExIDFqTV8qWu7Ga2Spl8cZhjyBP0zwAHcR11W4nuwVRx9cPRTaTBI+nMY0vfz5WyBZ
         uE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755527069; x=1756131869;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGqHpggRQDFEy0YzoEr31QdRXGiwtQXJ5jTbO/aTvh4=;
        b=ZALCMS45eg9hvtm6ubbDwzC1idQT3npwz7Of7X9nmgY/S7V+t7XUpKpIHiMu+xS7r7
         yomKQKmnICBSOs8MB54QuP70Q7DV89PHNllhRrHYHYimbH2IgXdEQ8TA1yeIFWuQ77pD
         O+yVBv/hlIMtSQdZ9qVmkrXU0gzLN1AAjoTGBI2i0T9Y/da6o8rVbYHxQirJGjGr/TcH
         eJKkROe0qXX6CP1PMCIlJ/WT219YFJk9LoNNkZ6NnouTi9vB70VydhMXB0P4TdbHuCPS
         c3vSJ/GK9wu5oziw7sPyUFlLfj6btRcolMEp9wBu6ZAHuOglkNis+g/7hxEPpERKhDrr
         p4gw==
X-Forwarded-Encrypted: i=1; AJvYcCWFs52a1736KUPzp9n0Rpyd9m0/MosVayb1NRK81bN6LQEKnIDKIM97eg11fXP76szuCWAbV7KpxkW9Czg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC968m8NMuZRJv2kBMKmi/X7VObyDNtX73Yef3zzWK0awoS+20
	qJlprDDcTpt6bjepauIQMO8wL/x32xSx+GUU2fw4uSGioXFP3DBt1w5JcfXOtKywhlwu3fgdvwN
	CUaAsJA==
X-Google-Smtp-Source: AGHT+IG9+Y4yqHl8NBEeSC55tBHswginuQnM6TibOLzYjcVwx6yMS5FEQ+Rw5bYAUNpa2g6k1GuxKoU0+t0=
X-Received: from pjx3.prod.google.com ([2002:a17:90b:5683:b0:313:551:ac2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a09:b0:321:c2fb:bcca
 with SMTP id 98e67ed59e1d1-32341df9013mr16341295a91.3.1755527069223; Mon, 18
 Aug 2025 07:24:29 -0700 (PDT)
Date: Mon, 18 Aug 2025 07:24:26 -0700
In-Reply-To: <20250816084218.GAaKBEaukeGa6b5UBj@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250723183426.GA1158000@yaz-khff2.amd.com> <27E487FE-EC8D-42AC-B259-F8A18776C802@alien8.de>
 <aIKehTDgP-Nu36ol@google.com> <3cc16f7d-c650-43f2-b0ca-d99c427cd69b@amd.com>
 <aIKmeclza-9TDe4U@google.com> <20250725065009.GAaIMpIVgAKi0kMBVv@renoirsky.local>
 <aJ-pJvrPyHyPI0qS@google.com> <20250815220436.GJaJ-u9FUVTmjyaaua@fat_crate.local>
 <aJ-5XDXp1CxKB_7J@google.com> <20250816084218.GAaKBEaukeGa6b5UBj@fat_crate.local>
Message-ID: <aKM3moQgdlqr6qIy@google.com>
Subject: Re: [PATCH] x86/CPU/AMD: Ignore invalid reset reason value
From: Sean Christopherson <seanjc@google.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Mario Limonciello <mario.limonciello@amd.com>, Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Libing He <libhe@redhat.com>, 
	David Arcari <darcari@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Sat, Aug 16, 2025, Borislav Petkov wrote:
> On Fri, Aug 15, 2025 at 03:49:00PM -0700, Sean Christopherson wrote:
> > Which is what I'm suggesting here.  If an MMIO load reads back -1u, then
> > it's a darn good signal that FCH_PM_S5_RESET_STATUS is either unsupported or
> > malfunctioning.  I don't see any reason to drag HYPERVISOR into the mess.
> 
> Ok, let's play through how you suggest it:
> 
> We do not check HYPERVISOR.
> 
> The machine boots on *some* guest and it says:
> 
> "x86/amd: Previous system reset reason [0x1]: "power button was pressed for 4 seconds".
> 
> If this were:
> 
> * a normal KVM guest: the machine is straight lying here. There's no power
> button.
> 
> * "to improve system stability/uptime, e.g. restart the VM if the kernel
> crashes as opposed to rebooting the entire host" - this is basically telling
> the guest owner that the *host* got rebooted. I'm not sure you want to tell
> that to guest owners if you're a cloud vendor.

Most definitely not if the guest owner and host owner are not one and the same.
The example use case is where the platform owner is running one of _their_ kernels
in a VM, in which case that kernel probably does want to know why the platform
reboot.

> * If this guest type is lying: same issue as above.
> 
> So, what guarantees that hypervisors will adhere to the spec and DTRT here?

The same thing that guarantees hardware vendors adhere to specs: the desire to
get paid.

> Hell, hypervisors don't even care about that probably because they don't know
> yet that this thing exists or if they do, they *definitely* want to return an
> error here and not disclose to guest owners why they got rebooted.
> 
> So the only thing that is workable here is if all hypervisors either return an
> error value we do handle or they implement this properly.

And QEMU did return an error value, 0xffffffff, a.k.a. PCI Master Abort / PCIe
Unsupported Request.  I would be amazed if any real world, general purpose VMM
did anything else for an MMIO access to an unknown/unsupported range.

> And because I don't trust hypervisors to do this right because, as I said,
> there needs to be a concentrated effort to support it - otherwise no one
> cares, the *least* we can do here is:
> 
>                 if (s5_reset_reason_txt[i]) {
>                         pr_info("x86/amd: Previous system reset reason [0x%08lx]: %s%s\n",
>                                 value, s5_reset_reason_txt[i], 
>                                 (cpu_feature_enabled(X86_FEATURE_HYPERVISOR) ? " - unreliable: running on a HV" : ""));
>                 }

Huh?  Handle a read of all 0xffs as proposed in this patch, and this is unnecessary.

