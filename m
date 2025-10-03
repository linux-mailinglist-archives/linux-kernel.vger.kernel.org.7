Return-Path: <linux-kernel+bounces-841557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F03CBB7A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 19:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1CC1887998
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 17:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552352D6E6C;
	Fri,  3 Oct 2025 17:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eyO2G74h"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE032D77F7
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 17:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759510970; cv=none; b=i6OdS0cPS8QGMjEgwhyqO9/+sFaHRQyAmWVXI5f1oNN33d3tQPWj2ncXli399mK89SQiBHBxpfOA67mAiS2ijoyYslPhdS/KUylAFXKU9DWDenBiiqCGMbcyF0FqHs/p6FPLiyIay2yLm9iBOAeQsJrRSHU9nlzAseqEX2x+n98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759510970; c=relaxed/simple;
	bh=uUL4M6USjXif7+Zg4JLkgLeVCj1yxgT886bmk0gM+/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D91m/fRphCR7Iy85fMG4KbjxNXLLOSRt0F+bVlDCeGDBTF+wwVIfkugA0rw/CYyDEmIKJfv1Wg8lLsOHJBmpegEVjkkHZFAUqP/b2VrBwQyCln+8dmUJKceowBlhH1xl58ZjZQVEY40AN92NHDVxf2upFy9b9mCwZrCocetnMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eyO2G74h; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b554bb615dcso1828273a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 10:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1759510967; x=1760115767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hRMekBaFzTjIb38gYN8i89LXzPK5ha2Znw032LPsVsM=;
        b=eyO2G74hdIrYrldzJIgP12opx7vwCRt1H4fwH+AheW/DnOCQBazSiSHKzNI6QMTYmG
         ZmUd9pu1SFT5BIhgI+OIkkE6fXj/6wGa+dpme9oB/nJEBojBpQXaN2UCWYdLw8orAYNL
         1idvVfBTPxIkq8NH4Q9ATxZmrp3hYWwt1kDsc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759510967; x=1760115767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRMekBaFzTjIb38gYN8i89LXzPK5ha2Znw032LPsVsM=;
        b=MIr0sZIEEFKdOu+fHXzIR9qPgPysqCh/KtDIrEkeYy5Kg+uaeBnfyWvovqb949fGxY
         PzSy4clt+hTBIs31ueSBG7AMfB0mDuB7mBg6LJHbU17F2wirXKx5GVupVzUUnNxbBJ+9
         vJBlqrRENj1NxqO3IJ1RChNj0nq5f0hH//Q808q32C58ZuM1zRapS1bbBph9SlQSb87s
         o9wO+34mZUAL/hdMZmZ6t2S4eDGJnwLyhqIKMBYqyViRNtd3skWOb36qYXm14Crj2oCB
         RPJSNNqoFxPi9Sb1OF7+NDVv0ZrMleDk3ETeqIuep2CgrB/9QAPvxOtxj0K2wNxCB68+
         ocJA==
X-Forwarded-Encrypted: i=1; AJvYcCWduASAXBhEJ0QFSqUyZMIGx9ggNSArHqqJDY4M1SWdmcfhcDfRBfAK5FVyVaSXTvNznCtC1Co23lcA2JU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz25pFsXcFDo0RSxolXp5MvvC03niRGV0Gm+Om45T2Z+cs5h9eF
	0RqKEwgUHOq20TO6ZGJYBLr6aq84K6g8ygmedQBL/oJ+jf3T81wsLg8QJ5R37Ce8SFlzwllzZDV
	3+w0=
X-Gm-Gg: ASbGncv/YkN821SqVfnkxMhiCiYUuaHALIhBKd39Qd0Ck6zhE6zxzAXR7BeRzyp7ZAm
	J+OdKJPgvPQ/rEWUYFvUB2powLjW2Yl8WptaFhshaNdtxZzU10VdUdIaXJTi/lw9KqDaN6QnAgN
	rw8GtxjQc3o9kKK8P4HPmP0d0iK6u5CnGZoYexvox8Yy1F/++hyJ2T4qRN9YV5v/hpCXLM+moQI
	d3kkZ+O6frn3U249WJznrZ2s1E4zr8RouW8arBjXf/6Inrmwey0daW/EeL9NDL/UrrKRrnduD46
	YQKf75qpSWRpCCKvYo2oHARkygTDwFhzCydJwgX2IGk981kMHPU7upFfhgeSZsBIJJVSux7uSMx
	B8zFGUOwB5B7jZBNgjLjCQiExC2sN6BCTmc+5/PRyzQxg19EIy8r5PnDxBtnGAJUIQiNSoX50St
	pJAMvgTQtbmbj+rUN8EGw7ruO/0DWP
X-Google-Smtp-Source: AGHT+IGw+xASGD5iDLfdgpAflDlmLL0c/ls7XDKeDwt3g+ZHIWOjmN0GPr8i61t/oBD1yS/q76AXeA==
X-Received: by 2002:a17:902:f602:b0:24e:3cf2:2450 with SMTP id d9443c01a7336-28e9a5cdadbmr43162355ad.2.1759510967432;
        Fri, 03 Oct 2025 10:02:47 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:9212:ce9:ffd0:9173])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d1d5358sm54712665ad.103.2025.10.03.10.02.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Oct 2025 10:02:46 -0700 (PDT)
Date: Fri, 3 Oct 2025 10:02:45 -0700
From: Brian Norris <briannorris@chromium.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH next] PM: runtime: Fix error checking for
 kunit_device_register()
Message-ID: <aOABtRxgm7maMsy_@google.com>
References: <aN-Xe4lgox1cCAaR@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aN-Xe4lgox1cCAaR@stanley.mountain>

On Fri, Oct 03, 2025 at 12:29:31PM +0300, Dan Carpenter wrote:
> The kunit_device_register() function never returns NULL, it returns
> error pointers.  Update the assertions to use
> KUNIT_ASSERT_NOT_ERR_OR_NULL() instead of checking for NULL.
> 
> Fixes: 7f7acd193ba8 ("PM: runtime: Add basic kunit tests for API contracts")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Thanks for the catch:

Reviewed-by: Brian Norris <briannorris@chromium.org>

