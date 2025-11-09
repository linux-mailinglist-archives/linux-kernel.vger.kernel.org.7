Return-Path: <linux-kernel+bounces-892198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C470DC4499B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 797423B0527
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 23:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C960226CE35;
	Sun,  9 Nov 2025 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBev6YoZ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="X8rsmsWp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814D221540
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 23:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762729293; cv=none; b=Y0MBoipAA2c1xnZinCUxWpwJmxFE8d78CGo+IJQhBI0oqQLYMjmSLjgR7jmqGLOP1yun9HURdavu23iRsDPdxQTO6jMgjj6c3xnR03IZKJTxIlYKMuMQuvrUmK+plY01/QuVkj3V5ORvNoJThQP4seVITuR2aETQjGsW3IBzv/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762729293; c=relaxed/simple;
	bh=1rNdMAgjQE4PmtU3Wz+uxvWLaXBXHlQhc67jVqw1EGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eEzCTeEZrG0tHlPL0xUCAfOCPGNbkmm8TrxAZd+WD0FkONpeDgkOHZJkj0boP0eERIPjWpqqkUwnlGWUuoNhUzyCQZn1ScDMv/n1Zjc5Ex88DNjYhO4qvnS9jj9T5WHkbY0n2QYKJU0dwmwT1dI8Pwe3gDdXut1gLPDEmR32I38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBev6YoZ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=X8rsmsWp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762729290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZNXq3wDHifJe4Q3Rx2GNFT4RtaD6McNY3lm8qZQBNJU=;
	b=SBev6YoZBTrTRcJa7DCch0sAHiqVl+QJO2yugEbJAvnGbXSV3ju0qQ03I2jM841L8CI9aS
	N7HFYDHQ153qfDKXLSwcFLpYoa8eWk17uHdmqmvuNxZpwOpUkLU4mlv4K4yrjOF8sPIHYs
	aQZqBnFrfJgU5RAJaoMLZV6G9d62Uu4=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-w6OAxC2DPzGCzabJmMDnUQ-1; Sun, 09 Nov 2025 18:01:28 -0500
X-MC-Unique: w6OAxC2DPzGCzabJmMDnUQ-1
X-Mimecast-MFC-AGG-ID: w6OAxC2DPzGCzabJmMDnUQ_1762729288
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297dabf9fd0so17758875ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 15:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762729287; x=1763334087; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZNXq3wDHifJe4Q3Rx2GNFT4RtaD6McNY3lm8qZQBNJU=;
        b=X8rsmsWpIujK1qW0g9BhTMkXS5TOfR432xcJl+QHlAxZVsaMs4F46wHmeg00/sm39k
         ZE+T1ufWUGDVJIFZcvt6JZl6g6YXpUQFcUW/i2uhro0JLUTtBeYGmItXAyslJKNOEJYH
         xq3HjNfqSg0qqCR7Ld+Q7Zfvjuip9kEtjjuduznlsD5VBNqRkDX0oB8JkTwPfcgC+Lo6
         UagZgT78/Xs7x/dZ+DjK4PbUNixajoV6AjrPfqrkmYSBBsB3nRIiLUF5m/3vbxYoYDml
         496qdGL+2aymCfljhox46uPvRm2BDLgXMz56xtaDrPMILW/MOwlKA6FjXMfc2DB0vr7P
         fi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762729287; x=1763334087;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZNXq3wDHifJe4Q3Rx2GNFT4RtaD6McNY3lm8qZQBNJU=;
        b=v3eYUNI5pOxB1FgJa00IJlM8eXXoApXYJsP0QTT+zVh/Jdh9kS9hJtUnRgBqpBsa5C
         Lck+1zk27FfaMsNilE7YVrXyUP8SLT3lx5evRAfSUY83gu6Bn5hCLSn8yLVOdw2I/Umk
         j0apzb0lM6IqETs7FT/jOP1Cpd6uMocyazDcGUHep2DyCFxnXTq7uXRqs7FQD2xWD6Kj
         NwQ74BFmAYPP/GnYjZx33KDXShX6NZAcyPM6DvXTWPX4/eMFrp6htZk8G7l39KQk/fka
         raQv1iv0vmMAKTfXnv6hpENmT8L6gj6/AXxow5uBhz+5BYyNRl41vyC9afuJ2ELHE+dh
         9tnA==
X-Forwarded-Encrypted: i=1; AJvYcCXsr3RgnU4kIbk5GK9DB59eRD8rdp9hbNC9x5r7FDoEF7rHnAwy+Nr8tjvHTskrAwLcOkoZARJ6D3Qssic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7A+50qX6jPXQJTagYJR4sWU7npAjYjZdamxwJrQaIA142n/Np
	4Lfzo9fhQE1THPP55pAva/ixsjTViVwk5sd0FTK/Ag/inqG2bYzKk0+WyI6lGfGHQyfMKhfNxIw
	EKl1Bju1QV1Klq/e7SKDGgOIfqM4ENYGFkAtJ28UvxCiWM7NOeLexZ5ArqakNdN0A5YUDOAtOUg
	==
X-Gm-Gg: ASbGncuyxoTZI61cQZ3L+9gvA1qJ5NvGwN08omf0WccnU81BsDfju7l2wgmxCNllYSo
	XC0KmPSMfDStpx18J8XnOT3LGsadnqPe7ZOYcLZb4yfUcs5JJRcJbnyr+kqIzCVErcT3BngfiGQ
	WzkFCv/nWdtuL9KbuuDXPRaiQ2eTq28yygrwmDUmokpvgn9oQiUIFCYrIDOzRRV6UmuzjKcN0D0
	cKJQZCBwsIoAkwXf1FiQnGsP2ys3aWMYC0Dj6N3jgNLrUAaizYXeaX4xDz7IjEqx8YF4QY8LnqW
	UXEzIs/FPmblXcfqzv6sN4P+xrN8d54AEJTFr3fiwPsHNTRdSat/bX/t8AUypHXadm1sGW1kqcq
	ynGgu7FNZZGcUmbbTKVCYSKnyvZkhxkyw97Ip3ew=
X-Received: by 2002:a17:902:d485:b0:295:28a4:f0b7 with SMTP id d9443c01a7336-297e571abdcmr84706345ad.60.1762729286661;
        Sun, 09 Nov 2025 15:01:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH20FeHF0gFMlacoNiycg6+34EAdYTYpIb2C+WuBML627rkfNSdBeqyaZRt/itc5uhGL0htSQ==
X-Received: by 2002:a17:902:d485:b0:295:28a4:f0b7 with SMTP id d9443c01a7336-297e571abdcmr84706025ad.60.1762729286232;
        Sun, 09 Nov 2025 15:01:26 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c740b5sm125699615ad.70.2025.11.09.15.01.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:01:25 -0800 (PST)
Message-ID: <9c744ab8-d555-4202-905f-015a13c377da@redhat.com>
Date: Mon, 10 Nov 2025 09:01:12 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/33] arm_mpam: Probe and reset the rest of the features
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
 Zeng Heng <zengheng4@huawei.com>, Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-25-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-25-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> MPAM supports more features than are going to be exposed to resctrl.
> For partid other than 0, the reset values of these controls isn't
> known.
> 
> Discover the rest of the features so they can be reset to avoid any
> side effects when resctrl is in use.
> 
> PARTID narrowing allows MSC/RIS to support less configuration space than
> is usable. If this feature is found on a class of device we are likely
> to use, then reduce the partid_max to make it usable. This allows us
> to map a PARTID to itself.
> 
> CC: Rohit Mathew <Rohit.Mathew@arm.com>
> CC: Zeng Heng <zengheng4@huawei.com>
> CC: Dave Martin <Dave.Martin@arm.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Fenghua Yu <fenghuay@nvidia.com>
> Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> enum order and commas
> ---
>   drivers/resctrl/mpam_devices.c  | 188 ++++++++++++++++++++++++++++++++
>   drivers/resctrl/mpam_internal.h |  18 +++
>   2 files changed, 206 insertions(+)
> 
Reviewed-by: Gavin Shan <gshan@redhat.com>


