Return-Path: <linux-kernel+bounces-862606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F93BF5BB5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C0644EA5CD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D8132C33C;
	Tue, 21 Oct 2025 10:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nosdlo/B"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BBB32BF54
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761041793; cv=none; b=EMr8VbtNfh1gUkJ7hMGmt92yhLEiCwMXmeBQZABZW8LopEbST9n6txuRyvedW5E7WNkNYNIL0JAU2/dLsrKsKUd55jUotyO9n1DLfPc/zZs7AEDVkY4CHjKRuWD2D9uc8HTv69eIwcncotvmOyURK/AClVHpp8KwyPtdbVZw5iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761041793; c=relaxed/simple;
	bh=k4u+Ihr8vkpW4CkylMViplglhKtMWRS32gog7rSU0tw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sI9Js0+3wnjVed+laz6eQKkgVFLMJZ1znBcfE83Fh7dtSJdk6YQK41aSnWuwPbIU0EFsmJ0M5pg09ZiG/SJ2J8IWuLVHnrfdXCBXJ+EMjvvExjhi8ZF9yxNygjwA6vr1DRrRGen14869Tf8Hjy5SYTkpRj46OPPEhexAf6Nk6S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nosdlo/B; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761041791;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aAfOpf2VC9r1Aq/Ba8aQCcqsQ1cmp5ERa0FiKT74Dxg=;
	b=Nosdlo/BkFLTqHyC+X/Wh5QjqmQwK5lXaYkFIqc5KXxnBIco1Z78dCqnGYXTu4OAmCuciJ
	/5LcKMT7wqID1gBmFGRrvhtQL4Q8TQSaxQsXl/2K3RvxbKtOcOTzjViM7x6EO+huO2kKzY
	9HyQ6uYtkH92LfbfCFiMXkR/UEko6bM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-KkaD_cHyMKisdfQn-7ed2w-1; Tue, 21 Oct 2025 06:16:29 -0400
X-MC-Unique: KkaD_cHyMKisdfQn-7ed2w-1
X-Mimecast-MFC-AGG-ID: KkaD_cHyMKisdfQn-7ed2w_1761041788
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-427015f63faso2787081f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761041788; x=1761646588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAfOpf2VC9r1Aq/Ba8aQCcqsQ1cmp5ERa0FiKT74Dxg=;
        b=BhB4tj8GW9CEr5XP3uTcsq+3j/V+8hwrxcJoRp/xw/2KoF0Tk3Ivgtvw+/L5mRWohj
         G0sStPPPLwjUsFNjs3fhCvVLxBN7Sd4LCxK5FF/WeveVYHly1T0x6Z1LT17ObguF/8cp
         pphCY1jNBztplOcInfE6P4gLxbJkuTOhMOA+MAcs9aWCXOxThZD6mmARKhcfTzpqqgiO
         OhFkEXsCiLAbMZ68+e39HYhebwm1WpouLCMqxT0kquNOotJZSxI6vksh+aLJ3fZcZ2Yg
         NHSe7PslmblxTZyngjMHCTbMnccCF9D5AWLxoca04VXwsw6mYO6wjEaueLsQQ8T6l34W
         UJcw==
X-Gm-Message-State: AOJu0YwgE+RdkyofoWK4+v40q+vUqkCYV8t8TgUi250+nrebTzQXd3I5
	8B56O0O6qqjBT99on1VhwS1NS6ipN7k8pwmmMKlAfmTCj8nlQCBbbHYQiK9ZZYjtqHsLPW8ppDU
	H3SiZtDu6fREq/PSomhPKKNu2cQcNhoF82xGioGu+ZvEmutuRBEbLuTGamwSU8upK0A==
X-Gm-Gg: ASbGncsj0cPJ7nJQZWQPE4zToiMM+oXjKV3GA+Y+9xTjATdIPkVC1z9tT3/SD0dbvS+
	1BynnC+O+tzTSFbGa1x02m6jGCKrV1FjjDEbl3m07DlPr9ETWTtXN9KcfmoZPVL2ZANEfTKDRur
	iQzZFyd1IV5c3d1egqZCNlPy3hASY7dkRbQHdUOFBDFvou9vdRB7iyzifbMfuPtEsDJ7/IAJSkI
	RYajLT+kB7fHGyzpqrc3SE1P+iy1swP/3Z1zpwH6B1BGH5dZvMoOWSHpn17a/qjPRyE6+JsmKxH
	RgRi1muTd6dfBMThTmihX2/0xxm+/2AT3blo+wMDJC6fkwCq062oa1HjZaNMDT5o3a6eGVgLTpd
	yaDOjEdAUoU/mwwPP2QlkJVaS0ZGe/6aIm+f6zuVt/RcXOZU=
X-Received: by 2002:a05:6000:186a:b0:3ec:db13:89e with SMTP id ffacd0b85a97d-42704d1441cmr9403278f8f.7.1761041788467;
        Tue, 21 Oct 2025 03:16:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEk4jyuQMg0K8Aws1Lv1y09/ZSf7i4qxnIBZGs2bQmXI8n6Npjep0Yjfazd/+t0xT4RT5Y7QQ==
X-Received: by 2002:a05:6000:186a:b0:3ec:db13:89e with SMTP id ffacd0b85a97d-42704d1441cmr9403254f8f.7.1761041788036;
        Tue, 21 Oct 2025 03:16:28 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4731c95efb9sm155390235e9.8.2025.10.21.03.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:16:27 -0700 (PDT)
Message-ID: <1e779b80-4645-420d-8cae-36c36c3575e3@redhat.com>
Date: Tue, 21 Oct 2025 12:16:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v02 4/6] hinic3: Add mac filter ops
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Markus.Elfring@web.de, pavan.chebbi@broadcom.com
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Shen Chenyang <shenchenyang1@hisilicon.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>,
 Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>
References: <cover.1760685059.git.zhuyikai1@h-partners.com>
 <dccaa516308f83aed2058175fdb4b752b6cbf4ae.1760685059.git.zhuyikai1@h-partners.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <dccaa516308f83aed2058175fdb4b752b6cbf4ae.1760685059.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 10:30 AM, Fan Gong wrote:
> +static int hinic3_mac_filter_sync(struct net_device *netdev,
> +				  struct list_head *mac_filter_list, bool uc)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct list_head tmp_del_list, tmp_add_list;
> +	struct hinic3_mac_filter *fclone;
> +	struct hinic3_mac_filter *ftmp;
> +	struct hinic3_mac_filter *f;
> +	int err = 0, add_count;
> +
> +	INIT_LIST_HEAD(&tmp_del_list);
> +	INIT_LIST_HEAD(&tmp_add_list);
> +
> +	list_for_each_entry_safe(f, ftmp, mac_filter_list, list) {
> +		if (f->state != HINIC3_MAC_WAIT_HW_UNSYNC)
> +			continue;
> +
> +		f->state = HINIC3_MAC_HW_UNSYNCED;
> +		list_move_tail(&f->list, &tmp_del_list);
> +	}
> +
> +	list_for_each_entry_safe(f, ftmp, mac_filter_list, list) {
> +		if (f->state != HINIC3_MAC_WAIT_HW_SYNC)
> +			continue;
> +
> +		fclone = hinic3_mac_filter_entry_clone(f);
> +		if (!fclone) {
> +			err = -ENOMEM;
> +			break;
> +		}
> +
> +		f->state = HINIC3_MAC_HW_SYNCED;
> +		list_add_tail(&fclone->list, &tmp_add_list);
> +	}
> +
> +	if (err) {
> +		hinic3_undo_del_filter_entries(mac_filter_list, &tmp_del_list);
> +		hinic3_undo_add_filter_entries(mac_filter_list, &tmp_add_list);
> +		netdev_err(netdev, "Failed to clone mac_filter_entry\n");
> +
> +		hinic3_cleanup_filter_list(&tmp_del_list);
> +		hinic3_cleanup_filter_list(&tmp_add_list);
> +		goto err_out;
> +	}
> +
> +	add_count = hinic3_mac_filter_sync_hw(netdev, &tmp_del_list,
> +					      &tmp_add_list);
> +	if (!list_empty(&tmp_add_list)) {
> +		/* there were errors, delete all mac in hw */
> +		hinic3_undo_add_filter_entries(mac_filter_list, &tmp_add_list);
> +		/* VF does not support promiscuous mode, don't delete any other uc mac */
> +		if (!HINIC3_IS_VF(nic_dev->hwdev) || !uc) {
> +			list_for_each_entry_safe(f, ftmp, mac_filter_list,
> +						 list) {
> +				if (f->state != HINIC3_MAC_HW_SYNCED)
> +					continue;
> +
> +				fclone = hinic3_mac_filter_entry_clone(f);
> +				if (!fclone)
> +					break;
> +
> +				f->state = HINIC3_MAC_WAIT_HW_SYNC;
> +				list_add_tail(&fclone->list, &tmp_del_list);
> +			}
> +		}
> +
> +		hinic3_cleanup_filter_list(&tmp_add_list);
> +		hinic3_mac_filter_sync_hw(netdev, &tmp_del_list, &tmp_add_list);
> +
> +		/* need to enter promiscuous/allmulti mode */
> +		err = -ENOMEM;
> +		goto err_out;
> +	}

I'm under the impression that this code could be simpler if
hinic3_mac_filter_sync_hw() don't modifiy the argment lists, but set
some flag on the successfully added entries.

In case of failure, you traverse the tmp_add_list and delete all the
unflagged entries.

Both lists are always cleaned-up at function exit.

/P


