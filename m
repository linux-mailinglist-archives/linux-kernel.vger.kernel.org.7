Return-Path: <linux-kernel+bounces-804461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD795B47766
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 23:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D9FEA04329
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Sep 2025 21:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4DB328725B;
	Sat,  6 Sep 2025 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bX1AT7m0"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66D315D45;
	Sat,  6 Sep 2025 21:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757193883; cv=none; b=W6jy+MckJFwCzlo8UF6vmZIFzeFXH1+lqHsHycxPpUpq/qo24b72iFBzX15i/4P1G4pRQAIqeH2PeUf124B+bSYeiC/aMepaFqqxTFlowjoN39GFYFkX9ukpUREL++R/45GufuHDaiQyIDqhDo8Ipc07zdyw1Qtd4fpjr9MfgAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757193883; c=relaxed/simple;
	bh=Uzep+sEhdcrqXEih+4tJ0b4qh2zPVvLsdqO+7+9M4U8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8aQm4NzUhcVNZU1B7oFUnBVtlgQ4heHbyNqzss+qnNeP2j//sBvyBS2HjHtK31oUGWQwKK+igzvv7JBQMq8mfB35wGjbCFzqYRcs08PoOJnAZnH/dI151Lb9GKEW+GGljwB24sZcHrvORlHRZHiNYZmkCWJBuLZ/Vf7PEGp4KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bX1AT7m0; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32b863ed6b6so2584126a91.2;
        Sat, 06 Sep 2025 14:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757193880; x=1757798680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MgymOrrr0bGTZvGqTZf+3QddI3vxZ0SjLKPTQFYb9lU=;
        b=bX1AT7m0Fsjoad0tuCghyz6/50+GpZd5WIcdrVv5jovd3sBdtfA96w+uCZGkYBdYgS
         sQpXAac5YOaOuldu92vHpxjv7HBdmkq+RWGfQqW5z9D/y2Jh7LmI/UKmdpvPK1KMrV3Q
         I7tjHJqhdhr7RSszjcQk0W8uo9XwSV0y/Zd0KGy7bQMRbmDS0GZJaSXhssgUSzV4yr/K
         WUJ/QWxrQzcDPKppjtsYIhLzUE8pB7ClKfOCHFRLIk2F9c/oOgizOFf+VwJt/p9DQT8e
         xKeslVMIjbDvg5nBGpPilcMLOtAkBYRUPDu/DMcupvaBYNREaUuj1tHT7DKQpGlcv+g3
         2u8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757193880; x=1757798680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgymOrrr0bGTZvGqTZf+3QddI3vxZ0SjLKPTQFYb9lU=;
        b=oalMZy/YszZzZ1dfTqZt4EHdpVc/Taow2OYiJNC9V6WluuAtBTKQ2khAzijmVfrfY5
         umxbKhsYCTzhYD4pRPZi+j9i1fPUktD1xXwnpxquQzrEofjcA4+sXihtS+VurfPTVwP+
         ut4eiifH2vxLBLFk/ohSp4ehLMmvp3p18Cq17d3ap53UUuIM1oT/wDD76i6Dxyq2+AAT
         FNjBpMjh08BSWmue6Uqk+uXO5wfsBGj2s133mjkD5SNjhcd++H5AeTT86E0mmpZ6mkvr
         kTpYIRLf/TwYWgswR+HJNQmePpp66kt6DmZx11J4o8uteR+WFK/lfzy73FB0FOrDqP1Z
         uKFg==
X-Forwarded-Encrypted: i=1; AJvYcCUDcuJEp4+ppqavLV6RlydfCvMomqxx2TD6ld0ZeKDC6goGa11A0bDL61wGt2m8rRKPdya+qDjwCfxxhPEx@vger.kernel.org, AJvYcCWQcDTCQeX2sDVomnBQ+oEVVsXqzgzFBWr/UTgG7UmJ5HnN03qkOEkPq/k2JTuzRt8N2Mj+LQJRpcw=@vger.kernel.org, AJvYcCWw0CFElqynPQOUZjMCbbVs/1SVXR4wCg4S1MNS9iHkGYoRNgo4SdEf/zK0YCWq5d+HjnxPAEHi+KGmogQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/QlRzpY7qBWyvnhRskQOFRhpN36DIwrfZP8T0tCvM4uFOyjwm
	OPXWwOluy/d0Hhhrhom9VhexyCTVF9YuGY6ddjoy0dBI7f+HzUMMLYa2LKLO9fvL
X-Gm-Gg: ASbGncsdCmwNmQbCzkjGAI2MW0McinuTk5DUKvrHo4Tc+JhQWSsbkPF/AkGWpreirQK
	UyMDEHmAznmyeWr6epnx1b2pOyIuiXZ8YIi6Qb+hbJwyg5u28OsE1Jy15afCvYE8ii7hhO7rgSx
	NslNiaaB2krpZ3Y22tW856JwhaeeRdq9fmJcYtrk5wBiQrmhgONNFy0tAtrNS3LtCALdRc5BMXU
	OI2MocV9EC5Xm/kWS0puy7XjhAL72669OVzEbzZldytDrCXAUmxmP7PrVnqTB3FUHIMmNW1JDJ0
	a+SmhFc2sn/f8Qq6SxnNkPhQ7PIn/sNlHkGFeG+wGcW64/gsWDr4YbI8DH1mhEFZD+aHjuxRvOn
	PXWXp34zeDU6d7O34mUW0Aki1P1ckEmmA02I=
X-Google-Smtp-Source: AGHT+IEpR+RBpTyqR6TfOLyQ+MXiE4BMA0NRrZ9RojS4mQx65csPHnYHO0FJIAc3cgJGTgMUCvc6Pw==
X-Received: by 2002:a17:90b:3b48:b0:32b:b26e:1570 with SMTP id 98e67ed59e1d1-32d43fb9294mr4061600a91.34.1757193880354;
        Sat, 06 Sep 2025 14:24:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2a0485sm24720097b3a.25.2025.09.06.14.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 14:24:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 6 Sep 2025 14:24:38 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Maciej Zonski <me@zonni.pl>, Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (asus-ec-sensors) add ROG STRIX X870-I GAMING WIFI
Message-ID: <825cfba9-f48e-4d46-a32c-26db1bad7285@roeck-us.net>
References: <20250906161748.219567-1-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250906161748.219567-1-eugene.shalygin@gmail.com>

On Sat, Sep 06, 2025 at 06:17:37PM +0200, Eugene Shalygin wrote:
> From: Maciej Zonski <me@zonni.pl>
> 
> Add support for ROG STRIX X870-I GAMING WIFI
> 
> Signed-off-by: Maciej Zonski <me@zonni.pl>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter

