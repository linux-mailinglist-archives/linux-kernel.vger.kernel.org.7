Return-Path: <linux-kernel+bounces-774910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B675B2B914
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 08:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C203A627070
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 06:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275CC2609CC;
	Tue, 19 Aug 2025 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AGebLq3Q"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7967E176ADE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 06:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755583556; cv=none; b=qrex0UZIMgT9ZxxsaWDAipn1H7v9rPHxCMGVN/iCY/c9Czeo5uleil6y4tK57AIntq1ON+PXgxQvMgXLY7bbk+TwocWmQ08ZPRRRZn3a9NIu476BLwFcsViDa8EK/sgkr7no+3ls4Tw0r4EiyFXJj3rdx0nXwpIzuSvTU3px9cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755583556; c=relaxed/simple;
	bh=bxPgM7yo/aZAhGNQ4NGGRlw3ruzUcR9O3+5SiEZqKnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiKdm+xd+v6JBzLDWqvy4Qg73zHoQhKURhw0dx/rMqI++w3QPlh6jSVBDtB12nY7fBTXk3eYHDg6o/EDG8OXVf5/pkdI7fNaMm4ht8KBqVopi18SIVC0N8nvDoCqWGPWYJ2OE6+TiCf0vOyGe4ToAkk/5SVnKNgc9z+uiRduJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AGebLq3Q; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45a1b04f8b5so24393525e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 23:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755583552; x=1756188352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyYciVPLbS6snOaAsO4fw3vEl41HECaYwSESuUU0uXk=;
        b=AGebLq3QXIYgoPEFy9zQdiVSrn0fsnTeQsl7Oatbuxbbrli95ElYIz0H48jA8OQW8Z
         8n7aHZ95NZHlKVSG6eX+6FirbK1U6o7JYm0WQkgfCt+Y4XSsbv344lj8m374QZxrOfss
         5puIscq8e9THEnj7aDPIXVWGxeQlEWIhH/3KRRWwvPmv2K4Lm44E3UfTIbd6xYZjv/NB
         n5cMchhuMiFZRPT86smdtxGTUnIlYGzKPy1hXlUGQNWsVvYbEaZVu8gbm5bGbmKO1ADi
         LN4NAhCxaVW2NA5B9ynaBSJ2xh6/10+yO8FxvE28yVR2JO9ZjAwcTD3dTyse+XxJFwrK
         9OpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755583552; x=1756188352;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZyYciVPLbS6snOaAsO4fw3vEl41HECaYwSESuUU0uXk=;
        b=eRkA24eCmhB1c8HWii1N45M2xq+6mf2ORgwfkTQg5SriOMleXNKtwV5wJQGwSjRElN
         sLCKgLGwrhiel0LU6JhX2kPZkBQI4XvmRwR6lDzjCuIgXie165umHRb1j1CQtoF1u/84
         7gFHNu4OQYDQGUBEtwAQTNOH82vfTmiLIIdPyKzeYnh9IQQQC0nKzcBqRtobfxUNvLPO
         CaCy/grsEtImlp1IPISqzRumnbzA4smyRE6Z6C6k+1eiJyocIizS54kxXyTu369Rq0Mk
         2qH31ZHJYbehP+e1SLCD/mr7RRH/XGdEUcHLURbkylPXO1D5ENruxCrfATkDpfPYofbX
         HsBg==
X-Forwarded-Encrypted: i=1; AJvYcCUe3f1iasvEhIljIW6OkUZPY8lK6jAmBOr3BGYLZ54laW3QMM647D9tYrowvohr9aSknwg2IipJCZLVQnU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+vyKPaet37vK6u51pUPHRdUohoeM8kkwNx3n6X4hYToWYY5Iw
	8UDKDwLz5Z0JWUGAmrQmFRvhgFSlb+jqwVmKoQGHA8QJpTez7SxFX0EQBqcp9gSO8Ro=
X-Gm-Gg: ASbGncv5Et82w3Ko+rs+E93lIg42tTx458VREFLTEjTwboMhzQX7sJPhSd4TGEzR9oj
	3Y1AOCm6ae+XYiPJtzCdJuDKA/2oMGl+43tDUH4rWBsukAzXl0Sa+pYwXD7eucg2QY1HXpUJgLB
	sF3TmOpGgbKrOFgm0VbRQiaXheJIfuLTBpEOnenTzyxT2JhKNtpR2lUjO0ISlhycJMpAoqFKz8i
	kfwaqgoh0y5y4JhOcboe9nBDuBDCoh1lU58yD9jsin/SFqCYYiGHb4khb5DtOpOO1bfmh9H8rj1
	uQNRDC1maKmX9YccwkvA5sExQ/vgUSo0Hr+xpqLMQ2ILjUPNiq/6/TZs5+VDb9B6PZ+IjerVsqW
	Tl04rGEaY3c7r25nYw5Om0kju9faaKlBrWxSi7A==
X-Google-Smtp-Source: AGHT+IFw2BSNTmQYZsrxAeHUw41R54OQHcFGDyt5cWhAdj18Fb+YQS9GQGDyVsvFlrO93e7In/3Z6A==
X-Received: by 2002:a05:600c:3582:b0:459:db5a:b097 with SMTP id 5b1f17b1804b1-45b43e048e9mr9080665e9.16.1755583552442;
        Mon, 18 Aug 2025 23:05:52 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c6c324fsm194494305e9.1.2025.08.18.23.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 23:05:51 -0700 (PDT)
Date: Tue, 19 Aug 2025 09:05:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mohammed Guermoud <mohammed.guermoud@gmail.com>
Cc: marvin24@gmx.de, gregkh@linuxfoundation.org, ac100@lists.launchpad.net,
	linux-tegra@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] staging: nvec: Remove unused NVEC_PHD macro
Message-ID: <aKQUPPlr4hJS1UTe@stanley.mountain>
References: <20250818203855.11914-1-mohammed.guermoud@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818203855.11914-1-mohammed.guermoud@gmail.com>

On Mon, Aug 18, 2025 at 09:38:55PM +0100, Mohammed Guermoud wrote:
> The NVEC_PHD macro is a debugging helper that is only enabled when
> NVEC_PS2_DEBUG is defined. As this flag is never defined in the kernel,
> the macro and all of its call sites are dead code.
> 
> As suggested by Greg Kroah-Hartman, removing the code is the cleanest
> solution. This also fixes a build error discovered by the kernel test
> robot after the v1 patch modified the macro's body.

We don't reference v1 here.  We would do it under the --- cut off.

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202508182005.4PiKxXcN-lkp@intel.com/

Don't add these tags.  They're just confusing because we never merged v1.

> Signed-off-by: Mohammed Guermoud <mohammed.guermoud@gmail.com>
> ---
Here you would put a comment like:

v2: version caused a build error.  It's better to just delete the
    code instead of trying to silence the warning.

Please send v3 with a comment:

v3: Fix commit message.
v2: version caused a build error.  It's better to just delete the
    code instead of trying to silence the warning.

https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

regards,
dan carpenter


