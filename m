Return-Path: <linux-kernel+bounces-797680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445FDB41371
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 06:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 033B03AC77C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 04:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A04021771B;
	Wed,  3 Sep 2025 04:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MiKu1nye"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4531F8F40
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 04:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756872813; cv=none; b=R06LL82Bzl+3fBbaLCf70We1uL+jX+1mN4IYHf+MEN+XXspUIK8UZuopU2ji9GUTGLfj6QlOL2QgY5AeNy3FLsaGAWU9kOwoVNGvjvlZDpbWKJgAbbvJGLjwqYEWZ/BiiZvC+ueOC9NRaw7a3dn9bQt3UCC3/iIhFQ+gpKm16tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756872813; c=relaxed/simple;
	bh=S9vyE1+A5amQRaGkXPBUxr7nXJObiO+2MUaiaVpTblE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQ9Jb1YGhCdi7WKaSRF1MJ81nlbq3l4SqTkG40oc4TpuwDLa3eVk/dadcejcnJ9nQeI5CsbpA079bDIxDAVGXnvqqnzc6N3kiEiGtB4ndzbyUPVRyFo4DpqLh7hlBi8yQ6eeyMJTDU7USGVcjBn/EVxmK5UHK1shgBLfRpuA/Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MiKu1nye; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b471756592cso3973345a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 21:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756872811; x=1757477611; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bmjwLG7Fq+yscSPUHiCSFMVINTU2Z5qiOL+YOu1V9RY=;
        b=MiKu1nyeIGJlmExOn/3T+VeJ+z10VI0Ml6iNUvkACcC/2YcBTBKc1js6YQTXwHMKR0
         IYyOSq9bxjC/Tp8vEn9ot6li4mwEumo6BWmmc6qY5Rgb2CEVXWruKp9inHoVS9MjirzZ
         X220br6Hf7lT9NDPx0C6AiiPgch4Um1PKbFGwiB/8bzjQTLAtgWst6kAT7Oxu9u5Ct4s
         MoZHhfEGNab055DGaRByzNAYuBtucLBqPetQLRUPlpPzkc9ADfmm41DrwInLmjZF2y4c
         fVh6FGxygo1dFxF6JdPEFyhQ2eLu58DEcAE7WDLcerTDLNwUnLrpC28adlL7z7gfBeVP
         JYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756872811; x=1757477611;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmjwLG7Fq+yscSPUHiCSFMVINTU2Z5qiOL+YOu1V9RY=;
        b=tknCpmOjbtyxnGN+6Ne4Ug0xtjZc0r6oXBUu1fd7+qOQK2F47rNMSnanPwDOHAhvSZ
         WbOws7w1L16fimhEolj8X1sn0h7Ao4qnOorYAdIzUCJXKm8fG1MR/0nL0jxzxgVjm4T2
         LYb11MhnBBZIfQBOgidYp6pzJyuC/7i7bmvEy7O818bt5EwfRFn55Og3K3oZpCyiXPL/
         C0kEOmPfKAFeH59qusrwhEdrQ9rpoU8k9cBxaM+/QFxdapxymSg7OY8y8o86mdN+IDyy
         zTMfFnZdlaAQnaYRBu64so9fwlD5bwjXhyLrzhfljhtex89m9w79N4G4GQ9OV0mYMWNF
         mMQQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3aPaod4mpvGpyirDG7l+qXO2+8qzA3cHIkLNiJUtiaNiPgIv2tw67pvANQvoszkI/tme7bCawsiCnxyU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDgWXpse6QULQXlLkFMCgYrTxV3ofFdFbrzyLUcrOoyx+E3oCX
	CiaC+2+SQ8I59QMqSSjd1wBqL3BYetuwj3/LZGUQuIMWxDK9QQTkE8AaACd4dred7JSiiHqo82S
	5/m+/
X-Gm-Gg: ASbGnctWl2kcceNdsOVKW6c5k2xb7Bi4Hv5RCjjeHEfjd50zXIipaJNsIe8A2sk3Kjg
	dWBp+VSQrFw85StQrrd6MLBBh6HwqW8Vx18x5LoIUwEc4tqwcGvcGwrFFQxbMKefUxA01Qs9js3
	ilPQtWBlqlDYjSxEhwcJZqxxsFO726DeoJx3cAVzFUHieEVOgtK/Q1EcXIQs2k8PbOJL537sC49
	WrMYQoNKLGQad4005IuuHFXkz97KJxonP7Y1TvJOuNCockk787W3/FIUwrNQ5ppjf+rdaFv/3Jg
	BtpGd8Xhd7G7Z3sNgZ7fBvVPVcHo0KtDo+POnpgao+BjPHlkbYnOkR8Q4K4wrOOpUQiTy9NtbB/
	bHdE7+hOJiaVL2U+tK/sVbWNl
X-Google-Smtp-Source: AGHT+IHRoC10EpzarKMIN2A5R3VhBRRZPbEUCwSIAdpKvzIs5DQQWKr8xbqFsrKLC9z/vlEp3fqJSg==
X-Received: by 2002:a17:903:388d:b0:249:1f6b:3268 with SMTP id d9443c01a7336-249448e3b08mr201309885ad.18.1756872811622;
        Tue, 02 Sep 2025 21:13:31 -0700 (PDT)
Received: from localhost ([122.172.87.165])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b020a7cb5sm44572215ad.115.2025.09.02.21.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 21:13:30 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:43:28 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	"open list:CPU FREQUENCY SCALING FRAMEWORK" <linux-pm@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] cpufreq: speedstep-lib: Use int type to store
 negative error codes
Message-ID: <20250903041328.qgxv5eoajd6yg6jv@vireshk-i7>
References: <20250902114545.651661-1-rongqianfeng@vivo.com>
 <20250902114545.651661-4-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902114545.651661-4-rongqianfeng@vivo.com>

On 02-09-25, 19:45, Qianfeng Rong wrote:
> Change the return type of the speedstep_get_freqs() function from unsigned
> int to int because it may return negative error codes.  For the same
> reason, change the 'ret' variables to int type as well.
> 
> No effect on runtime.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  drivers/cpufreq/speedstep-lib.c | 12 ++++++------
>  drivers/cpufreq/speedstep-lib.h | 10 +++++-----
>  2 files changed, 11 insertions(+), 11 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

