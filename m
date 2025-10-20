Return-Path: <linux-kernel+bounces-861635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCDCBF33BE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 21:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B9B554FB906
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5B9EAF9;
	Mon, 20 Oct 2025 19:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYhR3iMX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE7E2DEA73
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 19:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760988944; cv=none; b=B+b/DOQWXZ8826BlBH9fq3FFp5cvdnfRuydzrjk9/gUrSDBEh30Dkpr6KfX61A4R4Ibg7m/lGx3B+hY515LbuGe1hGQZoSsS/v0Yk3qSLn4NQYiCuNm7o+xfw+PK+efkjAhGg0+wTFYpuitfWnaaX/9cdwyjKc8W6QtXe+RpHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760988944; c=relaxed/simple;
	bh=TstNcT24iidk65qQwuHBm8MLWpw+Rgs03+06matpxa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ewL8rMBuXZpi54HRy3vprDS0fCjq6QUZ4ot1N3eWbmXcj2nHqpdHH2QHOE1UpHLKxEZwc3XYLO3VGbgMUc2gHtFjkmIPWC+WknMT8l2ToMJK1dh52NfcbGYl+M6ZiAP6jvtM4oFl9Nc5c3Bp7J5Yj8UBnkg4/trl8y8GpDEI7DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYhR3iMX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760988942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IZ4KHrVXGbKOyfWQ4VuLHo93xGYeDh1z6yDjQj1rykE=;
	b=fYhR3iMXLzvOPCFD18Aww8rgEf0/Pxo49rHgUhtQbqRW1ZldxAJLAttj3OooVyk1rXHY09
	s07tHjCrSZZg5GAbzOzjSh+NUfxd8UpplXQ1n8TakbJg42Lw6fzh7ii20jTxPKsbCKDQJd
	OE4Tw9hz7Z0a1QGaTY3N4693ErXNUKQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-h2GNfGNtOwK3cb_ZMfdRYg-1; Mon, 20 Oct 2025 15:35:40 -0400
X-MC-Unique: h2GNfGNtOwK3cb_ZMfdRYg-1
X-Mimecast-MFC-AGG-ID: h2GNfGNtOwK3cb_ZMfdRYg_1760988939
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-470fd92ad57so101003075e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 12:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760988939; x=1761593739;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IZ4KHrVXGbKOyfWQ4VuLHo93xGYeDh1z6yDjQj1rykE=;
        b=NcQclCvTWSBjPXs+EZgyHNNKcg/zMwU17ytokZmUkoZ9q5NGa365PCRctt/RmtLWXM
         jTcTTcBtRNwqkVSzU2m6eM/LYAc9Gw6P0iiFYouQZTxLhahUhplNqA7H+ZRRKKzI9SzQ
         bPvaacwiKjii30ZiIFZO5znGPrfjs9W+RjZyA5oRH4jxzMchny78p3h+wKSl++OIdfVQ
         hlNWj+Tr8WeFUl3dOIAimJpvZ7YT7HMTTCJpwhTyA1oAV1pZsZ3O23W9Dh986MK/IEV0
         VWnWRZ9zP1KHANiqWgpTRyWWvd2HU94vScDjCme1oRMJSBnkylaarH998DZrmI9EFU7x
         dQSA==
X-Forwarded-Encrypted: i=1; AJvYcCV9YAC8p9pcXDOr1riB0Et/a6J69FRSvnPER7U/o0+AdFUfh6UQ2uU0BbjbuL7LYQLiCCZR4k+YgknMNaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB2KZU8WDfT3B5ii91ISWAvjYbQlFVq0wMHGx23+64ZLSDtP99
	s49SQ4FmAR07Kv/FS3de4Gab+MkPZOKSY/3Vbua1umsLaUL2jGPTleyslEdN8hh25f1EOKMMrdt
	TefNBSZD/UqHY69iN/JsAOCRBjZPawLFpsGp6KyuFRxubKYVCwp+8oN1C84AK23MxiQ==
X-Gm-Gg: ASbGncvjRsdQMz6LdJgceXotW3F6vXTWTFcK4EiGCskmTc96nHhbNjmhj2tSpMfyaII
	WvFwVKFRXGZVDIyYUyh5ioTm38f6JBVSdSYBRyXmktTR2WGzM3RTmkB/CXjez8U72WMHAxAIrb3
	ZwRdcMWkLNQL5gf19XixdGLaIq9l/SPG+/zsBTnV0ypJq7HHivXK5oS+w5NKAaSHdJe9aWI4S1k
	btBV6/xyz0custst1q2Q6BtjkV5kb+PSINdIjvXkESz/X2XQiBqt8H0Ea3Ta7HXuDyqitYxjSyg
	c6P9jYeU6DdVQr/6dB7HngLPIP0dWJUs5Aphr1YNkos4EdVngcgvHbb2oOaFz1kZcwb8c+tefej
	oKXO2fdTXsfmWmTjDY7HpTSYBhCZsZ9rMn9zcldwGybRPwPNiO+x8o22KLzCrDfdpgmsah/VPjS
	+uwZtCBPxkLHyBECed//kpzY+JA0I=
X-Received: by 2002:a05:600c:528e:b0:471:7a:7905 with SMTP id 5b1f17b1804b1-4711791cba1mr138573305e9.34.1760988939350;
        Mon, 20 Oct 2025 12:35:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHUD1Q58X1dirbdln4YyEHe+ZrBTn2g3MQBkfJH1bO18P6uDwJ35vA6zo0kQDMsN8QQTSSzUg==
X-Received: by 2002:a05:600c:528e:b0:471:7a:7905 with SMTP id 5b1f17b1804b1-4711791cba1mr138573155e9.34.1760988938928;
        Mon, 20 Oct 2025 12:35:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce? (p200300d82f0cc200fa4ac4ff1b3221ce.dip0.t-ipconnect.de. [2003:d8:2f0c:c200:fa4a:c4ff:1b32:21ce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00cdf6csm16661954f8f.43.2025.10.20.12.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 12:35:38 -0700 (PDT)
Message-ID: <85166a8a-ad54-42d0-a09f-43e0044cf4f4@redhat.com>
Date: Mon, 20 Oct 2025 21:35:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 PATCH 1/3] Documentation: add guidelines for writing
 testable code specifications
To: Jonathan Corbet <corbet@lwn.net>, Gabriele Paoloni <gpaoloni@redhat.com>,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 gregkh@linuxfoundation.org
Cc: linux-mm@kvack.org, safety-architecture@lists.elisa.tech,
 acarmina@redhat.com, kstewart@linuxfoundation.org, chuckwolber@gmail.com
References: <20250910170000.6475-1-gpaoloni@redhat.com>
 <20250910170000.6475-2-gpaoloni@redhat.com> <878qifgxbj.fsf@trenco.lwn.net>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <878qifgxbj.fsf@trenco.lwn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> +------------
>> +The Documentation/doc-guide/kernel-doc.rst chapter describes how to document the code using the kernel-doc format, however it does not specify the criteria to be followed for writing testable specifications; i.e. specifications that can be used to for the semantic description of low level requirements.
> 
> Please, for any future versions, stick to the 80-column limit; this is
> especially important for text files that you want humans to read.
> 
> As a nit, you don't need to start by saying what other documents don't
> do, just describe the purpose of *this* document.
> 
> More substantially ... I got a way into this document before realizing
> that you were describing an addition to the format of kerneldoc
> comments.  That would be good to make clear from the outset.
> 
> What I still don't really understand is what is the *purpose* of this
> formalized text?  What will be consuming it?  You're asking for a fair
> amount of effort to write and maintain these descriptions; what's in it
> for the people who do that work?

I might be wrong, but sounds to me like someone intends to feed this to 
AI to generate tests or code.

In that case, no thanks.

I'm pretty sure we don't want this.

-- 
Cheers

David / dhildenb


