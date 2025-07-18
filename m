Return-Path: <linux-kernel+bounces-737051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A82DB0A70C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DEF0A80B1C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A702DCBF7;
	Fri, 18 Jul 2025 15:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1q5TgRO3"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4065184A2B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852178; cv=none; b=VIUCfL75X70fyTUe8eF4Cg0V+tC/0NEM3B1DS6Obd+Am5P0kjqlXI4CyO/a1CVf3jyhp5YtEPRO3d/gFSzE9X06fZs+D6/0Rva2B7D6py9ESIU3EB+Y4tnvqes8VGBQGsZAGyicl8AxfrBMI8M86+RAzujEQ+OiUOUkI0nXteAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852178; c=relaxed/simple;
	bh=h7q6reLOVheGsZaNKSwl4n0WAcp7uhc0p7859t2Tq2Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ecjpV9Qo+MNn58T0Belz0HfSGsyhO/HyE/ZeUdcR6azmA73VAaJ3nJnKhr9Hm04+lpkZ9ajAfTEGbVny23fvXhc+jrC9gAvi31p2tv6fzfNBLhxnch3EhlscRWStfBvbW5P/3Wi4Ip0LPEMgqeIcPuIudfD/U7T1q36iz+LOTlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1q5TgRO3; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3141f9ce4e2so3264300a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752852176; x=1753456976; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gk7HrZFZ4ah7oZlUSyYLVPKufe4IyNCvV96cxCrMuk=;
        b=1q5TgRO36rLGIGhsDQpu4PeQCFfRvSL8Vx7elBvddH1ZgvzDPld+dFQR+76gDWBP6U
         3HnsSUPbdKx30e1OYt0ENDZO73mD6zah0o98LVb4fRpbpw+NrsYxNw1Crdj04VvsvG1+
         g6JuJetfxuC1+7P0Ufw7in4qwm2kxnlsN67UPtwIOhwtRmCeIoT8QrPYuTactzluuzy9
         R6b/dv7L3v8PCGM/sNC0TPcFXfnBH/M872LmQw1N5rk8Ix9GpbHkQhzBU1/6/vbJPzF/
         liPButKa66rb8KfGHmirI5A7nOpdo6nvPFRM7rAM7MMtX/lRHa75ItHOthTzAbUs9fuZ
         5YXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752852176; x=1753456976;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gk7HrZFZ4ah7oZlUSyYLVPKufe4IyNCvV96cxCrMuk=;
        b=UXFe6Sm7JNcIZIagdHY+LaUmy+XTPauD2u27AhKLrGOcP2PKD+Vtb5/Igv7Rw2Cu+2
         fKv8xUEM6Its1hA5/g7VzOW0tOvHUrTRp2OzcjsJV9X38fr69FOH+qUcHFvXv8ZEXlsZ
         pkUqF/6qPYNqXPdawzXs59I+mhnKhc7N7BEzGvDWModkRGyxn8/id/06gP3O5YBDhJfT
         Z8KMYA38CMCpWRmfU+Qer0hlihdzu38ZVHNnOlJsBpxBaj+ZGGsgCX/v80deCIlIOPBC
         yp6GyZc+MPfBOobO3FsNa+KhlWJxY3tfmZzaokWdQoZRp2SRLtovUzOwZvf9K3dilAG7
         kH8w==
X-Forwarded-Encrypted: i=1; AJvYcCXPDeG0PLaQv5+AFxqrBNz+wiWgsAXp/hVyrc5KULUx39U//QvEfQrfbsMWK3P0S88YPVZCeuuYXUmesOo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC3KDP7Jl8eVyjQYL4OSJJzrFqCIkhXgZOGszZgWC+3vtVjbFR
	Ydzfcq19wNuYnwo8i2d11uZI4xO9SogTLpUxqZtCUsKwd+1l6QrvLFI2QVGqc9Bon1CTgOI3J0l
	eKEAnSA==
X-Google-Smtp-Source: AGHT+IHemYLkPGfTNf/KBJ684XD0OoZDbY+eeRoJgnLdcVPIkiZ0MwG35e6cDv98jF7HooJYupn2MwsKGDw=
X-Received: from pjbsu4.prod.google.com ([2002:a17:90b:5344:b0:312:dbc:f731])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f91:b0:311:ea13:2e70
 with SMTP id 98e67ed59e1d1-31c9f3c612fmr17703545a91.14.1752852176493; Fri, 18
 Jul 2025 08:22:56 -0700 (PDT)
Date: Fri, 18 Jul 2025 08:22:54 -0700
In-Reply-To: <aHplCKOxhBL0O4xr@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250718062429.238723-1-lulu@redhat.com> <CACGkMEv0yHC7P1CLeB8A1VumWtTF4Bw4eY2_njnPMwT75-EJkg@mail.gmail.com>
 <aHopXN73dHW/uKaT@intel.com> <CACGkMEvNaKgF7bOPUahaYMi6n2vijAXwFvAhQ22LecZGSC-_bg@mail.gmail.com>
 <aHo7vRrul0aQqrpK@intel.com> <aHpTuFweA5YFskuC@google.com> <aHplCKOxhBL0O4xr@intel.com>
Message-ID: <aHpmzhaU5JNqhp75@google.com>
Subject: Re: [PATCH v1] kvm: x86: implement PV send_IPI method
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, "Kirill A. Shutemov" <kas@kernel.org>, "Xin Li (Intel)" <xin@zytor.com>, 
	Rik van Riel <riel@surriel.com>, "Ahmed S. Darwish" <darwi@linutronix.de>, 
	"open list:KVM PARAVIRT (KVM/paravirt)" <kvm@vger.kernel.org>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 18, 2025, Chao Gao wrote:
> >> >> >> From: Jason Wang <jasowang@redhat.com>
> >If xAPIC vs. x2APIC is stable when
> >kvm_setup_pv_ipi() runs, maybe key off of that?
> 
> But the guest doesn't know if APICv is enabled or even IPI virtualization
> is enabled.

Oh yeah, duh.  Given that KVM emulates x2APIC irrespective of hardware support,
and that Linux leans heavily towards x2APIC (thanks MMIO stale data!), my vote
is to leave things as they are.

