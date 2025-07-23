Return-Path: <linux-kernel+bounces-742236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B97B0EEF2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE3ED1C85B87
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 09:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90FD28B7F8;
	Wed, 23 Jul 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqFGwRRs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F94248F69
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264631; cv=none; b=kiYZdVp0SydmizxAXgJWSiI6HQZKWUnru2jBbGDP5Es1dpvcJRXZVXYzsWb/QC97vQZS5+xyzcQBnA11XcuF8yPr5CChbxFk8cGcj+m9Ja/DwW/VsUhRH7rOp/tBpClx2VjrcfiFa/mO72+KSrKE+aa2x0KF/POJLEy+o9zRx0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264631; c=relaxed/simple;
	bh=0wER1sdDpf0YByTkUTnsflZux/fcWM4DuADoOCL19vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=su7L75EJTsACM63UjZTLVaSfhry8nRNDxtw/FGIlRL6ENNdpAS2dPbo5IroqJLh33x0sMIcnojrAF/68gJszAJuvt7FG74gIWCJ5eGNsdJquzub02dEzHSB0KJDa6oSdZ1Pbllv893uJYSfkcyD0+2mFuxHWdEms70JpPbwuy4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqFGwRRs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753264628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mSuQe5TZfFo2TDAjQDLuVsg6M8GZKLj4opJx5Te6VLQ=;
	b=LqFGwRRswXc6uPvnUMS/gkpjFKsdEOcocTR+AbqEP+Z13QkVnGLgeH+80WYfjuXVBupd6K
	NUpI0L/7iFK3S1WfxRp831n8E86EZ53BinYZni/tZIbNuEe4fequx6ck7JoyoaFr8Sx84Y
	XdzjngDLdf/ptA/USS5f9Mbu3EcySvo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-C8jT11yAPXCpjkML8HVDAg-1; Wed, 23 Jul 2025 05:57:06 -0400
X-MC-Unique: C8jT11yAPXCpjkML8HVDAg-1
X-Mimecast-MFC-AGG-ID: C8jT11yAPXCpjkML8HVDAg_1753264626
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4fac7fa27so2387520f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 02:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753264625; x=1753869425;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mSuQe5TZfFo2TDAjQDLuVsg6M8GZKLj4opJx5Te6VLQ=;
        b=fLNbneZx5xBhtp9F9jdwcdQQUXyEs46IVgZFi8XJ+cqSsgH3Rzz8K0V5O72iYXn71L
         jJxN3fdzoupicTjhz97aTqviwD8ST5ex5PGucf90Y3BxhdT+AUZlyWPhL9ZesWy07tsn
         xYFghVPdBZoqs9Qef5gSLeiUXPvWmWLQSktKk3u3JID2Oh3NrK6sRHd6jOgwOnj7Vbxh
         aO0Htma6DXQUXHwLSeEInQ/cx8XdrgGbJuDDFk1UVO8cRsdU1Qe9mpa2T4xuFpyNuMng
         KqIqPXPfuDNeEfj6fltp+5K2IiLXdPX4rn9oBS59zo8DBCW+ig9UJvs0m26ADR/0yj/1
         2+HA==
X-Forwarded-Encrypted: i=1; AJvYcCVk+P+q18AurSAtfXdjsLlay6b+mD3+ljWOZJ0TbWUe8f0ekKQ/4KggFL9QilgfT1XGP8V8zB+wlycr7zQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJA3d72YDBkYqoRGSoIim4IWvpKtAfNr1UZcLcQ5bJX2V3a/D
	qtiPfxfDrslexGGno7y0/sMx+xcijRunLcFEwhBor/rYKlUTgBA7zPEEgXw5BVj52qZHPh3NeHi
	UOEJkOORZdZMsDov8/8DSAzAmgqsn8jH9b3gCbeMojRxcCUvjBx4+gWYpSqBRaTzeZQ==
X-Gm-Gg: ASbGncuEVS5pAyIzQCA1YApxOO5wYt2NWVZUiZPQanNn8N/4dx+WrkftwIQ5T9tFsW1
	cmcMINCVSSfn1W5b4I/YY2SOFb/qqgI79l9iMJsrTdTQeriAwv2Shqd2iOKZfqqekT0CEbCGRV1
	REU02pGBRy5aDstNrkCLVyYvgGDoAN4CL9sul1MG5uaLeC06PaUz7TW+Zzu0m7BhjEB8w78hMUl
	jUo5NfIornrXZHeGiikXM0koXuOMIxtaDvHyPDfR4zBzmJFE8Z1NWtVroOwt1IL6oWdzV8uyKhI
	7tZhbbrJw6JpgB1srElcRvm1G2aec3zjTmRPxbU6GfjUoGHViT5PnJrDRe2zgUb0iDKqJFQoiGn
	Hg46VDN3PTUWpJYdu6srb9t5FlDh/fThsgDFvJjiLKm5TI9VQYYFWE6YjQfeAtx3OxdA=
X-Received: by 2002:a05:6000:2506:b0:3b4:9dfa:b7 with SMTP id ffacd0b85a97d-3b768ec1e6fmr2044933f8f.25.1753264625586;
        Wed, 23 Jul 2025 02:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl73Vv5SZsEFpgMGgi837EdpzryiyNAai0v+xTUvEkF0zaqjrdbQ6xETFDhH2xtsYCmD/VEA==
X-Received: by 2002:a05:6000:2506:b0:3b4:9dfa:b7 with SMTP id ffacd0b85a97d-3b768ec1e6fmr2044895f8f.25.1753264625096;
        Wed, 23 Jul 2025 02:57:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f00:4000:a438:1541:1da1:723a? (p200300d82f004000a43815411da1723a.dip0.t-ipconnect.de. [2003:d8:2f00:4000:a438:1541:1da1:723a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458691aafadsm18545845e9.24.2025.07.23.02.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 02:57:04 -0700 (PDT)
Message-ID: <1524727f-aa6d-4286-8ef4-bcd224c50c62@redhat.com>
Date: Wed, 23 Jul 2025 11:57:03 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] tools/testing/selftests: Fix spelling mistake
 "unnmap" -> "unmap"
To: Colin Ian King <colin.i.king@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723095027.3999094-1-colin.i.king@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250723095027.3999094-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.07.25 11:50, Colin Ian King wrote:
> There is a spelling mistake in ksft_test_result_fail messages. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


