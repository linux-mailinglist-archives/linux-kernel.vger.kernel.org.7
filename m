Return-Path: <linux-kernel+bounces-881978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44433C295D6
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 20:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C8653AE637
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 19:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B412264CC;
	Sun,  2 Nov 2025 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K1AUc7mZ"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7AB1E98E3
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762110604; cv=none; b=ss5peHoSwqBa3U41qadMEsr2G+2soQJR3zowsQaB1FjQzNFfbywcmAJJcShGpPI1UMxesyS40R1isxxARhPyfViIcCrLOz9TiXpcYKEx5e8jtMOlkOPSF8bcrLx7O7orddQG0tmQrxvcOwEOpxFTalbLyDnb4frgMdqyZTe305U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762110604; c=relaxed/simple;
	bh=8Znko5NuDnyx+OGakH3V/EstaaQ2BsRjlAmgoLRxMjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRJypBXDsIsqiAUl07vBjYFPERtBwC468LwUtAN/1yvkx1CPB8mC9g2XT9RvcqkXHqjYLEYvVupDTeHFXh19BPjtTIIJLy6rGRMT5o+9MqmQwFYrN92+gOllpQbSb2DdyjC65n7zg3ks/d6Rd2/QYFuSsCVpvtiz/S+OWjmOwhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K1AUc7mZ; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b556284db11so3161474a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 11:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762110601; x=1762715401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IgLvpaYQ9gRjsmHaaMXfyMMelQArREAHVTBvb+wL2M0=;
        b=K1AUc7mZKJfyCW9y3IENaRrKjRNtD+U9+P1s6wdOZIfV1vD4Nvk1npp1ueCBLsWlZY
         rGzUYf6p560NtFFpvCyGspHknzsH+/X2UiHpqebpY2RXLjdXgz+X9XAlyjPdzGwT9T5W
         WwxAGfi7+p+Tl8D8MDjUUpYnu2L3re0HkDCTedANxmXSdLs7sigukivrnwcs7AyTi8sh
         Qj70NaextcpeTsDx3vAXBTrSrAqtF8Zlv5z1XDFQJRHYLGn6j6sy3c2TWweP+zSl7h90
         cHwZHGM8dnvg2wtDCSGrtMNF4LBIXkynoWopds42QAytj2jD7FjrXNEmdwPANizQpBQk
         Ab1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762110601; x=1762715401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IgLvpaYQ9gRjsmHaaMXfyMMelQArREAHVTBvb+wL2M0=;
        b=ti8anK2f7itaVMg1QNlllaLy77zcAuglerzfUFx499R5TSORnnZrhYf7B92X4G/iMX
         vhjyCZmSjIN/czgfcz1806rXQL8zgD6CNYTkBzLksVl6HGRp2PBNedu2dwalADmMh/fd
         t18IpgCvRKAc385hFdA1Bs3VgmlS6C6q+WL59OM8dYsUcd6hK9fW+IRGMyWLSku398jr
         tBoAnw/WIN6F6GF0lfRsuYqT+WTOIK8OnzQSiGjTzQZtruYrWqER0Z0uqPAUktcyDc5H
         EcM6Knwka+sjXxl8qVLHAkVFUbsELvQHYE8o2L6XuPhDiNpvGCkdC7G7hf7n8z8p9p9k
         KOhA==
X-Forwarded-Encrypted: i=1; AJvYcCU9AyRwRcKVUPtHroBV3Cy7aPSNNZf4KoYXD9vYIznz5gHOSL+q5pRySN0XfT9FVwjzpwIdW6ix8EDHbhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHRh04mGMR1VdnfbLecRuAQ+egrcFY0PXeoSBJVITRrjiOmpX8
	xa+vNwtbAAAWKFQBN9fOuCwfXAKjyzXnx2MXVd3r/FyGxB7aKbdh92tU
X-Gm-Gg: ASbGncsM+KlcbSZ6ggS5CNA1+n+bOdNUz20p4IfOCkfJElHvpLgkDb5WgVRaN1JmcpA
	LqVA6pnepT13L8fyNt+uPS1gEt92yYFksNELLgiETN3iam5Qs2rbTHSWtW9UVURvfR7XRleoe6u
	TsFGU6fMDCJGj1TCR1cbyQUoarBApfuu3B5EV1cUExVu8AojoS2fvWCCJWfnNPshpd6SZfjjbpn
	5uHN2RnRoxa1C1VTK8UEb0+IIoFsMkBqKjuFm/URlYRKQXGGzNpIDBZprnrspmdGPpm9bc5FzkV
	qCFsIToaLrRYfkRjZ0KOm8R5t3pHUwFICagdrhbwFlBuUSUllnv9N2b9V65GPeymGU9Fox9FfZT
	nJSDvrX//u5xEssK1PQUij1bNUAtAGEXITmKLIQ/uNdbd6ay8bWxDoo3beS87d2HCNOvrmS7QJF
	oJc3ScnZDh/5IQ
X-Google-Smtp-Source: AGHT+IHkMIAYpUU2qCDVKXaSXXcsZFHQC4KsbEqB40ybOnj25k8W9KwHb++brJJza1y8FVB8EDMWqg==
X-Received: by 2002:a05:6a21:99aa:b0:33e:eb7a:447d with SMTP id adf61e73a8af0-348ca75c0ccmr13766035637.17.1762110601545;
        Sun, 02 Nov 2025 11:10:01 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34092d2df47sm8433792a91.12.2025.11.02.11.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 11:10:01 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 2 Nov 2025 11:10:00 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: akemnade@kernel.org
Cc: corbet@lwn.net, linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: sy7636a: Fix sensor description
Message-ID: <d8befd43-5398-4659-a6a2-afe46fb5a541@roeck-us.net>
References: <20251027202847.119707-1-akemnade@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027202847.119707-1-akemnade@kernel.org>

On Mon, Oct 27, 2025 at 09:28:47PM +0100, akemnade@kernel.org wrote:
> From: Andreas Kemnade <akemnade@kernel.org>
> 
> The temperature is not from the die itself but from an NTC. That was
> verified with an IR camera. Fix that.
> 
> Signed-off-by: Andreas Kemnade <akemnade@kernel.org>

Applied.

Thanks,
Guenter

