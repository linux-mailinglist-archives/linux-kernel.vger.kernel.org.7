Return-Path: <linux-kernel+bounces-855669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA1FBE1EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 09:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7D6550249D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 07:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62B31F418D;
	Thu, 16 Oct 2025 07:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZEvjNos+"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FB2FDC56
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 07:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760599628; cv=none; b=tAwi3caZW3fifI39JwkZAMUZnsYs9lAfiywqYnYV/JHyspuGPKNH/QESrAZF7gPggj/LJEMlXYa1oJIwB5qhTUV7cgFQsZIwvuZzJ1L9QPXztUTQcdUXttpavI7uYzrC8UMfknn1EryTHli8x5LpqdSOmlnnZh12yEXPczp76UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760599628; c=relaxed/simple;
	bh=m8f4zg6xeLykgRE/o/fcAo7BMndyvXR2pwRMu1iNPYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dkkNimaTeuUFeXJDX6nbnd2TutBL7mHVkcUQ4ASIvlDZBcvPOTFUPa74uX17dMvwF27ZefUp2N9i8hmRrNEsz2jPTsexWMHLwsgkHSEifh8omYtCt1jciCacRNXWHv+vHftclWU5ZP/zwo7cj0uzClvVVH1stDNLLUMZD9/axpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZEvjNos+; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-375eff817a3so3905501fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 00:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1760599623; x=1761204423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQq6/C1Pq6mJ4glqaLVTk3qrn5Q0fPYc2F8kgQWkSeE=;
        b=ZEvjNos+VzpxgPgkgpMLaBOvAHFoI85SCbyqkzIOyHzCPAjaIP5DjwdL/XDtp+F1bw
         RWUMCvjHqwYdQlQSeCf2WM7dxTekKRuphfJFQd6lW9uDb8cQjIJpAAF03+r7xiW51QWP
         S93hlU5F/NrH77YHeJ4xt5l7rwzM7CJ5M59BBPQKdakciC8irCCPomAcOZyoOdevzIVH
         lkCP7jSpInP9eGpPLIL4HVHycqRdR+ld2CXs3iYXktUQTP/j4fVWzL52cj7EltwyZKu0
         QvUY2SbSlQz/Zy4uT/IRVRu9Etw0UrzeM1DehCFlnLLijjQG4TDVb/WgkGA70nL5zxX4
         EfcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760599623; x=1761204423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yQq6/C1Pq6mJ4glqaLVTk3qrn5Q0fPYc2F8kgQWkSeE=;
        b=YZOhgiNZ8GcnGb8IPb6z2uKfZpPuHTfGg2EwNtGZErJGxiob+i//NH2Pt9rT7qMUVD
         IeTetql64t+OFM7sFOiZRNXZASAqvBzVdDzzvb49OLKfxws3SiMQqg+OHK1ns71bt02u
         JC79KxqsJ227oODw/aDIbjWcsKcCfHRPqS1KiFakRpnw27HZZTU1bV7NdBqN2HwIzDN8
         Gbis/WcaZ04AIiIBkTOx2G6lgEzUbG5h74FBG8YmaDQ7/5j05DMKcG9BgiTvNWHrGqCX
         i3dChW/oFYdzEKE0qgWKDFQOteY9oI/TlYd78IDoITEY9TWIWMb/VU4/LBo6eWohsllS
         7FOg==
X-Gm-Message-State: AOJu0YzZg6kk8mrxuDrjZ+DhioeDHfCQ1F4xf/9oPNTnSxWzlZBM3uXn
	BZIWWUceDRXCUmP0B+KXbfcNsoOWdEOY1btvCe0fB5sOSpFE4ghFTeY/bDUIDbH4XIpnJakUI9D
	2+Z2/1iA3tkuicnkGat+7hixejJMal+uKWqYxgy5NRQ==
X-Gm-Gg: ASbGncvFCtckiBJGck+PMf4WiKK+NmsCjHWtjTdAFipztFSaTcZwBxGaNG2JyYB1VR7
	R2cTzCYyr6GOBNZ/p3i3I0V6X6ys2a5tCee7yYeXhgu2OIGI2KHS1NSUFdmOL8VDMYdXdcBEbzi
	n1XeqCXCrm5geDpHf1tPpe3tQQDh/+1oqvYuQcqJxiAv7+QZm2T8oFRaLyrU7iNSy5PI//+97w4
	2KlBmOeph3SsFJpumXzbpkdNKq44WtTjCJpc5/bLTKfxns0liGSWJSOLP0z+Hj15x6dgjWdj0mC
	XyhJAgsF/X84y9DvHxge8QpRdI9t
X-Google-Smtp-Source: AGHT+IFxVEtUUpG11oNuraoctZ6Hp9toOBZQ5cSCf6CoGhF26DBIDaJNAFHhYr6c+OhY2yFTtyl5cf+NwcVMvMDm3ZY=
X-Received: by 2002:a05:651c:150f:b0:372:4814:3021 with SMTP id
 38308e7fff4ca-37609cf7ce8mr82493341fa.15.1760599622974; Thu, 16 Oct 2025
 00:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905091139.110677-1-marco.crivellari@suse.com> <176055121712.1529254.17045515819433949532.b4-ty@google.com>
In-Reply-To: <176055121712.1529254.17045515819433949532.b4-ty@google.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Thu, 16 Oct 2025 09:26:52 +0200
X-Gm-Features: AS18NWB1N-m1AMT2106s1Zy205G2WITDT4RPCudOvUSqKgVI3x-P6_PBd_gcbJ4
Message-ID: <CAAofZF6hoDXVj_aSxkOwnPnxAOE1z8CsqokJWMrxwGd+RaOU7Q@mail.gmail.com>
Subject: Re: [PATCH 0/1] KVM: replace wq users and add WQ_PERCPU to
 alloc_workqueue() users
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 8:02=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
> [...]
>
> Applied to kvm-x86 generic, with a rewritten changelog to tailor it to KV=
M.
>
> Thanks!
>
> [1/1] KVM: Explicitly allocate/setup irqfd cleanup as per-CPU workqueue
>       https://github.com/kvm-x86/linux/commit/9259607ec710


Many thanks!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

