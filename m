Return-Path: <linux-kernel+bounces-837242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 301B5BABC35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 09:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA95D4E10B3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 07:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500CD2BE02B;
	Tue, 30 Sep 2025 07:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D82SuFTX"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2387E1494C3
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216243; cv=none; b=M7ojMNy6/NAAiTYj6aYCiylKTgIvf4jzuXqgsLnYiOAkSLI3V9yX9rwZvurT5+sYxUC3Y6jrDWSvRYLqH9xGhn9vClxViK6fGqL/KKDCbZ8bJ77rnC7rtSnwiX5wLHQn0DAuTDlFkkJ7LxgQoOE5n7kb5G9E4uW42/yNpeDi4pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216243; c=relaxed/simple;
	bh=Denl1qxGVo41Q7d0YQr1Lb2bxdfCpeSVRs9tMPHWmhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfphV0NSFs1dsdbC2t3CqsBkyidnwUgn4afGu6Mfo0hWj5vBEzU6rGKOMAIb+AjqNGMf7r61Ao1qvBqi+Xfw8H90O8DHLXxF7NOpnlsmjEH1IZQ53cYM3YziXdVESME2ZhOXk5sK95R89Q8WU9CVX867Cp1fO/oFtdnFoqPawYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D82SuFTX; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46e491a5b96so19889625e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 00:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759216240; x=1759821040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z9RRPGHytRgN97Stdv6ppI5vkL5PAh7jux1HTdTPQWo=;
        b=D82SuFTXvTCOfz+r9Lvwg3dSnBSzcoewksfEcKRQG2sWCJe1HdtZ5HW1O0aF/AO8qW
         aM++AHWdbSWG0rSxMcBSbIYx01IZtaaxxma1IM7ZTwa+mN5ep30G+4VsiEMM0aCKCdaC
         ccwi8dpApv0C9grt45DKisadO5ReJVSXxLQL6pvRyKjsOrHyWRdqWwJJkjXDqN9wyBD4
         o2hF7cozesnLwl0V9pbRYhKX/KOaeWgqVrtpDLWYA+/OKqqCQfOvxymNwKOnQBWc4hLk
         QPR3ywtS7xNzP0hafANAuGHhhpiSQn/s/BHQxOOr0/8VGoJ8rAqLdLyDLb0yuebVLhXk
         WroA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216240; x=1759821040;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z9RRPGHytRgN97Stdv6ppI5vkL5PAh7jux1HTdTPQWo=;
        b=cg2dSpQ9r4QppceLMHDoTs5oAgLnZYXTkrwLLExejvJrg4djNqr3CEMFM+BADjEu1b
         CePE1+5LiaajtamQ4c8RZNuXeP7NxEaTrXfZtuNb2J22TiOSVpr5QjxvUycCopntgD1l
         VAwOJ+a7GZ/Vb7F5OjZebi8t9RKWAQlkiI4JyXoiwZVdtf86RXaH5IUKgNw03nwdJpIH
         eaPxmM3wV77MQMYi50Km8U+mT74EqH5sg+vJv4uU9IDbsP757VSGyTWmT8n9JTK2mYpw
         DZbLWlVe+w3ycDPzjfcgKioW72UGrcUHQnujEiv/KAoo69z3BUyyVDU68+FbbiMoVO59
         tFpg==
X-Forwarded-Encrypted: i=1; AJvYcCXuD6W19s2yteHO+JwSOXoJ0q0S2o2qprpTu/+r96tI6NVYEvrnon6AFNMrGsriCYwGxN4ii5syO7uE+Oo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu8UObJSdpa00QExxmJJZ8mFa6ms6XtAq+HO+mTQ16vWOaEkIH
	h3SVaPdXcC7RpWCaZqVM9Q9W2Q7PMPwbhnhUjmafybLzILrqhOVX/iW1
X-Gm-Gg: ASbGncvTIaaWxRrCGvRaTP6FGweVN7/NfyfbhTIZCka8ucvDUCoPGzDFZjVLlqK4XA4
	+XzTq+5E+KobK68cYUm/QRt/fAr88aEpMXKk5aaFVTqsnn8FHGNz41QJCvUAo/Ny0LjcyyBn92c
	DIFxM0xQGZzyoUDJs1gAkAgB3tjIvr3/zHw0ioAPmQrmhlSiluctFjt01I679Ebxlatco/nbfQy
	IpiTFOZN+LZMuAXaUNjHehQyFegnQS0rmHNusAUvL7A8dAAmEBpRoVIjYqe5u97dIyo0XgKVJiV
	eueXVhxDHm29lKuPW+t7OuuO33kdyrInoxLUOmP+eEYM6M1qXDqRcV+Meg46Ers5QGs2mFnkJbZ
	u8qG+/7Q0+WDOzgfox3Xw10il67Z4UW6e/RK3N8qWnZs+/LM1L2mn4tfS63hzsDBXwBwyssz7/M
	7nmXS5
X-Google-Smtp-Source: AGHT+IHlxvADxFZFgcYBNDOScTJX42OY6aNgaF1tsfuhrlEv7RiVBXLK6R30nOuArkYTYX9gLCEy9g==
X-Received: by 2002:a05:600c:3f12:b0:46e:41e6:28c7 with SMTP id 5b1f17b1804b1-46e41e6293fmr176295235e9.8.1759216240262;
        Tue, 30 Sep 2025 00:10:40 -0700 (PDT)
Received: from [10.221.203.31] ([165.85.126.96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2a996bf1sm257605555e9.1.2025.09.30.00.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 00:10:39 -0700 (PDT)
Message-ID: <5d2eef31-8e5a-4831-b050-cdfd65e99e27@gmail.com>
Date: Tue, 30 Sep 2025 10:10:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] page_pool: Clamp pool size to max 16K pages
To: Dragos Tatulea <dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250926131605.2276734-2-dtatulea@nvidia.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20250926131605.2276734-2-dtatulea@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 26/09/2025 16:16, Dragos Tatulea wrote:
> page_pool_init() returns E2BIG when the page_pool size goes above 32K
> pages. As some drivers are configuring the page_pool size according to
> the MTU and ring size, there are cases where this limit is exceeded and
> the queue creation fails.
> 
> The page_pool size doesn't have to cover a full queue, especially for
> larger ring size. So clamp the size instead of returning an error. Do
> this in the core to avoid having each driver do the clamping.
> 
> The current limit was deemed to high [1] so it was reduced to 16K to avoid
> page waste.
> 
> [1] https://lore.kernel.org/all/1758532715-820422-3-git-send-email-tariqt@nvidia.com/
> 
> Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> ---
> Changes since v1 [1]:
> - Switched to clamping in page_pool. (Jakub)
> - Reduced 32K -> 16K limit. (Jakub)
> - Dropped mlx5 patch. (Jakub)
> 
> [1] https://lore.kernel.org/all/1758532715-820422-1-git-send-email-tariqt@nvidia.com/

Reviewed-by: Tariq Toukan <tariqt@nvidia.com>


