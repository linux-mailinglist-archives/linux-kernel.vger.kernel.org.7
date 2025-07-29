Return-Path: <linux-kernel+bounces-749504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EBDB14F31
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5993BA247
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9CF1DE8A4;
	Tue, 29 Jul 2025 14:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="T7THlioU"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94F31D8E01
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753799071; cv=none; b=cK9MU3j6jvhNLy/ayPax25eXONPfaSl8P/vr2oza6tKKjcgifSgPIfuqq+7OGK6PkpHKdislGNc69y1ppi3F5w5W1c5xlgjlqghGARrsIgFc5uetQisOjvDczGLNGMZn3LLlKf9MUassAAupgvAatWbvAfK06ffRyORorVQUhag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753799071; c=relaxed/simple;
	bh=ec5WyyYI1Bxo0murcCSV3jplVPxieQ/uucSm7GFQQHA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=hY+xd4u/ZeC2FjBRFW4bieairr+AOfA7OXpHf3AnC7Qo3FJljkvFXK2Ae91J7iikTvk3DOnqvDmQYi26buch2fcRZYFCtkrg6WiZZfjjncKFvY0j2KIMyVBnFCB5JRimPtDa6cYnGqVkrlryT6JEiNpdoK1XbLWTRcoddf23R8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=T7THlioU; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753799017; x=1754403817; i=markus.elfring@web.de;
	bh=dF5ZI7eobCdwBR53e3yTpvGGc4brQ3ds8RXh7qzIz9w=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=T7THlioUFPOFqg4g+zBs+QHZ1sDd1n507Y2PqlicV4/btDq4e2y4TVZrO39FWKKX
	 t4+aIyDbw0bPGIvkzFk+YnVpoa4CNlj0R5KsM08G8iEU7yoJvZ/g8+iDE6EFzjUf0
	 MWYPTMRlR/Av4v725Z3LKez8Z1Vs/NaomJqymEV2zc4ORs6nQHgIc/yiSIvNOOFlB
	 ZHLu5LphuseD0pnlILCLTehT7p9KnC/WicJeNVNIOxw+ptiwx+TQXV7dG77RMtqm0
	 ciQcnxq5wem/ZW6uTKAikonKL2CYT001KOLW7LaAyuDAmnS1FcbTi0K1WA9Wi545Y
	 KkAM5LuoZOUHYKmuGA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.201]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MgRQD-1uBWxb45B1-00qYYB; Tue, 29
 Jul 2025 16:23:37 +0200
Message-ID: <8d908a98-bfb1-4008-9944-c33dc035d42f@web.de>
Date: Tue, 29 Jul 2025 16:23:26 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zheng Yu <zheng.yu@northwestern.edu>,
 jfs-discussion@lists.sourceforge.net, Dave Kleikamp <shaggy@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Edward Adam Davis <eadavis@qq.com>,
 Jeongjun Park <aha310510@gmail.com>,
 Nihar Chaithanya <niharchaithanya@gmail.com>,
 Rand Deeb <rand.sec96@gmail.com>, Vasiliy Kovalev <kovalev@altlinux.org>,
 Zheng Yu <zheng.yu@northwestern.edu>
References: <20250729000508.3517823-1-zheng.yu@northwestern.edu>
Subject: Re: [PATCH] jfs: fix metapage reference count leak in dbAllocCtl
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250729000508.3517823-1-zheng.yu@northwestern.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:a6fgcWczpQnQRayUw/Xv+eSQTEERJkSMZ0OYf65E9dKUxibf7+M
 b+e0PXx2TNKJHXTITO6EF+PNB5jOMP6RBuj7ViQ9vqSGkQXl34QIYWnFrgEeFH9WOe1/1k8
 yn50ctML6Y0JmNtwq1CaLprPFO7t2tRIc08M6teNB06WBfmgw9gCDjMmoI3I+vPK/NZMcxg
 LeRzdtGNR6fBBYOXAZDCA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9WnkSHYJTB8=;sWjWbOABOLqsEFra5bY/R5KVSE3
 fMS8utLHo1wqSwbyJgkiVpBaVFgT7QVwa4XDgiNq+Ra5iIjSzT02uCLE3Y8ygA3GcBU8kIxjy
 Y4/RPD16e9bBh6qk4vMxFkG/UnM708wHtp0bJGaJLRsD4wYwXnCxnHs+xyoXb4L57jFTtVcIX
 03//Cfcal06JWtyNXgPndgwWJUpvZaFbDWRWHhzjceruEpTKO3J7JptcaOty13MCHaOjUuUUE
 h3SJS9fvSBxxccHNSR37IS1Gvvm0fggbwUtgKhUnnbE2GSlgmPOIoXkXE/dzaE6AGqDTfxONx
 iAtG65nXw5N8ZD3jbO8hXAgSav29L6a3RIElCrgSMpBpFhfMk14702FfjvcLquhL3HoArmVH0
 UPvZz/SdHy8UIL3QoMjecTxaR8qNcm8y3hJhFuckul2wW3eTK+JrHr/hhP6vaYg5j2Lmp0jmP
 NQP1dK1I86SvccythJNaiKtmClJqijp6kUGzmdzuCAUpHtPo0TF5IJTk6O6uvJfMI4taMhFbH
 CtEKohuqtA9qY3ZbpBOGFmPOAGgvtbTdqVtXbtdBni7m+G8bTqopzTBEWjF20E++rp31pQxjl
 8YbGlmzUzXVpHWyR5wKtOEipzSD+RNPpweR/PlzCj99qrjdUzF8a2nzX96jotJDhOkBRusiZC
 PLKd9HgSkcSoXqhuNZP2hUv/Iu0JJ0xfM1TWfy+VDmn81xmTAruYjTf/Ol78/SEzRz9FJtRq8
 IUX/X4u/A5GfqDWHqBeSxuhGtSRr0UmkdbYlQ6XPv6qkXI2MLvm0LMIfUzXy3iUqkn23wc7AN
 V56nz+DgozR9LImp9GuroJuMAZEOdYgm8mnyErBUiEW6EQSFX962lgFhzbkrt0f7XNS9sYmRl
 OL2+PRNvk7koj/4Cx28qfp3a2mUDgqkwm+yLUnWYWnrTZweAJRNZptrsun/uleIob5zRLsex1
 bjcblSwwo5LPlWR4X6VtZfTRU7lk1VXzBk0Xn8J+v9HrAgJCAGyYm/T9ZN2ufjHka9LPES5V7
 BccCzQT3LODdKsMjT6RZpCoeH7C1HQpAgOXWwxdL0EkQB6LnzFANCDlPMAOUV0r5lNMtZlX6f
 vX+x/SDUZJZYTnM/XKZChrX+lNBRzHLFyBy/A2MSZpr7DlgRcxIUhEhosKg83UYDHhAI52oo/
 Sm2RpGa64lBRDCzE6OUb1wogYdCTKlOqeBHzJzYMfEiKmZGLJCBe4R9xVjE4mrnv65gfG8Jvn
 xyB9QtFNYR1MkN39nmBBen9/uY+Swj4LdOX/QGm6X5VKgP2Yx3ujPHj6JuqYGcsoT9OVIjnQf
 EtjUQ+OZkTYRp8y08JdoOvcSvac3ryKazXu31YhhSMZF+ea/va7XEsrodBsZTY0g3t1SJMjKk
 O/1+KsV2Q2sLTS9j9B5F9b6+PzGJfd3W//tG/m7+UVhmEfPZESLVT1MFMM9g37ASGhqBd09g5
 5pHw02J9qpD413/kXQhMtStrfNwqKUzfYRVpmYTnHBh6szRZSmt/xduH72KpKozzCgQv0ACna
 +Mj9i43gm2t/XzyH4lp5ssoarCfdtmcT/6tt17B9MBsSOeGHf0gyTaxp9QHiMgQZK6zET5IJX
 921906AXKo7wdx72FYvlinSlZ7AUs3kOXuy4/phjmtinh1GMIKlz/fKi/LX3uf7j2IsssWt6O
 EyBjHGxp7g/WcAo6529XsIpxSDvOTOf2RMnpqliyxH4H7DYe/Bm6+eiTrld4orjhxW5UGqJA8
 Q0osfexH+U+v92wrEwFjZIoE6CUCeZt6MVODY4U4bnNFc8z5utgiOdtivh4lvnu9Sqkf+3u58
 UfAzsDvE9U9zJGPOR5jpD/YHuMNLy9fhAu4Pbs81jPJfW+Kbz8Z/376/MR/0+w+3VUUyVqP+A
 cbuJH8hS8AlLuWPnIoQymhDjnLCGrTjzU/wIW2BF+V8d3NbwCL6odgKHlR6bisI6yf8R82A9x
 NKPvtWhHr9tBbtTQBqAMSbALVi+5MoyR8IE4y1q6yGtYsUdcPhL/0g3KtNfcTvVU6Zit9/LxL
 C0KbyESMuQICAV56Vqvho63dEoircrHZqDUPHN6Rft7Gk+mTxz6yb14scBSnKWLW5pKAHijYV
 HGrcuMoDh2SsQbTRBOVRV/Ka/XYGJYPlRpymG+FKUCdVJT1+Unc6WruFrEvXTXmIntfzDQKLI
 pdORqXxa9xPhdjZZ4PFz3xrnYX6qSswk7rHiVQF1lO+HFsiSCfnZGUdB07SQpAc5r7UieEMIB
 ImZQvugXcgqkM71aX7hh3sB4fuy+4gYKjkuXinLEkFQ8R2mbNYSNgpub9XiISDQp/v6HOBOcP
 /Ai+3BG3cAc/TI9KOqo6jfh2KOO1qb3DNSxQ4/r4SWplXMcZgcU8a29Zzjiq7zmCP17n5HuLW
 +3o3weUjqCYb43jp3vFFCvdKmkKFIXxvkQI2KvvAy82Mzi0l18PxHok7kuCeibvwqJeZfmYDt
 FOoYPTKk8gc8IwbTex1c3moxpZToJuO4henqbhxcS6JHqk6iE3qqjm1yaCshA8xqXUy9jJx6Y
 xYKxT0ZBVjcb+YYy6wH1v/qe3I0/YoKxERDu5M9lLVRk+9O4wy4MUOaVoV0kLudcbxshJmlPo
 9nnziSoW4BCcahrtuoYqujPlP1Jtl+TjhH3a+KgeI2NOqGVnbrWcmwNXr/gpuia3v8u1hgE7P
 UGeqG7n8r7VwMoDXh7TkdCQ9WZLvavw3AelmgekFw1y9i4aUT8pCcq21X1JFHabIyYVPxM8p8
 QsB3lZquXXMsuV/koHngbBusQt96DO4AcHAtilX25wRkLZZkgPedGuvtLVHMQMpfhWFlwSJkT
 9rrpLY96PIGbl1Wp8+e4AuDlekMyAHSO466MDpFBCYV1EanjLekba6WR7LE+bZwZRETY5KO6h
 sj/f/XRknWbGpSANudNsqt7Mg6io6p4N1WBItfWc83RDd7Ud9d4W1suhqtnaJg+WN0gjD9WY2
 8E9m2t0v7KMOkQMY1kWPashJzeYsDFLqjydYLv4Ni8DSErA7I1ac6Cw+Qd+sXArlPRkYF/2EL
 N0J0UIbSnKiy/2jaklGiEHrNjjkPKHREZS8LAgITBgieeqc7p1BJErTWwleNHNrx9d3nRE5Bs
 pyznnL68BV5d9j2rb5571LEiDaQrfhoGG1ijFLGPImbC+h4p449jhY2YBKWmFUIp6CoJogyIL
 YQCSZBG7WGx/JyP8yrk+WEybhRY19HvskuGyRENma8vsEgyAhBchucpWW2hYzvzISEhsRpWmI
 mttMZJV3lSlN5TKS+eNiqtRAJQ9kb1KQJJqIoua1jwDOInlDFbbYofARVDTtGlO9LYhrfWdme
 evmcc4Ov+wJsVJnJWKGLlxcjXWBGjJpLM1ya8FqX7nkp6++k7df4N/j4m1b8CshKRwgj6kHya
 +Q5v4whn1ZWHYeXo97u8ewYIWA2+u5d6bn3lzVk1g1CNezto5EysY75xjlirMmQ4bPkSLmznx
 omAzO5ElxRGGLglij3zw1gTKeql63RTKAq6iETeIOiB/0oW11bClWvu52kg7wypZLlp94TiCD
 1Q==

=E2=80=A6
> +++ b/fs/jfs/jfs_dmap.c
> @@ -1809,8 +1809,10 @@ dbAllocCtl(struct bmap * bmp, s64 nblocks, int l2=
nb, s64 blkno, s64 * results)
>  			return -EIO;
>  		dp =3D (struct dmap *) mp->data;
> =20
> -		if (dp->tree.budmin < 0)
> +		if (dp->tree.budmin < 0) {
> +			release_metapage(mp);
>  			return -EIO;
> +		}
=E2=80=A6

Would it be a bit nicer to use an additional label for this case?

			rc =3D -EIO;
			goto release_metapage;


Regards,
Markus

