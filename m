Return-Path: <linux-kernel+bounces-846316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 299F5BC78D3
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CB263AF116
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6090260578;
	Thu,  9 Oct 2025 06:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="fDh31YBh"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94C917A2EB
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759991512; cv=none; b=FA7T6TqJnAwSFAV0ylvnk85FNYvbjLnnwqo3GM2WtmelQnj4uWcIWEu9QVHu364aAb4N0JfL3RENJ4jeXXxnghN0BGUaFwoNz4KdmyLatTcI7WD/NoPYuMSyf3Q0TYTeXSscl8pHs3w3B/K8JgoWAA5Tg06WPPVf/6X2Twwjnic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759991512; c=relaxed/simple;
	bh=YWnhHQcSyGlFWhF9IR/pq1cQnmO90pMmUASkR0pB2Sg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=cL8O/W2leUArV5vSvKay7XnHFAyRE4wUME3krydZEZfrd8+OsMqcZEtlQcW8zLaAKVPwrv1+7tZzHUzvNFc2RWA85T9aW/8WdAGzLHADBkmXCZF5mqx+NgpFBMixzGBZuM8cVZvmnduK34J5SVd2J7G+/NjfLPOl4pJGtbo22Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=fDh31YBh; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-46e38c21fafso1159535e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1759991503; x=1760596303; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZphDIVd5tmeP6KAhy58kJYA1PrGr3bDOHMWlYgqBwIY=;
        b=fDh31YBh0j84ookgphRxISNEP0JZRmdqjNrT6DMwcDfLhSBv7jVRoRQi1A743a3DEW
         G7Ll0wq1lAsNxD1maeeg071KVHL64a9iLRo3TEP+x/Ush4P/G1b8MxY9ReiTg7Bgbssh
         S4g0ReyA6aOU36IlFLsbkYbR8itGsw/FEx/yX0++3B0gq6fsPW7vexYlFvBKVPC41Bsr
         QSxrK+mkqVFnGWQQW2DOS1MHSPuyLPpLWcLc/ATeftSUAtb+cKK8pQwYSZAP+hs8Cc/S
         F/Un7LMPtOuH/LzqEzaK7wYLhwBZ7r1LL0djihd8HCY7RQR/a8DeapiDJmvO73cWA3dZ
         YLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759991503; x=1760596303;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZphDIVd5tmeP6KAhy58kJYA1PrGr3bDOHMWlYgqBwIY=;
        b=aGJ88CjhD9P/GmJR0eiWBHCzwJWZfWEuFvdGWHzi8iIi259qhmxvivJEcmBLbPrzub
         ZyzwvTOp4HnaAieq+X8M1MaPYPO55WRLWhYUVszoCTEKrs+4myB5av9QGlVrHZOOywQk
         WzY7vUnQvCYjxKQSnyMsA0UzbSB5xdmwLeDTbxyBQeCXG7T8pp6cmvxSgCv/U3jEyIB4
         VTbEovkxz0CmrypqFEv+9GKSaBmrGaTYAVdtPhbmbnKnjjDLblDzO+xTq3ORhTQkjzh7
         43WQc+63eU8dQSYaljeE8oP/GE9H5fq1qqTIDUnsTWah6sIUdDc3c9zkQsSwe/6UYRpN
         7YWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0n/QfPlvzn7xbq5h4UcxEVcMhTb5LxYruYwwEkjIaMhSNd6H6BxwP/vxJ6qBTy2HQ9K1ZdEvWkstlJeo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuyjScQd29Do43UuYzt5c4SqrUxyL8pumruVlXockcdDH4PBTn
	okb5s3mo2S9L3OfzYgCKmtanBXWY2X51+rHe+t3mt3+8iMEg8sin4MsStjfiaSPRV4U=
X-Gm-Gg: ASbGncuXnfc7hFSFnPHGoAQhKsOJM/1h7bovuc1aPt+ECBQ4HVDtEv8G/07BsRSRaAH
	wUT0YYLKZc4+8iU/kG0j/Isd7Yp2UQkePa42bJzFhXzaAUquxjo7YBl4Ln2UdCChT/IiNrC4kXB
	s1MpkwLlC8otvG5FNg62a5OZBXzuxUvcgGwHboPtAu91hoBvx7pNfroyJr1mXf3qreXfkC6+m57
	4aQ9iLyJ3G9xAPNDQ3NsOcqZBJTYuYQOwCM3VOSVMF0XaUiW9onyVxc7tUIHlyoseKdMYP5gpmO
	JccAr2cR68OIMuJQd0jGKvFNdtAlXb+ItwNp8P7RkK7wqeZmJavQsitA6g7Ki57BYUHln/gix/L
	etp4lfP+iwnDLJVkZOkmGSTsedkyxCCuertIbX8mAxpVNQujK4ESjrflX8Ns=
X-Google-Smtp-Source: AGHT+IEIf07lX5X1t9lPoRt1uKJDa5WT2TozooFfyQvTgQYIm3IKeoNZOzn9APYtFiu6W4PehuHHyQ==
X-Received: by 2002:a05:600c:548b:b0:46e:3d3d:ea92 with SMTP id 5b1f17b1804b1-46fa9b06cabmr25204355e9.5.1759991502804;
        Wed, 08 Oct 2025 23:31:42 -0700 (PDT)
Received: from localhost ([193.86.240.59])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4255d8abf38sm32664903f8f.20.2025.10.08.23.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:31:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Oct 2025 08:31:41 +0200
Message-Id: <DDDKX1VNCCVS.2KVYNU4WBEOVI@ventanamicro.com>
Subject: Re: [PATCH] RISC-V: KVM: flush VS-stage TLB after VCPU migration to
 prevent stale entries
Cc: <anup@brainfault.org>, <atish.patra@linux.dev>, <pjw@kernel.org>,
 <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
 <liujingqi@lanxincomputing.com>, <kvm@vger.kernel.org>,
 <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <tim609@andestech.com>, "Hui Min Mina Chou"
 <minachou@andestech.com>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: "Ben Zong-You Xie" <ben717@andestech.com>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20251002033402.610651-1-ben717@andestech.com>
In-Reply-To: <20251002033402.610651-1-ben717@andestech.com>

2025-10-02T11:34:02+08:00, Ben Zong-You Xie <ben717@andestech.com>:
> From: Hui Min Mina Chou <minachou@andestech.com>
>
> If multiple VCPUs of the same Guest/VM run on the same Host CPU,
> hfence.vvma only flushes that Host CPU=E2=80=99s VS-stage TLB. Other Host=
 CPUs
> may retain stale VS-stage entries. When a VCPU later migrates to a
> different Host CPU, it can hit these stale GVA to GPA mappings, causing
> unexpected faults in the Guest.

The issue can also be hit with a single VCPU migrated over two harts:

  1) [hart A] accessing X as Y, caching X->Y in first stage TLB
  2) [hart B] remapping X to Z, sfence.vma
  3) [hart A] accessing X as Y, instead of correct Z

Migration from 2 to 1 does hfence.gvma, but that doesn't flush first
stage TLB, so the translation produces an error due to stale entries.

What RISC-V implementation are you using?  (And does the implementation
have the same memory access performance in V=3D0 and V=3D1 modes, even
though the latter has two levels of TLBs?)

> To fix this, kvm_riscv_gstage_vmid_sanitize() is extended to flush both
> G-stage and VS-stage TLBs whenever a VCPU migrates to a different Host CP=
U.
> This ensures that no stale VS-stage mappings remain after VCPU migration.
>
> Fixes: b79bf2025dbc ("RISC-V: KVM: Rename and move kvm_riscv_local_tlb_sa=
nitize()")

b79bf2025dbc does not change behavior.
The bug must have been introduced earlier.

> Signed-off-by: Hui Min Mina Chou <minachou@andestech.com>
> Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
> ---
> diff --git a/arch/riscv/kvm/vmid.c b/arch/riscv/kvm/vmid.c
> @@ -146,4 +146,10 @@ void kvm_riscv_gstage_vmid_sanitize(struct kvm_vcpu =
*vcpu)

The function is now doing more that sanitizing gstage.
Maybe we can again call it kvm_riscv_local_tlb_sanitize()?

> =20
>  	vmid =3D READ_ONCE(vcpu->kvm->arch.vmid.vmid);
>  	kvm_riscv_local_hfence_gvma_vmid_all(vmid);
> +
> +	/*
> +	 * Flush VS-stage TLBs entry after VCPU migration to avoid using
> +	 * stale entries.
> +	 */
> +	kvm_riscv_local_hfence_vvma_all(vmid);
>  }

I had some nits, but the approach is sound,

Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>

Thanks.

---
There is a room for a RISC-V extension that tells whether the two TLB
flushes are needed, or hfence.gvma is enough. :)

