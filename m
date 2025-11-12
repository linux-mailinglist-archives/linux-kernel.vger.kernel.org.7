Return-Path: <linux-kernel+bounces-898115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EC4C54667
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 21:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924133AF447
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D252C08C4;
	Wed, 12 Nov 2025 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zu/WLApS"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6922BF016
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762978510; cv=none; b=mrNLGs4PWpM1GSv4z7kJW0JWEKgGPFjTp89ZQ7/87dLrrbladquPzRlT/0/ebrMeR0gEYwgXYheyle9geFS+dphsEuq4sBtaToT3totG85C/0sbzgqJH9vxd2PNyzjYNpLt/CJ+ZHAkwVkacVTln8H0/+lxOXYL2FdWtwJpYvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762978510; c=relaxed/simple;
	bh=Eiwvm6yluoO0JX6Ce6PQ59k7Nip9lToT9ZGCLzyprIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6bX8EWPldVn49hKsEkP3c7kD1M9u54H8U4fG5UQIk3TZ63qsp/Y67z12zqvmDq1qjguQg50Ci/pMnbNCPJvZtVsubZDsmmPFHO1MpJlrdcWgptb6MSoe01IqErwQyQce12qRwOBK00zIT8e4UN5XyvLTJb/reuFfZ0dVSjKTEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zu/WLApS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso13879b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 12:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762978509; x=1763583309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0of+Alf6T4+63MJiwJGoBZkQR101RqICgRjSBtL9Gv0=;
        b=Zu/WLApS/BNmAU7w1BGGP9SIXE2toxCBoKY9mEcLPd13TneNRhHSEpmS95WE3hKXcg
         JanKlNgEJs9JHh+f9HiHqucs6LLxOAkbfn08WWNfCq2Vlmtoaz+CyV9ELEZ401IRguXu
         5tXQ1BcDEi0XJeXBjYXR7V4hb/dc1WrwE/d7qx8iwsVv1vuKdAvc3Yo//+FIEzKEUb1F
         uCJgObU2Ns0ERtB/ozvJh8p7PzbvjzAihtOf91HF/pl5z5qE27xHUntNwLY4oSg1+UPw
         k7+8uyOLRuBE6+zYYIPrM3eWZvKMdBjnl0EwHA1g+bRVIEZnFBYgbQbiCwjuiMLeetrb
         VreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762978509; x=1763583309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0of+Alf6T4+63MJiwJGoBZkQR101RqICgRjSBtL9Gv0=;
        b=KDsEZkWNIvR4EIMgYRsfy5s/z1nJ0EMsgmQHkCl6jH3m/so3G/hSyhvZ7thqlCA1ZA
         RfzsyhZ6S0P3ahVtw91JtWNSPTkX92femqHDfBF6/rQALpdcrt9MMrGRm6fZIr8bdJvF
         z9dTNOqjzpI6cdT/4IOkRhO/qr+RIvy8PuIxhbBAD8j6fFFXW0JSoWrBRgtzj1VJAKkx
         1rnLiBOLg8/YvIW8oBCn4Uq+UIY6YiyBb2RWwkFV+/aXJYD6icG6pfbS26qEsl34gj5z
         SNzC0NRunmJcluKr8XJf3W9W/53KmY4ff0lmBed4fd1KVwVbpNLJUJ9IVF6hqlk+JhbX
         K9KQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOEP2/URm+r+4DHh2nR6g7OlnJldZMt/r2Cn4adxR7U2h2VnycWfENutx1b7yTkCZQ0ROWjXUBY78GjgY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwF/HpgixYuCoBCq9v6nSm0XOzcr8y/C+vp2gTkhc0hKHmzsfii
	kBx+eGUYxVsZQbOU00OJ+J6s67BOD10S2zz6IdeSuVByqaqOtRdI/nKqFtIj7w==
X-Gm-Gg: ASbGncsv+oc/76zF4x4o+IqtSEt+zTRxFv4hWleapsSjfm2MyYB44c2T3mlm/p/GouG
	EfsJp+fyFk9eGB6hDjPhRMP0rqaqKyQB5fnOWArLEq7LMWJvDPrEWeWhaT4DurQPG++3ZNUVNEL
	TupzOHBS5mSRjZnew9kxg5jXw8lnF+feD3S9yYJ78M5TXZqr8dv/98Rypw0b8nEGUZ5sGBm6jvO
	VY7WRFmwMm5MBtJPjU3lqF4tI1JGbszju7U0tjE7sKXUculF/fBKNZndqzXYUY5ZXzX81Uo5j0u
	bK4pZZK94Ss6P9Jjv+VvSrr3GMLQ7ZLwbbMkGkhvUViAc95kQSYfo5DJVbaBFgJnJ+YAE3Op6M5
	NTQ1btzvRHDOxADa61lsJmsckfMT/4PcLsuRfG65Px6j3Hq1mqatWjQV6MlHEX4sSF6RqWOcifs
	aWwMzsvA8PhALn
X-Google-Smtp-Source: AGHT+IGJVaBzUd+GH5+0F1+fgUd90xKgi2sOsh2N95NvCJUwi0b5/poLRgwWQ0qknWXA4663p3Wuqg==
X-Received: by 2002:a05:6a00:2d95:b0:7a2:7f87:7ae7 with SMTP id d2e1a72fcca58-7b7a4aed5ebmr4413457b3a.19.1762978508405;
        Wed, 12 Nov 2025 12:15:08 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b0ccb5c674sm19222420b3a.59.2025.11.12.12.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 12:15:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 12 Nov 2025 12:15:06 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Bruno Thomsen <bruno.thomsen@gmail.com>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] hwmon: tmp421: check error when loading label from dt
Message-ID: <fa23e0b7-c0aa-4c90-9ce5-1779a94221f2@roeck-us.net>
References: <20251111144406.7489-1-bruno.thomsen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111144406.7489-1-bruno.thomsen@gmail.com>

On Tue, Nov 11, 2025 at 03:44:05PM +0100, Bruno Thomsen wrote:
> Add error checking when loading temperature channel label defined
> in device tree. Handling of error from of_property_read_string()
> is inspired by lm90 driver and therefor contain same error string.
> 
> Signed-off-by: Bruno Thomsen <bruno.thomsen@gmail.com>

Applied.

Thanks,
Guenter

