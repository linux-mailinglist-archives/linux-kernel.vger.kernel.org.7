Return-Path: <linux-kernel+bounces-735664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EABEEB09249
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965347A5719
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84752FD580;
	Thu, 17 Jul 2025 16:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="do7rrhQW"
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF162E36EF
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771365; cv=none; b=esmmc12cvkQbAKK/I65ATjL0OwwQ1dJ/sYWkO3OMdnQj7VT/wPUloy1CRqkZExRZHG/P2Bx+vvv765dK8tklGDqP2G6zMpqht6qq1gSxw83UeID4Lpl0PwkSo7bm+v8QJuPE2UfhiNI9uudf3NbZ+7GEzq8wzrhKJGI61ldTyF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771365; c=relaxed/simple;
	bh=oiWWGXY/ZhkUfsSKuD6veSuHIoiki619k4jyqYPZ4hY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L6CX4RP4abMXnmyuaG3/3sNrpAvEDS/oKAAJcBW9NwfF71dZRfTOgPpgc8j7EmSOl7EHXmo80/XxVGT5jn8Z+11Sx19KXTNbzJNexP1JKc+S97xEv26SsPdiX0lWCNdi0fNB2Z3abtUvD1UiQTGnat8GjfmmxnowxbTagpccUhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=do7rrhQW; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-313c3915345so1710689a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 09:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752771363; x=1753376163; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YtKaXiis7X8OUZ8IxU2O9gUN20EGW8+A38M9nr3POFE=;
        b=do7rrhQWaSACO5YZHj4l754Y4Gq2ijoRB6GT/RMhVTJVRoyXD3Wgr9Eelvop8GU/IO
         7/qDNfwqKGhAJMioMtz0OLTOYGX8RDRaa9fh4ALvjRzpT8Pyw0OXUOmDe9LkJVdWfqtn
         ypjAsHgcj08IstV98nbv90ArQvSNelVP+aSDB69xEs2e8eyfZZCxIw+US8dMBRYzeWxw
         KHw+i4cn1F0wjKJVyStRbCq2BcOejZQWpOqXphvTdSRjjdxqqvN//rQOQC8OMpBXFPut
         8Bfce7prNrrax/6LYJFy7vX5KHIN902B/FHnhPwBH7e53MplVNvElyrn+gW/bcE26d0Z
         i8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752771363; x=1753376163;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YtKaXiis7X8OUZ8IxU2O9gUN20EGW8+A38M9nr3POFE=;
        b=EOgV224BvBxjI6dKGzJXBLU8f5PwRPZB/BsY59dNr1wY92ZEMUkB8SCdn8oa8fQ+kH
         VWwtjl0r9Nl9jggr/MhcqLFolZeUIY93RvutLb4oaQZYO3AFSRNslrh29AQvMyQFHXVC
         vU4/8SCB6pINERdjAo3riRJpbmpc0hlq6QXffFJjeeGPCe7fChwG7IKH7B0seZHdj+23
         g53veiKChnSAo369DVaZCY/133QmhheERERNvs3sQz9gJksuIK9GtpWtZw3H73+hGybx
         nKf192a+AmibrnQHDr9vLWbE/PEBRL+sZMITSr6PvxfY+1zL8p3iNyIjs90MGETtbphe
         73Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWhWfXGI0y99HzmrMhTATsMHiG7ejl6tSpfBoUW8IDyPkX4e2g/0mhql4htsm89nICBM2IEqG24u8pWKak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4fjgNvGyGl422YKB09pYwiWgrcYuZW64WhgZuBiHX/QNF0PJ/
	qmW3lMsbNsOrNjROrD/0ThEvvZRS3d7Hv08L6hPPGmvn/KeDNLiXowN7g8OIIy0GKoltYGo3tyR
	s8/c+c2iMknTlL23+NlXjN5CtrQ==
X-Google-Smtp-Source: AGHT+IGT+Ip7MN3kC7WfmhPlW1Zbfs3wNc+DIuzQ2qHyU4q2gnwNyjohySS08EGy0S5iPmKjYIt5Af/xFOvpCcEiDQ==
X-Received: from pjg12.prod.google.com ([2002:a17:90b:3f4c:b0:312:df0e:5f09])
 (user=ackerleytng job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:2584:b0:311:df4b:4b81 with SMTP id 98e67ed59e1d1-31caf8ef446mr4773759a91.25.1752771362614;
 Thu, 17 Jul 2025 09:56:02 -0700 (PDT)
Date: Thu, 17 Jul 2025 09:56:01 -0700
In-Reply-To: <aHjDIxxbv0DnqI6S@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <d3832fd95a03aad562705872cbda5b3d248ca321.1747264138.git.ackerleytng@google.com>
 <CA+EHjTxtHOgichL=UvAzczoqS1608RSUNn5HbmBw2NceO941ng@mail.gmail.com>
 <CAGtprH8eR_S50xDnnMLHNCuXrN2Lv_0mBRzA_pcTtNbnVvdv2A@mail.gmail.com>
 <CA+EHjTwjKVkw2_AK0Y0-eth1dVW7ZW2Sk=73LL9NeQYAPpxPiw@mail.gmail.com>
 <CAGtprH_Evyc7tLhDB0t0fN+BUx5qeqWq8A2yZ5-ijbJ5UJ5f-g@mail.gmail.com>
 <9502503f-e0c2-489e-99b0-94146f9b6f85@amd.com> <20250624130811.GB72557@ziepe.ca>
 <CAGtprH_qh8sEY3s-JucW3n1Wvoq7jdVZDDokvG5HzPf0HV2=pg@mail.gmail.com>
 <aGTvTbPHuXbvj59t@yzhao56-desk.sh.intel.com> <diqz8qknhj3l.fsf@ackerleytng-ctop.c.googlers.com>
 <aHjDIxxbv0DnqI6S@yilunxu-OptiPlex-7050>
Message-ID: <diqzqzyeg3j2.fsf@ackerleytng-ctop.c.googlers.com>
Subject: Re: [RFC PATCH v2 04/51] KVM: guest_memfd: Introduce
 KVM_GMEM_CONVERT_SHARED/PRIVATE ioctls
From: Ackerley Tng <ackerleytng@google.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: Yan Zhao <yan.y.zhao@intel.com>, Vishal Annapurve <vannapurve@google.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, Fuad Tabba <tabba@google.com>, kvm@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-fsdevel@vger.kernel.org, ajones@ventanamicro.com, 
	akpm@linux-foundation.org, amoorthy@google.com, anthony.yznaga@oracle.com, 
	anup@brainfault.org, aou@eecs.berkeley.edu, bfoster@redhat.com, 
	binbin.wu@linux.intel.com, brauner@kernel.org, catalin.marinas@arm.com, 
	chao.p.peng@intel.com, chenhuacai@kernel.org, dave.hansen@intel.com, 
	david@redhat.com, dmatlack@google.com, dwmw@amazon.co.uk, 
	erdemaktas@google.com, fan.du@intel.com, fvdl@google.com, graf@amazon.com, 
	haibo1.xu@intel.com, hch@infradead.org, hughd@google.com, ira.weiny@intel.com, 
	isaku.yamahata@intel.com, jack@suse.cz, james.morse@arm.com, 
	jarkko@kernel.org, jgowans@amazon.com, jhubbard@nvidia.com, jroedel@suse.de, 
	jthoughton@google.com, jun.miao@intel.com, kai.huang@intel.com, 
	keirf@google.com, kent.overstreet@linux.dev, kirill.shutemov@intel.com, 
	liam.merwick@oracle.com, maciej.wieczor-retman@intel.com, 
	mail@maciej.szmigiero.name, maz@kernel.org, mic@digikod.net, 
	michael.roth@amd.com, mpe@ellerman.id.au, muchun.song@linux.dev, 
	nikunj@amd.com, nsaenz@amazon.es, oliver.upton@linux.dev, palmer@dabbelt.com, 
	pankaj.gupta@amd.com, paul.walmsley@sifive.com, pbonzini@redhat.com, 
	pdurrant@amazon.co.uk, peterx@redhat.com, pgonda@google.com, pvorel@suse.cz, 
	qperret@google.com, quic_cvanscha@quicinc.com, quic_eberman@quicinc.com, 
	quic_mnalajal@quicinc.com, quic_pderrin@quicinc.com, quic_pheragu@quicinc.com, 
	quic_svaddagi@quicinc.com, quic_tsoni@quicinc.com, richard.weiyang@gmail.com, 
	rick.p.edgecombe@intel.com, rientjes@google.com, roypat@amazon.co.uk, 
	rppt@kernel.org, seanjc@google.com, shuah@kernel.org, steven.price@arm.com, 
	steven.sistare@oracle.com, suzuki.poulose@arm.com, thomas.lendacky@amd.com, 
	usama.arif@bytedance.com, vbabka@suse.cz, viro@zeniv.linux.org.uk, 
	vkuznets@redhat.com, wei.w.wang@intel.com, will@kernel.org, 
	willy@infradead.org, xiaoyao.li@intel.com, yilun.xu@intel.com, 
	yuzenghui@huawei.com, zhiquan1.li@intel.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Xu Yilun <yilun.xu@linux.intel.com> writes:

> On Wed, Jul 16, 2025 at 03:22:06PM -0700, Ackerley Tng wrote:
>> Yan Zhao <yan.y.zhao@intel.com> writes:
>>=20
>> > On Tue, Jun 24, 2025 at 07:10:38AM -0700, Vishal Annapurve wrote:
>> >> On Tue, Jun 24, 2025 at 6:08=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca=
> wrote:
>> >> >
>> >> > On Tue, Jun 24, 2025 at 06:23:54PM +1000, Alexey Kardashevskiy wrot=
e:
>> >> >
>> >> > > Now, I am rebasing my RFC on top of this patchset and it fails in
>> >> > > kvm_gmem_has_safe_refcount() as IOMMU holds references to all the=
se
>> >> > > folios in my RFC.
>> >> > >
>> >> > > So what is the expected sequence here? The userspace unmaps a DMA
>> >> > > page and maps it back right away, all from the userspace? The end
>> >> > > result will be the exactly same which seems useless. And IOMMU TL=
B
>> >>=20
>> >>  As Jason described, ideally IOMMU just like KVM, should just:
>> >> 1) Directly rely on guest_memfd for pinning -> no page refcounts take=
n
>> >> by IOMMU stack
>> > In TDX connect, TDX module and TDs do not trust VMM. So, it's the TDs =
to inform
>> > TDX module about which pages are used by it for DMAs purposes.
>> > So, if a page is regarded as pinned by TDs for DMA, the TDX module wil=
l fail the
>> > unmap of the pages from S-EPT.
>> >
>> > If IOMMU side does not increase refcount, IMHO, some way to indicate t=
hat
>> > certain PFNs are used by TDs for DMA is still required, so guest_memfd=
 can
>> > reject the request before attempting the actual unmap.
>> > Otherwise, the unmap of TD-DMA-pinned pages will fail.
>> >
>> > Upon this kind of unmapping failure, it also doesn't help for host to =
retry
>> > unmapping without unpinning from TD.
>> >
>> >
>>=20
>> Yan, Yilun, would it work if, on conversion,
>>=20
>> 1. guest_memfd notifies IOMMU that a conversion is about to happen for a
>>    PFN range
>
> It is the Guest fw call to release the pinning.

I see, thanks for explaining.

> By the time VMM get the
> conversion requirement, the page is already physically unpinned. So I
> agree with Jason the pinning doesn't have to reach to iommu from SW POV.
>

If by the time KVM gets the conversion request, the page is unpinned,
then we're all good, right?

When guest_memfd gets the conversion request, as part of conversion
handling it will request to zap the page from stage-2 page tables. TDX
module would see that the page is unpinned and the unmapping will
proceed fine. Is that understanding correct?

>> 2. IOMMU forwards the notification to TDX code in the kernel
>> 3. TDX code in kernel tells TDX module to stop thinking of any PFNs in
>>    the range as pinned for DMA?
>
> TDX host can't stop the pinning. Actually this mechanism is to prevent
> host from unpin/unmap the DMA out of Guest expectation.
>

On this note, I'd also like to check something else. Putting TDX connect
and IOMMUs aside, if the host unmaps a guest private page today without
the guest requesting it, the unmapping will work and the guest will be
broken, right?

> Thanks,
> Yilun
>
>>=20
>> If the above is possible then by the time we get to unmapping from
>> S-EPTs, TDX module would already consider the PFNs in the range "not
>> pinned for DMA".


