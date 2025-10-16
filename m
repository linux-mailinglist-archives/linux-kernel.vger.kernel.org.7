Return-Path: <linux-kernel+bounces-856353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 986C3BE3F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 16:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711D71A65798
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324C1340DB6;
	Thu, 16 Oct 2025 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="sP7uyKiy"
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934672E1730
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 14:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760625520; cv=none; b=UTV+m3Ae2a/2cjlVvBeafx17Lv9Bj0HxBnxfLMNIaxcFcJHmQ8mDjtCnwHaq1/qi6ZXEfueTOtYzUVdSNjxYuJPEoEPFeIXH1UZD1lpGHpaaHz/Fo50bF5aHxMmtL4X3STxgj63aBaG4IZ+B9khgnoQyuLIhn4bagcePdzTAiVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760625520; c=relaxed/simple;
	bh=W1g8f3vY+qbl9C5XG7aw1PiwvOsDeM3lpkKEWyCgfF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ueZ5JHi3VJ9Bmb4PVouKzzB+kEKirxzytJkwP/WGczziShydh2vxlLz5EkKxXipc16sO+Xgq4Oc8FFwSjzYpkvKvrN8B9Toyfa3F0WtdJanhtfKLdfU1hx27TSOzT/mSmRtmiyhgBhunkBvPrXLwt9gB2WImBpuByLMelJ+WuYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=sP7uyKiy; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760625481; x=1761230281; i=markus.elfring@web.de;
	bh=H3S+3Ynz1TOt/M42tcxbRtEI5ZJy9u2qfBu4zK5zMEA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=sP7uyKiyjCTlf9L2EGy5w6hH+h8dYkL/VKmTSzU2MUcAzWQyrfZgI310H+sCD75D
	 EcRPAEBfuF1ColE/w1p3hjrQddPFjP1SrZ+O59SH6OI6bunkrCkgO0xCPRcOPg00C
	 WLigMrdob5xg8lcqHA97nExneCTSC92SESRJO12k76M+QVKvACwsiA+FEoi3Vk4sd
	 hxU1Qmg13gbLXU0k3fscj+tRkzlPgiRAm9IVtRbV25OFa0U6K3fXoUGqyLWaZ81/E
	 1h+pmFoeQYkhYV8pXL/zYrmg74ZRvDF5F8/OEsBm8ZRnt7c2xrKbS6Ddy/4me+QfB
	 iOkkrYIvKZ3FhzFelA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.241]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MP3CC-1uqnu12Y3g-00TXEe; Thu, 16
 Oct 2025 16:38:01 +0200
Message-ID: <add77995-2e39-4f8c-b827-766fa8631ae2@web.de>
Date: Thu, 16 Oct 2025 16:37:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/ksm: recover from memory failure on KSM page by
 migrating to healthy duplicate
To: Longlong Xia <xialonglong@kylinos.cn>, linux-mm@kvack.org,
 David Hildenbrand <david@redhat.com>, Lance Yang <lance.yang@linux.dev>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Longlong Xia <xialonglong2025@163.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 xu xin <xu.xin16@zte.com.cn>
References: <20251016101813.484565-1-xialonglong2025@163.com>
 <20251016101813.484565-2-xialonglong2025@163.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251016101813.484565-2-xialonglong2025@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gwt9OktpJPWtxjzPqwm43XtHTgOiFICpuSNp/HZnEhNZtvITuJj
 7QJ5wVwYlOHnNkiLQwGMD6ykaYsSM+5bgxtWdeqoSk5KRFJE1TxNmiPIlenxv+vByNAB4kr
 ZsJZjIKsrKe2mBHok9zcJqsMwrrrP/vhIS9QZGJ7dFf8ZsAvVH2lgwZGaWYD9P47NQD1Bmj
 9xwdCHItqQo3xwDtt9jaQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:6Wtu4e621cY=;9RiPC9wTL8BiiTYjiX204RHXYN9
 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
 Veopc5c2HBr/7YNxIq/RqJgLmI=

=E2=80=A6> This patch introduces =E2=80=A6

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.17#n94


=E2=80=A6> +++ b/mm/ksm.c
=E2=80=A6
> +static int replace_failing_page(struct vm_area_struct *vma, struct page=
 *page,
> +		struct page *kpage, unsigned long addr)
> +{
=E2=80=A6> +	int err =3D -EFAULT;
=E2=80=A6> +	pmd =3D mm_find_pmd(mm, addr);
> +	if (!pmd)
> +		goto out;

Please return directly here.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.17#n532


=E2=80=A6> +out_mn:
> +	mmu_notifier_invalidate_range_end(&range);
> +out:
> +	return err;
> +}
> +
> +static void migrate_to_target_dup(struct ksm_stable_node *failing_node,
> +		struct folio *failing_folio,
> +		struct folio *target_folio,
> +		struct ksm_stable_node *target_dup)
> +{
=E2=80=A6> +	hlist_for_each_entry_safe(rmap_item, hlist_safe, &failing_nod=
e->hlist, hlist) {
> +		struct mm_struct *mm =3D rmap_item->mm;
> +		unsigned long addr =3D rmap_item->address & PAGE_MASK;
> +		struct vm_area_struct *vma;
> +
> +		if (!mmap_read_trylock(mm))
> +			continue;
> +
> +		if (ksm_test_exit(mm)) {
> +			mmap_read_unlock(mm);
> +			continue;
> +		}

I suggest to avoid duplicate source code here by using another label.
Will such an implementation details become relevant for the application of=
 scope-based resource management?
https://elixir.bootlin.com/linux/v6.17.1/source/include/linux/mmap_lock.h#=
L483-L484


=E2=80=A6> +		folio_unlock(target_folio);
+unlock:> +		mmap_read_unlock(mm);
> +	}
> +
> +}
> +
> +static bool ksm_recover_within_chain(struct ksm_stable_node *failing_no=
de)
> +{
=E2=80=A6> +	if (new_page && new_stable_node) {
> +		migrate_to_target_dup(failing_node, failing_folio,
> +				page_folio(new_page), new_stable_node);
> +	} else {
> +		migrate_to_target_dup(failing_node, failing_folio,
> +				healthy_folio, healthy_dupdup);
> +	}
=E2=80=A6

How do you think about to omit curly brackets?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.17#n197

Regards,
Markus

