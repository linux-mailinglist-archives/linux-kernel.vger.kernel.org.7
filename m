Return-Path: <linux-kernel+bounces-815180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FB9B560E5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 14:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D533567E5A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 12:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDA792ECE8F;
	Sat, 13 Sep 2025 12:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwYm6YKJ"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAFD2ECE8A
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757767515; cv=none; b=Lif0n6HgaWYdals1xf9FY8Wk3L2K198NavS6UlHjF4Xz3hQVz+QJ1y2/ngD1G1GSkGeHH8vsl/QStSYY5M5pXkMss2nTPNT1yQc+f88rwD6oyswNrFogBXN2SATmZWzDvTw05D0/+T0l1SbrjtJTMyTPItuBSQ/2GZvPQQgLi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757767515; c=relaxed/simple;
	bh=xMaQibe+xIzu2wuKVnlslNWfdwPWjSm3Neinl6dyVMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m21QpzyfYqqdyfn5n5RNYyRXxD6GE3AhmOny2kR2X/YJErwaffFh51eUAvIEjqk0vvW7U6reHte0KUPtN3jxt1XT5osL1nY2vTIKvrMPauRN5ydDXcVC4rCu+KHZ4f4uOwi1v41/GeuHKX8hl0h9EJYoMIyIGjEt5nBIhsR77N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwYm6YKJ; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b47052620a6so2595077a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 05:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757767513; x=1758372313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gBgNhLc05aeWCQ2PbldjUAPRODag2fhm6XeBdAbAa/k=;
        b=WwYm6YKJyl2g9ydjTcm01EDT+6/nr9dmSdYX123h3LiWwFbMyaKW6Wm2tE/hCCyQx5
         bk8vwgStltRjoxLscX2jBu8JxDFrreAtPCKRzAKhbVaakbSohtm04mPUTPJlOoJGOui6
         sAoMR7BrttreRJ4uGBKBiFvKShqoOMb8u7lqI6+nphgjNCLfkPX/PYzNMTp7Qo7FBv4l
         gUac+EPgODmNes0NER7sp3WsJ4DsDM6AomnaFwuDdTovON+WlxChSL9fNulCCn5ymjXQ
         BNTm9O6J6kinUc44GKUr4oyn5ddc3Zyq3J/Ov3OgVBfgZWWzr6zxIxMXbudcA/yChEiz
         Cyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757767513; x=1758372313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBgNhLc05aeWCQ2PbldjUAPRODag2fhm6XeBdAbAa/k=;
        b=GyosWYOw8OU4YTXXzae/XLPzOeRLBe7OrwFL2WGIMOIp341ugN7y/mmTFHsrf4Xf7T
         PIud64uiptb6689fdq5CWIXCM2jOXL2yOaVuT1INGBCAPbCC47ZMyUFMQ81y0qdIRSbh
         jmdDb2MIhfdJ2O7FEpNh2S7hsk3REOgeR5STYtmoJSQRuNcWn9U+3pcYtAsJ4w4JB7HY
         6kNnDzAiYM488CHI5VxwPCtNUbSPlTxl+YsJGy88rkXwbuoDpUzlU+L4Cr2JRZrk8kU8
         3ffKTCbvILEx4UTOn30M96hbw4CybHURfHBAl+w1IPv4tIQ9rx3cjLAFy2gVyMY/dFiJ
         Ieig==
X-Forwarded-Encrypted: i=1; AJvYcCWUjDt3KW55GsVSH8r3awFDU3vdMU2tO9yB5oVW7Z7wWpS9L4COw6yKqDWZYxeRr5EGVtWsEBlVK08EZQk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzZUs3oCeIyhSmVS60qguC83LpuXrDvgp2K1XpwspsYV3LGJQu
	bAhvgllp8PbU6Tk2ixdNdlywG0J3TZ6H6Qt0/H2lSjLzBijs8uQ1X6Vp3AYjvCUI
X-Gm-Gg: ASbGnctOc9g+K/L/H0siEyCWV2Vy/8ffy/0M3fdmmL4v9IimmkPqGdZIEeyutc+eXyJ
	9NdJvbMatEknCT/MDsBUJozPO0KB46g43ba/7AbHcmCPotSEIzEgpBOAbcHG68p3WdN8oQwsTGV
	uiiEBVTV+rNQtBZwvtGorQGzelbd6DhqH9Yw3fKnxx1sdZrlS+surAvqDOIys+rYLj3yUl3qLjh
	ebJUJAFmy8Npwdl41lBYaRf0eqxvCBeP/LlELao3C1maDSNEs6glDuHGUPQwN/dk3mHcJ178teg
	tnC1J6io+EwMmK+D0eUAx2tSKzIlfk7zsCDDV3UxGPb4QaYo2NmuWs+B9yBwB+aLyoCox9UPhYu
	1CKuajdM=
X-Google-Smtp-Source: AGHT+IG/lfy1NWrcEIj+W7etpm7WKSUoeiR3GGEPpsh74n6PAeF2X9pU1kCN9vBnwj/Y59cDM7I9Mg==
X-Received: by 2002:a17:902:e844:b0:24b:1b5f:1c0a with SMTP id d9443c01a7336-25bae12172cmr96054945ad.21.1757767512934;
        Sat, 13 Sep 2025 05:45:12 -0700 (PDT)
Received: from archlinux ([2804:14d:90a8:4498::6b2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b4f43e6sm76359485ad.148.2025.09.13.05.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 05:45:12 -0700 (PDT)
Date: Sat, 13 Sep 2025 09:46:33 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: lanzano.alex@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] iio: imu: bmi270: add support for motion events
Message-ID: <lipouuxehycprgdxg4yqg4wuw7pqpeynpfbzzpukatn3wbnwak@znjzqj434atw>
References: <20250830115858.21477-1-gustavograzs@gmail.com>
 <20250830115858.21477-2-gustavograzs@gmail.com>
 <CAHp75Ve93UPiE=STPLiGzfipWUe0WeQsER5X50sKbkdMWDR4bQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Ve93UPiE=STPLiGzfipWUe0WeQsER5X50sKbkdMWDR4bQ@mail.gmail.com>

On Sat, Aug 30, 2025 at 03:44:37PM +0300, Andy Shevchenko wrote:

Hi Andy. Thank you for the review. I just have one question before
sending v6.
> 
> > +#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) \
> > +       ((val) * (scale) + ((val2) * (scale)) / MEGA)
> > +#define BMI270_RAW_TO_MICRO(raw, scale) \
> > +       ((((raw) % (scale)) * MEGA) / scale)
> 
> In the macro names "MICRO" in the implementation "MEGA", please make
> this consistent.
> 
These macros are intended to work with values of type
IIO_VAL_INT_PLUS_MICRO. The division by MEGA is what produces the
fractional part in micro, so the naming was chosen to reflect the
result.
If you prefer, I can rename them for clarity. But please note that the
same naming is already used in the BMI323 driver, and I kept it
consistent here.
> 
> -- 
> With Best Regards,
> Andy Shevchenko

