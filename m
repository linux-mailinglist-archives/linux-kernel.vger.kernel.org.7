Return-Path: <linux-kernel+bounces-605455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B4CA8A169
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 16:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D5F441350
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Apr 2025 14:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E89CB2973BD;
	Tue, 15 Apr 2025 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tp34xGkS"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96BF296D0A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728189; cv=none; b=SP2+Iypu0nvI8Pr0FwX3bv+I65nJoh7sJzUKdgO6P4JNpVuKI4n/hRZQ2Dq5ckPc34EDaezgiInYCmx63x+sWZpv0i+9n5cQSFoBdkNpjXaDIxB8g9x2HQAeKmJNnl2EEcjqEDdLmqRBUduDgVlgD5B1Vwq3CxLchP3kiVuerGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728189; c=relaxed/simple;
	bh=LOsU+N+ngWcNTUp0v7jIwqfqmT9V5NxpNoIMNt01EQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rIELpLBpD9soJv2Za/LIbeYrMzx7Dp8JqaTjw9PunMzd+VGPe77lcsm8ZZVZwOvuoYxreBztMliEtoforRDDbgTbrCwKvYRSVyjg5R2L6/PkS9I6nA3SUWoAotglFDhGVPQPDJGlXtVw6swSkGGoAiccWUhiapW0Okuozz0xO6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tp34xGkS; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7398d70abbfso7127913b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 07:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744728187; x=1745332987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LOsU+N+ngWcNTUp0v7jIwqfqmT9V5NxpNoIMNt01EQM=;
        b=Tp34xGkSc3garxw4BdziH4p1CjtsVmVw6SDIq7R21xRzGzoVkjcYXV8unAgWpyYVc+
         ltcVioJatUK4FOgm+CCq2tACdTO18Zhv2aQRGHHpiKLtFMLIIaXQlhAr0dvO07OTmj34
         fBinTVhPxV1RBbw2gLbqn3sCfZ2Gnbine/sbhvJ5LDcBKPcmMcXp4uS9rlONWlCQ3gps
         qeJUakzGJ5Smd8GQfwRw9QwdvFwfqAfRLBK7c8Y+8JyPWAwUtojN1HWhWXGiMutk5h5V
         N/7f+Kc/DmsAauT/JpRiP35vWoCjQwFk67cl2yQ80UnmM0vGmue54R0Slvnk919j9miM
         iruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744728187; x=1745332987;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LOsU+N+ngWcNTUp0v7jIwqfqmT9V5NxpNoIMNt01EQM=;
        b=FrSBjGGA85BU6U6MhQQdD1ITViGGunN7PMweHHr/7lfwH9jcxey8Y2CLBBxBFslCG8
         3bm4o5xT52/n6I9s3mC4diuEkDyhKVsW/cbU6hm71Qrnd+bJktBbdTY7B9iFGQALFGIv
         +DMZ07HOGhVchaprYyaAHJQgg16ClPt/gBAquCnodVYK9LhtB4BqYNNGdF+HL0eZRUwX
         JGW+o4jwxraWn1+CvtCkqccGmLmON6HZ2pjeqSdGqz5KfEkVZwwBDp7VYbwnBOO5PuUE
         iI3PwwI4SijhVNyxGoe/9US2n2ucIPVYB12c97LyhHbbY9BzsB4zjZhfITYKpvrT3WKy
         CySw==
X-Forwarded-Encrypted: i=1; AJvYcCV4J0UTnRXWUpOjhTqjV2oahRcBhRp0kcn3boZvKTR57bqtSM5AY+dzfFLUuKKKqt5MMCWOvqDm/u+Ih+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YySvUoaR3WyNmUnyeI+qTbNcMK+Hf0WqnyKgVhjMqoFLgaV6rqH
	VU1QnWCScrl0G+ipJcekwoXM4iTpBdEFrYr2NUhA1qhqr8rQ7s7cgRtgMmXqt2B+S1rkPd3zbQb
	fyA==
X-Google-Smtp-Source: AGHT+IGuRKECsaS6tDd8viezt75dTMwoPb2acVz8TD+3vlgc6I4Z8PNDNOHSKbUgHY4y52rCyt+QPrfOwEo=
X-Received: from pfbkq7.prod.google.com ([2002:a05:6a00:4b07:b0:739:3659:ad9])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1414:b0:72d:9cbc:730d
 with SMTP id d2e1a72fcca58-73bd11fb281mr21135681b3a.11.1744728187081; Tue, 15
 Apr 2025 07:43:07 -0700 (PDT)
Date: Tue, 15 Apr 2025 07:43:05 -0700
In-Reply-To: <20250415.AegioKi3ioda@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250313203702.575156-1-jon@nutanix.com> <20250415.AegioKi3ioda@digikod.net>
Message-ID: <Z_5weSEpN1rDbYAs@google.com>
Subject: Re: [RFC PATCH 00/18] KVM: VMX: Introduce Intel Mode-Based Execute
 Control (MBEC)
From: Sean Christopherson <seanjc@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jon Kohler <jon@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Grest <Alexander.Grest@microsoft.com>, Nicolas Saenz Julienne <nsaenz@amazon.es>, 
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>, Tao Su <tao1.su@linux.intel.com>, 
	Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025, Micka=C3=ABl Sala=C3=BCn wrote:
> Hi,
>=20
> This series looks good, just some inlined questions.
>=20
> Sean, Paolo, what do you think?

It's high up on my todo, but I've been swamped with non-upstream stuff for =
the
last few weeks (and I'm not quite out of the woods), so I might not get to =
it
this week.

