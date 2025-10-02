Return-Path: <linux-kernel+bounces-840698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F41BB5022
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 21:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D1D917EDFE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 19:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98430285CAF;
	Thu,  2 Oct 2025 19:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIW0rJ4d"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CCDA93D
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759433454; cv=none; b=lrljx/3Y3vXmxFmndaXTZ3On68ztajyOG/SKrzsL0udmLY7noiyQzIkAMc3uUmbBP4vXrpSt+0SnLEgOQy+xwYaC79HAr6GVkDecbU3waW9hsyl6sDxpj/0FnQVVCZIjEyq26hi7/Uh9Y32jy0rkANYiGB4IYjzDeaq4l5ZlMgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759433454; c=relaxed/simple;
	bh=RavlUV38xKbCURMIaXHAVGr9bhvD+BobklBpey5pr9E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpLNsqqivKgSNj4SbmkjxS8Za/eJ2w+zpGSWNbaQJSFKoKcTbDdJcIW2pvVUELyAiP6xWPn+3LenhL5JekuL4Wagn5niEKZns+c3lSJXnIyJywOcNeMiLJEiRfbzdrg6h4UZVyPWnM70vSK+AMj90m2Nmh6P9GMo2RZB4b3edzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIW0rJ4d; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e3ea0445fso7757585e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 12:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759433451; x=1760038251; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RavlUV38xKbCURMIaXHAVGr9bhvD+BobklBpey5pr9E=;
        b=PIW0rJ4dnNSaUBViyoFYRhUEwf7G8KdbnKjXHMjIfJZJO+7IYBIV3Knuvf1SWK2xJA
         ZpNrO66udeQXmoHf/vNZKSTjzihsWhONq1yZSsMEx8r2y4if500ZLB6U0Ax3fWmHg7Pk
         Pi9jc2G1w51MiKyty2yjaLjt/w822i+ZqzzHWGZguSi3wpOdEKJapZRZOfXkPO+W4y5O
         wk1sA5JM7SxoJaWc64mgNWANw9eKgTWTeWoT+nHVKs1iGGQ4Jp0cCuDEEN5Z8QgBNX67
         LALgfZ6dnOyqcjnlRgAfXsE8yNUFV19thFux22+vX3XqszlshbGRrxN9xcwq/RpMssw9
         A3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759433451; x=1760038251;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RavlUV38xKbCURMIaXHAVGr9bhvD+BobklBpey5pr9E=;
        b=HVHCOIg7zeZd0R+lLk+5gB1x/SjBQ1zz6bxduBP0VZHCuXqs4PdhwcPSkM+HzK1aNS
         1BD5F+lQtZvoasbtN35OczT5009Ox3ExrwRl/NsICVTTtqAdzJ+ZSdREmSpRMjVw9rT9
         v+YnD2OUMWpeeImadxE7yYounmOmCF3NsOg0jw9PvHLxYLBcrMHiDw1eD37G32TLSErZ
         6SeJIscl7xmbV7+nIjRdv90lw1qTwhOFQg/dgnDxbCnfrmsgV17FQpqBlqhkHGxP25Da
         ojwM7cRDNvCemfweVTTw+jA7PT7IZeZNeYFiVlEFWE3CRO2IhRnpAiwtR5aYSM1YB2vd
         82XA==
X-Forwarded-Encrypted: i=1; AJvYcCVkz9auR+0ignlVoyJp8UasPQ/OVy8Purjz30sXWWsNC32/PfmQMkW+AcpLgRcAmIQX3gF2d1t1wqDA6M4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDWJrl625vQq0q/WxzsrOWUMqWI8c42rRsvgAAmZcHLAyKJRBB
	svOh9ubcEnOETEkgx4NJ4jtGhT97r7CyzWAbfiqn4znzA7QMxGA2JBmqKfHE/5yQ3OkcjqPrHf4
	8EGP12+VvGM6F8B72d42STCSLQMZx8QKKMdNgqPtn
X-Gm-Gg: ASbGnct4HFICS8BwFYe0IL4fpYZGLubuujYjkoDR4aTvCC51ynF19ApqA2X/Oelkqkj
	/V8jrHTtACDi0KnRMKelnMuhLDoqYaz1klGuHhDtttU8BRrFwz+GhJxHkaWdaCT2kpqkAXTDrvq
	Gc/RVarkRgIYO+a55tXqXgrCEoXWQLAAVZr4rvDfdTBngsST6ZGTL8sy4JzMUFWmQd5JM66A/YI
	+XWl2fcnbfudTfhmZtBGFYvD3RTczjSQsrc/oJDAdSwMo3z+NdeayanB+KufYdYZZsgbT+XrCZ3
	j1c=
X-Google-Smtp-Source: AGHT+IFCU6uBe4gWMYCNHz3kAgXiO/K7bY0HyJGwPrChQwZ9JM6yW0mxGVSnRHqeL/KB4jYDo6HP8b5r3lGA+u45RuI=
X-Received: by 2002:a05:6000:4024:b0:3ee:1368:a8e9 with SMTP id
 ffacd0b85a97d-42567135148mr286275f8f.17.1759433450604; Thu, 02 Oct 2025
 12:30:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250926-topic-tbt_header_bit_fix-v1-1-122238af5c82@oss.qualcomm.com>
 <aN5fpicXs-JwKvQo@tzungbi-laptop>
In-Reply-To: <aN5fpicXs-JwKvQo@tzungbi-laptop>
From: Jameson Thies <jthies@google.com>
Date: Thu, 2 Oct 2025 12:30:39 -0700
X-Gm-Features: AS18NWCP5sKgHNdu12Azk2AdvFWe9eB4GL8mTduwvhesRx7j7Vpkw8n9TtAOPbs
Message-ID: <CAMFSARdM6CmUwfntnbG3THsOFC33KyZnR1RVLXmYwFJum+5K=A@mail.gmail.com>
Subject: Re: [PATCH RFC] usb: typec: thunderbolt: Fix Thunderbolt adapter type
 bitfield values
To: Tzung-Bi Shih <tzungbi@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Benson Leung <bleung@chromium.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Andrei Kuchynski <akuchynski@chromium.org>, 
	Guenter Roeck <groeck@chromium.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev, 
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

Hi Konrad,
thanks for raising this. Yes, it looks like this works around the
current faulty definitions in typec_tbt.h. Where
pd_ctrl->control_flags is assigned in our EC firmware, the
USB_PD_CTRL_TBT_LEGACY_ADAPTER correctly gets set to 1 for TBT2 legacy
adapters. So the data.device_mode assignment you are updating here is
currently correct even though the macro is incorrect. Your patch LGTM.

