Return-Path: <linux-kernel+bounces-739118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 448B7B0C20E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C07C3A646B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFA328DB6D;
	Mon, 21 Jul 2025 11:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMTQrHzF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57CA921421D
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753095690; cv=none; b=A018FiULbkZ+IeHb/meGsaEu0wEUGUdsPrKOGup7AfnDs6X0ErjhXYFHz5yZiagdjnkHC87uVP3NeX5Elva3U9fJefMyYKyzdQ9/CDvD+RyJ4R37HTBlxqfYQYC+8ws8lgraxg0jT3c9L/C2VbQQqWItTR+xO0exImSG2joxjB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753095690; c=relaxed/simple;
	bh=3uDeAdiUvN4l1RdJ3DN3um5QS2m8kMLLQ8xN9+IgeYk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i2e5sNA0CDOn1hL/+mXoV5Pd5734W9U62/yOamnrEj8gVCdkZPk8jwXv13y+/kSP7SZvDTHU2BBtz1poxq1uhjGLeNa9EfbGRrr81NHj+OEbjJkj1uHKF8l3C7dvv16+WCUu6k5fdAbNetQxB7j9ZvLT816YIsS8Bk7xfTWxdS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TMTQrHzF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753095687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=6+dfOTlpuHnMxu6kfYNSNJVS9pkyDC0yE+vfftpCyw0=;
	b=TMTQrHzFC1TIKbB0dMBKrrhRj/1Ldqe23w4U3DhOJD8HapBZH+eK7IFvMHyBwcLlw1o3Y7
	OUC2orvaqKg7D/D3/h5YNkRfcuEad7hLVG7ikwlg9lmCnjTria5SiIVPH6kHspRktPHmkE
	XcaCdpfwlStJYAbazTl2GLIS2JhMHpo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-596-IDDnlShaMt-0I73QxgxgGg-1; Mon, 21 Jul 2025 07:01:25 -0400
X-MC-Unique: IDDnlShaMt-0I73QxgxgGg-1
X-Mimecast-MFC-AGG-ID: IDDnlShaMt-0I73QxgxgGg_1753095684
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4561dfd07bcso24748685e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 04:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753095684; x=1753700484;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6+dfOTlpuHnMxu6kfYNSNJVS9pkyDC0yE+vfftpCyw0=;
        b=mTD94xxMDyb7eGi6tbZGJvC6c7aU7R+KeyKiJ5azqYeRpBG8Krb/sgmW+GE3fc58ct
         E0zEyNQR7LMufavC+Y3ODvBOqUT+vbnN1rS4Td3Lx5jYTMJH08tRQYI7xJO25Zy81umE
         XO+k5IpkfWLeELX34bnVxR2I0EV113mXu9Z1xv6BKtJAcbE0abPpe6vcJuEDEVa0hsJN
         Ge5YaJV7/r44yDetOg5gLxZZM7nX/YWePi48F7EO/t+H8noZipyIafGsQhkpHKPKir1q
         dGZX71fPDGLU4MC7Goob7P9d65CPQjT5fhKpGOWni/KVYyshrBIfn573vRFIF3k9xGh1
         GUNA==
X-Forwarded-Encrypted: i=1; AJvYcCVOj8VYyqFhYPg1/lZs7vtm9SP0U86hAJXJOGpPHFRst+Qd0ApIxqC1njRlypQaEsF2LpOjJgXhrroTFr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdNcvfSm405lS9x/wwRhJKo87QXBFc0Ldq9N7gs9odp9Jyubof
	1aHWDASMfHPhmZgSWspefBafPjzOaGmkex5NKLXNuSJt/EPoHSkEQRVrkuCHOuTN87gcFNgOAp1
	XubdSx6tCnBQ5epWFGW+7zcY4r01zWKK/IWDdrELsAFTnkyGdwmdpPdPlEZqxyaU9ww==
X-Gm-Gg: ASbGnctNn5UOFZgesLg2h55y/ivj4h7NBEYZ2HapwtNxOTYI09mND8hnwcU6iKOdbHh
	Oaqmyg8MZ7LHcT9cpm/b7Insms5Uc+cFBMWvKURUMmHBMZ6S5meTtuq4wH6+qVOp4Jg8MFvwY+N
	8dnlLEoTBNY4Lu4AB4Zx6HtyUJeeZX7XjNDrUP9Jy4vgPauBo0/60WLRGk5XXIo2H16FW8wx2j3
	muAD7UGZsNV9D0/XEHmKU9QTU2SzsScSX+ZT3Fd9QHA4O3jZAPnvXWhOukPXd6dyTjnfIKPvMiK
	58/KVUPWEw0Fy5h/6Gpi7agFQq4XS74TQHU/tas4utDLenHJ35tdVNn8azPMvqFTKro1IqbTptn
	1Sn1Uuj+HyqItXZPLO2Tu55ga7WWN9Nrp19UA8RhouIAopW4B+oktB8d2jp87e1+1
X-Received: by 2002:a05:600c:8b54:b0:456:18f3:b951 with SMTP id 5b1f17b1804b1-4562e34e142mr211410895e9.15.1753095683749;
        Mon, 21 Jul 2025 04:01:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1Puq+GVFglasRWX7P1rZcJme71HisJQEwqR9AJl7KOt3wlBX7XhhcudlfRQFjD49vh205qQ==
X-Received: by 2002:a05:600c:8b54:b0:456:18f3:b951 with SMTP id 5b1f17b1804b1-4562e34e142mr211410205e9.15.1753095683110;
        Mon, 21 Jul 2025 04:01:23 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4c:df00:a9f5:b75b:33c:a17f? (p200300d82f4cdf00a9f5b75b033ca17f.dip0.t-ipconnect.de. [2003:d8:2f4c:df00:a9f5:b75b:33c:a17f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b75baa6f78sm3187671f8f.3.2025.07.21.04.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 04:01:22 -0700 (PDT)
Message-ID: <8ad783f3-479e-4227-9328-42de6f407ba8@redhat.com>
Date: Mon, 21 Jul 2025 13:01:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] mm: cma: simplify cma_debug_show_areas()
To: Yury Norov <yury.norov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20250719205401.399475-1-yury.norov@gmail.com>
 <20250719205401.399475-2-yury.norov@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250719205401.399475-2-yury.norov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19.07.25 22:53, Yury Norov wrote:
> From: Yury Norov (NVIDIA) <yury.norov@gmail.com>
> 
> The function opencodes for_each_clear_bitrange(). Fix that and drop most
> of housekeeping code.

Same comment regarding "fix" as for patch #2

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


