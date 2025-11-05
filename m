Return-Path: <linux-kernel+bounces-887201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8BBC37876
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 20:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8F223B9C61
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 19:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9638F341AD0;
	Wed,  5 Nov 2025 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HAKZpPRO"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75DB31355C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762371871; cv=none; b=BE2omkx5o25sHzklUC44bvryQWySEIDPZ7P6xN8oQft28itZGTSIu+OWHrvQ6QLUpw+kEisCGA5Gvr6jv+2QZKFG1ZERuiknlTYNwpokWkXpFuy6tJibNtZz6ao6kB0aGfKThQUFY2bI4MHOJN0TkX9UZCY0CP+U0qy3l9jJWRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762371871; c=relaxed/simple;
	bh=F1PLsq9xm+III7HBdcj18czd5KsIWEZ81RMxhvzVsNg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c0zTmy7QX/5RltjNd4uHwkaMHxx7kSeeB8fY9roqlTlF94VR9Aa3E9NYGmj45VCiHHeIJ9H5dg+k4TscWXtlBknPkRhSqy3Ua3ajj+ZCKaAoZd7vOsgs+slm+7k41v376aLX4ETGAkGPw1vbSc8NudqzntSq0ZpjrVdA1R0h2Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HAKZpPRO; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-341661973daso237889a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 11:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762371869; x=1762976669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K8ZK0MiZ1hzn7iH0lOR2KZ5CJE/Z492UpE0NsitI4ac=;
        b=HAKZpPROeyWEmoNXYbZCWAf/QHh47RVnABxelKbu8ysPRNzzl7e7qGLAzW7PvS6n5K
         7eB3jqr9d+P1H4BV37W/lh2s3kPha1D7Jw8REzCfe+h/9Ugg9CL6sxOE2joLKlwiX5uy
         XQQr8oCzvnWf0P58S3yGP9dCyd+SiQTvz/g67TyAuvgNub0meEUM6CJocvYxTHPmYySF
         7eyya8TlVN6nWjFNP7bdLx9FodfmquHascYSE0DkgLHfas+1VRh3TK6UzbFRbGDH394R
         +lpMUllEBKR1/uSUGJ/cqCkP2gdLv9KRUVYMtd6i4Y88bB77h0fwMcHnf5aptZxUM/8G
         iNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762371869; x=1762976669;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=K8ZK0MiZ1hzn7iH0lOR2KZ5CJE/Z492UpE0NsitI4ac=;
        b=jVSQlNAq4/cUkarrzGs7KxGgC9rlLTxB77J2ozxOHL6xYTH5hUdPpsVmXVALZPAlnN
         u+Voz3e1DKJfuNkBll//h3Zfzf4SwEEFg1pbhQA+/Sr+DFmOBp5mj5KuZYg0bU1Rgq5Z
         ve6TitUa0+m8Ko+Jp3a9F/M8sXZ9PA6cTEAj8XhZabaZvgi9pCetqc+56W1ctqF4AzHi
         EV3d0FjXNsE9awU/188etiiEQwQgDF6cMWzHyzWYKWe7UQ2pn+RfY88egAH4Be6I/GnK
         Y3vuTAGCBLCfRcH5qXfPmAbGDF1Sz1d7OfDdiL+w5g01d01Rlj/6cAsjKl/ay+8ayHnr
         a6Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUmJqXwvGGXrb7mGdF+Edx8ajdpimMmmAucA6+WEBp2a+u5dKdOVsWiGkOPOEy7cpqDZCiJqgoo2zNueBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcD2SjFAHCsupHKRU8N5p+xlIs3yVZ+qJh92Faff4s2Psh/Dxy
	+pOdAwQfNPi3gVC4zGsXY7NjKio2UbAKzguES2hw35uViKUOVFnM74tLsIUhkAgmfcHd5sR1+Ki
	jhPUVuw==
X-Google-Smtp-Source: AGHT+IGUe19WzjgS7NVl1on3cCWT7NzacMbeJ7zc1z1lSJo6Mtsb4w1JefM4Y086HcyZXcE3ju6dHq1EPBY=
X-Received: from pjbca19.prod.google.com ([2002:a17:90a:f313:b0:340:66e4:4269])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2dc3:b0:340:f05a:3ebd
 with SMTP id 98e67ed59e1d1-341a6dd9a30mr4900591a91.28.1762371868572; Wed, 05
 Nov 2025 11:44:28 -0800 (PST)
Date: Wed, 5 Nov 2025 11:44:27 -0800
In-Reply-To: <20251024192918.3191141-3-yosry.ahmed@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024192918.3191141-1-yosry.ahmed@linux.dev> <20251024192918.3191141-3-yosry.ahmed@linux.dev>
Message-ID: <aQupG93pUl-IYx8G@google.com>
Subject: Re: [PATCH 2/3] KVM: nSVM: Propagate SVM_EXIT_CR0_SEL_WRITE correctly
 for LMSW emulation
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel, 
	Matteo Rizzo <matteorizzo@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025, Yosry Ahmed wrote:
> When emulating L2 instructions, svm_check_intercept() checks whether a
> write to CR0 should trigger a synthesized #VMEXIT with
> SVM_EXIT_CR0_SEL_WRITE. For MOV-to-CR0, SVM_EXIT_CR0_SEL_WRITE is only
> triggered if any bit other than CR0.MP and CR0.TS is updated. However,
> according to the APM (24593=E2=80=94Rev.  3.42=E2=80=94March 2024, Table =
15-7):
>=20
>   The LMSW instruction treats the selective CR0-write
>   intercept as a non-selective intercept (i.e., it intercepts
>   regardless of the value being written).
>=20
> Skip checking the changed bits for x86_intercept_lmsw and always inject
> SVM_EXIT_CR0_SEL_WRITE.
>=20
> Fixes: cfec82cb7d31 ("KVM: SVM: Add intercept check for emulated cr acces=
ses")
> Cc: stable@vger.kernel

Bad email (mostly in case you're using a macro for this; the next patch has=
 the
same typo).

