Return-Path: <linux-kernel+bounces-726701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B19C3B0102D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 02:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF46C1C80992
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975D8BE4E;
	Fri, 11 Jul 2025 00:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EOowp1f8"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A608F6C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 00:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752193797; cv=none; b=l4vhu7gnM7lcA3/z9Ik7L+VHs1TJ7O+yXb7mtlryhlBFSPAH+ZmbjY8WaPgyu7Rq6LcsdiWyW7fWUoVfoUzNooiDLesxfRtc2dnZgqnJwmhqLRP3yuM5Q9M/WibYZC7hflRQJbOPJg67ZYeqfrGYdDtqw7FoQbQTSLrWwFtEpGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752193797; c=relaxed/simple;
	bh=r0lPHxvs43uR+dHXcIrd5JAul1oKL023d8VVoNs5Xqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c+lBmTLWiVdb2affEXjwrg/vuTjgpQdRfJdDncL36X95rZRKJqYRACwdPVhNk1D1rf0kxeX2OJsdB17aADeJpPQUCwHYiumiahkaL69YZrJOGlUEvdxN6bq80aquIT5juExm+v7+t2hrpwFI+JC0I8bTEihif1/aWd2a5Gkhrx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EOowp1f8; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8b3ec5c82eso2237658276.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 17:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752193794; x=1752798594; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r0lPHxvs43uR+dHXcIrd5JAul1oKL023d8VVoNs5Xqk=;
        b=EOowp1f8ECHDega+HXidInFVYyVXOPGTJmAqlOau+hIRS1qPbq+/u86DEnodphUkGE
         oU0eZAC7ADM9pG69HxOvrzdFLT30vAXYkrQFosAL7PtmkroZJHLFYLDzrCLQPYfJHbSf
         S6lPjVHx+wE1Xhu3p6MzCSerjPMimJbEygfjitIwuPfos0yph8JAny/kJLEjAIDc4/S0
         bDsLIVfaHh11bkHmuLvrKIZ/kBpbCJOlIYLRdO/u2oWi3KLqlrmIckZbJtcIUvAHA7Ug
         FO4QRF0FVViixtDUBmaemoAU14QPOZOaR/N8/vFG3Mw2yCO3tl+i/HBirh/qpLWScJU1
         M24A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752193794; x=1752798594;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r0lPHxvs43uR+dHXcIrd5JAul1oKL023d8VVoNs5Xqk=;
        b=QtZ7jnBgdS51IiZJSuKjgNUxrBFkE8hyUUr1K3k3Tb2D5T4g0zXFEzAGpuutpPSAKL
         I0lmpbVesuMUjWfBo+8Se0JCZddq35Nw83sX+VzXlAxfjXoGt50mgOb9wn58HSDMY6bL
         25UtMyxnWTnDeGddg9lzF3Z/yFoIktWCosJ++PySYv0wiwu/3PB31lx/HX3qq/ylH2Ff
         TepJiu3jgXzW8c113mIkYqNuv5fyuEzrELWAPbysc1Zfg7DjNHHiG4qtAofA81mKkAnU
         FR1ZnKYodG8q+scdyr/6vsb4ARug2QsRCr+t+kNrVFQ9hzyVN+l+jJOXqlQ8MClsMDDi
         aKng==
X-Forwarded-Encrypted: i=1; AJvYcCXHb5/pXTIMInVkQSGqpxsqyCSdXWFvu38skl2EfgcGQfpucqfDeLoOEHh38PVEvh9d7V0BrFUqZ2dWVpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqJc9qDUwwIrvIl9p/IHZWXYPBqUHoqv8AVuPZJSX4zmigQTyP
	falkoX+4gCdO5Vd1KJSM2XDnDBPo7XMvzhs6Yk8T44VXNKx/fHEziK9VMtCk77Vz+ni6p0rdONZ
	Pa4OkadaCJCJ3wm6SlTazsBV+rQnezRU7pJRpNkKA
X-Gm-Gg: ASbGncvsbGUHRtiyDaZe9jyd5VQlk8WbxkU/u8KYNpGzMhfGzJMt9+LdaOk6imaVCBA
	coy+SYR/UcE0xoBVvpDiDlNeaner6X7NrGKy4VnVhlB3dgM93XdDBut5DUKoc+eVkVoUsEzoipU
	aMHO0sNk5h9OxKJjpkmIxBBP0wL4wt+cmOZ/K1R6L4ncOc2ogzbqJok2ZJbOrj0eVNNOidOVqEl
	WHUor3pbIPBMPdKY4Oj8/RFnBcZ3VeNAo/u
X-Google-Smtp-Source: AGHT+IHo5wOXiLQsn/5Sf9V/dYLksjYkGC6K5+8xIfEcLBdrtFqnS93Qdoy+B89S9yKZhvHKYo4pICjWraZMAWP5GVU=
X-Received: by 2002:a05:690c:23c2:b0:712:e082:4300 with SMTP id
 00721157ae682-717d69d151emr22793207b3.14.1752193794242; Thu, 10 Jul 2025
 17:29:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711001742.1965347-1-jthoughton@google.com>
In-Reply-To: <20250711001742.1965347-1-jthoughton@google.com>
From: James Houghton <jthoughton@google.com>
Date: Thu, 10 Jul 2025 17:29:18 -0700
X-Gm-Features: Ac12FXwp99zxVbMC_VhJYh2XiCFZAUQ9b0PyTNfZpbH7kwWeLapvYsalM8A6msk
Message-ID: <CADrL8HXQBfT2MLUEW+0w4P0weCjCOWdDpp3kSu5uta4-vtXn2Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Fix signedness issue with vCPU mmap size check
To: Paolo Bonzini <pbonzini@redhat.com>, Sean Christopherson <seanjc@google.com>
Cc: Venkatesh Srinivas <venkateshs@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 5:17=E2=80=AFPM James Houghton <jthoughton@google.c=
om> wrote:
>
> Check that the return value of KVM_GET_VCPU_MMAP_SIZE is non-negative
> before comparing with sizeof(vcpu_run). If KVM_GET_VCPU_MMAP_SIZE fails,
> it will return -1, and `-1 > sizeof(vcpu_run)` is true, so the ASSERT
> passes.

:%s/vcpu_run/kvm_run/

