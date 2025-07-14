Return-Path: <linux-kernel+bounces-730238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6023B041B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7B2E17BC6D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E275323815D;
	Mon, 14 Jul 2025 14:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K+MP5x39"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE58911CBA
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752503494; cv=none; b=eEAtPuN0DlTDZunkJAH7d4SOc5hY0VdyoP6/vgVBED6AKeKK/4qEwaE4wpY5vsPW+aJOKfaiwtM03qEgTP5pcw/9aY35Lu/YK/OscndtNZPKW+Cs45nce6x3CGTf/u00j2HJ+WAxC30iElaCGSKXTxOzUVWrmZtKIpX4gSClJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752503494; c=relaxed/simple;
	bh=wRM/SE7/9tB9XcMezLr3TGZA4VE4qPB9mN9iJbtqtLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tXLj2dJgPMBUgEMGca6ktT2KPdXoCsnR9pCBT+wn5RYv5CODZ1+mp5SmHrxQtp+viDrMlin0KelUa0Z29b6bkFUJMj7tNlX5xD8nGQzN54Zoejr9+93+cQlTMztVvz2MWkIiSxUZOGEM/JdDoU+ZYvVJupQOlnY+nk6duyhltEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K+MP5x39; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752503491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKnj2tl6JvA6a9IRkfdn9/MC8uWt0oKSKah0TqYXd8I=;
	b=K+MP5x39tpSm7qYsxb5GzeOHCZU7H6HLjQJn0zwPFmAJ4iBEwiOkEWQ5cIViat7Z1E0ZLM
	A0zE+k3soFaYCRA7Mu+tDPwsWDEs486dcGZU7dqMSBPUSV6VcQ3Y2Pp5cumVsPWYMEKI36
	r+3TNb2ZFN/Td7kXlyxs7tctwCnrjMY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-OKi6N6arNIqK1rGYaam7PA-1; Mon, 14 Jul 2025 10:31:29 -0400
X-MC-Unique: OKi6N6arNIqK1rGYaam7PA-1
X-Mimecast-MFC-AGG-ID: OKi6N6arNIqK1rGYaam7PA_1752503488
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4560a30a793so8695025e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:31:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752503488; x=1753108288;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oKnj2tl6JvA6a9IRkfdn9/MC8uWt0oKSKah0TqYXd8I=;
        b=L+M78ybGOPMb1Hksx/1B1+WupR3BRlSdsZ4LOkfrDdmJ0xdzzZkuh+Cvp7etwF825y
         B+8vAYO0AI5yGLdH16KhZF8/Uq4/SS/xXjqDcJ0plyZes19zqeuDnHT0QWvQ7cTdXFmH
         +/3Ve0cnqA5ikkHz+3kg3YiI5t/HzjgTLc0ULe6exu5uZHanKcg3UG3Ga0h6Svd27huY
         y+vMAxNmlwybTHvOOYpKszny8/xVPK/qkUlsbsn7UVEaXsd5BnHBCoYRIoeRONdDUYYy
         0HVYj9Jrju2JHee2tnjCuQ2tSFkqrLMWSb2zzAg01KWFzK+nmqPGlXii6D++VVlJeV4R
         wLsA==
X-Forwarded-Encrypted: i=1; AJvYcCU68hHV6ZxBma32LK0S+YLcTw+14j5RbJeJrAV83GEyVGE0fOf+l9ergIw3tajBxtqhlOnhICmkRkYsxdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu+SifmVggFlDUvfFIaA6obTSpZf6ApLEpwyL0wHaBEheogFJd
	yDxONC09k6oRg1dqnJcM6tr4vmRKoMJzhb7JGPxp9U1ZUa0LXi5YoyBuKcEROgnIej6423ZDGWf
	6b/XQifoDSxwceRi9b29w3W+MEtpLQJ9z8Pq2TPsPzJzPaf7BH8NYIhXVrlN4g2l1NQ==
X-Gm-Gg: ASbGncvkAfoZWec24+5exF0HLwMyoeL+vXntTXU7n4KKe5xPZDZFiuhT2pgPH4HlrOV
	X5UyLBIg6mr6QIS/AktH2DlkVkEEj9l4Taz0GtFF8Mz7zPdHVeq7KYjRWXaJ/sshP9c7GG/bR1Q
	4V93HHgw2k+XdJiZe9YD1NLANwUNmBPT0rs78BdCXVUwXZHsDgbFPgfJvdS4r1PZ17A+JNBvRAL
	6DnJ+ph3npGp5YBSJ2XtARi1vrlTpY9tKxmsyc8rvII0GFXRLatXtc8hZx1dpLVDpYKELZOdjIh
	KK1WtWE5v63CfTzzRVkM667S+VE0F7gFrvWVfBbXCZ+qTqyMQOEcuGIbOuu1KkKPq8pVYZ6tSSM
	tTWuuKw3iX4Ni+e9mF/wEzXSEFpoREJb9oYgfoQyeI2iTejOPCzZoVu5D7jvHM0xZ
X-Received: by 2002:a05:600c:1d96:b0:456:23aa:8c8 with SMTP id 5b1f17b1804b1-45623aa0f4fmr11266055e9.13.1752503486550;
        Mon, 14 Jul 2025 07:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+g9KaAKen7SAS0+dPdQpmJCwnrVvw6jjaHTCfr2Ht5/VOONYOcr0O6b41a3ZTS3wmqn4Z1w==
X-Received: by 2002:a05:600c:1d96:b0:456:23aa:8c8 with SMTP id 5b1f17b1804b1-45623aa0f4fmr11264045e9.13.1752503484596;
        Mon, 14 Jul 2025 07:31:24 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f38:ca00:ca3a:83da:653e:234? (p200300d82f38ca00ca3a83da653e0234.dip0.t-ipconnect.de. [2003:d8:2f38:ca00:ca3a:83da:653e:234])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0d70csm12790157f8f.62.2025.07.14.07.31.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 07:31:23 -0700 (PDT)
Message-ID: <0987e53e-3fd7-4e6c-847d-f7ad935c41f2@redhat.com>
Date: Mon, 14 Jul 2025 16:31:22 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] mm/mseal: always define VM_SEALED
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jeff Xu <jeffxu@chromium.org>
References: <cover.1752497324.git.lorenzo.stoakes@oracle.com>
 <f6dd43a1111677145b815b31bca8a04db0862c53.1752497324.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Organization: Red Hat
In-Reply-To: <f6dd43a1111677145b815b31bca8a04db0862c53.1752497324.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14.07.25 15:00, Lorenzo Stoakes wrote:
> There is no reason to treat VM_SEALED in a special way, in each other case
> in which a VMA flag is unavailable due to configuration, we simply assign
> that flag to VM_NONE, make VM_SEALED consistent with all other VMA flags in
> this respect.
> 
> Additionally, use the next available bit for VM_SEALED, 42, rather than
> arbitrarily putting it at 63 and update the declaration to match all other
> VMA flags.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


