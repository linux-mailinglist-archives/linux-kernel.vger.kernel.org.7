Return-Path: <linux-kernel+bounces-842752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E89BBD769
	for <lists+linux-kernel@lfdr.de>; Mon, 06 Oct 2025 11:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B1133B2494
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Oct 2025 09:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8770F1F3FE2;
	Mon,  6 Oct 2025 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vd3LG8tT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7251F131A
	for <linux-kernel@vger.kernel.org>; Mon,  6 Oct 2025 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759743528; cv=none; b=Zdo5fszRpRe++EvBdtX7ua7sh//bHt2lfa2cv6L9OAsRM9AdAJ5CchviqtkVmPc2yMNz0ez9Oa1FBwGWMXIu+SmCDOmhd38PfyRLDY/jG1qpsJAleCSqncGTuYnzUnAwLj1ZYBFU+uWQsBEHsGo8F9QaLp/6+ojzjd82p4BT4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759743528; c=relaxed/simple;
	bh=qnrXCk1erDfuPsdQukvOAOXJBiCqo8Vwezl61cw0KN4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WLRj4BOhXcgBPRQkDrer3dtDty3ftPdI4hHrwjezR/I1zjGQZO/QnmjRWlW6KIQ+lKG7F0klPr6JIK1bcBrzw/PBunTNn6kS+W2LnM7olHUZt0LbvZHDTqSoM5z9+p3w+laN7976Qs6UH+8S+Oi6wMlKl8lTMb/yEDm4S+sCn/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vd3LG8tT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759743526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=S778EcOwu4vfuWOJY2mnN8fiVuQl9UxyQh8QCZUHwJg=;
	b=Vd3LG8tTEWMsadd8exBJgtygHsRYEFKLr8ywqZpxH+4C5/MMYdqkeI6mGqreT/V6XpRzgH
	7V8zuJgFWI0Y2rPxwlP4rQFuT8GtrEaUpw8w0+kB+fW8djTVv8oXT7UHgtWenUzyjbFD6B
	IRtpC+xIPqbJsOLL3Ep/UTicigyhT04=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-Sg5tS5JRM_KMB9asi4Igaw-1; Mon, 06 Oct 2025 05:38:41 -0400
X-MC-Unique: Sg5tS5JRM_KMB9asi4Igaw-1
X-Mimecast-MFC-AGG-ID: Sg5tS5JRM_KMB9asi4Igaw_1759743520
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e502a37cdso32217665e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Oct 2025 02:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759743520; x=1760348320;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S778EcOwu4vfuWOJY2mnN8fiVuQl9UxyQh8QCZUHwJg=;
        b=mzgy0Um8nU5tO51aPEsLYwFBrKDiGY6kJ+1JIsSFGCJoYTYGIc0ighF/GQhFcbidzO
         IfVxBiEUNHEilvVGnWyT97g9Jcnu10vy7qB8Eaun2jRXPSBkELSqRW+l9+ZEvCaAGTYJ
         iRLfiWObCSarrCTTl2a1ZJomOVGpVsHqU4WOXy+0KSm6c2Y4K5Dk7wmkXZ9JAFIQig3d
         Cq5PL5JcuQSeQECho0w5HhRVib0O+EAaGuETJw4q5/bosoARy6smdASx/EgpXl82cRSa
         54Tx7xSf0/2eXAySYRmWUtK5VlQgrCCcD7p5pI3KQMu4F5mtmcwtBHyRJpuBmrsnEKOt
         7xUQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7KH1WusI5GvqZxDEOTiGKRdnF2wVZo9SDDahOKD3KLu9BdNQP1GH3J0xOYLImalMqm8MIxtm2aSj6frI=@vger.kernel.org
X-Gm-Message-State: AOJu0YziFq9qPOL7m6AOR3C12rOAAVTfKSRQFD9qI55ZUVtRQIeSXO1P
	NxPubu43M+86970FBni+wB5xyuASCpaMsLWHCjJ53NSBKWOBAxt1lUm2lTCshuDm3MHw+llimWZ
	geHTrWdiDQMqrekQnJZ40UDfcXdljNH6SApRqM2RKKEUsTZyNxCb6brwlVJwoh/9t5w==
X-Gm-Gg: ASbGncvUMsCFQ8iQi6joSd4hUNUnjmzw0AVVqzi+Wf4EI/0hR6bMf7fYJPYgvPmMgaJ
	yY1v0qcXrdWbugis2Gr0tzOpsW4YLdg6hrsfdUS+wFAm8iwvbUW6KUpQxWJSv2UFUN3pv7shlnY
	m/J9TFIyP0lUsyevB+bHRHmDPBY1xT0S2W8Lqn3A3zP9v5J16srqzKNtpEq0RKqp9XvzMg30N4G
	OvB/wVwGcLtXFcS0POnkM8sPdPqkgLVvVuh0fVdVjsmWZa9IHK3lRrEoD+hYavFx6EcazrmsOVb
	l8ZCIMta62vHT1piwavgOUZCh4v9tzf0eVSl+gnaCyp0DmKBCdd8Nf1i5OX5A/7hI2TnDb5Vilu
	rr1IuiXEw
X-Received: by 2002:a05:600c:4fd3:b0:46e:477a:16cc with SMTP id 5b1f17b1804b1-46e7113ebe5mr85456275e9.24.1759743520366;
        Mon, 06 Oct 2025 02:38:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM7OAxHoyOGk3NDN2YecoVvGgjn5cjalQKALBocWZeZM1YsBnGlW1kvLUy1HZOfdNvBaUkxA==
X-Received: by 2002:a05:600c:4fd3:b0:46e:477a:16cc with SMTP id 5b1f17b1804b1-46e7113ebe5mr85456135e9.24.1759743520030;
        Mon, 06 Oct 2025 02:38:40 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-110.customers.d1-online.com. [80.187.83.110])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e5c4dd9e4sm137515865e9.10.2025.10.06.02.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 02:38:39 -0700 (PDT)
Message-ID: <99564dc2-f3b5-46b1-a755-25d73598516d@redhat.com>
Date: Mon, 6 Oct 2025 11:38:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [arm?] WARNING in copy_highpage
From: David Hildenbrand <david@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
 syzbot <syzbot+d1974fc28545a3e6218b@syzkaller.appspotmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, will@kernel.org,
 Kefeng Wang <wangkefeng.wang@huawei.com>
References: <68dda1ae.a00a0220.102ee.0065.GAE@google.com>
 <aOACSWYIOD3llWnj@arm.com> <7af02ceb-563a-4bad-84ee-620aaa513bed@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <7af02ceb-563a-4bad-84ee-620aaa513bed@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> 
> The most reliable way would be to un-tag in case folio_mc_copy succeeded
> but __folio_migrate_mapping() failed.
> 
> I'm also wondering whether we can simply perform the copy after the
> __folio_migrate_mapping() call: the src folio is locked and unmapped,
> nobody can really modify it. Same for the dst folio.

Answering that myself: obviously we don't want to fail after migrating 
the mapping, that is more expensive to recover from.

And I think that also explains how commit 060913999d7a ("mm: migrate: 
support poisoned recover from migrate folio") likely introduced the 
issue by moving the copy.

CCing Kefeng

-- 
Cheers

David / dhildenb


