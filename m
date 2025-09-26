Return-Path: <linux-kernel+bounces-833485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 719A4BA2223
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 03:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BAFA176F91
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 01:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0991946DF;
	Fri, 26 Sep 2025 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtQmfJNp"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641D7186294
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 01:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758849705; cv=none; b=ohLfc/6N+GlQ/A8s6zEj1oPkH1bszpL8u+J+4dxdrPbLb66vqgrrIa1Mt39jRS3oZjLCi8UvCVfWl6kI4YWO/KJ7VfSuFPyt+jnOhkw5z7zEI91BkYMjhrfHUZixEZKR15PlAbMsPny1/EFKAMNoaM/uymkB8mTRuz/ONVxAmls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758849705; c=relaxed/simple;
	bh=Qf7Aixfg+ZsH4rCpuTDs20y0ntBGG8SleC6ZBW3wAKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cvA49D+lV5Dc09ay5QCpOK7kkY6p0EPyJrjctL66fsbUy2SWAfNhKdmj+usbaEa/xUjz4WV+g+X4Ez3LzUDDc9USvvKTRgAJcQmWjO+2NfUSD0twe0m8ivLEjuXtgEc7L3aUiJVLHLU4uJRu3CU0MgQNky1L7E2BxkjBtqji9LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtQmfJNp; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so1531655b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 18:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758849704; x=1759454504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AP6fJWx+DDl8KhZETli23Qj60jKeOdbMieamHjTLXYo=;
        b=TtQmfJNpa0fh2qm1v7ZTXZ6SkpX3iMslISkjYVr4FdVyVlJObRcRJQWnJYgM8lA+P9
         DUDpE8lQbFmJWayUM8zkoFFZwOekDUwi8ZipTmI9SzM7O54qV9NCGgP12gJ08M1I4hBz
         MiOCgYo2dDzuMWkesKJv7j7nMs/eq/Q7KdPkAYtBZM9H/OjTrNHWF+9jKtJQF6eJojEw
         UVSXZrJvqeBYaCOYVTKrweb5xnUHWaNcdp+5CNFZw/Bc4qDuFwZVQTHxhhPbtsM1uIem
         VQYMXC8bsTHc3J+rjkkwrrHE17eJ4lwuCS3MoyGT0RkTympcEPmjHiBQT35O3w+etVW/
         0lNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758849704; x=1759454504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AP6fJWx+DDl8KhZETli23Qj60jKeOdbMieamHjTLXYo=;
        b=HdTwC7TM1wAWjCfvLIfh6nBYRY1fqNH3/N6QeGFXUgwjBtJLrP0+b4AFQ7JzIvJiaC
         +H2z0YxGbsrXEulyQKn65roriMKBLzHheeMZOTb2CTEllV2L3zZ9G8jkMX4OcJusXOzr
         VnXwCFDSx72nxjRW/TKCQvIxmxDkzGBEn9kcmKb2KhMcv45lhgf8fS3m+B8Z/+dMAhGS
         S2XUujAkQZl4fZ7SZUexEKeVIeGjX0+P20JUJ42qq6+haRo5lLgZRjnbL6mc462sBdMp
         yyjQN3bSW9uWfTCEtKx15g4OERAT6PZA+uFFupTPdYvSqmCQRMudp3cS+5Nn5uZbn1xD
         GLzA==
X-Forwarded-Encrypted: i=1; AJvYcCWY4XIV03eNJ8s1fx4p6QL6dW3RczLl6aTzzEUJrbILorc7E+fSyzs7NF7fZWXBE2rJf8hLAn0vXeT31yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCr0e5+f3QMaGlqgQJm0pNitgx2hyVEeREIIhN2BKVcFO5Fm/U
	BcOUhgCIvl6njpjXprySHa2dqlVJrErgR2k+9CWXzyydU5oMrlkOu/Ib
X-Gm-Gg: ASbGncsZTCjnOc4gBJkwqA1H7rlTbpMqI0AfCR+OwKCOroPlUNzTaUsgM2XVLrH8gCr
	eyZAYZaQ4JljPxt3OXi4QyzDdlno83hQFbUssPMx6kNXgGz9i8OdQpXADEwEQGOG2tD+QAcq3Uq
	BKlNnlOGsVR4YnGVQ1LzFSufvQCkAfPLANDPrEw+3eNeBD+q6Dvfp45e1ONYimYL5mgWvhmMfk1
	qLH9A4NEyBMeqtSKuStWuDv8OeIwjEz4ER8UuFHPFyjnY3RgliFe1g1Stb4LMIVo3dGVhXNioOf
	TrBMkAMykr0rxB0VBR8jELVG+KB2xNnjq4HgVClh6PKfXTQBbDuPp/A6WCC3+NI3lpPJG7kb/XD
	jN5vQsaV20Tp2uFUILGy4XMlX9DFjpYmCjFE=
X-Google-Smtp-Source: AGHT+IH7AU9odF5p04RR7XTxrYV8lFhFoYCRERAsrchheebfwRcifSg/WunbI2lPkJCi9K5QgUVHCw==
X-Received: by 2002:a05:6a20:a122:b0:248:86a1:a242 with SMTP id adf61e73a8af0-2e9a0b9b2e5mr5509072637.4.1758849703636;
        Thu, 25 Sep 2025 18:21:43 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b5dfd6sm3112336b3a.68.2025.09.25.18.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 18:21:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 25 Sep 2025 18:21:42 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	"open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] dt-bindings: hwmon: (lm75) allow interrupt for
 ti,tmp75
Message-ID: <e6143356-3de1-4be1-a9c1-6a250a5e9390@roeck-us.net>
References: <20250925192219.303825-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925192219.303825-1-Frank.Li@nxp.com>

On Thu, Sep 25, 2025 at 03:22:19PM -0400, Frank Li wrote:
> Allow interrupt for ti,tmp75 because chip has open drain ALERT signal.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Guenter

