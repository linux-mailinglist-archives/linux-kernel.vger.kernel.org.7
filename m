Return-Path: <linux-kernel+bounces-793588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAC6B3D5A1
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD9A1897B20
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6381F254864;
	Sun, 31 Aug 2025 22:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QynoRha/"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CAA233D7B;
	Sun, 31 Aug 2025 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756679669; cv=none; b=qkfIfod1IeJgQxLkA4hladk0QwcZ7AFF0jvADGtwnHwtjT5yQqQwqSgEnehO0ZSIIhbt2k4Uxi3S5mTVN0oYimHmiqHrQ7XqeNJq6k4Xxq9GCfJizwspoYiTuxghWvrL02ymmBNNrXnHst7EtAfZPGTcG4rj6h8j6oXOswdfc3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756679669; c=relaxed/simple;
	bh=HbRi8e0rjdCOTJBiINSK95RPxf3uhi4FMqc4vuyVDiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1SfEgxSmzUgMwQQIO2kB4sQ+Tll3NTN/0aoB8ubMNcYpH8mfG9hjsGYnRArCfP/F6gHj0LMT5bTqW4ZFVEX1VxY4U3p7XcD2w0Y1Mo+nATwpeERkerHo75PrS24G35IUPjV82TzEwPavIj/xU457Wsyxz5MLc46OBDxWjg4o7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QynoRha/; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-327b3e24637so2428596a91.3;
        Sun, 31 Aug 2025 15:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756679668; x=1757284468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aCD6icAg5SG2fS7k0HshLe8whUBsmfj3V9wUSufl11k=;
        b=QynoRha/UE4T14U5kZ1Z/TCin0HoyWTqGPobAzektbL91hTV2xMcql/ixyj7Lwraml
         eUEX4Zf6VMM4STT0dhdX8T1Q9ps37oL/82th216flzD4n5Rw3YhGtB2xENGPlZlq1oS9
         XUZ+Ie/uM/nyUReggTe0bAj918qRuqs/6KXMesWSYbqhtBpBVj0Kp1yC6xQeDAVyfH4V
         LKQdsrYz7KgTCGyXNB83OL5+b0IJ9KdA/jdWEL+SEa/jyyKnBbRXPV14ThpVTVkbkW1e
         Crjnsn779tyEI+PSv4XeOed96XyMjib8gwtG6DpilfHmmCAq3gi4UayR89oTGHNpGRDF
         xykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756679668; x=1757284468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCD6icAg5SG2fS7k0HshLe8whUBsmfj3V9wUSufl11k=;
        b=tYNnJDQBDursrcbOGguMfuv9AHUatLQRnId8SPmLlQ7cykOVK3jjShsALlHTm0ETvZ
         vebBxRPeREcbzOR6fffM+grpEtyyTFlUV7o8ZWX4eGyvkkCAqAJiTIOHw+TcmHTqIO9W
         Hqx1T2GLU70w8nfW/Sd5MZ1I1MR/qamPfC0wvlOSX+i/U0ev8bMEMEioYkuLYCInxHWN
         fXBbDmOawX9Wf2ZSgWTuqtvCdT5Tw0Jgn8N7z/qV59lk7rsTjr/FsX9E6JmwpyvqreNK
         Jd9RMImY/MQzu/qjsjLSpa1OkJu6iQjxDbDqTi/5IsWPCPj/sS01RwvxGsA64ZYxlvXZ
         8juA==
X-Forwarded-Encrypted: i=1; AJvYcCWSzWDs2UHlEGy1FQnCxkxIlgGEdzxiZfJi+T5QrdKTw06zkBvM/trk7LbyXCb6wXRFG7Wivubp3POSZxA=@vger.kernel.org, AJvYcCX1RBnbRC3kXlo4dAhJD/CkoslrpEDyP9NtE/AxB0Fb7MMbGCZwYeo+DB3UM8SjAUqpFPUHN1mD8ICT@vger.kernel.org, AJvYcCX8FaLpu2BzV9m1PVgwssDysnG2mMs+7yLHbSAawlBPCMQZIhUA7wQi2oXEJJShphUd0v9AhH2mQS9f@vger.kernel.org, AJvYcCXQQkZnJ9idyhVby0lqouODdZVCPCH9+amUnSVetYueBhEtZlXqS9xj+UWv9s+bsv0KNtU+skgdl6Mh92AH@vger.kernel.org
X-Gm-Message-State: AOJu0YxWLo7t1lQPDydyzFr6chB0hey1V0irisGqnir2UxPckqRb9jMD
	XiBuPthx1f3+eQ2DCC36HN8Ka58jtPy1+dCBVydMZzp4n5G9P8xL7IgZ
X-Gm-Gg: ASbGncvHapTCoAxnvc6MJk9hcwnjcOs3SeIU06g8/ulT0h2+BjQ9L+AIBHpuAyTZizI
	RJj0o0M+jYzNAVkGpkV1HnNJbEeAOkpo0BvsDj1lvJZGeVOCvXwtW3DgPXEmJeP4IcYfP1qxOEu
	o6q8z+PemUbnu25EoJeVrnUxpppStJRkyi80JpS4rCbT61Iyvo3k2yHAr1KHOjabaWfVPNEIuK7
	sY64G3w7527pF42W4T1kYD1fOKG/YJ06e1MoeJ3WwdwhtkKzMDlAgqwjhfWoprzTS6dR4/8fEdL
	2cGXlPwtHJjg53Tz+QukCGp8FpuvQDXJi+a0IJ4wjeRzzxMFrpmy3nK9pHIhbF4LDhil+S4yrn2
	bwFME6DTLtMoIfqqHk8dxVYY2pGMpUxdTwiHjuB4Qd4j2Iw==
X-Google-Smtp-Source: AGHT+IFxAcvOhhFI8nQpjtvVIThZawESKTzbeW96J30MMZiopi4p4rAyuXC+WKheGK3dhb/c/ELbvQ==
X-Received: by 2002:a17:90b:2f8c:b0:327:e01b:6c0f with SMTP id 98e67ed59e1d1-328156cc95fmr6758895a91.30.1756679667500;
        Sun, 31 Aug 2025 15:34:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a269f27sm8725139b3a.12.2025.08.31.15.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 15:34:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 31 Aug 2025 15:34:26 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, wenliang202407@163.com,
	jre@pengutronix.de, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 2/4] hwmon: (ina238) Correctly clamp temperature
Message-ID: <d1d4ec51-bbd8-4361-937c-dbec3066848e@roeck-us.net>
References: <20250829030512.1179998-1-chris.packham@alliedtelesis.co.nz>
 <20250829030512.1179998-3-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829030512.1179998-3-chris.packham@alliedtelesis.co.nz>

On Fri, Aug 29, 2025 at 03:05:10PM +1200, Chris Packham wrote:
> ina238_write_temp() was attempting to clamp the user input but was
> throwing away the result. Ensure that we clamp the value to the
> appropriate range before it is converted into a register value.
> 
> Fixes: 0d9f596b1fe3 ("hwmon: (ina238) Modify the calculation formula to adapt to different chips")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied.

Guenter

