Return-Path: <linux-kernel+bounces-727484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 733A1B01AE2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3135814BC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712CF29B8E2;
	Fri, 11 Jul 2025 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmCpVRSY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A05629A9D2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234048; cv=none; b=Xk76YrSFvaG6DH46//12wVE+yFCMbsN17QC1ZJGgpIEwYCvaxMs8CCw5e8/A9dbDpOmJ6uKHWu7J1dG2IxvPWGdB4DdGN9lYtjX/xrR03x8bQA14lCwxqO/Bs7JVaJ3x2YOdlsJVch7698aSKhJiG4tsNoX1c502MyzlZhCy4is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234048; c=relaxed/simple;
	bh=UJexkU3SZxlwXuwlqA9h8WDbdSz0pCUgNBCY8fCr+Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gghPC7q/mvSl2DkbzEHcFMa+ax+jqNMpX2WPZofci85XYtxir4r7O2DiGWoXmFFnfjvGs6s22/2c0QzDTFx9mOvqICYDcnxxbb7jTll2HcV/axm4zs7BaeooXZ1N2hCsWknnRvXMKHmoPK1FI7xZzped8vG/Vv65BA2Wh1vPm8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RmCpVRSY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752234046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=JxNvOa4I1lVwZjisn9NutG86CttWSUJdgFsU+YoJILE=;
	b=RmCpVRSY9g8y1z6AOomjt0s4cXvzjkhIvCnn1/+QoMWc2VLPQQbYFJpKs7ZYHDMYBWTqlh
	NZCxw+Brcsm2cztzJUAdqqReNuGCzMWegLOwhNwOHykW2g2oR5iMoxpyKMniFHk8MIGZBM
	6vtS3M7HEfdSiJVdVtMaSV26unmGa1g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-ZK-TMy3OMOexI80Kdee4YQ-1; Fri, 11 Jul 2025 07:40:43 -0400
X-MC-Unique: ZK-TMy3OMOexI80Kdee4YQ-1
X-Mimecast-MFC-AGG-ID: ZK-TMy3OMOexI80Kdee4YQ_1752234042
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45526dec16fso3769885e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:40:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234042; x=1752838842;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JxNvOa4I1lVwZjisn9NutG86CttWSUJdgFsU+YoJILE=;
        b=wZxXHH5j+/2MXIPfcBkzfjzzvcL4A7j6Ah0xAqKHmtCWqCL6YcXDsNhYr0EtRVt4VA
         xQUnkhSU9VxyhyAXVf/1qQcU6vFdZkYCQ+dLnw9u68xzrlcqbCXqfQYUXfg1rPo/lQfz
         QRXK7PCB7ch9kqbbGggdlo2tvPmyqJ0SSt9kjHhkGPdPg1Uh2TZe1R96drIAne/eb/cw
         hMXnshR+41vV6PzVkjnMcnkcSbE1oJ3mG9sS7fXImT2si7RnogH9VNzDdyzKZzodNSNe
         X2WzHaDRZU+vAToL4K47lQPxU3GuQXr7Gakv0Lo9EmK8avmWHXXhcH+9GeQItR0et0jX
         CJCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtrKrPefrnU7k4s7e3lCDMV3P6qz3uGEphgURJTFV+KPDzafBn96HWPQyyhnHCAop8acGNdoDTg6KHxvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBOcn7+r2VoIUOBGdglMwakjHQYDPj59MKDpAIKzVrRl4Zv7ZN
	wbJHf99CBV+5dYIqwHF2SDRXrpeUH6CJ66O1AsdlKZ13uGcdOVKyJ4FP8U5Pj6KZprjt0ely+hI
	a1OHN1oniUsqLJKCsjF6znV+4VlA9GTj439OaDnnE4Yjj2oKi6UGX6FOjo7tlyRRwlw==
X-Gm-Gg: ASbGnct9QJzbanj2aJQHfyUD5IemFbluf87flGyaoA6OLT2utD97Y2B6qlHMEDVp864
	wDPlC6lsgxsS0HmNlBhuxz73mPQCbb7WW9r4kf7Zs+N0iH+Yp+xYvXw08ovu8YVbBoHWJzRupVc
	umaVJnQtzzdWvhdI3BhxZnAFbyONHuXhAeYNHXs+cWVtoDVhXpK3fj6fbuXBSlnJDVhl1JyBgWx
	fUd3Ea9gUzuCm4zHmfFn33t4GjWWu1CZaae1LJA7lOkWSjVlb4IVdUPO55Po78ZslWIkUYv5zwa
	5vOth13Qg5gtp6TRVDPg0fJpgzVlUv0IP0xtfUOU6N6MPi5g1UCOstAXINFl+PpTSh2cPUplCLe
	6LvZVQ1/u7hmWLiRrc0Wi2ae73tCa0CRv5dSgIVRcy5LVAGx1QGBn/2Xfu8Ij4ZhhsQo=
X-Received: by 2002:a05:600c:a301:b0:455:f187:6203 with SMTP id 5b1f17b1804b1-455f187666bmr6014455e9.27.1752234041764;
        Fri, 11 Jul 2025 04:40:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyNsyT+A2blP2ZWUR7EykNn1A8pk660lkD6z0yQ/zgmWN+MwD0hFcllj25is0rmjoSLvocwA==
X-Received: by 2002:a05:600c:a301:b0:455:f187:6203 with SMTP id 5b1f17b1804b1-455f187666bmr6014195e9.27.1752234041359;
        Fri, 11 Jul 2025 04:40:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d727sm4280998f8f.51.2025.07.11.04.40.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 04:40:40 -0700 (PDT)
Message-ID: <fe138d11-e0fe-4e57-8e51-a5521bad1b88@redhat.com>
Date: Fri, 11 Jul 2025 13:40:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/14] mm: add config option for clearing page-extents
To: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com,
 hpa@zytor.com, mingo@redhat.com, mjguzik@gmail.com, luto@kernel.org,
 peterz@infradead.org, acme@kernel.org, namhyung@kernel.org,
 tglx@linutronix.de, willy@infradead.org, raghavendra.kt@amd.com,
 boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
References: <20250710005926.1159009-1-ankur.a.arora@oracle.com>
 <20250710005926.1159009-13-ankur.a.arora@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250710005926.1159009-13-ankur.a.arora@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.25 02:59, Ankur Arora wrote:
> Add CONFIG_CLEAR_PAGE_EXTENT to allow clearing of page-extents
> where architecturally supported.
> 
> This is only available with !CONFIG_HIGHMEM because the intent is to
> use architecture support to clear contiguous extents in a single
> operation (ex. via FEAT_MOPS on arm64, string instructions on x86)
> which excludes any possibility of interspersing kmap()/kunmap().
> 
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---

Staring at the next patch, I think this can easily be squashed into the 
next patch where you add actual MM core support.

-- 
Cheers,

David / dhildenb


