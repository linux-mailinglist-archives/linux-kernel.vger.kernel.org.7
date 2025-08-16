Return-Path: <linux-kernel+bounces-771760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC081B28B3A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 08:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8AD5A0CD0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 06:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01E221D011;
	Sat, 16 Aug 2025 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QyS5GcZ+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECB73176F0
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 06:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755327477; cv=none; b=Vegip9DNzMJi4HXmlO6tSayfXnSyyWvzTmsBMLCkm6SWbGY9Pktc1MppVJo6qqvDicdPBQf0U7uGdACECdinvcLAhnaVOljsSDax1ccsKpVxx3cSCFVguAE3Jmewp/JZNCwiASc5adShXKhoqTNzBwiMq2eXGhEonvVknyfGMYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755327477; c=relaxed/simple;
	bh=4ya+ORsQ8cX9UsCUqnb33v3ZqeBVAQam2G3ncNO2MRo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2wf90QsdW7s+qnNkfGpCGD3ama+kzMvgcQv0NmOOlkOsuvLHR/2NoV6ToGG5dn0iMNhfr27q4DD3BWdDYAoUeUdfhlcDnJQNNRWymNzL9edA0JYs0Vase7YNNP2dSPyA10YflU3EblXzeTue2UioNXAryO9fqLeLm2Iz9ruJAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QyS5GcZ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755327474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=wg8wKLsgD4C0qASoGGdbCBpxEg9XbKTfPdSgvDSrnxY=;
	b=QyS5GcZ+Yn1CQM/JNbBUnhzNWVvz3ejYb/gle8hAtYEb1lWKY32ly5ib3kKDoZF2Mo+0mi
	uytKh+KuwOkVkY3ryBIZZ48x/xkQ7QeSTCDaB0YxdvJ3u6H+DuOVJV7ZWpFCewpus+dLqO
	xHjHRPIz/Wwa/ZA3JVHnUJVXcfzhSMc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-DjyLGzGQPO6yoevr3iLT_A-1; Sat, 16 Aug 2025 02:57:52 -0400
X-MC-Unique: DjyLGzGQPO6yoevr3iLT_A-1
X-Mimecast-MFC-AGG-ID: DjyLGzGQPO6yoevr3iLT_A_1755327471
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b9edf2d82dso1313407f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 23:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755327471; x=1755932271;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wg8wKLsgD4C0qASoGGdbCBpxEg9XbKTfPdSgvDSrnxY=;
        b=exKjnVHqGzCbUt0UJ8/B0SfZebR1gP6wW+CRLCav7ZTdlgovbUsc3nsXCYCDEBNO1O
         4s/dRKMY+FuSdzWONtM6xAoVayk91F2zEZrSW6gAm7uPCLHMUvNtg9JQsiribNGEhvfa
         AcrY3DN+raRmu24+nqbZ7jPSfSFjEnobvvDp7z+rYKlrrXlkRjvcZ2DG80l3otrBPMkS
         i3E15aNiFAV9ZEMqUo5XbUxupApsJ+qlbnUKLo5D7lju9a+5GwMySgeFSad+OqdeiUcy
         jpy96iK3CxgSwCD/Az8FPGsCfu+ZeTqGTIvsD+mAw2OE3cC7BssMi8TWXhVch0hU9Zeg
         9nOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ9ADItdygCG9z1Yyo7q4Qh9KJFOHeeiYcSPyh1wh5lJ5UxJHH7SrenWPvlVmAVUDMGlNIN6K8p0jneqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2a7JMYGlyK/K4daBFlHqwV8lDkk9NwL1wr0bGUr5Qiy3DlgK
	2jiVqZYaAbpMR1w3HYgy8lRjKokcpkrXypw4kERUc+m1oF5DfFOIpiQCdQKcSONZd9beGx2ABTG
	iB7fdyOCKW9IjL6T5b1BhAIekOUSY9rkDZqoXPamp4fhzhpEwltBkll4iZvSPPJQ+UA==
X-Gm-Gg: ASbGncvb+c3iiLVPbH1Ic94CVB8scxrBU1RdYqUttMRbVpBbWRjt8YKiPvK6fQYBogi
	69aMGmpmqE7zlspmv8zfZ/+o9GejlhhYtGqk8zLJyuo9ZbmGwbn4BmpcY8/y0U4TAjbH2takfI4
	g2cfNiWNIJM/1rGMioZZfShSvpnkUhft23SjLxLRLr8vixcik8HIWR20XcIYG/LO0qDpzZS3fIW
	VN3uSxJbV5QCCfCnHqxL/0OuSjIQmMcmvNBEkfPVu0ACKRr8ciK/54ohnUXevUcwj3TWxQlP8aM
	RGLKzl1LC7yAGSdskxBZ3drIqDJn8EadpoecfrQP6vb+uqtiqZxI4mHmJfS84GA20TCEa+fBxTm
	pr+65OBERUEuXo0hngsbBAvzhU52DQikpHYYDsoleZMNuKV58OmHQCjV1i/Dxcm8EAZQ=
X-Received: by 2002:a05:600c:c8c:b0:456:fdd:6030 with SMTP id 5b1f17b1804b1-45a21839acemr39164395e9.19.1755327471432;
        Fri, 15 Aug 2025 23:57:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOjp2/h7DEpRetBzYCh95sTuQHMs3qZPndjitRLIlFMSSKwzMEFfJZgCwWmyFWpiYtiA8F9w==
X-Received: by 2002:a05:600c:c8c:b0:456:fdd:6030 with SMTP id 5b1f17b1804b1-45a21839acemr39164235e9.19.1755327471052;
        Fri, 15 Aug 2025 23:57:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:c700:d8ae:41bf:492a:9e4c? (p200300d82f23c700d8ae41bf492a9e4c.dip0.t-ipconnect.de. [2003:d8:2f23:c700:d8ae:41bf:492a:9e4c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1b226eecsm53774695e9.1.2025.08.15.23.57.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Aug 2025 23:57:50 -0700 (PDT)
Message-ID: <b95b62e2-3e71-4029-9f15-2ce780b1b91d@redhat.com>
Date: Sat, 16 Aug 2025 08:57:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/cma: print total and used pages in cma_alloc()
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
 Xiang Gao <gxxa03070307@gmail.com>, akpm@linux-foundation.org
Cc: lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, gaoxiang17 <gaoxiang17@xiaomi.com>
References: <20250816042842.3959315-1-gxxa03070307@gmail.com>
 <ee29262a-911b-4a97-b619-0dea3b657252@redhat.com>
 <9be479a1-ab93-4ec7-b1aa-68acd94f15ea@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <9be479a1-ab93-4ec7-b1aa-68acd94f15ea@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 16.08.25 08:42, Giorgi Tchankvetadze wrote:
> What about using tracepoints?
> Add a trace_cma_alloc() event that only runs when tracing is enabled. No
> lock unless someone is actively monitoring

Tracing in general sounds like a much better approach here than the two 
pr_debug() in this function.

-- 
Cheers

David / dhildenb


