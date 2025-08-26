Return-Path: <linux-kernel+bounces-786983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E3DB36FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C23460F6E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1F52D0C89;
	Tue, 26 Aug 2025 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NbbVULl4"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4AE2C0327
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224773; cv=none; b=nnk9ikTy1aG1BvKeEc+qqK72Q/cJOzK8Me5rf7AGVGTs9jI+tMQqKHjoBpxVt7lWncaACVSAXCbewrQTZ56eca85NDsirVg+3dMdHx3eSBhfCeWYedlOaXvfX3yxm4i4X/6lkX8dkkU+ZgEkUPGxKH4xy/9GppqImlhCpSpz3pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224773; c=relaxed/simple;
	bh=lpNJxIxdAxwJxU4ad3K/8xf8SB/3leQSRQ6Ul6aUQa4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nt1+qBiX6nR8R7qlx3uCPjfGpJ7NiLyN5q0fbFoMOxiiNxPAYI47XOYfp+EpKo6xt9S3UqYinVbzguMApXXvZovb8t5LXvWxVkqd8+1pi3sx45XjtYv5OgWH3SuAIhJjTJJatdQz0JPr+v6edWkFeKyrrIATren3bfgDO335kQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NbbVULl4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b29b714f8cso442601cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756224769; x=1756829569; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yShLrZrJiMcpakMkFlTcuZUxFmYo1J+gWIqNEy87nw=;
        b=NbbVULl4/+iaIrPor7/AVhOtfejsNPjYsQgEN4j4GermWgplRx9htSXk252RL5/QBE
         PzgvQvNPSkgJeM3jIZziSFRaD6LoVKiq/WCzYk8+0vd58EQ1KocNcfXTd3qxdAt7aOoy
         /kzE+3pWkErAsluyw13CHNV6XwhZCPuE6TsuGTQXFpYvixE/9HJmKlGnYiD2uvCZ4pU3
         eMHY3Zf/+aAuof8rfC3zraOgm9B4WCGBnuWGxV0TyMvHOodWl7eVuNFbk3Gzt/Ym/wsT
         hZEfvmyruvSOHbIPmMa0t9UTFwspWtRFOGtovRb2aHPMEXOjBz9YxWA8LWKMB4LXMZdp
         M1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224769; x=1756829569;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yShLrZrJiMcpakMkFlTcuZUxFmYo1J+gWIqNEy87nw=;
        b=jdM8IrmwxqMrGuOajcz9zV1SIw3TtyN0NS8o4d6mRXlInxZaE1t3FhyZOfqK067ENK
         qBUN+G8CgZYf0UgtZV7kd5a0WOvSW4qVlrX/BiOLJqdSpHPfD5IpLZQlnpXV/J/EGdaT
         DlgDUMnONM3B83Ds2rBDz5a72WmOr+BJ3r3IOvwDCeKpy7o6OmSMs7uINii80cQhxqtL
         2ZODC+4heSMcxwCr+73AAKlGhfZpa8uehSLgCI5M3kWYViJylOOtkBDKtbrzmm15MhNO
         ilAynB3rdzy1XNgNCYpjbJ5l+eEJGe2KgsEmsO2rvfCWEYsO9M3wcER2FE+Ky3k/3+Si
         wnEA==
X-Forwarded-Encrypted: i=1; AJvYcCWw4c4QJhz9NVSvduxbJXek21O0SO28q1vim3n1nSdBJHetKgJYRx6ht4Jr58bh5Y82rMvyXsrmsGMCTxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4BVWfBzkB8x/KHzk6LcB71mDpqIuTh/QBkomEtYtJ3LZ54dDe
	piYw8UkGCE1WZRR72sudh2RzyJQtoXwWg2o4xIxWJeTUNEeW9QoHASr1UCQIKVOJJ2+9zmP96ih
	ocesME2KtPxa8EJoZhO6epkHEXt7adjGMdge2ymPK
X-Gm-Gg: ASbGncuAZCe5YOYsrigk4T5o+0+VEs93S/mfj79hhBIzFNpIrWzeSM4eG4fI+iHkmGE
	g1Ui3SAIhZH/POk4axzDqDJRxIjVUDGpMN3WY36V7tAY8nK9npTYWQjbJrxRttztgXT9CGbkLwN
	kFN8jUxhqvsGoantHEeqhup9b7O2WVhoBCL6O3LpGXj6BK628V39UI6PR13fwy8gWsSBya+u+Er
	jVf3FtXQl4Cq2Vs8AdcLJKgLohtX2X4Irul/oZIlyuuWvkEbqCkRvKZ
X-Google-Smtp-Source: AGHT+IFVvO6S+pHDrFpICQlKDSU8oqWS2opzl47Wp6F8/5x5K3WItU0qoTqh+FfZuB0xx7wpKAFANxB1M2Uef/LWkQA=
X-Received: by 2002:ac8:570b:0:b0:4a5:a83d:f50d with SMTP id
 d75a77b69052e-4b2e2c1da97mr5618951cf.11.1756224768436; Tue, 26 Aug 2025
 09:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-16-sagis@google.com>
 <94f1eeb5-35c2-4edf-ace7-6917b06bb4bc@intel.com>
In-Reply-To: <94f1eeb5-35c2-4edf-ace7-6917b06bb4bc@intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Tue, 26 Aug 2025 11:12:37 -0500
X-Gm-Features: Ac12FXxRdiH0_Etf0N3MHyniMjmTUDp8DCEiBrUG4BKEG3ue3GXyQJLjbFSxojw
Message-ID: <CAAhR5DGC77bo427gQkvEq_BaJYaYXMgrw9ESq2xp=ER7pQPCLQ@mail.gmail.com>
Subject: Re: [PATCH v9 15/19] KVM: selftests: Hook TDX support to vm and vcpu creation
To: Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Binbin Wu <binbin.wu@linux.intel.com>, 
	Oliver Upton <oliver.upton@linux.dev>, "Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
	Chao Gao <chao.gao@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 3:28=E2=80=AFAM Chenyi Qiang <chenyi.qiang@intel.co=
m> wrote:
>
>
>
> On 8/21/2025 12:29 PM, Sagi Shahar wrote:
> > TDX require special handling for VM and VCPU initialization for various
>
> s/require/requires
>
> > reasons:
> > - Special ioctlss for creating VM and VCPU.
>
> s/ioctlss/ioctls
>
> > - TDX registers are inaccessible to KVM.
> > - TDX require special boot code trampoline for loading parameters.
>
> s/require/requires
>

ACK

> > - TDX only supports KVM_CAP_SPLIT_IRQCHIP.
> >
> > Hook this special handling into __vm_create() and vm_arch_vcpu_add()
> > using the utility functions added in previous patches.
> >
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >  tools/testing/selftests/kvm/lib/kvm_util.c    | 24 ++++++++-
> >  .../testing/selftests/kvm/lib/x86/processor.c | 49 ++++++++++++++-----
> >  2 files changed, 61 insertions(+), 12 deletions(-)
> >
>

