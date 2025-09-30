Return-Path: <linux-kernel+bounces-838092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64898BAE6AF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 21:16:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB971683E4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 19:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7568D23026B;
	Tue, 30 Sep 2025 19:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gtWKC3aW"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EDC4C81
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759259811; cv=none; b=txoFDq3VW5b4GUFY0RjZfRVhR3gmunjr9RUWrwLuLUm1sJONmby0AH5T+cVK2TuCEh5D8IS31MUlXiHDmHQlqyAYSpW7xdDp2095TBILy/6a1oif1ELqyK7yBdRIt0oFsBWKvOb7MDhL+K3L3rySUE5E0icnKveQudhq4IQqngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759259811; c=relaxed/simple;
	bh=9Ju7l26lyQ25LtJnf0uogw+JuQhfeHi5Rb2Twfkgq2k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bcEV90iOgW0aGs77KVl0SfFIh1G7xTkhk9S+0+EP4MMYwbYU9kwRF0PACGeFbMBrIyO1ns71IqZuzBcJeEb35Btu6cD1TzU3cBW7mUL7CJNhUTcrs/Ed2ADlB9+eey6ypBzpB8W1pnJK+0Q3QXTi09n/WnvqXC4exfqLx7l9DrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gtWKC3aW; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-78105c10afdso5591757b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 12:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759259810; x=1759864610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/WEFiCkd++mamNyS+6QnAlgEtBqhn057fis8J9wtWgE=;
        b=gtWKC3aWi9hD7WSuaHMH79jqstYSV6girdHL6+MYAO8gM9ZdVvcuYV3nfrQWVxS909
         XU0IDBsNWoDR73mkH5iMxBbX7clcLF2besPiBLZ1T0FTqBqrhfL2eBqynB3YPH5cZPZ5
         tdu4UKyu/ovUQvzessN6OcdiajU6+9pf73SgTp1gM2V9kZWqMaJdr/Ro4uPr0OUC94tV
         hUwoJf9m7E81os+WqJhy9kNAJ1BRLdnfdV/WpVrS10yX+PW9kDGA/1DQgcfKIorL9NpN
         vhXpekg9ihfuYSKw/PwnLiNJlmfkNaQrUvMCDserz8LyYJ7h36F5cuwqh+wMTsv4DI1Q
         mTuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759259810; x=1759864610;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/WEFiCkd++mamNyS+6QnAlgEtBqhn057fis8J9wtWgE=;
        b=ryDTb3YarQU9WW5qdejAH5dOQ9bJuWwbG2D6aEpirL5MjoPdh5Xcv9aJoanG2wRoi+
         zctbQPjdaC3JNkTWr2VJIjUDNCRA9dnQeC3kzExXJr41pbyN85aumo8QquqH0UG1FL5k
         nIMUeB5gttwbTI/aNl3Jx2XlSPGG1TIAQ6MQPK2jcKCGElV/O0kp98MtEmrT5hwvFYH+
         8ayGiqjgkPjKpvszxFEgh7sHKio40Os9TrFyKxeEyACXs4bMIR/dxfHW7IkxJgELkns2
         /sfL/H4cyMfxGug9jqsi84IrKycr5LLGfVQgWadhBO5ZCDpz0JOQXDPvbZYHhRLWtkUf
         CExg==
X-Forwarded-Encrypted: i=1; AJvYcCXHbxZBY9AI1jvODHMpKNcHfxhZAvjFXaYLRN5URXKQxhzuhmFxAVbi9bKjr7wAJ9ue9nqYxX3MbTKXx1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGDUoRsZCOI5ZY4yNgNRYubMoVd5En+eudiLsTroyn+6bK0Y6b
	gm5CLQDuqtyy49sNjUEyQQ+zHT98kj+Dj8S5hbfQZEbHO3p1fXDRrhqknRZV7dBWU1ezs8MI0uU
	bNFhDKg==
X-Google-Smtp-Source: AGHT+IEXPFUjRtt5ew9DeYIED+Hsm39PUrHsJKuZ6bbCzorROt/9O7Cpo7mA9gj01oyY1i4vD1ekMSlcsp8=
X-Received: from pfod16.prod.google.com ([2002:aa7:8690:0:b0:787:5063:2f2d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:1587:b0:2b1:c9dc:6db1
 with SMTP id adf61e73a8af0-321d7e97db9mr1061649637.12.1759259809734; Tue, 30
 Sep 2025 12:16:49 -0700 (PDT)
Date: Tue, 30 Sep 2025 12:16:48 -0700
In-Reply-To: <CABgObfY6iEKbo9tLAGdsKhK3vYsFW3MB_6X4ay8GAmQv-oRBGQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250927060910.2933942-1-seanjc@google.com> <CABgObfY6iEKbo9tLAGdsKhK3vYsFW3MB_6X4ay8GAmQv-oRBGQ@mail.gmail.com>
Message-ID: <aNwsoK82jW97xy9Y@google.com>
Subject: Re: [GIT PULL] KVM: x86 pull requests 6.18
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025, Paolo Bonzini wrote:
> On Sat, Sep 27, 2025 at 8:09=E2=80=AFAM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > Sorry this is coming in late, it's been a long week.
> >
> > Similar to 6.17, a few anomolies in the form of external and cross-bran=
ch
> > dependencies, but thankfully only one conflict that I know of (details =
in
> > CET pull request).  Oh, and one "big" anomoly: there's a pull request f=
or
> > guest-side x86/kvm changes (but it's small, hence the quotes).
> >
> > I tried my best to document anything unusual in the individual pull req=
uests,
> > so hopefully nothing is too surprising.
>=20
> Quite big with CET and the FRED preparations, but no surprises indeed.
>=20
> Because of the conflict, I'll delay the bulk of these to a separate
> pull request, probably on Friday.
>=20
> I have already included (and tested on top of 6.17) the selftests,
> guest and generic pull request. Everything else in kvm/next. As I
> mentioned in the reply to the individual PR, I ended up cherry-picking
> the module patches.

Roger that.  I updated kvm-x86/next to kvm/next, so we shouldn't get yelled=
 at
for having duplicate commits.

> There were a couple preparatory patches that I guess could have been in m=
isc,

Oh, yeah, that's super obvious in hindsight.

Thanks!

