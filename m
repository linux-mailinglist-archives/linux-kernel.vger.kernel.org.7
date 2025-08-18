Return-Path: <linux-kernel+bounces-773342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A34EBB29E93
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 11:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CF6F1962171
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 09:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA030FF3F;
	Mon, 18 Aug 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dWKjk9K+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D1030E844
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 09:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755510976; cv=none; b=StrmRqUWSoiBWkjK3qtlUPpe5UXG2ypqSWHqsZtgICox+JDgm+FQZ/ZH0yXogg/v6M4HEhWVYPBImaEU0SRPOG/QQ0rsqHf+PrchRJCHo3qRpWxnGmBw/sTQxEy/K2Z5sQ0eIXjwpss7uEPApi7OKRDMGCu1d2EDWfpymA+QVWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755510976; c=relaxed/simple;
	bh=T6n7tG2140FihXrM2B2pBsjHqASmO323rupXc9dMges=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b5JOIGnI6GueIoDx/QWl8544E3ei45JAMH0O9hkfk31bvlEP1X7wJPFc4Xxq57BUAeotHk+UHGasqVKb2oteikQNQJsoasI0GyxKYQ2aclECdTIAUqblr1w++XN7i1ncy9rIC/XiEbvvFk/SUyDf6hpb1Llq5cnjJXodsbdpHag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dWKjk9K+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755510973;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=raDzIjAENVmKn6Sj6sy5GLjqp3QaobootKXp9zS8+JM=;
	b=dWKjk9K+rlASpQz5wdj300MddGvKUag2+ABUEZOdg/z961ilr5IVphM23XtOFncPOxM/Lj
	hlOD7V9BbZMwgv2zDueg9ep+0ATfLN5NMNaxR9quPywOEZPhwgXcZISJ1dxJGbgdhFDtiC
	4122fO2OgYt6h9gG7zTBGbNJIoz4uIc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-X_REF2EVOdSv1_xGNP-ixw-1; Mon, 18 Aug 2025 05:56:12 -0400
X-MC-Unique: X_REF2EVOdSv1_xGNP-ixw-1
X-Mimecast-MFC-AGG-ID: X_REF2EVOdSv1_xGNP-ixw_1755510971
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45a1b0b14daso12458625e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755510971; x=1756115771;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=raDzIjAENVmKn6Sj6sy5GLjqp3QaobootKXp9zS8+JM=;
        b=e1+GJzIUJzVTDNt+iS2ZGKJjxndAWT9M6k4tieF0/IZC7D5HpRs1Iy5/PmIbic0/q4
         71CkKa9Tw5YChsbGIkjC8ZCOcQwXMOTivh8ABFpb8BvsDbOgU+zJhNLt+s9qkZWtFz+r
         1YbxYx/vvIGgz4MdxJi133q2xuKlv8u6P0MqG4dsTSFWt/KuPG/nNx2vP4vpFxbjWvJu
         jcrcJy0ULeOqWBv4Y7AQu4iG08yFPFBTN/VRsXGoEHVCHysgIkQOWJ/dD+zULaU4Wd9I
         1AFaEGkFou/owdkubKm68MY1Q3eyPxn3Dg1KOf55PopO9ZFLX6v1RTXdqb1qeTJ2BvGY
         GXkg==
X-Forwarded-Encrypted: i=1; AJvYcCVSe9RCialceijmiWuWi/dMWLNnBR202xZJMc5rQymz6iKHVplD0RqVNN4tfaU8KfeTRp1js91JqE4sa+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZj6tBLvlR1UHQoTnmZSh50tnscLC8c69XMuf9gBwdWUS3Oxc3
	X43slzoA5Cy4uh1goA75iJQ4mw/wRQwqp4pwSk4c66ewjqK+EzPABBuhqq6uaEkU9v4633DSuXK
	O6Hxd1crq8++v8sFv+oiyitGVOmLngur7hWYDLJCrHypNsc0gVTYu0MxLV5fMV6igPg==
X-Gm-Gg: ASbGncvWYFJSsm2lAH3gPyBJoWht16rUMQhpFBn9Pg6vOOXUzZXqOaCnp7P/guqy3pF
	/GIji9BSh6YchPNWKpDFJeZ/byPdgOHohz9DjE9JLM8QBEYlDfbyXt97eQWvn4Wb19wKsBW0c43
	vvZaQVuJ0tMnZzjkIw7NtfO9OsXmjcaqhgiOt9uSOnrrC+GVmpwAMD3OBihvPTAes1ddhd7b3J7
	XbRlygJcb+cZpu63YK54XHK5dIscNAra/5yZgOtE+NGRp0vUeUr+pz7WxWmKTDFhrMRM+/hNGFe
	A9veO2RPotsrn+JkiC1d/v2h8YPsP8oyKe7iO2hsMcYGJJA/qPYSXZDEtG9PKebLvnLQmF7AmMc
	mbp2HYesNEINx1aaf91y5gl0m3z0SPTwqpnqHo6ujJzpAV30k/8GPHhuTUSwcXBlm
X-Received: by 2002:a05:600c:b90:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-45a21877960mr102171645e9.30.1755510970910;
        Mon, 18 Aug 2025 02:56:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHokknDqB0c84wJMzSgV2MRYm5XM+i/62v1KITdc0/L0Tkbm35j/TM/ZHDqqxEk9IMBO+SOsw==
X-Received: by 2002:a05:600c:b90:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-45a21877960mr102171265e9.30.1755510970517;
        Mon, 18 Aug 2025 02:56:10 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a2221136dsm127102855e9.5.2025.08.18.02.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 02:56:09 -0700 (PDT)
Message-ID: <ee28da71-a1b8-4980-a2ad-f956260e73c3@redhat.com>
Date: Mon, 18 Aug 2025 11:56:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] selftests: kvm: s390: fixed spelling mistake in
 output
To: Soham Metha <sohammetha01@gmail.com>, linux-kselftest@vger.kernel.org
Cc: shuah@kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linuxfoundation.org,
 linux-kernel@vger.kernel.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
References: <20250815000859.112169-1-sohammetha01@gmail.com>
 <20250815001803.112924-1-sohammetha01@gmail.com>
 <20250815001803.112924-4-sohammetha01@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250815001803.112924-4-sohammetha01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.08.25 02:18, Soham Metha wrote:
> found/fixed the following typo
> 
> - avaialable -> available
> 
> in `tools/testing/selftests/kvm/s390/cpumodel_subfuncs_test.c`
> 
> Signed-off-by: Soham Metha <sohammetha01@gmail.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


