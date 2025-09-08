Return-Path: <linux-kernel+bounces-806542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B29B49839
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 20:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9079D1896EDD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 18:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55C11BDCF;
	Mon,  8 Sep 2025 18:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jLts+UE6"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE3531A574
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 18:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355833; cv=none; b=kBymcd2TqG5xKHeDTyHQQzXoIl53f6d4g9PvDs9T0M8JJxlFgyofRBxcf+9Rp8AVcyi3Ycd72I3XcdNf0SpLH+9TgYssAfKCdt3csceGBBr1H2wtzP6PwbxCgV2a4BZ2h3TyxXsSFTpTQFM1t9SFHw9ZIkkkyA1NVdsVLEXy0SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355833; c=relaxed/simple;
	bh=Plw9JR/aMqfPdB27PDwUiGPqBgnuI2/PGE1uxMuCVwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p021XSIwxoYXBSmMc+T32ey9/YSQcEhRFFUqghW0hUoiojm29Sx8WN5TbsYuK4PEGAMD8uu/zrn3YtDlTcboQ0d6vK8dxjDaqz933M0HQtvii77sQY8RBzn8M8coWuOKF4k1DoD+J85dgPyKB9A13iVm8tRZsMKpqSw9wk/OM9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jLts+UE6; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3278bb34a68so4120543a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 11:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757355831; x=1757960631; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1nSQsxLZOUXb7Htk3aEKe3ifM6QfGlXxpSgXrbf3nV4=;
        b=jLts+UE6wUAUSXj6FIHzwd81OI5W41rTTiDnkiGbbg6gUbPVYMeeVaRAYjRaSndsdu
         OcVp4NMs9SP222OnFkdYChEVh4xLWg9jX3sZeT0kaVez9l+yp6OhZjvTFRxbFeAyVfwl
         8ENqX7go0qWutV9fSLAfu26L5C4/2EQD3414Xk7/ThY4ECVqPTAVr20SyVBJV+WEriLv
         TP61+VRSfao6UY/RZW5GL9AiJVbRUIYUp+deK+0WJSXf1uvwyR4cP36O99Tx2dIRxOG2
         MHEEydn4wyOqocoZlVL4UA26MQa2SrMOmN3qp0aClnkS1zcZSqXrFe4ntP7P2KIs18mK
         Q4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757355831; x=1757960631;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nSQsxLZOUXb7Htk3aEKe3ifM6QfGlXxpSgXrbf3nV4=;
        b=lc+YLNllkMFZUQvGgozv0hbO6Ydhc6p+HoQm1mTTiqqJEY8uyXe0JZBYrIe+/cmyl8
         L64a/YIIN7Kql3yPEl+RZ6CH72AZQWH4cQjlMAOilfBCt4XZ3fOi572kQUeEVWdzhvwy
         ZP+2CFzW1APcHLJKJzYVEkxV9GMs+UoYfXYFd0TOif1U+Vh79W3oENvhAILbgBiDOb3z
         i4VSG1jWKhadMFnuq3LClbMDNf/KDQ9EhNmZ3EhGHfuABA0FjLG/pj7E4I/amrgBN3dM
         rHOmlq+yNrCxeA+IhQruqk8m/hIcWGlTDFSk51Ee+/7EpayE1uLnIKRNBFWdShMEg1Go
         Jhrg==
X-Forwarded-Encrypted: i=1; AJvYcCW+O6kaFyhL1z6IckqvzNJ9xksHguQS15HN2YTYk5oONBkVeqAUaa4FpUuipzZaqvaceyhthoWm03LruYE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7fccxj4Ov/4C7nMGrQFxNuUbbpf6+L/6tYjR7qOTZBE0+WAI1
	bE9655oJdkQJ0rOm2eaC2Mq7j2Q4ZoegXmejGJAZinauX3wLZQdDcs2sNAVrK9IJAdHFpAhKsoN
	l5UL/VA==
X-Google-Smtp-Source: AGHT+IF78R1uV7x1ogjmInLr/cHkHlP92Oatdcz/yCLS1lFHwz0g8eoZ45c4cQIVzgzl4K7+nwozoFhZcTk=
X-Received: from pjbtd12.prod.google.com ([2002:a17:90b:544c:b0:329:7289:8bdb])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4fcb:b0:32b:b8d2:29e0
 with SMTP id 98e67ed59e1d1-32d43f82685mr10534524a91.29.1757355831249; Mon, 08
 Sep 2025 11:23:51 -0700 (PDT)
Date: Mon, 8 Sep 2025 11:23:49 -0700
In-Reply-To: <d378c6b6-68ba-49c0-b480-5d3dec9dc902@maciej.szmigiero.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1756139678.git.maciej.szmigiero@oracle.com> <d378c6b6-68ba-49c0-b480-5d3dec9dc902@maciej.szmigiero.name>
Message-ID: <aL8fNdpoEuSERs-G@google.com>
Subject: Re: [PATCH v2 0/2] KVM: SVM: Fix missing LAPIC TPR sync into
 VMCB::V_TPR with AVIC on
From: Sean Christopherson <seanjc@google.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Naveen N Rao <naveen@kernel.org>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Sep 08, 2025, Maciej S. Szmigiero wrote:
> On 25.08.2025 18:44, Maciej S. Szmigiero wrote:
> > From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> > 
> > This is an updated v2 patch series of the v1 series located at:
> > https://lore.kernel.org/kvm/cover.1755609446.git.maciej.szmigiero@oracle.com/
> > 
> > 
> > Changes from v1:
> > Fix this issue by doing unconditional LAPIC -> V_TPR sync at each VMRUN
> > rather than by just patching the KVM_SET_LAPIC ioctl() code path
> > (and similar ones).
> > 
> > 
> Any further comments there?
> 
> The fix itself is trivial, would be nice to have it merged even
> if the reproducer/selftest is still under discussion.

I'll get the fix queued for 6.17 this, I didn't get much of anything done last
week due to KVM Forum.

