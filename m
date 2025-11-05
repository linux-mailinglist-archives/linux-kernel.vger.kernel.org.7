Return-Path: <linux-kernel+bounces-885808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 703D1C33F45
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 05:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D0F674E8B68
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 04:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BEA257836;
	Wed,  5 Nov 2025 04:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RTNBS3F1"
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F334EEA8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 04:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762318558; cv=none; b=ei9QP6x8lcQvFoiGdSywSvpeHSpOyjegKhSiXLedXUG9oIyVtGGtBxP/Lp6qcW5pi1LliqahUGPGbWmIRSmwWXFoXNQiilaRqadAhSAKAmt4SZkm+sJc56d8BVWq197jbskgZcjRJuGCDbk+vUH+IfKf3Evt0YqxHtF9MKTR/Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762318558; c=relaxed/simple;
	bh=9/Jp1GJaR+DA91kgazRavPpRIXOMGHJeaDr4E9vpPdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKPp7PjbU1TiQ2XT72is3ZsiLOu9UyGCq98AzVXFoc/0Bqn7QK6OLiIZs+ij/Cfwo4o9mp6jsxYG8+O2/80ekSVMtQWL4cdTJMWzOD/3aI2yqczn/6NzXF/rhICUezHrr3ZInwIkJrb6XIPYrYG+ujG5pex08NJQ7oNNnIznQyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RTNBS3F1; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so4635370a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 20:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762318556; x=1762923356; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3SkGkbWNd8Z24Uo7RXomJvnc0R5cdaaZ4JC7K8uRAoU=;
        b=RTNBS3F1o8AoNciQwC2J7+5ixOKRu7F2aihDDY4akdN7/PB+P6y8ITNH973UQIQMKP
         JDKneA5WT1wrbbPJ0Q/murNqKXmDnEqlypIMgvu5fLRI2pHnhLP046AL73IV2sRvab90
         BflX/+JKtbLfCBN5z6ptSEUpIlsrX1aef1fsbxkDPPrB5AhqxuDhoSTs0EysSohID5fJ
         i63kgnnX/bYt4N6kB7v8dmnibfYxZJxLP+CdeY+/klPWS/nOsrpMsoianirQ/gRJ1Zzo
         A8sLniJ+jUWDYW7lFB0cOaXzvxQbvpOGJezOqiHyZbEif/bdXVkmUi8bZkfKRlbq531q
         ovHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762318556; x=1762923356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3SkGkbWNd8Z24Uo7RXomJvnc0R5cdaaZ4JC7K8uRAoU=;
        b=urj16Z1sAGic/OeMAZ7R36iGxW3cZN3oEX7bwyYKzTQN+/2e2wI8XH0feJt9U1TNqv
         0ZrY6K1VOZF5HMuAE2H0rmvL7KILvB59v3EwPTckkzjsHOzX9sqaoxTuKQTamdBjOTAS
         G3pr7fwXNjmfpcshK+AAfJi4tDBNO79hOZ6dObT+bNAt4xe7AwLXQadr66tsDky1oauA
         a7aZuClsbppxB9zFGrMaHBCjT2oJFo72xSIaQq1gbovcRR/Rknl1wo63G9wUM2EhL5MY
         fT2L/sb1c/3HUQiUs4VvtXp5rAPDk0Hep/pyxu5+IXceKFfQW4VBkemGdrSkuDjHR1IA
         gdJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn4xM/3CgaExFxDvp6tzqCgpeZ3tmHDMHz/Obn3u1Kqkjv8IhOtefRuZKckIMfmEcU8tbGkTGrFX4IAZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz672A6u/8dH+QcUrFWuXLxbJ5p+bl9RTrklSnNvu7IUqShARS
	vw+Kr1tg0qVluY55rNRti2CGb/fOn2mKZ7tA27/qBId/6H8pQTIfPGlS
X-Gm-Gg: ASbGncugSyM9exXw38kiNX5w0EGP6h/7lYOzWMb+6VZZkzVHcSfIahB/GEz0chqtW2L
	4gOdQPQvPzc/r9DJrK2tZe4b4mFzL7moUKDS9Nh3g1lowrWS05+/3cvqBXh87Asiv3dzakLpvCO
	ZJ5Jc+0IuNvNwcMTrpVw2lYy7b1fiGDYyQbcXHsKPJcMlb/qXra7h8KMnWaWRd37dkoBOMnaqjZ
	pE4Xe0pLIrKIxfgITQX2zxIIRlJ+WiXXLvWi9RX1Rst+mw4W0V7WI8oX3x/TX0Nczn4R7YAlbzZ
	EIS+AdmrjvhClKiNitXJ3UIfsMYBulRQZzPyG5McXTOC8CnK9jyof6LlGH8rLAaOb8/J6gVcLIb
	6fofla6U+IU6f6xNw+YujN8AMdxLK+w33+DaglKHVMZmNPXSpKPx2fNsWzfI536oW3UgjSdcFdc
	0C1Nwmw+kKsjwS3OxMqbFUElD5a+xgUXGezL+7ZhtH4Q==
X-Google-Smtp-Source: AGHT+IFvF4EN2vVaoUdNGQ6tkJuScCUogIfE8EU8w4B6e/v0cer3BAbTDZiqWI1pVmd5K+VZJwdt5w==
X-Received: by 2002:a17:90b:2709:b0:32e:64ca:e84e with SMTP id 98e67ed59e1d1-341a6c4957cmr2399588a91.15.1762318556394;
        Tue, 04 Nov 2025 20:55:56 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:86b3:15ed:c006:18d3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341a68e81a4sm1363766a91.18.2025.11.04.20.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 20:55:55 -0800 (PST)
Date: Tue, 4 Nov 2025 20:55:53 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: krzk@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: elan_i2c: Add newline to sysfs attribute outputs
Message-ID: <swn2pwumb7ffpcyer6n5nn6zbdjvxtwxprddymhxzdjzx4lbr5@hkwusbsr5uks>
References: <20251030123458.1760524-1-zhongqiu.han@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030123458.1760524-1-zhongqiu.han@oss.qualcomm.com>

Hi Zhongqiu,

On Thu, Oct 30, 2025 at 08:34:58PM +0800, Zhongqiu Han wrote:
> Append newline characters to sysfs_emit() outputs in func min_show() and
> max_show(). This aligns with common kernel conventions and improves
> readability for userspace tools that expect newline-terminated values.

This format for this driver was in use for 11 years, and there might be
tools that do not expect newlines. I would rather leave it as is.

Thanks.

-- 
Dmitry

