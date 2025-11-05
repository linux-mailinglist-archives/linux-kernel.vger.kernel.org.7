Return-Path: <linux-kernel+bounces-887433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 737BAC38380
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 23:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4407E3B8C5F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6B42F3C02;
	Wed,  5 Nov 2025 22:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rj9xuNqd"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4142EACEF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762382580; cv=none; b=OxoG8pOidxOEUuG+9G7dZ9UEFcFzaZKtwO1AtgFBmE7ZMHzzINNAMoSh7OUTcx9+H7BPdtXBbIdSDIUnZp4H3sykp198uXWE2XW304rWFxjOGQlUpfNi5hN3lfDMtPZ3feq8o0Vv8nI9fi1pq+rvdheUc1ZA1QAuRodX51a0k6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762382580; c=relaxed/simple;
	bh=DDJcM3o308lRznvcKXTlIS/CWI9gWk3xwBcIeYBXdjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeLd/hLGI31zBwiLO0XBxCxs6WUbOX2PROQavvDKONpqb0qv8EVJWixUh9PCJ4hhHkPvTAh0kTDyd9Z9ZI1TmQN8bdQH2ynCBId1DROx6ulLCw78GeGg3/dQv7ho/0SU/CfGw6RQeQJqdokigWKsw39Vs4v4WMg3NWYYYlrSfPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rj9xuNqd; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7866aca9ff4so3740477b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762382578; x=1762987378; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F3I7J13Lm/TZktCvPBXUloQhziyL889846w5yNI4ZSM=;
        b=Rj9xuNqdQvDlG7CPylJcJWTerl4JwtQ7TF8/o/6FAkFhHTKzC304t/E46v4Rdd7/tk
         1qb6iqPby7wVdpQ7Yi7TgrdWNNMPnuKgtPIJJDlx1+MyaiBuYH7RAZUFmd8AvlIZcAN6
         DxcCLTI8c+4LZjnxXlnFd+75JShGtHtGbz01Tkmki/gpDDnXJF6A0ycYc1anhrP2unB+
         bEVM5grB6Ip/EFZTh0FgLeiR2u0u41TUtvx+aWcVjzjnaDOg6ju98Hz94sXfxn9XZhLl
         33ct00a+F1BxlVw8xjsepd5R5c6bykPdLgOkMqCE5PYvUGAiznJP0B+2BWoZy074Tkt5
         Ze9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762382578; x=1762987378;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3I7J13Lm/TZktCvPBXUloQhziyL889846w5yNI4ZSM=;
        b=oU8v8XOsiEbcFoDqDSZwaCeDmAczxeE8azDO47BmsFvZRGC9KVGuH8Ekv5RqYLO9kx
         1SU4PH/DDkkZKTEl1p5KVwJd67uwTo/RrxozHyi3Hrwn2spXlln1M+Cf1IHP67mqiWzj
         WRyQRl5ExFA5vM11YI567mMniybMdiWhZ5PpViakIwIT6+VWC1Fxybv7uSZ7dXW0fphB
         6MGySV84KMT7h7dDvew5HcjxLZhxGZ0UTPyjWghjLv4gqjsWXLr/JnwP+jFcfC1o0HIx
         9gfLj4HYNp2xmMkLdCI9hLsLI35Xj0S9AnO4tetwHDWzMTQ4AwNj+q/t5xBfpd9TzKlk
         Iv9A==
X-Forwarded-Encrypted: i=1; AJvYcCW+vpyiqf+I1s0T5qF2JVqpnkj9N7mnytZbzbOm1D0+hr9Wssqvp9BKDNPDlsLRZ44A5tp4Y4fuFzhGlRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpgHm7reilc195FoSelDnsTVN/7HKBP9ZE/oxRSWdUU8nKlKn
	OVrsNqcUarPsfh2TegfwYl5hgN1ozBGI+2g3K/IC9kEggOfKrfvkZ/CY
X-Gm-Gg: ASbGncvcCwTwlrcihqMBT+rjd9cMksFp1+CPTfBKQOaSuwhkoWuS4r5eyvfxy7wQ9lT
	lYPNIFf9awAe1edhoWcb5KjP2r+is29rlb4XDk/f/1dz2LNADYyZ7L0EA22QVCJA3/QwKmDH/BN
	+A+HXJJfLfsYGMnQAVlMqk9RiMrq6MdfBUiCLHkfbee347r3okgMmVkHODtE9mJDLg6/idYVoii
	RHjE9CMtzRP0IN1R853q2kyi4Jxe2S7xl7aQpVu6pdAea48HuUB6X+pV28Q2nIQvy93H8ofDTVH
	9Cq4Lyhh2riJZlGTpYj35/zUZND/SEppcKoVbIa8RYJ0oJB6buzBeo4aimKIk6OFCgLfg7gUx8W
	eMrhrxFwNGdbU6PxC8VcwrzWXXq4E/O42+0RrT++XDbUgFurk/pNZgZYPujB+bfuwgd1NjavWwY
	DtVf89kfbjxDklsEkzVB4llSpQ694WQQRzTG0w
X-Google-Smtp-Source: AGHT+IF4bH2tlcrxAWH8nMgSsZ+oa2FDYqK2kFDiy/QWN+ROxEWd8z1LH772DutB9P2i6rkfAV9wfA==
X-Received: by 2002:a05:690e:4289:20b0:63f:9a63:46e5 with SMTP id 956f58d0204a3-63fd34d6705mr3657566d50.28.1762382578383;
        Wed, 05 Nov 2025 14:42:58 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b160e761sm2705947b3.57.2025.11.05.14.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:42:58 -0800 (PST)
Date: Wed, 5 Nov 2025 14:42:56 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v2 04/12] selftests/vsock: avoid multi-VM
 pidfile collisions with QEMU
Message-ID: <aQvS8GdzrfhVOhgx@devvm11784.nha0.facebook.com>
References: <20251104-vsock-selftests-fixes-and-improvements-v2-0-ca2070fd1601@meta.com>
 <20251104-vsock-selftests-fixes-and-improvements-v2-4-ca2070fd1601@meta.com>
 <3osszz3giogog7jzs37pdqhakcrveayrqu6xduztuwrftkwrad@gjj3cyvmypw3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3osszz3giogog7jzs37pdqhakcrveayrqu6xduztuwrftkwrad@gjj3cyvmypw3>

On Wed, Nov 05, 2025 at 03:32:18PM +0100, Stefano Garzarella wrote:
> On Tue, Nov 04, 2025 at 02:38:54PM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 

[...]

> > 
> > -trap cleanup EXIT
> > -
> 
> Why avoiding the cleanup on exit?
> Should we mention this change in commit description?
> 

Makes sense to call it out. It's removed because it just isn't needed
anymore (vm_start() callers now all terminate and cleanup the pidfiles).
I'll add more context in the message.

Best,
Bobby

