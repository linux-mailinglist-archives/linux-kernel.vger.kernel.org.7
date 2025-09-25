Return-Path: <linux-kernel+bounces-831583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F95B9D118
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 03:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903C3326507
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7E82DF12E;
	Thu, 25 Sep 2025 01:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i3iADYCR"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2E2DEA9D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 01:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758765470; cv=none; b=soZYtZXZR9Rv8d+R8OeYGWsH49KR/lqJAyfe/LC0OzHDwlBeEqYdwY9dqK+2xLq7jG3BfSbdcGgegOej2EKHCgKYgKjQ+wRh2LNNCh7ubDy/xK8jt2OCWJ39Rmn1/lqJLnzYruVLu7Ee2d7lB3QmBohEPs5knUQm/3Wap0wKGTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758765470; c=relaxed/simple;
	bh=BzE2nWlHaSb09IJHmQN5hhf4/KfURbjwUnfIYkRiAM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DHSxlj6JLZVE2VbvH4h3DlZI4t9DPuZsrMMhBXB+SfLDjB9z1CjUuiNjqwwY+42Fs3vxohy2GWHpnYuRXvsJD6Mf9l+QlozuL3MPFIBRlMzOfdWaAR0Jxq8eI/nAXr6A8vzzw+2Fj68ocIxzgQLgLP/Xm+2wRTQRLoUlU3endsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i3iADYCR; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62fc14af3fbso840542a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758765467; x=1759370267; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BzE2nWlHaSb09IJHmQN5hhf4/KfURbjwUnfIYkRiAM8=;
        b=i3iADYCRoiSH0HlgpBlG6Uvh1LClCZa1ZyZW1UtYjJWenhLmjNv141j/EGTi9ThmIr
         ymIlMQuZ4tRP1/yJUWhjxhLHO4kJZJQC6yPe8kkO6WkuUmnXxu850IikYq38NqkyfWrU
         KJmHNHAEjB3Y4BEMsSqwDcVTgEx1uSmTs8P5DqU3XR5L5h1m7Mr3f2hxfY2wLNdMJkih
         m+nUgwA/0/bh32BNXB9OohK2fJ4EBNzOws8wQebGqmSHUs75mikvC7Uj14ZLCeRp1CN6
         H36YPpY+dAjd7gggJ2ozy90kCsL7kKfML3UFel7MwWZej1Km+ASP33ZlLEEY5hCAIVR8
         rDGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758765467; x=1759370267;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzE2nWlHaSb09IJHmQN5hhf4/KfURbjwUnfIYkRiAM8=;
        b=Nn7qkaSiYT7kMg7kDdxs/UplPmgJiyQuB7A5/j2W45LlZ0LOmW3VlJlK+7nRcFmNM5
         /ojYs5vMY97rIKlodb/lJpe0IARykuSr12VqO1wSXpQ/bcX2GHyL81jC3OUjm1e6Mvje
         D1vYOU2Cri6sQPMfr2QPxcuEWCOIZRbj6bHQRGZVLAREINjENi1Tqful/EzESPk2N4yE
         XzW/PNZqS4iISmcNc0oWYcwBLx+EuAA8Xwi73XsQJKFduuQau58SXCu3g5TwMatdvls/
         d8cucshPIIzJeZdLZFZAOU7s/3Nuykztarwyp3waP2XnPvAb629aNRGChgoJvYeBxFPu
         PuSw==
X-Forwarded-Encrypted: i=1; AJvYcCV+leDRbaWXalj1CJUyvLV2eSZ7fW0Wa54/mveT/7OwUe3loViypdB8/kHpV/X3qpAWM9/DFNfkU4SUltE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDoOZct5gjgNA+FRcQ+1oF89o//NIOyRkpfoQrDraMKjMKhjL2
	IrUo4ZB0HNaKho3zOUpLSOBnKubEMj9FucE7ltZPv6CpoBYwqtfkL2GIyvJF5Z4lqnEckC+YcO/
	pT9OqLAZFCniyl7EjELgYmcW+OM57P4M=
X-Gm-Gg: ASbGncv9bBQjCaY8uZ+SB83DgxeDVftBtoY3L3QxJFf+WqadsWpdkJJ9fa+me6CFbun
	W8FEiyHc4NQoQ1KP/u5aS1imfuLYHHfiOMViGfn7DgHmS/AQJBvkwXgYod2ezqDIpKaqLAUiMYo
	To70JXBJluU/h+bexrWZG/MwWZzfswL5Xa0Ge+2nIvT431InXWcc+yKX+bPJzYZ6CDmw06Fr/Yx
	RNVK2q8nVxCjZkrylCKG1qek2KITYJzOGmrmVsGI8YaJ7gImyi0/B/P
X-Google-Smtp-Source: AGHT+IF+/+JTZumqPSyotdgOAvpzeHBPXP4w8U2968XjiTAnXz6ZQtIbPEAD2FTktGdPpJGqn+Q97s4zzwKHhgbTGFk=
X-Received: by 2002:a05:6402:13cd:b0:626:4774:2420 with SMTP id
 4fb4d7f45d1cf-6349fa71749mr1317160a12.20.1758765467408; Wed, 24 Sep 2025
 18:57:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924134350.264597-1-viswanathiyyappan@gmail.com> <20250924161835.63e9a44f@kernel.org>
In-Reply-To: <20250924161835.63e9a44f@kernel.org>
From: viswanath <viswanathiyyappan@gmail.com>
Date: Thu, 25 Sep 2025 07:27:35 +0530
X-Gm-Features: AS18NWDW6_dN93pbRL3G38WQSpiXZWIIBNijqFMY5K6yqGxEhObamRG-8b5i7SE
Message-ID: <CAPrAcgOQmBHkehYTpeLds9yobofXhxJmxAa2Nq80b1T3HFZZ0w@mail.gmail.com>
Subject: Re: [PATCH net v3] net: usb: Remove disruptive netif_wake_queue in rtl8150_set_multicast
To: Jakub Kicinski <kuba@kernel.org>
Cc: michal.pecio@gmail.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, petkan@nucleusys.com, pabeni@redhat.com, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com, 
	syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Sept 2025 at 04:48, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Wed, 24 Sep 2025 19:13:50 +0530 I Viswanath wrote:
> > Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
>
> Sorry, one more nit - please spell out your first name, not just
> the initial (in Author/From and SoB).
> --
> pw-bot: cr

I know it's uncommon but "I Viswanath" is actually my legal name

Thanks
Viswanath

