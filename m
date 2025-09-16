Return-Path: <linux-kernel+bounces-817947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C2B58961
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 768341B25F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC9520CCE4;
	Tue, 16 Sep 2025 00:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fEMCeB70"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75691D63F5
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982515; cv=none; b=naDOYXFED2iNoa6MtMeiVyXkt581c5217XII3ms0rxzvEZvKSrdou5tS2GVbOKwWVCNnxRvl+g2JziwpTdt2p0wwMaaoteDhkhEgt+2u0VhLDEtxLpxQ2NO0F/ludbDo5YXdnBA9QF7ccljzW/fCn84xW2zH4NmCqrWX8zPGI+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982515; c=relaxed/simple;
	bh=JX0UcQuHupmId46IJr43SiaDoDTDb3nm36tgidFfH8Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mBHmKqEHAxpKXI6v/jeIyMVuFuzkV/8mB0WumNlNpOrf6w5fJeEcpmo5SYI/A364yV2vkWHsEtKmEq6c0fFVZ3zY1zoudK9XwtQaZJIq/JNVkVnn+5FjTHSEbPHgqGrQmqGwx6LkQJ+LfpZMygF2EcLuU+N7VJmA57Y4GFISCiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fEMCeB70; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-32e0b001505so2297134a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757982513; x=1758587313; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh3c25Knpj/n+HZod2yW+2iuXH9YBdAZGgMPVRPQco4=;
        b=fEMCeB709QvPayI/bYcFYnrPMx8O/Euk5Y/RdbD9mbDR8d2TSPdEFJlhXyRnHLzHAC
         u7pGtJhA+rTJweo5pZx0wT4Tah+kmap6tYEyhjWk8ERMqmmvEFpe63H5yPdJyf1nlBmv
         k1vERCFkfVZl7jwZ1fTbbT6nJ16Tx8WyZYDca9lTs5gbRSJ1qsTUJKfz17rWftSpP6iW
         po/3CSNUKX5CsUODNhTdr3TOqP+ik35Xj2oR/9Y5Ndmm4pPjYgab2T2QpVCx3aO9jxzo
         LD8PnFNPpOHfweSAYmqKtWtgy4coBv2nahSU3TZPQIyeXFTx/58QuaoY/UgD/al1Gij2
         haIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982513; x=1758587313;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh3c25Knpj/n+HZod2yW+2iuXH9YBdAZGgMPVRPQco4=;
        b=ChgWg9VgRODC8ZI6pNTAmBS7S/hQHRqNuUVh/ja2B8g7h9Hmc3Eam92aizhkUPnRxa
         b198U96pBCB6usqaHR0zydYoNaLVen0aHnMEpszvVqz/jMKcde643M5rPmGcc32kJj64
         h8QM6PuNOVrNWsr3WRRJUXZRRv7g2skvkKM5kEJMaVtPb3zXqEFDoOB5KX6uBMaITSDr
         io1gxrGJF6aychGE8WWYvvd4H3EstfFCRkkJ3BfKOCAQdgHjrs+2scNbPw+kzg7Pbsw8
         VDfrqf7vLb+Xh+qic/E+BHkILIjh8ieh+R3YT0o04ra7M2nXZsOGKeimg7gKtfMIKEdS
         Cmaw==
X-Forwarded-Encrypted: i=1; AJvYcCWplYrA8hCqFMZ1SHzwGiQ920SK03rqTldkRA4/252yqhao+rwQR7H3X586xLJ1IQWuiYQr3X96bO/+3y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVOg0/QF5xcO5SMGjLaNnPIt2xJi6DNyL5oerKPdTZIq3YagOj
	5YuReIJVqxrpkhwY1bzQbEnnukwYjmHZFpx+ZOeReW5hOml9PFYQ1S85HW0DMkgxn58RvBhkuvS
	mG/tiIw==
X-Google-Smtp-Source: AGHT+IHlqPB2LQWi0UOxXLJVTLGdTA8AQIKB/YZM3ckd+1Eu1ThWb/99D6oOfDRWrjfnum2LfoUj4QLmLVg=
X-Received: from pjbsx6.prod.google.com ([2002:a17:90b:2cc6:b0:32e:613f:b8d2])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5866:b0:327:734a:ae7a
 with SMTP id 98e67ed59e1d1-32de4ed232cmr15805386a91.11.1757982513133; Mon, 15
 Sep 2025 17:28:33 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:25:47 -0700
In-Reply-To: <20250821214209.3463350-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821214209.3463350-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <175798180645.621821.15899499815524721468.b4-ty@google.com>
Subject: Re: [PATCH 0/3] KVM: x86: Clean up lowest priority IRQ code
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, 21 Aug 2025 14:42:06 -0700, Sean Christopherson wrote:
> Move some local APIC specific code into lapic.c that has no business being
> exposed outside of local APIC emulation.   The lowest priority vector
> hashing code in particular is *very* specific to lapic.c internals, but
> that's not at all obvious from the globally-visible symbols.
> 
> Sean Christopherson (3):
>   KVM: x86: Move kvm_irq_delivery_to_apic() from irq.c to lapic.c
>   KVM: x86: Make "lowest priority" helpers local to lapic.c
>   KVM: x86: Move vector_hashing into lapic.c
> 
> [...]

Applied to kvm-x86 misc, thanks!

[1/3] KVM: x86: Move kvm_irq_delivery_to_apic() from irq.c to lapic.c
      https://github.com/kvm-x86/linux/commit/cbf5d9457462
[2/3] KVM: x86: Make "lowest priority" helpers local to lapic.c
      https://github.com/kvm-x86/linux/commit/73473f31a4bf
[3/3] KVM: x86: Move vector_hashing into lapic.c
      https://github.com/kvm-x86/linux/commit/aac057dd6231

--
https://github.com/kvm-x86/linux/tree/next

