Return-Path: <linux-kernel+bounces-781602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CCBCAB31480
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523D2B02796
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6422FCBFA;
	Fri, 22 Aug 2025 09:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XhrGpEXP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D88F2F8BC6
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856099; cv=none; b=Vu8vZPv9tNTnMxsP6nArF7n47IEOxw+PN2ZK/q5tMtCN/w7EzwQZY0nCilpZLvluHQGJ403TBpCw4Ij19TmuwIBZGqAvpgP4z36Uwddz0bGONJLjryqIzJbSzYFXvmHiDN4Ob6Z0SOHEJawhzkZmicQCpt3JCKo+5e3R2ORXofI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856099; c=relaxed/simple;
	bh=hqAjL9NJDtp0oL1TAsAbqDBrTVq5ctcZYvqsnatfYZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AH8BDcSyoIIn7SUjMSZi3eFWlZzBVQfuM++neoawXCwsNHab/jGYWCRIcPcCKzIUurlk4jdjRTm0IhcXy793b/+ltbwPGBnL39UtsP+lERPAZa15Apa8VK580RJuHERXaY1mQlBSH81P6xVhKMynHiZMgqMBmSrKkua9TGfyIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XhrGpEXP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755856094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=faN63CP6wzr0s80Apq5XGXLJE/MDjDQFzV5+gvCjSzQ=;
	b=XhrGpEXPI2auILMPsAx+xH55srpTFGl3WszlkEiqLsUw/jdg1ucTYW8Q5a8i9K90a7uPUa
	O0dUBYERLm4DS5gAtWxs5n3rMCcd602xC5E4lIMynJWWY8sCPKv/zzE5rnckBO5Hs31i2p
	Y/T1BSdKivcQ04Kx5XytHDlhJAYE04s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-1YoJe36uPZ6l_UQ_EA99aQ-1; Fri, 22 Aug 2025 05:48:13 -0400
X-MC-Unique: 1YoJe36uPZ6l_UQ_EA99aQ-1
X-Mimecast-MFC-AGG-ID: 1YoJe36uPZ6l_UQ_EA99aQ_1755856092
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0511b3so11458145e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 02:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755856092; x=1756460892;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=faN63CP6wzr0s80Apq5XGXLJE/MDjDQFzV5+gvCjSzQ=;
        b=vUo2MGs1ol1/WJLVj8oIsmX2Jpu2KOtIY7HsQjXYRCTkc8+21QE9AGmphBIUdol5dA
         C9OiDZ9HOxAlcAWL7nprc7FRZFXgRKMWBswl7B3O5IIy3JeNsFSmNMDQuf2A/rtCU/ph
         fmQM6rdnW9HOtYnaEr+gsTG/l4GeVoT+CJJYRL/X12m+Q4ZtWXiRnZTkTHSLQO3hMJV3
         V2XJBS27KBxx/wPL3srIzA5zMtkayR5YgbeB13XakQx8LClPO8dFsOXv4ed0yhRhpBDm
         PWQO8xwKf415YV9pDUTLaxmFZDUbYbhiJJhj0RL4McyJizhrVPV5kQ8IYKZBN1HmR6Ow
         qoKw==
X-Forwarded-Encrypted: i=1; AJvYcCU4jAsY6H1lq1ip5/kiMVbKYt47Mcsye5LY+0s7LT9NEmv4CPcT/k1AOptp/2ckLg3DsglC2EjNl6vNUqk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9FTv3OoGH2tBr29XAUqZkPLxk6Tbl+wNo/R5zsFugRT1W6+ub
	NAC+okuP2ecogPaCFwmyQ+TuQqhh36jPeZAcX0A8QAMoktKXh4PFBAbD/M7F2LE6Hm5frnnR1vx
	xUbv3DDz5IAD8DmdW3SJTXDIu52/SxHsmQBmFU+so6pDuU1W1ubwg/Z7yf2GXeY+C/Q==
X-Gm-Gg: ASbGnctt+G1wch8VWz+u8NWYgS0XsImCcMtix+GXXm6yTlRluiIl2BQ4tPkU4oZa35M
	69Uch3s5B2yuTamsqINVy4k89Hbm5QA6DpFmtemEsszQaSJG8dSYkrEwd4VL+d5Qmnw31Vebyci
	9jBO2bl5sTCcaz53qqfM8xLpTesO+HGbzjRCIMMggazW0vJx/mw1NfYiXIozXP3BEH+V5NbXKvo
	NCTqoGX+oYmyreV9+Sg8J8tJwOF6RoIdzJGO2So+fxRaN9IRmS3DYeYX3CurC3c6sNXNC1Knl7Z
	+jDDH4xgBzlVpEhfwqcpfWRH+G3Bxilr3oRzlxBUVONSfeFJU0M95xTTcBqB8+U8K3a/uordXPG
	SL1gqRlMhlsyuDf7IMEo7cJcxxZHEwYkjQfhUjH/nq8bdUlY1bWj1iXsQK2Hxc8wm7ss=
X-Received: by 2002:a5d:64cf:0:b0:3a4:f663:acb9 with SMTP id ffacd0b85a97d-3c5daa27b91mr1221712f8f.9.1755856092051;
        Fri, 22 Aug 2025 02:48:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsdAE6BVKMKTQokf2HQDERhev26tuT34FaU+oJmXccUoKh510aswQcMHluDCuMsd6oXjJUWw==
X-Received: by 2002:a5d:64cf:0:b0:3a4:f663:acb9 with SMTP id ffacd0b85a97d-3c5daa27b91mr1221683f8f.9.1755856091630;
        Fri, 22 Aug 2025 02:48:11 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f2e:6100:d9da:ae87:764c:a77e? (p200300d82f2e6100d9daae87764ca77e.dip0.t-ipconnect.de. [2003:d8:2f2e:6100:d9da:ae87:764c:a77e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b51b61256sm24247305e9.3.2025.08.22.02.48.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 02:48:11 -0700 (PDT)
Message-ID: <83724cb3-4cd5-4a5c-9a85-c61bf3553195@redhat.com>
Date: Fri, 22 Aug 2025 11:48:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drivers/base/node: Handle error properly in
 register_one_node()
To: Donet Tom <donettom@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Zi Yan <ziy@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Yury Norov <yury.norov@gmail.com>, Dave Jiang <dave.jiang@intel.com>,
 KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <20250822084845.19219-1-donettom@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250822084845.19219-1-donettom@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.08.25 10:48, Donet Tom wrote:
> If register_node() returns an error, it is not handled correctly.
> The function will proceed further and try to register CPUs under the
> node, which is not correct.
> 
> So, in this patch, if register_node() returns an error, we return
> immediately from the function.
> 
> Fixes: 76b67ed9dce6 ("[PATCH] node hotplug: register cpu: remove node struct")
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


