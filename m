Return-Path: <linux-kernel+bounces-704922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C60AEA33E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 18:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDE41881271
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jun 2025 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFD41FDA9E;
	Thu, 26 Jun 2025 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n3eEgvsE"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3928632C
	for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750954127; cv=none; b=RM2GLLRmG/ulP2eGxTOpBr3UH1ASTUccirgjMI/9cowml/g8zJxc/ACmsQbLCif/UTu4iyyWTagTj/7+ZfnBWc2VNCi+j4wBqv8autyki4Z3eEgs9atvCVtDdRbsBZOsDCdkBB0oRB8fwLijmHMrAGDpIiEsTN4ROQsg9xHnd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750954127; c=relaxed/simple;
	bh=25rcnHrGAd6jyBjad9VkriANs0eN1jgdnIwuMPPx2Z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p4KTUIeb+x3VwN3KIstdnC/IbSMkyJPzLn3GFNmYKD9SfbAC0eb8Rp14ioNNuZRnAvfryb7zLcxajoH9qcO2IU6u1Jd4BWKUxc8At8KO4ltOVIBstcljPOqlgH7Brpo6pPp70tewx0n4l1nZtG3OWH0ueR1fsnz4LsTJ/rtYzTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n3eEgvsE; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-609b169834cso13576a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jun 2025 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750954124; x=1751558924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfDY3q/RuaDFoPam7Snloe52g2QKGAUoB/zqQm94AJI=;
        b=n3eEgvsE7Yz33h1QXbsNYrqnFNlozC/Clb6jvOh137n5K4Z+9OchtITg7QdPz6ByOu
         YsR0wnFe5wfq2aWSob8A8NkPRLe3ajBA/38ECzgtyN6Fyx1plYn6BRXdEk25N9HQ0LLH
         QiuMlgGVKpso3uJnXOVxROCny8i5U2UVwK0KF3lfyFKsI4dzG/3Ve3YlANO60gSWHk2X
         9/9M8PFa8YdvwhDZ0unwAKrL2iGmwjg+FgltDTIlqrYHpeXqC7Y1N0IO6dLrx5db8LtX
         OjDpRrA82fOTaEQiO3NWNe4YHdYIWzkP3l21Rw2CMMQSm2x6GaB3trPo2kaRSTA2tTYS
         jBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750954124; x=1751558924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfDY3q/RuaDFoPam7Snloe52g2QKGAUoB/zqQm94AJI=;
        b=O18uL3fNoXllV43NG5eIaGu1D3Fj87E+s4DyqLsdzv+oKNWqt11sFAni6kKjUoOs5O
         fGl+51b1PZTXpXbuLDluFEa5zFcx2lKEQug1FEYcKT2CoJIHM2IbnuOpDRey8C22vNcl
         uTT5zk1xoSSLKaNdJPD58NT/v1MtnvQY/Z8W5LA8MsiQZ0su+PyNXClHqBV75nyzYASB
         LR2aCrn9txgv6sj0Wfcg2ujj6O9Pg5sqvlXCj1aHJvoEqz/7kMkQPPISmbFhAeNYOLFT
         sNOuLLxyiqWdlF1ONMKpEX1Tt+F8mOt/UmYcP6MVAq+zJGP/0QWNBHk2NEjlr2jliJKL
         Ft2g==
X-Forwarded-Encrypted: i=1; AJvYcCUtxYmFk4511k+U+lvYglGpQqdMilSuTydul6H3noEoERktO2GhT4uqdZSREjUXOFuu4mf1P6lchYUPukA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhVmWEP19qY40wT5T+8gkZXNjXhbdG0Ab88LIcv0PmTYrwT0tI
	/7IPnko3yGHHzt+A9tX/yaxB5DNFRKrKW4XH+4JlRnnYcYhj+WIfP2FQq174o34TxwdgluUE3zY
	fHJYCqaiVVst7O2kUY/dOim2j3FLoxs/GPEvxG6Sh
X-Gm-Gg: ASbGncuY8ascfFz7ijIZ1M+MGFlLEjtLFlyZpWwk5MI7EMyVWDb4U31ChFukQgNK4W4
	Yc0e0JUzowClF+ExeVtwurX136i4U2Ct9zsmvj7KiS4pT7F074rvLfQtTeM6cNZeLiNeBmBjEUr
	r6gd9Am4g0Di28JVhQ8uoEVwoSHPbOjjSUlpPcM43hyY0=
X-Google-Smtp-Source: AGHT+IE720RjzTvcYQIe5ayorOJ+4B+pX+uR5Q71uQgifMD5UGWiBsgqrg4xzUqgd96gIG4zVplUEEf/vAhAr1oDEas=
X-Received: by 2002:a05:6402:2888:b0:609:b4b1:514b with SMTP id
 4fb4d7f45d1cf-60c865db901mr295a12.3.1750954123712; Thu, 26 Jun 2025 09:08:43
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626125720.3132623-1-alexandre.chartre@oracle.com> <aF1S2EIJWN47zLDG@google.com>
In-Reply-To: <aF1S2EIJWN47zLDG@google.com>
From: Jim Mattson <jmattson@google.com>
Date: Thu, 26 Jun 2025 09:08:32 -0700
X-Gm-Features: Ac12FXxI4E7VzrdrXP4rTj-hWh_ZYuicrnJPU7mpg7k0GFjNvJZ8JcRsUVG1DUM
Message-ID: <CALMp9eRjDczhSirSismObZnzimxq4m+3s6Ka7OxwPj5Qj6X=BA@mail.gmail.com>
Subject: Re: [PATCH] kvm/x86: ARCH_CAPABILITIES should not be advertised on AMD
To: Sean Christopherson <seanjc@google.com>
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, pbonzini@redhat.com, xiaoyao.li@intel.com, 
	x86@kernel.org, konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 7:02=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> I don't necessarily disagree about emulating ARCH_CAPABILITIES being poin=
tless,
> but Paolo's point about not changing ABI for existing setups still stands=
.  This
> has been KVM's behavior for 6 years (since commit 0cf9135b773b ("KVM: x86=
: Emulate
> MSR_IA32_ARCH_CAPABILITIES on AMD hosts"); 7 years, if we go back to when=
 KVM
> enumerated support without emulating the MSR (commit 1eaafe91a0df ("kvm: =
x86:
> IA32_ARCH_CAPABILITIES is always supported").

FWIW, commit 1eaafe91a0df ("kvm: x86: IA32_ARCH_CAPABILITIES is always
supported") was intended to deal with live migration issues across
Intel microarchitectures. I probably just forgot about AMD at the
time, since it wasn't on my radar. I blew it. :(

