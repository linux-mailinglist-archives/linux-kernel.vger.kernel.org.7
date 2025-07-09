Return-Path: <linux-kernel+bounces-723844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F365AFEBAC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 16:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04BD566E6E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E678B2E8DE9;
	Wed,  9 Jul 2025 14:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fo+dVGE+"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2E62E8DED
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070027; cv=none; b=uSdBXbmMno2wrha9Dw5Fq8ZMt43ZJ3SPrXs4jCSqq0MG9zqlsFoBu6y0akLDsv7I/2j2BTteRDKkT6qpeA9bRUiV5/q5IcyJOkvwgAotIQ4VCYN3Y3qxoU+XDhVV/4UyxtpE5m+Pc/VcQOGpfweXSDwUEu+lNlkGS2VXLl8TYEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070027; c=relaxed/simple;
	bh=LJafJh5xCNMq1ouGVqPO4QJrs9QZXQjwYEc57uay5eI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=F9GgpX3ydWp2SjvrL8rw2ZnHq9dQFuNUXSnpmyyQ1n05bphg25shvHGwb7Plp5L6mRLlZbRW/M5P051P/fg23lKXCDnageQma+LGnlHNq38t7qwQVSFZvVI2duSjMdcajzg6bS0Tkq2ZuJ5hz34XcE8y9yBev6idzmcoDc+G0Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fo+dVGE+; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b31ff607527so4134750a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 07:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752070024; x=1752674824; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cmcguu9UCBEWTTsjlEJwXa1dAvNETj0uDtiVn25gJe8=;
        b=fo+dVGE+5q470LwpG8ikF/rM5t+hipIoAghM369HC6vcoCKptSzhAsy4SLOtekwKC3
         6OK5asxO0B1Y2COCxm9Qeb2TxzQUTJRMIe6AvO/v0fWALTNznxOoL60cj6TxRN9LJa3g
         SHYuThK78Tp5URxQsoGTfDSLkmQDr0UsT6dgdvlhluAz3F09SHcYkOkPYDKJhskeEZK1
         NYX/SQkZjbn82giH71HYkAkraCDqBR+JQIQlHjpBnrLEyioSmkQ4OtUKt73aE+224tHZ
         pjIhm/Uy7vbobTHlb3gGTZaZmuko7zITgNEqYvh7FVUWRiOO+BGL7may824MHnlak0ao
         w2Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752070024; x=1752674824;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cmcguu9UCBEWTTsjlEJwXa1dAvNETj0uDtiVn25gJe8=;
        b=Kn30x+U9ugUN8odFXzMxYQCDbnDwAfSPCCcdyo9mlZY8qnx09q6uLHIL5xXpjvoq8y
         VubGl2NbuC1A4h4uaHjX5plr5v6MY3+g+8gzwCR9fvLsEP9Jt0aMqB8pB8TZVr6ix0Ls
         2Q4NFTJPBgJ1ax8Bn8k6h4tUdogCD7xjhICDcPr+wY6Rm65zfTiGLQOI6tKgvT9nmjHP
         aUDQTOGnlBSVT9c8w3fU+JgmNApD2WqKtxeLzCFMmuGlogXjUHdChYvsOPoak+iQgH9q
         jzUkvpTRgoeJzsElaOCpw/ddw5onXICxRIB90mKm11t1ARdXB9fNiPtXIjSXtidWhGEK
         YWFg==
X-Gm-Message-State: AOJu0YwgDxq9l0qRMT6bZ1ytiPzs0ufN1U/71ZALNj/KP8+QwbLgWAUe
	Jc0ExzD8G1VfXwGr80r75LCcodzCcaDvozDidOb5Omg7pZkZIZBJ/HzJzMSdROOJPVf6CEpe+Yg
	zF3uWlg==
X-Google-Smtp-Source: AGHT+IGiLDmO9tNUZfK8M1pEp/RxQc8CmRskg2wRHx06WOqlp7dEAHwv1HMGlLulwL0mtGCwLp1D/JwbiWE=
X-Received: from pgc17.prod.google.com ([2002:a05:6a02:2f91:b0:b2c:3d70:9c1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:682:b0:220:21bd:75c6
 with SMTP id adf61e73a8af0-22cd7c9dbc9mr4663887637.33.1752070024417; Wed, 09
 Jul 2025 07:07:04 -0700 (PDT)
Date: Wed, 9 Jul 2025 07:07:02 -0700
In-Reply-To: <20250709033242.267892-13-Neeraj.Upadhyay@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250709033242.267892-1-Neeraj.Upadhyay@amd.com> <20250709033242.267892-13-Neeraj.Upadhyay@amd.com>
Message-ID: <aG53huKPYCxmAZGQ@google.com>
Subject: Re: [RFC PATCH v8 12/35] x86/apic: KVM: Move lapic set/clear_vector()
 helpers to common code
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
> Move apic_clear_vector() and apic_set_vector() helper functions to
> apic.h in order to reuse them in the Secure AVIC guest APIC driver
> in later patches to atomically set/clear vectors in the APIC backing
> page.
> 
> No functional change intended.
> 
> Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> ---

Acked-by: Sean Christopherson <seanjc@google.com>

