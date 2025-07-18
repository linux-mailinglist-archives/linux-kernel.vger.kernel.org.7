Return-Path: <linux-kernel+bounces-736782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8C2B0A1C8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 13:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1A4516BE5D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 11:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66A3E2D838D;
	Fri, 18 Jul 2025 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaUgI9tG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CD42D77F9
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 11:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752837355; cv=none; b=YbAxMR4MEMkA1CEYMefRCeZMg7IEUN9ymrbbjqjIqcuZcguUE2NExpGwJy4n7Yj/y7a1w2m3AqS0h2IeVVKN0N2EeTNQiY6vPiqnHUwUicMUFJggiFDObYorrYuuH2EuE/TUHlQjcRzp+Wem+uW8f3J/j34rTaBbtf+iNYUtKfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752837355; c=relaxed/simple;
	bh=BBCIJJlDLwuO3Rt2Xfz64r1W7I7tZy0awNIPraZD3KY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUAXzooZ4kYIVWgTOrnp8fj4+bhi6r/uHNu5MiXVF+r+OjdNi4CaplmnMxMe4lfnKTfyhA0UZa8GpnWAz453nzsKyK6hnNZxOp9zGgDUyvLcXQqQZZjTulURjOnc85QXtgn3sWw9U9m1pe2mX7s/STXjehJs1Oh9jhZJ4BnJSso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VaUgI9tG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752837352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBA7xsX3f/iwBHfD/uycAAiF9tf7BvrMU968pipgS30=;
	b=VaUgI9tGvW4pBJWnO+zwLz2ajQBexG4dWQaXqduGwRCu7t8bEPfTEUnchox2bpKM1NcS/J
	acY0suN/S2eKtQuDTs8TRs2faBxfR1EeJVX5f+mtL/95lah/NKbzzRK70TfmZtUEDkQ8u0
	M4NV+kYP6ff8eeMOoYsxG52DHDPDRgs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237-A2XbugNzOI-A-GL0-R6hkw-1; Fri, 18 Jul 2025 07:15:51 -0400
X-MC-Unique: A2XbugNzOI-A-GL0-R6hkw-1
X-Mimecast-MFC-AGG-ID: A2XbugNzOI-A-GL0-R6hkw_1752837350
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31220ecc586so1944894a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 04:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752837350; x=1753442150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBA7xsX3f/iwBHfD/uycAAiF9tf7BvrMU968pipgS30=;
        b=mbukfIQbh8hFUNBB1w481Pym1+oUX9dpkVV73sCE5zBWqT8bHGzKAONYDaSCvBtjMO
         kwDZJOO26QX7nJHYRZNOes6BbGUr8KYSWNssnYQIPfK/HHoxrWHLa5GqwfhaeTUjOdsS
         7YmaCPFIiHk1veybrZGboxrYG7IUu4yeEkOA8Zj00ahNgR1p2uoHcMwDvipO5aukjxqc
         9eTQY0ITQwEZiS+LXeEFMzHVTY+XFAAhOMdU5y1T5QSRQ4E69lOr++hUa5MZessCrqyn
         4mcKWjIsPLUl5G40Tuhmq/C1YvcpnEGen2aZfXK1cpPRt62ZxbJjyP7Ua3QrZ0hQOVL2
         z2dw==
X-Forwarded-Encrypted: i=1; AJvYcCX833cmuqO7LnP1REFIPqz4HLh4O/MELyGIj7q8gM+wZcn8JHf5ONEeJPowpwH4OhgQOP8cbByuywkfHJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbbTiKV2GoR0spcPb6KSYQ0ZahvAVyEJma+VqJ9UVet7QDiKBc
	OxJ1NBWnorh810HYWUIclPbsxdQgBFHH8D6XeB1cx7rZZ42os9Ewn2OunYemRM5WyVoaSSD0XKr
	fBZ6ulnOjiXS/q6YywddA13Jpv08ySRPmuSYmhhDGjRsxzg2VF2FN+cPsojP5N1hkAFOoOO+zi5
	t/TvKc7s9Yd3aKyEvXQb0jMCCOox9fzriONv/A0WPR
X-Gm-Gg: ASbGncuSnXrCZ1scmJnUJTGf4pUk/m+PVcSE5ZfAoYqEzzn8Q6sF5o+amFRfVRePNAQ
	wWTqgE2xGYOW2WtvAaRIoDeFFoljaIBVo7zwS8VqVQyHUkeH1vGEV0MJ/G4tUrZk6hSE1oikmXD
	AuFxWoncPKc2xUVaFgxuc=
X-Received: by 2002:a17:90b:4fcc:b0:312:e1ec:de44 with SMTP id 98e67ed59e1d1-31c9e77050fmr15952278a91.27.1752837349696;
        Fri, 18 Jul 2025 04:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9QbxoyibgZZyMUpEIKM/wsW0LKvXoPiVOFHYBhjUnG4a++/+O1Hcc5xvbKFBhDfEiitqwkezMta44uTRF0SM=
X-Received: by 2002:a17:90b:4fcc:b0:312:e1ec:de44 with SMTP id
 98e67ed59e1d1-31c9e77050fmr15952224a91.27.1752837349203; Fri, 18 Jul 2025
 04:15:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718062429.238723-1-lulu@redhat.com> <CACGkMEv0yHC7P1CLeB8A1VumWtTF4Bw4eY2_njnPMwT75-EJkg@mail.gmail.com>
 <aHopXN73dHW/uKaT@intel.com>
In-Reply-To: <aHopXN73dHW/uKaT@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 18 Jul 2025 19:15:37 +0800
X-Gm-Features: Ac12FXwz4rGUXJq91Ex4E_n4Za48YoQX-dFUm3kg_pscGZgwjRVf5myne0oT9ho
Message-ID: <CACGkMEvNaKgF7bOPUahaYMi6n2vijAXwFvAhQ22LecZGSC-_bg@mail.gmail.com>
Subject: Re: [PATCH v1] kvm: x86: implement PV send_IPI method
To: Chao Gao <chao.gao@intel.com>
Cc: Cindy Lu <lulu@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Peter Zijlstra (Intel)" <peterz@infradead.org>, "Kirill A. Shutemov" <kas@kernel.org>, "Xin Li (Intel)" <xin@zytor.com>, 
	Rik van Riel <riel@surriel.com>, "Ahmed S. Darwish" <darwi@linutronix.de>, 
	"open list:KVM PARAVIRT (KVM/paravirt)" <kvm@vger.kernel.org>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 7:01=E2=80=AFPM Chao Gao <chao.gao@intel.com> wrote=
:
>
> On Fri, Jul 18, 2025 at 03:52:30PM +0800, Jason Wang wrote:
> >On Fri, Jul 18, 2025 at 2:25=E2=80=AFPM Cindy Lu <lulu@redhat.com> wrote=
:
> >>
> >> From: Jason Wang <jasowang@redhat.com>
> >>
> >> We used to have PV version of send_IPI_mask and
> >> send_IPI_mask_allbutself. This patch implements PV send_IPI method to
> >> reduce the number of vmexits.
>
> It won't reduce the number of VM-exits; in fact, it may increase them on =
CPUs
> that support IPI virtualization.

Sure, but I wonder if it reduces the vmexits when there's no APICV or
L2 VM. I thought it can reduce the 2 vmexits to 1?

>
> With IPI virtualization enabled, *unicast* and physical-addressing IPIs w=
on't
> cause a VM-exit.

Right.

> Instead, the microcode posts interrupts directly to the target
> vCPU. The PV version always causes a VM-exit.

Yes, but it applies to all PV IPI I think.

>
> >>
> >> Signed-off-by: Jason Wang <jasowang@redhat.com>
> >> Tested-by: Cindy Lu <lulu@redhat.com>
> >
> >I think a question here is are we able to see performance improvement
> >in any kind of setup?
>
> It may result in a negative performance impact.

Userspace can check and enable PV IPI for the case where it suits.

For example, HyperV did something like:

void __init hv_apic_init(void)
{
  if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
                pr_info("Hyper-V: Using IPI hypercalls\n");
                /*
                 * Set the IPI entry points.
                 */
                orig_apic =3D *apic;

                apic_update_callback(send_IPI, hv_send_ipi);
                apic_update_callback(send_IPI_mask, hv_send_ipi_mask);
                apic_update_callback(send_IPI_mask_allbutself,
hv_send_ipi_mask_allbutself);
                apic_update_callback(send_IPI_allbutself,
hv_send_ipi_allbutself);
                apic_update_callback(send_IPI_all, hv_send_ipi_all);
                apic_update_callback(send_IPI_self, hv_send_ipi_self);
}

send_IPI_mask is there.

Thanks

>
> >
> >Thanks
> >
> >
>


