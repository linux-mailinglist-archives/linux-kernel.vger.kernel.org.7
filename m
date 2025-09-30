Return-Path: <linux-kernel+bounces-838036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D26EDBAE47D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 20:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B26E194306D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 18:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4BA1D63D8;
	Tue, 30 Sep 2025 18:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyCrl8aO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C602C30C63D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759255846; cv=none; b=pii6DGYVlPp7gwMXqf4lUB0x5y5WoHQwoLalFG8jSA6q5ZoOduHmf0cwpliXc6ioQI/KIaSlpChsCSb9Qa+kvQR1RMEfCKtbd/lsgHzyBOosfVEzOt/cZKY32kdQY9gdUm9BgtgTwvD6YaoFp/9U8LAR1Vv9emIb5D1Zvj+FIhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759255846; c=relaxed/simple;
	bh=gks9rE748iFgDpsAFxxJcMCatjgsFNBnvh91FnPmnK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=drB1NA4uyJ89eowSvwIqfOOJUfbVcvyst7nGl/QR4jYYz5ASZ0lTbJx5lEmBdgdozMImfhNMctWIHtXJ6RZoyc469/z0nXJ35+FmuOl2akmtGmIqoVMTf6g3b+UM74KGOUkIg5Ja9aeQa3Yr6OOxfQQ/XawOe4ikDRCrhhjGPKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyCrl8aO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759255843;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nw6Z2dvH8M3CUzmbUufot6Bsmkaiw4nKeZg0Erl+RtA=;
	b=OyCrl8aOdavi0gi1Jro8zPLthsxOTWkEvN+f201CjunrK+gr26S4S3A8D84Uou3KhHDAqm
	S2EgRd9kwt2KCDvl25+VhQ7n/qMRqeARJSQ/CZdr0sKwERGyGMmxW6LZG9ClSqVDnxy/Lm
	H7XKZOuNnraMmtnDXSPmiNBxiivJ0Ao=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-VRUO87cTMs--ATJBcVwJnw-1; Tue, 30 Sep 2025 14:10:42 -0400
X-MC-Unique: VRUO87cTMs--ATJBcVwJnw-1
X-Mimecast-MFC-AGG-ID: VRUO87cTMs--ATJBcVwJnw_1759255841
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdfe971abso4195786f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 11:10:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759255840; x=1759860640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nw6Z2dvH8M3CUzmbUufot6Bsmkaiw4nKeZg0Erl+RtA=;
        b=Ha0HuABIFKsDxe4TEi2WEBve+8ijGLpWJZYxyKQ1bl43qZMCQ5IaNWxyixDZBvDFpt
         tl+ZaPhVdVUwRoHlEsYGi3zmLTtlD1vvMq8m9kDMCbV7gp+fVcWmZNQdqB7Z7z0KsX8b
         48KHal+COhjUjeRk0L0DCHHREm+oHWcrBWRSP1G4jf1Oyb3Rq0DIaBEw5Lz5cZEaN7ld
         wuEZsffPNlWFO7d7NMNCTyi8hrxFWyUSnYCKw16hyOrOspVrxDZKVgWSs8FKRxpaN0+k
         0NDwJcKQWBOH7Xz20ywp1WU/bFXJCkfhyv5inBLI9mhX7sGseZv2ZDJ+MV9xBlGII9ro
         Ebag==
X-Forwarded-Encrypted: i=1; AJvYcCULixxPtAu6P0IWCusw94d1nN8lUAgm53uY00a3VO73hf3xLObKbCLWopGwVdMkHPskBSwt5IFJDE6ELpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRvulDXjhmVei5L2QkWZxxXyL2B75GDYG1JNu8fwYa8SG8VD0
	q35UiK4LgqrzeAf6LixH/AnqGLS5MClN0uMe4BNo832GeF9ewarhgXLd8/HWh7TJ8RLrL/ZFPdJ
	oRp/A8rn4K5MC88od4gaPnUdn/6n3lUgPqNDZhJwe8jJfekftNxVHgZn5Jco2ee6QdoumMY2VPg
	jWLEteRKCjRf6lrb0+fL6JbuKsxzSDcZCzdBq/36qGR4ivbEe2
X-Gm-Gg: ASbGncs+BqgGpnqF4UMMq94uSZkWd5OrhybP4dDehFJmsKcDubkfyaK3C3my1+1tzUs
	oH8U4C4t04pE7ESRDm/I0jiL+7uvqwx+Sbww6wnRzPQzbYIJud2nRi8EXpvwGExTYeC3VavTyWo
	TwdRsnOu1d09jOuB9sMIEuSbCuMnixT0PY4onGY/TsZCeoyLRRrIT+sY+UbbBCokTrjWz5X5NJ0
	t4tejXYwCS0wknetlwHEC23qMgqrq7r
X-Received: by 2002:a05:6000:26cc:b0:3ea:ad2c:c166 with SMTP id ffacd0b85a97d-42557809261mr477644f8f.49.1759255839995;
        Tue, 30 Sep 2025 11:10:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBCG2kxTA80bOiFWd587Y1SVn/cGwf2yGHcuXWo5P7wNBcb6wa40dWh1o866qphPlRt3lLg8JAwzqZtui+3cA=
X-Received: by 2002:a05:6000:26cc:b0:3ea:ad2c:c166 with SMTP id
 ffacd0b85a97d-42557809261mr477628f8f.49.1759255839647; Tue, 30 Sep 2025
 11:10:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927060910.2933942-1-seanjc@google.com>
In-Reply-To: <20250927060910.2933942-1-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 30 Sep 2025 20:10:27 +0200
X-Gm-Features: AS18NWDYgoDBpwI0tWh7HqFmhsfEhAU0pt8W-xzFoHlkOlaFY1ZBZoNnnKuMWas
Message-ID: <CABgObfY6iEKbo9tLAGdsKhK3vYsFW3MB_6X4ay8GAmQv-oRBGQ@mail.gmail.com>
Subject: Re: [GIT PULL] KVM: x86 pull requests 6.18
To: Sean Christopherson <seanjc@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 27, 2025 at 8:09=E2=80=AFAM Sean Christopherson <seanjc@google.=
com> wrote:
>
> Sorry this is coming in late, it's been a long week.
>
> Similar to 6.17, a few anomolies in the form of external and cross-branch
> dependencies, but thankfully only one conflict that I know of (details in
> CET pull request).  Oh, and one "big" anomoly: there's a pull request for
> guest-side x86/kvm changes (but it's small, hence the quotes).
>
> I tried my best to document anything unusual in the individual pull reque=
sts,
> so hopefully nothing is too surprising.

Quite big with CET and the FRED preparations, but no surprises indeed.

Because of the conflict, I'll delay the bulk of these to a separate
pull request, probably on Friday.

I have already included (and tested on top of 6.17) the selftests,
guest and generic pull request. Everything else in kvm/next. As I
mentioned in the reply to the individual PR, I ended up cherry-picking
the module patches. There were a couple preparatory patches that I
guess could have been in misc, but certainly nothing worth another
round trip to the west coast...

Thanks again for your help with kvm-x86.

Paolo


