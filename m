Return-Path: <linux-kernel+bounces-825937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F24B8D2A0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 02:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3978C480037
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Sep 2025 00:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56684C6E;
	Sun, 21 Sep 2025 00:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzaRfxuC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C81853
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 00:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758413478; cv=none; b=nqum2o9dMDtq1/mFS97/5ya+3OwMQ2ylG2ogaGtm++CGBqbZO2uzSnaXgpWcjEVZQr2TnzOrDGWP6qXw3w4EvSB30OzIGU2l277CsOatSFTWvwxJYVFAeB2Plaggl5I8BoIqi9ajELhZh3KE+tNfy9xZJMY69QrbK46xIDwmzlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758413478; c=relaxed/simple;
	bh=YCAV/eRRMv3+e9YBfBNCTfFLSqZziYMTKzfRyPJvnhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sKCT9vKeOCP5GNtcdwUcsKPn1eukr8rUdpKesGnU4LtO+alWMCjm5/ClBto9NGRXyK2/CPjwnh0K3lT7Ji2pZPp3/dhcqorR+96NYhQuEWXXkaj+CuF098D0lLWJk2SXQr0Py4LZmnu00+TASPqAKRV7NO3666uBp6SRyd4N4t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzaRfxuC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BF1C4CEFE
	for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 00:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758413475;
	bh=YCAV/eRRMv3+e9YBfBNCTfFLSqZziYMTKzfRyPJvnhY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bzaRfxuChG9erP0M/5V5VjuwKA5lP7/v7SeUNMQryKO4sZJxatCHbZ4BV8LINpNo9
	 RpiYALZ+BqTzQZT/JBwMEtRu78cQQlTrl1boGuHqQbCo01wI01W+5GtoHqwQZijgzA
	 heonexHP0+y9UQXTuJ20FWVdyVi63tL/HZ5FiJNuvx+TGjHqcjqWTdFE2jBtMpG3lh
	 POj6oqvaG9TQy9Ob5OlkBfmYR1UFIYRjwISHwEnzKuSKRaQPqijen49fEJNjUw07zV
	 m/+4Lh3+1iwHj+2l1G+GceQG/435ty5yc69/hlpiZnYkb4OksCQLyB9hCq55LkkmkX
	 ORR91RYRx3pPw==
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-ea856357c38so1484887276.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 17:11:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX40IifN0MaNyf6SldAYDAnGQJ4WoXLdoWOzn1EkNWGmOy9xITZQHupmcXdU/avmPGYKT3Q8nJQB0sCggc=@vger.kernel.org
X-Gm-Message-State: AOJu0YysMV+95CG3stiGIAAmnWwdZbhnQivah9eSbwH2d+U4cikicELt
	jK3Zpyoi9BI7aGIr3sruN4vJDaQJVNTKIpsPJcqEXE0ooe66UhGBkiq3PgOUCV7ERwcTKa2QXPw
	iNCOkoaJEGXC4x208r59vsmFTzJRKGbA9xblpDnR0jA==
X-Google-Smtp-Source: AGHT+IHXtvuVXAiUDShss5VFJajPEEBCzBrR6o6+Cqq1R7MOJ8XoKi+vBUF/UQKficxFre52whFezjyJrfMuSBW7J64=
X-Received: by 2002:a05:690e:1449:b0:62d:66fb:d4b8 with SMTP id
 956f58d0204a3-6347f5967b9mr6604050d50.28.1758413474690; Sat, 20 Sep 2025
 17:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916160100.31545-1-ryncsn@gmail.com> <20250916160100.31545-2-ryncsn@gmail.com>
 <CAGsJ_4w2GqGj8HZMfwndsWu7qkORqsnaw9WwhmQS=pW4gR7nEA@mail.gmail.com>
 <CAF8kJuNbUyDWcJ13ZLi-xsiYcbY30w7=cFs7wdxszkc7TC4K2Q@mail.gmail.com>
 <CAGsJ_4wKWem-STYAnh_0EgSFKzzs1M1c7wz6K82wLt6T6JEw9A@mail.gmail.com>
 <CACePvbU8cUs-wwPsXkZ24EWga5bXxxUGSCT18rKAWFYn5w9rpw@mail.gmail.com>
 <CAGsJ_4yhDU_WVfEybDhGE-WF5+w-fak1-F8jqbAQ-Qw1+qWkaw@mail.gmail.com>
 <CACePvbUabb+L6Z9Nb-41fLR-FMhj--cDWSbnXtCj3rpqXModiQ@mail.gmail.com>
 <CAGsJ_4y8yTX48ESHKgLNCvM1M1_gY9uGnD4qiz8n+gD47Zd1Hg@mail.gmail.com>
 <CANeU7QkZBWFO6SeVHtmm73oLu7r0zavePQEYmQfH8opKPH1QWw@mail.gmail.com>
 <CANeU7QmcC=-CTmJ7i8R77SQ_WArBvjP3VrmpLOy-b7QhCfMRYA@mail.gmail.com>
 <CAGsJ_4zmkibM_Ex7kGMsr2sni85H-cnxQvh0XwkWiALNQy+zAQ@mail.gmail.com>
 <CACePvbXae0zymE_BHydXtA_pjZ2NqabVyqxu1xKxLjLKmeYH9g@mail.gmail.com> <CAGsJ_4zB4ygGCN4JTx+AW+XAUm8WtFVLVesStuDHc8S-HT0ihQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zB4ygGCN4JTx+AW+XAUm8WtFVLVesStuDHc8S-HT0ihQ@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sat, 20 Sep 2025 17:11:03 -0700
X-Gmail-Original-Message-ID: <CACePvbXjaUyzB_9RSSSgR6BNvz+L9anvn0vcNf_J0jD7-4Yy6Q@mail.gmail.com>
X-Gm-Features: AS18NWAKXR1mWgOvJl586I0OOCDajvkVTayDD7oSIGKEBFrYYvnY9Dj1CZ4VGD8
Message-ID: <CACePvbXjaUyzB_9RSSSgR6BNvz+L9anvn0vcNf_J0jD7-4Yy6Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/15] docs/mm: add document for swap table
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Baoquan He <bhe@redhat.com>, 
	Nhat Pham <nphamcs@gmail.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@redhat.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, 
	Kairui Song <kasong@tencent.com>, Barry Song <21cnbao@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000008740b7063f448a13"

--0000000000008740b7063f448a13
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

Can you please apply this incremental fix up commit on the document
patch of the swap table series?
Just folding it into the original patch is fine.

Here is the change log:
- Move the swap table document to the mm main section. [SeongJae Park]
- Rewrite the swap table size sentence for easier to understand. [ Barry]

Thanks

Chris

On Thu, Sep 18, 2025 at 2:35=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> > > I=E2=80=99m not entirely sure what you mean by =E2=80=9Cpage table pa=
ge.=E2=80=9D
> >
> > The page that gets pointed by the page table, or the page that holds th=
e PTE.
> >
> > > My understanding is that you=E2=80=99re saying:
> > > The swap table contains an array of pointers, each the same size as a=
 PTE,
> > > so its total size typically matches a PTE page table=E2=80=94one page=
 on modern
> > > 64-bit systems.
> >
> > That sounds good. Thanks for the suggestion.
> > I take your suggestion with some small modifications, mostly to
> > clarify the total size is the total size of one cluster of swap
> > tables. The total size of all swap tables in a swap file is much
> > bigger.
> >
> > How about this:
> >
> > A swap table is an array of pointers. Each pointer is the same size as =
a PTE.
> > The size of a swap table for one swap cluster typically matches a PTE
> > page table,
> > which is one page on modern 64-bit systems.
>
> Acked.
>
> >
> > Chris
>
> Thanks
> Barry

--0000000000008740b7063f448a13
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-SQUASH-docs-fix-up-for-the-swap-table-document.patch"
Content-Disposition: attachment; 
	filename="0001-SQUASH-docs-fix-up-for-the-swap-table-document.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mfsxxs120>
X-Attachment-Id: f_mfsxxs120

RnJvbSBiMDNhOWI1M2RmY2IxNTU4ZmViMDExODhmNjU3MzQwYmMzNDE0YTIyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpcyBMaSA8Y2hyaXNsQGtlcm5lbC5vcmc+CkRhdGU6IEZy
aSwgMTkgU2VwIDIwMjUgMTg6MTI6MDQgLTA3MDAKU3ViamVjdDogW1BBVENIXSBTUVVBU0g6IGRv
Y3M6IGZpeCB1cCBmb3IgdGhlIHN3YXAgdGFibGUgZG9jdW1lbnQKCk1ha2Ugc3dhcCB0YWJsZSBp
bnRvIHRoZSBtYWluIHNlY3Rpb24uCgpBZGp1c3Qgd29yZGluZyBvbiB0aGUgc3dhcCB0YWJsZSBz
aXplIHZzIFBURSBwYWdlIHRhYmxlIHNpemUuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpcyBMaSA8Y2hy
aXNsQGtlcm5lbC5vcmc+Ci0tLQogRG9jdW1lbnRhdGlvbi9tbS9pbmRleC5yc3QgICAgICB8IDIg
Ky0KIERvY3VtZW50YXRpb24vbW0vc3dhcC10YWJsZS5yc3QgfCA5ICsrKy0tLS0tLQogMiBmaWxl
cyBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9tbS9pbmRleC5yc3QgYi9Eb2N1bWVudGF0aW9uL21tL2luZGV4LnJzdApp
bmRleCA4MjhhZDliMDE5YjMuLmJhNmE4ODcyODQ5YiAxMDA2NDQKLS0tIGEvRG9jdW1lbnRhdGlv
bi9tbS9pbmRleC5yc3QKKysrIGIvRG9jdW1lbnRhdGlvbi9tbS9pbmRleC5yc3QKQEAgLTIwLDYg
KzIwLDcgQEAgc2VlIHRoZSA6ZG9jOmBhZG1pbiBndWlkZSA8Li4vYWRtaW4tZ3VpZGUvbW0vaW5k
ZXg+YC4KICAgIGhpZ2htZW0KICAgIHBhZ2VfcmVjbGFpbQogICAgc3dhcAorICAgc3dhcC10YWJs
ZQogICAgcGFnZV9jYWNoZQogICAgc2htZnMKICAgIG9vbQpAQCAtNTcsNyArNTgsNiBAQCBkb2N1
bWVudGF0aW9uLCBvciBkZWxldGVkIGlmIGl0IGhhcyBzZXJ2ZWQgaXRzIHB1cnBvc2UuCiAgICBw
YWdlX3RhYmxlX2NoZWNrCiAgICByZW1hcF9maWxlX3BhZ2VzCiAgICBzcGxpdF9wYWdlX3RhYmxl
X2xvY2sKLSAgIHN3YXAtdGFibGUKICAgIHRyYW5zaHVnZQogICAgdW5ldmljdGFibGUtbHJ1CiAg
ICB2bWFsbG9jZWQta2VybmVsLXN0YWNrcwpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9tbS9z
d2FwLXRhYmxlLnJzdCBiL0RvY3VtZW50YXRpb24vbW0vc3dhcC10YWJsZS5yc3QKaW5kZXggYWNh
ZTZjZWI0ZjdiLi5kYTEwYmI3YTBkYzMgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vbW0vc3dh
cC10YWJsZS5yc3QKKysrIGIvRG9jdW1lbnRhdGlvbi9tbS9zd2FwLXRhYmxlLnJzdApAQCAtNTAs
MTIgKzUwLDkgQEAgU3dhcCBjYWNoZSBsb29rdXAgd2l0aGluIHRoZSBjbHVzdGVyIGNhbiBiZSBh
IHZlcnkgc2ltcGxlIGFycmF5IGxvb2t1cC4KIAogV2UgZ2l2ZSBzdWNoIGEgcGVyLWNsdXN0ZXIg
c3dhcCBjYWNoZSB2YWx1ZSBhcnJheSBhIG5hbWU6IHRoZSBzd2FwIHRhYmxlLgogCi1FYWNoIHN3
YXAgY2x1c3RlciBjb250YWlucyA1MTIgZW50cmllcywgc28gYSBzd2FwIHRhYmxlIHN0b3JlcyBv
bmUgY2x1c3Rlcgotd29ydGggb2Ygc3dhcCBjYWNoZSB2YWx1ZXMsIHdoaWNoIGlzIGV4YWN0bHkg
b25lIHBhZ2UuIFRoaXMgaXMgbm90Ci1jb2luY2lkZW50YWwgYmVjYXVzZSB0aGUgY2x1c3RlciBz
aXplIGlzIGRldGVybWluZWQgYnkgdGhlIGh1Z2UgcGFnZSBzaXplLgotVGhlIHN3YXAgdGFibGUg
aXMgaG9sZGluZyBhbiBhcnJheSBvZiBwb2ludGVycy4gVGhlIHBvaW50ZXIgaGFzIHRoZSBzYW1l
Ci1zaXplIGFzIHRoZSBQVEUuIFRoZSBzaXplIG9mIHRoZSBzd2FwIHRhYmxlIHNob3VsZCBtYXRj
aCB0byB0aGUgc2Vjb25kCi1sYXN0IGxldmVsIG9mIHRoZSBwYWdlIHRhYmxlIHBhZ2UsIGV4YWN0
bHkgb25lIHBhZ2UuCitBIHN3YXAgdGFibGUgaXMgYW4gYXJyYXkgb2YgcG9pbnRlcnMuIEVhY2gg
cG9pbnRlciBpcyB0aGUgc2FtZSBzaXplIGFzIGEKK1BURS4gVGhlIHNpemUgb2YgYSBzd2FwIHRh
YmxlIGZvciBvbmUgc3dhcCBjbHVzdGVyIHR5cGljYWxseSBtYXRjaGVzIGEgUFRFCitwYWdlIHRh
YmxlLCB3aGljaCBpcyBvbmUgcGFnZSBvbiBtb2Rlcm4gNjQtYml0IHN5c3RlbXMuCiAKIFdpdGgg
c3dhcCB0YWJsZSwgc3dhcCBjYWNoZSBsb29rdXAgY2FuIGFjaGlldmUgZ3JlYXQgbG9jYWxpdHks
IHNpbXBsZXIsCiBhbmQgZmFzdGVyLgotLSAKMi41MS4wLjQ3MC5nYTdkYzcyNmMyMS1nb29nCgo=
--0000000000008740b7063f448a13--

