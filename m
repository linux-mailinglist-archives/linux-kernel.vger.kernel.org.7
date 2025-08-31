Return-Path: <linux-kernel+bounces-793582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8597B3D590
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F7D6175439
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B9D24676C;
	Sun, 31 Aug 2025 22:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpBZgrp7"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F44D231826;
	Sun, 31 Aug 2025 22:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756679130; cv=none; b=mey9M/sXjS6egiIkWY5vlxUdysUiJ2wLiGqGOiWEReJIH2Ey3Fr1yVwAdPG8XqfNX3UWegeyacmywRHHGak4T/wqnnz3qWHjIki68WdW2biHZ/Yk9tdbFNZX+cYIb/j4a4vfh0Jpus+drrOJowMqo4tTsOGIF7HIbhsl3d3JeMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756679130; c=relaxed/simple;
	bh=IXdCYabTfCFfnUgA0FINar6CGh/GTwkJifW+sxDw2Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFPQIPDHFoxL8+To8gDKVw1JxIaFq/LGUuE5drN6LZOoriltFUYo+Oap8Gj4Yk/1EahqO8rhjnn/nfjj/VmwvnzBEt5jd+66yUIxuAIT95SQYMoiq8+s0GXw1EAH7Vh32BaPod0IwC/ziCliAyRkRBaExpWOd31XnmV6qMQ9K4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpBZgrp7; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b4d118e13a1so1473314a12.3;
        Sun, 31 Aug 2025 15:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756679128; x=1757283928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ljMuDfz+V9f5laziqBy+TjiVrY5z3Dh8QqJw7LI40o=;
        b=RpBZgrp7WLNqMVZ35MzCSgKKZxORTMugJrOuq9X3X5WVHsrJpm21QCQARe8cdj+ggt
         uljTIGTsvJCizbpmyzKCCNE51LDhs7BwQ8Nc8R+ZkgHNFqVLEE3gVMBLu8eS3oIDBJ/8
         BTRDpq0Ah2ayTMWGLNa+38myrNgfQDAdVsCeY7NsKE5maLnliJyj+xWyU//SVSsyU6n7
         j4w5V02mWNUVR9///NDxnJ49wj1vrbR5HMC8hQ66AhyZYfH240yDhnrILnJHWdoVkuC3
         Ry2fSWH6J4T2Cciv7EMiZggEDpXhunvddHzBWapJK0e3kbCxPMPZdGZ9C4c3SfsNahyn
         lQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756679128; x=1757283928;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ljMuDfz+V9f5laziqBy+TjiVrY5z3Dh8QqJw7LI40o=;
        b=tusE68nSTqDCQUZtdAwwaWjybBybmrZLv5jWOz9+bRieGHvyydiJiIpVx+h6NjNedo
         WthG7ACRpjJyUJc9fmcvrtxdq2TrV0d/jtVN/CDxYNfwd0Xkd/uHVxfjvFOSQpji0qou
         VALT9J7bL5OdRXHdIEur5fKsiYdMDAkp7/Q1aKqQiolvZJGMdzr/aKwDU6sdkGPvt9zl
         NULJV9aBdoAMBPoMRvpwXUZ+apZHahM6qxOZW7U4hxcBdtNmYaORO7wwc0AXzVXO7E1M
         QRdOmkdkDBp67iIJml4UKqYpoZ9LAFW+wC1kGMyFqfhJ2gqj7fyB18PLiEzwBk3N5FBK
         GPvA==
X-Forwarded-Encrypted: i=1; AJvYcCX6U/nHJxGrXjjgc8o2cuAgzXCGXrghLG15MJiWjB7VudqaOCVNwQSoXNkqdIJRQ6KLR/jeEyVHw/dyoa7f@vger.kernel.org, AJvYcCXBa0PtU9O7R4OGjoFXfpDucSmvmtnLRdshFbAPZbhOE0h4mmSt70mbuQ8HGQ8Q5hCdRnSt5mdYc+s=@vger.kernel.org, AJvYcCXF3LPuPOasBpDCIoWMA+Av5JER00ydn2YCHGNERq9W+lqO668XSesNfZL5lGpvMI16gj5Mj+0+PeKgnRc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ACtXbItRZ2DXtrJadOn2QBcRu8LS2kg9qAuXqsldn3RATVtU
	ydhAmwLKA4mWLWQkC7mbZGAr37I3/KI+OkRoNE8ugGfhJe80m9TpQL/G
X-Gm-Gg: ASbGnctM6/KiugK/T6lS55/2QbZHQKM1/8hYdcUNjR+fPil+h8fyblxvGgMD+vgXKTm
	XHJdLfZveLwqCh5SAisoOLmXf+tiQ3ta00wsjcGGo5Tn0RR06qgTArBfSkQnmxlmYoEsV8XDsoT
	elXwDRcjLysskwVSQ9R2gaqhyujmFpQLM4fIhde7HTZt4dEfwxdPSRv9saQcvbvIsAxF/xQKv0w
	wIH4VT4ss+owZJMWbanKG0hAwTg3YYmIopfi44+fc7dBKCRpHlj7jBexFdTqcc6n3KFo6xW2zRR
	71NoOjeBxG3oj4jMcx1fD893lH0SVyV3xG2Ph7hb8LxWJ8N3CCZ2xMNFmeTxCC5FcPTSTzrZOn8
	/qarIhRTrAeAih4jPkLXYkdhdtVas4PrFUK9l+xOj4QqzkA==
X-Google-Smtp-Source: AGHT+IFN+M8qngD+R9YEAPm7ab+kjuLmL7tnTEUs6rDX+va68g1zdZ1as9WoqoPa69PCjqa29+jTpg==
X-Received: by 2002:a17:903:28c:b0:240:3eb9:5363 with SMTP id d9443c01a7336-24944a70227mr80651035ad.27.1756679127809;
        Sun, 31 Aug 2025 15:25:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2490648d67dsm84988965ad.108.2025.08.31.15.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 15:25:27 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 31 Aug 2025 15:25:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Michael Tandy <git@mjt.me.uk>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (asus-ec-sensors) add Pro WS WRX90E-SAGE SE
Message-ID: <deef1221-4614-4ff3-9302-086c5bad12dd@roeck-us.net>
References: <20250830120121.738223-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830120121.738223-1-eugene.shalygin@gmail.com>

On Sat, Aug 30, 2025 at 02:00:59PM +0200, Eugene Shalygin wrote:
> From: Michael Tandy <git@mjt.me.uk>
> 
> Add support for Pro WS WRX90E-SAGE SE
> 
> Signed-off-by: Michael Tandy <git@mjt.me.uk>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Guenter

