Return-Path: <linux-kernel+bounces-879398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4C2C2305A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 03:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F881A60218
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 02:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07242EE612;
	Fri, 31 Oct 2025 02:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jNNeqXve"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB04F2EC0B4
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 02:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761877941; cv=none; b=RN2bYWr1YulK11k++pB0zZ7KPJYlvwOhHsEoxciXq83dc7F3osB2l7t5ebHo6BivG46gBbv5chXq2wV4bTlhA+F9wYVLBNZEj2a0hScUfAClT+Gc1n0qZ3O94LKUNprrKrzhNQx46oMXZDLkzDb+t4ypPV16IQy9F+R/qM7/ccE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761877941; c=relaxed/simple;
	bh=p5yxsag2OECAEXhQk/zhvc5agc1YOH3y+Ya/dxbEMtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0oIIQRXke/Rt//NruV0l3SsbLPRV6wOvEMtnlnzLzRpin2t8+eqHIKXMLCkQ/W0S4ZrUjue2BBoN7GZFpYSWd0yT4a9gimpfRMu/dZNhjV1A6v1Wy/mx9CJNbeEraQty6/QcjxvvzsF2psUwXok+ExP9sNXuoUkblc2Qr1R3i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jNNeqXve; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-427015003eeso1441015f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761877934; x=1762482734; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QV9/aau8/kBCbnurL+VQAEoEEwOJQQtoJW0VC7kNSaw=;
        b=jNNeqXvePL7g6NWhRIMtpomQg+dLCXwIWc+FiZyuCJviVFRqudOhs1pixnLtj+UIzv
         PrSJ6qA8wrZ5RdG6bTxc3O9AG5YGko04Y2ghM/mVLvY5fS3WJzqFYzt1Xe/LLAVuT5Yq
         u/1YyF8yUwOr35z06ImlgQ2hK+WYwwOgQAbzuobRdKTC+XAdz5xOg3HFasFgz62Q9NNO
         R9EusmYVq7Y0gMsfqOzdpGe4M1UGw/KnvB2R4QXAeA2RnpWmSeg8R8i0ZgB9ufTxPhhS
         nvs8Xf9EaLYa7Vh+NSDOCDHFtiQLLjkgopDmjB4G1NJMpHRGUsaRjfVR6OswIbLeFLl9
         i74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761877934; x=1762482734;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QV9/aau8/kBCbnurL+VQAEoEEwOJQQtoJW0VC7kNSaw=;
        b=fgVyIzmBmdaADG5moL64WmK1lhbNf6aMPWagBATWWBKMWNRD0TJU7lvlsKxN/llaAb
         OqDbyNxVzb+ffMxSBcmppknwdEki4uJz8Ht2h+T2KnQoJs1CS5xZZjIh9FOH/bg1taMs
         /UNx74utBbZ+cDFPOo3NvAT5TPsZEtKUazOE6zgSTo/IB0FzuAgqgABxa7ekURI+o+pV
         kj7eDHfEw218YuleOY1EHxC2oYsXR5Wsb67Xr8WsyC7MGH7TN3nsTW7M7Fv4S6ymIrfx
         mF/VMeqfudYV1i8298Okvi8/WbGuQ5EdSf2B4UHWi6rdRijYDFGjXwPaAyUYBhq6Za3/
         K/sw==
X-Forwarded-Encrypted: i=1; AJvYcCWPkFglL2vXLM4crl5nvWu4M1jBtt9ndlP36dEcbWol6gXQhGqcP9Ld9pFJ5QXqq/+N0gnnDipKGXOq4C0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yznz3NPpj+69VTBvvxpn2DhRdfraSwQX02iuyAtA12HK6nOHkqA
	M5XTl/kERQFx9jNYfKHio5rDKMW4HQ+wl/Thn38M+hqlOvZZdkWkvS4t
X-Gm-Gg: ASbGncuTFQL5syiXxgA8AwzJs+h/abgmiBh5uXFgrduUp4XzK/u6prbAAB3JMzX4KmC
	iju+bDrrSvnd6UEuIvjkxJ7h92Ys/KB1a/JCVa0QRAw6GBxUN3HusogzS9+Jx6JbxyYWvXz6ji1
	WZt48gnYH4HJnhfx2Pnp9uzcOZ/4FVFKYtkh1v08+X1aAvghkoxvTkkIuhGxLfxsglIM6SjHGEN
	v4fwTOJBQE2TjlxGVKz7Vw81NWRSB2i2JZhtb6OgdVIxNw0mqZzVWSnIhe8GhXx7e834t6v/IS4
	tdvACa+fwOnb1JOBFd9PuX1C3wR1osUI6BXW7sRx0qOGd34MvAnQXPBRcf3E0AZgS47VGLgE9nH
	7jWTVF8vn41V3Yu9DkgGq1016LUFWn4G61J0ysXMDFQCV2L61MaqFLGC9I3fixV8lrFqakrnxIw
	hglvKOE3EA8pzEJ0RxrMRo
X-Google-Smtp-Source: AGHT+IGDjmSI9ZsALv2eCXVZl/4MAYrL8m6rIPSbY8ME0ISG3yZXFfPvYoXo+3p6G3qEwgFPt/dYzw==
X-Received: by 2002:a05:6000:4387:b0:429:b1e4:1f74 with SMTP id ffacd0b85a97d-429bd683753mr1506395f8f.20.1761877933879;
        Thu, 30 Oct 2025 19:32:13 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f192fsm735011f8f.38.2025.10.30.19.32.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Oct 2025 19:32:13 -0700 (PDT)
Date: Fri, 31 Oct 2025 02:32:12 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Zi Yan <ziy@nvidia.com>
Cc: linmiaohe@huawei.com, david@redhat.com, jane.chu@oracle.com,
	kernel@pankajraghav.com, akpm@linux-foundation.org,
	mcgrof@kernel.org, nao.horiguchi@gmail.com,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Wei Yang <richard.weiyang@gmail.com>,
	Yang Shi <shy828301@gmail.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/3] mm/huge_memory: add split_huge_page_to_order()
Message-ID: <20251031023212.mghlthnfscnxkfhj@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20251030014020.475659-1-ziy@nvidia.com>
 <20251030014020.475659-2-ziy@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030014020.475659-2-ziy@nvidia.com>
User-Agent: NeoMutt/20170113 (1.7.2)

On Wed, Oct 29, 2025 at 09:40:18PM -0400, Zi Yan wrote:
>When caller does not supply a list to split_huge_page_to_list_to_order(),
>use split_huge_page_to_order() instead.
>
>Signed-off-by: Zi Yan <ziy@nvidia.com>
>Acked-by: David Hildenbrand <david@redhat.com>
>Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Wei Yang <richard.weiyang@gmail.com>

-- 
Wei Yang
Help you, Help me

