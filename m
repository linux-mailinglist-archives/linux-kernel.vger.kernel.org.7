Return-Path: <linux-kernel+bounces-887553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D83C3881D
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 01:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97713B0AA4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 00:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1E71ACEAF;
	Thu,  6 Nov 2025 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxYZZLVR"
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31FC86353
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762389725; cv=none; b=qZ3PB72LbwRO4Y9zyD09Ps31X6PKxg8kLq6Ml+S57QJSk5FsRtbVKU6/f0PfJta4+i1xksiD/Qth9J1aq41KLCpssM1ySHfK+L8YlOE5MYPZXtnMorRP1tTi9MmiAE2fxK9jd3zsa7aAkd2qTCBlPVGq4X8F3e+UxmrPxqzl6TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762389725; c=relaxed/simple;
	bh=IlSwVwT1VuvzUynUU4Xj+hFZKWXPHeFJ1t0CgyLYuU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUdD8NeK/dtlp+JYc+1akG9QJiPlEt5gviWR/+bc3CRBr2wue8BJ+yzTvwBIo1u10M8XDb1IGEz677gOPAoBMVb6M3xgERUKH5NCZXiEfql/5s7AbFHWOjetramkAGm1EmF5k8T5mLtLJODO0CEom//gijkM21c6xvB8oEmlo68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jxYZZLVR; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-77f67ba775aso568124b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 16:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762389723; x=1762994523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IlSwVwT1VuvzUynUU4Xj+hFZKWXPHeFJ1t0CgyLYuU8=;
        b=jxYZZLVRmKD+A/1jnQUWCe+E+/WBS48P+l5h9b7jghDKwZkyINezQhB/k2bxPDpl2A
         ueM92wOHyvjh/Hf0zfaU99gs/2RwMuGhoEvXSQ2uUXqEv/cE0GuVzlI41baY7+kh1nRR
         Oq4xQfi8Y+4tmuvyxE2CFmilTWQdV2ERTMjT13C6fitbHMYjcRxJaxb8S3YkbOGN97/R
         uEnV1gZjzqeRECL8sbVabcpLstDsGeOW3i1abup15/srQikrAyoChfJ7GCV4qntBtMTq
         /4Uc7sIXMkTMW1m8BYzIv/HvzUN9/0CY19+KqNr+eDWoK3MyinE1x3Xh8kI+pI/QGhDd
         gEbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762389723; x=1762994523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IlSwVwT1VuvzUynUU4Xj+hFZKWXPHeFJ1t0CgyLYuU8=;
        b=Yl5WP19jWyv5ou/T4WXaxB47s6neclS/L74yHHaTCJOVXq3mFmO5Na0JCRsLZgEWz2
         JeiijI8dvooqB1qkK/LKwZLNsIyJ4+EevMP3hWK/WT1prsYGbDJqYnD8agDauwNkasJ2
         E0+jVGJbrjTXPKB79LwkZ93hY8LdobkvEGoLNmII5bPrgKiz1ROnZFf5pLRh+xV+2cM3
         xT3n8Q+HrD3oHBv0GP1uxx4JyoVLh2cDs/CSN0W237QzBGJ+cfQxL2B3Whje1X0816l7
         kaQYtMOuu3xCOxXSXDG40ztphDeFVjudLZJqFATVimYhI/JJTxH1qdCTzxWij9Xquc64
         SH2Q==
X-Forwarded-Encrypted: i=1; AJvYcCX1YgvomT7IVVJIU5tQ7q/EIIXm5oMWyfPWC3ucspsnwXD3WN0iRNtgVadmQqEIM/NxP0+wK0iF0ahQges=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyi88+m0G0h8TVWNBjL8RexqsEguXTrQq3NoVAHRPepres8DWd
	7lDIjM9jhC8HrjcUd4Vu1Kyy23CvadjhDN2GsiXtcXY+09EscNDa7xxDuRoDJeo6XA==
X-Gm-Gg: ASbGncspzX+Cqs/k0DVuuau/RO7nEuJiRRE5zDeyMYdqLgY2rrSOGjTs5yRlcP+jQV5
	hklMA35qmgUJkUdITcdpYLVaMPrLtfOdfMl/w8CaGVxZDpR0slWqAjLSjLTouziKW8PqxydDbH8
	gdrjD6+r5jCTWUo5ECrQGCBTZmpO29+yRlyt1u4Zd2UOtsacuofWr8Knh8xUS4TUlIXNZObWZTY
	T1IkyXOrRthnwOkR9chmsimOQvHIx1VgDsZNYx8UoVfkWn1xy9Bv0m5ZLiSCIc/lqd444XM9xcx
	CyvTRO/8/piDawNsCjGqOHH3Ek/lYhajPBo8NMEujtB92tvwr18/XotY4E94t09E36gt3MpHUAw
	zQvU5/C+dobigwq3oMb99Eg90+Mi/aO/Ce5GpSkjzfuMP/hOWbmd1pcjPZAji2iXTXOkYF6hKB9
	8bwrojlChGid8lUHztBE0Hd7Xqvlx/sg8Whz0a5C5XycFkQyo5ME+j
X-Google-Smtp-Source: AGHT+IH41on4jpXBOi5c2bKsIC6xn61T+UyJ69pWDeAn3RI973fXQ7iyPYS01mgsWNu4I+diNqvKWQ==
X-Received: by 2002:a05:6a20:3d11:b0:33e:eb7a:4476 with SMTP id adf61e73a8af0-34f84dfc120mr6673105637.23.1762389722735;
        Wed, 05 Nov 2025 16:42:02 -0800 (PST)
Received: from google.com (132.200.185.35.bc.googleusercontent.com. [35.185.200.132])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba8f8e750c1sm539201a12.1.2025.11.05.16.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 16:42:01 -0800 (PST)
Date: Thu, 6 Nov 2025 00:41:57 +0000
From: David Matlack <dmatlack@google.com>
To: Raghavendra Rao Ananta <rananta@google.com>
Cc: Alex Williamson <alex@shazbot.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Josh Hilke <jrhilke@google.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] vfio: selftests: Export vfio_pci_device functions
Message-ID: <aQvu1c8Hb8i-JxXd@google.com>
References: <20251104003536.3601931-1-rananta@google.com>
 <20251104003536.3601931-3-rananta@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104003536.3601931-3-rananta@google.com>

On 2025-11-04 12:35 AM, Raghavendra Rao Ananta wrote:
> Refactor and make the functions called under device initialization
> public. A later patch adds a test that calls these functions to validate
> the UAPI of SR-IOV devices. Opportunistically, to test the success
> and failure cases of the UAPI, split the functions dealing with
> VFIO_GROUP_GET_DEVICE_FD and VFIO_DEVICE_BIND_IOMMUFD into a core
> function and another one that asserts the ioctl. The former will be
> used for testing the SR-IOV UAPI, hence only export these.

I have a series that separates the IOMMU initialization and fields from
struct vfio_pci_device. I suspect that will make what you are trying to
do a lot easier.

https://lore.kernel.org/kvm/20251008232531.1152035-1-dmatlack@google.com/

Can you take a look at it and see if it would simplifying things for
you? Reviews would be very appreciated if so :)

