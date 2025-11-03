Return-Path: <linux-kernel+bounces-882934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2330CC2BF5C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 14:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0AD1422ECD
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 13:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4BF30DED3;
	Mon,  3 Nov 2025 12:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtyaFhq3"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D651E233D9E
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 12:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762174627; cv=none; b=kUiQer21aSEXYTwZTRvkzW+2x4O6bBLpcZ9DwK430ck2LOLO1qIByPJohwb81yMsSyfZgMGiE3OW9fCiPBEIyn1cz4QnYFuW8c/NLfaXrKagVo5VlbJUBITpnX7vLZmE1RIHRxLedE+MAg84xYl0FxfAprpiICbHU8aQkL1CzE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762174627; c=relaxed/simple;
	bh=GtwiBFRUEFBVez/Z+mGFBS1AdJ87qQO1QK15vTC7rDU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jAzn0OD83PIaTmucS1w/Ahf9r+ByzMJVoCGSmPT9lVxUsVtxig08hsa0s83DNRrG6mwUhDjKx316pDk9IsevWk1BA0/pIxoSJ77noFx8/n6VkqOcB5uHUCMEG2BrLLp1cC4BPVEoXtebM/CU3Rrn5V2SX6q7xRhMWm+8oOcPuqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtyaFhq3; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-36d77de259bso29522441fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 04:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762174624; x=1762779424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ABjcrw89jAA3Q20fdppeCXKOEoaWX9Ww3g8nGLhqb0U=;
        b=HtyaFhq34el7kx1zNLJTOU8VAx9pxy/llrOxDdjkUz5tNUenQBfG2ftnzFjgjH6714
         MtdjGHwudn3An/GyL/3cL/MiYQEThJAWjx0xXkREp/M5BlbsLB0nCYC+e1CUNc7Lu/c3
         okIkcFstqxJSBYC2b4g434ePmQI1Y1+/tbksgDiPAL+Y0sW/OpWUpYFJukkBze3dT87s
         WcJPgPmDdEmdtljE/+Lqi4GcFaAhBIPtEW//0LHCgqM05qy21fSsUPfJgs+oKlYg3C1s
         THHj/jDGEPjZL0FN73ThLZoiJL5vVHT9rIKW1Dr+xemthLSzxj0q8B+WTQ7UjytxFlvA
         zwuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762174624; x=1762779424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ABjcrw89jAA3Q20fdppeCXKOEoaWX9Ww3g8nGLhqb0U=;
        b=M4BOGYXhRK5imk/KMgU6hvV10TkHIWreNSBr3x98cWwJWaausgIuMvNUGCj3fkh90z
         gcNN5BBu9sZs2F2nbJy9U7SLh85bDGzC/DCSAsVyPMosF8ppLDVCvGcRmr98PqkBpCb9
         /1Hs/oS/IqD7or2p9suRvoPyPirwwii2qqJg7TifMgF/pUUajnUod5vR9whWSVrU9Emn
         PelFL+598fj/ZZGMFDeiKaZvfgfq+Ma924+B8xqD2KSgISkDRm28nptlqJhmgBDFrJSG
         JisEwaiHpuXTSs+Tcd8Vgu13JzO6/BF6D1gM8OJKEFMAWv6L2blAdYYOFfVOia9w/laS
         W5ow==
X-Gm-Message-State: AOJu0YxK7zA9KKR5vWRdy0XuH+rNaHSzYle4uyXTOrKRkwFP+kJOuHhK
	mcXSISaJQZ0xF90cSY8jY54hhyp3VIuozmQ1tul9FmoAwAFm6ZPw6FbUpYBTPA==
X-Gm-Gg: ASbGncs+9BLXjqNmXNf8RARXU+KXQ3ERzxeS/MclxEfao55Zp98NSApNGgicnCuFMfh
	BJ8q53hdxbO8tw1/mPCRmjKL5PHZZf1ZTrmE8abMTA3cwJmxJ7tZO2Xi60phgEKXA5GIJUtcSEs
	4H+3ZaUZ52ISUW/oqw7FJ5eQ8vNC8zoHjVzpZhx6yzp6vBtnSHKYn/rEIrmnRd+du3xcsMUylzn
	6De1PylTcOyEX0bhtTVS5PuYbzPfgiBaE7lRBfU2Ik+pq/rIhO9KKlWEWjc4dLWwsL/4EbrzhZs
	WMOZEioVtOgZh8TFA0sYbix1OsJP7SZBApWikAb9cXrBVdz54jXTQhrJUKd9/z6bpHhzk6zJZru
	vzcNFQ+KBiARtr2vc439nLZIzYvHUwg8H+r3NkMZ2zg==
X-Google-Smtp-Source: AGHT+IG4xzdqhYAc4R6V0PORR3naINtbpFIeJn5oDtyrwDfJWC2/RhaLJmIXtOn0jpFV5tRicG8KCw==
X-Received: by 2002:a2e:a542:0:b0:37a:2fa7:53af with SMTP id 38308e7fff4ca-37a2fa75c90mr17228221fa.40.1762174623533;
        Mon, 03 Nov 2025 04:57:03 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a4167f286sm276301fa.52.2025.11.03.04.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 04:57:02 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Mon, 3 Nov 2025 13:57:01 +0100
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Uladzislau Rezki <urezki@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [RFC PATCH 0/4] make vmalloc gfp flags usage more apparent
Message-ID: <aQimnV815XIjV2JT@pc636>
References: <20251030164330.44995-1-vishal.moola@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030164330.44995-1-vishal.moola@gmail.com>

On Thu, Oct 30, 2025 at 09:43:26AM -0700, Vishal Moola (Oracle) wrote:
> We should do a better job at enforcing gfp flags for vmalloc. Right now, we
> have a kernel-doc for __vmalloc_node_range(), and hope callers pass in
> supported flags. If a caller were to pass in an unsupported flag, we may
> BUG, silently clear it, or completely ignore it.
> 
> If we are more proactive about enforcing gfp flags, we can making sure
> callers know when they may be asking for unsupported behavior.
> 
> This patchset lets vmalloc control the incoming gfp flags, and cleans up
> some confusing gfp code.
> 
> ----------------
> Based on mm-new
> 
> I did some digging and am not entirely sure what flags vmalloc does NOT
> support. Is a better idea is to have explicitly supported flags and drop
> all others?
> 
> __GFP_COMP is an obvious one due to a BUG call in split_page().
> ~GFP_BITS_MASK is also obvious.
> 
> Then I started following the kernel doc and added NORETRY and
> RETRY_MAYFAIL, and after forking a couple hundred times, it turns out some
> per-cpu allocations pass in the NORETRY flag right now.
> 
> Does anyone have a handy-dandy list of supported/unsupported vmalloc flags
> that we should reject/clear? Ulad?
> 
We recently have added GFP_ATOMIC, GFP_NOWAIT support. Both are handled
based on gfpflags_allow_blocking() checking:

<snip>
* Supported GFP classes: %GFP_KERNEL, %GFP_ATOMIC, %GFP_NOWAIT,
 * %GFP_NOFS and %GFP_NOIO. Zone modifiers are not supported.
 * Please note %GFP_ATOMIC and %GFP_NOWAIT are supported only
 * by __vmalloc().
<snip>

>
> I did some digging and am not entirely sure what flags vmalloc does NOT
> support. Is a better idea is to have explicitly supported flags and drop
> all others?
>
Maybe we should look at it vice versa. Focus on supported flags. In the
slab there is an adjust function which modifies the gfp and emits the warning
if passed GFP is part of buggy mask.

--
Uladzislau Rezki

