Return-Path: <linux-kernel+bounces-857132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE23BE601A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 03:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6689B4E4E31
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 01:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F76C20C00A;
	Fri, 17 Oct 2025 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpDHjNFG"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47766153598
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760662919; cv=none; b=BJkubzGLsn8c94NqImYioqpAyLbxgo0+6KdDB9JB2p+DPz+atRi0fupHMeyBChA4n3edXayeRngUucAk8QSA98voDVkMwTg1QzbFp3o/Y5kP+cLcNeaNinoftIW9vWTtWnNmLCKk7aLNcjZ6ntXkLuLkp5dp6pLnQuqJ0EjKpc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760662919; c=relaxed/simple;
	bh=HEPZjJUFc93YXxtVt9Bv7JUcLpl8tmZC5BGGn+wKEqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=djtfNYgcGZG1D/0bvCo+/2ZEyduxVvrN82fut7DIazr7KY8DOoOQNT9PFfGp28KcKi2a4vvSw4upGo+RJhmd8VhevjpvEmMdSD4NeBu0iLqFgsMdFseDcN29nxbJNdM9IimWCP5J5rWhyiqBrt5zIRHnpwEh1CQKXEFy+REMMA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpDHjNFG; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b4f323cf89bso265158266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760662916; x=1761267716; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lhOCF1jngPVTEjHyyJfbBN6QhgsjGjoe1GvteHaugcA=;
        b=RpDHjNFGgYompwnFSM82j/XgdNQ+RxufxBh+XF+lCIHx1dZGxizxYX4DWGYyCw8dzX
         ECuKPXqEbonBoTREhh2kWpL/QwXEPm+zNPaU2Ocb851nVbpD561cu5x1/y3v5lmZl7PQ
         48Ubmz+cQdg6dwRw0KouhXccO8z4C9Co8BHrIjJoPTMj6DkrspYSp2eAZBCElXl86hrz
         xm14RLhr2qqE7G9VuvXRKFeoAXkL/zH4VBiwnOP5i024YtalLHyEUQK6QHS5og/Mx05Q
         z7AnnbLpIcGu+J6M4iu9DpKU8DRAYurt1CBnhRQpmyMpu8yW3JUa1mHjzvv4jBaOfsp0
         08zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760662916; x=1761267716;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lhOCF1jngPVTEjHyyJfbBN6QhgsjGjoe1GvteHaugcA=;
        b=bxmtEzKHQopHdAfm3KxDkFaVHwyfdO1KuKGR/YCG0Luj8Av0dnXImNft7Eq7OELPYT
         SWAS4BCcu8IzCPI8QbH2uROHOTAy5La6uv5dV79FtLHw5xwQbtY5K1RAOgdsltx4ASxT
         dp6N2TMPTCbhBfvgJgMWF9K4DsZ8N+CZ+w3tGU8ax9JrVpZVplDUKs3ZkMV8MhgkW/g3
         /K72slIaWgU7VSlgjJSE6fxo9cpIXihR7eUt1Z1qVMXpliXFK4BU7g+qfLn8PUpnvg7S
         9RVZnxXBdhvQnhXsyJMFIovGfr0a7IUnELWJs0U2ur9/oxTt7IqPV36Ov+3VJdBzrZvd
         Z58g==
X-Forwarded-Encrypted: i=1; AJvYcCVAQPiqw8V1/QLxj9qT+HFxahthnaWti0yc+VljFdcuoAJWi10L2JiNBau7xT7RKad/XnK60R/S0cknhEw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLq0aw683EAmDiStAp98hQ7PsM3G/dI8+jOgllB9h1e/EfxEvn
	VcMPftMNctFSRKs5toMUbc13SMAWsHzQ0xNZON5mwcyUAp8zdIfrNRP0
X-Gm-Gg: ASbGncuAQQGm0mbbRGaqzhpOy04IkhDtQhxPxAEcvyR+oU7IaQsP7a7vFWBY9pmk3R7
	apWcf35s4/tfmngBQ03zoI+W/1qQ5wbVnDxLKoeEKNPWmNJbOgiHOcwVo77hRrVPO8BI03IdOxU
	zNaDyXIVzYkRmO48zpo9jzK3h3ChGNqmcN5xJTUuP2I7Nm1DLwlsYz7CsWYGAh5oiIVAhMjjzO0
	jpEsu5Zrk6ff02hPYvEgaPT8jyqraeL1ALMDFI+y1QgVITuK3MVJEgcjK6s6KM4zixrej6uvs46
	eulf5xk1dfGf5+ChBr0AgAix0DETVlE/q87Y3NQwyauJHVT7kd61Fd0yq/ImOdcQFSqMLsPxyZa
	MeNEhOOwp7jYRGbK+s8V21RsW23fWbY+XKe8/ZFzgBlCN/9w+OJjBOdaS49PVkGGz7XQ7bDKccO
	csWdA0jHK+ame9s1POs6hq3Z46
X-Google-Smtp-Source: AGHT+IHw+KEl5rxSaF+lWRF3a8kte3TVt48oRokdAZeDiuuJF4LkZjJ7dkb1VCZhm2T8EQpxcxNUVw==
X-Received: by 2002:a17:906:f594:b0:b57:2ffa:f17e with SMTP id a640c23a62f3a-b64731447a4mr211558566b.19.1760662916198;
        Thu, 16 Oct 2025 18:01:56 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b5cb965dac0sm681744066b.13.2025.10.16.18.01.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Oct 2025 18:01:55 -0700 (PDT)
Date: Fri, 17 Oct 2025 01:01:55 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, linmiaohe@huawei.com,
	david@redhat.com, jane.chu@oracle.com, kernel@pankajraghav.com,
	syzbot+e6367ea2fdab6ed46056@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com, akpm@linux-foundation.org,
	mcgrof@kernel.org, nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 1/3] mm/huge_memory: do not change split_huge_page*()
 target order silently.
Message-ID: <20251017010155.dnwu2bytfyoeyiaw@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251016033452.125479-1-ziy@nvidia.com>
 <20251016033452.125479-2-ziy@nvidia.com>
 <20251016073154.6vfydmo6lnvgyuzz@master>
 <49BBF89F-C185-4991-B0BB-7CE7AC8130EA@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49BBF89F-C185-4991-B0BB-7CE7AC8130EA@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Thu, Oct 16, 2025 at 10:32:17AM -0400, Zi Yan wrote:
>On 16 Oct 2025, at 3:31, Wei Yang wrote:
>
[...]
>
>>
>>> + * @new_order: the target split order
>>>  *
>>> - * Try to split a @folio at @page using non uniform split to order-0, if
>>> - * non uniform split is not supported, fall back to uniform split.
>>> + * Try to split a @folio at @page using non uniform split to @new_order, if
>>> + * non uniform split is not supported, fall back to uniform split. After-split
>>> + * folios are put back to LRU list. Use min_order_for_split() to get the lower
>>> + * bound of @new_order.
>>
>> We removed min_order_for_split() here right?
>
>We removed it from the code, but caller should use min_order_for_split()
>to get the lower bound of new_order if they do not want to split to fail
>unexpectedly.
>
>Thank you for the review.

Thanks, my poor English, I got what you mean.

No other comments.

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

