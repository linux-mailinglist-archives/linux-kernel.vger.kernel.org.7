Return-Path: <linux-kernel+bounces-885287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 497F4C327D5
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 18:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF7673BBCD3
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 17:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91D233C523;
	Tue,  4 Nov 2025 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/Y2G/ID"
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9007F27FD5D
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 17:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762279050; cv=none; b=UGQvitLL3zOYcZei9FXp0LwD0N0zzlegT6RiFUBSupFw2fCpKD0n/OJ7LaqKYlKlwLxrNwSJMokKTD2kcgFbybAp9CvnEwCZ+pWE1REMd9JnbRsg4q2F1skNVMCGvPjCYROSR2HM7GI0z40eUVPRVorSsJiZ2/y+x+LAmjuzra8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762279050; c=relaxed/simple;
	bh=EKtg11I2y89dxK71syiNOTNg3HE8V+Mj31tEd40SOxE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uiPhxV0OAICrVBpNL+wRJfDoDO/sWiLUs5ehAioyMF9DLlqIOH2SK93GDiGeE7VdWi7VuBZbQXNOpAXo2JuAGerFLxQjg3Z9ZzyllSiMyPJiVQGiBX5t2g+3eKwTUPCn1r/rz+HVjxCDQEmE3sTWooQ9Fr916hxHMD/w9lN834c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/Y2G/ID; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27c62320f16so73197225ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 09:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762279048; x=1762883848; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kxFvD6gKxB44i1bxk1sbjy38espILrC0yFM/UcBrpew=;
        b=s/Y2G/IDayhc9ZswWNjn6octcPCYlhILPFhz3v+4L8a5AdikpkP6RLTaWr9p4eN0OE
         4bK9R/lO9tP8LOUSsNgVSVHx7lyJzm5mQjV033/Hz9PD8sI9QF+twAfqzAKv2Phvur85
         4hZ8d/5tUgGoPIEoSegdrjmI3Mb4VREvwFawZbxwZoJoG/HLI3+chFvf2HJ8dlyGkiLw
         2r/lnp9nKLHkTR96i1rTAD6H6PrQyjk7+fWZDyPM8ZiA30lg36hBq9/aJqOkF/ukAabt
         o31f+Ge8zaEDEC2ju9OOQktY3F1BJA7cU/i0ESF+SK35SvLuVZLo8iVMFAxBWuU3qExt
         XHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762279048; x=1762883848;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxFvD6gKxB44i1bxk1sbjy38espILrC0yFM/UcBrpew=;
        b=pdx9VwJv1PowBqzgY5Baix3Ess5NCGFikAzu2jBDaBKurl7DXQiorO0kroku9FoXTf
         oQioHXUEGMJGa4P+j7GHWr/LDSjoBWPfJvW4h7S8AyIgEpdHd6zw5iC5KVMo/xklp1zf
         1frhzh/RsCgTpRrm5IaMXgKcY9ZqsaOd17sqA5Xya5+W9Vo+VDxBhvg5Kuuj8X/pa7t5
         LoAP7H7n2JnZFfFrJ3fIsWGzFJPI+PCeuzxp/NbuI+aMQMCrD1Y4ygVJ9LgGOVUxU4rX
         2RpwbobtJbmtaGwUMIvY96UNUx2V/U3wXSvflR6HnDbn5rxQo/cMOCBYWoL3LfO667za
         Febw==
X-Forwarded-Encrypted: i=1; AJvYcCXQlvNMxEpoxRGd26T/eeO+bH0fSOLag8toBCKM6JdB/2LOf4bPOlfScGp3nmFLPkn7mhI1AFAmSEgP/1k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/c+XjJHcbx5qKv3mOmCsIyakaGBc+vpCNYb23tZ6uC9SlLeUY
	SOjFrFD22nuBmje3VAgTMJkmXs9LdhAqgLBylVI79lRzECIbmI/LbUSUO4SGnd+7LISSJpvvPkC
	09PcaTQ==
X-Google-Smtp-Source: AGHT+IFJG/V0EfaymcoM6cPfayQ+DGikxVc9kN5RoO6CmqYed2gXkivkS54tuPy9BQi+XScmFB78yDVh2jQ=
X-Received: from plblv11.prod.google.com ([2002:a17:903:2a8b:b0:290:28e2:ce5d])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ffcf:b0:295:2c8e:8e56
 with SMTP id d9443c01a7336-2962ae715edmr5562415ad.44.1762279047867; Tue, 04
 Nov 2025 09:57:27 -0800 (PST)
Date: Tue, 4 Nov 2025 09:57:26 -0800
In-Reply-To: <aQMi/n9DVyeaWsVH@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251017003244.186495-1-seanjc@google.com> <20251017003244.186495-5-seanjc@google.com>
 <aPhjYcOFjL1Z8m2s@yzhao56-desk.sh.intel.com> <aQMi/n9DVyeaWsVH@yzhao56-desk.sh.intel.com>
Message-ID: <aQo-hus99rE7WBgb@google.com>
Subject: Re: [PATCH v3 04/25] KVM: x86/mmu: Add dedicated API to map
 guest_memfd pfn into TDP MMU
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Tianrui Zhao <zhaotianrui@loongson.cn>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"Kirill A. Shutemov" <kas@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	kvmarm@lists.linux.dev, kvm@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	x86@kernel.org, linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Ira Weiny <ira.weiny@intel.com>, Kai Huang <kai.huang@intel.com>, 
	Michael Roth <michael.roth@amd.com>, Vishal Annapurve <vannapurve@google.com>, 
	Rick Edgecombe <rick.p.edgecombe@intel.com>, Ackerley Tng <ackerleytng@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Oct 30, 2025, Yan Zhao wrote:
> On Wed, Oct 22, 2025 at 12:53:53PM +0800, Yan Zhao wrote:
> > On Thu, Oct 16, 2025 at 05:32:22PM -0700, Sean Christopherson wrote:
> > > Link: https://lore.kernel.org/all/20250709232103.zwmufocd3l7sqk7y@amd.com
> > 
> > Hi Sean,                                                                         
> > 
> > Will you post [1] to fix the AB-BA deadlock issue for huge page in-place
> > conversion as well?

If you (or anyone) has the bandwidth, please pick it up.  I won't have cycles to
look at that for many weeks (potentially not even this calendar year).

