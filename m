Return-Path: <linux-kernel+bounces-809018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB3B50792
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 22:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828611888DDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 20:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07798356900;
	Tue,  9 Sep 2025 20:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fXwON4k1"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3A630215F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757451553; cv=none; b=Rjr4epHrunCmDWqvOZWnldS4ywHnaHTK0XW3fVhiRJ9kREJgtAxXTsPOWnE/VdK81p2T7gWDs2vBSCzjTIi2c/AB/CTxUmK6hjBl0pHmhPHEneSr6d6U9OA7vn1GZ32KCmeFFh9ytNEe6Iu2f+uyPQabhgiAgbul4nriFhLAI2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757451553; c=relaxed/simple;
	bh=4o/Ny2gYtEkqlev3bjAo55mlY2GymrgPsnWTj3xFpsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EYiOHlsx769sMrA4vNGggWyQU5dHayTS4qmQ88cglnrCMVrSI1cox8tlHtfsZC87dWvdkE4++ZKXHnYz1FhM4h4VrflOaR7vcMXyfnTknYvqJ1hsjbh9pAAOaCWl3zU/dojyOSKYSO8HukXEltuQ0TE0aKYBxACenPz4u1+bb08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fXwON4k1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757451550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zCVNRf4uxpIBkqC/u+KO0qz0W99ZM1kson5SS883F3I=;
	b=fXwON4k1o8pjgJiR1wtsyqTe3Eaqkl9vZKH1JgIQMep3vKL+CxBMMjsv5lAKWcdc12j/cx
	dNgh9FB5Z2U8GUOsT5o/KpfPLTiIYEdyWumOGL3pbGSQpdEfZgZW+gyupPFtqs41/QWusy
	7WzStHAtvngOZVRPJw0ItM9/1fOf1JQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-1_MUKPOcNymodhSZJZqXPw-1; Tue, 09 Sep 2025 16:59:09 -0400
X-MC-Unique: 1_MUKPOcNymodhSZJZqXPw-1
X-Mimecast-MFC-AGG-ID: 1_MUKPOcNymodhSZJZqXPw_1757451549
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b5fb1f057fso46201641cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 13:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757451549; x=1758056349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zCVNRf4uxpIBkqC/u+KO0qz0W99ZM1kson5SS883F3I=;
        b=V6XvoCz/S38i3vdHFJYxCKXZwI2yqeoOmBF2veCFuKqcML99OiXpNPxYRgOnv8MtPD
         VZdNtP5qu+MFLIJD/8S/f+K/1ZUTcjno9/coLakp7WvW5sE9rkPd3J981P4AHD1dlUar
         nWbFv5cw2kU7NmOa0aOfVfM22XpPstdTuoQI3plImecH3Fnnqjws43NmY6Bqyy5KPXVr
         cbU7pJErqhxT4jMsqD/1FzWLzwRp5hPpOXy1ZSt1s5yZ0wfXOYjYu3kG3O3vgnpzYzn0
         8Jyz/7mT0QuVoRwXaDAEps0maZFWUpbuUTYpCgdDdiSRC1MLTtVvrYCeAb6JiORVt98F
         yGRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV3TrJimA0SA0yZM+orA/UBmCYFqNQV0ZOaIJHyauHVu1BvHyXR+rcMMh75QPi50I9m486dTgKMy9oj3c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJDt8hWhI/6SwG2L2pzFFc5IWp2WDWeckqdb4m/loC5QN7fsJZ
	dQE4Nbo0vaohmPXzJNl499GXIajQEdzOv7B45pT/BLYI4ZOmbehbSNS9pSlm71pxWYOAKGI4MEB
	tpYxSX3em/Bqyu3e7ie57nBoOVPhSRqsJy8EIdGG+lr2+EG0u3inFJBIs2JfQz2WIHg==
X-Gm-Gg: ASbGncvDTJhgWz7v4Zm7eKIymraIVuRl2Y7aiXSLpt9UHNFygupiqLHF3fMYPXf4heO
	2q1Fjs2GYIWCdCQDk20c35di7jPEnlIJCADtRSW9s97TzjpBRpreGQBxGUuemSu9S+lTCYy4iAj
	fYA+h4oSdp+STf7ZXkJ7k+FnuQBDE8aRRvTg4+Mm4wL1XaaPwCqbNsdfj96Ace9wdzBBbyN0wSk
	y/ALsfauXbPOD5WoHaHvy9JULiL9P30PqY8XmdWTjOMXznpdr59rJA7GPH2ug0wIdhxgp+6G1bE
	Vnu99z1AAb43PTFB+aXtWaEyQBlNTowESMeIG8wFT/cqq4T90AlBENKfSA+wnLCuhEivsoVvzUL
	b51RLpXfP3sJV
X-Received: by 2002:ac8:5751:0:b0:4b5:e9e6:81e0 with SMTP id d75a77b69052e-4b5f8398d48mr127179021cf.32.1757451548706;
        Tue, 09 Sep 2025 13:59:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPACoNuxszWjE5a1pmJtASC07htXfqx4RgsHf3EkVuPUYYKnszU5cwn2VxrRnrMUnmj8A+gQ==
X-Received: by 2002:ac8:5751:0:b0:4b5:e9e6:81e0 with SMTP id d75a77b69052e-4b5f8398d48mr127178791cf.32.1757451548234;
        Tue, 09 Sep 2025 13:59:08 -0700 (PDT)
Received: from ?IPV6:2600:4040:5308:eb00:a77e:fec5:d269:f23e? ([2600:4040:5308:eb00:a77e:fec5:d269:f23e])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-72f9ad0acedsm91331836d6.14.2025.09.09.13.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 13:59:07 -0700 (PDT)
Message-ID: <39ac9482-75a7-4124-9caa-5d0550c677fa@redhat.com>
Date: Tue, 9 Sep 2025 16:59:07 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Return error on corrupted metadata in
 start_restoring_volume functions
Content-Language: en-US
To: Ivan Abramov <i.abramov@mt-integration.ru>
Cc: Mike Snitzer <snitzer@kernel.org>,
 "J. corwin Coburn" <corwin@hurlbutnet.net>, dm-devel@lists.linux.dev,
 Thomas Jaskiewicz <tom@jaskiewicz.us>, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20250909202242.355086-1-i.abramov@mt-integration.ru>
From: Matthew Sakai <msakai@redhat.com>
In-Reply-To: <20250909202242.355086-1-i.abramov@mt-integration.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/9/25 4:22 PM, Ivan Abramov wrote:
> The return values of VDO_ASSERT calls that validate metadata are not acted
> upon.
> 
> Return UDS_CORRUPT_DATA in case of an error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a4eb7e255517 ("dm vdo: implement the volume index")
> Signed-off-by: Ivan Abramov <i.abramov@mt-integration.ru>

(cc'ing dm-devel this time)
Reviewed-by: Matthew Sakai <msakai@redhat.com>

> ---
> v2: Change approach as per Matthew Sakai's <msakai@redhat.com> suggestion.
> Change subject and description accordingly. Also add Fixes tag.
> 
>   drivers/md/dm-vdo/indexer/volume-index.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/md/dm-vdo/indexer/volume-index.c b/drivers/md/dm-vdo/indexer/volume-index.c
> index 12f954a0c532..afb062e1f1fb 100644
> --- a/drivers/md/dm-vdo/indexer/volume-index.c
> +++ b/drivers/md/dm-vdo/indexer/volume-index.c
> @@ -836,7 +836,7 @@ static int start_restoring_volume_sub_index(struct volume_sub_index *sub_index,
>   				    "%zu bytes decoded of %zu expected", offset,
>   				    sizeof(buffer));
>   		if (result != VDO_SUCCESS)
> -			result = UDS_CORRUPT_DATA;
> +			return UDS_CORRUPT_DATA;
>   
>   		if (memcmp(header.magic, MAGIC_START_5, MAGIC_SIZE) != 0) {
>   			return vdo_log_warning_strerror(UDS_CORRUPT_DATA,
> @@ -928,7 +928,7 @@ static int start_restoring_volume_index(struct volume_index *volume_index,
>   				    "%zu bytes decoded of %zu expected", offset,
>   				    sizeof(buffer));
>   		if (result != VDO_SUCCESS)
> -			result = UDS_CORRUPT_DATA;
> +			return UDS_CORRUPT_DATA;
>   
>   		if (memcmp(header.magic, MAGIC_START_6, MAGIC_SIZE) != 0)
>   			return vdo_log_warning_strerror(UDS_CORRUPT_DATA,


