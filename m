Return-Path: <linux-kernel+bounces-898262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E12E7C54B54
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 23:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24E83B44AB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 22:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B1D2E717C;
	Wed, 12 Nov 2025 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dhaeVo4s"
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEA326CE04
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762986236; cv=none; b=N9pK1RlqB2qpxbehihubDV2SHflYLHP7kMPXR/1AGDYWG39sY71xj4IZyssE6Rq6UlhNLjKeRl/DIhmNfyemGrM2DRedaM2PKWynzccOnFYhGxOR59fhLVjWJiUz7H+aLwCeAwZtd1zMEAiSJXgu/9X128N8bafss0Z22k4hd2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762986236; c=relaxed/simple;
	bh=1dATqO0nEuFQDqeYmGHYSBBpQc0Dmbg+kkj7JSrXrEk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EJNIG5LJZiF1e3i51o2ahmdYWJw+7L4CvSuD3KJMuR9+6aj6n+gcxcjaDHjIsQfmhDPtoEkwaqJ6uHAFYyqwg6kMyAxGMroS6Gmxsi2xuvxr8sFQSljvCavQb0ojPgxJ2pXHEwqqLO/a/vgSWrn6LOTBA9yoMv1NfNfiGB0Wzhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dhaeVo4s; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297ddb3c707so1139585ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 14:23:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762986234; x=1763591034; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw4f1reWMcSIQ6pzE8/3VdwzTz8hfGSrFUGEZWPw50Q=;
        b=dhaeVo4sdrZmWEizhfBkN/beP9EMA73++SUoZn8Z+yUMeGZ0SCMoHgL9L9WUH3kVDp
         aRfUx38nexmowYLb2eFXtnUWYg4k62Ir6KJ+/ZuaPrNsX3PeUXCgc5RTjaseOMTMzt26
         Xv7WMEdFbgcw7EZTlOxS89JtvF3isVL1Uir/JwT08kxhoiOzncAwsqu5L2hA2rzVz85r
         rmatBg3HAJVGOFuw4OYEQFQZTSD72pzVneX1VlA3IYEKle2B0dg/p7bzPPgyXjAoKlna
         03N8I85OPGMe68BJ6FjwRWvQAG5ViACZpKJXOZ4+MEMFIAZY9iHJgdsVX2BhZDFwbqZk
         AZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762986234; x=1763591034;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kw4f1reWMcSIQ6pzE8/3VdwzTz8hfGSrFUGEZWPw50Q=;
        b=beWBRYURXDjqzJd91vXgRckw2GS3h6sE0SLtjRo3IyLe+RwZ7SeM0wF6a70fU1zRkj
         s78zV12nY+CACe445eEfTgKkjwGBi/6V4t1RpNz0LojRngCt2ovr31DvpDX4L9/r6Jlz
         CKWkGQJHuhfn8DLN/RIQm/G9558oJlN6boazzmyie3y7v821AIGNnOhlXeWqXgjeoBZa
         173hKU6EnzYNUUYtHCM/a0oq6pcL4S2t2vb5PiZc8IR0e62qr8YQUMe6nQMD5ncoaIT/
         +QfQU9zchsvMv1oefVWiAaZmkneUyw5tgyuU2B8a02TdDXmXFOEVwxxATyU5Ku40EHMw
         u7/g==
X-Forwarded-Encrypted: i=1; AJvYcCXT8nkXtjaeOcwhJxQ/Lk+2chJr5pC8dXBwzbrKNYKXXHgW80RwAjlF9G6uP/qEZvP+1urOKWjKcl6PNPs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9b3k4svym5xIdKXbyB6IpO4QnFmKlx+BmLn2eQT4nbgwIt7hF
	DYzQw5GxGt6jIxV9j/o/i4tYLcsAF9Dpc0X+HDvil2btVc4UEKajbzt2gSzM1PQ8ybPjRUu5bW/
	gR4+wiw==
X-Google-Smtp-Source: AGHT+IFRDn0Up2tw4QzGoUgCS4Z+fQYxb0kDQeHkuY5hAI1bGwySPTsxvKjtMiE2+kGA10Lg7snsdkDpTmc=
X-Received: from plfh8.prod.google.com ([2002:a17:902:f548:b0:248:7327:44b8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:15cc:b0:297:f0a8:e84c
 with SMTP id d9443c01a7336-2984edec330mr54153015ad.52.1762986234586; Wed, 12
 Nov 2025 14:23:54 -0800 (PST)
Date: Wed, 12 Nov 2025 14:23:53 -0800
In-Reply-To: <aRF5+3NW4V1z8oSi@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106202811.211002-1-seanjc@google.com> <aRF5+3NW4V1z8oSi@intel.com>
Message-ID: <aRUI-eHG2Bg1IOxR@google.com>
Subject: Re: [PATCH] KVM: x86: Enforce use of EXPORT_SYMBOL_FOR_KVM_INTERNAL
From: Sean Christopherson <seanjc@google.com>
To: Chao Gao <chao.gao@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Nov 10, 2025, Chao Gao wrote:
> On Thu, Nov 06, 2025 at 12:28:11PM -0800, Sean Christopherson wrote:
> >+ifneq (0,$$(nr_kvm_exports))
> >+$$(error ERROR ***\
> >+$$(newline)found $$(nr_kvm_exports) unwanted occurrences of $(1):\
> >+$$(newline)  $(subst AAAA,$$(newline) ,$(call get_kvm_exports,$(1)))\
> >+$$(newline)in directories:\
> >+$$(newline)  $(srctree)/arch/x86/kvm\
> >+$$(newline)  $(srctree)/virt/kvm\
> 
> any reason to print directories here? the error message already has the file
> name and the line number.

I want to fully disambiguate the file, e.g. KVM has multiple versions of pmu.c.
And on the off chance someone unfamiliar with KVM breaks things, to provide a
more verbose hint on how to fix the issue.  We have a similar "rule" internally
related to mmu_lock, and the initial implementation of the rule simply failed
the build with no diagnostic information.  It was incredibly painful to debug,
and I want to avoid foisting that experience on others. :-)

