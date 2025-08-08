Return-Path: <linux-kernel+bounces-760135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C687BB1E6F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D960458087D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC1D223710;
	Fri,  8 Aug 2025 11:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="W73+F8Lp"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A6853BE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754651211; cv=none; b=bhl5zua2oA1agpRw4/wtKjnX6IRzNMW6zYYY3MGtTm/+t+V+ILo0BFOfFHtHpC3xPWkn2ByywOkwr/OETfOmIVHB6fz7sQ02D31h4Rs0qcf+OwIv8LN7dPAzid+ZVdUG76o9lhMG8+24QT34xK6xiuQcD5vg7Tk+GxNmMvTd90c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754651211; c=relaxed/simple;
	bh=fah6fDAHPsacje0Bek0+yZMl1AG/AjYc/B3XNcGffoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kDxWL0+H5j/P+Rh02iw82KIyGBAUkljMS8OE4KQWCk9qa1Lhc4nWQcBNA3EGfRdUqvM276z5OyS2WcieXCCfIMCh3TmtYdwW9maNuz04UaMn2wt6PYLS+CsK0ATW+2tTHv8MJYajtCk1y1mWkrorjqi48FY7zPIq2fIm4rH1CB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=W73+F8Lp; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4b0770954faso32741481cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1754651209; x=1755256009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fah6fDAHPsacje0Bek0+yZMl1AG/AjYc/B3XNcGffoE=;
        b=W73+F8LpNbikggari7nXpys2vzhOVpPkRkzdo5DMl3VMsI904T7LTZIpwO5+/Xv++G
         Y6Lneyv8W2/kpXML5Pgi2GS5khpWXhAYMEkRUq5yaWGUMwoo7dgRCz1MR8TIYnveCGFf
         RxNGsCKRMuL1fV3D9J9utCejnaq+KApIpn9iy3gly/499ErUHNdalKHm7pzqgMEblmrk
         zXaN0qwG1yTZ3YMMMIAASn7d6toYVBGJWIj0L5zowzFmEgOCdSnCjgVtSW/bZuVpKrBB
         rStZ7IOItOHyE8MGkyfTb4Oxn/EipCrTvQ9gtYHBv2tppEnOUcPixwysKhbmwdw2fY9T
         l/kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754651209; x=1755256009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fah6fDAHPsacje0Bek0+yZMl1AG/AjYc/B3XNcGffoE=;
        b=RhhQ1CKy35WxVS0Fd5QEUJGvoPaPTU3p0ZwXmsU6+w446nxUYEoZ1cjARqRm2j7F0n
         OzgWMctsbmYqEfaKttQW9LYGXKozJVJ9NXTRVyDpDZCcsPKI1h7e1v2zk+fKc+7xS/6k
         VqJBe7Ag5LBmTHY79LMO29XqG7Ie5TRCFUQhafgWO2YytxLmeoIIv3F4aXTLd6fo79q3
         4/VpfjqYtub7w55K7w+Grto+ZbUP2mWDlxk+jv+mGiZfmNl776BrMhlsQWBwHdIafgK1
         1MhgncV9tMywwenZEtfNPTGp4iXQw7bW6cqoCAFApbN0jZ2c4R/47TTedl8hbGv3N3fs
         qh8g==
X-Gm-Message-State: AOJu0Yy1oyJtnxpcK5tM1EFdahsRGPRUniPOtkwg0O4UeShP15JLvi7T
	IWliBdONuazJ+hTuc0nffS/McbgVxNxpfI3iC66I3QSZDJdYmj8OwqsutLwv4kiiPQjhA6/qaCT
	LeBjgqRTQ7ubZPsb9B+F6cguRSlo9tLEn1S1rlJfjww==
X-Gm-Gg: ASbGncvBNMdfIXlESGeuHbSE0OzB9I4CgpECA1o55JT/fKs+Lxu5P4nO0jbUvvRPSVV
	zuo8rFzHMumYcbc42VmrCGjzNXEV110ckHWg8ppi83vP7ROhqbfZ0A7pYcpevDZlO6OiC5aPNAn
	af2mH87Zn5+Ve2KPUqaHz2NtT8a2VhOedZjwWuGMUQ/nerDNf09bdALCpqb4l/7StMMtmVGzoTL
	1pYwVo=
X-Google-Smtp-Source: AGHT+IEOmZWups2hN243iqfjpByJua2uFwUShIijfWfI1uxkQNIXMHQ8pxhoL0a3kOPMvbSICL62EXJEvEDnDiUIOx0=
X-Received: by 2002:ac8:7d89:0:b0:4b0:8092:9918 with SMTP id
 d75a77b69052e-4b0aec614dfmr33698741cf.1.1754651209282; Fri, 08 Aug 2025
 04:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250808010235.2831853-1-adrian.larumbe@collabora.com>
In-Reply-To: <20250808010235.2831853-1-adrian.larumbe@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 8 Aug 2025 12:06:37 +0100
X-Gm-Features: Ac12FXxZaEscduPvHH0B0nLaHo4tpAPiZNRtVv35--KBYHU6yGJnFgpNl8UoigE
Message-ID: <CAPj87rNnjvsJ1P89dv+OtawBXTLwfcaS41mzOL9Z1SwtjRcVJg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/panfrost: Print RSS for tiler heap BO's in debugfs
 GEMS file
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Boris Brezillon <boris.brezillon@collabora.com>, kernel@collabora.com, 
	Christopher Healy <healych@amazon.com>, Daniel Stone <daniels@collabora.com>, 
	Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 8 Aug 2025 at 02:03, Adri=C3=A1n Larumbe
<adrian.larumbe@collabora.com> wrote:
> Otherwise it would display the virtual allocation size, which is often
> much bigger than the RSS.

I've pushed this to drm-misc-next-fixes to land in 6.17 with the
original commit as well.

Cheers,
Daniel

