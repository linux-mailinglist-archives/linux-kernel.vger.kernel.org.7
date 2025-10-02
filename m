Return-Path: <linux-kernel+bounces-840820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CADBB57EA
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEE0819E7558
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A4226F467;
	Thu,  2 Oct 2025 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YE5BooeS"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F831E4AB
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759441142; cv=none; b=qiS0pRHStUpMoywfEdUyXNp63XT1y0gLESvZEfd6nEMm74579Xk3ilCoAbiEoGWrVCLS2lU3Br56H6hx4Ea65AyGBLr4EDVfvgxO8p7vN9Fpf6XOtN+e54yrRTZZn8E5eLONMNmI2POMGHdRKsYBh/+2IAnH0KIw1Q679cgpMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759441142; c=relaxed/simple;
	bh=+ttJsDkf94r0CSdQ4el9fEq6CwTnDhuz1diFWZn1frI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhjW0UpDfTo6BazfjHOBl8H1j6n8lT1pceoOONtUS9xk2xKZ5yugUUUQYvW4c8Bmn3aM3nj7D7YZhL/VArv4u6VQlQCMihDQnynZzan+rU2qwA42uvnjCSXtOR6pfe2ijFtIBlFpF35VcABJAooIaPxkXPKl7TZQp9oqGVmeONQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YE5BooeS; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b55640a2e33so1157377a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759441141; x=1760045941; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hGLl/rz+wrsVeMOuhwheEV/pvZWT7ZRQueFVzWddcaw=;
        b=YE5BooeScvAUASPQnOOloYzXVTOZq8vYcGpgt+XH4bdGCh+3RT9EpaP1spETJyBFC9
         0z+UJqJ/p8ogk0RBxNTbLERlw3xX+uhV288eNWHS51f/5d8CEx1dxVjL6/hyg8nv0Ch0
         QV7W69pheDwk9++hK/sy4FfG2jjWxmOBHOr5h8wly0HT8ZnaMwzuDZIGUkUonV8s7CEr
         yZHmrjl667ybX2xrfy9gvLeWhtc65VBkrnLxwEn910Ii2kF4yRzB58sWLrDidkX/GS4i
         r+nLEfTdWCE0t9sBZIzEkSCGmM8cT+5u+p3CGRbGv8nBqSSLV6o1oP8nWWrRMDT7Y4Nl
         sB8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759441141; x=1760045941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGLl/rz+wrsVeMOuhwheEV/pvZWT7ZRQueFVzWddcaw=;
        b=ZFxrCyS8BqdTIfeUW0y/O4rGeV6+rCLv86Wc0pSgxf+esptk0fUC7iDlXL/XfUCL/h
         wgKibsqZ89nJVE1vJDYU6hju68h1yheTUDOWQ+Cgd2UnXWYx8pWcwInRoQuAx9IqFs1R
         9a2LjbWK0zZZzWg1L32uY1PO4JRxmFMpRsX+2dx5pnlwZ9j6odNPf+Gt+z65ITGWy9l7
         8A9p+G3mVZDJT4cwprB+FX81Cc95/lDENWoJGYcrBFNtppbNS4yrhOwsAkIRJY7Tc1Gx
         ZbP46ovlM5p/PzBBhKe71k3qnHCPmWnBeNiPl8WcPCuT8la/jtqu87iMPGJi8cJXBAxO
         dylQ==
X-Forwarded-Encrypted: i=1; AJvYcCWL2VjzqFeg78X7oyL1vyQ7CTY0ce+/eazxy6YLlXpcsZvOHWvCa1ydpCWsfxzzIjQ1fuubVXgTYFGlAbg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCn1sqMSvcJ31D+QeHVNjlzf61Akgiz7rN+i3RJFw+fkMidTYv
	mNLtBNUgaiSf+MM82hL0a74qUnWALuH/6BzrsakQ03im7Dod4Dou9cXr
X-Gm-Gg: ASbGnctbEkCQjuHwFP0e2rWkZl1ooOSsuJkfjbhCVEbqi3DAhXbwKIfbN5jySsTh7n7
	BO/55MZzbNJyUtiGgGM90S+YR4DRZ9O/ynGOtSXbETPHr5SsAm/1I14Gqu22KDqeuaXdVRspCeu
	+k658YiEDwQw88teh8MnSXb/P4ss1dZ7mNrr8orGKkL3wjwI3QQ34BPyo1+lRU76hKbhY4LCoeI
	mek5MP3E/1BkL8kaiquSa985JEdR6gals8SR39+94uj9vdOwOKxCvUzClgRYMqz6MqjT7qdviUF
	ZC9rupoomLcTn+/e4QC/xJ+BPlS9AmX0yntDZaBZOqGN3roqPkqg8rGEScP9eZy5y7d108/NDOQ
	Qxpr2DsaJNEnqdcQrucnmimnOVYoge/6OQxSH2XEwIUjLm3Tq/mxTH8tZ+Zc8J8YD6PE+3g==
X-Google-Smtp-Source: AGHT+IEtqQT22g+3Kd23iYkQumTvz38cXl27NAonZwLQoyLdON3rrIzQUidT4T+O5nMlBjuQSArlMw==
X-Received: by 2002:a17:902:cec2:b0:250:6d0e:1e40 with SMTP id d9443c01a7336-28e9a54ee6amr8808935ad.7.1759441140664;
        Thu, 02 Oct 2025 14:39:00 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d110d0bsm30175385ad.29.2025.10.02.14.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:39:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Oct 2025 14:38:59 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Maximilian Luz <luzmaximilian@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (nct6775) Add ASUS ROG STRIX X870E-H GAMING WIFI7
Message-ID: <4ea658b6-7635-4d2b-9ec3-9b781c3795fd@roeck-us.net>
References: <20251002184958.359744-1-luzmaximilian@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002184958.359744-1-luzmaximilian@gmail.com>

On Thu, Oct 02, 2025 at 08:49:56PM +0200, Maximilian Luz wrote:
> The ASUS ROG STRIX X870E-H GAMING WIFI7 has a NCT6799D compatible chip,
> which is also accessed via ACPI.
> 
> Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>

Applied to hwmon-next.

Thanks,
Guenter

