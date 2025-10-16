Return-Path: <linux-kernel+bounces-856067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55640BE2FD6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 13:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9639119C2011
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 11:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C682798FA;
	Thu, 16 Oct 2025 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="VQAagrtA"
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550412066F7
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760612509; cv=none; b=awDTdpkwWrzStD5zkvt3oHVs0UE4amBinE4YiuGxj+wQ3Vtv0WO+wxd9Suoa1YqjpgN6J5cSU7YuERol8m/up1BEPIJOthXfJfWnNzGaAToUA0C9cpYe4epm2NoyBuMWlFXswFDKC3kCNlK3Fo9iZmoHs1oYSv8dT9yoMCAORYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760612509; c=relaxed/simple;
	bh=TwInCQuSxkp1G5BdQXQOGvUNIqDGzmnYz3mow6w6l84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RCtx7DmU/+WEixuSdmZSHkRA3y4yvA889ViTNcUm4hlrc3u4LiTKVjQ6L/ZtnkB9KmcVNxZepNDc+4Qc+sxPZRTpl7H739KOAtOSn8L2/d/SihcIZBwC1IlRs3wx1sJN+T9qJPjh2U0uXas1eBgyC9nPt1qvRNB/Wf7TbWldu+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=VQAagrtA; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760612463; x=1761217263; i=markus.elfring@web.de;
	bh=pBiHgqrHbUYp2JEA6PbWJGJtRV3x6jWPI0L/vSeghho=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VQAagrtAaS97HDtx3m1NFhFzulhL15tU3UMYE1gbMacZjQgDDOVowmheHkR/NY8v
	 vgPcWlZamsgwpaMZk1JngjelUJoT+l/k5P08JIDCaVZhKy2gPh/pC8kC08JPD2g/5
	 4Zh0PtvcEiLM5i+hbqLyk3q1exyLVM/WAq15Gjsj4piidou3Z/+6MhSjet5FwP3hY
	 3kPfDfdWLOP0xR47LkGbmIaUWkoDpJeD9qBvs/VsykqJ+cITXYL2qD4ZN3cIZT2Fu
	 l7i5gSz4xMj7hu1XI8wgQHPn1mj+Z74OmB3yXNqMS4kw0bofjVgf/wtdh54ivt8KL
	 V9Etdxfi1Il4pFHWqg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.241]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MuVKI-1uItnZ1SxG-015dOT; Thu, 16
 Oct 2025 13:01:03 +0200
Message-ID: <04f6f978-1551-4429-8f3d-a9eaf331d3a7@web.de>
Date: Thu, 16 Oct 2025 13:01:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] mm/ksm: recover from memory failure on KSM page by
 migrating to healthy duplicate
To: Longlong Xia <xialonglong@kylinos.cn>, linux-mm@kvack.org,
 David Hildenbrand <david@redhat.com>, Lance Yang <lance.yang@linux.dev>,
 Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Longlong Xia <xialonglong2025@163.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, xu xin <xu.xin16@zte.com.cn>
References: <20251016101813.484565-1-xialonglong2025@163.com>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251016101813.484565-1-xialonglong2025@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l5cCuNphgxSZjAM2aUiH7tqi96ORbL27N3eaVYs0pSWyvDhRY7a
 EP56On/5SDBn1OqEst7Ae2QaGlNMtMZ9TtvHea1URPCcP9WJhquBqBvkocgxyWe7pj4zeHy
 mu93ZQoL9zrkMBtk5DVwAEts6UqLqMV1/f0Zem1AjCb4pqo0sHe8n0IpuKkXNH+zE5akEeM
 UoCBOkjjzzKMzjXqMKTXw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LbQ5Jc5HBIc=;aO861wgYsDC4QF26xQdykZyEFyD
 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

> When a hardware memory error occurs on a KSM page, the current
> behavior is to kill all processes mapping that page. This can
=E2=80=A6

* The word wrapping can be improved another bit, can't it?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?h=3Dv6.17#n658

* How relevant is such a cover letter for a single patch?

* Is there a need to extend change descriptions at other places?


Regards,
Markus

