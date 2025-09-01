Return-Path: <linux-kernel+bounces-794051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B663B3DC29
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28F0017C699
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C5623B632;
	Mon,  1 Sep 2025 08:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B2b/odw6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C462E0413
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714824; cv=none; b=ZqYWcwc1E5d+kFvWtjjwhkQ6jlXYTj1GbByYFIFBg9fXkFTQLv0RjX03GmPmgyTppidkXkRo/O0jYzMxq1t4h96osG5RVwB3RlMYnB/AFjli5DhHF1pOshXWr9lVOc3WclGM/39s73gWcBAo2oZlQlYxs3Ezs0HQcszC4191Y44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714824; c=relaxed/simple;
	bh=Q3qvUTnrW9XzQZqy8Oy/yuIeKr7A4yPNjYEzI/Ss6JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sKaNsJUTRqwWqb4ohiTvKesXQ72iLgk8KpiA8+PDjenStQpibWPdBhxyPPyD3xI9Pr094QC7OSPMSWF3VC1AAgxOPujmR8EAov6SN/PoJvc1v8n/MD8dQ3yAsfP43MJ7YLhMsHTIkYdK917qdQ493KTKe4WG3Dq5l2npHKqAy5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B2b/odw6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756714822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rutvY9tMMADig1z9n6TyG35p/uwBG7rZBt/hGHCxQyU=;
	b=B2b/odw6atrRSHBDsQmruQWpHrYbuHrk5kzp2+9WB/DrKgdHtKxDvtrJcAj6ZZaXZTu9Xe
	k3ETJvuVMMQ/Tdwci+qMj6IwojtqtrV0iua41q2+CcFXa2OcMJCPFWAVw292GlafG7plL8
	pyGMHlhvS5gGVsUdIX56k1K8ubd5Nao=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-gx3gmGNFMviSuIYoC7w15A-1; Mon, 01 Sep 2025 04:20:20 -0400
X-MC-Unique: gx3gmGNFMviSuIYoC7w15A-1
X-Mimecast-MFC-AGG-ID: gx3gmGNFMviSuIYoC7w15A_1756714820
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3d17731ab27so1854717f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756714819; x=1757319619;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rutvY9tMMADig1z9n6TyG35p/uwBG7rZBt/hGHCxQyU=;
        b=tP1MalnF+aEFnlYz9G0WsxJaCHiQVov/63Bp0Cdks2Qoq5/xZOwatdHlSVOrQUS6/+
         bmISFYJXbgbefrf4kSPedFFRFyra3pmMBQ7zUiXryl0VXsgLqg6cGPnfUEgfryMEHJxm
         f8o5YRJ/zuQRpfFKAMQQn5S6zGPWT+QXCCB/cn/LAeSSOsuPCWtuP9zpaDRiYPvNN3wc
         6T0XNRDKsFnK4ppRDn2nYgmkw4DMWfMkEPo0r4wDpjvymrkllZG+rQTwb7U2JWp2lmA+
         RKN9nqgPkXiqVszyhUXmuFpLNmJmbvPNfVAInASPcsYh4u+z7N03x8+9bGnaukdto5zg
         JAcg==
X-Forwarded-Encrypted: i=1; AJvYcCXOcCIbmLhkSPTLrjttDJVqqA1g++pPTvxChUoyN+vSDra+Gdkzh3BrqZTNIALfxUjcFqvvYWZo5oBEVnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfeKNUOAP7K6e2ig/OB3Rp26VJ+yPylgYuGhmb1ndDSTY3KkLq
	MZj1KgD0CB1urLxulWJzrvQjoNstKWlTKpUPC6dpeOqsbmeP8/6QVJ0V62AaG2cV1axg8/Un/XS
	IaZYR+Y8+L4mi9PkHZKS6NWWZGt78Q4pxZCCaK0kq/mlJ8wSOBrv7p5kWPCaBMlk79A==
X-Gm-Gg: ASbGncscGXTNr6e7nnpEWh347usZQdKNbTrbppWvC/sI8OidOfXzBsGsp9sK+R1qu8A
	YgRRwk/eYhhew3wpgOMb/9fT1Xo6qa1Tc6z02Qndu9tcB051sM5kqEyc3He7xPZcNcqjDLn5XgL
	5wEqk6UPiCpCusWTRMQzA+siL/Xhu1vABfRFRwzJC+ZofQZoxh6Vg8ZYkYxhsGXf3SsXHHhJdIE
	EhzcLukDzRSaMekfCviwH8hHb60NzCTrIrRXqt0Abxvqg2fHweGMpRya5WW9/RppQ6++pRHUO16
	lTVXs5L5TfOFN2Q+OYD4p7vcfCZvQWghoePb7nBv6vlqGUuGoCehV+MgGoMXPoj6WejJt6gJSzq
	NKE70sp61VIhwKob5OWYDyu/5ofDRhIGrv4S0DgqoRvzJWNsReqaQEVlBqTl3Enm2WUA=
X-Received: by 2002:a05:6000:4022:b0:3d8:1f1b:9c9f with SMTP id ffacd0b85a97d-3d81f1b9fcemr734432f8f.55.1756714819420;
        Mon, 01 Sep 2025 01:20:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdmh5ifuvjCOK9QWl3WkvBZapyglTpnSx78anU6PThhgybWIAF61QvgVITS8wexYd3afXp8Q==
X-Received: by 2002:a05:6000:4022:b0:3d8:1f1b:9c9f with SMTP id ffacd0b85a97d-3d81f1b9fcemr734398f8f.55.1756714818939;
        Mon, 01 Sep 2025 01:20:18 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d26f22f5bdsm8611397f8f.37.2025.09.01.01.20.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 01:20:18 -0700 (PDT)
Message-ID: <e3ec5583-adf0-44c3-99c9-5a388c43fb7d@redhat.com>
Date: Mon, 1 Sep 2025 10:20:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/12] mm/shmem: add `const` to lots of pointer
 parameters
To: Max Kellermann <max.kellermann@ionos.com>,
 Kiryl Shutsemau <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, axelrasmussen@google.com, yuanchu@google.com,
 willy@infradead.org, hughd@google.com, mhocko@suse.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-2-max.kellermann@ionos.com>
 <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
 <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 10:05, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 9:33 AM Kiryl Shutsemau <kirill@shutemov.name> wrote:
>>
>> On Sun, Aug 31, 2025 at 11:39:07AM +0200, Max Kellermann wrote:
>>> For improved const-correctness.
>>
>> It is not a proper commit message.
> 
> I believe it is proper for something as trivial as this. I think
> adding more text would just be noise, only wasting the time of people
> reading it. But that is a matter of perspective: I expect every
> competent C developer to know the concept of const-correctness.
> 
> Do you believe the commit message of 29cfe7556bfd ("mm: constify more
> page/folio tests") is "proper"?
> 

"Constify shmem related test functions for improved const-correctness."

-- 
Cheers

David / dhildenb


