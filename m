Return-Path: <linux-kernel+bounces-867249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E48C020A6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 17:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8353B3C3E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 15:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D578332ED3B;
	Thu, 23 Oct 2025 15:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jiAvMPQJ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9394B2F6188
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761231911; cv=none; b=uzJTdb5hid+5V5b5M9oNPlJUWwRayLnY0I1+KftR608IFzJTPhssYwzJSAmhTGZSWjiXPoymSFMrkc+xoFmpRjKogFfYD9fvAjKs1bX6cFvnf3rhBGU9zOi4zzEcBa6EBY5ZTv10n8wwRbWpXhmrwPDaH66DjLG/SA710ZGvRtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761231911; c=relaxed/simple;
	bh=GHxA3c0yV6CEoBK6kR7057V7T1cFgVLHP2eCafXealQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JHXIDwutPi2TdXUBPRYIDEx6WXk2bUR87qZDF9yQbm0JPZI4tVc1AmoBTKtscJskW+rbWIdacMa75gEjwjLhuzx1YEWx5BvOwH9p2HwaZ06nfuKOMl37MkyUbX6dIHuGK8GPICH6/fg/kERr26/lUPI4fWITtH8tqhxOHWkf2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jiAvMPQJ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-63c21467e5bso1675401a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 08:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761231908; x=1761836708; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0g9O1UAQmliCyOFgls7R54UMarfOxqkSzanB1NMWGZc=;
        b=jiAvMPQJuR7LDPLTyiHpc2m4iCktUFwOmKaf1gcPTzWBXLzeT1hWBoBvhnogi3PpuO
         vr3sEEL0ky2AxUJjwXz+auFWXWEYaO1OEPtPPpLYakO1F1PIoQF7+jTcV3HDN5xrDpA8
         rlxGUeI2XdGi12tkGy5CA8Tz03zWq40HgUvpBLR8+iicShvlfEeXg/+DLUIHHF7AALod
         gpx7s3Cs0Gcpui0+gsj3ouObBfsZdsLypTxjbMJ9habdB4/mgiusY+b2x6YIekT1lKAj
         C1kJTgcW6g7qY2ty75nRKBuWDdOFSS21Wr0dO7DjKaddr5w+JYd/hsItOYO+Ed2Tp2h/
         uGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761231908; x=1761836708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0g9O1UAQmliCyOFgls7R54UMarfOxqkSzanB1NMWGZc=;
        b=WUO/E9DD/ycJhC8WRapt9HX6lJTu/txQh6hnCd0ZQlv4nOfB1yPPt3RBHvtDJvGERN
         NpW1TQi74CAxkYC8IZnB6aavnpyQ6TJZVqBL/Es6mLe+Qe2XnvkLfVYkmyAX/BUWOEOr
         29lnt+NaavGdHEcfnGAkZXzHr6maxSAi6D2GJseLiq/903kcZIaYpXv2i4wY3fDgC8IM
         cy49ZlWzhjJBG2qXy7LwobpkP8Ex5CJ7XiFWP383V8QLz7kQluLLZE62FaZahhoZskvy
         YnwWFkYu9tG1IJ0CYcuUAjmFrzt7YmCyMhsjMAHSkWHwqzW7PjWp3eN/kc9a44d7hB1J
         Blrw==
X-Forwarded-Encrypted: i=1; AJvYcCXgu7br5AHnbwowBMONBPzby5HkZHffD/FutmaSeovKqOqHlpx/a4ETQ4gfZsXzHLjsivzsk+28dOewEBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMPGxCE0e6GFfewXzz6ZNAyviJt8lQ1BysJl0/GOaoOiAZ9WmR
	IJIUqHBf4clxMyjsZpJ4qRTT9A+TXQxtzJfBL/4nAz8i/jb4HsPOlDUGm/0ALBi+Ah2m45wQhWb
	05ibVanUIBraiR2aTvjqYjG8eEh2ncpQ=
X-Gm-Gg: ASbGncs/y5MWHyZ2HSqMNl88j4GNccOjHtMj8hrNyJt/QfPqarp+4lOrGCnCWLtfE1t
	kQjaUvznvxyooujAakUZ4OatjQs4SbNs+zGAuH2TdEUzv5HlwTMs+41xaPaBirBBJw2PgLhqqBO
	bFvXvKlIZ68HUDKou86RoOm2b9jTNsh37hJaETOn/AnqmasE0lDw9OrRsnNRh9kD9N7VglRC8eU
	f4Urb0/0frMJvWMcAnJHUZsiyYHp/5re7FAwfXEIfErDi4/L3NHP8YoLoY3Ku4tnGyKn8YofkL0
	Ak+ApgJtWCGnOV4n8EXDYHP2BabEwQ==
X-Google-Smtp-Source: AGHT+IHB8B5L3u8WbMDNbmjmms33DeNsuKSJCMufZx22juNs/gndSdpSi8DIUT2dxhoELBY0BdEhQ4H+/Q41jUC1tb8=
X-Received: by 2002:a05:6402:1810:b0:634:4d7a:4d94 with SMTP id
 4fb4d7f45d1cf-63c1f6d9335mr18957800a12.34.1761231907807; Thu, 23 Oct 2025
 08:05:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929115405.25695-2-sidharthseela@gmail.com>
 <486e0d6b-799e-4fec-9e6d-3ddfdd64418c@arm.com> <cb30af9e-c22b-485a-a83c-f395880cd799@linuxfoundation.org>
In-Reply-To: <cb30af9e-c22b-485a-a83c-f395880cd799@linuxfoundation.org>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Thu, 23 Oct 2025 20:34:55 +0530
X-Gm-Features: AS18NWA765vw_3LiOpRHjjahBitbX6N7WFYKyQWJzAW1GbNsAm0JUy1d7Tv4rWQ
Message-ID: <CAJE-K+D6ODXnMtS+pbQ-GpyTy8PLyycqK19P_EgnZzKbKwoOog@mail.gmail.com>
Subject: Re: [PATCH v1] selftests: cachestat: Fix warning on declaration under label
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Dev Jain <dev.jain@arm.com>, nphamcs@gmail.com, hannes@cmpxchg.org, 
	nathan@kernel.org, shuah@kernel.org, morbo@google.com, justinstitt@google.com, 
	nick.desaulniers+lkml@gmail.com, linux-mm@kvack.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, david.hunter.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"

> Make sure to not use "---" in your commit logs. Everything after
> this line gets thrown away. I had to go fix it manually.
Sorry, I will make sure that doesn't happen again.

-- 
Thanks,
Sidharth Seela

