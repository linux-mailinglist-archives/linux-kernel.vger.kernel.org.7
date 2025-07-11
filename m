Return-Path: <linux-kernel+bounces-727364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FF41B018EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4025B1CA78A9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7F327EFF3;
	Fri, 11 Jul 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfMZNS7Y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0615827CB06
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227864; cv=none; b=T5bhufl5qH2Wx/AnlObGyoUl9/63CoqeNWAYbIorrVDYuGwo2Fk4cmXnD2L11xFNvJNxJiaXcjMwX6hj4cC1TyLihGMTZbNeI92i4NZZ3/NtmM4LPogmunIGGsSgkplBxb3zvbUIr7Gqt4bjyqO/mJLyPA7mcWjMsGzDtT3mJNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227864; c=relaxed/simple;
	bh=xMZgdcztEG49h6PEcELUuMANkqYuCitjkmquuTq2Dyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q3yXeyAh1hDSpeoFCeeikIXpadKwxiLw+kbpYSI+w2m2m1C0A4Mq2k0xc7TPDmtBbykNurPs6lLkZbZ1VCGkTEeNOyM4IyuUY4milKEMlLnF1mEyoZ8z/Jp0DffToDobldAlmPG85zffGrYmVAJucB3/Qgz/xRkZGdQj5bm9sA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfMZNS7Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752227861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dqla3mdKvGRReLpFIIcZ46u1kgz3tyioCB+v31NHBUs=;
	b=KfMZNS7YyN8t96LlsW32qHjlurllJGO/vSPpOxCo2COBKgnc0gdFLWVIMABL11ySvk2JAP
	snXOZyoVadQM21JIIIKOhOmtDf9l1EAWrFNSbrZqbOt5X7PY257wn7rX5yHuInx8NARs2i
	X1YOAe/hwAuvtJUbuaOHhFRYbrauB9A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-0eD2P8ENNva8EK9P_c5Vkw-1; Fri, 11 Jul 2025 05:57:40 -0400
X-MC-Unique: 0eD2P8ENNva8EK9P_c5Vkw-1
X-Mimecast-MFC-AGG-ID: 0eD2P8ENNva8EK9P_c5Vkw_1752227859
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so11361355e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 02:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752227859; x=1752832659;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dqla3mdKvGRReLpFIIcZ46u1kgz3tyioCB+v31NHBUs=;
        b=qnbdmWnDaiZqMgr3R4jsKMLWfFdCWelvhaHI8Z5nP0DuCweJR+jfKwdElO0wdZvdHU
         zZIRNHX2d/kshPGT++WaVBHNLXkc/PzITG8mTFqd1hTzT1zFbDroh2WRJXptVc49kgnW
         PCAZkHR9LimE6L1LJMBV+b2sIVtJD/inXFAsEy0PDOZWx+lHhXoq9K2TXHv7ERFL8dQI
         v/hJpi/9dB1WcDwNwlWQIExXenOcwq3KOMhuvPyNPUnqkUdrKnu1nsOuVYVJ5JTgSvhQ
         W+OQks+JFY4DRMYcWvcI8X5i/hJ0xdpB9mMSQa0CPdHVv1zyMg/XqJoZzCKZc2fcetZF
         4kbg==
X-Gm-Message-State: AOJu0Yw40OcH36BK8OQgVCIvIIDyIWUya17rVtZPs4T73waWf8BYPVZj
	18Vu/PEqxWERLy5tCCN9oB1DiBEvUn5Loi9nQZ80D9hUwvtj7UwPi7d3FuBPr1PrTJqAjFEzCJv
	9DV3cv+K3XMEFfH7njoBK1WBU4MIh/zN+8n52YpW85rPG7IIMYBdkIzr1w6NER07XQ7C9tzDrzY
	Ts
X-Gm-Gg: ASbGncs9EPcU4x9M40kZYnmOYtuy8Ul5xJL8IEtkDne8LedBfTmqJ2MdY4OmeDXARgO
	XhIelTnHj2AKl9OrWsmzezIGUNXqMyLhTb4i+5IFDH2zZUmJr/T8JVTdv8RizkdHn525s4nN2Uf
	FpvZQgTBn9I4b4XbOMkjN9rkZ1HqlBrBcixm79wqII1xRgyFGsajjK8N1vg3PFDjNGqepRF/5mu
	fKfAau8dc5TJ1uuvM8wR9YiJ2wywR1q4dzGLaXTNKjPnAJ8IDobU3o94U4IMJYw8G80WV0IG00g
	OPqQy7iM7iEHNaXayVM7xLgvHUvgdFsiVb62bR+jPD0YUtOGZRHBN3RNx7uGkkJZfMp3nW7kwao
	nGZ8nEuDzUWjg5hswxzgvDuXpkidEbGKYhDbbTfw4eZKbEzGOJXSZerTU7/yxDPFfq5g=
X-Received: by 2002:a05:600c:8289:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-454ec15a538mr23514955e9.6.1752227859058;
        Fri, 11 Jul 2025 02:57:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZZC7HX/nceEmpA1xoIeBqRGMHJMzNqx4FycoOPbQdVnFvLyWIjG9lfga4g9iULHCLwAwcgg==
X-Received: by 2002:a05:600c:8289:b0:43c:fe15:41dd with SMTP id 5b1f17b1804b1-454ec15a538mr23514745e9.6.1752227858599;
        Fri, 11 Jul 2025 02:57:38 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454dd462b2fsm42513895e9.9.2025.07.11.02.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 02:57:38 -0700 (PDT)
Message-ID: <d96e2916-2c43-462c-b6a1-2375ef397d8b@redhat.com>
Date: Fri, 11 Jul 2025 11:57:37 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build warning after merge of the mm-unstable tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20250710175020.6efdcc8f@canb.auug.org.au>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250710175020.6efdcc8f@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.07.25 09:50, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm-unstable tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> include/linux/page-flags.h:1161: warning: Function parameter or struct member 'page' not described in 'page_has_movable_ops'
> 
> Introduced by commit
> 
>    7a93faa2375d ("mm: convert "movable" flag in page->mapping to a page flag")
> 

Ah, there is a ":" missing.

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 970600d79daca..8e4d6eda8a8d6 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -1150,7 +1150,7 @@ PAGEFLAG_FALSE(MovableOpsIsolated, 
movable_ops_isolated);

  /**
   * page_has_movable_ops - test for a movable_ops page
- * @page The page to test.
+ * @page: The page to test.
   *
   * Test whether this is a movable_ops page. Such pages will stay that
   * way until freed.


-- 
Cheers,

David / dhildenb


