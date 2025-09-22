Return-Path: <linux-kernel+bounces-827044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9245B8FFF3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 12:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0031B18A0BF4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 10:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB092FDC59;
	Mon, 22 Sep 2025 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UZGGHLS8"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36143285045
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536778; cv=none; b=RKOiL13RINaQew/Rr2sG0zZd7dyRIyv8f5/ayOEkPVeJu05kEl/M6uPDvZbmgA0J3XtGTuuiBvH4d1+AAK/fWx7FDY6Ke70Z25QjJYb6Wp5GF8TM7ov6ie7TGVV30qPrcxSNWy8FTafWU59Zf96qlQziKwQIzzmsZ19eSX4O2xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536778; c=relaxed/simple;
	bh=x+816UkHLyRvuKb/oS0wEATvXuUn8rJpVOodqIFEeMc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=K9vQwvr/68RVS7nxCcWLVMf4lAznEKvXKc4Vd0FvsIW44z5OKsaMUD0DdD5vy0FP5G3vygvObFYBtVsei044LtggISYVqS9ksZd+Qzbv6opr6DAXIPCvEVf1S0ku8rafzcSNmLrfXTH5IE3ONB36urqczS1nW/LpcmXL/rUgndc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UZGGHLS8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3c6abcfd142so2075011f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 03:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758536775; x=1759141575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x+816UkHLyRvuKb/oS0wEATvXuUn8rJpVOodqIFEeMc=;
        b=UZGGHLS8RzxzIYOJz14wa0Eps5Am9v47sUtvODWN9ztOA7i+2O46SYemocthYKD1tA
         wc8meh7BMPsTs1R09TCUthWNYwh7eyq3xajkUhfUmCCpOl/YpoBt1xeS+8JC328wkHxo
         EgmK/R6HDM9VJZP3cEo4ys7/Cp+q3O1xJf84NxcE6GJtNQc554ErykTCSzUwraKEVG4y
         uB9NS13PKjuuImTEjECN3I1MjqCTTq0P/rUZ60gaVmxwupxPc2dk07mVphNNU79u6bnt
         IyO7RmyxGBFB9LXMF6NVRd/UkZM0f9P/WJMezBe1Nv7KVKe/qVswWkpmiPZxR+ermpUl
         UXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758536775; x=1759141575;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+816UkHLyRvuKb/oS0wEATvXuUn8rJpVOodqIFEeMc=;
        b=BqSVINJmoSeP9UXshd2gsiu96HujlK7ICkPme8tTaH47HQ3ifOOlxNT1T82zu2Qkkk
         jrat9y18Fs9xGuWOjxGXfOs7lNXa1jIc2H402rW4CMbHbN6wBGm/FDSJEBk/Nm2rL9eh
         UF3SglHuA8xV00n4oQJW+Gd2M18/oSjro6O4Kp5DwdUE22BbU1XObm+CX+XqMblcp0HI
         irUMqZWUltClFpG50FRLfKPjNLfVilsfNRHaEA/cTWhWxePXOW1cxfU7+niUYna3w+uN
         EaaSt7Ou/SXJm8P8kPfUnPOVH7YRx8tuosMBgL7vMsvmz3HaCABXuNbicHTq9w3Sb09w
         H60Q==
X-Gm-Message-State: AOJu0YxKkntv+t+9pC90QFEbwYDHnEf++A2WTBv5olXRiiA6XJC20Fl3
	Z+s01wj+2omVdfGoY+jzv5N1tNd0FO2xlhtsClojNk2dD043gH6K/6g=
X-Gm-Gg: ASbGnctmGvu98Xfbaehmz2yeOEJA7HifeJgYISiIGlko/5/Hw7W2Nk1pm3QfOh7KrrK
	oBeXSym80XVLUBbcjgJ4cDjkpRADZqzH2W8eyVCQeS7Uhv9kU1Dc355VOZvEIdtnE085nbAyTWK
	UYBfFbgqFdkFlAMpopoUlTJR35r+AyisclUQBe0a9OTnpWZfinGs4x3cKYG3mf+d/e65cHoo9Uf
	iMDOk6mdFCZXvcELrue7akpRYumwybRFAl0eTznoUkK8Qiyx7lBZ1f+lvyAALT1Fjraq8aTOSYg
	RksnhQGVcLK8Un1e3jigM9UPCWHjoxA5xqr4AcoOVln4ibfws0BpOMF80yzBOHAyL0mONw2HYtt
	STtWYF9UGFkd6LZAPXsRrsGZljzBvn/W9vg==
X-Google-Smtp-Source: AGHT+IGT/XCP8Ckm3XZbHQrxLORq8ZdI8TPKN9zhYtRcdj/W4jZuRUzrBpAEGg+mxMwsGndI+Mm1hw==
X-Received: by 2002:a05:6000:2001:b0:3f8:e016:41b5 with SMTP id ffacd0b85a97d-3f8e01647f7mr4697830f8f.14.1758536775291;
        Mon, 22 Sep 2025 03:26:15 -0700 (PDT)
Received: from vova-pc ([85.94.110.241])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3f0e28c83d6sm13845992f8f.56.2025.09.22.03.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 03:26:14 -0700 (PDT)
Date: Mon, 22 Sep 2025 12:26:12 +0200
From: Vladimir Riabchun <ferr.lambarginio@gmail.com>
To: ferr.lambarginio@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	mark.rutland@arm.com, mhiramat@kernel.org, rostedt@goodmis.org
Subject: Re: [PATCH v2] ftrace: Fix softlockup in ftrace_module_enable
Message-ID: <aNEkRDSIce6HTGT9@vova-pc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMQD9_lxYmphT-up@vova-pc>

Friendly ping.

Best regards,
Riabchun Vladimir

