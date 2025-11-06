Return-Path: <linux-kernel+bounces-889062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FDBC3CA63
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 17:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3890942143C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 16:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBF2335072;
	Thu,  6 Nov 2025 16:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVpN20h+"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35CC632D0E3
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762447925; cv=none; b=Z4eeSzd3F3ApFU5Rz0HrMm5Cybeo3q3KRJOwI1t9xNAsQHxKVaPkS1fkWko2mr8htd6nxBsW5StAgK/dDnQo9LFoPzk2x3PI02uzWOTTr2dH8P7BjyW6oVwqDComtpM+dwsxn2yA2mMQno1M6RU6Qx3hFYbm5H7M5THo87ZnMBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762447925; c=relaxed/simple;
	bh=yvXJfu/ob0GjOMeavc3rYWon+fHKroOYnZx49oPhgbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5LrU+6RYPad+NkurRtB3nk7txIW88Kl2mAua4Z03HD/uGzcOiqqjYHGI1LwGBSXYcGjuTyvbecqafm/IQHfJGUtoQTRMj2q35+G/HF5thjos/CyF7/STFnfak7F7/toc7JinhTGnCug/7W8rRpN2JQ/hapeU8j7EDGfealss04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVpN20h+; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63fd17f0cbfso1083501d50.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 08:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762447923; x=1763052723; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x932i+qn7VOr3brR1Z77jL6cYxaH6GfwHUzG9KPyVH0=;
        b=XVpN20h+w4PRej1A5WYXmr42/SRIMjKio2piLWGGcuQpCSr0INVahVGWD8W8JLKaLt
         95TonH73S92OHo3c+z8zEyt4oB7dlJOtA6Z0xHuWjTFFHnO1u6+F4UhokOR+Pc+qHgA6
         7/L9UbV/hvnD0GGyURV3RsF53xhQQsxBs00ViOI9xVZ+PI1WxFM3aUe6v7RHlp6pBNHh
         tbD4XshZQB90V9JKzjfLlKszkoI4uttiEi/76ijvfGNGNQJ//RbFkTimZbbnc/KlgD1d
         Nif72+HBgpyYJdy/mWKsEfuLbdh3w7XWDLY5kbE56k7pJm/lOO4w8WTrZAyVtCnXdqfT
         sw7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762447923; x=1763052723;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x932i+qn7VOr3brR1Z77jL6cYxaH6GfwHUzG9KPyVH0=;
        b=YzHPcl6cceF0LePTSwdoYEm8gmtITY0VrZqZVBDe/nPVL+x4/Dn6wtKb21Aa/UnT20
         oWQD+BSRtfO+ogzilfnspWJKc+J8ePluqwScXDQslOKpYvDxOcUqzcjydrQeUPZG7pf1
         lxbmdKckBmJhfC91z+l+52b3d5Id5qkF0SnwPsVnwMD2vnVPVtdhXCPpjlGSiEHYOs7R
         9myZ40FNFS8DHsqdxx9JnJ9/XfDC3ptBIwDl+d0EH87GUJgx8tdO7I30mGpjcVwfnZ6l
         MogoWVlBui552hgNudOsVh0d7SVru7sTjvv4vUSJS+4OsD+l5oDSPNDb+1AzSUmezCDZ
         o3Ig==
X-Gm-Message-State: AOJu0YxJHIRWIcW1H9IxF2FWV5JQ3y38I8TnOr5dRSYnOaEiGG6YDzeV
	ut9zGBP43QHQrUXKqtc2NDXCDZxCcwiIl4tXGGvYYWccXcplzH1w2W5VlL42Bg==
X-Gm-Gg: ASbGncvRA42v66YybZcZ4iCaFfW3HQGunGtNz8pEpUDumqqh9VWD3bci/KnUmMH4iQd
	PWDNtmfvuqO6VeV2+v3ua8mx/ViP/cfu5Bvr/cg/uLD0/eAWXy1YJKVU69goxLcLLb7lf3V4DzG
	JhRRCbMBSbWqEGIAjrQDxd8lAF/kIB/gYPSzuaTrymeAdGhJ+ClkMXbwx5PCa+5XtoNabmIV0Ng
	UNhVI7EcdMzoMHDgztEbSVHzwAvuu7LC5YoJ/YYGydYVLTgH3WCPD38jdvJa+s4WRuqF9UJV+NL
	KLtSGVFXX/CZIlxPTd9fR8nA07kQrRwJQsABdspQShS9gCdLydIRkeb3ut/lowMqb43VCJqQOyo
	ag7AS58+msOxvFbF6tkLpL7+OFuuhI6UXMuu9Hs/yUfC/UXy2GwFlzsYPkneg4LiC67UQ5/5+ZF
	874i0vkdVdfhnbcqU7nq97oxeuD+WTfN/t
X-Google-Smtp-Source: AGHT+IGOGW0J40NdlB/jBjaSg2YarxTTiaMotE2HgwQ7NjGGd+B3lbnlpZu0LUm2pVB2JQOEkxMbYw==
X-Received: by 2002:a05:690e:1594:20b0:63f:a103:5d3d with SMTP id 956f58d0204a3-640c4374c8bmr17792d50.45.1762447922995;
        Thu, 06 Nov 2025 08:52:02 -0800 (PST)
Received: from localhost (c-73-105-0-253.hsd1.fl.comcast.net. [73.105.0.253])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b159b666sm9375647b3.39.2025.11.06.08.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 08:52:02 -0800 (PST)
Date: Thu, 6 Nov 2025 11:52:00 -0500
From: Yury Norov <yury.norov@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 0/2] bitops: update MAINTAINERS and fix hweight.c
Message-ID: <aQzSMMX5LUbCZIoW@yury>
References: <20251106080712.1885074-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251106080712.1885074-1-andriy.shevchenko@linux.intel.com>

On Thu, Nov 06, 2025 at 09:02:49AM +0100, Andy Shevchenko wrote:
> Update MAINTAINERS and fix hweight.c to avoid kernel-doc warnings.
> 
> Andy Shevchenko (2):
>   bitops: Add missed file to MAINTAINERS
>   bitops: Update kernel-doc in hweight.c to fix the issues with it

Applied in bitmap-for-next.

Thanks,
Yury

