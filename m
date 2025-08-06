Return-Path: <linux-kernel+bounces-757471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EAAB1C283
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 10:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D54D7A513D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 08:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB558289345;
	Wed,  6 Aug 2025 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIbSB7mw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93CC288C9F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754470581; cv=none; b=fwsx40acuQ4CigbAU/KpgFH31fVS4hAXqo80NX5woaFNC3Nco5K5IrlO9P7geg732DMeQVgSvEUYBmLU3KHiBfxMb0RMb9z4O/me6AoZnZfs4H/2nEs//6JKl/3QpJs1yK4eQwk4taN3ZyQWsgqyAh9rWPr2YU3bQppgQ5VSlLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754470581; c=relaxed/simple;
	bh=pfURzHnn1+hUwaHL71seyn3Y9v5pg1Kic5w/SFwGdqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fDMyruH672FxG71aIgPeJ8bAcODtci9MTsS4AhCr1cpNKkvtCRxjUugSyESGPVIDL0U1r2uFih2/kcV91dgmvlTGoExRLj1DaRA01dtPbdCkt5SXQcpLzDZhAc+xFDhrzKy03iRYmrPAxCCWaueqzXImec2RvNpPc/aW4m8Xndg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bIbSB7mw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754470578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ligMKuzMymYT6q7hFg+L6jC/QWTmCs2aLfpugFK2uvY=;
	b=bIbSB7mw3zN+QM1HIISGlqAe1ktCAfxLnyWig8gLAlvIzfoFxo90LHqsZwa7uZe65BBAbG
	mRSU0+MVFcwwY08ERM+zj04yMBXZV/OTtXvnvmxop6bjRhEduY59XD3ZRaBzVsdGOJKG0s
	MfG137Zx76xSKeRFtS0oytLlo2xuqDk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-VEJidIntMJGLLWPEyCW24A-1; Wed, 06 Aug 2025 04:56:17 -0400
X-MC-Unique: VEJidIntMJGLLWPEyCW24A-1
X-Mimecast-MFC-AGG-ID: VEJidIntMJGLLWPEyCW24A_1754470576
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b8d62a680bso399899f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 01:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754470576; x=1755075376;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ligMKuzMymYT6q7hFg+L6jC/QWTmCs2aLfpugFK2uvY=;
        b=HCjRPyOU6F8F9qXujJEbtCL8iPaDl+xSS6kt7Rs1Ud7HSytSPNq2B4GSx3EJO3O3dI
         maNYLYUp2MwKjYWFysFWWafYrIw0aEPgz9rzblp/+tg5fLNUS11Bb2tsTnMbmILNIh4h
         mvUaoIMMbLbW91zUU0VSQ4gLr97G2q1VlKjKugESdMztj+pOdVcDVBYNo2LqauTUQfbH
         qyTi1rJbHDuGQAzdEJMxJd3FqwEQda2BrR1CZrrwi1V26b1lGESb8thIAh/yIeyeRFPS
         xCz3QSVT0BvabADv+himWOo9rhVnAzzzTuZTdBixo6eq2yzMa9PBGIVMi5mKW/BeYP9d
         oRuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkUy+/b/SGkAv4kIjWOPuHSvuNEZxKuRchL9iXZoMzbbrJkVb/08mnhsE8DGJxdFkKCjCgW+3NRmwgbU4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4COk6FFdWbgxCKaHwt9ehLumumJjPZ7QypuC9OnYeNjDHAlPa
	KXbsvYPQbeOb7YuTe7LWcUy6+mwHHA5zWu24QIJPBgiFQe7nrMgQ+J/zTiP46+DAGWUjwdkQ/bP
	HOkNB4FrwtCXJWFFUX5P2a21gONA310CT8pr565yWIG4/OcTWbcd4RubIsnlec6OdIw==
X-Gm-Gg: ASbGnct+9l2Z5ud9+BRZvpoGjX/odpJA1Uz025xByYX+TREza942G7nj6FGk2Rlcouc
	zEdH/0MICe2TAD9XZOtZNcBnacNM5ntvbXDuFtPuzdcteFcco9c39ZM/MAMt/CMyIdjjb8Rjy6j
	wh8YeScZWmusVWwJgPb1QzHh6OmRlRAKXBCvnHkgBvZYpDpowYNzNgHOCwfWYaRznowcdpEM7Xf
	en/O+MGimE7a3nTSRtKw058O/tJHNPo2t5QBB5vdbLgSvSm4OASj1+hfVpz0qGFmGN0fW23W9kX
	TlvwXGQG+hu+6wWe/f5zY23jwoHja8Nl8CoHMndimFJ0xHqyoeNLYNWkPZjfzUxCEcBbpt8K2UC
	nnZpTI0WnQRC8/ok9roJfbjsnhaBcCAeERzCegp3wcbD7Nl0BCh+yl72dITzJz+5YiSs=
X-Received: by 2002:a05:6000:1a8f:b0:3b8:d25e:f480 with SMTP id ffacd0b85a97d-3b8f43723femr1567471f8f.29.1754470576135;
        Wed, 06 Aug 2025 01:56:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4JMRKLdw3mXUV5OuDO/tBpecNu9HjGvZkP0QMVtkPkAWZcsAuNEwVje9OMdBe9DlC7UE48w==
X-Received: by 2002:a05:6000:1a8f:b0:3b8:d25e:f480 with SMTP id ffacd0b85a97d-3b8f43723femr1567434f8f.29.1754470575683;
        Wed, 06 Aug 2025 01:56:15 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f35:8a00:42f7:2657:34cc:a51f? (p200300d82f358a0042f7265734cca51f.dip0.t-ipconnect.de. [2003:d8:2f35:8a00:42f7:2657:34cc:a51f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c466838sm23317600f8f.49.2025.08.06.01.56.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 01:56:14 -0700 (PDT)
Message-ID: <4e6e0492-f2f3-44d8-ad02-084a47c9fa4b@redhat.com>
Date: Wed, 6 Aug 2025 10:56:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] mm: Optimize mprotect() by PTE batching
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org
Cc: ryan.roberts@arm.com, willy@infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz,
 jannh@google.com, anshuman.khandual@arm.com, peterx@redhat.com,
 joey.gouly@arm.com, ioworker0@gmail.com, baohua@kernel.org,
 kevin.brodsky@arm.com, quic_zhenhuah@quicinc.com,
 christophe.leroy@csgroup.eu, yangyicong@hisilicon.com,
 linux-arm-kernel@lists.infradead.org, hughd@google.com,
 yang@os.amperecomputing.com, ziy@nvidia.com
References: <20250718090244.21092-1-dev.jain@arm.com>
 <20250718090244.21092-7-dev.jain@arm.com>
 <7567c594-7588-49e0-8b09-2a591181b24d@redhat.com>
 <a2fdcb87-9223-4091-8bda-9d9316c84cf4@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <a2fdcb87-9223-4091-8bda-9d9316c84cf4@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


>> While staring at this:
>>
>> Very broken indentation.
> 
> Indeed, but then in order to fix the indentation if we start positioning
> 
> every argument just below the opening bracket then it will take at least
> four lines :)

You are allowed to use more than 80 chars if there is good reason :)

-- 
Cheers,

David / dhildenb


