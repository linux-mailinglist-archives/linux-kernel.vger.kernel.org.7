Return-Path: <linux-kernel+bounces-830579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFA8B9A062
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBED2188696E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78A5C3009E8;
	Wed, 24 Sep 2025 13:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Q//IkjTE"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FC115B971
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758720223; cv=none; b=n7kJ05ULAOL+5JEjq8GVdt1/qXep1fSzCNnstM7ZmV4mo/61yYWUPieXAupoOXzoNZbipJBuy/u2FFcUl7MUqKvH98yrZzYQ4WeoQGQ4Su5Uy26BbX71o2O+bO3VQZooSDCB8c4QsUYXTw7d3QpQT2sZPUN66+dacpZLuWj5D04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758720223; c=relaxed/simple;
	bh=DYl/Bkmkgnv8NnV8bRJWPp5qpg+MVxlpTt4ZhnmTKGY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ncCg8/43//+j+feUs7mU32Z+sHKDhhz3RacFxmULFbExrJ6qs/P36gFZUFLEjCoZ9EuCedHBIrcilLCOZCvWCRGVoz/PMHB+6CNvQN/6uLjTC5hw+e4L4sBk3XHAqJnvw8VooZMjveDfCpL/XVGGlwVhzViXSFfykMKhMWiaSjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Q//IkjTE; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1758720208; x=1759325008; i=markus.elfring@web.de;
	bh=oUx7FQDk2SiuLavlx/HNjgWtSxwt+Njd+F6PUkWYXZc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Q//IkjTEddC1uTTET7XqodQwxs0USK5Tp0NlciUFBdusrkoOVGlTSrFHIpLDEqIn
	 Q56RlA0hhswnOoWSLaWOIFCea5SVxrWvvjbCLIo2aczMHrTP8LxAkNlBWQjfC1bwv
	 63tCnddtkYK00S6i8jf1CUtxBlXjkgDtgbrIN8cLEV34ni7Bbd501LkisWsg7abDA
	 K7xdrEOEixs5kFYillU7uEN6W9ixv894l5PFtGtUWreXHa5pdLqhfUnjtDeKODZoE
	 93WBshPIcXDzD7e9f6j9xy6g8N3NF0gzcOXdoM3w14Glw9iowmKuleSlejR/pGpq/
	 IyF1ElCPUk/pk4BYZA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.191]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdfCN-1uRnfK3hGD-00nFl0; Wed, 24
 Sep 2025 15:23:27 +0200
Message-ID: <8f0366c8-f05e-4687-817f-90a5b47922c9@web.de>
Date: Wed, 24 Sep 2025 15:23:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Alexander Potapenko <glider@google.com>, linux-mm@kvack.org,
 kasan-dev@googlegroups.com
Cc: LKML <linux-kernel@vger.kernel.org>, Aleksandr Nogikh
 <nogikh@google.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Dmitry Vyukov <dvyukov@google.com>,
 Marco Elver <elver@google.com>, Mike Rapoport <rppt@kernel.org>,
 Vlastimil Babka <vbabka@suse.cz>
References: <20250924100301.1558645-1-glider@google.com>
Subject: Re: [PATCH v2] mm/memblock: Correct totalram_pages accounting with
 KMSAN
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250924100301.1558645-1-glider@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GbK73zxLYoS2kQ137BowTVrHDqoJ8gk83c2ByReHUM2nq/LRqlh
 CZO842TFixdnpUk1ktMJFWudMgvfOEDHLgTrHpvgtEf6VDZAlIkg892QjA6IwmIm4AZAGQa
 oNuryIfeGvJ2wsDd3/FylPuN2EIt+UCxKigm6SB0DvsaAXNqmFhAss29qpFku4zedN1kKB/
 RSZKpA/cm2WPRO972GolA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q/uBpl4JHmo=;6HT6GiaWj/LEuxTLU8Jcvzj9PSt
 jcM8QUQfOOVwSerGN8P/loixqJtlaz37Qk5otGPaJo9Es+YN8dLEJau5kyhV4X4bh8+MvonFu
 lm6c+cORSCpLgYjbQE2nc5CDrrg+xCdlmat8/eEIynhON+3VVP2QNsepd2Sd26mtyP09ynJF1
 sDjpAOtjDXvenB8BuWZFesLJs3dJdtN51v0cKd+1OyiqQw+kxuCCXiP9K0JDMArnepoqh+OB6
 lPyO7Wdg4TrdIYu7HpwpXJi+1ZJ6wxef2N+5mSN9rLBrRpT+EWAr6s7Jqhv4xzEyC4XNRbJet
 w/hpf2QteYjWuYTVmPuOtybR0O/cTE/2DiwN3K0wnhDWy7tiDeXq+NV4So0DwkfZ8CafNbRL6
 2DYAYC9okncouidlfyLTOzX2AQi5yIuYZic54aMEpXVmPBOz1lozUHb0XFRaBupxSrwUsUrsx
 De1g6f9s2fw5gqBwTytBuUt5Wuq5fV4U9UC7EOY3EYsuiVjBNI/cLoeLbky7RFJd/B4B2TktR
 8QlCoz91QQlu03EbQXVYzVVeYyfdMQCHK2Y/8J5KVBTHunw+ShbtSwRyuZdkREZ8WYq96V0BO
 0w5F1ddwrpcVJv1XFCUpSpj5H1aMbgxW/1QbcSKDxocxVXbWtfgtbhaaGkF+xPTXJpYNT/AOX
 K6mhd5taaidtbterGR1wNj/hUBCTdPCbIlSkhj00Y80TF+3IpRIV9gRNvGlp7b6iHYS7eS527
 PXAqmHPQzHp1L3TenvWMBRZerpQ3KDEZu1tJShUBdwbZhDz7LrF7IysC4H5GQoJPVPpbIp0DN
 Pd6yuCR1BHbpyNrmMD/TUS2jXBZ7bO39f2TshWBR1lP38jbNyYbeaYj0EJJwQkGe/MM6wzRpn
 CzOhuUUKO/iQMpjAKyp/URSFLH7t5OrOxuWAUcmox69l/0on3aeQnlzj8QgOM+BAFmKkTczfV
 mksVSa2cAh/+pBM8/xdCTep3WdSyb2hyElnHiKY/FObqWTiL/isIskHXyw1M5+0RT8kzafw//
 OAk/8JbcnyZuZzPKrAGXPU2eHd6DiTa5ZuinxzCcy6fM9kte4L5SOZGP3rUXob1di3DZMDXEa
 H1mari08G51WJvPCuPDVJww4h47Q4IE+idZBskqgEcM+rT7Xdqf/OZie80npUIDPB+kovJ9XT
 EJG2uDkl9mOhdD4+4w9sL3VfxyibY0hgVvUlDtlIs6Sr+ZDuZZgWiEfZ4E+pTx/80YUgoSopy
 8hhgo3icIXtO0G4MM9D2YrjUdtcsUmgUukqqOyQnYF1vlDkSHocicI4cSCypIEFN7Y7ySvFjt
 PxayHCNpgV/fpo2DfQEz/jrEtT5/m4dl89REV1C0e0wvb8JE8DDoSBQY1m51pzL7iNLW3xOlR
 +trm8eLf3FFYATgYRkMlAeEIpXimWrR86ygt7wJfSFkA0qOW4CdIxJrqZSb5s0q28PcO2HaFd
 j0axNYYkuoVfPPm7xfoQSUeF42XmecpWzxeaQrMlAhuEQkHejehTWHlLMWWO5rOR/ZyKVBCu2
 Dt7Rj/MNbUszeSUIPJ874qTi8xrVy2kBBbiyzXtpAQxuOpYq5Qdyp+ukPXEWYUpG5NYE0moNk
 apCK56LTgFvjvclDpN0N9eKB7HpMwEnz38OaB4xQzVoqqE2gAAWb5w11eKnLwIdNZzX7cxhkr
 ebTpFupzsQyAf5ZjXlvgx0fANxCM3PG1FnrRxkulg0OxDjucvSiKiQsp7fpRZN9g5fGpZkN2a
 WcE/rPoU9VRQ98SYkS2/nG5Sd1HqeH3Lzzp5mGXqjTIlSRR6nqs9yqmDX7GZlZ444wFFOrLrq
 ucvSH7HNJMR1ru2UMq/W7p5oMFs1B8aeM/EhUP7bfvHBm1AABPUyFk3DQpI+j/3vEnmN1VBcy
 8ZjLCso/fYyGfzMdubl9fHJ8Rk8BXBYg8qp9j7RGM7pJScYUP88xbQB8SLW/7a1PQjOrWjSFK
 NVyFaKRTfKVOoqJx1KroreIOSzmon7HKs7CzAKGDJmt2IAgbgC5qrdv01bqU5H47nVkkztjcI
 +YO4IXeQl5yzzKUO2MBMr2WC89eMvIjeTUp8p1kScvahdH6bXLLCLQ/1sCYIg6bdmvVDnRBgb
 qrDwBdoNZVYno4oU9rLf3QBLzygLizeaFzdChLpVRe71KncraKV44UbIuJUOICLBei/0cQEIQ
 DWJ4gbYkqdkhbZUUXh685OxGSj7QB1/wnJxxuSmreJHYZFB+HRm3AM+uhpWOupJUAiJOnuRsn
 sylEXtdcQYGiW6SurdpSQjuNjwopHyTEaDcCFuJo7O30jZ9S6bQcU0wDF31d//eexH2ff/yJc
 rrnMRT+f2IVOdcaG/j+B0gbyoyHKAQ11FB874ExhyLrn+vNK+EUb9RpVbY52IoSyQUDYJGztr
 AojxDRDiQavtFohaShT0KqvbdWsJbvDLRpIB7DiEO4uEkKZtcuMo6tnxWcuXjXS05aPnihzI9
 6FNY2yJeUTRMUO4K6opRSq6fjG9regKophydBobtmAGKv13AQAB35QJkmObHCqkhmC6jXjjGD
 /OzpHpDZPqQg9b0xVu4P4TetmpuCZQKuGqGyWJjP1apYSfdn8Ti98cO6VGTnlarX7BDKH6QFZ
 3Gcer6QHIgTb04NqmxbCh40XEurQM+zoaQ/t2nVYsN12TyOyf8t8V/E+t6I+8m1RltWg0TfY8
 0zn2twtQzKnKsML+wFpvAWtQafEsNj0Y0c+nIMAFMdmfhJ233+vnJtfaMZj2tDPhRRRbXuYlj
 5HAS4nQJ6wYIPbXVgtWpLCDf4wnEO/ZCVr+g9OkTwzx7MViWpQexS2OuXZ0x4z8YW5olU6Ru8
 Hr6OmNPjYOd77paJnxczDG0zmpRV2EF7QxsmzRG7UALUDe/UIMqfcAv0b5iRU+dPBx/zQOpoZ
 18BFTjPJ07ecN2qvA6juIKRO2mFW5bc4XKyajDBTh13QKTB68q28zNqvxBC9s9g/Sq41u9cmI
 C0cVxwrdphib6KtuS1Y9Dr+0jwmv3EYST9Ul0Z1kGJ/WqR4bhaOyIq6VN6wq4yJnKy0Rd6drE
 4mp6MbhaeeHko8Bf7RpliqDbAmILV4lhfRh6eE0P0PvcN7stZ0eXe8PP41XSwx8E+yhGnTWE4
 jrO7fkmhtHfmGZ38FyVzwxfXUYxw304ZKBaC9syCgyAdZFiOmJnefKb8GHZAqFg5DK+AwX4nv
 IAr2xEjRxVmFOvDKAOvyL9L1NJmPI9ji7fCdMaTAGscp00Xi6USkXRJVAoT0qUciZ+hZbeNEn
 t2q51PTpWDfJjsjVJSOfGQ3iG3ir4/Bfi5H2fKB5SGE2JklrNOR+FCbiG4Lk7ubCgPWn7cddj
 esWi4qDf/wO9x2Q/3n3hclqtB0kH2hdQHmCJyr5bIh58LULHovM1hg8EobxrE/55x9qTfWIUc
 zJBHpMeToQABiAp+TVkguVZdJupdicCDkRDY3xsiAeZkkYXi8ifI/hN6zLt3VmaBezWhBELlW
 LI4eVq0tP8Lb51ZiloKBvHU5Vuop8T+pqymJUO+cKmY7txofkYGOTvf6p4Lo81tYjvqIjldbE
 8jzSUDLxG9di/c/TZZFAZXpGycgrL/5nEQRyLB0FDsL3iL5D6t2woAlD81YsQj+tjqciJZJLK
 yw487J2scK1CEhnD6UO4at6S8f67LSrZAV257qgDsxIu75op3ljnzpjXydYaqysz4En0d+tax
 JSJiBD092Rlow3MkstpISwwZ4Q+IatSVqILaUkXiiZG1vLf5uucSKqjnrJMEjlZQtnQj4KYkA
 B3iI+bLp4Xl1L5JIZeUfuEhyBhUob4f4Aj/wMGx5KHnuiq4HA4j65T42hjNW0R8Zz6M55sLYz
 MaM/LlCz3uqA5RUcVpFZO8voU67HRDu9G9+Vcm1lFBBcRxA+REMFOfGVfnf7RwUfPisi98BeH
 +QEt4kR+T5F5svQQIdXC7v30SHMx9KIe4xZrJQbr352dUMXCE33sQbt+XT4zDDQKSYEUa1+GE
 fwwokzWRgipNrjTYlnEXt9vSjrJyc/gqrCxd/1F9AgZcvKY01/e2Cc6twidFHnsP0SGVoOQtD
 DtbZ/UeqnSjRMTjkOgfvgw0LrD278EcnO90vvVpn7O7qi8sGSXM3W3bUO7pGUVqPlhOhdRkmP
 8qPwsK0kPXZb4r+ztw9p5M9ElsYy3kbjeaWkqJLVZ3HD3UfZjji7GOJ/qdlAnIcyyBvESZPaE
 +fOQcf+X4wbI88oqgmXepuI1ctqERaPIM0J2+Vuyiwmx8NHOgCEM4M/u+m7Ay1O2RjJ1UmZfq
 YVmAWVlhZ0iou2nq057BjUgnfBgaQbnYWFn5QpbCMkfWeCT6B4HvIDfGZN7nIuQfN6lRjudUH
 jWB1DvsIUO+mHX0XZgS5cFsnruZTyE9EIc06ETkGj7vQcs/kKO5GS0qdi3t5Dn6jRkVbcg1K4
 sau6mUbfW3QrExUXLWd0ufJvknCGvyCXJiUBBMzwAybeHRf/0f9yqNFb/XFhA/KQE0fVvCyMv
 OuzG1UFQyBqVNWuePFFsskBO9E4XTozGa9aMamy4Is7KY20FAE0OzaNa+ojH4K4W4yBiu8gEz
 jWHeHHS9Gm9sYC4n1SSy4kxhKK9IMIqfSTb55bt8hCHPpZk6Ce+OT/4f69OgnzJJVjmI9TDbo
 WHfBJ13Nje5FFjWke6z1ATboQQ6c+80hvcdLM1mI2DwrNrXpUfw1alFOtQA==

=E2=80=A6
> +++ b/mm/mm_init.c
> @@ -2548,24 +2548,25 @@ void *__init alloc_large_system_hash(const char =
*tablename,
=E2=80=A6
> +unsigned long __init memblock_free_pages(struct page *page, unsigned lo=
ng pfn,
> +					 unsigned int order)
>  {
=E2=80=A6
>  	if (!kmsan_memblock_free_pages(page, order)) {
>  		/* KMSAN will take care of these pages. */
> -		return;
> +		return 0;
>  	}
=E2=80=A6

How do you think about to omit curly brackets for this if statement?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?h=3Dv6.17-rc7#n197

Regards,
Markus

