Return-Path: <linux-kernel+bounces-850277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D53ABD262E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 68B6C4EF9B3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E141D2FB614;
	Mon, 13 Oct 2025 09:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2lqZWLi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71122F14C
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349251; cv=none; b=koM/+He1/kUspzNe1f6wMXzzVuMv3hl5Xv48lW5/96Om2H2by7NiJi1xzzrVn66J6C4qajfJaHk6XF2b/VLzS4FbayASejuWAoqB6UC501hbk0N58mY1P1cYml1nbNXhgA7u/ixnBJNGnAZNBLXczjL443gSDcWxGqzFqZknyJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349251; c=relaxed/simple;
	bh=/OsANy/xknfpxgeA3mDd5Xx9wo3BIXMT68Kyd66OWjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0lPtczbowHUozkgltjCJ6tw2rThY/E3FIfLh4c6RsvEdLS8VIOls3YKVvcF/TjapLTTCa+hBZoTy1Olqq2Bq3lw83lOpU9N9rf61Pn6DxcA0krqAE6SPqNnD7ZZ5QNE9IHcfsbGTyaNz6d9Er4nb/klp9jwLTDpVmfDNHSiBKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2lqZWLi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760349245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EJNqEM7yM1jaIMopGhasb5E5+Dj52uVM6msHKbTRxS0=;
	b=D2lqZWLiKkiKfysBhm7EbZOEVu59ASk0ohI1VzXV+O9G2T7WtujKdzVfiHgr/kgfh8VNqc
	sZCBudX3/95O7NMqcKmAw867OqE/1JBiaGoEbhzVngxTjV5GHXLadC/qD56IiB52LTpx6A
	WhZI4SZ4AqXoCcJid/Up5Cod5PBiNX8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-184-9U2CtVuLO4mRfSQCwbbKXA-1; Mon, 13 Oct 2025 05:54:04 -0400
X-MC-Unique: 9U2CtVuLO4mRfSQCwbbKXA-1
X-Mimecast-MFC-AGG-ID: 9U2CtVuLO4mRfSQCwbbKXA_1760349243
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46e3ed6540fso26761335e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:54:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349243; x=1760954043;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EJNqEM7yM1jaIMopGhasb5E5+Dj52uVM6msHKbTRxS0=;
        b=nHdLJKPH9TLvf3uLP/+cQUvK2fZSeJy4zvGDP6NWqF2iPCH68g+AIgvGpy+Wk4OPIA
         EyFtihzJlWEVdKQ8xgO8YN1/Cj3NswpzWIzyZGmWcmZGAB2dgdWLdVOkD+sUsI7xoDCs
         QF1ge0AlvSY5bS9U2oplEvC8C8Hy0PrNotsEVO46IL1CXeaK9NKeXiws//bBojeaiANp
         uFuOCSvHo3uqsfCA7tVYb/r4nQV60sD7N2Lrn9TyxrXLe3OnfVTek5ko+RZSw/PSlzfS
         8BfPnk/QZNDxlODghfNl/s2uvNyo2t2hhpiF2oe35K5JQI6F34b7pxLNXjLuXXZGxsZq
         LdWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7k33B9qwpbGono/dszGS5+dirGcoYXEJ1cMcsOk0CyBZZ0nis97yDfaO77cw7gx4slBGhCOWJG7E8/z8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4nx7GFW5y/1ZN3V4DMLrthZmLxTGmuqkMj1neJIFUL6cYa1rS
	PtPgw6uzhgKRDYCYE9b6L78IrFM5AGspc3GFCRvgD7VXNR8K6yf8C0r796jdwE3Pantm53qWPpl
	lGEFddCQm0eajQsV+IdLbCI62OlGuWSWed4/E0YH/EGmxwqO2MbtA3DXxozBqzw8FLg==
X-Gm-Gg: ASbGncuS2QHTpJ089QnYe8EaJzikBIzKhZ673QSioR/xE5B+T9JVhPVf/Pqaf/ImCst
	iya+6BOYOjgygX+ki30KXqI07d/5LU64BoMlq197utImNdduvOMwaod6gQhRgF/xzzp0PAtfqSU
	qnD3VzcK24kbb1M7BPxBwJ2SmAKfiY92rKu9e/1eD4lbI4wVnq1Q03RhNuMMIe3IDgXG/NpDJrq
	YybViNgBsAuVd2MuqOLxCkLuZyU6HPdl1geDWYtBVH3gcnHHuzJgQK+46KTtOlQz67KF+fqmAz3
	ceG72XcbeBIl8hKSKs522vPfM9yV5kFufStA/xXlj1xo68LQ0nhiCSDwnep0lumgCoVNUu0k9bf
	gHv8=
X-Received: by 2002:a05:600c:1277:b0:46c:adf8:cd82 with SMTP id 5b1f17b1804b1-46fa2952c02mr117821685e9.3.1760349243171;
        Mon, 13 Oct 2025 02:54:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTXPafYWeLRO7Uuqu7fC7gIcp+4dWzio8Ya6TXBPNgFi3I7AUlaSBX+TM+dTAwVgrNJI1szQ==
X-Received: by 2002:a05:600c:1277:b0:46c:adf8:cd82 with SMTP id 5b1f17b1804b1-46fa2952c02mr117821605e9.3.1760349242740;
        Mon, 13 Oct 2025 02:54:02 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb482b9absm200025705e9.2.2025.10.13.02.54.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Oct 2025 02:54:02 -0700 (PDT)
Message-ID: <bab3249a-d9f2-4f19-9493-b7560aecc3ce@redhat.com>
Date: Mon, 13 Oct 2025 11:54:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] hugetlbfs: check for shareable lock before calling
 huge_pmd_unshare()
To: Deepanshu Kartikey <kartikey406@gmail.com>, muchun.song@linux.dev,
 osalvador@suse.de, akpm@linux-foundation.org, broonie@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 syzbot+f26d7c75c26ec19790e7@syzkaller.appspotmail.com
References: <20251013093337.4432-1-kartikey406@gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251013093337.4432-1-kartikey406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.10.25 11:33, Deepanshu Kartikey wrote:
> Hi David,
> 
> That makes a lot of sense - moving the assertions after the early return
> checks is cleaner since the locks are only needed when actual unsharing
> work happens.
> 
> Should I send a v5 with your suggested change?

Let's wait if the hugetlb maintainers have any preference.

-- 
Cheers

David / dhildenb


