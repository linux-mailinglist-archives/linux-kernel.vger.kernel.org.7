Return-Path: <linux-kernel+bounces-867059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A33C0179E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C403A94AC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4131A7FE;
	Thu, 23 Oct 2025 13:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQElGbQl"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3E31578B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226453; cv=none; b=gljqQV0MdFPU5bW2PFqG3BvH4Ik4IiyeNyXMRirZjZ22v2MVcV9bDJ6SlKYPyXQEfiT+rssp6PXLjqd/9SGwHQqFdanDfny2L1cseIvxh1sa/XP5pDe2jO/jUFszoIYwV0odbKKwSppWhi84fF92WLVblbPUWVatOXGr8ulAFC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226453; c=relaxed/simple;
	bh=xXth8SlDXO+ya0Rwx7TxjiL6fRIaXNPR/86PNBjKDaY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ghd3HRF63OOl6oCXNnKrS4HceUP/z+JOsmAYVmFa71kNJOuOeTkAV5vCJ4aUzWBn/8OPiZ4qsllTtAeOLkY21M42uS0XExH61vxFbyrXOvwOH8zMrbYFjQdSnV/mcbhS/FsxE+Dd7sPJqFmm41fgjFI9taf0GuuZLd+mr1LjqN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TQElGbQl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-414507aa5e1so41906f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 06:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761226450; x=1761831250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snm+ZjLDAUHwyYAgdyyjD1e1nZHd4R9TDNKsNTjhU3s=;
        b=TQElGbQlZuS8vVZ7pQF4grPHDOyjLiqBSEyCKqEt3oqDWfHEpTDYV2/K/H93WdCF8+
         AdVDUdQ6WUaNB7ItwHaiq+W/5dnfNQnEiQLOfsuVPYjZ5YFtu8sgThyxOtih2Ai881qD
         /I/CIO1WqHoE7IfoOzwJPA37hR//gRAXLxKjqvr3NIAYwyiKwY3LIloR6Ww6fczEypPl
         IHDjgqMnvCJ3beuy71G6Sb083TPMwclGT6w6sXtUI3UyDEB/1fE7pmmaGV26Zfb+cQ7T
         hxVKwHiolC3+SkgKWVIhvZD1dhTfWCPx36aP19hivUaLh9OtpA5xml4qWRgrL/VCpnK1
         oV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761226450; x=1761831250;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snm+ZjLDAUHwyYAgdyyjD1e1nZHd4R9TDNKsNTjhU3s=;
        b=bsUfGJKzUVVIDEFrrV6JUMPMQP5D6yvxhV4F3nmYhQgG6PBCJER1usWfRJvvW/DWbv
         RZojaR443JbkQKxubC3U06p5BEg1xI1UgnYvSqKiKi0u/tJ0alOfrHsgrFTF/kE6jYF2
         yDD3pHQxWrdbsWctrCtbAEaW/8XRNtt6y0Od7TMWnUtK69S63KEG7T8pKWwK8Z5tJDYq
         eJQnRNbuEh2Vu74tL16I+nNtILWt333xLxO2dYg6eWSz9R9l1lG//6SbqcRvM3jMbPoW
         t+tPxNQ7M5c2BSFKQWmvSVLRJ6E7ITsON9J/fcec/eKWDHz3F9D5qXgExZsZH7nOW0RW
         /JKQ==
X-Gm-Message-State: AOJu0YzeL1cPwv+vjLsPZGUch7iSPqV9lkXl7Fr6SYdZshdA1uRS1MIJ
	fNtyvZMLAtKWMHL20cF0nbnoqopiiQ2Rs0QRJzti0Jio6dFgaDZk32Q0SB/gF2/b+VE=
X-Gm-Gg: ASbGncuJXpApN8PhTllgWUqIEFW964gpYRbhKNB47cUT+67P1a38fErAV6xRfKlsyhL
	Rb/Tdm7ciu0BXd5woHzhtLLsHi8w2SYbbKKSs0xBpcHp8ToPBfh3lIlH356qijI/HMthKNfRloU
	OK0bC0hVwA3H9Cr4f/kygUt9+VXZgID989fb0H1HC+lbHYK8qiR9EVi1rxGoL0GEBI3CG2KsxDM
	3A15PmNAYDjcB8GA0NOY08wedG8CFBkQE1RskDlO4urDJf1W4+fNsqfZrGeMhJtD2dqqxGJoZMZ
	+tcWLEai1vz1j820NnFTA71/mQaRyL49kh/zJH2vqkp84toRMvybKmDDVLxT4Vnc+8Bj1MWDqN/
	OcC1ea9uKCz1KUhWtzfN1Llry0sFh6oahmzmR0M4+E0Pyy72Qim9Tr9GuOzeWSpAZCgIaqIOWqf
	rTOOX5SQvqFumf7naQS0GYLn59Ebo=
X-Google-Smtp-Source: AGHT+IGIDXejYCgbX8iEcmglszIf/CJWYVlZznjEs22PM1eux1O0bog+AXkWL2i10CNC8RyE20P6Kg==
X-Received: by 2002:a05:6000:2485:b0:3ea:4a1d:b542 with SMTP id ffacd0b85a97d-42704d8ebc7mr9582378f8f.3.1761226449781;
        Thu, 23 Oct 2025 06:34:09 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429897e75a0sm4037198f8f.5.2025.10.23.06.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:34:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Aaron Kling <webgeek1234@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
In-Reply-To: <20251021-t210-mem-clientid-fixup-v1-1-5094946faa31@gmail.com>
References: <20251021-t210-mem-clientid-fixup-v1-1-5094946faa31@gmail.com>
Subject: Re: [PATCH] memory: tegra210: Fix incorrect client ids
Message-Id: <176122644852.70962.10111018550041208091.b4-ty@linaro.org>
Date: Thu, 23 Oct 2025 15:34:08 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 21 Oct 2025 14:47:06 -0500, Aaron Kling wrote:
> The original commit had typos for two of the memory client ids. Fix them
> to reference the correct bindings.
> 
> 

Applied, thanks!

[1/1] memory: tegra210: Fix incorrect client ids
      https://git.kernel.org/krzk/linux-mem-ctrl/c/6f37469a933030692741710db809722076f71973

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


