Return-Path: <linux-kernel+bounces-855083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5287BE02E5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 20:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2352619C6B47
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E970724468B;
	Wed, 15 Oct 2025 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dw1JW6DN"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAFE325488
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 18:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760553041; cv=none; b=lYVEvKOxGNnaJ/Bo/Y04WJcAt75lM4LaIziS4+vUyS7u5REEF/kAm9l95JLGBleYOcE83Q+xSNTr/82+NUPVjmvj4vBXPbzcDnAQjHpP0SB2qKmldH47uXuz9DDXW7iExF3elrAJTR+sA9pStKhB3b7ZCkqVnzPcqnQWR5UAB7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760553041; c=relaxed/simple;
	bh=shD+AjTNiNEKfrCiOBgUX785Wji961nBvsqSehvM05o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0b+iox7rvp785C/irnklzZGgUN0veYZ8vKeIP4XGp0u2XpjGfDfBQ3oW3dnSNdKDuWh21Y06WkD/D6TULvO+EXqnbaqkYQ5U8ktCsoQxk9le4FvjhNIZws04785AZUPblkjH+HRODTCXSMfpMpXfYZSQWqU8BmhX3ZsMm94Yaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dw1JW6DN; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-46e6a689bd0so51964815e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 11:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760553038; x=1761157838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kr8fHPKCQCSS2Cz0NxhaRIgWGDrTqmH8xm1AG+RVO7I=;
        b=Dw1JW6DNY2a7hSDSiN+u7UsYEFDzFfp3XQBi9KZtDREcf7p9Dnd7BP6x1UYJHpEUmP
         BG6SeVbWs0ezFe1vCEVt6uoXwtL4Z2Hp/52rAtfEMrVNzexo2Ui3zqtkVB/b+sCp1nbJ
         ZzXLDUGbho7t+NRQZUcKHWZ1Ih5FL7RymKKKKGlBlxRF/+rgBfKfC+eqzr1pED4STFlL
         cyOhLifOvcosucG6ggy6HLROdCIsvUz2PYvMVTxd7HEHBv/MJBVdBSz1xxGt4sKWZxUV
         xbYVo3YMtrJq2Jb+EwfU9QyWYoTNppIpp1Vu3s7v2CkRyA7vR9ooYtSiCXjrMaX0S2FC
         +rOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760553038; x=1761157838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kr8fHPKCQCSS2Cz0NxhaRIgWGDrTqmH8xm1AG+RVO7I=;
        b=NLWDwwjPzPTdHZu7MZlWPfoCEkPcDEuNQVK89ZjeRGiQUtmny3X6vSgEhWN5fZffX1
         m0TP9lKIKjt5rqo9Tf8jFkR2wmiRBmo7aYTidnV5rI7l0t2D0Zr/9JP4QN0d7I9zkLPP
         qApUPyTSJEQxu3rx/WggsfhXcUFB71R4z99/p/5AUmMOfy81Xy5TSZzmyuhr2Aa1OoKr
         Qqf5apuketZiKTlU5nMRT93XvL7IaC0zAJr8K4lpUALdT/vM1yhq6tlSg2hXtKd0RNQv
         9zgEjpRqRio40guvKlXoXo8EN34e5sDrYy6tih4pC/S3WaKY3x09TZxb0vHx8+D0LFQH
         HkXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVilCVTu7AzC9UdHdDSO0eU93iHQJDzbSHYo6ESXDyNmnZK3bWGOR0OUCw36DH6V5+HAzuOaMPOX1mli6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI1kTpTlDYehd9nTaM21LBwO/Q7WZJGFTgnpLHTmM+N9X+vaFE
	S2CmLda/ugY9tZ7EbIhCa66FRLKsWH79Ys8zpAm3EBZbuUDyuUjmgy+5
X-Gm-Gg: ASbGnctCSUO8zDDHp0K0yeSMj68GrgKjTNwIyJ6Zwkp9c0dFq4z/qzk+CwPIDTZykjC
	tLsCNq7xmukL2VONaCeLfjUw2P7wIHbIQDV7xcL8kI9AJlUEbnoKa3oQePPY2lMOu7/0LusoYZv
	7eZukoXkayCZGdjp3DVu15h6c3UxGaw2l2Dpg8ZdqJwgoxL2hJ7GgLElhx3NxEqUfYgW1C9TW5f
	FFuxFD3OUrDW3LzSjd8LKrIi4SzxSAH6459JzfiIGdaVYnaHsSJLKnwlk5yJwf114sfz+1RWlgo
	bT36lbQWC85WaUWwhl5F96l7CwNyIecXVCxvphYwRdQksK/wMywM5Mq/ybgfoM0sBNBA808uZPr
	g19srxuYlO3pD0sytLxGZ+7bxvmTS34oJ/Hw=
X-Google-Smtp-Source: AGHT+IFfczfioijaKKD2pS1noEiJWYnY1kDJxby+Nn3g/JuazmJhsP6vmgjhC8NJIK9OxbeHpECqVw==
X-Received: by 2002:a05:600c:6304:b0:46f:b42e:e38c with SMTP id 5b1f17b1804b1-46fb42ee457mr147202005e9.39.1760553037750;
        Wed, 15 Oct 2025 11:30:37 -0700 (PDT)
Received: from fedora ([31.94.20.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e83e1sm30552851f8f.51.2025.10.15.11.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:30:37 -0700 (PDT)
Date: Wed, 15 Oct 2025 11:30:34 -0700
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: wang lian <lianux.mm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Rik van Riel <riel@redhat.com>,
	Wei Yang <richard.weiyang@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm/khugepaged: fix comment for default scan sleep
 duration
Message-ID: <aO_oSvC9LqbLjkJf@fedora>
References: <20251015092957.37432-1-lianux.mm@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015092957.37432-1-lianux.mm@gmail.com>

On Wed, Oct 15, 2025 at 05:29:57PM +0800, wang lian wrote:
> The comment for khugepaged_scan_sleep_millisecs incorrectly states
> the default scan period is 30 seconds. The actual default value in the
> code is 10000ms (10 seconds).
> 
> This patch corrects the comment to match the code, preventing potential
> confusion. The incorrect comment has existed since the feature was
> first introduced.
> 
> Fixes: ba76149f47d8 ("thp: khugepaged")
> 
> Signed-off-by: wang lian <lianux.mm@gmail.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> ---

Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

