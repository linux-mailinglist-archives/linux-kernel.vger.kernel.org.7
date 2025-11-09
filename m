Return-Path: <linux-kernel+bounces-892174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC9FC448BD
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 23:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B97301885AD2
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 22:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93EF233D9C;
	Sun,  9 Nov 2025 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3y9m4tb";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="T8/MTURF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ACF1DF27F
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762726307; cv=none; b=G123MsbA1qG430irDdA3rCa+Wawv/IrkNMwBGYjge51i7x4VIjVwTOhlhHbNMPWHgxzBZPN9wxDQgbOGwhBwFTWl7A0iC32/qxiSOYAXXYUBzxE0I/yJ9e6nj2nrlZzdan7e8p9Eq2wrzNiYJXRqR5nP1Tney56MjnIzMbVRweI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762726307; c=relaxed/simple;
	bh=EhAKRO7WMDbjstmS/+6wn2u687jYKO5Z31A7AViGYek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4Im1GueGtjHw0SxE8g26t1UuxM5hrnC6JoV5ZLKv99l4vd3Fad8prQtbretIi2BoqzkVelshmLliA4vYPwlrosWi9b4NgiLlPLy3SLbdkySf0VR6ZmxPUvGmS0U6B6Kq4pRbA4KvMHRxy5cG17Z9hdSvwTBbNycEc/CPPdLR0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3y9m4tb; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=T8/MTURF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762726304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=torA9iD+O5YccAO+gDgO+OReSyG8Lrsf/jD8r76xtZI=;
	b=H3y9m4tboWoN6il60IqgvrfxB0vmJTtOyiSwVxPGrzQLbQCb5pHYKTGZnLcAb+UREHql7z
	E5E9Fy4tvbBY+yfdXWCaXMSRz6OffnVQA+2GVnl9XrZRN3nGXxGhclaa2NQ86EJFqgSlqE
	AI5T+7tXHt9ohUfVlefoSUFCGZEtR6A=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-M-YFsCJOMJ6fkWvO_rlAIA-1; Sun, 09 Nov 2025 17:11:43 -0500
X-MC-Unique: M-YFsCJOMJ6fkWvO_rlAIA-1
X-Mimecast-MFC-AGG-ID: M-YFsCJOMJ6fkWvO_rlAIA_1762726302
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-343823be748so826877a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 14:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762726302; x=1763331102; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=torA9iD+O5YccAO+gDgO+OReSyG8Lrsf/jD8r76xtZI=;
        b=T8/MTURFE8+I91YBXFIZft6kqCdFWRbqjPxQVa+0grGvSn2KJZoLfD++oF9ZWlOT4Y
         zxdh5MarVOPONf15MagbeUdPdqqSPqm7qY9xwQQMhv7lFAzBA/xUqdvcVV3cjmLwtU7Y
         ZRLIYVMeCxaK5BJi3N4r13ZgJDMoyFuo/o5LmRr73WkvPj4oXrkj7tQv+SptVMm5LFLD
         hqK/0x1Z/mZCcmfw3b5+QNfJOKlJWegHgKgSS03sIq0mskQ3ULw+K+9w2bdiq6kZtso3
         GOanm7QXFRbjSolvcin6tfLL+kmoBbycTWzSsK/Vi4+/yZrpM2Mo49spYosgr9fg6zMx
         IA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762726302; x=1763331102;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=torA9iD+O5YccAO+gDgO+OReSyG8Lrsf/jD8r76xtZI=;
        b=O77mChSdBJeIXESeF/e9dM18HT7NwHm4eTSRv7343QpgMc9jO0Qby46nHKKk1sISE2
         T66EcITx7ernZZ33PlhnnTc4eQ4YwCS4kwk4jR6BAd2O21Oqe1myFZ8qaAfsdOUDC3T1
         /n/fiawDBLquSAmkRZENoCg7brabx+/o3POUlOlZcdM+a6TRqJ1qqt/PfiKz6eLQsxNg
         L9T1VBYqvU9VpQiNe0Rz6PJC/vojrztdflOOntTvLBPYTUwN5uesueWkgXCskdWEb1nI
         yYjqB9ZJtXpSSdrb2Fe74v3JuJTJ+bgP5PN8ntcn/bdYjG6Q/4qHlFltmw/YDCwEWPR/
         a57g==
X-Forwarded-Encrypted: i=1; AJvYcCXUnxn+nqkqgJ2BdDmlzxSgFVDg5kjB/bPW+0d+V7p5vzkOMnynLODybFDiWnOvZPcm/TXATPXZIKLYe2k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6ULPvPuJkKYRqSXkA6uFq/9/RVOQWxT45y8nPqI95Sr+mRAx2
	GyivIcyaK/Gyx+mZXuNYKQMs25UxnZBb8kcycmsiIwCy5fmIj4U9BXLKzHogVKC3+xEagERcoOE
	S4FgSGvPzY0qPHqgoGKG87q88mq5seDQc39vP1tLVUu6MwXDyNRrzDvzGwyuvHFkKoQ==
X-Gm-Gg: ASbGnctczEF+3rZ395n1nT2OOxgZUFMBIYIIMxZDdjvavUt9yL+a4K11hCypwUn9We1
	uA27azcXMxL/771TmoLfMHXMQYP7O/66LqoEqjGSpJSA7vB5U5sqegTrATvDpW0JCXS8x7vaqAA
	FZQ5L9RTjRFOE5gyrk7TEMi9YlfatjrwUG6ZWAjlz7JbQR0lTq2xnRbG2hMg1Sa6HVIT2x3E//n
	r/ONq7y1ve+ksSaYKwTyjycU+59UycApT7/2B6e0eGvCNEJekXXCnj1eGNfXX1o0HUbCDyQI1fj
	W1Vcwjh+oua9ZXQdGYpQK824YseZTYCVt+6O7BIV1oxKlQCgXl5xpSpNVMKMmjppzX2LZdwgXaM
	hlnnKFyA/nCZOroqut0NOU2ZRegitsfrkrluVG9Q=
X-Received: by 2002:a17:90b:3811:b0:330:7ff5:2c58 with SMTP id 98e67ed59e1d1-3436cb7a977mr8352236a91.7.1762726302250;
        Sun, 09 Nov 2025 14:11:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkgqRagTj1BsYFqTTiIN11rDYYz+ULLJjYUpCoKdSxULvZJZQzp6ZykLD3a8LycOtC3JeYVA==
X-Received: by 2002:a17:90b:3811:b0:330:7ff5:2c58 with SMTP id 98e67ed59e1d1-3436cb7a977mr8352208a91.7.1762726301879;
        Sun, 09 Nov 2025 14:11:41 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3436c3d7dddsm5430819a91.7.2025.11.09.14.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 14:11:41 -0800 (PST)
Message-ID: <a4ee3610-5a5a-494c-b994-28447535f25c@redhat.com>
Date: Mon, 10 Nov 2025 08:11:28 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/33] arm_mpam: Reset MSC controls from cpuhp callbacks
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
 tan.shaopeng@fujitsu.com, will@kernel.org, xhao@linux.alibaba.com,
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-19-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-19-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> When a CPU comes online, it may bring a newly accessible MSC with
> it. Only the default partid has its value reset by hardware, and
> even then the MSC might not have been reset since its config was
> previously dirtied. e.g. Kexec.
> 
> Any in-use partid must have its configuration restored, or reset.
> In-use partids may be held in caches and evicted later.
> 
> MSC are also reset when CPUs are taken offline to cover cases where
> firmware doesn't reset the MSC over reboot using UEFI, or kexec
> where there is no firmware involvement.
> 
> If the configuration for a RIS has not been touched since it was
> brought online, it does not need resetting again.
> 
> To reset, write the maximum values for all discovered controls.
> 
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Add tags - thanks!
> ---
>   drivers/resctrl/mpam_devices.c  | 109 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |   3 +
>   2 files changed, 112 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>




