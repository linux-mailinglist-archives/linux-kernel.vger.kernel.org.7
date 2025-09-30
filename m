Return-Path: <linux-kernel+bounces-837467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9479DBAC60E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 11:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14B87482B84
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA6C2F7AB4;
	Tue, 30 Sep 2025 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WoZnNigI"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44A62F5316
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 09:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759226235; cv=none; b=Tuqib2cvhAT5VySfHMPxqX6CMKJmR7KaXhSqS9QMeS5ynq+MuiKoayTkdbu8x6g5top3HyyQ0C9TNo1+ZfnWbaVxopDxeEQwS/uJewLZnMvBMxJut8YE3tH4s/tF+9RvPcmIAjOGTE2R7EEwefkZrp6nFBNCAPEYZmt/sHjkMMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759226235; c=relaxed/simple;
	bh=Iby0dCV1k5FoMaSlf23PqKFSrLsu46FnHbptNvkg3QU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=um6oEgGwdwPrHaujCoicZKdzXfvDugPr2SzHANbQbmjId33hDn+4BCnTWMZ72szI6pg5eIngj3U6Ot3YePvLFsZzDDpDCTRA9uUoIH3n6QylGN+ErGt4EszmL/QN006Rd6DlYyUOEXfU4AsWokGT6hUjn/L9GsUnMYDkh5NKKr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WoZnNigI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759226232;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=srAu9efQeLkOrSNZBhuxJ9qVZjhUw1Qf2FT+xE0jzg8=;
	b=WoZnNigIx7hI+z5mdBPkrjlB/PRC1MhFZ6OebiAyMBCjIFuCWoIfcjtci4OPsDDXkxssMF
	d9qdh11eV6T+hCCNOzoH6eLMjsCtc0yGMMQ+NH7QWOBCm2o2LCnIaOVwJT5odXYx401ZkX
	Jvi79o9Cj9mCIbFyWyK0gD4tL9vXfz4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-7UWkGUZePByXxjGQmw2tBg-1; Tue, 30 Sep 2025 05:57:11 -0400
X-MC-Unique: 7UWkGUZePByXxjGQmw2tBg-1
X-Mimecast-MFC-AGG-ID: 7UWkGUZePByXxjGQmw2tBg_1759226230
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f44000639fso4245439f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 02:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759226229; x=1759831029;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=srAu9efQeLkOrSNZBhuxJ9qVZjhUw1Qf2FT+xE0jzg8=;
        b=OPlylXoJEWpaDO89qYqWv9tCtbbdwM2z8kgR5P8jY5gq59y+OvtGe4MCk6nnEn8ybq
         a+3WroBpENlPP2iGHRyUMHl2URZdK0802VP+VB9fAiFoOK5wh0fD1jDfc1INQSzdLLr4
         fSgxdNkesNqyDIUW22sCT/GYz7YPf7II+6mLWrxMt3/5E4gZF3cQDYbmh+vjDLRmuKo4
         2InBI+gdsv3mryXjs4AexzVGljg2y1q6KN2LORETdCLz9HKX2sv19Xw2jhkwLgOHJuLH
         D3coE+XhuCL49bzW4tum6xf23G+/K9/FomQ/RWwXXW+GDjVGc0bLGLBn8bkjv4ys2XDf
         JMRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSi+Sw9fDPi38vimMmzOeoOQgzXfi9z8buFQ1436/q1bJHmXeWT+e7kPM0rRiwJuySfUNwLXY6biKP4FI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXJhnDYFx6n5Nzwy0qFtJ2/ZgGth9GPMCt9Hm0qkT2miOBWGmW
	fVLUJpIYK3GwnqFqUusIHrc+C/4uE1VcVxbthK1A88evrnU2A8huGPM663ixHeiWHGLFJPaaZuL
	plGlFOz2pLOIzJK6sQpNFNO1jqHE2gRqsLPG0Dy/KGgjV1AuktcqAlsB0g//1vNViKenolTzd1w
	==
X-Gm-Gg: ASbGncslisPKLIQE8/WjsHJPk0+auCBxXvWeAAC+Q2uTbdRt32W93Twwtrx2hhP0UQB
	6Rl3uj9vHCsjHpgzx6rPKB4u1Fxfl7naz180VFSfUAoyclOcrWTAGvSgPKUiSL3TWmQDUHoCE7b
	zx2Rw7oYJYlSJkEIsD+oXdnJ7RJrbwR91NyJQ2UJwHSUFX9iVM7sztd4M92HxfkrX2H1xOucQec
	FbF94KKkXo9tNxfLyNHMK7rkWdccXO48s7TAjkNbXyaX/U9pqp8nX3AzGt7bgvehnH3BAhN0pQS
	giLserH/Ttc35cPPq6+sQ4BW3finVvMApOvlWqre5Ksjqj93yfqd6iP7N2+YcbwbQ6vre7fAmLv
	rrp8lF86xwcJBJFAE1w==
X-Received: by 2002:adf:eb8f:0:b0:3e2:4a3e:d3e5 with SMTP id ffacd0b85a97d-41358755409mr11327883f8f.22.1759226229585;
        Tue, 30 Sep 2025 02:57:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRvdEuxPGd1K1hL6v0AssJUCVO28oQVmR6eHnpL1I8WvLYCEWr5PTILGebhv46wh47Za/SKg==
X-Received: by 2002:adf:eb8f:0:b0:3e2:4a3e:d3e5 with SMTP id ffacd0b85a97d-41358755409mr11327863f8f.22.1759226229159;
        Tue, 30 Sep 2025 02:57:09 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb8811946sm21856303f8f.18.2025.09.30.02.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 02:57:08 -0700 (PDT)
Message-ID: <65e53548-2d68-464a-87bd-909f360cdb1c@redhat.com>
Date: Tue, 30 Sep 2025 11:57:07 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: wan: hd64572: validate RX length before skb
 allocation and copy
To: Guangshuo Li <lgs201920130244@gmail.com>, Krzysztof Halasa
 <khc@pm.waw.pl>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250926104941.1990062-1-lgs201920130244@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250926104941.1990062-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/26/25 12:49 PM, Guangshuo Li wrote:
> The driver trusts the RX descriptor length and uses it directly for
> dev_alloc_skb(), memcpy_fromio(), and skb_put() without any bounds
> checking. If the descriptor gets corrupted or otherwise contains an
> invalid value, 

Why/how? Is the H/W known to corrupt the descriptors? If so please point
that out in the commit message.
Otherwise, if this is intended to protect vs generic memory corruption
inside the kernel caused by S/W bug, please look for such corruption
root cause instead.

Thanks,

Paolo


