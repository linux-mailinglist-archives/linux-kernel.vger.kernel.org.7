Return-Path: <linux-kernel+bounces-748490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F3AB141CB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:17:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE1083A5F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EEC272805;
	Mon, 28 Jul 2025 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OKBLeMi/"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B60BA45
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726659; cv=none; b=J/sCgJQWejj/PGTPXfo3/tn7fRp2Qt+Xu7OtX7AY3Jj83VYjykZX2MtaFqEBFHzeqSOfG7P1wJdpM0YqeWPaTOjliGrrYlzBSDfA/nHGDvyluTwxK2bWN1N8En+/OR4VuC7pK5o4H3aImmNAYO0oTmqQRX2aooKeINvHLS9g4RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726659; c=relaxed/simple;
	bh=VDlEiwovForUKX6glMaAfiqHDQdEgC9cj1h8O6kYSlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxzfezsFXJU6lOLzSweh+miJfvYb2RZiPqRRGMwb62h+sf3CmZAP9U+vaGA+ph12vChMxg8JAul1rNs0854eT+VF0KgXWcAYrp/SpCcNmZPbM2qDdccXwZDfo7FbNK6Axw7hYciEPqj7G7A3KSfAXzvKHVvH1dVvtXC4PcI2EFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OKBLeMi/; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5562838ce68so4194782e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753726655; x=1754331455; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=abFGoaaLKyanJnlZpRo9hB7o79m3CiWoXYjYW1q8YQk=;
        b=OKBLeMi/ccC0b1loNQeMVtjw8/uQlxvqMTlA6IijIOXjrl9Aeqjvv8ZDmslOrLtK+B
         H8Re38ERV0cU/Kd8OSmQrl0Gr+fifUTvp/RSBtY7kNsMRvldvUs280PgesF7AaJ5yWrX
         TByzddGUFmEkFT9FRxxuTY3uFKz1wKUYhSkj8qBPNu+61ZAx4BXkIDmFntDFbwDElFzO
         S8AoIoQUSfsg/pLE/rwLm/c0dvI+QKZ0q8z+mKcXPYa7Ef3ppwsXFrK/0kDB2coAtSIz
         iyZQz09ZNH1PCkBmb8IF6iwrknppdWSK6f7OtcYxuPCWnPp6cmRkQAJTWM9CA8zWY3/H
         vtKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753726655; x=1754331455;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=abFGoaaLKyanJnlZpRo9hB7o79m3CiWoXYjYW1q8YQk=;
        b=hPilDqz5i8Zmfny4d+c4Le/x3mU4HaBH80aCOe6xkU4XjY1Wsl+gL1TzoO6LzYV6if
         E9pebnA0uRqRILHjnNVr8JDZQ/JbVG0D/ko70kJ7ybobwapxA2S504WGBThb9vsfx7aQ
         lmCHfWIS76CjhJgp0NiU5uswoj66h6Xar7rBppbD1fH0O2shWIcoVIJE6j9L13Phrx5z
         oeTpVpYJrvzn/PWwSNMXRKTle0mE73hPlDk2DgD63/yqjYKVtNakjwArx0BNXrcMQDi4
         9cKyuecnpEhqLZF2/ttNsvJsKMQt4neA2T3ZGAYFdcj7O8wHEaiHbZzNAbhLqB0BacY8
         Ttqw==
X-Forwarded-Encrypted: i=1; AJvYcCVTuL2wjWEfS6QtO91ElcHFqZjynCePb5F4wY4N8Af+oGHMSw6m7v/vhsZ4mF6D4/XZ4qRF1gGole0/NA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx82LeW98q7xUGllo6nQp2Vneapjj9gaNX9pkVfy5oGA0KhYoqg
	lTD03vPaytue/B7jAYyfz3lzRPg1y+sR8SeZZxiFoSlGXnBj+hMNcMsymBhwVHMiB2cIHbnsp77
	7f/gF9t0eyaZyyazDOWG+pJgC20Hr+/KX6x6+2Ysv
X-Gm-Gg: ASbGnctujRdoZsoi63gYzHIY0hryv0a+oqGlAU9VdscPWTUYdiLG+bFEbSjPV15JdtN
	XUy5hZmc5VLR4XFdV+rEup41hrnaLL7tyFqQjhQNSnpMlwi4TfmQS3v0BAzctC19MJWfVR6gjCT
	68DZCKvQ/tCCu+VBjxksjq8QlL77JxppH0Sf6yESWpYB827+mk/BFPaaMIvXsmM7MLxPKnyt+Iq
	c6Wc2s=
X-Google-Smtp-Source: AGHT+IEJHS852UVpU5vL94onuZIrwp0eDPbW78u4HdyCQoNEd/oAvT0Y7thZ3sQ9bQLlq2pDNmOPdGs27+Yzee4LzYg=
X-Received: by 2002:a05:6512:3d2a:b0:554:f9c5:6b30 with SMTP id
 2adb3069b0e04-55b5f4df42dmr3074009e87.38.1753726655095; Mon, 28 Jul 2025
 11:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707224720.4016504-1-jthoughton@google.com>
 <20250707224720.4016504-4-jthoughton@google.com> <aIFHc83PtfB9fkKB@google.com>
 <CADrL8HW46uQQKYUngYwomzfKWB0Vf4nG1WRjZu84hiXxtHN14Q@mail.gmail.com>
In-Reply-To: <CADrL8HW46uQQKYUngYwomzfKWB0Vf4nG1WRjZu84hiXxtHN14Q@mail.gmail.com>
From: David Matlack <dmatlack@google.com>
Date: Mon, 28 Jul 2025 11:17:08 -0700
X-Gm-Features: Ac12FXx3wVXlb41VNkshvgKpI33DjTt3OFbnSm8kispxP2pDqaX0TG1jBjkEzTs
Message-ID: <CALzav=e0cUTMzox7p3AU37wAFRrOXEDdU24eqe6DX+UZYt9FeQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] KVM: x86/mmu: Recover TDP MMU NX huge pages using
 MMU read lock
To: James Houghton <jthoughton@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vipin Sharma <vipinsh@google.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2025 at 11:08=E2=80=AFAM James Houghton <jthoughton@google.=
com> wrote:
> On Wed, Jul 23, 2025 at 1:35=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> > > @@ -7559,8 +7590,17 @@ static void kvm_recover_nx_huge_pages(struct k=
vm *kvm,
> > >       rcu_read_lock();
> > >
> > >       for ( ; to_zap; --to_zap) {
> > > -             if (list_empty(nx_huge_pages))
> > > +#ifdef CONFIG_X86_64
> >
> > These #ifdefs still make me sad, but I also still think they're the lea=
st awful
> > solution.  And hopefully we will jettison 32-bit sooner than later :-)
>
> Yeah I couldn't come up with anything better. :(

Could we just move the definition of tdp_mmu_pages_lock outside of
CONFIG_X86_64? The only downside I can think of is slightly larger kvm
structs for 32-bit builds.

