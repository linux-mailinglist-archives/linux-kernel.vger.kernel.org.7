Return-Path: <linux-kernel+bounces-808910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 551D9B50661
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 21:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF53154306A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171BC350D79;
	Tue,  9 Sep 2025 19:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afKHlGNk"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8346213A265
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757445792; cv=none; b=Y6/2QheH5sdNJxdTXBioxDkPRxbjDhBO6i1BRsiyxiwM0ZI/cT42kbDcpdZyIlu0z/o/gk1ptGsbADcK8pb4a/0wbjoFgDL8PbpMv2Ke7BOchBcRMDjuTsO8rjNSx/1oatZtRGr908H+dAVtCD7f/rozL8i6CKnGdE85uKs9PdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757445792; c=relaxed/simple;
	bh=Dr41Tcqata/raqAboRNakNManKKV7R8cd3/aEJ1vBTY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JLiocYsc+bx/OWWPJdGfqVYEzuFQDU8aCzBls5aXRyWEdL/+hdVXZKYLbvsM+lOCcmlpxbKuBKogWXtXzAwyu/yeooXm04G8LNCmnQIAZ3Kq2Ti4teD2To1fnoGSWTbijj4iXF8/E3rvYw6Jj01GZ8RXK8o20tCbPmlWXqu8e8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afKHlGNk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757445789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KaahEf6JZRZ6NZ6hGjJioziPQJonllTKnhQkCCQ9Zy0=;
	b=afKHlGNk4Pnxa3W4skjN5v4/8YOjgS/LpUQ8gk0qjqSRqtutlBCq87RbsLDIr4YtLYsyws
	LinqYF5cs2LJ2B88aFuegGUfgrzHvDn0rKYfqH1GHccqkP6iGgdk0lAw7wiDBmX42hDwVg
	Ynyc0ZRGyw5nzRsJnJfC+wTFhfESEd8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-KOuc1lywNKKnsOHgt2OD7A-1; Tue, 09 Sep 2025 15:23:08 -0400
X-MC-Unique: KOuc1lywNKKnsOHgt2OD7A-1
X-Mimecast-MFC-AGG-ID: KOuc1lywNKKnsOHgt2OD7A_1757445787
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-816ae20ff2dso687493285a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 12:23:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757445787; x=1758050587;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KaahEf6JZRZ6NZ6hGjJioziPQJonllTKnhQkCCQ9Zy0=;
        b=UPDT4E5LCYldxcb++RtoL5oQN2wnhZF5nzzE41TceO8aIoyddb9+QHdY0lsVbALuZx
         SSCH6p2Mtt5D151nEjbtQiFwIa/G8N0LEfvCXkqAJiBJ4JaC+y7FxcIyrAzcaqwkg8us
         jBanJbraMJdNFrj8rJkWZqBIpOKCpILjk+rLi+/uT/KbNTy54kjCVH89rKI2/22FjNOY
         l/BJCavpel0uTJN4EROrqctbXQe+qU128DXoz+zoifL8UbEM2ovVWt0CXRZAArIObEF1
         RAIv2I7jFVrDSECxH7pBtY9v7Sh6P8yDI4qsAkOJElny0WaBwJx7tE/tEYpJGdtxKyBx
         tQ4A==
X-Forwarded-Encrypted: i=1; AJvYcCURZj0+D53Y0KngodhLr77ISv0qb1XkP26XFpNANstZ+Un/0ZyskZ4vCgO+nlkDXPlrEGkFqZk4Act++Aw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcCQ+5kPuiXhddHXcxKclKxFNfQlWkWhF3dzsG8XxqCR/lqofy
	ZzoJTvQGxW1J4LQrROKy7Nj2/IYIjwBclnfopX1P50j99hfUUesq9e5bHFYeaT5J13/Sw4ADCNs
	LpZc+ZWvI60eEAeHauj5juCcfTFu2DvxPZrF1SsbpmNt1HE81UF50w+alwlpAW1ly8A==
X-Gm-Gg: ASbGncvZCpFPGIFq6o/z0Zo2mEKmpiNDca428mqPIwjZcojSG/R24ZCfGJHhVf9AfWD
	A54TKqI/JcSNdpkppd0U/FMzRgrP0gc8IS92MaZlmjrkOWVbBFX0q/CouqRWnNRJcxMYs1NqrOD
	lKf4g0Uq37Ro2NOvPgNbWbv7a/Oyov2/fMG/7KFHw1KvxZ4b7I7DVlisBXUB94msZ4uBFkPEOf2
	Ydl7uiIfbfjUj7939aFLHcmnPnIb//vlFeafLdnHMS6TIAajRZkxfKWXKjpiFi+62TOQkdBBAXC
	OlrYDNYnitBFmisLa0xuAqXvRHaaO+iGKVZjD15dLs8GUgleSENe8y/tUZS+382OOzPcyFCKTWS
	kjitDrsHY4eOy
X-Received: by 2002:a05:620a:28c4:b0:7f9:1f6b:67fa with SMTP id af79cd13be357-813be440672mr1186303585a.11.1757445787483;
        Tue, 09 Sep 2025 12:23:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLY5kexLTwmeWexP1KElG9GzegYJmUBuptStZfbFZ+i//+RQxgQVoBsSR7G6dKU9Eld5w6MQ==
X-Received: by 2002:a05:620a:28c4:b0:7f9:1f6b:67fa with SMTP id af79cd13be357-813be440672mr1186300685a.11.1757445786985;
        Tue, 09 Sep 2025 12:23:06 -0700 (PDT)
Received: from ?IPV6:2600:4040:5308:eb00:a77e:fec5:d269:f23e? ([2600:4040:5308:eb00:a77e:fec5:d269:f23e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81d97fdcc6fsm14133085a.42.2025.09.09.12.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 12:23:06 -0700 (PDT)
Message-ID: <1788ec12-c362-440a-b63e-fc720bd5a18d@redhat.com>
Date: Tue, 9 Sep 2025 15:23:06 -0400
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
From: Matthew Sakai <msakai@redhat.com>
To: Ivan Abramov <i.abramov@mt-integration.ru>
Cc: dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20250908222410.223574-1-i.abramov@mt-integration.ru>
 <340645fa-5c6b-4b28-bd56-63088d4705da@redhat.com>
In-Reply-To: <340645fa-5c6b-4b28-bd56-63088d4705da@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 9/9/25 2:58 PM, Matthew Sakai wrote:
> On 9/8/25 6:24 PM, Ivan Abramov wrote:
>> There's an incorrect VDO_ASSERT macro usage in
>> start_restoring volume_index() and start_restoring_volume_sub_index(),
>> since assert's return value is not used anywhere.
>>
>> Thus, use VDO_ASSERT_LOG_ONLY macro in such cases.
>>
>> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>>
>> Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>
>> ---
>>   drivers/md/dm-vdo/indexer/volume-index.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/md/dm-vdo/indexer/volume-index.c b/drivers/md/dm- 
>> vdo/indexer/volume-index.c
>> index 12f954a0c532..99608f14400a 100644
>> --- a/drivers/md/dm-vdo/indexer/volume-index.c
>> +++ b/drivers/md/dm-vdo/indexer/volume-index.c
>> @@ -832,11 +832,9 @@ static int 
>> start_restoring_volume_sub_index(struct volume_sub_index *sub_index,
>>           decode_u32_le(buffer, &offset, &header.first_list);
>>           decode_u32_le(buffer, &offset, &header.list_count);
>> -        result = VDO_ASSERT(offset == sizeof(buffer),
>> +        VDO_ASSERT_LOG_ONLY(offset == sizeof(buffer),
>>                       "%zu bytes decoded of %zu expected", offset,
>>                       sizeof(buffer));
>> -        if (result != VDO_SUCCESS)
>> -            result = UDS_CORRUPT_DATA;
> 
> This is not a correct fix so we should not take this.
> 
> This assertion (and the one below) should only fail if the stored 
> metadata has been corrupted, but in that case we definitely need to 
> return the error and fail the load.
> 
> You are correct that we don't seem to use this result, but the correct 
> fix is to return UDS_CORRUPT_DATA when this assertion fails.

Replying to myself, feel free to correct this patch, or I can probably 
get to posting a proper fix later in the week.

> Matt
> 
> 
>>           if (memcmp(header.magic, MAGIC_START_5, MAGIC_SIZE) != 0) {
>>               return vdo_log_warning_strerror(UDS_CORRUPT_DATA,
>> @@ -924,11 +922,9 @@ static int start_restoring_volume_index(struct 
>> volume_index *volume_index,
>>           offset += MAGIC_SIZE;
>>           decode_u32_le(buffer, &offset, &header.sparse_sample_rate);
>> -        result = VDO_ASSERT(offset == sizeof(buffer),
>> +        VDO_ASSERT_LOG_ONLY(offset == sizeof(buffer),
>>                       "%zu bytes decoded of %zu expected", offset,
>>                       sizeof(buffer));
>> -        if (result != VDO_SUCCESS)
>> -            result = UDS_CORRUPT_DATA;
>>           if (memcmp(header.magic, MAGIC_START_6, MAGIC_SIZE) != 0)
>>               return vdo_log_warning_strerror(UDS_CORRUPT_DATA,
> 


