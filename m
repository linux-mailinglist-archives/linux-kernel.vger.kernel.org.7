Return-Path: <linux-kernel+bounces-808873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12A1FB505B0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 367AD442DA8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 18:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB2230215B;
	Tue,  9 Sep 2025 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhaElix8"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E592C32CF75
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757444295; cv=none; b=AxvSRQpvTroGXNlhg1fwNz9BmC2gewVMSi+ZWc79eXGvzPoVlYq3qJqXSYaI7O8eNBfkOb2GeRkp6vhyXjQsqlS+W9egV+WwvMgBOdWtO0ckkKBezqaJwD3hPbbjx6ilVntCYcc0Cz9q7eygkzn4Swh4dKcr7uLosNcH1Txfeu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757444295; c=relaxed/simple;
	bh=yAU1xs4OMymWHOKYKdpxggNYhkm00IDst2AdLJtu3nI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOm3yJUCp1Pw4xNoTocm8LfL4CQlFZE0YRBLOJXW9EBfLpe5cLZzlQAK3M8m4vDkKQItEEZlrkohJXxVODuHsVSoWRjXMTc6sfhSMZ3ycA/WdxgMWbQoFqh/miHgqZhk/8x84hrHHK1OgCU1TNHxPNRbJBwNBY+rx6qAIrOIgTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhaElix8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757444292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tEeTKl2Am8ceYqmZeJXkbvM2lrOEYBAJICAMqquNxT8=;
	b=KhaElix8GRkh2YfSzfMpvGuw1RdR1u/Vhu3OEhjxJ6GdzFRNtvphkBf2MEnfRd6aH+2yx4
	MY9ZskqJbCBmU2wsy967gfcoSF2jH8aOXQWQ1m1kdK//iczgfg0owdMV1EFEaoZLBiPO2s
	v59bPJgqtSON5Mi7RBXvJ0RSjLKHu8s=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-gyp12XfBNZCqPHJmHk9i6g-1; Tue, 09 Sep 2025 14:58:11 -0400
X-MC-Unique: gyp12XfBNZCqPHJmHk9i6g-1
X-Mimecast-MFC-AGG-ID: gyp12XfBNZCqPHJmHk9i6g_1757444291
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-7224cb09e84so129003226d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 11:58:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757444291; x=1758049091;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEeTKl2Am8ceYqmZeJXkbvM2lrOEYBAJICAMqquNxT8=;
        b=shywAOEWhsMYyNXMgi3N5I3i3axsq9FDIaaqfXd6iGj4pUbqsf/zJ/TL0rYw8IiMws
         Rb49pV2PQWqJ/rj6VFxHcNPNN68cL5BXYTe5+0sIb866MAn3uS4HGBFjRXvn1bk2LUzl
         Zw73p7AK2aaQiLjGaMm4P9JvPIJECFdQ77ZYq5H0DVjM2GQkWI2fwMzsao3O5sUDZuTN
         v3aFhphu/1528DBGGffhO8TJG8P5QD245ujU3hvmcQmugJS4HG3BiI2Uche+mzdHmJrs
         Yg+jDYfrOQ4gjQakjgkB/TigcpY/2jNlf+r436iq6x2p0RyBM1Csgiyxr2ntpUTV4fZl
         OUUw==
X-Forwarded-Encrypted: i=1; AJvYcCV0CTEGUclawrwLIfyZ/zPmb7Y+FA/QBxNHZQHrfSiACdeE2r/ySRt13F7M84YQVLAiL1Y+Kpxz9QTh2b0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4k8+nlOIAnZKOcmSwuCfgx/ClrSNVS3Uizdy2L43EixEAFQw4
	BNR6rV1CRoOpfeeRy6Q6G4NHn1eMiiVEESFGzRMM78hqkYvcZovIQY612rv/cUrMJrk0NMk8WOj
	4h4YSXjL0wVO7D5DEcN52BqBM+0d+BbdjJyYo5xCkbPpnUruRx2G9T878Tl9rBoIRH/qiF6Qfks
	FZ
X-Gm-Gg: ASbGnctGiwQnPnZsy+9QOITLPXJWnst6LI/Mdt7Pb3vOsakwc7t/l2g9S6Z0e1R2CRW
	W6zGwey3CAYYSlWmtqk30T6l0wSt3rZdUOrd4tRysgZvZFNmb3DI9O2Hx6rK2+b1IYA7d0FUZ7s
	HbvZWhJgzxPAJvv241A9uiYHH5mmE7W73ODNs8HARPmL87NVRNkK+bVrZQKxvbolVS+OvGrnTeW
	b90onbStQhRTL4HPynQXmYJf5J4XOjHaiATX75BCtniE7E+jKJtLmJKbFvUmnT9ERHKvrZwBkvo
	2C+CYPZFP9WFZdPWGuYuvZ9Bw65SPtCxk9+f4kQ5toMWvc+kU9/0BGDiagMgV+nJP8Jl46JuDKU
	/xQdcWV2Upuez
X-Received: by 2002:ad4:5fc5:0:b0:707:6cf8:5963 with SMTP id 6a1803df08f44-72bbf3fb0b1mr167451196d6.9.1757444290728;
        Tue, 09 Sep 2025 11:58:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhF+OsEgNK7/8p/dRDiQRMr/orPC3+MXuUsFgulrWFnDz5gzikw27aQ/Tlem1vSIuP46h3SA==
X-Received: by 2002:ad4:5fc5:0:b0:707:6cf8:5963 with SMTP id 6a1803df08f44-72bbf3fb0b1mr167450966d6.9.1757444290315;
        Tue, 09 Sep 2025 11:58:10 -0700 (PDT)
Received: from ?IPV6:2600:4040:5308:eb00:a77e:fec5:d269:f23e? ([2600:4040:5308:eb00:a77e:fec5:d269:f23e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ada83b25sm146538706d6.27.2025.09.09.11.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 11:58:09 -0700 (PDT)
Message-ID: <340645fa-5c6b-4b28-bd56-63088d4705da@redhat.com>
Date: Tue, 9 Sep 2025 14:58:09 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] dm-vdo: Refactor VDO_ASSERT usage in
 start_restoring_volume functions
Content-Language: en-US
To: Ivan Abramov <i.abramov@mt-integration.ru>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20250908222410.223574-1-i.abramov@mt-integration.ru>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20250908222410.223574-1-i.abramov@mt-integration.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/25 6:24 PM, Ivan Abramov wrote:
> There's an incorrect VDO_ASSERT macro usage in
> start_restoring volume_index() and start_restoring_volume_sub_index(),
> since assert's return value is not used anywhere.
> 
> Thus, use VDO_ASSERT_LOG_ONLY macro in such cases.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
> ---
>   drivers/md/dm-vdo/indexer/volume-index.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/md/dm-vdo/indexer/volume-index.c b/drivers/md/dm-vdo/indexer/volume-index.c
> index 12f954a0c532..99608f14400a 100644
> --- a/drivers/md/dm-vdo/indexer/volume-index.c
> +++ b/drivers/md/dm-vdo/indexer/volume-index.c
> @@ -832,11 +832,9 @@ static int start_restoring_volume_sub_index(struct volume_sub_index *sub_index,
>   		decode_u32_le(buffer, &offset, &header.first_list);
>   		decode_u32_le(buffer, &offset, &header.list_count);
>   
> -		result = VDO_ASSERT(offset == sizeof(buffer),
> +		VDO_ASSERT_LOG_ONLY(offset == sizeof(buffer),
>   				    "%zu bytes decoded of %zu expected", offset,
>   				    sizeof(buffer));
> -		if (result != VDO_SUCCESS)
> -			result = UDS_CORRUPT_DATA;

This is not a correct fix so we should not take this.

This assertion (and the one below) should only fail if the stored 
metadata has been corrupted, but in that case we definitely need to 
return the error and fail the load.

You are correct that we don't seem to use this result, but the correct 
fix is to return UDS_CORRUPT_DATA when this assertion fails.

Matt


>   		if (memcmp(header.magic, MAGIC_START_5, MAGIC_SIZE) != 0) {
>   			return vdo_log_warning_strerror(UDS_CORRUPT_DATA,
> @@ -924,11 +922,9 @@ static int start_restoring_volume_index(struct volume_index *volume_index,
>   		offset += MAGIC_SIZE;
>   		decode_u32_le(buffer, &offset, &header.sparse_sample_rate);
>   
> -		result = VDO_ASSERT(offset == sizeof(buffer),
> +		VDO_ASSERT_LOG_ONLY(offset == sizeof(buffer),
>   				    "%zu bytes decoded of %zu expected", offset,
>   				    sizeof(buffer));
> -		if (result != VDO_SUCCESS)
> -			result = UDS_CORRUPT_DATA;
>   
>   		if (memcmp(header.magic, MAGIC_START_6, MAGIC_SIZE) != 0)
>   			return vdo_log_warning_strerror(UDS_CORRUPT_DATA,


