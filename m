Return-Path: <linux-kernel+bounces-753824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5A5B18886
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CEEB564692
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9380928A724;
	Fri,  1 Aug 2025 21:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IBt/GmGu"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49781A01C6;
	Fri,  1 Aug 2025 21:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082300; cv=none; b=f6jyVEm553HAERUFcALHWyRNg1sj+G/drLqDrYoVrWwBoYGaZ+UdQotoT9vwwXc/yJm+igO3/VD2NfexhtIWbcGJpgvY7U/8LVm5IY12QKBFgqJU6mvDqA2oJzSTRbjl2fDgjUiv7a/9CFJoeRWNkW+JzIqwMBMAhcvTO4IAMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082300; c=relaxed/simple;
	bh=TRUqs6xlhglbCyWGVZLqMEQiUXQwndHXQ6HDJSNkuRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm2dksUT/UDgwVLCVv2NGlvp+LDidhFRVGf37cjI+3iSLXtpJ04C9ZTSsjBlDe16uSGwf5+19WTIJ66VPCvUfhNp1LCFuj0Vng/jyFnBd43wnVqnxlV+mIptdA0UxnEx7FFeQa1WxQucE0G7dcdYLcY2MLHh0jL/fq9STVsrNPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IBt/GmGu; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-240b3335c20so14923675ad.3;
        Fri, 01 Aug 2025 14:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754082298; x=1754687098; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8e2o2DOmm2yAsxtpRoWoG1Ii2DzD6+fXPkOVUpk/X+U=;
        b=IBt/GmGuflh75WJdHvmxmII3eJ6apV/KIzOecAPuPy7NCwHgy5jek4gfhClrLrW9Oi
         2QyKRkr5TmYor/iGFw9Qh51JGArGNr5mc8btyRTWYWaU4tHNeETwmwT8vx3tRDjwzNHw
         fLJhyZrCXRPp09qPjz+G/LafkWCkCn80HeWXxeGMjpEop/a3MmiTT61juazS3AA6c8Ft
         TqNGLDX2P7H9M4khUABKz42gyoWGCderMRwIhTF/uKaVv1NEPaK6zGloYNiEyuyY1ASH
         Sf0+QkFEeVrLDzVnaHemIROK7c4/J6RwpP448pbXHer9OZiPZNRKJM8TEOCBMWVCQJuR
         thww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754082298; x=1754687098;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8e2o2DOmm2yAsxtpRoWoG1Ii2DzD6+fXPkOVUpk/X+U=;
        b=SfYmayrNtGlQutgs5u2e7fHvLfNSmNA0/0owGhk5kXmWbhAVGpHTRg9Cd8cGSseaeZ
         vFnonmnD8C9XXjQ4xYGkhdHhOEXZ+BakYfyd6nIIzk6rt71iyGk7eWWN37S70+1q8KKi
         h9pax76tR1BL53Itd1/5YlUAh07eqUtZYMjsWEKSGvftgJGnHyLQeyP4INO29dwkmE73
         qrEvMG+qcce95RfMP813mrZGw5xTXkHKokEcA13+Ouv9lVR9TvdJlhy8cVzlWXykVd26
         /4QFH0Mq/eZBc0uJ15XTy6D0JAg/SLMQHFjOkVfSYvUAr9+enUpwfTfJmUCXO4VHzVOl
         +yaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvzcxvGOZM+wCAkL2nuXdmtprQiW2xTf8cpWFMMRoYYQtyN2ofpXBLFQYCXE+j0syQwshEIWESrMedvaI=@vger.kernel.org, AJvYcCVjmzTqz2A625Pan4yFhzClvI3mVOJePREfv3ox4eu8TPunCQVKrCDiNoGnhh/RjsoooYpdyUwxGTU=@vger.kernel.org, AJvYcCXJVicd6ltIoNkQjJnMkd6z5BiG56TqCiOFFz/jEbiAKdcZ65jf3iA50GTeKPxx1+ngUQOg7tl+frOi1Mlj@vger.kernel.org
X-Gm-Message-State: AOJu0Yxri2yMj0g7hdHUwMjHBIu+SmePINLLTkSLTmuqeOLjpmuJbIz4
	O0YTrdf+qmiHlHwyw8QVQNcQpWwRCKvhAyQIJ1nKnorAGjzA+B8iuw96
X-Gm-Gg: ASbGnctcEhuNB2cyUEJKPG4N2pI0IzTXBR2jFIwy5uMpMY6uMTN846FZUAeHpOzpi1r
	iCOHVaEz/jV08QTPhmhWdWDwR8ZIN3KMafRYueJk8T/7qqFwLVmMfwTNqQp7FW7sYBPlHND2hDM
	mKfDmVNFCELN9ApME55QszSDsPMWf1xbTOwZmhDvv4gv3Z0Zgx2Q1Ja7IHQQ71cHkFjk/5vmWVq
	TzE+nhc53uvEhzgqRc4ZeO5Rlb7Gu/POdASIyQcIRdwVjb0L3ct3Rk888d8PXmssP2ujm213XW0
	cYq6SIxZXHuJJVp0NowLHNfHPZzlZQyAYjrw0MMv2eW/cyfuajy8C7IGoxhJDUOgDhnb8EuulPk
	rQNzNcBO2h0ljUdZa2xSGMqXaMmCmhPFstAs=
X-Google-Smtp-Source: AGHT+IEcmQguvA4OSb6zM+Ox4Lwc+OtLle2Il5C+7tUf33JxrxfEuMHkNj0e/uf56oBX/EbPogiZ9w==
X-Received: by 2002:a17:902:db04:b0:240:99fa:dd1c with SMTP id d9443c01a7336-24246f1fc4fmr14571295ad.10.1754082297773;
        Fri, 01 Aug 2025 14:04:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e89a3a6fsm50893175ad.147.2025.08.01.14.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 14:04:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 1 Aug 2025 14:04:56 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Runar =?iso-8859-1?B?R3L4buVz?= <noizez@me.com>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add X670E-I GAMING WIFI
Message-ID: <2ed06671-fe2d-4008-b185-a1398a515925@roeck-us.net>
References: <20250801195020.11106-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250801195020.11106-1-eugene.shalygin@gmail.com>

On Fri, Aug 01, 2025 at 09:50:08PM +0200, Eugene Shalygin wrote:
> From: Runar Grønås <noizez@me.com>
> 
> Add support for ROG STRIX X670E-I GAMING WIFI
> 
> Signed-off-by: Runar Grønås <noizez@me.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter

