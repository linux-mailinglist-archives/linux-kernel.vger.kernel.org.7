Return-Path: <linux-kernel+bounces-755569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8034AB1A894
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 19:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5A3B7A49EE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D1528B4FC;
	Mon,  4 Aug 2025 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwSZGCal"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C5284B57
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754328151; cv=none; b=DbJJXSQQpxACWkDeo5zvP45mw67SwLNLVW+pT83aKSRIcDdgFxGOULjMOItGMLqron23csP50e1sej+a6fLXfviroG8XX/TpssfWxxZsYCUHWBQIDc9PFRznyTJBk2bHiPv9YVpBZADSD6JY2kGeHXezLcvIwx5vdLhVE4TXkjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754328151; c=relaxed/simple;
	bh=4D7McfMz//6Io5jkCQQhQXkA8qJkTmMiaWyIVHYRoLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BJTrSemHmNx33l8YYF0/ZQsnZEAGTzKxgC6wZv6t3dVbMPglp5qfmR3A1pSreOmHngXTSTNDpiyHpPFcuj71MhN/izjZ6d1+FoBYu9wF6rHAgM47SsO+FVUApsUAFnkXoD3MhQ8QoONwExEC0EnIzwWQ3tnhKGJuHdbtqYhpbf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwSZGCal; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754328148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvAzramPzKC7LOCG03EIhflRhdZZnfGOcS3I4B6JOHA=;
	b=BwSZGCalvcwV8kNH8Ni8/7rc22DXBUixIoy8SRRiz2h/RaShvpZeb+VAbPNn1SFtW8BZ7k
	j0l9R5l9yjCcsLt+FLr2FOFB6FfRqjHgBNjtyGtnVXMA/KBCtCHf6tXVPr0MH1WtrorQd5
	ZhYUBHrMU5M8HL+DFUlu/uU4cpzxpcY=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-BYmtaabHOmSnQkGEDBXsRg-1; Mon, 04 Aug 2025 13:22:26 -0400
X-MC-Unique: BYmtaabHOmSnQkGEDBXsRg-1
X-Mimecast-MFC-AGG-ID: BYmtaabHOmSnQkGEDBXsRg_1754328145
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3e3ee9c77beso38804415ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 10:22:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754328145; x=1754932945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AvAzramPzKC7LOCG03EIhflRhdZZnfGOcS3I4B6JOHA=;
        b=EbMcYA8Rgw3UoXKstoKHwMhCkvOXmFfrgBUpoByrtyH/EJTxzwJZFcbi11QbxTPHKs
         7kspYoA60mbg1kj9JVjPYhk1AVSHimI0SnbJg3VwcLulHCJvlN5aLHCSvdC8nsfpHJaC
         iQdLdpq1uFuj1cDkZP2QtY8cNcSc/DrjvRgl8aGJ1gvJOFTrchr/PCtMDe/e7lOL42hN
         GLW9COekLd9xUyaSf7O89Amaus95XPZQL77WGIkOaOa0lBs0DwswAhB6We5zdalyOxzN
         fDH9Q5JdJCixv8M1SLdYNNSXf1BZUssniYdG3g9YsbaU1PW1HmV1RfjgivZf5Dx/0eUP
         3duA==
X-Gm-Message-State: AOJu0Yy25nki06EctOL4QQbcX17ova8srOQUB6V8mpMWpnkQWQpIeMBT
	v5CMklsYTa2IdAp2HnGK/teHQfUeXPzt0k0QQiqVYN8+8EL8kLsZpXQyrM6Lc/dModYM3YfwzYy
	Vs+GlAxwofZVy/Xqs5tkLh93PsQCD74aP00TPsx9IvQP5ZilKDTj8QVaU1JzMvKZAfQ==
X-Gm-Gg: ASbGncvSyrRtirTiq1Surnt+OnGYrf6vZNebEIpcX34tPR1laePd2/oikbvDaQI4Ojs
	4aR6buJW/Uu0SXDEPk7crS2ip6Skr/RiVLOfY9sMzpalYDtIH/YgA1AxxeloLAGuhu7FlwEGnOR
	b067bxKxWwea7Ds+sGhrjIJKhvmOsJjlX70ujcup9UYiqbHRdCSz83KCyQdaIXZZYsK0p045sjy
	2lFHwFFUQOKzGEFhOTHOzC0JvseU918dLhFSi+IzmgRUV9ZhuUTNQDKtvUZI2hTdgVayFtwHyJO
	2ne2iPU3cwAIc7pcS1S78R240hvDwueY0OMwmUBlRsQ0QypZ3YXl4CqpfFdfbFBITicb5O3VWIH
	0
X-Received: by 2002:a05:6e02:3047:b0:3e3:fd04:5768 with SMTP id e9e14a558f8ab-3e4162b92c1mr196965515ab.5.1754328145083;
        Mon, 04 Aug 2025 10:22:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN5yhHnEJURiVEudiCJgdS0oLdQiAu3b8N+Y02EpKLUppy0oAd4KAxbooiejm+IqA4f7JAyA==
X-Received: by 2002:a05:6e02:3047:b0:3e3:fd04:5768 with SMTP id e9e14a558f8ab-3e4162b92c1mr196964965ab.5.1754328144627;
        Mon, 04 Aug 2025 10:22:24 -0700 (PDT)
Received: from [10.0.0.82] (75-168-243-62.mpls.qwest.net. [75.168.243.62])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55da3351sm3360429173.87.2025.08.04.10.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Aug 2025 10:22:24 -0700 (PDT)
Message-ID: <a1b3f555-acfe-4fd1-8aa4-b97f456fd6f4@redhat.com>
Date: Mon, 4 Aug 2025 12:22:23 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] debugfs: fix mount options not being applied
To: Charalampos Mitrodimas <charmitro@posteo.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org
References: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
Content-Language: en-US
From: Eric Sandeen <sandeen@redhat.com>
In-Reply-To: <20250804-debugfs-mount-opts-v1-1-bc05947a80b5@posteo.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/25 9:30 AM, Charalampos Mitrodimas wrote:
> Mount options (uid, gid, mode) are silently ignored when debugfs is
> mounted. This is a regression introduced during the conversion to the
> new mount API.
> 
> When the mount API conversion was done, the line that sets
> sb->s_fs_info to the parsed options was removed. This causes
> debugfs_apply_options() to operate on a NULL pointer.
> 
> As an example, with the bug the "mode" mount option is ignored:
> 
>   $ mount -o mode=0666 -t debugfs debugfs /tmp/debugfs_test
>   $ mount | grep debugfs_test
>   debugfs on /tmp/debugfs_test type debugfs (rw,relatime)
>   $ ls -ld /tmp/debugfs_test
>   drwx------ 25 root root 0 Aug  4 14:16 /tmp/debugfs_test

Argh. So, this looks a lot like the issue that got fixed for tracefs in:

e4d32142d1de tracing: Fix tracefs mount options

Let me look at this; tracefs & debugfs are quite similar, so perhaps
keeping the fix consistent would make sense as well but I'll dig
into it a bit more.

Thanks,
-Eric


