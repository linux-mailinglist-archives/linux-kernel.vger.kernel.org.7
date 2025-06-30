Return-Path: <linux-kernel+bounces-709164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1252AEDA00
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 12:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2A51897CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jun 2025 10:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C513E2512E6;
	Mon, 30 Jun 2025 10:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0VsK1hv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E72246BB0
	for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751279928; cv=none; b=RNQ0l5NzzIqUmUX3coY3dUlBp71SMamrKFuNS/7zUS++nwRYchJoAKrLHfET47y5oP9ugkEhOaaWF3pojV5ray/IHQ+AoXgXVFfJiZ94AMtJru5SNVD2rJ/s3b4u4Jz5ioQQ5HIwLC8IaDU1QDGrzod+v/cG8aYI+/C+fd0SOhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751279928; c=relaxed/simple;
	bh=KI5H1B3obLGclGzIVYoqT657wg5uoacHX0Rz1Qbk5U4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rRPQOsL3btRE8iPXh5BgTgzQr94wKNMswyWmdBumuTQv6/BJ4+N3bTkeYSblAlDCzUDyfx/B3+aPXP2NLxOdOgcMBLWQxcsoTdQ5BWVeEksogW3C5YNH+xbBDS2cWybFcyq2/H1Q2X5XMW3TPzbiQi/FRysBcpLFLCHuF9HtRYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0VsK1hv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751279925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=67aFXQrWHbpI4Fyl5DLESwSzgu+5w69Ws3Jiartc4Ao=;
	b=Q0VsK1hvvSJkjpUc1Nvlx+8/uSxI0xPJCV/jfkiOJs1Lz+uzn99T85qJT3+HmqOam42DMQ
	rdsYNnC52JcPeT66haR2V1l+3YzPFNHJAUXF/pMEUmG28jo0+v5aRxDYdNc1nWVkpQhVMN
	Jz8Fe77Mb1SDnn+d/WwLMeBjvTD0nXc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-hSI_RxryPl6mbt63sxN0Aw-1; Mon, 30 Jun 2025 06:38:44 -0400
X-MC-Unique: hSI_RxryPl6mbt63sxN0Aw-1
X-Mimecast-MFC-AGG-ID: hSI_RxryPl6mbt63sxN0Aw_1751279923
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4537f56ab74so14223165e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jun 2025 03:38:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751279923; x=1751884723;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=67aFXQrWHbpI4Fyl5DLESwSzgu+5w69Ws3Jiartc4Ao=;
        b=MGUQHnrOyWCNdUhV99RQMUnspJtVrnZHbH6jMCswYaHxblmrsViMn83DBMCpJ8vcZc
         XEzAU2olW8zbuUV1Lqt7Qf18auFe+lPUPpHaDGR0FMJVYvYIzJL8lFxYqFpDifge+jCW
         zrAia6cHZn3XveDTCbkktDzl/A6eX+5gMrBxBZoz+ZWDYMW4RN/TAjTKzZgV9v/9uKyx
         ovQCbTvYFVxLKnEke+P3hUzAeT2/GYWx+o5mbD6FIcU/1Mvo6/Me9V7hnG3FOvHMgQOr
         gcK3pIx1pFpkRyEPPr/Jj7CSlpvr4tGmsqaivuWuMA8maPZjZKsYoNkhnTA1ifmfc6Ug
         b6Tw==
X-Gm-Message-State: AOJu0Yy+vypPypQv0GshniuKHQ9WKyyG/pBjmFVYTyjsbPbopIbHi/CH
	K2nHlvh2ywIflrb06Fy3gpu4z5gkzgo1xOgCxevb1X33OX7jTBg2CQMBosDCmakUdYm4he9owAv
	6HNlos7cnw0UaulSDEjcJ+SeBpTOa89YIIBi2AyBkB0Z3eQvdvXZM6CC/xa6GOKVHswXYp4UbXF
	w676zmtf8ZJMTKcTBvSQUlYGO1Egng6l8PU6f+qm5lj93+Gba1
X-Gm-Gg: ASbGnctSnJpq6Mg/3kAsKDlFUgk1Uu8PQbagz3w+3jnbtIh3ibeCdeOa8M75b8pUF7Q
	ffKPztMHhSjeuuyN3v4iyA3QghmSIyzj5UeiZVfTBDnzN+oqlEd/ZHGwUi7iaKU+GxhXaIe+7TV
	1tp/slBPfphn2IMxpMWiBkh22NT/ASW1hJTVmcB3cJCDDwIkFRdUzoiMTge003RNWRXUUnRizl8
	S781OjwJgw22tyhpjcpsXTdVX+gWeFLMsbaTSm0ZyrWa0hDbApi8OlTZ8YEdcUxjr6s3/Oa5va7
	YePQXe7ljim3nLw4LNQq+lcyfHSOlIpgn/iFzJNk6NSTrt9LiQJpGdcEGX5ZPhLldyKHtSj2BDP
	WiJ7oR/iHataNDXrjwi4xXQRAuR4IcoQ2wi7oyUlqF5vadOI+EQ==
X-Received: by 2002:a05:600c:1d18:b0:450:d07e:ee14 with SMTP id 5b1f17b1804b1-4538ee60815mr148032585e9.17.1751279922907;
        Mon, 30 Jun 2025 03:38:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbR0EXwYLOIn4B0J77nh6IYL3kQZ2rdcN1jUT78ZTpALrM9RwX6OgAGv5YOD7axO14le8E/Q==
X-Received: by 2002:a05:600c:1d18:b0:450:d07e:ee14 with SMTP id 5b1f17b1804b1-4538ee60815mr148031685e9.17.1751279922315;
        Mon, 30 Jun 2025 03:38:42 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f40:b300:53f7:d260:aff4:7256? (p200300d82f40b30053f7d260aff47256.dip0.t-ipconnect.de. [2003:d8:2f40:b300:53f7:d260:aff4:7256])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538a406ab6sm132793025e9.30.2025.06.30.03.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jun 2025 03:38:41 -0700 (PDT)
Message-ID: <d2a304a0-767f-41b9-b040-a43ce58bdff7@redhat.com>
Date: Mon, 30 Jun 2025 12:38:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 18/29] mm: remove __folio_test_movable()
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Minchan Kim <minchan@kernel.org>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>,
 Chengming Zhou <chengming.zhou@linux.dev>, Miaohe Lin
 <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
 Shakeel Butt <shakeel.butt@linux.dev>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-19-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250618174014.1168640-19-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> @@ -1164,7 +1148,6 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>   	int rc = -EAGAIN;
>   	int old_page_state = 0;
>   	struct anon_vma *anon_vma = NULL;
> -	bool is_lru = data_race(!__folio_test_movable(src));
>   	bool locked = false;
>   	bool dst_locked = false;
>   
> @@ -1265,7 +1248,7 @@ static int migrate_folio_unmap(new_folio_t get_new_folio,
>   		goto out;
>   	dst_locked = true;
>   
> -	if (unlikely(!is_lru)) {
> +	if (unlikely(page_has_movable_ops(&dst->page))) {

While doing more testing, I found a weird bug where we end up having 
balloon pages isolated forever, and never putback/migrated. So neither 
the balloon can deflate them nor the migration migrate them.

This line here must be

if (unlikely(page_has_movable_ops(&src->page))) {

But I am not sure yet if that's the issue I am chasing :)

-- 
Cheers,

David / dhildenb


