Return-Path: <linux-kernel+bounces-862106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 419AABF4729
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 05:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B28EB18C63BC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 03:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FF42797BD;
	Tue, 21 Oct 2025 03:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3U/t4bI"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790A217C203
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761015641; cv=none; b=BhqoPQeDmze6YnRKkUQUJa+RzoaAO1iZvTP3TeMrqQooXIMN/h+n9IyivKlbZmRxsDLYeE5+qv/cOPjZOYiT9FaXd3N8p4Zy34K3q0QlsBqXofT/LIEZMqusVmKDa+UbV5K2HMJEIMo6WaAKswuUtGp8k682tarF7J4YMHzvP4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761015641; c=relaxed/simple;
	bh=wolrO6K5Gpk5E6HmjujtcKuYSzTD6g4tns2SCtq/Y9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JW6CRt0iRLNGUKkRQKudcgff7gih9o5xfVVKsugYr8WHVvk8Uwi99GmuEaZdkVbzh6vu2r6i3NzvjlCgYcF4//+YL+jUEoB3pZxBPUkHXZKa9CoNJ0anaXmPW6pOnSOCAxLVA71bwCiS3zvKTRYKbZRvBMk2/4A5EfOrhTIPJHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3U/t4bI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33ba2f134f1so4716437a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 20:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761015640; x=1761620440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wolrO6K5Gpk5E6HmjujtcKuYSzTD6g4tns2SCtq/Y9Y=;
        b=O3U/t4bI1AypvWvcDr9TVqNMX4VfzSEzsvqHNgVYWwNSYIy5jVhYhA8zL6v9Qw7Oc1
         p0Jcuk+RztRSS0qr9k8+XwMkD9xaNtrwksV5YRjehoYT2NyJtOD22jM43e/wnE095WF9
         okm17z9lOUxgqrE1bbMZRY4mI7g7327nlPWeNlCZ2Vl8eqiKPX4DHW4735m4BqtiLrOG
         iF6jkzsdWEeefcD3o02fgEMRWdyNC7Sumd9oglkgqGaIyN71gt5ZfTQOErQfEnN0jJwh
         2kxADAUK3+DUtia315Rn93o7M0vagchofNw1OzKwIzvKKKGwmUwVGqsZ1tfOfhsfJWnj
         tZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761015640; x=1761620440;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wolrO6K5Gpk5E6HmjujtcKuYSzTD6g4tns2SCtq/Y9Y=;
        b=tGCh93ICUsuXhGaQXiAPT5LDtf25sEumQUpAQ41zo6Xyew2jTehZ6LP4Rgz509x6cS
         qj+wApBExrZGuzpa77ByDCxnRPr4/C5zx595ElHyKZ7TsKrXinzqfdMbfCRPNBu6vGGS
         RKhNWwHUno8sEqYrf/xVTEzhadand127JWYLI937H1rgxM5GtcnPPl0/VmV10n/XDKhW
         npgAIu/s5Fys/nNUoKmkG7NqZj02+03GQXNN47k3yZ7KCjzBeHOWEz/2AoLmRyBhuU1r
         rljctxHlbrQyncsfF5rb1RbYOxq03gC62GHFTY0o4lb+dSlw01vWNX/q7U2I0O5pprHf
         3qyw==
X-Forwarded-Encrypted: i=1; AJvYcCVmYVlFpHH/nOBijTTLmulfZKha377n2nmA0IYenKb7USCfQfrLdlJbE84XIAReAbLZ6dUbgoGmNJbCwwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBB9H74ior+YeAH7hdRVX3Tm+7tcJC8rGFgoMcFMnP1z1nO+0s
	OyHuUVXMhbk7HxlxP260Y3mpmVipOAueM9o0mYGuY4G5M5snKsvipjc5F45e0PCnlPc=
X-Gm-Gg: ASbGncsDe4h0lnwg0cRCL/n8+4UMl4KkXYhp4mKsZ+NvyjYSqIGsidedKtNqKMnrc5O
	N7YXIlVZqlq7D75p1bkkDNAH51MI8+oo2jCWrBjkP7Hg9HLV81ln7bPzaY+GPpUnEPFTbBSUHtq
	DWgzsgs9ubYrOlaJq2yO/Mgsgd7N2vqvPCZAeWfaXPD17XyF/XoVoVmqsImr6FvXcyy4wKQQ4ZO
	14js6MEW+qjnaH+VTBz6pIV4K3rm6+VXGB+qYd5jsmsB9Zpr56x8V5/9AXvUsISgqbsEIGyFBiI
	6f5FKJel2IBOqH3yvpBeEu5NPvRdZx2OcLjNdPeLPZfO/F64iQFNHGFQibgszuYrjqeMnJws5fB
	Y+qQkRyN4+tDnLhnnTW+0R1FQM0Y0ruMtR8ktq6wPj07cf69yrbFJfp2tyOwdVp/ATgQCZ9rS+3
	tkFsM3O3LIt9EbbB2LyZhrvHqvj4ma27Vg7448VjCXVFbYoGmYSGu2baXe1CPV/wJFlQ==
X-Google-Smtp-Source: AGHT+IEyWb6zUgAua3fez8vWhCKNdZw46wjWRLvNKVjsaqlwsezQ/r2XFrxgG+mEgkBHLIH21+GT1A==
X-Received: by 2002:a17:90a:ec8b:b0:32b:6145:fa63 with SMTP id 98e67ed59e1d1-33bcf860229mr23990816a91.4.1761015639670;
        Mon, 20 Oct 2025 20:00:39 -0700 (PDT)
Received: from ?IPV6:2804:14c:5fc8:8033:532d:24bf:bd5f:fd3e? ([2804:14c:5fc8:8033:532d:24bf:bd5f:fd3e])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34adasm9716472b3a.19.2025.10.20.20.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 20:00:39 -0700 (PDT)
Message-ID: <2d0cbd23-83e9-460b-a82a-d006a14fa9fb@gmail.com>
Date: Tue, 21 Oct 2025 00:00:36 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ksm: use range-walk function to jump over holes in
 scan_get_next_rmap_item
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Xu Xin <xu.xin16@zte.com.cn>, craftfever <craftfever@airmail.cc>,
 Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20251016012236.4189-1-pedrodemargomes@gmail.com>
 <844af749-374e-49b3-91f0-a72e951981c8@redhat.com>
Content-Language: en-US
From: Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
In-Reply-To: <844af749-374e-49b3-91f0-a72e951981c8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/17/25 19:23, David Hildenbrand wrote:

> This patch does to much in a single patch which makes it
> rather hard to review.
>
> As a first step, we should focus on leaving most of
> scan_get_next_rmap_item() alone and only focus on replacing
> folio_walk by walk_page_range_vma().
>
> Follow-up cleanups could try cleaning up scan_get_next_rmap_item()
> -- and boy oh boy, does that function scream for quite some cleanups.
>
> This is something minimal based on your v3. I applied plenty of more
> cleanups and I wish we could further shrink the pmd_entry function,
> but I have to give up for today (well, it's already tomorrow :) ). 

Should I send a v4 to be applied on top of your minimal patch? This
v4 would eliminate the need of the for_each_vma using the test_walk
callback like the previous versions.
Thanks for your patience.

