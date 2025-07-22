Return-Path: <linux-kernel+bounces-740928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27DD2B0DB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 15:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18390564558
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 13:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F872EA15E;
	Tue, 22 Jul 2025 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFMNypG3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADEB2E2F10
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192230; cv=none; b=uUS5dhPXPd5Es5VUiNH7iWAvpdxtvmS7YQJB/6YiAId6GM2rHPrp7cELixpDxN/TmiZt09ORomu544aEAtF3oRUs49lOEhRAwuhd6Du6Ddb61YFo9Xm1dEdIOm2egv2Pni2sQsSSdCQTyMWyXfPqUOd9/4t4bFtW8cMXQt3xKHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192230; c=relaxed/simple;
	bh=RQbcnlWGP6V5wy6qjXNxQRCHv0RUROtoTySzgyd8MR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=raRBg8N5sMgjetpS1WGHonDOHhp0JEDVjkoD1Z8tnM4dYtrBTvVhxiA+CLXoVoh6jRuoWaxgnHk+0IRuCZD/Fastf4caDIn3We80HWtYFpMnDQbC2eVcH2mgw8/RxFkRnA2qUxKSGkqEJ5WVqHBxpubY2gTtqfl/JBaNGxfPq8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFMNypG3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753192227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WdHT8CtONaVphfpJj/BW4Ev2eTZhAnTXe9T1K8uXeEk=;
	b=RFMNypG3FMq+qerHcB97d4M7o1DTu6yNQCmIgihnhQq2KBZsU3nXgY5+KvIPjceC3e5A03
	5SOPUvgFwjD4nMp6/UDcDjCqOhrnEGKIkhPOZmhdTNzAoK6AyQYkRiTYdny4FLv8xIQmmo
	ab+mY1LqlobzxR1Jh+2UtqrbDXD6M6s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-MogOM3GEMYu8oGrsrBPcrQ-1; Tue, 22 Jul 2025 09:50:26 -0400
X-MC-Unique: MogOM3GEMYu8oGrsrBPcrQ-1
X-Mimecast-MFC-AGG-ID: MogOM3GEMYu8oGrsrBPcrQ_1753192225
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ade6db50b9cso557424966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 06:50:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192225; x=1753797025;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WdHT8CtONaVphfpJj/BW4Ev2eTZhAnTXe9T1K8uXeEk=;
        b=GOGc/09OEL5K1tBFWUJ3KNTX5C+5gy8bYfsJZWkQgn8ZzWoReU90W9l7NYamOcFXfm
         LV768ygnYmLnJdfQk378NHyMCCnvoOKOakYD4nleOldkiNk4rJ3x2lCs4mNnp9AZe56t
         sngCB945Ky6PVGfswy8FMxhEGwSPBdveGqLRWXk3dg1CjzfgocSCzGVW3NMlBwcMG44d
         SlTRGeUR5MWaRHSGAghYmNFNv0c/IgIY75OFU64RW2NAUboVS6NLq/FNZyGej1btR57J
         PMgEnMbaQ3YNVzR5JUN32rVBJYTMnbNGXgELsV1auKUky3O6G4LNKN6fP7peKLlOHXne
         IRgw==
X-Forwarded-Encrypted: i=1; AJvYcCUcDYEZbPb4yVkpy28YqsagZp3AdDPHj6DON5gVjr3DyIHqefZvCbWkyme7YP4YeQ8oTOpjp0qeTUIWMHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVN+20NICxDNbO3cvbElMlUqWypOAZBCMOTvF6ct6FiwI6uDrQ
	1Vc/wiwS1yAKlpHsruJgWFcESx89J98TCsZKueK6mQTyU2nGZC6lmBZddkihmv2+1UJm5xa68LL
	N2yHnsWnBGkeIC6gtFY/DdBgZBwEIf2IDuHaayv9d8xYBU+KXVu0ORx9iWZwfgkMvCQ==
X-Gm-Gg: ASbGncsvKSHNdPWUvFIIiD4WldQ70X60BzApXoe4RLgwgUKLVaYJf5JM6ZK1CjPJ2n7
	cSTolfbhcWNl0jbvQzsNI1WqvzFiIXje5roP7w2wsILq6AAUCTAPip5hnZmGVvGeYD03XhW+mKS
	SWfL7KAVU9H/XfNopaHkgLCFZmcA9UbcRn6p0bEDCNgDdbRbxIFP87HKioTdPgquETNUvZ+Ojio
	/fWGo02UbDb5QxZIEvl5JLOEHikNXhBzyj6Gbsyrp42DIg9nLb7hLPmyAKJ8EwmHgx92zcVk6ZN
	DJufQ38rYV3hRzkCqfWAfnUnUb7uSoxTS+78GxuG
X-Received: by 2002:a17:906:c116:b0:ade:9b52:4cc0 with SMTP id a640c23a62f3a-ae9c9a109c7mr2746566966b.26.1753192224207;
        Tue, 22 Jul 2025 06:50:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1ILYMFsN5eCfd6Ulv80xtZFr7V6UTvP9mFdjZbbNdAXDhXBW5hW5Hy6S/RrUXYDsK4I00OQ==
X-Received: by 2002:a17:906:c116:b0:ade:9b52:4cc0 with SMTP id a640c23a62f3a-ae9c9a109c7mr2746562766b.26.1753192223108;
        Tue, 22 Jul 2025 06:50:23 -0700 (PDT)
Received: from [192.168.1.84] ([93.56.169.94])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-aec6cab5f53sm873458966b.136.2025.07.22.06.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 06:50:22 -0700 (PDT)
Message-ID: <20f12925-1c9c-4da7-b6b5-a0e9d4125c99@redhat.com>
Date: Tue, 22 Jul 2025 15:50:20 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] TDX host: kexec/kdump support
To: Kai Huang <kai.huang@intel.com>, dave.hansen@intel.com, bp@alien8.de,
 tglx@linutronix.de, peterz@infradead.org, mingo@redhat.com, hpa@zytor.com,
 thomas.lendacky@amd.com
Cc: x86@kernel.org, kas@kernel.org, rick.p.edgecombe@intel.com,
 dwmw@amazon.co.uk, linux-kernel@vger.kernel.org, seanjc@google.com,
 kvm@vger.kernel.org, reinette.chatre@intel.com, isaku.yamahata@intel.com,
 dan.j.williams@intel.com, ashish.kalra@amd.com, nik.borisov@suse.com,
 chao.gao@intel.com, sagis@google.com
References: <cover.1752730040.git.kai.huang@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <cover.1752730040.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/17/25 23:46, Kai Huang wrote:
> This series is the latest attempt to support kexec on TDX host following
> Dave's suggestion to use a percpu boolean to control WBINVD during
> kexec.
> 
> Hi Boris/Tom,
> 
> As requested, I added the first patch to cleanup the last two 'unsigned
> int' parameters of the relocate_kernel() into one 'unsigned int' and pass
> flags instead.  The patch 2 (patch 1 in v3) also gets updated based on
> that.  Would you help to review?  Thanks.
> 
> I tested that both normal kexec and preserve_context kexec works (using
> the tools/testing/selftests/kexec/test_kexec_jump.sh).  But I don't have
> SME capable machine to test.
> 
> Hi Tom, I added your Reviewed-by and Tested-by in the patch 2 anyway
> since I believe the change is trivial and straightforward).  But due to
> the cleanup patch, I appreciate if you can help to test the first two
> patches again.  Thanks a lot!

I guess we're just waiting for a v5 with testb and an augmented comment 
in patch 1?

(Frankly, I am not sure I see any improvement with respect to v3.  When 
assembly is involved, what looks like a cleanup can make register usage 
more messy.  But since the code is there, I'm not going to ask Kai or 
anyone else to do anything).

Paolo


