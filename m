Return-Path: <linux-kernel+bounces-723836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5977DAFEB69
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69BF45651FD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66172E3B0E;
	Wed,  9 Jul 2025 14:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVEWTuMj"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835722E6D13
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069956; cv=none; b=PfCB7GQQP2/PkSnoY9GK8HO2pKFC/fKy750Q6M6vMvEh8qu3ot4s5yjtnCozZv1uRo2WLiWSxPfBYF2bXp5BFyzlntBlNFhMfkApqESSxpGDg8tMzlSy/fteDXkQCeVXxnElxN+vpzpe8cB4bTqpl5JqGMoTUgvDvyIgWfkfTEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069956; c=relaxed/simple;
	bh=Ng6MfePRYUUC8mFtZmcZHQm5RoH2RF9/axmp+qQa16k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HnIAHlE7OIlcZ0DHABcqYegNgKnug2z297ec0foaVs47+VZ/5/3VSOsjAl8rbIp9bSHs8UNWGrS9Rz2UZjNkVVLbzfLKXPZQVZb50n+t3GFq63vXJrJMeIVBkHNQBwbNK7K/ov379Q2OxolF47JJgfL5O0m6isdBpgE3p1kF0d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lVEWTuMj; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so4821367a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752069954; x=1752674754; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ztC/v1aJt1OedYdC5xxwzQz6FBZgIhSizkYtZn2Fkqc=;
        b=lVEWTuMjL561pMfEgVoTX3vvdBio96WScBQQhhM5cHzOuPc9hgTDV5SK+Lw5V7O+2C
         dfZyJV9ZlY+5Md3Cyob3Xppni2QQ+t65YUaWAJ3k7GEQU4MKN+HmI346/v82Ion3oK+q
         967c5BNt5hTzNbqPU5ny4KwoBoJfK7yookYU6Zk1L+XUzK+391BcZ670sd/+fy0gY23H
         MylP4xjKwCdvuweI9ypcWtkr2+sWVlPkyHY7brrE4JcUgP3EWxVdavUfD8r4Q5m5Q5Sj
         zry2lGQxotefryl3DmZ94m0OWVzlkVL0tIIkWbBk1pGVB/oPjDEjuEbNcm2YaGtd2E9K
         KEAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752069954; x=1752674754;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ztC/v1aJt1OedYdC5xxwzQz6FBZgIhSizkYtZn2Fkqc=;
        b=kDAmbpicFArQ9D5PXEUr+E7GAYBSXd+h/YYKVumpfYuPGRk65ldV1YgfWeQn9Hf5HA
         QipmDHUjCPGFH2SgGDxsAJ+5fUlpdAyDk7776yGpnWsnVX2bDNgg77639ycUUpmmKjkX
         Z+RrUfqzuckn7Ofjq9tFnOV9APft2naQjYzndd1Q0Im/ouVnU4CxCyGDixALxw//spJH
         niPXsOYeLAlzXhQFmVTihSHJaeOV2iR8dbfqoVq5ZcTcxFUBcfO2a9GPCdc5muwAD4zu
         Y35SpZKbQwdzitP9dCa/xjRqAynXr1CQgaYkOod5DLEqT3Xc8YWzHe+eSNzfQRi3kNqE
         CtwQ==
X-Gm-Message-State: AOJu0YzTlCt14GkZsoF6sFc6+ZGkZ0hNetJZ87mhkeAXnXKHXlFrrZun
	4sm1Vi3SUpjbZz/9/RaocjpBoS5GthNp7EGk7I0Ifr3LX8YqLh8eZaxV0T11o8NYasQ1ZKJlUHd
	OCLfhOA==
X-Google-Smtp-Source: AGHT+IHHB3U+OQEz4khwRY7IlM9vEY9ArwkC+IXC6/90leBglbJaNJ2XA+RliaruhDIz/AR4+SdHqYUMAGc=
X-Received: from pjbmz3.prod.google.com ([2002:a17:90b:3783:b0:31c:2fe4:33be])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:28c8:b0:312:e49b:c972
 with SMTP id 98e67ed59e1d1-31c3c2a215cmr88636a91.15.1752069953940; Wed, 09
 Jul 2025 07:05:53 -0700 (PDT)
Date: Wed, 9 Jul 2025 07:05:52 -0700
In-Reply-To: <20250709033242.267892-7-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709033242.267892-1-Neeraj.Upadhyay@amd.com> <20250709033242.267892-7-Neeraj.Upadhyay@amd.com>
Message-ID: <aG53QDhdli4lrIDQ@google.com>
Subject: Re: [RFC PATCH v8 06/35] KVM: x86: Rename find_highest_vector()
From: Sean Christopherson <seanjc@google.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
Cc: linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de, 
	mingo@redhat.com, dave.hansen@linux.intel.com, Thomas.Lendacky@amd.com, 
	nikunj@amd.com, Santosh.Shukla@amd.com, Vasant.Hegde@amd.com, 
	Suravee.Suthikulpanit@amd.com, David.Kaplan@amd.com, x86@kernel.org, 
	hpa@zytor.com, peterz@infradead.org, pbonzini@redhat.com, kvm@vger.kernel.org, 
	kirill.shutemov@linux.intel.com, huibo.wang@amd.com, naveen.rao@amd.com, 
	kai.huang@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 09, 2025, Neeraj Upadhyay wrote:
> In preparation for moving kvm-internal find_highest_vector() to
> apic.h for use in Secure AVIC APIC driver, rename find_highest_vector()
> to apic_find_highest_vector() as part of the APIC API.
> 
> No functional change intended.
> 
> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

