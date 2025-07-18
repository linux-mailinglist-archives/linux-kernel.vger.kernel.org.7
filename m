Return-Path: <linux-kernel+bounces-737099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89047B0A7BA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 17:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5B8A3B43EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 15:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E0E2DFA3E;
	Fri, 18 Jul 2025 15:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2qKsFjhb"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4066A2DFA39
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 15:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752852806; cv=none; b=m+nu/0aMf29I6S/+miTdzUFO22MaHrHFeCos3F2Evi+oc9jAyWE3f+BGYnb6ZbUMjDvcVvkArnz0AvI+x7ozTcegSkhNHR/Zq+SMJwDAusfhxqQSuq2qPRsRRpRABkxfEgyk321qNYwSY2RzXnk2O77mvxufeZqE38WuEBhW/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752852806; c=relaxed/simple;
	bh=geRwiammgshPEkZTEfrGjM87emalk67t+A5KtRwbf2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GynyqsF5Z8DCZ6TZmPcNoYohSlItovxtijfh0rQNHO25CLOjsAf9hFdKYuQ+w797f9hkK0lMqvDdx0pq5pnnHl78GSga+39m542U1cpc7am8/s8royf7luOaDQHIDRfp2etR0p91lwthtyLLycbUBuxk3v7IFhv4gMCthLgN+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2qKsFjhb; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313f702d37fso2332110a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 08:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752852804; x=1753457604; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5YSpj+1IV44+FVqvcifw9o0LIVQ8kEqDMxNOHmhaNXw=;
        b=2qKsFjhbQLjVWB2kyJYM2qRuZA9mGnDIku7hAj5ldIlifoPCQzYny4FmkFqEWtk+I6
         dzkGNVVcbmnN60ci+fHG6+GvmiAYgmNGowexH94D68ox4aqm5PeQf4w2mOTp9Clxenzx
         qPdKmQJSMD1H2f8SnNwf8v7/CxG97ZFWBfK/nerxhatn3hTNyxXT65p+4KrKnAJndVLv
         cFJbDwh3p0BdCuRhErBIRuFGLgAbNOr6gcAMHAsJk2Do8RsVSlqjxy3uCRpoKPqe+XI5
         NSPVLUEe7yZkvuXWYGRQJI0GhQjsQvaY2XWwsLqAYueFbH+LoOOUs0fdE4inrxu7GJkI
         CjSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752852804; x=1753457604;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YSpj+1IV44+FVqvcifw9o0LIVQ8kEqDMxNOHmhaNXw=;
        b=Y+t6rlFoQGpDcfgSMXxi+0ZInF9tc/YMUXBZbTJERJsWl0R2aDvpnI+a1eARbihbnx
         KTWyaYZlWI6/CxPiNKIayaf/CZ1iiHlBCkGiVAQ1Dtor8gVDrd8I/AuWKMLdPxo0IT48
         Rdq9tTUDekEwKxA9DUX29fypc9WIRaHVRYtIs3iRn2irY3EkidoZ6NozD0ktR3QXC1sk
         1+NpKsgYLhFKvYjGvZlNzNCwTsvqMRIrqfbVUjq02cq/S87wKWMFKwAgL2C2zyLF/mAj
         M5MwNtlk7ILJc2sOhTLb4dRlQL4VivPn03DU5gI4QUpQv8OVzu3WamuJIj3TInlMGboo
         +jEA==
X-Forwarded-Encrypted: i=1; AJvYcCXpDtCnW69ezKe76iLWYAyyMCFefuCD7b1OHN0hH8YpOHwTAUKtusXtlXE81DxnXUzdSRU0EHje3F6ysWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFVZTGTL4zXP96LMCCm+8AG0RsFbxmhuM66NBmu90tBQypQ3ZR
	KMGSRv/gemxHFzkGORDDbWZFQbxvStxyLEO2M0OeW/3b+LMTMgGuNvxD2sA2u9XGi42GhbQ7E0O
	3UbELgA==
X-Google-Smtp-Source: AGHT+IEucQrf6BnU8TPUHyXRYZd0lenwR3GNHW7YqoEv+LTUasMyddo4Blp0+FuBeMJX3DZ+HCVXGBvFB+4=
X-Received: from pjbsn8.prod.google.com ([2002:a17:90b:2e88:b0:311:6040:2c7a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2ec7:b0:311:ef19:824d
 with SMTP id 98e67ed59e1d1-31c9f435537mr15265871a91.2.1752852803229; Fri, 18
 Jul 2025 08:33:23 -0700 (PDT)
Date: Fri, 18 Jul 2025 08:33:21 -0700
In-Reply-To: <c502a550-3856-4c21-8546-b4b1abbd0abf@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630202319.56331-1-prsampat@amd.com> <20250630202319.56331-2-prsampat@amd.com>
 <aG0jxWk1eor1A_Gd@google.com> <a5dbf066-a999-42d4-8d0f-6dae66ef0b98@amd.com>
 <aHBCosztx8QWC4G0@google.com> <c502a550-3856-4c21-8546-b4b1abbd0abf@amd.com>
Message-ID: <aHppQWM5TKPD7JpD@google.com>
Subject: Re: [PATCH 1/1] crypto: ccp - Add the SNP_VERIFY_MITIGATION command
From: Sean Christopherson <seanjc@google.com>
To: "Pratik R. Sampat" <prsampat@amd.com>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ashish.kalra@amd.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	herbert@gondor.apana.org.au, bp@alien8.de, michael.roth@amd.com, aik@amd.com, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Jul 16, 2025, Pratik R. Sampat wrote:
> 
> 
> On 7/10/25 5:45 PM, Sean Christopherson wrote:
> > On Wed, Jul 09, 2025, Pratik R. Sampat wrote:
> >> Hi Sean,
> >>
> >> On 7/8/25 8:57 AM, Sean Christopherson wrote:
> >>> On Mon, Jun 30, 2025, Pratik R. Sampat wrote:
> >>>> The SEV-SNP firmware provides the SNP_VERIFY_MITIGATION command, which
> >>>> can be used to query the status of currently supported vulnerability
> >>>> mitigations and to initiate mitigations within the firmware.
> >>>>
> >>>> See SEV-SNP Firmware ABI specifications 1.58, SNP_VERIFY_MITIGATION for
> >>>> more details.
> >>>
> >>> Nothing here explains why this needs to be exposed directly to userspace.
> >>
> >> The general idea is that not all mitigations may/can be applied
> >> immediately, for ex: some mitigations may require all the guest to be
> >> shutdown before they can be applied. So a host userspace interface to
> >> query+apply mitigations can be useful for that coordination before
> >> attempting to apply the mitigation.
> > 
> > But why expose ioctls to effectively give userspace direct access to firmware?
> > E.g. why not configure firmware mitigations via the kernel's upcoming
> > Attack Vector Controls.
> > 
> > https://lore.kernel.org/all/20250707183316.1349127-1-david.kaplan@amd.com
> 
> Something like Attack Vector Controls may not work in our case, since
> those are designed to protect the kernel from userspace and guests,
> whereas SEV firmware mitigations are focused on protecting guests from
> the hypervisor. Additionally, Attack Vector Controls are managed via
> boot command-line parameters, but maybe we could potentially change
> that by introducing RW interfaces for our case within
> /sys/devices/system/cpu/vector_vulnerabilities (or what the final form
> of this interface ends up being).
> 
> Another option could be to expose this functionality in a subdirectory
> under /sys/firmware/?
> 
> However, with any of these approaches, we would still be giving
> userspace the ability to access and alter the firmware, similar to
> the interfaces that expose features such as Download Firmware EX
> also allow, right?

Not all userspace is created equal, e.g. init_ex_path is a module param, and
(un)loading modules requires CAP_SYS_MODULE.  The expected/desired use cases also
matter, e.g. if there's no use case for toggling mitigations after initial setup,
then the interface presented to userspace could likely be much different than if
there's a "need" to make mitigations fully runtime configurable.

