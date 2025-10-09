Return-Path: <linux-kernel+bounces-847527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84092BCB1A3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 00:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD0A43AD5C2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 22:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D40A2868AC;
	Thu,  9 Oct 2025 22:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vJKZSjqZ"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE0E63CB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760049287; cv=none; b=mxhVyoxJiMcNTn/biW2IbgP4hV8tIJNqbmDMlwKQz6H/p8L+hjIiSUjL8XCtI2e3kxacjO6TyZMx1tN+P0D4Cci6/6nJ2nllfwNgzg1tFzBPKW1OBtpk1hYO5YofhO0xJw4NPSA2HzAqyw6gT+/LBa2MCOv9yf2SbF2c2mt6AM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760049287; c=relaxed/simple;
	bh=9jN7yy4faemkFk4CnVeK+ylZLzuZ08PbRW1aI3m6yEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l7EP0XP9welEITjxF6wuwsR94jP91iqShnrVB0vp2PsbBw/rBxnCLgz5PbjB/WXR9Au4My0sIdobNmk0SOv3s+alfFjhBeTbNJtvxA1tIVTcLiz+IT5T+sWc4x1tiYVbjcVARImcSENAskmqPlvWrDmED6R8ILM4LSv81GjgPvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vJKZSjqZ; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-78106e63bc9so1979473b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 15:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760049285; x=1760654085; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+k+gk6VQNvvMox+c8DfhOTxAsmkufNVxeH8bt4I1AGw=;
        b=vJKZSjqZ9kuwQ8GJa4DlhMc5aexAc6Gf2CnjKpZw9HxfJAF1ORUZ6zXdLnslK3WSQd
         /896TxGuO8Hk2CF96t6kNNALf7mBJXmDv6MtqOAZW8oUBWsbH4IkEMEbeVSEBjo6NsUz
         xtk9PZtix000TQk/NRnJgxT5R2BT5zxMpON2ixwhG2MpQ9cMYe1tsj2EAQplDGOIB9wn
         ZV6jfvHWbq8WEMFJdJPxvx+xmTMm/ZlHD+F+wgnoSJ+pU/RWALGx2U2B0iCBF+bDC7s/
         +ekqf6ZUe78STuJkah/mehxr1vYDao0CB1ZGOjxBF6Ac2nE/tWZnsGHuY6fgOS13+PTQ
         F2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760049285; x=1760654085;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+k+gk6VQNvvMox+c8DfhOTxAsmkufNVxeH8bt4I1AGw=;
        b=KlMwT7rTCG8JqdjUTt3W8TJzRLV3efKlVpTlusRUV3zMTwBPGBsPEfAGYcfV45Aaf/
         FGE3Hml4LZutqiknplFauyU0V5nyVbRQM5WbvoobfIkH8A+mR14yTs85ECGF8W5+0H38
         v5r06z2tLbFhVYUFUfkAXSSeXekhSmEy1m2QV72xnaQ2UovOL+XdbQjlTqrMlB++waHm
         hxPFwxedQ004XYCSaDqf5mcMwR5W6jC8D/FO6AkFbX5R4qDfeAw/3VIqjc1Ke1JEX8Wa
         0FYzUbC5fErSxzfKAmfY7YW8rb/9byfKbxBhfSOjMI4Y+p/CdEWem8ekynOCBQ5ARyUr
         HQnA==
X-Forwarded-Encrypted: i=1; AJvYcCX6voZgVv5A9wmRfRxp32D9ATDAkwviByPV12TstbHJhproGnZroZfNs+03uqx6pjwke/ZBlDc4VzWjy5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg0ZfpWZPmUOecH14UGK/zcLnVXuSKoD3JDl2sue8VUPaMtBmp
	y680wtZV2HjfYEZvj/bYEpsQK8J8i7LiTsHVQMsZC94X9Uw/kcicKFm2pSuNzli8fkLZxut1iro
	7KOSnWAfZ+mB+G8+y42xoqC+ETg==
X-Google-Smtp-Source: AGHT+IFT3+ACqwDT2lCoDe9XM9NV6pIpsUJnUvsrRoGgkm257Ov/Ea7I3q36/zx0MsZeeBCKYpcs1LHgia7b4IPfmg==
X-Received: from pfbgu11.prod.google.com ([2002:a05:6a00:4e4b:b0:77f:3d60:9807])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:391a:b0:77e:8130:fda with SMTP id d2e1a72fcca58-79385ddc9f9mr11632278b3a.13.1760049285570;
 Thu, 09 Oct 2025 15:34:45 -0700 (PDT)
Date: Thu, 09 Oct 2025 15:34:44 -0700
In-Reply-To: <20251007221420.344669-9-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251007221420.344669-1-seanjc@google.com> <20251007221420.344669-9-seanjc@google.com>
Message-ID: <diqzfrbrhfgb.fsf@google.com>
Subject: Re: [PATCH v12 08/12] KVM: selftests: Add additional equivalents to
 libnuma APIs in KVM's numaif.h
From: Ackerley Tng <ackerleytng@google.com>
To: Sean Christopherson <seanjc@google.com>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Hildenbrand <david@redhat.com>, Fuad Tabba <tabba@google.com>, Shivank Garg <shivankg@amd.com>, 
	Ashish Kalra <ashish.kalra@amd.com>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"

Sean Christopherson <seanjc@google.com> writes:

> Add APIs for all syscalls defined in the kernel's mm/mempolicy.c to match
> those that would be provided by linking to libnuma.  Opportunistically use
> the recently inroduced KVM_SYSCALL_DEFINE() builders to take care of the
> boilderplate, and to fix a flaw where the two existing wrappers would

Typo in boilderplate!

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Ackerley Tng <ackerleytng@google.com>

> generate multiple symbols if numaif.h were to be included multiple times.
>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  tools/testing/selftests/kvm/include/numaif.h  | 36 +++++++++++--------
>  .../selftests/kvm/x86/xapic_ipi_test.c        |  5 ++-
>  2 files changed, 23 insertions(+), 18 deletions(-)
>
> 
> [...snip...]
> 

