Return-Path: <linux-kernel+bounces-891343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3593C42798
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 06:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AB93A1FF0
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 05:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0846D2D949A;
	Sat,  8 Nov 2025 05:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQQMIrjE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DEnSjoAP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A542D8391
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 05:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762578712; cv=none; b=FEA730NAuyVF/1O5XTRdQx3UMxyRRF6yC3dUdjWHDMHrpUgiOivDqLnK7rKJj+9vomhvqFqSl/8oTL+2NLeqiadBdmQyVo0bVK53v2nxKUHlYJjg+jnQJ8FjNMNBSmh3kTRKyKGHaASiEFpxJ0kEsHPWEDnKUy3w30SqU4w3Rl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762578712; c=relaxed/simple;
	bh=e8PL3/IjwNaM0nfn0Cp/ejL3eQnuWmqm1bSvuemwGXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fr63M3fyiJ0uht7n8rO0g9MzItnKNjeQ/SvjGNGqjBdAmbZmWPrLHYbmAEgG4pYUVMfqOmgeBsOgkrM5G8lP43b4eFBuuc5plfpIgtpRbZDjdZAQ1TkxTxhQysH4Yq7pHS+sSoKtfHjcGjvEA3EyOoH3TbNze9LcxU4vcJqSXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQQMIrjE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DEnSjoAP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762578710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1V/1rTXsgtj3QBQHdAmhw8bkhg1LjYt1yuOVtS3CGk=;
	b=DQQMIrjEpG4iqslNYhO2gGHc9OSWi3E+dx2Nw0Au1OyDTRuoTXigzs9YdAxI2bva69ss11
	h/wmhSSrlbJu3EHJr97VOUDOTsoMvdKNPzqvhF9tFmfjXzkMrHXARWQBwpFFdJ21/8aUb0
	KfTGt2A4VSd7P1IpoA3SUqp71JefqFQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-LAcwGbuXOTWpunb5QYew0g-1; Sat, 08 Nov 2025 00:11:48 -0500
X-MC-Unique: LAcwGbuXOTWpunb5QYew0g-1
X-Mimecast-MFC-AGG-ID: LAcwGbuXOTWpunb5QYew0g_1762578707
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-297d50cd8c4so19850905ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 21:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762578707; x=1763183507; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a1V/1rTXsgtj3QBQHdAmhw8bkhg1LjYt1yuOVtS3CGk=;
        b=DEnSjoAPcgTJNRbD9/+3AEeiTzixX9t8yqC9WlmA6lCxC3pUra8/FwiMxcCcqZLa9m
         pDEJYDsyMmo0j4FqHKxf2z7Mc3aI39t5dkeVC8cTS9BHv07ofNQ+2M+GkhZ/45Gvr0gd
         YgLw0rdoSLXLAeK9EY+JlAZssqmwEATBZEayWLWWcOauE2ESFNJ9PeYefMH5V5vEXs8L
         yU1XYYRW4z7DnuzyrIlCAiixT7PbYqc3Z4sdsiEmGsSAZWpXTRzAfMf+E4yH2Xlnnuqo
         VdsBtOEfYWQb7deMlW1eW3esUzdWYgOJa3L6LeKCHNHXN2PYHdH8avXBaW2WDlkdYUuQ
         C0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762578707; x=1763183507;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a1V/1rTXsgtj3QBQHdAmhw8bkhg1LjYt1yuOVtS3CGk=;
        b=Ax+sMoGh5uMWleaT5+wAVhTrFZNmNjPnVZe2h/m2wY5jdNwNRuXj+p6/kQIH564ehj
         4YoQt1InNhyzErXlCg/d7W821iBBMXkm4nQMmOGiMt6CD0w8nOTij5IPYobnn6x1lcip
         E3vq4cYrX3VkoFgZMkHMHK0aES/gJspJdf0cW8yk5w/vs6QMhtljgCcC+eYmSQjZta7L
         MUJa2KRxnp0vG3n7NgjpxXsbxRjah0ZpY1gkCzx3hYsFlx9PgNvIz1qG0cI/yPpIWSsO
         es+mOu8gHGVof9RZKGRcq0iFBfj/nR+C5K/BBOhhCmOJ7VCzCzvFxMO5ahLGLPWY62jy
         z3HA==
X-Forwarded-Encrypted: i=1; AJvYcCWo3OdBK1JzPz86hBm0m2oEABUhWcXCL5/XTogX0eje4km/Q28yANAn5GTBH4Y9iRJEyAVnmtd5sc8fXpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz77aMEnzwc0lHIg/JXEC5ZWNxyzHDYPzgQM92tOBJFVvIOZEFF
	IzdfWcjKx2c63Ty5v+fLpa3XSjgMS6j8/igI/lnHCuOYn231VdaVyCyrOaWr8bX9VyOC69d68qM
	dzw7JONG1g/bP0+GnRiDLvlFxPaySZimBtoKQaImxd5VPzIifH8yhTzvpfvT9N8vJFA==
X-Gm-Gg: ASbGnctYFu0GUkBRM8Moxj+ddlwOSY5bHWBMAyXcS8bOaDapIkyaruwRG9gRI7RfrLo
	HhtzNSnvjlxGRsq5vGG6MFb2JVmlnpPSL+h+1s2irrf9P2uxEvZO0PY4WwmWV1MHdXeLmeNaauo
	UHRU9Xtjr1RHiWfSW7MCUZbWzZybYs1SzSPuEmdWcpfms+/ElXtx3y06r94SM8lBELIxbOombkH
	CmdEyabnkYLSm7MuZ0fCIj2XSy6uKisSQuDnvnQsLJENkGFQMYi6BqXLeTZDMfSkoIEJq3zAxAs
	uXZzselpGzaGuaSxtC1WxGAzG/SEBf0DmjkCZnXRqgPoblApqMpROTSWI1nF9KRCLWGXm0bs4C2
	r6rxRFgZhGZei/JXVexO2NWtk319j3cfZQEbf6gE=
X-Received: by 2002:a17:903:4b46:b0:295:2d2c:1ba6 with SMTP id d9443c01a7336-297e56d9079mr19923935ad.36.1762578707142;
        Fri, 07 Nov 2025 21:11:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGG5TfB74TNBIs24Dy9Vey8IldOETsxY1qXOyTg5VAa4miIQ2NU9mONOOqeH9RkJkWCKKblRA==
X-Received: by 2002:a17:903:4b46:b0:295:2d2c:1ba6 with SMTP id d9443c01a7336-297e56d9079mr19923395ad.36.1762578706736;
        Fri, 07 Nov 2025 21:11:46 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096825esm78299005ad.3.2025.11.07.21.11.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Nov 2025 21:11:46 -0800 (PST)
Message-ID: <b87ef0cb-5859-4cd1-a0b0-3f0444484ffc@redhat.com>
Date: Sat, 8 Nov 2025 15:11:33 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/33] ACPI / PPTT: Find cache level by cache-id
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
 <20251107123450.664001-5-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-5-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> From: James Morse <james.morse@arm.com>
> 
> The MPAM table identifies caches by id. The MPAM driver also wants to know
> the cache level to determine if the platform is of the shape that can be
> managed via resctrl. Cacheinfo has this information, but only for CPUs that
> are online.
> 
> Waiting for all CPUs to come online is a problem for platforms where
> CPUs are brought online late by user-space.
> 
> Add a helper that walks every possible cache, until it finds the one
> identified by cache-id, then return the level.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
> Changes since v3:
> Tags dropped due to rework
> Fallout/simplification from adding acpi_pptt_cache_v1_full
> Look for each cache type before incrementing level
> ---
>   drivers/acpi/pptt.c  | 63 ++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/acpi.h |  5 ++++
>   2 files changed, 68 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


