Return-Path: <linux-kernel+bounces-817936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9A1B58935
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 02:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FCE73A4B41
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C7A1A5B92;
	Tue, 16 Sep 2025 00:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ustimBcy"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF1172639
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 00:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757982356; cv=none; b=JbdpLPbJX8BU8/qS5Jq/VXRmdtovxSa4C1Z13mdoMETlj7ZBIeUkPvQhK3fVRoHk4uUhWusP2jMvCyseH5rYLtLBIwdOPdUwjXIRF93KJlTS/jP9sV15H1NEj3h38Atd38er0cbnGay3KA6Fek2SpQcIGK3Hzxr0KCrX/iC1Atw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757982356; c=relaxed/simple;
	bh=E/de48skkARmukqAoxeQ9dfDPu/mldn9SPasCaWg59M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NPv/m4R76SMZuVkTNeyBrybHfKxTv9aIDU4I5KV7JgfciJ1Jchtmp4LzPDGdkLkNwHckmRuNcDLXNPYx4Q/HJGOOtRybL4KmUANGgIlh9+X89sJv0oJIu5vH4fbIigFjOQGKCxvnBwIwQmJDpkkf8pC0fMrJhSrHUfFH0QskGBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ustimBcy; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24458345f5dso57136575ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 17:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757982354; x=1758587154; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BaSliU/Qp9/+sHRYKq5VI0MpnDs5e9LG+HbU1FTeWqM=;
        b=ustimBcyJL9fQImvXMEQHuPEFgtCSifF3ERbSQYLHS8zfbVFBV1KQ73Rtsla7KWezI
         4IuOgYtHzKXmkDXw0vRxfClvmCDizCiE4rRj9i/t58uBQ8YOIR5HzLDByiVXA1LjVpnB
         OMlEpglBrkK/YFfs/rxJqnnolZZSNAPL++3/osZRgp4Sv9TUrwcpyuD3f4ifLApv8rlg
         Ftwo1YILY8MxEAUghBLc6jq6wDWq3UsPpy+LJKAvGoUOrXFtppMmKLqR5xJO21cRjNB+
         RApWmMvy8vMHEJEouXpxcoyzDhtH7NWjjm76F0UC4joXWUqzPRSvbqtTSBIHv1FxMfkI
         W3NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757982354; x=1758587154;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BaSliU/Qp9/+sHRYKq5VI0MpnDs5e9LG+HbU1FTeWqM=;
        b=urGLET0WuuPakiUztPZhkVG58RxS9jgt3VURLBZjnQZq0wXiuXJM1ukajDRBtpmg5M
         SaOAXgj8fV5O8hJgQFl7urQgXuENqhZzbVlcdYM/NZYURIL/5jARrA7uQiITEP99GO4v
         yFFcHTDSScbpGzFBo2LwSggMWpYZOOFZLX70mTTxO1ZuMKKRMhtYME/P7aNdy8Es7wNe
         xB/pV5uR83/klaMfC9JnOCRboXtxFqJj/hBH92Q7VfBMXTT7zrAKuIVLIDFOQExAYCDf
         K3pOAXutEgsUj7IkiAZCHcR+DzGitV7W7/vyUj9RDV3plKkttKI2Y2eit3wJi4g4emRx
         w3UA==
X-Forwarded-Encrypted: i=1; AJvYcCXSFVMgbfoBiT32yLJiJGBkKWIzI3l3M10q2zgd4e3uxNxAvN5ioTYhnENPA5ChcJwa3AnmzQwmBr68Qyk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztw4VJ7tWMa2vKuF73lK8/u+OEzmdWVgwwec96vwErcudeVWY6
	URW0p5HCZkOsTZbA1BcMWZ/+IHuz2aAGe4ddPPNeDJQVKYjgIFNTX7d2EjZ0ej58H5ofvd8dGi4
	01RT02g==
X-Google-Smtp-Source: AGHT+IHOQzoWratRa3KzsT8Q/5SHJa6zw6V9nFNlvLqY74TjeW9ZR9cvV4jCcml3ZPsjaO73z8IOeS9HoRM=
X-Received: from pjbsq6.prod.google.com ([2002:a17:90b:5306:b0:32e:834b:ea49])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:3c2c:b0:24b:2b07:5fa5
 with SMTP id d9443c01a7336-25d26663dcamr173825965ad.29.1757982353968; Mon, 15
 Sep 2025 17:25:53 -0700 (PDT)
Date: Mon, 15 Sep 2025 17:25:31 -0700
In-Reply-To: <cover.1756139678.git.maciej.szmigiero@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1756139678.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
Message-ID: <175798189623.622616.15058554259906842549.b4-ty@google.com>
Subject: Re: [PATCH v2 0/2] KVM: SVM: Fix missing LAPIC TPR sync into
 VMCB::V_TPR with AVIC on
From: Sean Christopherson <seanjc@google.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Maxim Levitsky <mlevitsk@redhat.com>, 
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Naveen N Rao <naveen@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, 25 Aug 2025 18:44:27 +0200, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> This is an updated v2 patch series of the v1 series located at:
> https://lore.kernel.org/kvm/cover.1755609446.git.maciej.szmigiero@oracle.com/
> 
> 
> Changes from v1:
> Fix this issue by doing unconditional LAPIC -> V_TPR sync at each VMRUN
> rather than by just patching the KVM_SET_LAPIC ioctl() code path
> (and similar ones).
> 
> [...]

Applied patch 1 to kvm-x86 fixes (will get a PULL request sent out shortly).

Thanks!

[1/2] KVM: SVM: Sync TPR from LAPIC into VMCB::V_TPR even if AVIC is active
      https://github.com/kvm-x86/linux/commit/d02e48830e3f

--
https://github.com/kvm-x86/linux/tree/next

