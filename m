Return-Path: <linux-kernel+bounces-786451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9F6B359FB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 12:19:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 435BA2A6C54
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 10:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0592629D297;
	Tue, 26 Aug 2025 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uoKKX/sD"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01C91EE7B9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756203557; cv=none; b=tkAzq7TGn6sqG51c98ZJ8/C2cUBuL3ZgyQL5htBuOyAx5KozD08fl0mfnONA6L2kJE+xL/1g+/sEF0ZvIrCEPAwAz9Tvqmu/9dtM3vgx1pXB55xUx1uq4sl9CNj3EmBLx0So6XDf7IEplRbpdyaW3HXPOm+ThKuB8p8jZqLbFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756203557; c=relaxed/simple;
	bh=P9Vdw9iylpzk0qKP9kKWFec9BuKBYaZ64z20IOqIxAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pk4yDZ2NdEnHF0V0uU7geqxYbrKknO+LhKostZJbx9eu6oumwD3MgaiDrBxdvxgIrZc9onYLl3bS/MBkx7bd/1QIF5wW0YkC9sXlsqhgPuxZZ4kuWfrXRPTqclr8UIcFmlJtkShlQzogInX9/ynds6FlqxWK3Q8/Bb7GRfBqwyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uoKKX/sD; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3c854b6459fso1585850f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756203554; x=1756808354; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KA08p19n2dBZD6F6oasWBo8WpykXDUnkHMST64oT7b4=;
        b=uoKKX/sDKa/x1ptQtiT+iFnbOImipNzAu4AIzS4xxj2UDld7NuJGvxa+J/nXS6u4s+
         3bYzXSKhjc5woOnTMrl8JFDGtALtDG7AM8b6W3CeboLPFSQ0AUZGLh9qsznAXII3/fjk
         lxv24ulXkF/SUeinL85lNANU8QhpAOUfzdPxl8wPxG6UQj5i/n9yGm4F3xRfUUHauRMU
         o1EAmezIHiyrQeBH2cscgrq7wOQg6HTJ1mIjNBRQCMElQdtAsmlfepgeZbMMfhdwraNq
         QfEoxycPJlkjF8QZ9ykMCiKO2v91eEV9gGZPzAAEZCAy7ZOzad+iEvmfBDbuFrQ9zd0y
         cu5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756203554; x=1756808354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA08p19n2dBZD6F6oasWBo8WpykXDUnkHMST64oT7b4=;
        b=NwUBq9EkN5afZ8TKB3W8wk8u4/pftui1wi4PR1oljl3rfoMsiiHAUBSXub2XNggkSD
         GmjtnUZg5nTrL/VvHXrADyMXHX4WKDdm5YVR9t51kutjArIN6yTH6DbzwIxuIsDQSF38
         vweDYXARd+Cy+gduXxLLKBoqLBAiVEVu5ejbnjcm8H0RfZyQiEqT+4Sgl/uTZWpyC8fT
         mji/3T1HK+5sYCqrPuHN3GS5HpmfSCeH8e5nuIqY8Z1bcXr4YAAglXSXAHcw/O0dpBqX
         bNF6c7twf5Oze4JpXVG/mkOR8dSHk1s7CDaRcyyo0qGsVsDmKbR9PNpK5/8X3rR6f1Cf
         Xhnw==
X-Forwarded-Encrypted: i=1; AJvYcCX0OhOXp9XlcEEs93122OU4rZZwZg0CVVpiwJ4jc7WzQNpISOsAKl4ReyyVzzP7jNBxUmpSwBN3Qhd63Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi0W6c0jlxV6YuvugeTBmwk32lyowuxzcyXj00c7jaND79P3IC
	RVpwWgKKa0masQgW4wN1V3Egqnbc+VPS0Ev6JNBBqfE5YrDIclHMky3zcJeiGyPNGG8=
X-Gm-Gg: ASbGnct1PmQL7DmfoX2K/+4LubtLFtFwt9zZVvg2rqacgp0B8x5XGc+A/o2U+0t+66X
	XpQLIUsOkLQDWPGArbOrUoXbM6EyLoXu/d9tRor50LLKpFIPQVvQTNQ/i8meJ+CPlW/id5ogAFH
	silUlh09SjkzQB34DwQ/t9rxOSdYmo2w+ZyAqNzBRq6d8hW5ntTKhLSnIxn1MlEdcqfoxadKKYP
	yTs6ccIJXuLn9OvvOhKtldDIGvv5TIfSEKh428bh1TIW6W7rifPjD6+XPZq3KwzMz5/F125wW2S
	3G+pBStEHveGm90M9fO66w9i7VtO2FkbXE4s4ZLalX6ZhwID+qgad4ktEprWCjjqV913KQxx0PS
	IvFp0rgZTj2tk8sh4jXJlumTAi/8kfNxYalA4kg==
X-Google-Smtp-Source: AGHT+IHk9cosoz3/LRw9lg5Dp7C24orHPU6oYSaVahz4ew+BPbdCGzHMxX5ITzmTxE3NR4Fgi9pymg==
X-Received: by 2002:a5d:4846:0:b0:3b7:6d95:56d2 with SMTP id ffacd0b85a97d-3c5da7402e3mr8297216f8f.7.1756203553895;
        Tue, 26 Aug 2025 03:19:13 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3cc0ea9e0d7sm27392f8f.25.2025.08.26.03.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 03:19:13 -0700 (PDT)
Date: Tue, 26 Aug 2025 13:19:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Michael Rubin <matchstick@neverthere.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: use int instead of u32 to store error
 codes
Message-ID: <aK2KHhaFqWbd5S_O@stanley.mountain>
References: <20250826095907.239992-1-rongqianfeng@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826095907.239992-1-rongqianfeng@vivo.com>

On Tue, Aug 26, 2025 at 05:58:59PM +0800, Qianfeng Rong wrote:
> Use int instead of size_t for 'ret' variable to store negative error codes
> returned by bb_write().
> 

The commit message needs to give a motivation.  I would have assumed from
reading the patch that this caused a signedness bug but it doesn't.
The commit has no effect on runtime but fixing the type is a nice
cleanup.  My commit message would say:

The "ret" variable is used to store the return from bb_write() returns
either zero on success or negative error codes on failure.  Storing the
error codes in size_t which is an unsigned long, doesn't cause an issue
at runtime but it's ugly as pants.  Change "ret" from size_t to int
type.  No effect on runtime.

regards,
dan carpenter


