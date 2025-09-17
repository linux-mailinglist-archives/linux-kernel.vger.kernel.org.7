Return-Path: <linux-kernel+bounces-821775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08370B82380
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 01:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA30B1BC02A9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 23:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDAB2F6594;
	Wed, 17 Sep 2025 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VmfspLlD"
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A4A23C4ED
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 23:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758150134; cv=none; b=uvEH91VtCMKqh5WzHdLEzndy+sI7CV5o9qoF9eQcJ0NlyB7MMrKr2UPArrn2kd6RsQkqnPEx4t5kgoaM6drhBAneEbsr7gfHXshXNPyakd40RMGoOyKmOujsLDOsKudL7bjVCR6wUg9Vu46dyiYBLLsxRWapT4jUlcYa5P9ioIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758150134; c=relaxed/simple;
	bh=z9jj/dh0S6W2eXpDU5Up7mrUC508ERUUksMpIvjvSDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J5UC5K0BivzDtpeDQOKbuvLqP8pfU/HxShMXzjLcEbrl+kSxhhAcQRlHW1JujJfaeg7SxQDoR5OPvDnnU7tE/5GQ7Md+GfCtgP0EEiboibypQFIleXyLGoJY9FfQwAoiemezTysTRti6I5r7yUh5Y/Hk6lxWseKd0qvnNmcEfKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VmfspLlD; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-3306543e5abso204189a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 16:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758150132; x=1758754932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uXvv08vlixvMjyF5WhKNg9FBBdv11ZBTjvJpc8LmO1w=;
        b=VmfspLlD3G1KH3N9KJ1jNlFurUd1C85SDebTmy2poYgXVKg/LXnR+YaB/xWOd1O6MQ
         MduFC9Wkk8gUEglRIMJWgbjV14iSBkoKeA0AvdLfnVkyGj/snS+XuYSJavgsANKYecxz
         0RpelMdK3AlF44K1Izkujvd5Pu2tVK2WN+z+CSBrNFbsHSLizVsO6T2phYksjY3ggKiO
         NI8IpKLXYKYBsxbeu1FRPlgc2Q/Nhtvlc3y/oSIj0ulpKx52t3zHDt2GRshz5zguoTXe
         fY1ZlUjpRh8cYXGtR40DNUGaiO+nF+hPzsbJXbDU+voaFtdpOkTXEsc1U48oDYpmO6AS
         oZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758150132; x=1758754932;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXvv08vlixvMjyF5WhKNg9FBBdv11ZBTjvJpc8LmO1w=;
        b=N3YTBO0J2NWflczgYZpOLavpFCPieGw5ZK8N/iq1cfcRdTOB+KeatM0w1vTpRq6KmK
         3kAfIKa4La4Vd6uat6ijOEY2b4pUfGaR8HxbtyTseSx0MXTFSUPF78B7tFCicK5QvZoc
         s4bsmSGPFEJsPq3D0CnUvIvYvP3JH/2h7Ao1oRaoRm2FH5miA4jVLwOaLBGO8qa4WWXs
         rfmtEp1SNiXoXFVOZakzQnAQN3eamulvMXWXxc+bX1wuKj+poN4D3GeYxbd41gpnYkds
         +nhhF4bNtcQ2sc8rJCny07pMctCCQHansDfXgfLGh6iYI5+GkrXIEUQmtFSqmFXxVfOF
         u8wg==
X-Gm-Message-State: AOJu0YxOTOMnWNTs0ElgXhQE3Wzi4LFBKJyP32DLUZUkyUIGyPCRRRyw
	UYgGixNs1zWI9wyDv5Hh0zSVbku7hd3FRpAwHfx5Tf1uZ20hWhw8Bd3jX+YeDVLEqb8ejcvkb3I
	773az9g==
X-Google-Smtp-Source: AGHT+IEmHTqPKDw85gYpQLyZoWz4mHqPlxsjsZ3kfl9YZfHWLosdKTXZ1EF54fp4ZzNMDipJWOGGvUoBfQY=
X-Received: from pjkk4.prod.google.com ([2002:a17:90b:57e4:b0:327:e021:e61d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1a84:b0:32e:3592:581a
 with SMTP id 98e67ed59e1d1-3305c6e438emr1476768a91.17.1758150132332; Wed, 17
 Sep 2025 16:02:12 -0700 (PDT)
Date: Wed, 17 Sep 2025 16:02:11 -0700
In-Reply-To: <e0ce7a92-f8e4-406c-a7dd-c59c8d541d0b@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250909182828.1542362-1-xin@zytor.com> <20250909182828.1542362-6-xin@zytor.com>
 <aMmk0lUJ8gs7OBw-@google.com> <e0ce7a92-f8e4-406c-a7dd-c59c8d541d0b@zytor.com>
Message-ID: <aMs986QHpDqk-MSR@google.com>
Subject: Re: [RFC PATCH v1 5/5] KVM: Remove kvm_rebooting and its references
From: Sean Christopherson <seanjc@google.com>
To: Xin Li <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-pm@vger.kernel.org, pbonzini@redhat.com, tglx@linutronix.de, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, rafael@kernel.org, pavel@kernel.org, brgerst@gmail.com, 
	david.kaplan@amd.com, peterz@infradead.org, andrew.cooper3@citrix.com, 
	kprateek.nayak@amd.com, arjan@linux.intel.com, chao.gao@intel.com, 
	rick.p.edgecombe@intel.com, dan.j.williams@intel.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Sep 17, 2025, Xin Li wrote:
> On 9/16/2025 10:56 AM, Sean Christopherson wrote:
> > On Tue, Sep 09, 2025, Xin Li (Intel) wrote:
> > > Drop kvm_rebooting and all related uses.  Virtualization is now disabled
> > > immediately before a CPU shuts down, eliminating any chance of executing
> > > virtualization instructions during reboot.
> > 
> > Wrong.  KVM clears EFER.SVME in reponse to kvm_shutdown(), and thus can trip
> > #UDs on e.g. VMRUN.
> > 
> 
> This patch assumes that AMD SVM enable/disable has been moved to the CPU

Ah, that wasn't exactly obvious.

> startup and shutdown routines.  Accordingly, kvm_shutdown() no longer clears
> EFER.SVME, and the patch demonstrates the resulting simplification from
> removing kvm_rebooting.  However, as noted in the cover letter, no actual
> modifications were made to AMD SVM.

Heh, yeah, that's what's wrong.

