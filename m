Return-Path: <linux-kernel+bounces-898740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C5147C55E58
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 07:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE4FA4E390C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 06:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CA93168FD;
	Thu, 13 Nov 2025 06:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BWUNM/Rz"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F107526D4D4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 06:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763014286; cv=none; b=aTqzNh/XT1Rpxbut9rASnT7YFFA9Z+yW41WI87saHziqvI1s7Qqni8P3Cev89qIoHlWWOf1xaaKmLc7CjFrLJpLnqZqDxQHhlUPUB2aKz914asSpJqMkCLFgFpU6eQztN60s1oJlpRvwlin5AzCzS7A8huKGi8hMMFDLTQexpCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763014286; c=relaxed/simple;
	bh=14nh6c/AcOaAhtljMvSmOFuRFWYKTbrmCYuK0tWzQ5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKhjz06D2k/2HfKLH79ShTKjexSfs59h9wEWzXL6A/zLJIzvnsoI6cQ29i70RZPIrlT070tK/zTN1Yq4//RW1NdswbsqKDrVTi+0hSCsBmIGGG6be7IqXRAedX+ctIzKVQ1Yimio+HYKMAwDOQR4f+eNEkD0CpleoS5i/sNloFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BWUNM/Rz; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2953e415b27so4035045ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 22:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1763014284; x=1763619084; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2LqphD8tGRygLilDfD3DdZsx92tK0p16bJTr+js2PHc=;
        b=BWUNM/RzYfVS7Wt+F9K6vRvFicJ5XkMGF9bqK1GEfzlfRaqQAGEmRvu4YsxnTTB0aL
         nducuswDOBp+9BwBpKOPIGZg0ZB+AiV4WN2BXfZ5sDqklB/nq2iFIXZMESlhvj8uUF3R
         UJ97gpLDjvkUi1QnT5FK5kuSROHe2rrVkwEy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763014284; x=1763619084;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2LqphD8tGRygLilDfD3DdZsx92tK0p16bJTr+js2PHc=;
        b=AsgGEvazOj9jV3eLf3f3MW27AduXouwknpo6dfreDA2p8rv9vHF8PBbJvtcN+HCmmj
         TUGYs2vVTvkVapKh3ukpwFJ0Sl4iNL4j00lk9WX91P1No1DXfRZV+M+LO2ISTFhRRH7E
         jfFHPlzjNGqcIK7X+d27FpdM5NjuY4WyqVXgECoHR1bHbtJldCq84ow3qFAP2RRPLDZP
         69oQuNRnpQqWTT3LKcf0l/VdabacQoEAyr7ewuUVGoi6neJxOKjp5XuETXhHQgmh/bqO
         MWqF2F+0aomJ+Klb9gbEen1j7MLPYBPSV99lmIg3g3DSMG4XPAcAzd69zauZKH6WlrIP
         sJaA==
X-Forwarded-Encrypted: i=1; AJvYcCVabVX411Ofk0diXHtaQGSgGOdyz7yzgMyjulF4IOMkPTCUjUw8GG5mG5PDnrrJMSHwfb/6QaxCbocljRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq6S7n6HGfupTYoIsOEeqrIr92RV3CbdlolIOg5DnQcNokhZyu
	DhtvC4zT04Swimh1daZ/ngbNm4r3EGc7gMn7p1rBjAhITKqCFpe1thZg9spvpisw8g==
X-Gm-Gg: ASbGnct0Odus/t1MRgbRx/MavsopwAqvpnfYOFYef9Pi36MFiA6jJSV0iCZeQG4hIXa
	VSo2xD4iHa22i9MQegufzq6+B7G52xtbm7x4JGEdzma7RS3y8QyUTUpj66byk+ZP796j0DqYQKi
	Qae+uAk1qjjN1al/O5aXDZTxJMI7O+TDvBrYrn4VI4HexjlFrQhEJDOjEL+AxSpuVSiKUFW15Be
	fYXCJPiUDQ5ZKajncJYCKZT0DnMYa5cwZ65OGcOe60Zk2aN5s5IMFFZR1jYOBCo8Zp7xfTlbxz6
	CqDDyfBVOcc+BYz3Dr+dakFRQu8JY0BdAaRr+X6sWF9jhrJ51YWzP10hklWbFllqOw7vuB2BeJu
	fe87lTx+MCsIA9Oyl8mWKNiOD3ifj3DurPdkTYn5Q5NB6GhLgtIYBW8VgwuqnqKsH0EetWHtoUr
	k2iPyZEpKisj6DcCI=
X-Google-Smtp-Source: AGHT+IE7hQS37m/XPXlVQ4Foh9+BFb/rN2BBQKZCymZyiayaTIgspcciVj3iEqly3oeCkfBztppdXA==
X-Received: by 2002:a17:902:da4b:b0:297:d6c0:90b3 with SMTP id d9443c01a7336-2984ed6c342mr74657745ad.23.1763014284214;
        Wed, 12 Nov 2025 22:11:24 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:6d96:d8c6:55e6:2377])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bed23sm11944775ad.87.2025.11.12.22.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 22:11:23 -0800 (PST)
Date: Thu, 13 Nov 2025 15:11:19 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Minchan Kim <minchan@kernel.org>, Yuwen Chen <ywen.chen@foxmail.com>, 
	Richard Chang <richardycc@google.com>, Brian Geffon <bgeffon@google.com>, 
	Fengyu Lian <licayy@outlook.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] zram: add writeback batch size device attr
Message-ID: <otnmm7behvnsbcqmknx45pgonsdvk4fma4o72qui3bjidwfc35@aurhln6nfyyz>
References: <45b418277c6ae613783b9ecc714c96313ceb841d.1763013260.git.senozhatsky@chromium.org>
 <4b7b8f9c68f1a05ec6ada8aa7be9b735eae57446.1763013260.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b7b8f9c68f1a05ec6ada8aa7be9b735eae57446.1763013260.git.senozhatsky@chromium.org>

On (25/11/13 14:59), Sergey Senozhatsky wrote:
> +static ssize_t writeback_batch_size_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	u32 val;
> +	struct zram *zram = dev_to_zram(dev);
> +
> +	down_read(&zram->init_lock);
> +	spin_lock(&zram->wb_limit_lock);
> +	val = zram->wb_batch_size;
> +	spin_unlock(&zram->wb_limit_lock);
> +	up_read(&zram->init_lock);
> +
> +	return sysfs_emit(buf, "%u\n", val);
> +}

The ->wb_limit_lock is not needed here, a leftover from an earlier
version.  Will fix in the next iteration.

