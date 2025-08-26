Return-Path: <linux-kernel+bounces-786979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC81B36FB1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 18:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58E4C2A732F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 16:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A68313E10;
	Tue, 26 Aug 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqI8YPkZ"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C1D2C3761
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756224640; cv=none; b=C+QVe9sJd6Vn4XMe7kj1yJ3NAivt/PVyh2wt3/UgevPqomb2V/D/63cMYxebGxdivsO1CyXlBs5cvi2wDGKV+VnmPM9s5TFzbKpxCEyGRZSRPruL15PEWGNTh02Q1azxNeGmLtenvgbk/ff55bAqmHKWSB5Gc8HdQMj6Jkq8OXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756224640; c=relaxed/simple;
	bh=uUnVxVTDDWqmWBh2MGBUnTCtl2B8bgs4dvqdJBWjcdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uxWwT5t71at+aRs3fp07bVGTQAtpudRZh9BYfIDSCr1jla3A9SXoOSPSn5mbw/r0hgEKHs7V1FA7rz/boT+PgUDDE6Uznva5DJ6PECLtNVt+hOMtONq9OWcHpJ81fHetHXD4UNdfEXdoDlVdYkXSVyWluQD7UfGgFscPv/hf6M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VqI8YPkZ; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4b2dc20aebbso530561cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 09:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756224636; x=1756829436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZ5a9wW/sXjVhC8FVp7iGuvAwGNBd64MKlntfi+5SYs=;
        b=VqI8YPkZdcakCUIOg0W95u/5xJd46E9f/RukLu7o34XennhQ3iadNtDxw9fkeM9/wV
         lmdxEbw2+1ga8lAyw/muWK/lmhJiihLxrgxt5/ngmdf9QeXjUqCdHNd+b/pSLBa7VAyP
         YRc6M/gUkdmxZc9MltIo5EZlUfh1yYJ6lVpugy9WK17E/qPV1CnLwZjOsEOSvZ4woGY9
         Wsn+HHyCEDgHHuy8MJ0RQge3rVBMlmoBQ95BfluhlDSFrf0nbJPIGVbEO7iFJU891mFt
         Ayw255a3hBGsnS8ee6lrJUUle9zgqucgUXU942jUh3jWP+lSiwJI+rQ56rr5+yU9f+bF
         FCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756224636; x=1756829436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZ5a9wW/sXjVhC8FVp7iGuvAwGNBd64MKlntfi+5SYs=;
        b=LQS4y2yugu3sJKlFmU44sMz0fn7PkxWajI1ICBlnDapKGhwupByD6wmX3+FJ+BhWT4
         +j6NV1QK1I0grhBB3PHcbIRtAZHtkxHOpkpQUtVzCSfTd7T8V0t5uyfwgs3Afr5XUORJ
         AkeMDfR5pfkUnYIoJrrAYwe374YvZ0wLWrsq5L2E7JkvpVi4uSGSnrYN8uW4PdDWi3SF
         qEM7J1g1x0tOKpcEmie+r5sDaTbOqDkU53LRayyMG76ZWb70tc9+Y/f0AV4xF+c79fOV
         FhUVX0/D8lQYZBEMSNl9b2eX1C8k0pJRnBvq9kVBpVcoXVTrOEjZDoTFh6X2GtBAwURW
         y7qQ==
X-Forwarded-Encrypted: i=1; AJvYcCVECDKCc2oR9/D4vqgR3TeyCKq0+HOaqfIAepYbujn03e1J4n7S3pfOo64PPijTQbityaZS7JkBSmYubHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCd7VVrA/61JsJDvRIP2VVsYv7AUpC04cnNF8WLJO334n4FXNI
	e8ZDKcOkHDboWICWPxsRm4gCJlOebpGOYPZSeW03g6qVI3ovzjVqMmfNsba8sK/mY0pdEbD+r+K
	YcSjvuOPUIX+LQve4FAvXPG79dOBiwrKIieA6NHGo
X-Gm-Gg: ASbGnctgFtkBmrDtzDdyEllhuvPGaz9jWINBw5EpuwmOsuyaa1TxsRxh9JOQexqcmkD
	6FUyoZnf9WVQJcp6DEJyBiRMY0ws2GCwIgeCFL8Kj3rABZqJDQI7C9fX1EP9OIJGNXJ5noIpXaC
	hhKCzrpowEaUpvVrCNS8+ItlJ0SQ2VsyyLp8Ejp1vWoRVubeEBOG35W9d2I5LrUmoTHnvRrBqIq
	pQJ7WfbHrkiFzMWzSkcrL2NJqG2Fo8QMvEI0BLvFHtuog==
X-Google-Smtp-Source: AGHT+IFWTBnegYsgo4t+bTINOKl+X+5UHJwlAppipz3z1BODi/VrNOUY4vQo1AxTw0v14VFVG4iZb3RcvckoStjmph0=
X-Received: by 2002:a05:622a:118c:b0:4b2:9d13:e973 with SMTP id
 d75a77b69052e-4b2e1b31275mr6506651cf.0.1756224636084; Tue, 26 Aug 2025
 09:10:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-9-sagis@google.com>
 <d780a249-ecb2-40e7-9520-19de8728c703@linux.intel.com>
In-Reply-To: <d780a249-ecb2-40e7-9520-19de8728c703@linux.intel.com>
From: Sagi Shahar <sagis@google.com>
Date: Tue, 26 Aug 2025 11:10:24 -0500
X-Gm-Features: Ac12FXzjoQma6pYvJ2NYaJoeraToE-BsC5fTbwE_cSx2Q5p4AW62eAtBhQOjCPE
Message-ID: <CAAhR5DHVhS29egfT4aDA5HGnHkM0fQRfU5600ossaVGdvNgCGQ@mail.gmail.com>
Subject: Re: [PATCH v9 08/19] KVM: selftests: Define structs to pass
 parameters to TDX boot code
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 1:52=E2=80=AFAM Binbin Wu <binbin.wu@linux.intel.co=
m> wrote:
>
>
>
> On 8/21/2025 12:29 PM, Sagi Shahar wrote:
> [...]
> > +
> > +/*
> > + * Allows each vCPU to be initialized with different eip and esp.
> > + *
> > + * __packed is used since the offsets are hardcoded in td_boot.S
> > + *
> > + * TODO: Replace hardcoded offsets with OFFSET(). This requires gettin=
g the
> > + * neccesry Kbuild scripts working in KVM selftests.
> neccesry -> necessary
>
> Also, are the comments about "__packed" and "TODO" out dated?
>

Thanks, I forgot to update those.

> > + */
> > +struct td_per_vcpu_parameters {
> > +     uint32_t esp_gva;
> > +     uint64_t guest_code;
> > +};
> > +
> > +/*
> > + * Boot parameters for the TD.
> > + *
> > + * Unlike a regular VM, KVM cannot set registers such as esp, eip, etc
> > + * before boot, so to run selftests, these registers' values have to b=
e
> > + * initialized by the TD.
> > + *
> > + * This struct is loaded in TD private memory at TD_BOOT_PARAMETERS_GP=
A.
> > + *
> > + * The TD boot code will read off parameters from this struct and set =
up the
> > + * vCPU for executing selftests.
> > + *
> > + * __packed is used since the offsets are hardcoded in td_boot.S
> Same as above for "__packed".
>
> > + */
> >
> [...]

