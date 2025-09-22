Return-Path: <linux-kernel+bounces-827376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356E8B91949
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 16:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F7FE2A0338
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 14:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F481A5B9D;
	Mon, 22 Sep 2025 14:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IqInX6e7"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C9119C54F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 14:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550069; cv=none; b=tGtUcqgRO0F7MdVrQPVIWL2Mig/F53P/cBragsnDZayO60uZft11NDCbasEFyDO8hPBJ3+SxGA+PlfALirMXPHjT0o1pbP3tgcI2i8If1+WUDZk5q81LLKfUkZbYSBaWTvF1URetspLV049G0XR1IuMe4B+VTCS2mAglv3mMZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550069; c=relaxed/simple;
	bh=tyVaKuWfBFWx5BCJG3YHH2FqroIs/me67hugzU/cs1E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RcKlywORLW+4814ry/venCR8SG4mGud/wgC+02oHa8MrCysGKxar7KqF3x7bLXTLOLaGWRFNj2OymXQwobleG7vWvZX4Nn6PgCgfMQeoLTMfgTu6yiwvRIyWTe5Qm7nvOPFyyA/aHwB8oQS0Jc8onTET8n6XQobMPReAGsWAdu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IqInX6e7; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77f3feba79cso1370652b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 07:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758550067; x=1759154867; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3dmlNt4jLc1yhAOfhdIXu4MYWVCnFVgG6lvtlLOwUWU=;
        b=IqInX6e7CChcpmarSsZ+sKol2IkJJ7uyTnHJjiJ0CpoLIlCcupUSjso5/cjtMhLyhC
         ECzNHtdeMbbKRl6Zr9DwWgS17Ejnw06Cvv/vdjV7UHrdTOSnFSJzSpEy6yagBPbsVkmV
         TrYu3lFv98JOrVideQPhDPeLZO/Q6UZvcfh3qLQUr5zV9CMtiURVwKX7X56X8Ef1T31B
         Wmyflvt9iNdXElT15lvw/M+F3HOe5zd8PrXpgM5evygzVBzbf6r661ngyCYCTrAUosWb
         24tzmJg1tovehKMRLKzPlh81gzNjJYjqSf7gDOnvFyJRGuw+0Lm9ncxmad4uZH8fnt0I
         YsiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550067; x=1759154867;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dmlNt4jLc1yhAOfhdIXu4MYWVCnFVgG6lvtlLOwUWU=;
        b=TmGn42c4DxxgHow5tRGpEuPvLw4eA/rY/FcGabkdUzldxmvtZd3vGCG9pMeDlp3AoB
         9XyXyMy2fVicNmXEmjTb0M/h0GmLo+PVBXf+1h1E/gmkkx8sDUHA/dKnx4NhroY3nPJ5
         U2y22KNlJ7M3ZZjB380EEeJ2mmg1ALfESmrR/8rPHAWlD0gSmitgMJ1z1r0T9LyZ/wk9
         jGbIURbucsBsceyjGvTRfavSMtMqh9ZH8lbW/BjkVsuZwwQSVjzNBaxq1ZOyKx3YNxRD
         Mi+F5qe1h2m+e2Wg1Ub7Ukp1/doZaUGQGs9kPqTZzY6RSeqEq3JxMDZ0hddyrlME4TzC
         jSKA==
X-Gm-Message-State: AOJu0YzfPOE6zbcJDlDvTSslY1yI7IwnnTDsRryyRO+IFhKmZ5o7oNiv
	9OBiEPui+CzYgQS/Huvo8xYRW0yr9K59B4clidwWuejMrje2TBP6nb4cWmiPlQOUrZQbg/G57I9
	5LN1FOQ==
X-Google-Smtp-Source: AGHT+IEQgl2gi//t5TMBNwdIo1/6h8UVZtuDwgvBJmY3sChy40TPMSAvclGNeiDctfhD/fxxvR5QJK4JDjI=
X-Received: from pfbei54.prod.google.com ([2002:a05:6a00:80f6:b0:77f:4904:b672])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1907:b0:771:fdd9:efa0
 with SMTP id d2e1a72fcca58-77e4e5c5576mr13905425b3a.15.1758550066926; Mon, 22
 Sep 2025 07:07:46 -0700 (PDT)
Date: Mon, 22 Sep 2025 07:07:43 -0700
In-Reply-To: <aNEAtqQXyrXUPPLc@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909003952.10314-1-bagasdotme@gmail.com> <aNEAtqQXyrXUPPLc@archie.me>
Message-ID: <aNFYL2Os3rbfMbh6@google.com>
Subject: Re: [PATCH] KVM: x86: Fix hypercalls docs section number order
From: Sean Christopherson <seanjc@google.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux KVM <kvm@vger.kernel.org>, 
	Linux Documentation <linux-doc@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Wanpeng Li <wanpengli@tencent.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 22, 2025, Bagas Sanjaya wrote:
> On Tue, Sep 09, 2025 at 07:39:52AM +0700, Bagas Sanjaya wrote:
> > Commit 4180bf1b655a79 ("KVM: X86: Implement "send IPI" hypercall")
> > documents KVM_HC_SEND_IPI hypercall, yet its section number duplicates
> > KVM_HC_CLOCK_PAIRING one (which both are 6th). Fix the numbering order
> > so that the former should be 7th.
> 
> Paolo, Sean, would you like to apply this patch on KVM tree or let Jon
> handle it through docs-next?

I'll take it.

