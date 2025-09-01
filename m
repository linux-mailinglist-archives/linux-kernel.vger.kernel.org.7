Return-Path: <linux-kernel+bounces-794251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBF6B3DEFF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 11:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64A1F17405F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 09:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A6B30C35A;
	Mon,  1 Sep 2025 09:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BTx6eKV4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721263002B5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756720159; cv=none; b=F5r4bctPez+MFeWB6SNHLPsavCbzw7TFieBJhhuwg2U4DGHaudqB63AZ6YpQuKMXQwOsmNcTd+DLM7qBsYU1fo2AfNc5QNj+JRwYpGMWVRKxgIB1+pYCZComrRn0+JaiRoU73UPqRy9jyoNrFzdXUkgNGmuQIurk8xShLmk35kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756720159; c=relaxed/simple;
	bh=y6aqxq2pyak714yGCCUo8hD5ZylptEcBvFFp1pilPlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LmkRp4FRwcAjZT4lHxCZzSBzHfgSVwbg9PdYjOk7/hhcwNeaDK4z2CIbM3Mk8hiPLH1slHetRhhrsaO58X4r6ErrkB5WmNg2UNPO+mwlEwEBslTazSQQjdAM1Ya3bMwuSNwG3E1aqeyC77kvCgISgMG//Aj1GroiqnU9NN6sbpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BTx6eKV4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756720156;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VZPuTcB6VB1tT581BdsI3cxRxmrUkwCOtuVIN71SiY0=;
	b=BTx6eKV4dYEM33YfH/6AGlEztkpB+6F60+5aOIU0ngKxx4/FALQubKRUGPWlTqbG0HLS1i
	jSx+dFBQsS7B9lOU1Sevr6UqYBzKGwujINVjZROuh4I6auPSN7E/YIV78v/vPif6TSP2wc
	l1pRD8nAKq8Ocy3VK3d/PdPhS8RM7bI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-qRkCPPMJOmScduiOuu-nRg-1; Mon, 01 Sep 2025 05:49:15 -0400
X-MC-Unique: qRkCPPMJOmScduiOuu-nRg-1
X-Mimecast-MFC-AGG-ID: qRkCPPMJOmScduiOuu-nRg_1756720154
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b869d3582so7541845e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 02:49:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756720154; x=1757324954;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZPuTcB6VB1tT581BdsI3cxRxmrUkwCOtuVIN71SiY0=;
        b=v1vfbVimZ/pP+8qvk2hJYw3VoUtZiVT+g7U4ph4BVxDuWsdiRFb2sSXmeF8mLSCQcf
         ewkDyWkCmC3TIaldgRL9wb39Tgl2emNp2JCo598esIRbxMPM+FF3JSnpEpsKpexJIQm2
         kEb3brRijM9mv77jC+j8Qbik/H1SgMN0aVJolZnh1nkW3ZMaY27ttFQkveV/3zAtETcv
         B77/wRJVaOIEF8ENDBZDZvqZlQD1tNGsVVZkmgJqSDrvtd4qOnezEomNa9rh7ocoAACg
         JhmrMclSDzrIesmQO7yydZKJEMezI0TpTa1KTp2TmbjmDUXFtPegGuX2PtyQAbXHK5QT
         LiRw==
X-Forwarded-Encrypted: i=1; AJvYcCWwmBsuFztyFi27mOIkDWlUWOQTOHgPldkShFazizb6Rhz/fqJN2MtOphkbKFpTC9fnNI9HYkmH7C0cbtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFeSOX+wZa/zNpD7+ns6FI+3MEod9Q3fMllmna2v2bP8ceMnoN
	yKzg6RS1VYTmak7mGyr3zVYRqpkw3L8W4nPZy1OJcfNEbxGPW3Tu85AnfPNdF8p0vCSzCblykn3
	urrNs9IaOvTB0sZU0lqVaC0eaMXQgq3YaFeuIjuw/dUvvWPJ7hQt9Pc2hq0DcXG+rmQ==
X-Gm-Gg: ASbGncvJD2M+/lbgkOVpcr7R6zy9ntTxSMLq9ZQEbPj+w3adBbnDTPo/pq9e1E93zuA
	b9rNhXAZlImSDZ8D4YNvRCcdxF+m5M9SST8IEa2OBQEcbhjtmHmbOScYv/beFyBx/Cic8yabniz
	n6gtioO1qCbZinI8g11N9J3S4VVZNjmDDVkf8ljv8zOA64YUi8mn+Jhv9vDwLm1E3M18WpdrnD8
	kvkf+ThGIXCuyJ008qIJfgFGjud7rxRi8/DIx6b4IpLsdS7GzI7tRLVGmmNZpCUxSrhr9rQ03na
	L8Q6YsNOdKPVtXVvxjMOnFiK3jPH3P8zFHBseU6mYdWpODtr0IuUWPPGV7X2uhcOWowthkHkaLu
	PB6ax6i2jpmZ8oYgJYSL9eSSVI9Ms04PYXlbHojjEN2l9EDEpe7vxBhLWINxR9Dm73CE=
X-Received: by 2002:a05:6000:2a8a:b0:3d6:4596:8a29 with SMTP id ffacd0b85a97d-3d645968cb1mr2767203f8f.44.1756720153848;
        Mon, 01 Sep 2025 02:49:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLu5iNoRf+fgplKqxO2NiQYLZV1Fzka6Znlu4Q9UX+booG2HzYxe9U9o/szemNQgDBT741Sg==
X-Received: by 2002:a05:6000:2a8a:b0:3d6:4596:8a29 with SMTP id ffacd0b85a97d-3d645968cb1mr2767185f8f.44.1756720153460;
        Mon, 01 Sep 2025 02:49:13 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf276d204asm14604463f8f.24.2025.09.01.02.49.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 02:49:12 -0700 (PDT)
Message-ID: <27a631f3-ebb9-4f62-8efe-989ad25e7542@redhat.com>
Date: Mon, 1 Sep 2025 11:49:11 +0200
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
 Vlastimil Babka <vbabka@suse.cz>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org,
 axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
 hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
 rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com
References: <20250831093918.2815332-1-max.kellermann@ionos.com>
 <20250831093918.2815332-2-max.kellermann@ionos.com>
 <day257vhz3o7hepucfz5itjvdtp2k36hkqdg7hckqleb4jxyku@rs4rs3zhl4hn>
 <CAKPOu+-ZjNr9hEir8H=C5C9ZwbS7ynY4PrJuvnxa-V425A+U3Q@mail.gmail.com>
 <e3ec5583-adf0-44c3-99c9-5a388c43fb7d@redhat.com>
 <CAKPOu+9CiT-5P--6TZcyq=jHLDhCa8LDh1AYjKr69+0shO8UrQ@mail.gmail.com>
 <244b73d5-39dc-4bcc-a69c-8ae3010b40d9@redhat.com>
 <CAKPOu+_wQ9DDHOQDtFeXU7ZqwvwxYqXNqWeSP3zJpfC0Cm2YAA@mail.gmail.com>
 <adb9e55e-0023-44b7-bc88-ed95be8dc71c@suse.cz>
 <CAKPOu+8wK16XWCx1+7801tyE66uLBu79CySLFetCWbS3TnH3bQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <CAKPOu+8wK16XWCx1+7801tyE66uLBu79CySLFetCWbS3TnH3bQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01.09.25 11:45, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 11:32 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>>> Sure, but first I need to know what is really needed. Reviews on LKML
>>> are often contradictory, and it's easy to get pushed around from one
>>> corner to the next.
>>>
>>> I just posted v4 with longer commit messages. I think that's a lot of
>>> unnecessary noise that takes a lot of time to read, but oh well, if
>>> that's what you guys really want...
>>
>> No I don't think we want a passive-aggressive malicious compliance.
> 
> What the .....
> Your response is similar to what I mean with "getting pushed around".
> 
> You guys insist on verbose commit messages, or else it won't get
> merged, you say. I don't agree, but when I yield to your requirements,
> take the time to implement them, I get accused of being
> "passive-aggressive" and "malicious".
> 
> Please be more respectful when handling code submissions.

It's rare that we have such conflicts/drama around here.

If you feel like you need other rules than everybody else here, I 
suggest you focus your effort on other parts of the kernel.

-- 
Cheers

David / dhildenb


