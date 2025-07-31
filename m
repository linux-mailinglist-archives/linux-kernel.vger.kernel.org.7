Return-Path: <linux-kernel+bounces-752720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FCCB17A29
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 01:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF067A9DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 23:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E958289823;
	Thu, 31 Jul 2025 23:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkHMmBba"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFAC1D799D;
	Thu, 31 Jul 2025 23:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754005461; cv=none; b=jqVddN/gmafiO0dtb5xzOf9cfiuqpQwuGs5iRmOL8Ka765lzsGLHDfrS6WA6h3P17ijAK7lVQABZ8y0PtFwmkJA/Mc/jCE+gf9iBORoizfpOQDiuKSf0Km8DaFbeRVShXcoKeWpFnbluyYzbaRLe/d0Qt5yf1gFUTDeHHR31j/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754005461; c=relaxed/simple;
	bh=1IrSbZ4HMKU2t6sDsI/igyPzxl/u0rt0RwGtImeyNE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEcSxAkmuygg83xRMHMY4hX/lOGQAx1nT9+wBuKN2y23fdWkaHwspQ7SyF4DtW5c86rQlKgJ/cQo7q8cJ/9hEE5wtQpn3wjAPA89N7+yefbcxa4eLmEdmyBwe7t4hDYWdYtsHcj2RHdyVRg8fXKmF+qqVJYfubVGxlvd0UoV+CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkHMmBba; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76b0724d64bso1451911b3a.1;
        Thu, 31 Jul 2025 16:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754005457; x=1754610257; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9t1atL8z5oWKQpn8thMXXSYEGKf+Zq4jM8T4eNa58y8=;
        b=YkHMmBbafPElTWDekk4fLu6Y5q5BSCGFTQFq7gn0XC7C4btipRW2UEhqxUYAErvrLU
         LmsS22vgdxzT2Mp4oMPnuKeTt33oPetp+390Maqyacc9nbFefNF+pHvaED/y4M3PlBHY
         MTbD+FppztH3CW33bK3JmWXw8plTuw5Ll2kzQooevMpPDhc0hmIvzdRjCuNh3V+2dNXo
         SWqiOuFaDih3aAlmGDsFsk571WVUESGet/Rkj5Jm8Hl827KwSQ5DpxTGXKwlIiUz+elQ
         tgGf71MX3GSQNd9hKgHNCjjUjS25paX1xYTCgesl0ABTZL4JS0p/HGwBnc8sBD+SefUR
         Tr9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754005457; x=1754610257;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9t1atL8z5oWKQpn8thMXXSYEGKf+Zq4jM8T4eNa58y8=;
        b=pGjp1BjL3X+MxMYUBrRw1Isoe5vlwRx8jPiKPVfl9TNOfwZMTsodyRzVDcxe1pkmWi
         kNZJHshuWC3q/6n4SC4yYxSsPGhHfcnLYqu+2RHmmc48dNICAy6Ci8YqqHB50bJfrFK5
         Kyz3CF3SX72QAEt5Wyf6wxe51BvQdLdNypFBQC/zup4QqvKmHtcRsXrlRJ/8C2UjOWBU
         J+bPrw7EhNxO5ZzhYJ07kxM0iJFD85XXTBsG2NUB++/++HqnA5dudBM5q2+l967lVksw
         UYd0w1hhd7Tbk5kvJ6L2FWapMnfIpO8k0WA5xfgDf6EKZixpFjsKomrHfYymCON6Oxyc
         uhDA==
X-Forwarded-Encrypted: i=1; AJvYcCWJO1DXztrYiteTymrSgRo2HjH2JCQeKM22FFuPIx+PcXTmj7onWNy8QAoQtNMCNVDDlJi8gUpJOIo=@vger.kernel.org, AJvYcCWjhIDuz76ywQPhR2OZ7+frOLBbGISPMebYDFs00X1kadTGuuLENgg3LEKpGM1Ohdb2/TfWUZLW/GQGXwM=@vger.kernel.org, AJvYcCXX6dUw73+sx8qHw2p73oiGYjd/9uko+DGI/PJiwI5PcG29o1dNx+IxbwOfAPr7noF+C04GJNdbLzvn+mRE@vger.kernel.org
X-Gm-Message-State: AOJu0YzyjXEJ5GkbDmNt2WbPKdSFqYnwWyUr1LBlcym+2EljWT9LLZ66
	wTmjJp0l1BBNcVWb94RzASBQpFmJuOdqRTgyR/eYCfTE+x8mjt5CQV+Z
X-Gm-Gg: ASbGncthSdbsTSwn3/5odz/F+flihkitH8mqE+rcFguNlgMO+Z6bdHgTyvLTQAVuKru
	XFM9yOcwRvuimGg1DoflINRSypggUITIh3VLptQ27+3FQmRpe6BVVql5qtIaInJku897KA/2lX+
	rahSlfiVoSBWzl1HHCegRapbp/kq0wudrEcIRICUaCOzDMqNZAbiDxkjrz9SA+Vln39pwAXVGNr
	+SHOi380yVGWaBxBPRqDS2ei7hI65sRRLP+14SZeBRIuImybR8yi4L7JUDrMf/Nv5o9fTRUjA+p
	Tq2Euk9XR062qp+q5tk2V27Kw/QqqBxLGdnM6iW8BSm0WZnl/42cmulov2G58GTuo/X+zFjNOi0
	D669Yd7r9t0Txe7kQ/YMi/iaLCBrR9Cnh8NQ=
X-Google-Smtp-Source: AGHT+IGaHOAhOknybR2gzqFRcNa3eaHZhzl4PK5jb7251FUkVEZymiHIIKNxkpQu9NcTvOlQq5wvgQ==
X-Received: by 2002:a05:6a20:5483:b0:239:d43:4815 with SMTP id adf61e73a8af0-23dc0e1318bmr14798705637.28.1754005457386;
        Thu, 31 Jul 2025 16:44:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422dc7cfe9sm2144939a12.17.2025.07.31.16.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:44:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 31 Jul 2025 16:44:16 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Eugene Shalygin <eugene.shalygin@gmail.com>
Cc: Lucas Yunkyu Lee <lucas@yklcs.com>, Jean Delvare <jdelvare@suse.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] hwmon: (asus-ec-sensors) add STRIX B850-I GAMING WIFI
Message-ID: <b88b71fe-5c65-4c87-b0f1-945e3c63ced5@roeck-us.net>
References: <20250728205133.15487-1-eugene.shalygin@gmail.com>
 <20250728205133.15487-2-eugene.shalygin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728205133.15487-2-eugene.shalygin@gmail.com>

On Mon, Jul 28, 2025 at 10:49:08PM +0200, Eugene Shalygin wrote:
> From: Lucas Yunkyu Lee <lucas@yklcs.com>
> 
> Adds support for the STRIX B850-I GAMING WIFI
> 
> Signed-off-by: Lucas Yunkyu Lee <lucas@yklcs.com>
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Guenter

