Return-Path: <linux-kernel+bounces-828365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB97B94774
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 07:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F3217E3D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 05:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CBA30EF76;
	Tue, 23 Sep 2025 05:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="egk5++fv"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F66A30EF63
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 05:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606221; cv=none; b=iJ5AYq8/VBiAhpgu0d4hhx+ikxceuON9mBBDs+CnCLdGNWj05vDgu8ZmbpjAhFXKT/JdTA2zVAy38+UFqi+ZnrAUVquRnjsHzFV2eJYXjjqdeV7Hust8XkkNNhzDxkyn4pBjTStL7RAQhb+oW/gFMVZ0RrB5PAC12b5KmVsSjsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606221; c=relaxed/simple;
	bh=dVn9dbz/kO0mpv3IScTeJpkZ1v06TqC3yVwrf6YJ8Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E4aIYXc1OT4dsv47BMp58w9pCnKsKD8653yr4qEJ4g2TlQ8RfbGvpcmJTcUUw5eU3TttGRZaPN/Nijd+Qgec1fCYdjggEaoH5AnfcuSZ/RMVtwJmatZvBbx1+fn2IsmPtSed/YVvhLGOAVCMBxvkKTZ0vRoAvvklHF/KMjq62eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=egk5++fv; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee1381b835so3420964f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 22:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758606217; x=1759211017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCXbeilKuthgziM3kejQj1ZvDe5vwkeMiKIsYl7n/j4=;
        b=egk5++fvB7fFvb2bJdrxDTMtxT/lEX9RTbWRSSqSmJyruXoAHGhH0OvdNpH6jTydU+
         t55tddSvGvpA/pMOAJ2cJb2MKSiHUprcq+TklMZFtNVAWZ2SonM9cI/Q58ucXVHZuKSM
         TjY/+EFuZZmqrYQIYhgFVTuNP42BjLS9xE6nTano7cMy0jkPMRR7QCR+ccrk5i5OaeIg
         HbjSkjZ4bFkKWUlzB0KqOfjL+t4ly4gdnGrXZPEbpfLnyfeJ2bNbPO9f/1ioMjPoTj8o
         Kv1+lstKQZtcaL11rdi+J4X8lol5RNEKtYdfwwSmlpwatEJozCIC5VJE2nmqu/qUjZfx
         ElvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758606217; x=1759211017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCXbeilKuthgziM3kejQj1ZvDe5vwkeMiKIsYl7n/j4=;
        b=D2Mf5vH7g+m8wADwMbnqhT6u2GJqbTRJo9SJ2qNmPfDIYappbVkcXbTiRkEm93aDuX
         yyGoBnGEjxobj8fmr9KGWis0QRQ3R+itVgYL2P+jLrH60jb2AXdvTyzLla5t48s1AeID
         p9kbLA1JJlHkha4djabkzLZsYbi8W4nLvJPcczfn+lfFvhJMFolAxQ76WhX9qzDUQJZs
         rME0v/3ff0SvfPkk3wfrJ8Y0NloTIjDFU+Uugkm2PkQ9J802bPqtLoB6zbqD4vIRp6zV
         jRDvH2NxMDhvIU9sWUqzWVq8IbjmZ7E5zJbnw+QB99rQdwEJZQ4QWIJa479D5391eyeJ
         34hg==
X-Forwarded-Encrypted: i=1; AJvYcCWqAmLwH5sjZXO3CBdB1DxOtcE73JIQNgziNhTg8z/dBC/4oO2iOEsIwUMcm1j4dynKWq+fAJehYu2r4Lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbWqy9eoRLbJDcBV323qw6eGt/5uY8GHexzxEsQTR1S55eIACh
	fPazNUAmhH+bTAHoxho49JU85wCsOxflwjx0sMjVt2sDdFdJwZ+WhQYZrYvpUdBf6lc=
X-Gm-Gg: ASbGncu3VPDnHAnhvds3wMOmAez/OqHYpL4tzz/sy8fQEsQCy3hHDgPnwE/dPuB9HXD
	eYfBtigka8p7HociU5MXRe2DkSk+x9e2tVz1QcCnss2/dO6pZB2sOJWYNlVgkiCBCVH8hFOUa7b
	YQtunE8jUdV84APuINeweRBPdRTRcrjkxTlqosqK8SZDo/dwckW9U/vQAuvbG8o3jaH79jGZB1t
	g+//L1QeKN5xYaGCl1OVBEw9nZWb3VoGMlSn80QPUEpTJ8jRxaJ+Tx/okdUsEz6+J2msebFCrnL
	C3C4qD+/8RxlgxtnBEDkVqaYSG+ZenKW6B739a19gf7CDDdNsFmINRRSiEfRkFodq1IJnluM+Fs
	LZeD2kNwpYxqrP0BES/LDj3N+tFRQ
X-Google-Smtp-Source: AGHT+IEM+qI+wkll4yXIDQPALD07c0wXIM5SX3N4XVyP9UljJExIym/bakqlIutoRVJPQNlIn4+xlg==
X-Received: by 2002:a05:6000:288d:b0:3f9:141:540c with SMTP id ffacd0b85a97d-405ca959d6bmr651083f8f.40.1758606217290;
        Mon, 22 Sep 2025 22:43:37 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3ee07407ccasm22469588f8f.15.2025.09.22.22.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 22:43:36 -0700 (PDT)
Date: Tue, 23 Sep 2025 08:43:33 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ma Ke <make24@iscas.ac.cn>
Cc: dpenkler@gmail.com, gregkh@linuxfoundation.org,
	matchstick@neverthere.org, dominik.karol.piatkowski@protonmail.com,
	arnd@arndb.de, paul.retourne@orange.fr,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] staging: gpib: Fix device reference leak in fmh_gpib
 driver
Message-ID: <aNIzhU6m8zgxk-Li@stanley.mountain>
References: <20250923013603.30012-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923013603.30012-1-make24@iscas.ac.cn>

On Tue, Sep 23, 2025 at 09:36:03AM +0800, Ma Ke wrote:
> The fmh_gpib driver contains a device reference count leak in
> fmh_gpib_attach_impl() where driver_find_device() increases the
> reference count of the device by get_device() when matching but this
> reference is not properly decreased. Add put_device() in
> fmh_gpib_detach(), which ensures that the reference count of the
> device is correctly managed.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: 8e4841a0888c ("staging: gpib: Add Frank Mori Hess FPGA PCI GPIB driver")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---

Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


