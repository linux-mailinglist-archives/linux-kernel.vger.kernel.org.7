Return-Path: <linux-kernel+bounces-756355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF8AB1B304
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880C5175AAB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87283269CE6;
	Tue,  5 Aug 2025 12:04:49 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FEB23F413
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754395489; cv=none; b=RJxvELsF51azSGFVzmAnGvGW4Ihv9HPNRPa0LQNbCt+PJxdhGUpU/SRId5UDxhW6+ZzklPTlTAQDYrcJ0mEuFnU3qwX0+xha+iRnQgOoRVIDreJgqnMQ+B90CsiSpjAdw/RB6WH2/NWYq7bE59tppgoIN3VDNU/Sly5HJR6t/Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754395489; c=relaxed/simple;
	bh=uJBSd0RYDASFFZ/Z0ey9ZuL5lP97B4RDRI3fSG6SzW4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VCVYXsacav11WRPyE1g5B9lPloCpt/AfNJHvM32m0VZezOcDH/le9MjUsk08r7m/CwJSkibdbir5SPj2hGgXOGV49BmoUCzzcbeYaTE3bCYOKXvpL0ASazwJ/OfUw14pwTfw/kCftn2K6DvVxn0TY4jENW8/754fXyDxf0QWWYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5c889e4271f411f0b29709d653e92f7d-20250805
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:e08b59db-1227-415f-9524-48b789a41595,IP:0,U
	RL:0,TC:0,Content:11,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:11
X-CID-META: VersionHash:6493067,CLOUDID:bde39b8ec4116adce4cae47d27490bca,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|102,TC:nil,Content:4|50,EDM:-3,
	IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:
	0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5c889e4271f411f0b29709d653e92f7d-20250805
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <liqiang01@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 55385721; Tue, 05 Aug 2025 20:04:38 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 71C0FE008FA2;
	Tue,  5 Aug 2025 20:04:38 +0800 (CST)
X-ns-mid: postfix-6891F356-36186845
Received: from localhost.localdomain (unknown [10.42.12.14])
	by mail.kylinos.cn (NSMail) with ESMTPA id 53D29E008FA2;
	Tue,  5 Aug 2025 20:04:36 +0800 (CST)
From: Li Qiang <liqiang01@kylinos.cn>
To: akpm@linux-foundation.org,
	david@redhat.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com
Subject: [PATCH] mm: memory: Force-inline PTE/PMD zapping functions for performance
Date: Tue,  5 Aug 2025 20:04:35 +0800
Message-Id: <20250805120435.1142283-1-liqiang01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <74580442-2a9a-4055-b92d-23f5e5664878@redhat.com>
References: <74580442-2a9a-4055-b92d-23f5e5664878@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ah, missed it after the performance numbers. As Vlastimil mentioned, I=20
would have expected a bloat-o-meter output.

>=20
> My 2 cents is that usually it may be better to understand why it is
> not inlined and address that (e.g., likely() hints or something else)
> instead of blindly putting __always_inline. The __always_inline might
> stay there for no reason after some code changes and therefore become
> a maintenance burden. Concretely, in this case, where there is a single
> caller, one can expect the compiler to really prefer to inline the
> callees.

>
> Agreed, although the compiler is sometimes hard to convince to do the=20
> right thing when dealing with rather large+complicated code in my=20
> experience.

Question 1: Will this patch increase the vmlinux size?
Reply:
	Actually, the overall vmlinux size becomes smaller on x86_64:
	[root@localhost linux_old1]# ./scripts/bloat-o-meter before.vmlinux afte=
r.vmlinux =20
	add/remove: 6/0 grow/shrink: 0/1 up/down: 4569/-4747 (-178) =20
	Function                                     old     new   delta =20
	zap_present_ptes.constprop                     -    2696   +2696 =20
	zap_pte_range                                  -    1236   +1236 =20
	zap_pmd_range.isra                             -     589    +589 =20
	__pfx_zap_pte_range                            -      16     +16 =20
	__pfx_zap_present_ptes.constprop               -      16     +16 =20
	__pfx_zap_pmd_range.isra                       -      16     +16 =20
	unmap_page_range                            5765    1018   -4747 =20
	Total: Before=3D35379786, After=3D35379608, chg -0.00% =20


Question 2: Why doesn't GCC inline these functions by default? Are there =
any side effects of forced inlining?
Reply:
	1) GCC's default parameter max-inline-insns-single imposes restrictions.=
 However, since these are leaf functions, inlining them not only improves=
 performance but also reduces code size. May we consider relaxing the max=
-inline-insns-single restriction in this case?

	2) The functions being inlined in this patch follow a single call path a=
nd are ultimately inlined into unmap_page_range. This only increases the =
size of the unmap_page_range assembly function, but since unmap_page_rang=
e itself won't be further inlined, the impact is well-contained.



Question 3: Does this inlining modification affect code maintainability?
Reply: The modified inline functions are exclusively called by unmap_page=
_range, forming a single call path. This doesn't introduce additional mai=
ntenance complexity.


Question 4: Have you performed performance testing on other platforms? Ha=
ve you tested other scenarios?
Reply:
	1) I tested the same GCC version on arm64 architecture. Even without thi=
s patch, these functions get inlined into unmap_page_range automatically.=
 This appears to be due to architecture-specific differences in GCC's max=
-inline-insns-single default values.

	2) I believe UnixBench serves as a reasonably representative server benc=
hmark. Theoretically, this patch should improve performance by reducing m=
ulti-layer function call overhead. However, I would sincerely appreciate =
your guidance on what additional tests might better demonstrate the perfo=
rmance improvements. Could you kindly suggest some specific benchmarks or=
 test scenarios I should consider?

--
Cheers,

Li Qiang

