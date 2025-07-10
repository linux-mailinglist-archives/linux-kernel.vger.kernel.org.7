Return-Path: <linux-kernel+bounces-724842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6335AFF780
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 05:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C071481A8D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 03:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F881280CC9;
	Thu, 10 Jul 2025 03:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X9A9CsXY"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB00EEA8
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 03:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752118040; cv=none; b=RMll4jEX7J6fJ1ryNvpaGzc6UU97C2QA068uZhnSBZ2jjZUJo7GW7eJuGeiRIb/R904tBCi9XGpTHAW/sEb+CA1Gy8DyxCZ240TCasxpWhQ8fvDCMc3KmktLpJ2ckLz0aphRyBdhK3V68a6VZESqtmrqxCrt53efCOpa9IMnACA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752118040; c=relaxed/simple;
	bh=5XkrSb58mQX23flbBJb8+VsgRvzpUE4YfqmNdKPcmww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwyStMjdZAcYJvBZ+qHyQet/Ci5Gct+ynAexgCZ4qkqp67suQxPXwAlpaYsY/nmjAZ/zSBNTwVuRCeoW8a/cvCD+X1LtcynYF8MC8qpeoCA1zAOKmmhGptDI2eP2jPEhxFPbkyo1UxWkeWCcwZSteD/t9Rs8iI13X7FTylkud/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X9A9CsXY; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so550644b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 20:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752118038; x=1752722838; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hwJhlxKmrkI/0xgCrwq2Uqg0rpjRJmbaFgTYE24zPM4=;
        b=X9A9CsXYbiabhkPYDOM6Dbt9YpHmZdaOVBjjD3CJImL8FzdP7fAmL8uhbI4oX0boKc
         lkjttX37D/NJZymcLJVLRRS1v75t3SQ2NLs0fau8ZBY7qxoyvMvBqV51DInWM0jK+cnD
         osTU9X9g7jyss2PHIGxjAZ9ihf7uZX4xYS/3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752118038; x=1752722838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hwJhlxKmrkI/0xgCrwq2Uqg0rpjRJmbaFgTYE24zPM4=;
        b=P+bXGkyLhmOmemHJGDb/jG3g/wgBOA61UqgbcY0pGATSeMAe788eMsVduExNwvBze5
         c7N/ec+oiSpCoLl7bIJZKDG6QT5RzYA/ejXbJ0/dDLwod8AlySMRe259160IemOlR1nu
         51z3uisqBBbQ6gJ5X+TP7dYkIoNrghtvdNjh0/oNwUaQccSLGXgGI/3I5mGZAKpSzunn
         jlQapLxUZly81Ti/YwVuQyQ0Op4JbCvhXEpnYKaa0gdzooQzUuiwxERZ4O4g9cBQ+37I
         AbXeMvGUc7o5FHWbFgHAUhmE0Hg68gEstJ3DIWjds5gVgM5F24oY4Pspf8oUc1gM3GfC
         xdzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuL0bnYQ2hHOonItT8wuo1FEa6n61PuG9QhRVI6Fb1n+lNg1L7v4rOaO/nC81WVoJCOccKN4b2az399PQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVesYb4ArZoW9cE9mSUJAZwaaThDxpWV1SwjNOO95/U1WaUF7A
	sJ0iQjUko4l9s0vtMrEODElD8QhKE3dclcytuvzxXtJE19HDh7ZWxF53G6Uft0ejtA==
X-Gm-Gg: ASbGncvaoHf2fnCZUrOA1BJI5GI+PZxTDKM2wORyRz2tQB+E/w6yubELVH6iG1BDIXY
	uNaVhSZK2bJepKqoKsj/mCJ/H24Wm0GIirrGV0DP5/1J3PGzQIEhrCBOgXQZtUqY6NGhrWXN+uJ
	3Dvi47ZzY28My+ej73dRfU09bymsSEgI1i3JFrL72g+wD4opoWwG9vuwxpb0nP1xlnQzdFgjF3y
	bP1s64qQpadSkwGxXTlF90rKpEtB/R0bqK3NEQVA01bmU990sshmqvXF9AiyheLRcpiC7BE7bhr
	Z6+txpWXtIj1b0TjGD8jDddAM9Q4hw5cWhAItvVZAndBPbPtp9g/kQ/Yew3HoOhgyXi/c8BQVWE
	+
X-Google-Smtp-Source: AGHT+IGl4tJkB0AZiHLL32QDHsPqmFX2ujcNYW+CJ0Z24TklV4RRTjFwzI4xXUMBtshCAAFTmKSXsA==
X-Received: by 2002:a05:6a00:1992:b0:74d:3a57:81d9 with SMTP id d2e1a72fcca58-74ea6456638mr9247031b3a.8.1752118038307;
        Wed, 09 Jul 2025 20:27:18 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:2ca1:8cce:4cfd:83c3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9e061b1sm593898b3a.41.2025.07.09.20.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 20:27:17 -0700 (PDT)
Date: Thu, 10 Jul 2025 12:27:13 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Feng Tang <feng.tang@linux.alibaba.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, 
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 3/5] panic: add 'panic_sys_info' sysctl to take human
 readable string parameter
Message-ID: <vdgvz4mclwponjtuq46oydos4idbkad66siqgbbj3jyekld3ha@5oyu6vdkomyo>
References: <ndckw7vr5zxiz2olstjaxxk4a6qgrnbo65rex4242u3swnvvhm@whxmilgtgoyd>
 <aG3hjKg81xrDHjZc@U-2FWC9VHC-2323.local>
 <vksfx7stglvc7dvdsbu6b6eflmacg5eexnmzu47tdkak4uwscm@rm2ilr5ntriy>
 <aG3o2RFHc5iXnJef@U-2FWC9VHC-2323.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG3o2RFHc5iXnJef@U-2FWC9VHC-2323.local>

On (25/07/09 11:58), Feng Tang wrote:
[..]
> 	/*
> 	 * When 'si_names' gets updated,  please make sure the 'sys_info_avail'
> 	 * below is updated accordingly.
> 	 */
> 	static const struct sys_info_name  si_names[] = {
> 		{ SYS_INFO_TASKS,		"tasks" },
> 		{ SYS_INFO_MEM,			"mem" },
> 		{ SYS_INFO_TIMERS,		"timers" },
> 		
> then standing-alone sys_info_avail[] may make it more obvious.  

Sounds good to me.

