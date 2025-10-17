Return-Path: <linux-kernel+bounces-858031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA08BE89F9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520B85E21BA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 12:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B1D32ABE8;
	Fri, 17 Oct 2025 12:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwAnounj"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CC72DC328
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760704955; cv=none; b=MiuN8YKItjD2cTPFW3ezp0WAntH7nA1gMShTrCWIPLwyvMRv94U5rDybveLpQj7UDlxQslRP2EJvlAeRXkxL0rhPLdh5uBV5HFD6+iFdJBQOMMYYA9CC/ETgi+sl2yEsvOZm3D4McqzvKQP/doRo+Yc0WZRfpo9BpbusnS53Ids=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760704955; c=relaxed/simple;
	bh=POU5j+tvDqO8/nO9ZiDq3h6zTPVpd+d9v/uR7WHAxWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVLp+bqADFNtbjsYepSbGxAkgjRUXiqKCATI8ZSpFqaxxWrOvpWsjfYx6lIYCHsBfqQpX6Z0SRb0Fe5jM+UPkGLoWBd3skQjbFjFh6e63/5rYynqXcjuDtmSwmNsaIXC9zCZK6QCpeacDAw6NTdMc1TTfQ+M4iD697D1a7apXcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwAnounj; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7a213c3c3f5so2586375b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760704953; x=1761309753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lgf/jis+kn3VwQ0hzMf+yQz2Z7yEVW6ZUVMe2PEq2tA=;
        b=LwAnounjX9q4ZMAwqGZDDiZn7UPHg3zS+vmxVciNMPdxZLjcS7wiEm6EU8x5LP1RzD
         s4f8FgYuD/9RnNLjNzJ9bUdqe8PKg0XqLgBGkWbFiKJMItXJYMZ0x7LVKwoNg1YnG9+k
         UiAyuv8UL8PVu56ZLjNzXb8df9XP3Z33NGU452iCqUxyXPjCXXpPr6t22qTEPSh10MYs
         xoNQcYgtkaWGD6wEhx77fcQbzfK7xtnfC46rDp6Ijo5t+4HciYLwYgF91y8KGn95Fpmr
         cgg3VbRLRD6dhk5Ze35eSmobaJTkCf9RkV88xSsattJUCUuuLw+eOgsSkC60RpbeJL66
         0XpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760704953; x=1761309753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lgf/jis+kn3VwQ0hzMf+yQz2Z7yEVW6ZUVMe2PEq2tA=;
        b=Ybd5HOUp2cUYTr4spTIqQChzWPCB0bnaxtbNprw7w6n6ayxcsTDP2MCMqX3klC7dzX
         WfqaoqIUZ7h7auemnqOOAj8PYZvPMs6k3nZHFD8fNnZocRbd3cfHK8z6OSrS0czCHsqz
         U+tCP/8E4KHAII81iG6L2JSyYupCNSWPCdUG3YalDImFTpl/tdM5zKUsEAKrGF1mIxVE
         azmlQdDx3CYp8xrXW/fH9tl7VMt3EtfLprIIX6Ag5GrmVY3wH0r8VxzKWYNj2bsypZpO
         ReXFW0hoPU6bSd1EKIhlCn4kFkqqIBCiqGXEzVbc0mu/JhF6YnPLWb8+E4wbxRmU3DhO
         xamA==
X-Forwarded-Encrypted: i=1; AJvYcCVLldv9nY905CgG5s8NV7A4ASrnedV+TOTU43zH53Ng+QSm71E68CZvKRNvjXwfZQ9WYmvs2X7uTzn9ba8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKclX6KYyO/NJbhw2c5s9t9VIff1+wh2YNcNTQ13v4w4eOIaEr
	FZPWVdKbmXynxfqD7rAskCLkaMHo100hEsgyzzOdRzxuY5KZsjq4gmMR
X-Gm-Gg: ASbGncvWW8pG2QJqNF1nGd5SlHn8exuwqDYs+0ACL9KfmktzYvHG0ofccRnTovWWgPE
	jRtjamKhnAjdA/1zfePe5hHU+n0g0VhnGxvDL7kurymSCIYbeAutRsvBk55xl8WHy9XeeoCljwz
	eoNWWd0t+UN9CWzgt0XzyZ+k0mC3g9H7ANNvBh9cRBXUCKkxAM44imlkDPc3wj4KGBeNmiFwUFc
	HBSApbJPmRbsKZOkgMi8QeRyK5GhA5JIysJlw6yByjeJ62+CBhIH5/b1SmNMTQoSDyrtEkra87O
	zKBH6T99NLL1J30Ce6kcomu/JxmHZOgbqGO7azi/ZJi0vf3AT/CBLe4fZi5xM/jlT4fSDvGybyp
	H+vcz/9t/hN20i7F0TucTJwkuJ53+Bz0Gcihubpjghu/XxZ7hCBJ6DveXB2kPPaza2sWALO9V6Y
	yyD5ki/3AScAdGL8wGlMZ/J9M=
X-Google-Smtp-Source: AGHT+IFqIQl4xcuNro/f+18JqdeaKcp7B+ZvBEPtCwyqAzWqU1DOxii4XUib0aXOYR697MrcKnLO8Q==
X-Received: by 2002:a05:6a00:1a87:b0:781:2401:74f5 with SMTP id d2e1a72fcca58-7a220d56e59mr4076476b3a.29.1760704953019;
        Fri, 17 Oct 2025 05:42:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm25561467b3a.69.2025.10.17.05.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 05:42:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 17 Oct 2025 05:42:30 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Li Qiang <liqiang01@kylinos.cn>
Cc: thomas.richard@bootlin.com, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: cgbc-hwmon: Add missing NULL check after
 devm_kzalloc()
Message-ID: <fd8d7d4c-adcf-4703-9804-09a35aefc24f@roeck-us.net>
References: <20251017063414.1557447-1-liqiang01@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017063414.1557447-1-liqiang01@kylinos.cn>

On Fri, Oct 17, 2025 at 02:34:14PM +0800, Li Qiang wrote:
> The driver allocates memory for sensor data using devm_kzalloc(), but
> did not check if the allocation succeeded. In case of memory allocation
> failure, dereferencing the NULL pointer would lead to a kernel crash.
> 
> Add a NULL pointer check and return -ENOMEM to handle allocation failure
> properly.
> 
> Signed-off-by: Li Qiang <liqiang01@kylinos.cn>
> Reviewed-by: Thomas Richard <thomas.richard@bootlin.com>

Applied.

Guenter

