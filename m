Return-Path: <linux-kernel+bounces-672522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88932ACD07A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 02:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FDEF18974B2
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jun 2025 00:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDFD256D;
	Wed,  4 Jun 2025 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zCSvPv4q"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A657F9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Jun 2025 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748995820; cv=none; b=hu8ARgahT7hDXWe7gxKR3P0HbbXxyA4QqyGz3gqRNNhf/3OBHJdygkvQUCzzWnPmbKxNjEoX4jOvinjNvnu1K6kHS6v4x95TLWwDtmoyvBdqC3sjOBsWWuj9MTfCKVfCrSqMr/tvidrMKb5+TLrXvDXc7yu+f56dcuwtB5RQA4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748995820; c=relaxed/simple;
	bh=euBdrbs6b7CGc1XbpBBv0ZF6753p4h21n3PSCsN5nIg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=czV79oydD9Dn45H6C0bZMqx7nq+hg1qrojere2C/sx21r+ZEiKC8PlR+7o/5gqFgkSxHiCMKnQhWJwyMmHZU41LkwcBRuUinZAKEg8WR1WFIL/NLNt8BJfmhRTFbGTQ/nlR1VZBbLGWnMvHs/Wn6TaMYQm5BsaSbUDI26RxPLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zCSvPv4q; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b26e73d375aso6814287a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jun 2025 17:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748995818; x=1749600618; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gOfI6BunB5EjpKnjOgGcW4vcCGSHarmNLnezDicVUWU=;
        b=zCSvPv4qyQ17ood9k/tU9nf+TW75qc+Xnk8RI/WGdcYW+/KWo94R+Fp+53QctMwZPH
         DkZH4PywKbyqnsnpaxg9NOEu36MtxqUalkrt+9tgI87IC0thk6MdtbMDxkl9nB3yAbUL
         ucDyDCLtNyKklQjez/jdo4bXBrHQC5Aa1nLRnXimOwVaHKnP2REL5ycIpJfho+K643Jx
         QGyFZj+1SyCPV6sCNLRkb2c9Bbq2iu6cFNFKB3VczbQgV/QAq4858OjHM24sxlLcQmR3
         5kQG4qthn3eUV/Tmjrnvf8bIQIHBdXJei3B6qZYWGcDYQt9S8MURWscCgAVcRWqP1xOt
         3rlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748995818; x=1749600618;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gOfI6BunB5EjpKnjOgGcW4vcCGSHarmNLnezDicVUWU=;
        b=vZaAwYd+HHiHaABh9qTafQaHQLT8ALz4PYIrs//4ZrJbQOHu8Xt150YqMYLEGlLzZ9
         FbW2d5vjudc1kKEqeh2wLA4j/S+dlsaCgcXNxnIfXH+QCARv2jTUvuys/ReTkHAKv19S
         /Ch3B2HlhZmWXIpT/MjXoUyBWwboG5gf9/M+QvwK1/M7eEPQwH/5RJiYWGisnsFBRIEa
         TuaDLq95OBzgd5xA+3m9UkF3Uis9t7rTeeGB4C0NlNg4dEFcOo7Ndqrog0pbkEr9/Pw3
         ngnSTcmsnMIXbm0OgTWhugO4swge77shw+C6kfnBNHL3aLScRoTtCKNylaCbCL5XwvZs
         y5Ag==
X-Gm-Message-State: AOJu0Yy+Uk2DzrBCixv3KlmqDlzw1I9rX+qrRTvjUizE3JNVatAEC4S2
	ODwmO/bSXHgnirnKz7RVNnXg0ttsLtA3W1aJEU7tjofjUsVXHRsJoov1+VIWRgFvFTDM1yH6PAN
	s1vw3lQ==
X-Google-Smtp-Source: AGHT+IEZyiSLy8Ge+hshHc76Ex2llg0LkSoj5004GpA5PILdPk6C5xY+TyGEuIWbmybjXt5bCyuflXVgFX4=
X-Received: from pgbfy27.prod.google.com ([2002:a05:6a02:2a9b:b0:b2c:433b:f32b])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:9190:b0:21a:c058:9b8e
 with SMTP id adf61e73a8af0-21d22bcd433mr1259933637.34.1748995818077; Tue, 03
 Jun 2025 17:10:18 -0700 (PDT)
Date: Tue, 3 Jun 2025 17:10:16 -0700
In-Reply-To: <20250401161106.790710-3-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250401161106.790710-1-pbonzini@redhat.com> <20250401161106.790710-3-pbonzini@redhat.com>
Message-ID: <aD-O6EBMqPwLzgd_@google.com>
Subject: Re: [PATCH 02/29] KVM: API definitions for plane userspace exit
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, roy.hopkins@suse.com, 
	thomas.lendacky@amd.com, ashish.kalra@amd.com, michael.roth@amd.com, 
	jroedel@suse.de, nsaenz@amazon.com, anelkz@amazon.de, 
	James.Bottomley@hansenpartnership.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 01, 2025, Paolo Bonzini wrote:
> Copy over the uapi definitions from the Documentation/ directory.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/uapi/linux/kvm.h | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 1e0a511c43d0..b0cca93ebcb3 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -135,6 +135,16 @@ struct kvm_xen_exit {
>  	} u;
>  };
>  
> +struct kvm_plane_event_exit {
> +#define KVM_PLANE_EVENT_INTERRUPT    1
> +	__u16 cause;
> +	__u16 pending_event_planes;
> +	__u16 target;
> +	__u16 padding;
> +	__u32 flags;
> +	__u64 extra[8];
> +};
> +
>  struct kvm_tdx_exit {
>  #define KVM_EXIT_TDX_VMCALL     1
>          __u32 type;
> @@ -262,7 +272,8 @@ struct kvm_tdx_exit {
>  #define KVM_EXIT_NOTIFY           37
>  #define KVM_EXIT_LOONGARCH_IOCSR  38
>  #define KVM_EXIT_MEMORY_FAULT     39
> -#define KVM_EXIT_TDX              40
> +#define KVM_EXIT_PLANE_EVENT      40
> +#define KVM_EXIT_TDX              41
>  
>  /* For KVM_EXIT_INTERNAL_ERROR */
>  /* Emulate instruction failed. */
> @@ -295,7 +306,13 @@ struct kvm_run {
>  	/* in */
>  	__u8 request_interrupt_window;
>  	__u8 HINT_UNSAFE_IN_KVM(immediate_exit);
> -	__u8 padding1[6];
> +
> +	/* in/out */
> +	__u8 plane;

We should add padding before or after "plane"; there's a 1-byte hole here that's
hard to spot at first glance (ran pahole just to verify my eyeballs):

  struct kvm_run {
	__u8                       request_interrupt_window; /*     0     1 */
	__u8                       immediate_exit__unsafe; /*     1     1 */
	__u8                       plane;                /*     2     1 */

	/* XXX 1 byte hole, try to pack */

	__u16                      suspended_planes;     /*     4     2 */
	__u16                      req_exit_planes;      /*     6     2 */
  }

Probably pad before, so that "plane" is just before the xxx_planes fields?

