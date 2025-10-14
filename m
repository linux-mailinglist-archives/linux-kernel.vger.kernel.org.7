Return-Path: <linux-kernel+bounces-853148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B63E2BDABFA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 19:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7EB654EBB5B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B24305053;
	Tue, 14 Oct 2025 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AsNn4hj5"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A23330102F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760462034; cv=none; b=fgy+h3f4idiBxXnBFewAsQUthA30LwVTY80TXhC/x3ZhEDSEATKOlMPj11WH9Dmur9RodsKgFk2Vk1AJzf6ynVM+QbU4b4s47SLYDMXGtKswZkY1qYpIckdhYVLvMZrAnddIlyfmXaSMFgRgf9tJ9IRZ5oL4i1YnTmN/lP/zqmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760462034; c=relaxed/simple;
	bh=GpTOiyFRtNdaMSqi/bYVQ3sJz6AasUzfc3zGOwHXihA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lr3rkLzMZdh0uESiNNKgKAQMNG6HVRAlEEPjxwLOX5asqdnfJT8lT2lp3zb1wNJAIWfzTJz+PG97R6oRcEJTxdyzYyEeDUauLgtcRlRf7wsS9B1dD6vGO2x/NZVqNY/gtjwEZo6YEiB2KdOaMu/Jao0yNS3yUaTqSOgJQHxYLDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AsNn4hj5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ee12807d97so4050420f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 10:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760462030; x=1761066830; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y/vYN9+i/8qfTPL7Ep/qCKS+DKMGJXilpY9pRGklEdw=;
        b=AsNn4hj5i95QOIk/JTXh+7XpbtUUdTcLalgw+AMgdrjASvzg5Kz+XfE4JtPELgNAMD
         6XDjinZqNKZSZhx6magkIlvWRRvme1G9UKeTIMYx7vUClP7qY4Rgzgg5LV/CwYzOMAZQ
         8sUukUYSC7oE+cXE/OSUlZjTOJ783/2TMXfUOio47l0i/xDht4rq2lkxKPtjxPs4MAJa
         Wv9mCkZOHBzuVV8YqizfiKvUIS76cikf+BPog5RXekM9ExBUicssHEKsG5fz8K+9qRou
         UvuHkOcD7hw87JhpeOOZc6eVsq9TAxHLPD+uIwTYV/89VD17RUIdrzZ7AuomTn1/fRri
         nM8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760462030; x=1761066830;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y/vYN9+i/8qfTPL7Ep/qCKS+DKMGJXilpY9pRGklEdw=;
        b=UfwQyDskHfTdFWNM4n39sIOCV5oIuoerm1ou32b5vZThDtfkyLVvovHDkXY0v6dN0x
         7bJKO8ORneUc6n9nrOGj8iVT66VUMRbBJ1Hsd09TcUQX8BlR5giVrY/ofWPZTJNmAMO5
         /8uNkHgGcJGWHzK2gghFsWH8uGsBoUCv0z+COkRxqmHaXoidDgcjV+u2GW726wI8Zkxs
         2WQuxhZxXLb3NA9qMu7bPC74qHUC4TLx3ch8OLAEE4RTaELZ9dAiV22ZAN3uIszElkk/
         SiHPPlgc94s5FVVHFBt82GDCAJLQLCDxV1LSudYZAcBonrkgO8LbfyuXjtG9H1cU8BCi
         JQ2w==
X-Forwarded-Encrypted: i=1; AJvYcCWo+jf0XNl2z4ks3H0c/iv3sM/OtvzA20HLBi6FHmGK4Vh3h0UExzqQNqQ9Q7SuxqPopI/Tr7C+MVOeKvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCbdhJlKJztg33NZHg7Sg2t2lw3bkVHD6yyxnkI3JVaoNZFqXC
	9ImODpGxHxtX0jAe4DwhRLbgWz18dYayJIRN4LuRRt6BQALPDrV7jBP+0yloeny+jCg=
X-Gm-Gg: ASbGncsv3ctsqHDQWPMz9mRojwhk9woZpxksm1sz4pSrKvtuVhqQcyptOn9Vj7GZZf+
	Ocr8zFAQsvjdqvgUGZz4koMEwl7AQWXvZugaU8bJQBdwPHrRmyEU5Va8wwO9IVtWeRe+hc4VtVS
	nt4Lq2NjZMfFXaaEvKjtmMxSPgc2QeXIy5wGtVTMcX4ZqS8rxxW87Wzsc/6YInGxTtgh3SotqUz
	SJxr8dUiTLi3VRgDNX0S//Y/X41mOi1bpz3XV15Hvi9P/aEu87/P4OLoBnnhW1P2ICSmrT89+ud
	lTo8v0AdkZ6suW29TqRKGZ1l/u2gcAZ5WUjVoCg5LNkZMnWpT4e4CYM50mBhTDjvckAS3YcVTE3
	fB/C4CWXMURDgBK2T03UCaTbGN7u/Cvp2TRwKuNeNrf26GCnKHviOLzNCAQWM7g==
X-Google-Smtp-Source: AGHT+IGGYXaAodq6m4PGqBgRPauJSJZxd04u1Kj3/fbCuSDrFC2zdB/eMxQhep/Yh0n+luFWoRrXaw==
X-Received: by 2002:a05:6000:40df:b0:425:6865:43fe with SMTP id ffacd0b85a97d-4266e7cdc9amr14865200f8f.2.1760462029517;
        Tue, 14 Oct 2025 10:13:49 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fb483bbb4sm244163775e9.5.2025.10.14.10.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 10:13:49 -0700 (PDT)
Date: Tue, 14 Oct 2025 20:13:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: gregkh@linuxfoundation.org, johan@kernel.org, elder@kernel.org,
	schopin@ubuntu.com, me@abhy.me, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: documentation: replace strncpy() with
 strscpy_pad()
Message-ID: <aO6EyUVO9EOYfzV4@stanley.mountain>
References: <20251014134148.2597178-1-vivek.balachandhar@gmail.com>
 <aO5VvrKTswmfO-n9@stanley.mountain>
 <8918310c-d0aa-4e02-b9d4-9aac98b0a48f@gmail.com>
 <aO5a9izAISpCDJrc@stanley.mountain>
 <8f550b4e-2b7e-4266-be92-bb724265949f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8f550b4e-2b7e-4266-be92-bb724265949f@gmail.com>

On Tue, Oct 14, 2025 at 12:10:50PM -0400, Vivek BalachandharTN wrote:
> Hi Dan,
> 
> Thanks again—confirmed the structs are zero-initialized before the copy.
> 
> Would a minimal fix that guarantees NUL-termination be acceptable, e.g.:
> 
> strncpy((char *)&intf_load.firmware_tag, firmware_tag,
>         GB_FIRMWARE_U_TAG_MAX_SIZE - 1);
> ((char *)&intf_load.firmware_tag)[GB_FIRMWARE_U_TAG_MAX_SIZE - 1] = '\0';
> 
> I can respin as v2 with the same change applied to the other two
> firmware_tag
> fields.

Sorry, I should have explained this at the start...  The struct is
initialized to zero.  The strncpy() copies at most
"GB_FIRMWARE_U_TAG_MAX_SIZE - 1" characters, meaning we never copy
anything to the last character which stays as zero.

regards,
dan carpenter


