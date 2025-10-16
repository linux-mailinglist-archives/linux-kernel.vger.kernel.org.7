Return-Path: <linux-kernel+bounces-856948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D71BE5843
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 23:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9D4ED4FEA53
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 21:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F8D2E229C;
	Thu, 16 Oct 2025 21:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkEcS9UA"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D552DC773
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 21:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760648839; cv=none; b=n/HNBHCC5c/zJcR0UGxUgWNfexf8LFAbtUaDKYae2O2RG+bduXHeEQy+GZTXaq5vSWZm6tMbLXF/Ullr+2nBiV5APtsA0+Ae/oB5lW83UTStn4qMAw0VzC/NCDkZ47fFMvtQAqxJ6v/4ZpUxIO6vWB6+J49TkPlSH38C5A9aJh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760648839; c=relaxed/simple;
	bh=/PZwiIAPmraOr8DU5gpdQ0hm3ySju3FqvZeZeb5sXQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q0oN6kl2uPBZeDlmquERwfCuqN6LGIQi7316d6wRZNz1mdLtQ7oHWydIy9/xdjnNSJvOZhEkbBXbHB6cbR//hEG7gfI5aHvsqKprRkQHX5U5jgxujyBag5qp+amXv46o1xGkGXuSt20LjkcAkTLe4QXz5+L5nE04q3FUMWzRs4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkEcS9UA; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b656473dd4dso144389a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760648837; x=1761253637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YqKLtcHyZtQvUCKV9AK34ygiWjcxKsGF+96gmD+h6kc=;
        b=mkEcS9UAJzH82Xaf3mmBYfqnCmfGhTpmNrweOOBu9Q5DZZN87AoiAo5MwCIxBJpj1S
         Ro0O1BhuInOLntLvvI1aqTZ3IK6Va+VZNhbKeHqwOmYRt+ym9MzDROkxC/rUMWAiNenV
         S+qxFcKihT8ZlTbXWFhSi5A5jRJfCgG3PbuqtWvLZWthjVWTCRxy4uXfpUfQHTG/Ha5W
         U1V0JoQwNhRKvUMwtcQRm1gqXGk83oNstsUv3C7SCiMMOYlu5j2wOQrI31B4syOibIDt
         4Vc3H+K2zNAtrYceEPWkoI3G1T5fwgTaxN4Wxli1D/Wylz5E/ukb+zCO53ZWVbL1NZKo
         vK7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760648837; x=1761253637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YqKLtcHyZtQvUCKV9AK34ygiWjcxKsGF+96gmD+h6kc=;
        b=RWQ0RPg6n6Lom8rWceL6M8sjhhlagMB/opAILDTERccwTDYT3BdZhBJ9RmQGX8uYIb
         +9jNSyriNHGLPajbPlqKLINnLE4k+vg758lHdnsVk+uHH71c8i3+BMVXOlutwx8UrXJP
         4M/NVwoKeZ4VwiM9ZydVaOyD1fAzbN8z9mYMIULAXMIY4bdYezmwbj74Cc2OnkrY16TK
         wAxdmPcgcYXKetx4Fa4BHWVpKMLLhBWhutpDdVL+my64qHfF+s5d+57D6lB3rBT7clA2
         l9BwmyUbG65x+h4LuH63rQVAJognz6jIS/4TvRDjehF6CWkVYX9ELV8vvnPQfBzZGPIF
         I5kg==
X-Forwarded-Encrypted: i=1; AJvYcCWCEGD4u6GN/4wgHvcL0aRFnbFPZuinhFqfShLmThfZ9YK5sj1V4mZpQRpAWhNsqW6GNlIQz9+6aq26LP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGoetVxT1tWTz2NZL4aYhHmYALA38ep13PDKi0TrmThqfmjoid
	2hFG+F7JjLttDfOO0SbyufG728IoKoEUXaj6o9IqMTuqbFt48nLeTG4BMdUd9W6YiMYpqRLoQtg
	idVV6D9H9qjy/8/gbP+DkpEaXKSh85Dg=
X-Gm-Gg: ASbGncuJepoaQEGP9l1/198Z7AHVo6WeYyJxpULLjBBBMqB+3/2e4OXTmn6h/39JG2m
	x15tZVVjg2x9gZSQlxSVBXcJUSBoCE+ucaulR4YACC8pZ07EQISi3JTmBWr+MKCgsw15lxtjeU5
	w7zVZeDuSnCLU0F4CSqVWEjw51d0jSTdlBVRBCg+tPY/0CqrfSyQRLRG+YI9lXwM45F+DU6O2V7
	4S3BWcX7cl+xBEPiac3dyHpiTV+Pc4rInHn7rjPYZlqLZD2OHDNIC5DeOlvMIEwckeKAuJgWSWN
	hpTFS8gd1wKqY7FDDvyKPJOm3Y9CMwOJx5HPYu3kdblHy59SgjSwpbgITTw7DYPkz9t4oZvlCzP
	Mgvjq4Nsh75cIA6DadpV4Nchs
X-Google-Smtp-Source: AGHT+IEIgAYtM+PkA8oLdH6dq6tTOHVM2SK/9pf6/KLEGFt0fs1UrG1QtsI18/3/wnm81TfvgNcSQoGgwMXacG4fjDo=
X-Received: by 2002:a17:903:40ca:b0:290:55ba:d70a with SMTP id
 d9443c01a7336-290c9cf3306mr8101005ad.2.1760648836981; Thu, 16 Oct 2025
 14:07:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016172853.52451-1-seanjc@google.com> <CANiq72ntKAeXRT_fEGJteUfuQuNUSjobmJCbQOuJWAcNFb1+9w@mail.gmail.com>
 <aPFVcMdfFlxhgGZh@google.com>
In-Reply-To: <aPFVcMdfFlxhgGZh@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 16 Oct 2025 23:07:02 +0200
X-Gm-Features: AS18NWCIqm_srauk6JXkuo1Nu5EkkFsJYyp4maKnlr0nVE8sbB1v3JnElr1TnCc
Message-ID: <CANiq72m6vWc9K+TLYoToGOWXXFB5tbAdf-crdx6U1UrBifEEBA@mail.gmail.com>
Subject: Re: [PATCH v13 00/12] KVM: guest_memfd: Add NUMA mempolicy support
To: Sean Christopherson <seanjc@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ackerley Tng <ackerleytng@google.com>, Shivank Garg <shivankg@amd.com>, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 16, 2025 at 10:28=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
>
> Oh, I take it .clang-format is auto-generated?  Is it a "formal" script, =
or do
> you literally just run the grep command in the comment?

I just run it and copy-paste the results there from time to time.
Yeah, a very low-tech solution :)

> I don't think I care if it's in the list?  I honestly don't know for sure=
, because
> it's entirely possible I'm consuming .clang-format without knowing it.  I=
 added
> the entry based on someone else's request.
>
> Ackerley?

If you are not relying on it, then please just skip it, yeah.

> Is it possible, and sensible, to have per-subsystem .clang-format files? =
 KVM
> (virt/kvm) and KVM x86 (arch/x86/kvm) both have has several for_each macr=
os,
> pretty much all of which are more interesting than kvm_gmem_for_each_file=
().

There is `InheritParentConfig` nowadays, but from a quick look I don't
see it supports merging lists.

So to do something fancier, we would do need something like we did for
rust-analyzer, i.e. a `make` target or similar that would generate it.

Otherwise, we can just add extra macros at the top meanwhile.

What we did last time is just to add `tools/` to that command --
increasing coverage is not an issue (I just started with `include/`
originally to be a bit conservative and avoid a huge list until we
knew the tool would be used).

Cheers,
Miguel

