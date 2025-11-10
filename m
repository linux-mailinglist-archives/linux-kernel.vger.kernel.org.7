Return-Path: <linux-kernel+bounces-892248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B06C44B46
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE123B074E
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 01:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AA0286A4;
	Mon, 10 Nov 2025 01:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZ0wADb7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lU3DfSVE"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689B41F3B87
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 01:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762736648; cv=none; b=YeQrhTPu0Nx+rn6181xNZ/k8Ddr6oiztYpjYV0DPvAe8JOiFL5yJiPoCY/HIjzLAblFMe3+iQqFicS4nOjFYU+dnByyhWrpoJprRBYAYUAyq/AGhJC4jNqaLZmg9hZYZ5Hm8PYjFKYrdS/IR00DhGa40MLIEFgfbVSd6Thjiitw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762736648; c=relaxed/simple;
	bh=XR/ZHpAPBxjFWVCkYUHWLlXK9i6lghmC6dcE5F6S+nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g4o50R5koFPFaHacqjbrVa+poGMsuS2be1+DmP0Jb0yu17B8aT8sShNwFO9uWBdixNdETZGUIQVO64fhX4hgJ0a2ww1rF6kWGYjnYBdu3xS9aoCJ9spzVjtuVXNxOIdoC5IaarcOnJAiKOwuHKzctFyoKs+X24blgnSZ1veGLbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZ0wADb7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lU3DfSVE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762736646;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=leua78RlXfOm5yDLa55yyb90IYdYDP2Cb4NE7P74U7E=;
	b=BZ0wADb7+yYbVI/TipXIdt3cjv7Y1BDqRtsqbZGfOYMe/kAF4g5/kv7oG0rwAXbHgjveuV
	lS+lV20As+TmKI8/G7wCumtT42Uywa8K8SjyZmsOMieOrjQqQUNziUL7nNJtvQ2Sn1PX/t
	OWreLfOW3Y0yvvJbXZL8yLLgZdilEM4=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-YtdRWrERPvuSL2tnfqEpdA-1; Sun, 09 Nov 2025 20:04:04 -0500
X-MC-Unique: YtdRWrERPvuSL2tnfqEpdA-1
X-Mimecast-MFC-AGG-ID: YtdRWrERPvuSL2tnfqEpdA_1762736644
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b630753cc38so5776429a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 17:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762736643; x=1763341443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=leua78RlXfOm5yDLa55yyb90IYdYDP2Cb4NE7P74U7E=;
        b=lU3DfSVEdYnCvOwLk9+iYDhnL8h17Km9hQTZ62Q8eEIHeKRZsh/7zzx8teUEJhwBBi
         2A383b1SQcFwaIhiP1c7tn5SwKNTccHGQ5Vn5ZTLJ4sug8B45F+UMvdM8xM2wqPnCmEW
         +YFpyWyQvkwOhBLZ3NhTCtjGAThGzJfoznwnA3HmsJvJeUGlZ0cXjMnS2W+YR8+zUWRW
         C+bxV6h+ILjvlaKfYcLBtd27gegn3UZtvKg+R89vmgXgeQimlbor/TwCT+cJXPkMjjqo
         TqrbtTYHhm9jk2lfGt3fanSDVKkVZtsZ9hc3si38nT8v6aIouRQbCGop2uGgS3eXrnJe
         f/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762736643; x=1763341443;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leua78RlXfOm5yDLa55yyb90IYdYDP2Cb4NE7P74U7E=;
        b=f8mt8aFx+2rJYkQ3jh+psTBflNrDWVUqK8verNeWxILqfPJv/Apx2Obkz5B0a63iT1
         LnKQL/iviWslQAgJKmqirO9Vne/hritVcSHO4JPWZhgg6EP+VCMsglJNyKYqw9QK3d3i
         O2sAxkgiECZ5UPr91RdPC8MwwIUBv/UHCemstjamChj9SPiUdHpO84WqUOgdGrd6665b
         wGgc5pdVlc326IEH/fZT+E/bF2FCZazaCu6I+CKtaWAJP6EF3IYfi2sqCs7X5l2zuE2g
         HQTjRLYPMkG4i/svSWOTNGLpokKoBJgS4RbrdkzEI7TSRWllGdVVNuURJRykDsw9YLkA
         ESNw==
X-Forwarded-Encrypted: i=1; AJvYcCXN4ysb66BFCIqCCw5ze4Gmxa/o/HVwfY6X7NBhstGIRbRF0klnafZtKMvHgwrnJ47jW+6doTQmPHOsJEI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8LOmiTm5gi7WOexHfpsaGCPBGP5PGxucDvUlr1SCFI8r/jz+f
	mjDXsC52v3xHFw/7v5cdUVyyMMdgDFJyuSMKevzoxk/nbb8URLYWG7NkQwK6BQ7FEg+pWOxrTZz
	uExOcZ+oHx3zNNF9wuvWFDRLCOAJ/Iejrx7B3swMnwmOYPuGgBz6N0cFdUmi6zlliNQ==
X-Gm-Gg: ASbGncseg9u7c+8xyp86OtUmgCINAdQlwCmu6ugtTbB0QOe73Ego7BT3Sg1oKuYsjm9
	c2u06cHHmdv513LhQKS8EQk2KdFYrmcRgLMKv6KCmK2D4DqeiDkrhfXj0NiaDVsNDj2uiCloC5z
	zuZbIjVEfgiYQo+3I2/jEVF4MQ2JJsgX3IqfzkI5iwMuEbSlj9wg31s+Wa20ThYh50tF4pErWV3
	CES3FsfjqHMrtOpLPTbDXToeYsbpMI6rwMclANZUxaeVmZt8wm+NsMOhdvP9qL5v0noUFTw/5qC
	DdRV2TfN1kGbalKWCCP05kVEhnYaPr/PeSYQMSrxIaEWizDc14gL4sMPCINU1pZNUh8WLwMtKEd
	rQVQw3Urnzf897BgcGi/vWqJ89b4CKxVOUmuYl7U=
X-Received: by 2002:a17:903:2f8e:b0:296:4d61:6cdb with SMTP id d9443c01a7336-297e5655113mr79634245ad.27.1762736643568;
        Sun, 09 Nov 2025 17:04:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEaEQ8lrhTvJ73whBKPu8fioJhN253YclztyjeBunZlQDD4VtJSfb529w7R65ux2cszJp0SoQ==
X-Received: by 2002:a17:903:2f8e:b0:296:4d61:6cdb with SMTP id d9443c01a7336-297e5655113mr79633775ad.27.1762736643128;
        Sun, 09 Nov 2025 17:04:03 -0800 (PST)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au. [175.34.62.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29650c5e3c5sm126117355ad.43.2025.11.09.17.03.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Nov 2025 17:04:02 -0800 (PST)
Message-ID: <7e58eb4a-f8e4-41ea-a2fd-742e632c7deb@redhat.com>
Date: Mon, 10 Nov 2025 11:03:51 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/33] ACPI: Define acpi_put_table cleanup handler and
 acpi_get_table_ret() helper
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
 <20251107123450.664001-9-ben.horgan@arm.com>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20251107123450.664001-9-ben.horgan@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/25 10:34 PM, Ben Horgan wrote:
> Define a cleanup helper for use with __free to release the acpi table when
> the pointer goes out of scope. Also, introduce the helper
> acpi_get_table_ret() to simplify a commonly used pattern involving
> acpi_get_table().
> 
> These are first used in a subsequent commit.
> 
> Signed-off-by: Ben Horgan <ben.horgan@arm.com>
> ---
>   include/linux/acpi.h | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


