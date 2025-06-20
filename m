Return-Path: <linux-kernel+bounces-696063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B80EAE21C2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 20:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D1B1C248A2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jun 2025 18:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D54C2E974C;
	Fri, 20 Jun 2025 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cbtTAy11"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A862DFF19
	for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 18:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750442809; cv=none; b=J++Mx0AEmFYIrbYxyYHhHfwQ2LQeZ+mao2z8XlHjwesxEWe2ixOON7A0tHJQL6C4lZImJ140UeCBon8UW1bPf/O+4ieN/KLAUlVjYdnfRnkDninlqUm/fZ5xMkX20TEUWbcmzDrW5L9u0yZsa5leBO1yayHsB6UgLFKTx18fr/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750442809; c=relaxed/simple;
	bh=ZX0l/ldKWIzo+CezE7Ys/FSsj6dGbgzj/ZoSZmLp4K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vst0k0PujaZbtXDAC7S6XKhWeTUr7seTClvq1Fw1huI/y3yjVipGIzH0xDy4RzVhPauKC8juLdd5yGDz4MikB/0H8dA1I8m6lwMU3f+yDOMtbhyX8DGVHTjYiIDNNHCLOIHaigsFW912Tz6sWw7IZPskJvaAa4WJYeaSylf/wdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cbtTAy11; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2348ac8e0b4so17505ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jun 2025 11:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750442807; x=1751047607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQjh/hY84bm4XyuxeED43DB/e9Il2bgFC1axhaPvGF0=;
        b=cbtTAy11YWhvm0q9Dybva1c54ckTaGn7wVF1m2Fp5M5lGkLmk1lxTGswPg7ACmQC83
         lzIZLcbqxj8xbgz7k8lC8iqpOthjZTxD46usf6gbPfq6stVyrv/y0eAmkTKiczzUklp4
         ODFIGBvbvUBJSOMePXn26nfyFDLIkGaGGtCA5FEUUGKu4fW1eW9Z2Uxc/d3zSVETwVfE
         EQ5VCk4ZykBoIUlPABVoyiUfsXFGrpUl3jQFqKA45Ne0C36fWlQPSExYBtHmWMxIZ29p
         yQMAr8JCDorHL4zlZtNQw63aJXcUSaW6ZM7j/BK/wJSkHJr1YghEKeGbf0Dd/2+nnEPC
         fesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750442807; x=1751047607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IQjh/hY84bm4XyuxeED43DB/e9Il2bgFC1axhaPvGF0=;
        b=Q6QcBwWenqPMIb2djXNNveCZxp6ILI+HnvHcTmjZD7yBqzub7Ez5D8P8UjzVXGL+n/
         P5SDjuCWt6Y/CFRoNjn//4H7ZFz4LWBRMuYHaTTv1UYM7/Db9LOy3KgYt5EJHyjQAhXo
         VXwgxTXY2wVuroFE5aiYodOknKRBmKI8z1npT0lQZBHt8V44DlWUSgLDI6bwb42kN9yg
         ZgQs36rL2Kw6kttgzo5l8frtZBuQ6reB0X5xhylQkrzHH4fFuhzFxl8N2sI0iufXauj6
         +WzkKXcgVz8SLU7E7Y3upfnRad/e6gsWZmMdGsZCPQKszBSTNpItkRqzRgtqmTiAP/6H
         a8oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDfog/0SfU00IJA+1wdYqvtszpqS2i8ZgOCQ+Q2Z/cre/EnTyEEpB8Bsi0VhdQHHpf9kNKTSkYgXuel14=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNjQvZumrpR/qkn11LB6MJ9nO1UZyd0IcMT4e3xs7vxvz8Jty3
	Nq1yLGGSIJ0Jt2NLWBzAlUQfbHEXFOpo2ODUC6/4gyT7AlVmJlkWngENyzwuZE+n6FLMrB86GFF
	L2XHAIZnRJSoa36uiKyJfA4TVTPLpyps05pKrng5A
X-Gm-Gg: ASbGnct04iFwBhuJ/rJCUKSWf1U0UwS9JLnQsRSxZTWIThNT+71joYhDwczFf8hOmZk
	n0VwVlgYFw2gNic49sSrk2OieildPA+oA1eUfpejfnqrC6RSIWgDeRlv8gTVolZzRqzSVg6fWsb
	JILR+4hhVE4tx9q1oFmP5lK9uI/4w63i4WJYM+jfsnmao6rL7EEcKZNDM+WlfyyMKAeYDvNy9Gm
	mo=
X-Google-Smtp-Source: AGHT+IFkI5W24FxOkOilrpV4AT959VYZUpAaa9Gjd7Q0hT6ltdRb9PhpH+Ntr6uhLrlRr7vAbMKYPt38cNjwwXW1/nk=
X-Received: by 2002:a17:903:41cb:b0:236:9402:a610 with SMTP id
 d9443c01a7336-237e47e3aedmr142735ad.22.1750442806697; Fri, 20 Jun 2025
 11:06:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aCVZIuBHx51o7Pbl@yzhao56-desk.sh.intel.com> <diqzfrgfp95d.fsf@ackerleytng-ctop.c.googlers.com>
 <aEEFRXF+HrZVh5He@yzhao56-desk.sh.intel.com> <diqzecvxizp5.fsf@ackerleytng-ctop.c.googlers.com>
 <aFPGPVbzo92t565h@yzhao56-desk.sh.intel.com>
In-Reply-To: <aFPGPVbzo92t565h@yzhao56-desk.sh.intel.com>
From: Vishal Annapurve <vannapurve@google.com>
Date: Fri, 20 Jun 2025 11:06:34 -0700
X-Gm-Features: AX0GCFssy9EqzBPBfKmk3x77BiDoKazz9DM8Qxy3ao91hvru8iY4UtQaI_zCTzw
Message-ID: <CAGtprH9R5AjnuOHsmAOzXL8rwE=yTJbQN=7kk6rfxmriB9okKQ@mail.gmail.com>
Subject: Re: [RFC PATCH 08/21] KVM: TDX: Increase/decrease folio ref for huge pages
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Ackerley Tng <ackerleytng@google.com>, pbonzini@redhat.com, seanjc@google.com, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org, 
	rick.p.edgecombe@intel.com, dave.hansen@intel.com, kirill.shutemov@intel.com, 
	tabba@google.com, quic_eberman@quicinc.com, michael.roth@amd.com, 
	david@redhat.com, vbabka@suse.cz, jroedel@suse.de, thomas.lendacky@amd.com, 
	pgonda@google.com, zhiquan1.li@intel.com, fan.du@intel.com, 
	jun.miao@intel.com, ira.weiny@intel.com, isaku.yamahata@intel.com, 
	xiaoyao.li@intel.com, binbin.wu@linux.intel.com, chao.p.peng@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 1:15=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wro=
te:
>
> On Thu, Jun 05, 2025 at 03:35:50PM -0700, Ackerley Tng wrote:
> > Yan Zhao <yan.y.zhao@intel.com> writes:
> >
> > > On Wed, Jun 04, 2025 at 01:02:54PM -0700, Ackerley Tng wrote:
> > >> Hi Yan,
> > >>
> > >> While working on the 1G (aka HugeTLB) page support for guest_memfd
> > >> series [1], we took into account conversion failures too. The steps =
are
> > >> in kvm_gmem_convert_range(). (It might be easier to pull the entire
> > >> series from GitHub [2] because the steps for conversion changed in t=
wo
> > >> separate patches.)
> > > ...
> > >> [2] https://github.com/googleprodkernel/linux-cc/tree/gmem-1g-page-s=
upport-rfc-v2
> > >
> > > Hi Ackerley,
> > > Thanks for providing this branch.
> >
> > Here's the WIP branch [1], which I initially wasn't intending to make
> > super public since it's not even RFC standard yet and I didn't want to
> > add to the many guest_memfd in-flight series, but since you referred to
> > it, [2] is a v2 of the WIP branch :)
> >
> > [1] https://github.com/googleprodkernel/linux-cc/commits/wip-tdx-gmem-c=
onversions-hugetlb-2mept
> > [2] https://github.com/googleprodkernel/linux-cc/commits/wip-tdx-gmem-c=
onversions-hugetlb-2mept-v2
> Thanks. [2] works. TDX huge pages now has successfully been rebased on to=
p of [2].
>
>
> > This WIP branch has selftests that test 1G aka HugeTLB page support wit=
h
> > TDX huge page EPT mappings [7]:
> >
> > 1. "KVM: selftests: TDX: Test conversion to private at different
> >    sizes". This uses the fact that TDX module will return error if the
> >    page is faulted into the guest at a different level from the accept
> >    level to check the level that the page was faulted in.
> > 2. "KVM: selftests: Test TDs in private_mem_conversions_test". Updates
> >    private_mem_conversions_test for use with TDs. This test does
> >    multi-vCPU conversions and we use this to check for issues to do wit=
h
> >    conversion races.
> > 3. "KVM: selftests: TDX: Test conversions when guest_memfd used for
> >    private and shared memory". Adds a selftest similar to/on top of
> >    guest_memfd_conversions_test that does conversions via MapGPA.
> >
> > Full list of selftests I usually run from tools/testing/selftests/kvm:
> > + ./guest_memfd_test
> > + ./guest_memfd_conversions_test
> > + ./guest_memfd_provide_hugetlb_cgroup_mount.sh ./guest_memfd_wrap_test=
_check_hugetlb_reporting.sh ./guest_memfd_test
> > + ./guest_memfd_provide_hugetlb_cgroup_mount.sh ./guest_memfd_wrap_test=
_check_hugetlb_reporting.sh ./guest_memfd_conversions_test
> > + ./guest_memfd_provide_hugetlb_cgroup_mount.sh ./guest_memfd_wrap_test=
_check_hugetlb_reporting.sh ./guest_memfd_hugetlb_reporting_test
> > + ./x86/private_mem_conversions_test.sh
> > + ./set_memory_region_test
> > + ./x86/private_mem_kvm_exits_test
> > + ./x86/tdx_vm_test
> > + ./x86/tdx_upm_test
> > + ./x86/tdx_shared_mem_test
> > + ./x86/tdx_gmem_private_and_shared_test
> >
> > As an overview for anyone who might be interested in this WIP branch:
> >
> > 1.  I started with upstream's kvm/next
> > 2.  Applied TDX selftests series [3]
> > 3.  Applied guest_memfd mmap series [4]
> > 4.  Applied conversions (sub)series and HugeTLB (sub)series [5]
> > 5.  Added some fixes for 2 of the earlier series (as labeled in commit
> >     message)
> > 6.  Updated guest_memfd conversions selftests to work with TDX
> > 7.  Applied 2M EPT series [6] with some hacks
> > 8.  Some patches to make guest_memfd mmap return huge-page-aligned
> >     userspace address
> > 9.  Selftests for guest_memfd conversion with TDX 2M EPT
> >
> > [3] https://lore.kernel.org/all/20250414214801.2693294-1-sagis@google.c=
om/
> > [4] https://lore.kernel.org/all/20250513163438.3942405-11-tabba@google.=
com/T/
> > [5] https://lore.kernel.org/all/cover.1747264138.git.ackerleytng@google=
.com/T/
> > [6] https://lore.kernel.org/all/Z%2FOMB7HNO%2FRQyljz@yzhao56-desk.sh.in=
tel.com/
> > [7] https://lore.kernel.org/all/20250424030033.32635-1-yan.y.zhao@intel=
.com/
> Thanks.
> We noticed that it's not easy for TDX initial memory regions to use in-pl=
ace
> conversion version of guest_memfd, because
> - tdh_mem_page_add() requires simultaneous access to shared source memory=
 and
>   private target memory.
> - shared-to-private in-place conversion first unmaps the shared memory an=
d tests
>   if any extra folio refcount is held before the conversion is allowed.
>
> Therefore, though tdh_mem_page_add() actually supports in-place add, see =
[8],
> we can't store the initial content in the mmap-ed VA of the in-place conv=
ersion
> version of guest_memfd.
>
> So, I modified QEMU to workaround this issue by adding an extra anonymous
> backend to hold source pages in shared memory, with the target private PF=
N
> allocated from guest_memfd with GUEST_MEMFD_FLAG_SUPPORT_SHARED set.

Yeah, this scheme of using different memory backing for initial
payload makes sense to me.

