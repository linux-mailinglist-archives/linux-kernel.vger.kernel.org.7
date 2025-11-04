Return-Path: <linux-kernel+bounces-885272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DBBC326DC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC514460CA8
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC1733C523;
	Tue,  4 Nov 2025 17:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y+n7BbBg"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C6F265CAD
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278448; cv=none; b=oIipUShL5wJoO3TKiLiuV6NLZiJahZTYIzxT9SVQcIi25YQ9Q6Pb695FwDMvu95GW+SNvKvFIzDRERnn+v5kKge9Q835dZgsFhZOgw7tCTSSjP7GF1zRrG1M8Prec5DSbKyh9RXRy+6ZxtAtUIWBOk0BYMsa2j+/HSgFgAqeS24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278448; c=relaxed/simple;
	bh=dhwqrT6S/LS4zUkJRE8UP3Y4qubDSuf7ZUCumB8j2To=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OaWSczf8vdZYZhtqZsr0wzAO89OlayFqTs1XEmRjna4Dk0JFdVS/UE7MJVywImg/hhbertapzUOPJwToniTbahQPa/9gh5QciHcSI3eNrkI67AM7cVT06IIG9l8HQDFcGnS7ebFw7NrvhKqJ0nToo1X7YNRO/3RCdS7xYXU5mKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y+n7BbBg; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-78117fbda6eso5419191b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278446; x=1762883246; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+9Rq6oMw8Rb0BnOC/V8XXpWWLQcsgDUDwspc39yYxKY=;
        b=y+n7BbBg2qwGkl7AZ3BxI/kHTRyi6Vx6WbpLjEMWlQ3JBa8mHqYgVGJdcRL266TLQ8
         03OMJ3SE1gTvBs3IDPqy8rNcOCIeJHVJNaZiBYX61QOZlNGxm6NUQ/V7R81mKGP/A9xo
         fvW+ZI12TeF8qIs9OtWomhtjT9pxMwcq+Ip6DEhgzoYg8R+anCCB8VJQ8nv6mcpdBleP
         j+suV617Je9w/V7XaC1eYHWSFYKpwNOXqeVcuY0JVaRjqg6OzyOBrRVNKS/BvdvWAOXp
         IIyZronM/6YszYTtnh/xTLJg1wFA096GGrGJxWuUPot/KeY7ajpjN0KJ0CIs9qjV503r
         rniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278446; x=1762883246;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9Rq6oMw8Rb0BnOC/V8XXpWWLQcsgDUDwspc39yYxKY=;
        b=BQm9qbNkj3icojDMvbNRhN+wIiUnThy2Z4Gz4qQGAo9qYQBe+qaW8SI1EgNxsuwJe/
         KixdXLBsgosATBQAn49wP97EvOkVDkUk1KTKFMouyQoFTGKr7lxwOcwsebby3Ina8tGB
         V+yH01X0AAchYEkUYGKfzdPzq2MnDAMAwX3qh0yq9zhpicO5VoloDMJHlczA2n+Ul60D
         wka36AtguVouOxroN7I12zVjO64Ssv6Acm6qiMw7ejBO37uvqAihmzn2atIID78qIKVN
         V4LN7M5HKVI4fW4fXs2VHfd6EgGn4/ZN+SpdCCmr5zMliDorSin66Npj4lcJxLOb9pVt
         O+dg==
X-Forwarded-Encrypted: i=1; AJvYcCVjVj9lyv2iV//ZZoc7D8TnzCLQLqVgBHPhoWqJOWTuwxa8Xy+U4WYKLHAv6BEAcB//wCNChPLDAaSdgUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTGMuMob7QW2IQ//OHSEI/l7hmWz26rjmdxctJiAS69rqDPe/
	GKGUQc35xabqABSCfAE38HBl/RmNqKnvt/x3dQwt+Ey7WI8eRb6wfxV2Qiat/YiuvKSarluiwqt
	Erm2AZQ==
X-Google-Smtp-Source: AGHT+IHx54CudknapTjqpUs7zfNGiPy/qu5Mmu7jpkq4hiNlDYxs3va+KkHlVpMQ+tU4DdsMuRGF6T4bSwM=
X-Received: from pfzz12.prod.google.com ([2002:a05:6a00:1ec:b0:77f:4904:b672])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2d1e:b0:7a2:8111:780a
 with SMTP id d2e1a72fcca58-7ae1cb64ff7mr153168b3a.2.1762278446257; Tue, 04
 Nov 2025 09:47:26 -0800 (PST)
Date: Tue,  4 Nov 2025 09:45:12 -0800
In-Reply-To: <20251007223057.368082-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007223057.368082-1-seanjc@google.com>
X-Mailer: git-send-email 2.51.2.1006.ga50a493c49-goog
Message-ID: <176227813898.3935465.839720915635160924.b4-ty@google.com>
Subject: Re: [PATCH] KVM: selftests: Forcefully override ARCH from x86_64 to x86
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="utf-8"

On Tue, 07 Oct 2025 15:30:57 -0700, Sean Christopherson wrote:
> Forcefully override ARCH from x86_64 to x86 to handle the scenario where
> the user specifies ARCH=x86_64 on the command line.

Applied to kvm-x86 selftests, thanks!  I'm deliberately not sending this
straight to 6.18 to give us a full cycle of testing (changes to selftests
infrastructure have been notoriously brittle), but I tagged it for stable so
that it'll eventually land in LTS kernels.

[1/1] KVM: selftests: Forcefully override ARCH from x86_64 to x86
      https://github.com/kvm-x86/linux/commit/17e5a9b77716

--
https://github.com/kvm-x86/linux/tree/next

