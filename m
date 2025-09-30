Return-Path: <linux-kernel+bounces-837886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5B0BADFA2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 17:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 156E54A1B64
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5FC308F2E;
	Tue, 30 Sep 2025 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGEXGqg5"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C722505AA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 15:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759247500; cv=none; b=AXv7pEQBaj+gx/hh/K5W+Puve+ti1i/B9TMjp5R6FhOu9OHXjHjV1cDSf+VKi2qzpKOEt5Ho+iGFeyyEWsNkjJIuxe3lr/ygTMg2Z5qFF+CaIR56pWqqFFlRlbXOr5bkeuWD9VeR0xDu/RIzG1cVe1sdLW7OxY9s6f5fy2rNx6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759247500; c=relaxed/simple;
	bh=YNgK/31s5s0p0awoShixTkpKVHtAwCcACffZs/i4vJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNWGjmcitVEVjmnMyXSsfF97W3uPpYwnaa82kce4peQ5iYpLSA8IKYr9uAGe1EsgMRVnmgXB8Mted5T4g5R0BzlZYG3OOwlzAWgeANvU/kI54vyDxltCBR7Yf5/qo5HfKq0MIMPV0zE/BpzQZ+eLo8eajUuVEawAn1bvGmFVMLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGEXGqg5; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b5526b7c54eso3771995a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759247499; x=1759852299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YNgK/31s5s0p0awoShixTkpKVHtAwCcACffZs/i4vJc=;
        b=gGEXGqg5Ky66FWY3R4nxDdzmE+rGIeAQ6PEYN5EUZOWBDKTqpURUtxSn66pLSuHfHN
         179UkLimWetDHsEFK2zIq4E4zjOVOWGXWlONuCD/aevkI/8a9XAfMSSsJjRxufuLdwFv
         Jw6IkCpyYFyxpaZ5VArgkgD43ox+nTtQ1or8N8of4ojAM3JnA8nMjRSBAsQc/yRRoVFz
         vbunbO4/pPm7hAcmcAc2C+2TlofG8WVv+Fm2EN55okG+mvIUxGlwcQWNpLMoVqVZmHmi
         Skr/0oTlu7kK+TdXkofiMpZgLHWW2tPy6wpPZ7+ob9ErMz8Z2PmWnBBDJrrHg/OSmXyO
         76HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759247499; x=1759852299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YNgK/31s5s0p0awoShixTkpKVHtAwCcACffZs/i4vJc=;
        b=hBySmNTaLia/lBUK4CD5cli8SQZX3vclbZfFt/PEeThYQYfPjKr7s2e8Faa2IkOLO6
         1b6qnDkavRPLuDL0rPSr4t1qKPf/+6iWLYFj2zstQxYZKVUwT+uMTBiILArBKhFUS2i2
         4SZT/7kryYPRfTKMJNv71oCaYw5eJB5xjR6vv4lKP0J/Lv9HW3f5u0RHlFv85jCbNl5E
         lAvqv3f4fAohKeh0qD1rhbJ/qNpg7blJCeVAiFeyoJsidk/+RqTZCvKreiHLVzfPtaI0
         sIWYZmmeutFU6JXaR1MpdUGeUgdlwcFsPEyGG/xCdde8BwCuzFWSH2ik4p7q5SorvUiA
         VobQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk+nDiCS2YLDlHrE0c7YHhNSLdwScHEjEBdcAEEAykosTsgmGOgTnVvhIbkinIQr2YzZcebik42sRcLh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoJZ79Eu3hxJ74G/myU+ZXLsE6wjDgAJ/qXoU+mF/M774A9qRn
	Q0UuwHHRwnd3sAr5mrYL8GKEJkjzUHCyXtG2mH/DYSrAzZhUfNjONUljBGK2LScmys21O38nKFi
	rp2uTOACPcs2pUgMBWVbFuw1HKrHnbdw=
X-Gm-Gg: ASbGnctbLskAywYWx/zDID6HDBI91yvI89F0XPqDBpymzBDG8yIDL9YfmGplmfZsqPq
	vXiU9ZIwBqzIgz8mqO4Ll8atbD/LOKED88IZ5ut/gcx1/3qT+US+7f9Xuq+8981vkKkE50JEzRM
	Udc7twIXyQZ1/dKRLGYxq315p0CiFODA1hDxxirExc9q1UrmkiOKJjaj3GrDwP3d/xf+OvhmdPb
	VYvXPSEft4zkqjnH/PQmfFlYgrs
X-Google-Smtp-Source: AGHT+IEd0NJC1p3y7aLeiPJx1+PX7i0RFgbdfPr2KJK1dVlUcF/qgUZVmRbRgJtGMCSJCbx+OdCROi7etv0A4qnVF+g=
X-Received: by 2002:a17:903:3c65:b0:269:aba0:f0a7 with SMTP id
 d9443c01a7336-28e7f2772aamr3321005ad.2.1759247498577; Tue, 30 Sep 2025
 08:51:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918201109.24620-2-julian.lagattuta@gmail.com>
 <000808f3-10cf-46ad-94f9-95a142c08b59@suse.com> <CADuX1qJZ1V32d0U4hSOUOzte2KE-k-Hzop0zZd4=7Ap-kS3JzQ@mail.gmail.com>
 <3fc3f7e8-3297-4586-91ca-41f07c8a9418@suse.com>
In-Reply-To: <3fc3f7e8-3297-4586-91ca-41f07c8a9418@suse.com>
From: Julian LaGattuta <julian.lagattuta@gmail.com>
Date: Tue, 30 Sep 2025 11:51:26 -0400
X-Gm-Features: AS18NWAQdWpu8g2kC6qAaXYg8qwcCOJO281YwGwhZqyRvLU9GMiLhjffpDOQz88
Message-ID: <CADuX1q+_U6b=Bsjm1AxbabUsao+BEk3wr9ZeZHx+N0Wnkr5TbQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] module: enable force unloading of modules that have
 crashed during init
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you so much for your well written reply. I understand now where
I went wrong.
Have a good rest of your day.

Sincerely,
Julian

