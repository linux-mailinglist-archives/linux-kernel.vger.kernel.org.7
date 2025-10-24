Return-Path: <linux-kernel+bounces-869353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3A3C07A5C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 20:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4AF264E68A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 18:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65C6C345CC1;
	Fri, 24 Oct 2025 18:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrOCGwZm"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D0E32E74C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 18:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761329315; cv=none; b=BcSyW7I5OK5Jakj+pA/gHYHEQT3PjZQJcQz7YjJoXrnGy8JNL5mrLmJ6DBayolsnQKaiLDq3m0+h1Xn7mPVz+DiGlxorkMOvwwpd7o5uaPFmfEIxALrOFXVmPdptKpHPakPzicIKaTnlfbEe47NcuophqJd6cHqxS6c0lwHnZn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761329315; c=relaxed/simple;
	bh=fs4CyyLRT6dkUGXO5Q+u/hfzegd+QrcsOC6QOosSMeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIP8ajD2BVrUnuIJe8jS+1q6dhnic1hi/rAfN/BmS4IJzC9wVSBln+lDASDA0HZi0s/iP/qA2QO5Yjw3An8iIsboeCZdrk5YbDLuNGWDWNRqDJxPLjsFyXr+eUncheuxKEizd+PYFLYF8rVRULhD+O+NmNDSa9Osa1+oqMZIKac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BrOCGwZm; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-426fc536b5dso1710810f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 11:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761329311; x=1761934111; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4Vk2OMU5f1IjfJGz1tZfU6V+rEtX5ueWDjCoO5ODmWg=;
        b=BrOCGwZmsgvu3f9zdrIVgXYDTOq+Byno1eFHrVSrrVHNRvVFsndTGeN19A7fDA7saQ
         wgGujljhrVX10uWXcmDCt/RkM73MpOHPmjWQNzcnx/DiN3zUaZHqK9YPyquTosMDWIFb
         oZ8xcf1338kr5W38SdBanK7Ar4scefIYFENlts9wKB4d51UXhB3+2b8vNTDpr370K5AH
         w5EQH73EDamXDlPaPv8L0u2WQ8Q+sf0Yp3r4ExIRw6sfGdzJ/LYqEqNckKxtUe25BfS/
         OiwWhSpRNWaRaWhSvnyowoSXUB3YGMaFu74w2cBggmu+7O6JLrs+U7S/cAezfKfTRCbX
         00Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761329311; x=1761934111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Vk2OMU5f1IjfJGz1tZfU6V+rEtX5ueWDjCoO5ODmWg=;
        b=oBl0mhX9bZkJRh/t4jhrHEizdWD6i3+vjmxxcg7/FUCjR3U3BDcLAljvuMGiGtlwqq
         ZLNq7+ZsVKesOSLLwbjt4G0HLK2hdjerXQvNEyKSuRTo4itO5HCS7bIoUEal8Phd99JN
         mTHYkpMts5301/1IrxO+/ietcUYfEjhHBWxUURVd0qCJljqIRwYbucUJA3X8GsMJfTFV
         CpGX9AXb/Ik7/aXi7298EsO39sm2PK5j7ekU8AtwUvWpj3Dg1GTLhUzASPwME/b4LsNz
         NfTqxIximljA054VmoUs7NyuZJUfNZ/gMc8gU0rBODr00tAdfk3mZuyyTSagK2Z8Q7mG
         +HaQ==
X-Forwarded-Encrypted: i=1; AJvYcCViqkYwx+fVMcwUOkv6Bp9XD4f+aLzWanfOEqV6+6n5dzxRg0qhgYfQFcTFC5w5D8env6ZpWV39Kl+r+Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YymH654SZYh0SYbsVDc9zaPCd6YXP01PDIFoPxgiMndAPZxoTx6
	DHetftqngcKncD4FqokWkxtXVEbB81NOcHoXy38k9MNbgRwx1gINOT1aAJSinHNxdLc=
X-Gm-Gg: ASbGncss9lOqS9Xl/s9NKpgLhVyVwhZ8yJ+brazdiAYXegYZmm2CYjTkZbvXcPW/5bw
	ts+xitNpAQn0WT4cC7VzY3b7mBK4dNzYOP0ksM2xweS75Kys9xOlRP8U1fsQAU2C2HqHxWZ1cGq
	2xklc1k3U82MHufTp4fpEmzff/xE+oqaJ9XVcpOrJy3Fshky+NepH8krOt9I6ffmAN5dbQnnHlV
	AV+Kj/6wbL/Kz+GnfrvIzeO35jN3BDLpW9JgJSinC9j9ukcgNk5nDJmrhek8KP7fmLwud3drLFb
	zQmk/JM7EuA2O4n6Zm/7tSgr5/U3jWRFlZIIqwy572ruIS3Jib8GewoPjixD7EPncWnbVt+PNJX
	FdhNNNUzbZb+9PoyAoFcpvveFXub4yUIkkHL+ZS2qzViLFHQSiuuk6EXIw1W0ZDVeG/9lOKGf2J
	ui/4I0Xk1tMINnPC5f
X-Google-Smtp-Source: AGHT+IGdI0GFFF8+9xDCagwj4MCOwEUqB1N0DZpsRtvn/B4KLEI2zmpucHSiVzTvwKt2YEcIpv/8lw==
X-Received: by 2002:a05:6000:2506:b0:3f9:6657:d05 with SMTP id ffacd0b85a97d-429907107dbmr2776319f8f.12.1761329311443;
        Fri, 24 Oct 2025 11:08:31 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-429897e763csm10450792f8f.6.2025.10.24.11.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:08:31 -0700 (PDT)
Date: Fri, 24 Oct 2025 21:08:27 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ally Heev <allyheev@gmail.com>
Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Andy Whitcroft <apw@canonical.com>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Hunter <david.hunter.linux@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-pm <linux-pm@vger.kernel.org>, dan.j.williams@intel.com
Subject: Re: [PATCH v2 2/2] add check for pointers with __free attribute
 initialized to NULL
Message-ID: <aPvAm1E7CvQfOIuS@stanley.mountain>
References: <20251024-aheev-checkpatch-uninitialized-free-v2-0-16c0900e8130@gmail.com>
 <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-aheev-checkpatch-uninitialized-free-v2-2-16c0900e8130@gmail.com>

On Fri, Oct 24, 2025 at 10:59:16PM +0530, Ally Heev wrote:
> pointers with __free attribute initialized to NULL
> pose potential cleanup issues [1] when a function uses
> interdependent variables with cleanup attributes
> 
> Link: https://docs.kernel.org/core-api/cleanup.html [1]
> Link: https://lore.kernel.org/all/68f7b830ec21a_10e910070@dwillia2-mobl4.notmuch/
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ally Heev <allyheev@gmail.com>
> ---

I don't think this patch is a good idea...  There are two issues to
consider 1) The absolute number over warnings.  500+ is too high.
2) The ratio of bugs to false positives and we don't have any data on
that but I bet it's low.  It needs to be at least 5%.  For anything
lower than that, you're better off just reviewing code at random
instead of looking through warnings.

regards,
dan carpenter


