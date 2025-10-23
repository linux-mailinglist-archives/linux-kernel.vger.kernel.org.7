Return-Path: <linux-kernel+bounces-867176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9C1C01C05
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 16:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB0E188DF26
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59FED32C33E;
	Thu, 23 Oct 2025 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLAGAg7O"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BD31DFDA1
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761229503; cv=none; b=YBwtxt0o3rfHKsPpy390wzAI6YANPxMY1UeV8U6LYW+5NtMBagv35YvyRdzeCpjgkYvHHukBJqzwJwWFXoLfLBuseokiH9579Var+ujJPeu391q/kKjraAN8no1Ul7y2sp9u+jIcr/gmebLDdVAW+wkYS1rzIEEl1MD5Vp8gEQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761229503; c=relaxed/simple;
	bh=3jJe3/TFyxxkrvAPG05/Jjbc6EONurj1AmkQ2D7bhZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mz5oALgzeiMYS24/AU8Sk/ggxW2P6xQC83UPvz77iDs9xvB5BAWOk1kaUqfg+bGeyZzurvw90Tg7Y52pxhfZ2DlMsrTLBAOJ0bpmaLGS+3RoiuRXaaoV1bDTf9LHG6/RrsJnxFKzKKnksCnVqXWpsxiEQkOpDA6V6QtbucIRd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLAGAg7O; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-33ba5d8f3bfso767733a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 07:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761229501; x=1761834301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pf/H8hwwjXHOcfEd9IHK/0BwkuvQECWP59//+xIoOuY=;
        b=MLAGAg7OfrlgWpOCnrtm6s5NYnpeq134mI5EWY+NAE9vcAvKsjEHCudznubWZtdwxV
         b9+y9oZWeySOVIn7XuYljUK8E5IkjoWBwSGpd2ve3Ww/CGdMvKEaHr3pK3VNqSTYO9h4
         5NPW+fTc5I8ltBfG4Gnxg0x5su/n3izZxUC9krQziUD2/xNs21OajHqlxUJ1bhRvwbMp
         Y6sME1HCRZ7Tp08FjRNFe0HIAcaDN3k3yiE8ezncVi3/knU7qe5OhLW4qx5N5/A2cwqT
         f0lFvQzcWSQ8hMO8BszGtDARGY4GFwE4gZoSVbIqOhlzgqhqZf9LGIvMJBWsA1dTR+KL
         W6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761229501; x=1761834301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf/H8hwwjXHOcfEd9IHK/0BwkuvQECWP59//+xIoOuY=;
        b=thf60rriYmGyn4+JBg0djBRdZRum24wIkjzSDWoT1QkqsUUFD6+NsHIqAcLLjdT+Qq
         ZtDfx2lS1dcBtiI9GHd7K4/BqamJ3xpQR0C9w7RiXmMtEfU3DwqNUt/5aNOV7B039hYl
         ZXK1n+Zy8xUwOWleLIOzZNnbDQCREJ5GtVrsHTxGCDGeSdKcjYD/2efBg4s95zqJtqAI
         w5U5bBqTJlCLcGJ8nQL9qHIKJqHTE6EBA5YbXl8ammS14eSmg065ThoLunqsrf9yySuA
         4OMsP+BngAkWH6hfmktcJzImCxEGNmpQQ1QcKjKxcbUCj4Ck9Ty6dXCIkOuM1IzxRijS
         elSg==
X-Forwarded-Encrypted: i=1; AJvYcCXL17jMgg3PdwvBbwABbfkCyX2d2vHBRYMBUx8f8kXJpsQtJaheBwm9MtQAmSMX9sUAieHuu96cEJvAUEE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5t8RVCrCttaT21sAuVgDlFo96V2RUX/Dx+1j0qoOI3gF/ZG0W
	eNyUXp4eQ/u/6+WEryZcA10T6WTilVIO625kOypE/dheZbwHZ3ltzPUV
X-Gm-Gg: ASbGncs79kS1R48RC/m0atrizVnfgmt5fAZ5b7qHQO3V0ZRFCZ+/HtjCi9GV9cs+G4h
	kVtxR1agoC5TiZq/o1DgZTzd3v+Cfvqby0rg6rwvtf9Q6R543ErRF2scWIZcB04ajbTwhQyM4m8
	XaBFxxgFO7csfLMCe1Dwfkmgm6/eAq0fbG8mFJ/G6gUVD+fsYrryvWtUozobQjb3FXbIXrSQfJX
	YYa8BeJhBlE5sGkFTWHdG3edGmZOZJhuX9eA+tDd9N0hjxaT3g8shA5gvFycAc83HZ0N4YWTRFZ
	/KpG46cOwV0QhAt+R/5q+IirxM+1k5Ot+W+L4ps18hlB3OHj0x1wUfZnEyDD21gW458FAQneLu0
	bLRSI7QoKBEwa1RqWwTxHteSKRA6hyi3RVdzlWbX9YvxKDWDcK+tiNG9pWCGH4OX1ErIPFlTc9T
	qD2buG8Svn7BhKI3zcMQ==
X-Google-Smtp-Source: AGHT+IGe4BeM9/pmyB243lXYseQKK0oQC2Kow3UQh2Om045EVbmJQKLCQhmwXMTvnHHyQoLOWJ+UeA==
X-Received: by 2002:a17:90b:2d8b:b0:32e:d282:3672 with SMTP id 98e67ed59e1d1-33bcf8e4a07mr30935358a91.23.1761229500703;
        Thu, 23 Oct 2025 07:25:00 -0700 (PDT)
Received: from rakuram-MSI.. ([2409:40f4:2040:16ed:f15f:ed0a:f0b7:34d2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fb0191b1dsm2585682a91.18.2025.10.23.07.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 07:25:00 -0700 (PDT)
From: Rakuram Eswaran <rakuram.e96@gmail.com>
To: lorenzo@kernel.org
Cc: angelogioacchino.delregno@collabora.com,
	dan.carpenter@linaro.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-wireless@vger.kernel.org,
	lkp@intel.com,
	matthias.bgg@gmail.com,
	nbd@nbd.name,
	rakuram.e96@gmail.com,
	rex.lu@mediatek.com,
	ryder.lee@mediatek.com,
	sean.wang@mediatek.com,
	shayne.chen@mediatek.com,
	skhan@linuxfoundation.org
Subject: Re: [PATCH] wifi: mt76: mt7996: remove redundant NULL check in mt7996_msdu_page_get_from_cache()
Date: Thu, 23 Oct 2025 19:54:47 +0530
Message-ID: <20251023142449.117936-1-rakuram.e96@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: aPoqiioo6kUZ0kbY@lore-desk
References: <aPoqiioo6kUZ0kbY@lore-desk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Thu, 23 Oct 2025 at 18:45, Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > Smatch reported a warning that the NULL check on `p` in
> > `mt7996_msdu_page_get_from_cache()` is redundant:
> >
> >   drivers/net/wireless/mediatek/mt76/mt7996/mac.c:1651
> >   mt7996_msdu_page_get_from_cache() warn: can 'p' even be NULL?
> >
> > The function first checks `list_empty(&dev->wed_rro.page_cache)` before
> > calling `list_first_entry()`. When the list is not empty,
> > `list_first_entry()` always returns a valid pointer and can never be NULL.
> >
> > Hence, the `if (p)` condition is unnecessary. Removing it cleans up the
> > code.
>
> Hi Rakuram,
>
> this issue has been already fixed here:
> https://patchwork.kernel.org/project/linux-wireless/patch/20251014-mt7996_msdu_page_get_from_cache-remove-null-ptr-check-v1-1-fbeb7881e192@kernel.org/
>
> Regards,
> Lorenzo
>

Hello Lorenzo,

Thank you for the information. I did check both linus-mainline and linux-next
branches before sending the patch. 

From next time, I’ll make sure to also check the subsystem-specific branches as well.

Thanks again for pointing it out.

Best regards,
Rakuram

