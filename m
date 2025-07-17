Return-Path: <linux-kernel+bounces-735557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6D5B090F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 17:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3E5582B6A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 15:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32512F9493;
	Thu, 17 Jul 2025 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L8v5V1MF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E88426AE4
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 15:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752767664; cv=none; b=tqKpXnnkEEh15F6+F/fxq9lzZ6IV9zfxb2sVQ6X+oB8dhWAtF4Awblh6amFd/gQoD/Gr/7h9yO+t9+K+X31lZmkj3pl2Uy7bwRAI8Orv7vaSMsu2FaTk5r3ZDn5S0qBkuyCTki2KLbCBS5OyKN56cb+I/lJCKOX9MPJQet7O5kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752767664; c=relaxed/simple;
	bh=+haKQXrE5sVVrXPtn47dw+psf9u6lOMVcPNG+zVKHEY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FUaiA2968oMlgNm3vNMgI5uV4aY3Gu3IQGKdaXk98fnVHKYhxA8LQxnPzKJfCEoGgqabcbI+zdRV4Yj1Nt1UKkBeMuVhVkgBGtTlvYCtsbL3kAVbYp9rQunbSKU7x4e8GK0fKGq78P9AFYRrACTXf8fVP9f41HDXIyfa/eNGFTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L8v5V1MF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752767661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1Rss2p6sEyV/hPE9tfGaKgLgVdN2JUXZLK6OjTGHO1s=;
	b=L8v5V1MFQrXcvBM+LiIfL9+8RB4psuXynJ7TiIAjmrA/hb3itOji1DKYlQiIPKYvx90Qu0
	JrH2TPSljrjH/YsYIOhWp0D1L0Hof3W7elQH8o4vbgIxNvzDyvqHpduQaLYGP6l+/VydOe
	buJQmsXRSFcOJAi6thxd3QVhT22Dwyg=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-DUbg2B5nNLiquo5yjWg5cw-1; Thu, 17 Jul 2025 11:54:19 -0400
X-MC-Unique: DUbg2B5nNLiquo5yjWg5cw-1
X-Mimecast-MFC-AGG-ID: DUbg2B5nNLiquo5yjWg5cw_1752767659
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e2c8137662so183511685a.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 08:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752767659; x=1753372459;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Rss2p6sEyV/hPE9tfGaKgLgVdN2JUXZLK6OjTGHO1s=;
        b=ZQl6P5DrD2+ypDGEn6+furhwdQ099891jrR8oP/oWA4el868Rf8s9yEnzEED+088sD
         Mr2lITfcGUX6a6G29tpqWC9K4BJxgYct1+0HVUp4FnvAmE48VurzzQWWfNAMYA7FBYXh
         Pv5QuyCcmwmjJzSbEOAGlOmbzS1nLr3V2YZa5leoitD98SiK+lUSdmHL/ElIpVoL8+vz
         A7HD3AOKzzvcDj1ExzIFX4mJ6aK3RSj7+oGV9ruEapYBD+XcCS4NigMSYqkAtnLsRsTu
         HSSUsSQ4OXJv6DiOEwe0Cp+BlrpS5CLYZBtG2+ubfNxzc4+KXiwvU1clcHPsC8IZa7su
         nz7w==
X-Forwarded-Encrypted: i=1; AJvYcCVINIKjvYHfOQMC8jKVAurdV4oYe0k1BSdSOS73yOtFJsZv3lUX1/l6NfJ6LMbO4YtAwW8Acwm2cWBEIys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8/XR7jTxWebiQ/UmSmfRGWPCTLvA6bJKKmmj1yWFfMcFIEgfV
	t6Spt5w0ZZbazL3frrqn8t8pWuhxB2t4dr1mgENaQf0OUaIcAqPsn9kpyCP80FEYFuQtgbbQQ3P
	xiSCWDiGTFFWKh/WZRd82dgognsj77yA6K5Ty7JsUs4rr5o65YcphfMQ3r2FpXNsbLQ==
X-Gm-Gg: ASbGnctW4nWE/vmvYJg/h8XQU/S8YK4cify0s5YsJcyaxzwO3jzMlBtvPJ7SqohwhGf
	eiqe4+39p3vKoxEUKugE3a15daWzOPlB88FOCRyV1oKQMLZxa/7zlWyF2ONAolBkk7AS1rofaHb
	RxVcd17y46PU8U6orH/0+4v6MSTe1/uREwqdHpIzWUsvfiLp5FE82r/jOKJ7tsYpoowR5eF8rTP
	/NwlfoLcGUNaPCu8+6gExmSPx85Pq1U7gjJ1W9p2yCxS08hbCfbMhOgQrQoj3PwwkBimZF8yZmT
	hfMrj6EnDtll8Iuy4GJgAHVXtW03HFLM1XR9qZ93
X-Received: by 2002:a05:620a:2b41:b0:7e3:380a:b8b2 with SMTP id af79cd13be357-7e34356cf8bmr831732885a.23.1752767658736;
        Thu, 17 Jul 2025 08:54:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHryZEmYr7Tuddg4ZQ3hKsmSecQs60I/gBb41Gqzu1SHUfKbYY6c59m5/QQSBNNNZwy+9MSyA==
X-Received: by 2002:a05:620a:2b41:b0:7e3:380a:b8b2 with SMTP id af79cd13be357-7e34356cf8bmr831729785a.23.1752767658336;
        Thu, 17 Jul 2025 08:54:18 -0700 (PDT)
Received: from [192.168.2.110] ([70.29.229.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e3401b187bsm304477385a.33.2025.07.17.08.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jul 2025 08:54:18 -0700 (PDT)
Message-ID: <d5c75701-b353-4536-a306-187fab0655b3@redhat.com>
Date: Thu, 17 Jul 2025 11:54:07 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] mm/util: introduce snapshot_page()
From: Luiz Capitulino <luizcap@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>
Cc: willy@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 shivankg@amd.com, sj@kernel.org, harry.yoo@oracle.com
References: <cover.1752499009.git.luizcap@redhat.com>
 <637a03a05cb2e3df88f84ff9e9f9642374ef813a.1752499009.git.luizcap@redhat.com>
 <ca72882f-257f-4f41-bea2-0b5324c820d7@redhat.com>
 <900252c7-b16c-49b9-8c01-60e6a7a48683@redhat.com>
 <492025a7-4132-4944-b55b-90c6d6e40bba@redhat.com>
 <20250716151937.6dd71398bf764d073526dc8c@linux-foundation.org>
 <e4798260-41b7-492b-8b7c-0922173f59f9@redhat.com>
Content-Language: en-US, en-CA
In-Reply-To: <e4798260-41b7-492b-8b7c-0922173f59f9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-07-16 21:52, Luiz Capitulino wrote:
> On 2025-07-16 18:19, Andrew Morton wrote:
>> On Wed, 16 Jul 2025 20:18:00 +0200 David Hildenbrand <david@redhat.com> wrote:
>>
>>> On 16.07.25 19:36, Luiz Capitulino wrote:
>>>> Yes, good catch. This was from an earlier version.
>>>>
>>>> Is it fine if I fix only this with a follow up patch for Andrew in this
>>>> thread or would you prefer that I post v4 with all the other changes as
>>>> well?
>>>
>>> I think the series was part of mm-new, but now I only spot it in
>>> mm-everything, weird. Maybe because of a conflict with the other
>>> stable_page_flags() change?
>>
>> I think I removed v2 from mm-unstable and added v3 to mm-new.  Maybe.
>>
>>> So whatever Andrew prefers, really :)
>>
>> Either is OK at this stage.  I do prefer little fixes so that I and
>> others can see what changed - it depends how tricky and large they are.
> 
> I liked some of the other suggestions from David so I'll send v4.

I changed my mind again (sorry). I think the current version should be
good as is except for the doc bug, so here's a patch to fix it on top:

diff --git a/mm/util.c b/mm/util.c
index f270bf42465b..6e5b6ff1c90d 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1198,10 +1198,12 @@ static void set_ps_flags(struct page_snapshot *ps, const struct folio *folio,
   * Create a snapshot of the page and store both its struct page and struct
   * folio representations in @ps.
   *
- * Note that creating a faithful snapshot may fail if the compound
- * state of the page keeps changing (e.g., due to a folio split). In
- * this case, ps->faithful is set to false, and the snapshot assumes
- * that @page refers to a single page.
+ * A snapshot is marked as "faithful" if the compound state of @page was
+ * stable and allowed safe reconstruction of the folio representation. In
+ * rare cases where this is not possible (e.g. due to folio splitting),
+ * snapshot_page() falls back to treating @page as a single page and the
+ * snapshot is marked as "unfaithful". The snapshot_page_is_faithful()
+ * helper can be used to check for this condition.
   */
  void snapshot_page(struct page_snapshot *ps, const struct page *page)
  {


