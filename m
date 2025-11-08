Return-Path: <linux-kernel+bounces-891342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FBDC42792
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 06:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CBFA3B4EE9
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 05:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBEE2D9494;
	Sat,  8 Nov 2025 05:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIVOYnQg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8kn+qWm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449902D8379
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 05:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762578678; cv=none; b=c9R5yQaBS3gddMHycGVDv4h7hOELXxw8hO3CgOaqQtd6AKSk+LFsrhEXT6o+pm6xc4818OkqJLvMdTNFAbhTj6W/MvxAS9l6OQmY3TgW7VmxiI6UlgJBVHckKdbJnPGc4E9UOfyU46LjciHE2BOcpCFqztSoxCcl9jLV0SZgNRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762578678; c=relaxed/simple;
	bh=X2j9RurZZ2lQAPVeaVJyZ9A4M+s8fzPu+nQ2gpSP1K0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FkjGaJV3r9GdoHrwJ36fV2yVuWNykCOqeSdV1LaDtJk2tG047dYJtuYAD/qCi2F5oExRE7L7F0KxSTIeNqm87nSjodDL22W71Pcxzu+lkrvrStQ+WGXRWaoIjfWg5kzX9ZcTkketxNlnz9CGrC86nm1Reuuj3lzOM1o+TBk2X4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIVOYnQg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8kn+qWm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762578674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E5RVKnDwMe3MsMRRiwpHYF55d6WxBj8NQ/HClkP7h0s=;
	b=fIVOYnQgRJCdf3hGbi2WUYGXLLsfm+krLYrp0y4ViXxY8eZqvXpuG9480Qbw96FJlVe+7b
	r66jtDp5stylOaWS5DY5DEDzQqlSVK5ZiG4kiXOnR7bGGDkVTdDyP84Vv2sKtBLKJwzWKi
	33Ygf011U20xBTGr0FZw38pZnlk2Tk8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-MlRKXuMVOaiXVspT4qGnig-1; Sat, 08 Nov 2025 00:11:13 -0500
X-MC-Unique: MlRKXuMVOaiXVspT4qGnig-1
X-Mimecast-MFC-AGG-ID: MlRKXuMVOaiXVspT4qGnig_1762578672
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7aeb762bc40so1175280b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 21:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762578672; x=1763183472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5RVKnDwMe3MsMRRiwpHYF55d6WxBj8NQ/HClkP7h0s=;
        b=C8kn+qWmFrzL2HWSH8iIVK22VNn5YHBWKNDQGNcDJiBTr8ltcxtIfPVz1FHYix4Qbt
         VqcZViB2ST+4gJD77Cj86AZIgra4NjL/f1W/eOvuooJpH2Ap45SDQb12Dz3jF47RkvBs
         cqNKB1KEcH1KvsOUsIMzjXDFxGgt4t3qpLO8nNqjweEvJEgOlHW3TeLcu9nkvde580u9
         yGUvLRaQPdZ47sQHE1J5/e9UpObemXYsM2/G0wrbfGZTkItdoCICDsUIKTf39WW8xKDK
         kByIsy7ktMBJRrY0sJohhVseULHDEkmW8XqrsszmCuyZGNdboOaKSEyH9xhp2IaPL+V4
         Bbow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762578672; x=1763183472;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E5RVKnDwMe3MsMRRiwpHYF55d6WxBj8NQ/HClkP7h0s=;
        b=viO8XznKvzAUuzs9v++lIIXBN49VuTB/CjBaXgHj4EWRzv2QHInyJLJuH688zDFHi9
         m102X4vtX8yjysFqIMYni16m4oPNq69NfXtShy7qSCO8ucQQb0C43R7/RGLK4kaRu6m5
         F0xEOxOXw8Feiq25zjSJy5BdgIfOxr2IbycmoQBGYtmwA2fEFOdcvVjOLjLw52GWmjQ7
         F7DsFi2UQT3eW0b0W0IoDlN2RcV5F4z5P5z50RqPh8c2RrGUE90YYxCUL0Gf2MvYAVGm
         GogFieo8BapJLcaG3QAF9mReX/vPVmDChk7sh71coUvTlenMQhpSE38ORkJGJLEa6hnK
         8/zA==
X-Forwarded-Encrypted: i=1; AJvYcCWlbOKTGuuGPSB5l+SCbMf5uFpabfMV3iBmUGrxZqtijUDId7u6FmW0U8DlFQwz/3ci3TQxyGbRZ7eEOpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw3M4FTIIho33tZ1dWyAlLjqg9z3nrfLZknZyrmrsx1SzXjqD8
	a8gy3uokMwJsgqWRsHX5afmTs4i76vyS4O4Aky86T5Wa4X4T1P8TzYc7OaZ1a+6Z+QTlipKDD9+
	iuAGW+e7X/8cGz4gErG1+ftADwK71nKb496Zv5P1fjQWHlW3vXzqzWmnjYyOYL1Br4A==
X-Gm-Gg: ASbGnctDllPdx6vO7St6EInqT6FO5OVu1Es4mpqxc22GNMzxF9x4aGO9bbnHGR29saO
	6UxqT79qgG2Dm0HaabqZu32+6c5k51Hz9an7OhdMhItJozdvhCWBZZfYFhY61vr0Sik8sIVzEET
	w1B54D33zZX1T+4gcflxxmkQWcLfvs17Qrckk5fFOXVyLfdRxTUr7V9zGOPL22W+PmZLvx6rbVD
	aKzYYt1aCRNPKpaFWutH8G+X7tHcWowt4JCsqvZQ5ujSnh7QBISRg5+GtwojD+lRkfKFtBt+6XZ
	DbIc8WgxvPu9rvuKCeGLtuGpG78gFQ7p5T/DDyJwtx/JoZoaPKoChC1Igzx3ysZ0hfV30MA1odo
	v1jAIk4auKPh7gI44cEbtCIgPCLefaUIFdbBh/1E=
X-Received: by 2002:a05:6a20:6a08:b0:344:97a7:8c68 with SMTP id adf61e73a8af0-353a448bd92mr1787268637.54.1762578672092;
        Fri, 07 Nov 2025 21:11:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEoYg32blcZZ9sLbQSYNsjasNR+q+OXQEln3dsLqwv+tsm09w3tu1QPNPDwtq+FZYazc0/esQ==
X-Received: by 2002:a05:6a20:6a08:b0:344:97a7:8c68 with SMTP id adf61e73a8af0-353a448bd92mr1787215637.54.1762578671653;
        Fri, 07 Nov 2025 21:11:11 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8ffe36a9dsm6671472a12.17.2025.11.07.21.10.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 21:11:11 -0800 (PST)
Message-ID: <74c37bd9-bf73-42ff-a9e9-dc55cc192c50@redhat.com>
Date: Sat, 8 Nov 2025 15:10:57 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/33] ACPI / PPTT: Add a helper to fill a cpumask from a
 cache_id
To: Ben Horgan <ben.horgan@arm.com>, james.morse@arm.com
Cc: amitsinght@marvell.com, baisheng.gao@unisoc.com,
 baolin.wang@linux.alibaba.com, bobo.shaobowang@huawei.com,
 carl@os.amperecomputing.com, catalin.marinas@arm.com, dakr@kernel.org,
 dave.martin@arm.com, david@redhat.com, dfustini@baylibre.com,
 fenghuay@nvidia.com, gregkh@linuxfoundation.org, guohanjun@huawei.com,
 jeremy.linton@arm.com, jonathan.cameron@huawei.com, kobak@nvidia.com,
 lcherian@marvell.com, lenb@kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 lpieralisi@kernel.org, peternewman@google.com, quic_jiles@quicinc.com,
 rafael@kernel.org, robh@kernel.org, rohit.mathew@arm.com,
 scott@os.amperecomputing.com, sdonthineni@nvidia.com, sudeep.holla@arm.com,
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-6-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-6-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> MPAM identifies CPUs by the cache_id in the PPTT cache structure.
> 
> The driver needs to know which CPUs are associated with the cache.
> The CPUs may not all be online, so cacheinfo does not have the
> information.
> 
> Add a helper to pull this information out of the PPTT.
> 
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Equivalent changes to the previous patch:
>   Tags dropped due to rework
>   Fallout/simplification from adding acpi_pptt_cache_v1_full
>   Look for each cache type before incrementing level
> ---
>   drivers/acpi/pptt.c  | 62 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h |  6 +++++
>   2 files changed, 68 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


