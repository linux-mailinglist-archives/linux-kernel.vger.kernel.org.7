Return-Path: <linux-kernel+bounces-804717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4DDB47C03
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 17:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46FF417C8EF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Sep 2025 15:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5784E27EFEB;
	Sun,  7 Sep 2025 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBXzwkEM"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593EA27AC44;
	Sun,  7 Sep 2025 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757258378; cv=none; b=VfWA150fiCd2VmH/F3p/yvNbxvf3itsDWEgc+KWgDFdnLGKW4LneQ0tDoBFsam6VQyA4xX/iZEvIFuk+6MAea6I3mu/D6JANU2y/2czaJDrt+erAfppYfRvr1CpBDrHu8391GQ+V6smIICE/VMgRDYAi1JP44eQigS94VtVxMXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757258378; c=relaxed/simple;
	bh=SqKMAQ7sFn80rNZ/6WgDZ/7jXt308cRb3LHhVkWNI48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkaHlGst0YK1a3h9ENijTsPHdjWuP1xaTy6iGvr9THo3rAX9PDY10g8OsaukbX6VFmpGZG0vBY5jD4l8SmXk5a5zEyasdVfM/gBEQUsyhfyGS3Lfp5cPKIPDy0KS/mMGTXuigVC0baJTCru2jml72AOGfdtluJeQCL1qVegfzLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBXzwkEM; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7723cf6e4b6so2719574b3a.3;
        Sun, 07 Sep 2025 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757258376; x=1757863176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KoCTtKW3Tr/yX2iRTvA5LX7KDXYbgv/R3LjzPROXCKw=;
        b=JBXzwkEMUdAEROjkXMqIhvFJ2DNj9/IZFKf/yjn0rwjgqEFR8a9aPgvRD+tcHAsqMV
         jMtMW5fiYy0hyiUtWfJ8+BfXIK3GgyV/Fa1RJ5A7jQIFOwGBS5YXo5veYG56R0vyEWIE
         //QOkrFJw4V5eM/4c6RjhRIeul+W2kLNbYZubB7DLmr/+80QXAoPpeTKImND7YvZb2rE
         JCuhhFpR/W2qSh8axIjXOf5G7YzZXnMAqhjLD7EX1a0tka6bEXJAudu0pSLm5XNZ75Gl
         YVA16XVfTV8dDO+VSlTHoWOkxmK6DmJops7v+Z6Xj3kC2OL9z3EwuCp404AJ86PkQN44
         r6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757258376; x=1757863176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KoCTtKW3Tr/yX2iRTvA5LX7KDXYbgv/R3LjzPROXCKw=;
        b=co7Ot3p/jGP/vPoO+XyZiOnNrfsa4XLdYMgawPHtr3OcgSiks2ngpxWDGTPruu/Rcu
         MCyae6NlHUmt1FpccB6h0hyHNWDb/eRFm5iGMMRqJk9gsBM+MOXb0TGjIWKU6yg9xfDI
         5bKg74gdOEuhZl8u4YSWQ6q++MTTIp2wQ7AMbcxfGa9mkuxHEMiw+kk+V3adcgXCvuAd
         Rox108VZwMMXbqEPvOuc70uP+GGdWQnlqnnnZr7RqXUU3QHpyMAOr/VhFD0JmsVT3068
         E95YOhL4DiHOiBSu6mkHlNusaJb9ZtopZpA6gTJmHs2uo8j+d+oMKRaN0NBg5vbPkhk5
         4Oug==
X-Forwarded-Encrypted: i=1; AJvYcCVfei7zalqETZdzfo+eMlq00J7HJrEQRcgqG0qzqaXDipGL1ncdRU5pNXj3SCvmBmmhTFVdhn1FMrp9@vger.kernel.org, AJvYcCVtTZf1C5oFZsEfp6UlyL0U0XaIFUQrWToCpvkFE5Ire57nK0Jb9VsBmXJg1p5rE+Ynzw3lYNthmI4B@vger.kernel.org, AJvYcCX/TLIueUJYuqVwNpjMX8+mTp8mX2SmSUXZ6yzGqnznTA0IUR0xLyc+lS0rP3RGm069keD42l1CAmSezotK@vger.kernel.org, AJvYcCXqICbOsRibu+D7PkSPcmH020iyCiUGeer9EI/0W70lRHZ3xCYFJ2KAgXHj/sDcHE9UUMkP2SsAsvYRUbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfqrItt+tyQFQmJhwm8BCNoA/A1vmof4ytwE1gZw2pY84jkqTy
	39fffH3/mIMrLXC7qrXRCypbD3YbU+1BqnpxTVKH2nQVGhZ2htNgBm3X
X-Gm-Gg: ASbGncuQBxnaPpquxpSqeM7mtBAic1jluhPIvV62yPKSTjez3VeboilnKqhbaReRDKc
	rK2vT7TAhTYe0BYiVh2bVt+ZMx3YcXv6XnGODz3Rmrx5cwCX2rqXMNeiOmSbOg0oPhIqisc8TdY
	R50nj8R7Egpb+s1QBk/bSk/wJ3HeYsytansrQWu9EhziRBS4iL6u+xbAskGtpBqpitKcSc7Ahvv
	53GJNoSr+C/qhSPfAsYe+VPh3uo4uraCH6nz8Fu0Uykru9xIxn3wbk8SXIFcakzo6FiaGjIR1c/
	Ybral9Uesgzh+0w9YB5eKsyMxqONxAmHzC6awYA/BGuJHQuaEuup/sMiVdkkMC3aRFGPmzXzaJO
	H+SoDmDYsYiEFyR4mSC7RDlfi0L8jWYKgyAM=
X-Google-Smtp-Source: AGHT+IEBlI712JdWUw7U2nLunIqLeFUvAcl9YTIuScdErDIJ89NHG/Px36nmk1S5CBTenCfgOu2PKQ==
X-Received: by 2002:a05:6a00:2e16:b0:76b:c9b9:a11b with SMTP id d2e1a72fcca58-7742dc9e3b5mr6009979b3a.3.1757258375589;
        Sun, 07 Sep 2025 08:19:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a26a4e5sm27361256b3a.19.2025.09.07.08.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 08:19:35 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 7 Sep 2025 08:19:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: wenswang@yeah.net
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	jdelvare@suse.com, corbet@lwn.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/3] hwmon: add MP29502 driver
Message-ID: <49d39a3b-db02-4fd6-bf63-72c0597b05b0@roeck-us.net>
References: <20250805101754.749492-1-wenswang@yeah.net>
 <20250805102020.749850-1-wenswang@yeah.net>
 <20250805102020.749850-3-wenswang@yeah.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805102020.749850-3-wenswang@yeah.net>

On Tue, Aug 05, 2025 at 06:20:20PM +0800, wenswang@yeah.net wrote:
> From: Wensheng Wang <wenswang@yeah.net>
> 
> Add support for MPS VR controller mp29502. This driver exposes
> telemetry and limits value readings and writtings.
> 
> Signed-off-by: Wensheng Wang <wenswang@yeah.net>

Applied.

Guenter

