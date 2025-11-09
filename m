Return-Path: <linux-kernel+bounces-892204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0589CC449DD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 00:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8CC04E50E7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 23:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5998425DB12;
	Sun,  9 Nov 2025 23:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LbR65z6P";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eS8p5+5Z"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAEE253B42
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 23:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762730173; cv=none; b=q1YxofBoJrpXB5yDZbhcd1ezQ41AuHz3Pmk+EvWz+gL60r9ZEf3w7SucmGuCIvQ6Pafhm5WOXxJ6QpunJ2gOuH5qL+oHR7SFAKTj61GhwRrb4CicvM/id5pzu0SMyVvS7nULgoE083ZFhXSieReVoEmJNjzudMJWQSrXKoAm+Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762730173; c=relaxed/simple;
	bh=LjcUFAc39TJn1U6bwkbkQQ6rbkMkbQsQNrXVyvLDfAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ejL+S9ERriPG+SDv7OEEa2qyvCaRzKXwGAHW8LueQ9ihDWP0k7WAQ9RqApSal3rM0Tpdo0+2mmPzBRQbGPdSrMTzlSK3B08uPaML3v5AXG2PKIu8Ud3Wf/ldNK7tEw7CElRcRu6Uvm/TwK41qqLS41jbzT+qI4JzVg/V/0MFVvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LbR65z6P; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eS8p5+5Z; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762730170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDUv6je7Ohicz+smtRuBl6ZpYqiHtX0g/yyL+aPKMxc=;
	b=LbR65z6PKSl6IcCCe3OhDR8ROx9oiqKVw+GU/KIvWgCBclzUE13Xy6PE1tyYL4fc0YvR7w
	bqatD2ZgbHuTPqgeoZ8SZ51aOOI6ZVhvahruEuySVCXWl4FCihFH3uBAYPNkVAx9EQH31o
	F2GLFIregmd3oHZgyb8p+++W8eWcfHo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-265-LvsjwcEQN7WyTfqr_QLTdg-1; Sun, 09 Nov 2025 18:16:08 -0500
X-MC-Unique: LvsjwcEQN7WyTfqr_QLTdg-1
X-Mimecast-MFC-AGG-ID: LvsjwcEQN7WyTfqr_QLTdg_1762730168
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso5401955a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 15:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762730167; x=1763334967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDUv6je7Ohicz+smtRuBl6ZpYqiHtX0g/yyL+aPKMxc=;
        b=eS8p5+5Zpf/M/coI4xF2t4Vg85o+NkJYH7NNjW6jaz6MTERjGAq3f1tJPtjgGdeApj
         WnG8ORW9UPfw7EM+sThaUnPTWmWSfBsOAXSGGwnGOC4coeuMyUKCh3CpTRz7t6/Bhvf1
         C+3x1J8rNFxigFAoCiUg6JmYoRvaLXfUoir3clH1w+RE8YB39xj5mhqH5swe7PZ4Do45
         5xluZm5TiCso3pZNNnhMLh9K/vQH2AXesPTkSmJ7YDKBmLwp/Xur9PjWnJTsEYQSlvSn
         0R2YMglmLtJGHuIOExJsezh4GRXSDEXQTDBGxlQUC6lf4Z8E4FCUh5GawohgtjkQKesi
         tQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762730167; x=1763334967;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MDUv6je7Ohicz+smtRuBl6ZpYqiHtX0g/yyL+aPKMxc=;
        b=mODUZ401Pzxj3B3iTQSZrr7ttC9eeD7NOvrU2uaYVfhckZxji2K5z5Uh6+9vnpTXWE
         +1LXG7j4508KxxA5i564SvsDS9c6J58QRiEq8wABkJ4C0hNdsmO8Nb/bnsBbUjFpdg2P
         9dokxT6oIEO0od5cUnEpIilVWPr3W4WjyXUHZu3kr0zT97Fp9bphk2Nn6zHD5j/pMRTO
         NpfwHK3nXPJxXZokte/NGUg+6s6qvtZSDTyYPQxnrGx76pDE3lfbwN5XX3EwQ1AiHLAW
         HwwJGOQe5kwkRTEoK1sk7ddImPmj6z8rlyZHFnoMGZlqHX3XEuvNT1Z/dS8YbNz/5x9l
         He0w==
X-Forwarded-Encrypted: i=1; AJvYcCVZq81nWqhq4dih7aDQPFFcAZbMBPF858tRD9jf0DmjKcO91UT9+H/9c26wfNAFTtxf6nUIP47XIYIOrJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDKjv4T06NsoK38U2GYt1HS/LZJs6PrF72TpuNaU4CCTn5uVLf
	Dj179sIoomUXwqPgR5666ASf85Q8sjK6+2QOTYC+2iYakRvkr54nFgKcQtFaJSM8SMJnAhRnVpN
	wwlgPAf11/vR5B13F2YBqfERnGah8HkWilbnf9u31EmCbt+FKVH24RdpRAZ2n5VPk/A==
X-Gm-Gg: ASbGncsS57D0nZwT/N+490Ga22ITLECryA0sBS8POES3VgalBdBwGcNc7Y4mgHxbNgk
	4R7W1Xhf8pOlWt3EjKSUuAIN9p4kjh1rzfJFdgDb0MpPMQQCn3elImRX3nbxSiPXCJJGUteGF9Y
	XaIAUGbzvzrMglowoIsGNuC+VyMyTaCnsUYJKo/uBY5q0qzYiMWixaH2ltJRs7WSh4bimrR1AGR
	pMSKWf9ALU3MIO4V/fZ2157iDJtrbfyAQGQXqAulz1C1MdbBQX7/VanJqfwhXGWogh+ndeC0U0r
	RzdzzEA7bzNCc1LQq4Ik9avpdSMcwT80xVvVnkKf9UwoLGPWeH4VbsPKmIx2S5IQGQb5H6zlAYz
	0sOWgJRE34uCuaKolt2HLcqufTITJb5MxsL4M81Y=
X-Received: by 2002:a17:902:c952:b0:295:21ac:352b with SMTP id d9443c01a7336-297e560ec1cmr78399355ad.15.1762730167678;
        Sun, 09 Nov 2025 15:16:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGKFONVz/PdrHijdKUAMC7ZFvcfTvFflkxdMQ1OwyAkmY8Q3jbTVUYQNkRAQk/zZ/9eJe8Fg==
X-Received: by 2002:a17:902:c952:b0:295:21ac:352b with SMTP id d9443c01a7336-297e560ec1cmr78399125ad.15.1762730167302;
        Sun, 09 Nov 2025 15:16:07 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ccec04sm123053925ad.102.2025.11.09.15.15.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 15:16:06 -0800 (PST)
Message-ID: <6f36dcda-ec5c-46f2-9e22-7e4334cc554b@redhat.com>
Date: Mon, 10 Nov 2025 09:15:53 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 27/33] arm_mpam: Track bandwidth counter state for power
 management
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
 Zeng Heng <zengheng4@huawei.com>
References: <20251107123450.664001-1-ben.horgan@arm.com>
 <20251107123450.664001-28-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-28-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> Bandwidth counters need to run continuously to correctly reflect the
> bandwidth.
> 
> Save the counter state when the hardware is reset due to CPU hotplug.
> Add struct mbwu_state to track the bandwidth counter. Support for
> tracking overflow with the same structure will be added in a
> subsequent commit.
> 
> Cc: Zeng Heng <zengheng4@huawei.com>
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Drop tags
> Fix correction accounting
> Split out overflow checking
> ---
>   drivers/resctrl/mpam_devices.c  | 126 +++++++++++++++++++++++++++++++-
>   drivers/resctrl/mpam_internal.h |  21 +++++-
>   2 files changed, 145 insertions(+), 2 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


