Return-Path: <linux-kernel+bounces-872226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA5DC0F9F1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 18:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9F6104E8472
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB503164B8;
	Mon, 27 Oct 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UypOm19P"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998842C11C2
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585937; cv=none; b=kd2yELg+N2zW6830hT7W67GUbCmwsaIrOPdFcKLVSqqXvUuFV8IKUyIW8ZA9TkONEW5wmafaMG+uZxL0S5Ti6zM61i8dqZ6nIFyZ6XfbKZwfOM2ohA/i9ZvanAKNOinmoP8QNC0BKdHWXYu9MTEeQiuVhGWuTQAgVGsAFExI43k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585937; c=relaxed/simple;
	bh=HAqDcgGMjKKzyDltuxO03NIXefnszZjB7wdrs046Gys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjWQOrppTZTeYTVn3IFUCpE5gBHQf952YmY7+NDNJ/JHHxu6aVCz7A/DWuHFjmUjX3nDq6YSqohWz7TWid0c5ckSw+HL2CBVNQ7WzIh7Vn/+4vJjmOme7Wr16+Lh81GyWCRGpt8sQUu+Mzsiph2SR3fgrcpFB4aFi2spuw8hYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UypOm19P; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-78617e96ae1so2503857b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761585934; x=1762190734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ/ydtqR65wkobsTKCpney8zjIjx42CMb/k/gju9QlM=;
        b=UypOm19PIaJXT77Hrr6pWAUNTOqddsoLus5KTq1conazITUnHnyPeEubbTWMTL5CEZ
         oZgZQZYcB7xEbAVXGmD7ci7W6P1F69Bv9w+uC53x8yXeB2z0ecWnIp+3UI5DWCwKr5bQ
         z66vb99ZeW2530AG0GGcastxAQ0Fr/AoQ7Qr4z+fmpX7ixscRod1ZP2/6UPM0PUXk2Og
         BpEAeSZI1kBQXMPcKX3fRGep94r0IQjhp6L4Prj3FvdparUhGQUjwp1W+PrMZm6zEAzT
         5RQx0Qy1G/1HT2Sg/atd5PsL6srvd/VGxqvZWz0h4xWYOEm53Wbz333h1eKbaO///0si
         mv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761585934; x=1762190734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJ/ydtqR65wkobsTKCpney8zjIjx42CMb/k/gju9QlM=;
        b=gkrbtUqtmjbmMyV/5YR2YZBFyjPOjTRwUAij/+V8nmjS2STooo1348Kleh7ODceQED
         i2Do1sqwGs2HVhPMtmbL5VRLPfjjLO4PqGOn9EY03pGZYJOJlPJl49gizCQxNEV5Q5Yy
         8t0Al5LT9eo2+0ZVZ/FVqAIhQAlOqkDAZ1+nxhDwQhXo7u00g4dknR0UpBxcUHA5me9i
         hwTg70SCUFoammotuyIE6XGhfzUYdRr3FinHJj82cGRRLa/fcENz1133O9DOGSidqPA/
         PQNuwESGtKWQo46UrwmVumZ+JrjlpjLaUxhyELLwjN3sPc3J1ltuvSySqUFGZipqcSGV
         bNIg==
X-Forwarded-Encrypted: i=1; AJvYcCVR1PQoYR8whAuxVUNSzd+Qqr/TMfE4V62f68Iq1RQhlcPr8/ZoOSx1lFTw8pzBRcdLgTjH/dXpvQ3id64=@vger.kernel.org
X-Gm-Message-State: AOJu0YymYmcaDzWhVjuMJPWQ0HfXYWSXBkaNhg8vOMw1jabOBJ3l0o8Z
	quip5hr2UH9hCIIsHYtjYwtmEiV+6zMrYonZ8t3Fk3jDznAPzzrxwcny
X-Gm-Gg: ASbGncvAE5Zok1GzQgfoFH7Db01Y3wbU/99wD3LoFmtLCHV+eQ9ZSAc8kJYNlEtH9nr
	06N2mgNHyiS0rfEQFCvx98y8n/LxcDBg2kJ00d8/nY2mGXNooja3DF3yy7H5Gl1TUxJmTjuYCWn
	2XI8f2nV/PmEFxIXbi5ntc8sh1XWuEJULd3hr/Bu3oOpMULcN3GyHFQZ31XjwiFlTNHCbALsKrH
	EHX8BE4+lZzfkdC0Plz84Aqu3QzBM3YeFVud1IPixNkxnG+75Su6ZPPMQ9Rjvlis2k161dziIr8
	Q5QJdmiujzRQ20rPUDgEjQnksBr9y/GuVNsYJMO3lc6Qi1oyXaOGAAC91wP8bByEGxRCoCkLVmQ
	vxbY8blR5/iPIhMphbx32ks/Z5IWZQrbTGbREVxdja/6Tlq5DsonliRj17tzqQ3Ds2s+34GQ5y5
	mUKhbpkgPDofIp5g2+kMVTz/3zDDk+vRFIJdg=
X-Google-Smtp-Source: AGHT+IGHTF9vBtn+seygObOHlL96iKi+OVb+7MtjlE9jx6wEi+MY/OkA96sVfPPxkYnPfsaXOqXkAw==
X-Received: by 2002:a05:690c:338b:b0:723:bf47:96f8 with SMTP id 00721157ae682-786183ab057mr5505517b3.53.1761585934504;
        Mon, 27 Oct 2025 10:25:34 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1423f5sm20564397b3.5.2025.10.27.10.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:25:33 -0700 (PDT)
Date: Mon, 27 Oct 2025 10:25:29 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 00/14] vsock: add namespace support to
 vhost-vsock
Message-ID: <aP+rCQih4YMm1OAp@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <k4tqyp7wlnbmcntmvzp7oawacfofnnzdi5cjwlj6djxtlo6xai@44ivtv4kgjz2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k4tqyp7wlnbmcntmvzp7oawacfofnnzdi5cjwlj6djxtlo6xai@44ivtv4kgjz2>

On Mon, Oct 27, 2025 at 02:28:31PM +0100, Stefano Garzarella wrote:
> Hi Bobby,
> 
> > 
> > Changes in v8:
> > - Break generic cleanup/refactoring patches into standalone series,
> >  remove those from this series
> 
> Yep, thanks for splitting the series. I'll review it ASAP since it's a
> dependency.
> 
> I was at GSoC mentor summit last week, so I'm bit busy with the backlog, but
> I'll do my best to review both series this week.
> 
> Thanks,
> Stefano
> 

Thanks for the heads up!

Best,
Bobby

