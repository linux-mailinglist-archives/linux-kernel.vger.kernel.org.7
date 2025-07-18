Return-Path: <linux-kernel+bounces-736452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3D5B09D08
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 09:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C06E168C98
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 07:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9DC29346E;
	Fri, 18 Jul 2025 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="ZGu7d3Ll"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48013291C0F
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 07:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752825379; cv=none; b=QQygqG3DWkM0y7IcL7f+QG1crfNYLjB34SG2Vawi9phQ5ofEkt48Tw63u2BOTn0btyxRrpED3IGV664omP+9MSscanIwm2RV6IUqdhWg9EJA0HPy26kCoT4D//F+rWvxgqOTsrryg8BwiIzf8CgPm+E84dNcULVbccoEqRFT/Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752825379; c=relaxed/simple;
	bh=9EZi7hXjRsnXNdY7SoZRLPhrUWdg/ELcZQ/IDT3Ukb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eGZdpcF/CWM6yGkwvjAJ9C4yVHYnM06FwPNY5/JlpapT9ygBuKXm/GH5RghcIlgv7lew3szWpwclfhEeZ1fDnNr5BflYfYB5DHqCOuZXyB6Ovduu9xfdxJDaugdzq5DnliKVzA4+9ztngviSnCjZ/isoiht/oqhDncbcbhS+odI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=ZGu7d3Ll; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a588da60dfso1093696f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 00:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752825375; x=1753430175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN+uHHE8PV9NsxzDe/4vVMLQJV2WuEBnbmW7nc4a7jQ=;
        b=ZGu7d3Ll8exsqBXqMxcqXTbyqNHDQUMjFjD55W7K1cxxJcxb+3aGuw++8i2rsBunn3
         4pNh421W5tv0OYu6P3Tauo7dJmwOrnqMclXhrDKF68aU8kCjFcL5b8Cjwa8YyJEEhkq8
         R9hkIeL/lxhxD+M2IzN2cQGilgPosnKqJlJ9a4f2VJSI4nuNJaccL0ncyMV4uAamqdgy
         jgNi1z5DArp7K1fD5F/0QBv1TjibGZxldNsjbDJzMcMMRRtcUCHrZ+/p1TfGJwwSjAzg
         ZK54wxxTYxYNMWSNuk8IA288n4n7XhX6tILShbAeQB+n0W4wobovD/gqtGQVBgKC9+fm
         1fJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752825375; x=1753430175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN+uHHE8PV9NsxzDe/4vVMLQJV2WuEBnbmW7nc4a7jQ=;
        b=Ucv8TbhDJw3oSJqKryD/iDsWYr98fmUgecjJnpJPEm/Ub61K/rZJaBOmmMZlNBX2lv
         OabbEvGm7WWNtDA8bkcwzwhuwoOHBHXDTkuliI4Ghxghhh2EblScvPn9gXSRCoxCx2Mh
         tGc8qoEB/aMyR8wSWqmhojWNQRkrsrB3q7HUb7TEZ0CIcHW/RN5lfk0SjZ08qHB/syn8
         VDNXnczHMeNQ7IATLAGke7W+4akoIM4QIx3Rh9iHXbqJ9ZawKkEEHnVufZvzyfIC76BB
         tzV1WtQ0X9xDzTePUVGM6N6Pp7WwZotSd2y4wuq7w0UOVhFhxVhYpaW4t8PbZl8Yn9L1
         4cKA==
X-Forwarded-Encrypted: i=1; AJvYcCVO0P4gLGN87koTpB6RWe5l2CzXddwAfFlfqzR+d7osO3rBvHCv8qqh/4OUwzVMprUq8/N32mLLe7dh5+M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7bN/azNkMnscdrDU2OP5YW93v52FvLK3c1/JQCcArMl77pbCr
	6u3RYyclb0gndsKPIPkARDQrl2GUrCXstkVg2et1itEEiH7gcAtCGy5v77Jt2Fz77sE=
X-Gm-Gg: ASbGncshGvx/EUeOlFCf2R+D3ip4EuVyl8y1C9a4GSd5LbhJFyF8AEMbf9OvowqL345
	5uoR73YW4v60z51xubssQ1yRQrMg1NL3tCXHGCviWBayMkscYdafsNfxhm27TUexPZWaQ3vxwBL
	FdOKQdDZ3tclIxlR5LcaCQnSxfZRnzhpMZ3DsFjCumh+ODRdJcqd+s9tSQ0WbzaykBnnQkvZWdE
	r4n7MKpyPx3KqhSTc5Ukd4ExJgiK0+NYPnYfv3esPacOvKCqRuVkxQyvFFMHrXwdpATXSAi3jag
	8rXu2yUUSvR+ITHze+zunxGwgS+6mE9XEqP3yCSgHKuJ2hyZojx3NYRMcsJyuPghGlD5+vMhrkH
	73AfllG5WW5Kvo3xQY2Ol
X-Google-Smtp-Source: AGHT+IEiAzcAEAiQ9ayFP7S55kjzIXFer1zIeY1cYSz5UvgjCnvHPIHe5gFVJIivHGSmeTQprnBFYA==
X-Received: by 2002:a05:6000:2901:b0:3b6:1ed:9ad2 with SMTP id ffacd0b85a97d-3b60e51b8bdmr8413573f8f.42.1752825374548;
        Fri, 18 Jul 2025 00:56:14 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:be63:a233:df8:a223])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca48a23sm1080851f8f.54.2025.07.18.00.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 00:56:13 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
	Srinivas Neeli <srinivas.neeli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: xilinx: convert set_multiple() to the new API as well
Date: Fri, 18 Jul 2025 09:55:46 +0200
Message-ID: <175282531509.45055.666620085878969574.b4-ty@linaro.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250717131116.53878-1-brgl@bgdev.pl>
References: <20250717131116.53878-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Thu, 17 Jul 2025 15:11:15 +0200, Bartosz Golaszewski wrote:
> The patch converting the driver to using new GPIO line value setters
> only converted the set() callback and missed set_multiple(). Fix it now.
> 
> 

Applied, thanks!

[1/1] gpio: xilinx: convert set_multiple() to the new API as well
      https://git.kernel.org/brgl/linux/c/906b955c60770bfdfae141aa993ae5fdb3eab193

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

