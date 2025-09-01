Return-Path: <linux-kernel+bounces-794472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74090B3E24F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:10:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434921A814BB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C325274B2B;
	Mon,  1 Sep 2025 12:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TdzY5y0+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6BA270540
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756728619; cv=none; b=TUtr1D3Qyq7rGNECFsp7f7HTHnNEb5nv0YlhktFb10HJh+iGkF0XNeeuICaCYwnphKUxZkdIAFFNpRqVlcLFp/t7GeiSLgNerMZVJ3/0jn5zzMz7HMde11JAU6J1BwG5zcdgwfIFzyxgPkFheiamIN561BXgUUnROxgf6kQMypM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756728619; c=relaxed/simple;
	bh=+kZK4I8LZzFJemtN+zCLZ9gL7tmyqJEFKqOdS/hCOOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c2oG8o9k6RX1lTkTufOIMTzOHicqD3LJkqn3xU808mwNQClr2cfbxIJ/UBAnjvjZ+khS0BTkA5bLZdVOAEJT/0F6tNOgRNudy8ZRAh1RVCUpvfgSdbiMAd+kcFcM8dfSFqXhVw4ZhE+XI0DOmPhNhi9xlNAF0i7OKUgqrvUvPOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TdzY5y0+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756728617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gzHNZdUA0TtNsuvTJsCGiUNXQFxHIaKB5yJO8om2IZo=;
	b=TdzY5y0+LJQHhYSfiyLpQ5Ng3AmIJLjzBHf7ftYl7xe5vpjsdeb69uoJCx0k3XlQUX5wVy
	RYRqiupOpd+Y3gYl3sjb3vL3RTVVf7SaQ71DFdPIzI4J9qa+qsa+nvEMCrl439de5C0ETI
	ZXq9EtWDHVYGpP2UrhXLw5KnVjZioco=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-_dRapkrWPNa8FCXWsMr96A-1; Mon, 01 Sep 2025 08:10:15 -0400
X-MC-Unique: _dRapkrWPNa8FCXWsMr96A-1
X-Mimecast-MFC-AGG-ID: _dRapkrWPNa8FCXWsMr96A_1756728615
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3d79c7fa313so445496f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756728614; x=1757333414;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzHNZdUA0TtNsuvTJsCGiUNXQFxHIaKB5yJO8om2IZo=;
        b=GYmpMutwKzkow+92cttVKCqDP/Zs+v4NulBY5F8OpawQvchrvPdbdyH3LdGn714ixp
         AJMcVpGay5hbpO8yEYqoRxvJeMR5JitG3QzDDHkfIShVB0cAu8DNI9I5cgWDSsGFa8+g
         QAT8//UoaTpG5/fyiutTbKk4rlYZL4wHfcC72KMcPoYV2rH/rYBffl29FJfPnz0kMsJ5
         Cs4Jaw30wIL8LqgiKaK6aC/5CAG+k3HdXC80QrUiUPN8Omq1/xXLcscgkEBOjI/nC+Ix
         v8WqI1NE1XzelNF99dtO/klldOOVpH9QhmZMnDqzkG+Z0LXgqqTBKcrOpd0Sa2KQPd/U
         CdbA==
X-Forwarded-Encrypted: i=1; AJvYcCXI1RDD+OfRqg1zcCzCdMUe7SlaNgVFSj7aAYqwzAGICnB7srd+8JK2htzt6T6ykBDgImqtshyWWMSDReo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3+5siDVwTTKFwjqkSSDo2tamG0RZbxMd/sfTVrrFPL7mRK5Lt
	6J5UA2egEW+x6zwKLHkUtxuOfrLmUkYqBh30sui0+mVet5HNUyrev/2mMBwlZAQArTpIQ1Y1N59
	RjOjylzU7xDu5/ecG2ESez4zWS459ZEGud1/YDpoTo79qffM+0MaQCUlNWH0mQ05ZaQ==
X-Gm-Gg: ASbGnctHARybIreK8IsPfZqOVXibiiB0dREKd1wv3g5tWdsk6r24LBrpPkDbe4q2A+n
	sCfOpQtbf5eTi2Uhn7yPNcO+7JG9G19g7cGB+x2Z1DxaNgcEELKLOq0xpHH+IMc/Yq2ldKMZjuc
	9CIWSEN3npgCYzjneqPtMIeVJT/mA/Yh0DiHUTmCrpCyG7YqJvVPVdBv04aiw0iopZACafbyCqr
	+dB2nMcf34inSZ2ziRPA96B9rwNEYflj2TqOKgvIWlPgcB1SBI/Z976bFjE2e+K/hTA0s9HaYPu
	fg1AXu/v0cDJtrYHIRaIKna9KrOqr9dOJ5e/yobwGhAHH2KR1t2xS/LQnXUOjDT7aRKVkHUQEzk
	dn0iESnH8nsHOuluunlw1xR/zI3a6Bx8J1QaupE2AotDfxh5KPrDL2+qTsXk4zJR9PM0=
X-Received: by 2002:a05:6000:22c2:b0:3d1:3e8b:8b52 with SMTP id ffacd0b85a97d-3d1dcb73cf0mr6297558f8f.15.1756728614533;
        Mon, 01 Sep 2025 05:10:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUuPPsoc/niYWjw+mfZypvoo0ikYAMhz1Ycnbh8MYmPHmsIbLxd23gm7XjD6ilWcDbpxg96A==
X-Received: by 2002:a05:6000:22c2:b0:3d1:3e8b:8b52 with SMTP id ffacd0b85a97d-3d1dcb73cf0mr6297536f8f.15.1756728614138;
        Mon, 01 Sep 2025 05:10:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8525a94bsm105459755e9.15.2025.09.01.05.10.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 05:10:13 -0700 (PDT)
Message-ID: <64d270e9-e54e-4b8a-855a-07932a9a884c@redhat.com>
Date: Mon, 1 Sep 2025 14:10:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH kvm-next 1/1] KVM: guest_memfd: Inline
 kvm_gmem_get_index() and misc cleanups
To: Shivank Garg <shivankg@amd.com>, pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-coco@lists.linux.dev
References: <20250901051532.207874-3-shivankg@amd.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901051532.207874-3-shivankg@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 07:15, Shivank Garg wrote:
> Move kvm_gmem_get_index() to the top of the file and mark it inline.

The marking of "inline" is not really required. A modern compiler can 
figure itself out that there is benefit in just inlining it.

I would rephrase the subject as

"KVM: guest_memfd: use kvm_gmem_get_index() in more places and smaller
  cleanups"

> 
> Also clean up __kvm_gmem_get_pfn() by deferring gmem variable
> declaration until after the file pointer check, avoiding unnecessary
> initialization.

The compiler will figure that out. It's rather "No need to initialize 
'gmem' in __kvm_gmem_get_pfn() because we are already initializing it a 
second time, before using it."

However, I would rather drop the "gmem = file->private_data;" instead, 
because the compiler will optimize this either way.

-- 
Cheers

David / dhildenb


