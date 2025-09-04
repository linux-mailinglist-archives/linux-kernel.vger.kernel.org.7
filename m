Return-Path: <linux-kernel+bounces-801032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1B3B43EE5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1CD16939C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 14:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABB331CA6B;
	Thu,  4 Sep 2025 14:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="R58V/fXs"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BE0312835
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996298; cv=none; b=aQXotnsoqq62RRq3FE1weduiTMYBEo83wwFLUwaXUiYC+KrervqO/ZQrr2kQtm8UFkWz73vJcPHGBgmXp35nkumSwhKqEVI8NGFKyVch1gUyxpmIzozApmC559ufGrLwo2DKYjvCbcu8VCwhHVTX0Eyo7MtacdkDBv2cJ2rP8kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996298; c=relaxed/simple;
	bh=Jqv05BEur9jLVO6NaKp7y9M72ErD6pTvcjBw1BuFNBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQPIWnoBuhU6G6l71L18c/ZGGIr8aUm5xGUEaXc7nJRLXln6Z+XiVlPOnQ8xBWxMMtMfzk6ni+UKrCnJ1DtD9uv3vToy1fbj29a8YhrcoNi6fbDUXgZqopFhWd+vcOnFSCRfHk/ZXvqkbhTBMHTOXrMWOmHhuca/5NDDrhyzHwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=R58V/fXs; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45dcff2f313so6363885e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 07:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1756996294; x=1757601094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SOWc/c1a94HTBP6zFYRMkz+Dicl7/4365yjhzPWmzAk=;
        b=R58V/fXsG/bU+8Jj+szLP0FD92FSkIptWQFoUQFUUo/TPzLoTO6rWtoCK3H4ARxHoq
         kuVTh/gT1woUij1wr7+LfTyE4FZspe6g6gjTYOHyVfHvgmKIs/BDbYRIqDPry+wTv1dy
         Mryu/JKlyBtPvt/93SoaE9N1/BM4QacnJpvH2B0i+UmxMxa3Ecsie9fWZ5eUP0giOlia
         dyaQK7yAhjKCFXj9rri8At/HpV07cUzIrAEe2aQyVcsVr8+5iOnTftf0c6Fr8jxc474s
         0u7OUSWFqlMqqd/pB/8HSS/q6BWmvuktG+PZXcPSibOyqcxXhR9U/6E+OKc7dhSVecf3
         82vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756996294; x=1757601094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SOWc/c1a94HTBP6zFYRMkz+Dicl7/4365yjhzPWmzAk=;
        b=ag4mwzJNdXUUtKwNrJVJv6d1HjDHTe05rP0xCeAHAHuUBVGi0JYaajg1a1PHF5s9nY
         Ip+ICPBn34cnjOnhXFzLZ7kmCYgok4CoPq4NjuIPN+bZ0Y2QHCGYrRokZQ6ODM8k3LmW
         LN4HjqVoJRp0Gq6mjB9j0dyVWS8sPNnpjEPkVc98774C6LEm/zCiFl5cumeeciDmZiPO
         OIn92pwsCF+PZ2LtRCIIl/v1GwA1WXBWY11WrP2UxsXCQmFH6ALxyGT16JBlgK82zxDE
         lmz3ue/r1zkeGTaD2xIxHJfCoc+KFLlJcW8uLpDudArJ7gTOjb32HDWHyFPNgmW9QBk+
         KCbA==
X-Forwarded-Encrypted: i=1; AJvYcCVan4t1Qt9KnUCpleYbD9qLuf+bCy/1OKbLj/LVnjpD8OG5q8pUqoypQGlub0w7AmH6nB1s6pt97kuvOoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyKWlW/gYa0Izr1bG+RQl1Re39P1mg+4T3iZSXW3/Gjgdt6YKq
	FM04I/ieV4IpGN+zZfeOoiBlNlV583kUZxEqwOTbBPjg2xrw8NHFpLKXMvecwwNttAza8Cu4jYy
	w7aR4YJo=
X-Gm-Gg: ASbGncsDjx6MhBWZLFmm7PiwjvdyWR18PYK8fUOCw0b8zFlQKFvH7qR26L6RupRr3Fu
	v8P+ZstHY8dZor1pvmhndwdbIm7VgZGyP/un6eK5v/WHCGLtdrriP2KpJ2Ut5JfqGpkjfbE490x
	ZAusggEOiLYP6nkTZ+N5ASq6zHlXI3Lhx0/qoVftu3Oux8D04wdbw8Yxrbx6kHnWjseeroDjb76
	3UYQlUEvtE5Oe7xPTUmIDw2uVDKc2LuzELNOX62aPlgR+heQDzUMVF6HPR4U2FvkO5KjhdwBKy2
	W9aQQd5D2xy7FxAHnfFzREYR8oQ6M05ERVUcJhuCqXQ1C2l16vuuTnnvWwNZg8h9/dUsNxmwon9
	O4tbDJOjhKhEiVtMYd0V6TfaHEmvQe6q6Y+upVNQJ6tPY
X-Google-Smtp-Source: AGHT+IGfdMUSy686Cb1BqOU8JAIe9bVYHo+twh1W9Pn3DRVe6Sxnh5hEhO7YHP8lWHvi12JNN11Fhg==
X-Received: by 2002:a05:600c:8b23:b0:45b:47e1:ef6c with SMTP id 5b1f17b1804b1-45b855b2b0emr155588755e9.35.1756996294547;
        Thu, 04 Sep 2025 07:31:34 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:6e82:a4aa:49e0:a7d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d1319sm319642535e9.5.2025.09.04.07.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 07:31:32 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] gpio: nomadik: wrap a local variable in a necessary ifdef
Date: Thu,  4 Sep 2025 16:31:29 +0200
Message-ID: <175699628267.79535.14392040407433836716.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250903131903.95100-1-brgl@bgdev.pl>
References: <20250903131903.95100-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 03 Sep 2025 15:19:03 +0200, Bartosz Golaszewski wrote:
> The 'desc' local variable in nmk_gpio_dbg_show_one() is now only used
> with CONFIG_PINCTRL_NOMADIK enabled so wrap its declaration with an
> appropriate ifdef.
> 
> 

Applied, thanks!

[1/1] gpio: nomadik: wrap a local variable in a necessary ifdef
      (no commit info)

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

