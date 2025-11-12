Return-Path: <linux-kernel+bounces-897318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD05DC5299E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5D73AF0F2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 13:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2166A229B12;
	Wed, 12 Nov 2025 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="NhjKngH4"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E23C21D3F6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762955490; cv=none; b=dazMxDLtap5qpkIGpP8sDCfXA/By0b0+zhy1DzZy0ZWrQNq7VG+LLWnO/J/tQ5GJ5EidLBSlRKgprxZw2Kphcjh32BknikiGDku2K4s+uIHI4yczNgPGS8cevk98KxY/b84ifSDcpzZwXCsYfBfhrG+CpIEbx4nm6zK/zGEHJyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762955490; c=relaxed/simple;
	bh=n3z9Jw7bEHMAgnOiDe5IhWMfzXL5QaG73RaPQ8hsiRk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=prss4knQf8l+F6mui1LUNbdm7eDv8lL6sefXpRTHaZKC2EW6OFcgmPtdZRHQogruDhM8Ch0925H8R81tZUED5xsSSPD5nLYTlMlg1HXdxJ9Pa5a9jw/M8v/tiLoSr0v72FHbUIQi71YhTer1Ka4xWQwdwht+pdvAlSRGvGstGJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=NhjKngH4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b710601e659so154667966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 05:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762955487; x=1763560287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6eiNlO9W/s4a9ATMZ+5tC2gxgF5OkwPuLSe2qOti34o=;
        b=NhjKngH4QwqCocKpnN5eT4FBJ1deZrwJaqsRkjprC3UrH7Pm2iiJ8OuKw6oQOe4sA1
         Q3WByqVtQt7KVx75osmvuakFUVSR5vx+oqsMRfjW3q6jyEKmjQ34bEPT1UOX9mh/MPf9
         M5TXQoKN5A6l+HbxJ9us9XDK4Pr0B7MkYCRlewNkckKUnTE2GKBa1PYq3hsjRUanGkdP
         SVhhDtty4vlCPeqLM79OQM4qauB4zJJQmic/5w93FYrHF6ye7rtQ+gjMfxbTnTevS8NO
         nqUlGOhLMvXYqYYcAkJ3bJFQuOLsDKengXD6h5PVppnfhX203LclBqRHr9zvdapRyFar
         CGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762955487; x=1763560287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6eiNlO9W/s4a9ATMZ+5tC2gxgF5OkwPuLSe2qOti34o=;
        b=R6PxC9njeRxPWil/obwKlHHrafvVoiWw/S/M2B22iz98vihSW1jXEnmMS0UsvlB1XQ
         cHCqXpqPRFDYauplq0maUJgT1zrMcMDLZCgoWpk+22kph85A/lLSAQlbU0FbxA9Mahzo
         9GIGURTFDlOWtTmw2ig8qm1Hhw6Mp7JnclmEo9IucICg0qbN3lRHo+fPG1vPUY/2R4/E
         b61wfBuCA7VKXn3ibxlg8fv6SAii14crSbtCMYeCgmAi/4w65Od1kbWLXOgHwDTxOGlD
         Uut37ces1qy2LcQh/VBVUQxFRmYkYCiztJQRGcaVl5vuPMF1HZWf5o4pSRgh+WtiYv2V
         WrzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVs9X66Gu5vboMJ2PbaZwKOJJMKNfFE9Klz6yuL2J4WTmgR3kJb+THuczdJxBK2qhVzsqbtgHsBLzwW6+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3zLVY1W53ojpvP39Q0kbcv+U0c3RlhlJ8AkHRPuP7+y7JL3jN
	p2xMRlUOO0XyBsQEazeCUysKthAQCQyEJMpx1vIy9qam/2ZZiUoertBcMHeNvuuAgJ8=
X-Gm-Gg: ASbGncuFtT6AwZmdyftna/cEp6oEWzvdK9Gn1DHhWrgZsDsc1wFdRTBMWDk4Z1T2FDK
	DRg+a7PBsAvgLZTeC+eScxsGvSNc3RYVQUfn8Io1lRmBWR6U9QxbkCZphf7B7MwaK/RA+Q7PyDR
	5Pt+n9apaEa02BiVKbvrt2Q38u91IoE78MFXlEIJAU0gEi+Pni0AFcYYz6TwYNox4t62lC0fjqd
	IGosHYgtItxLB0I6jx6Q22hMMwhGDMpG61DBu/5AojmvOGIAE7JFHkbHACy8qeMpXtG5oIe6qJn
	+UVdMrONli9mBkSmiM//UHwBDX1xfJWjBAdB3Hg4+f8f4ead50xcOQJq4yrSmuQ5mp54oCds8nb
	r0i9xgdAy5LcSNdg/Hm5kv09ggreTGcx3Z+xNtCgKHEUqs+kMTx54bbJ6PHBjqGcZzGRso+Rr98
	NUw0hU/5nfEHtH6jNZ4ntx4wJYk2tEzfz203LdXwul9PQ/BdOx8mzldlHvZUgFq3CtgnJuDHc0R
	iMMpgIELtf4TXJE0H8jdfU4O3m6/sfMgL8L4QCeoyth5QA=
X-Google-Smtp-Source: AGHT+IGh4KgZmhD9Tv0Q7r99njOC0g5Ef0gAEOLC9RYQ++zh2fc2FZ85E0tUpZs0DA8Ec4kM3FudQA==
X-Received: by 2002:a17:907:1c0a:b0:b39:57ab:ec18 with SMTP id a640c23a62f3a-b7331a9aa6fmr284237266b.45.1762955486563;
        Wed, 12 Nov 2025 05:51:26 -0800 (PST)
Received: from ?IPV6:2a00:1028:838d:271e:8e3b:4aff:fe4c:a100? (dynamic-2a00-1028-838d-271e-8e3b-4aff-fe4c-a100.ipv6.o2.cz. [2a00:1028:838d:271e:8e3b:4aff:fe4c:a100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9be184sm1587077766b.56.2025.11.12.05.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Nov 2025 05:51:26 -0800 (PST)
Message-ID: <e624c242-b297-4bb7-a76a-cbb18b027472@suse.com>
Date: Wed, 12 Nov 2025 14:51:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] sign-file: Remove support for signing with PKCS#7
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: David Howells <dhowells@redhat.com>, David Woodhouse
 <dwmw2@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, keyrings@vger.kernel.org,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251111154923.978181-1-petr.pavlu@suse.com>
 <20251111154923.978181-3-petr.pavlu@suse.com>
 <922480ff44bda3b6ecfda1ae780c659644560f94.camel@HansenPartnership.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <922480ff44bda3b6ecfda1ae780c659644560f94.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 5:53 PM, James Bottomley wrote:
> On Tue, 2025-11-11 at 16:48 +0100, Petr Pavlu wrote:
>> The PKCS#7 code in sign-file allows for signing only with SHA-1.
>> Since SHA-1 support for module signing has been removed, drop PKCS#7
>> support in favor of using only CMS.
> 
> The change log is a bit alarmist.  CMS really *is* PKCS7 and most
> literature will refer to CMS as PKCS7.  What you're really deprecating
> is the use of the PKCS7_sign() API which can only produce SHA-1
> Signatures ... openssl is fully capable of producing any hash PKCS7
> signatures using a different PKCS7_... API set but the CMS_... API is
> newer.
> 
> The point being the module signature type is still set to PKEY_ID_PKCS7
> so it doesn't square with the commit log saying "drop PKCS#7 support".
> What you really mean is only use the openssl CMS_... API for producing
> PKCS7 signatures.

Ok, I plan to update the description to the following in v2:

sign-file: Use only the OpenSSL CMS API for signing

The USE_PKCS7 code in sign-file utilizes PKCS7_sign(), which allows signing
only with SHA-1. Since SHA-1 support for module signing has been removed,
drop the use of the OpenSSL PKCS7 API by the tool in favor of using only
the newer CMS API.

The use of the PKCS7 API is selected by the following:

 #if defined(LIBRESSL_VERSION_NUMBER) || \
 	OPENSSL_VERSION_NUMBER < 0x10000000L || \
 	defined(OPENSSL_NO_CMS)
 #define USE_PKCS7
 #endif

Looking at the individual ifdefs:

* LIBRESSL_VERSION_NUMBER: LibreSSL added the CMS API implementation from
  OpenSSL in 3.1.0, making the ifdef no longer relevant. This version was
  released on April 8, 2020.

* OPENSSL_VERSION_NUMBER < 0x10000000L: OpenSSL 1.0.0 was released on March
  29, 2010. Supporting earlier versions should no longer be necessary. The
  file Documentation/process/changes.rst already states that at least
  version 1.0.0 is required to build the kernel.

* OPENSSL_NO_CMS: OpenSSL can be configured with "no-cms" to disable CMS
  support. In this case, sign-file will no longer be usable. The CMS API
  support is now required.

In practice, since distributions now typically sign modules with SHA-2, for
which sign-file already required CMS API support, removing the USE_PKCS7
code shouldn't cause any issues.

-- 
Thanks,
Petr

