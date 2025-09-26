Return-Path: <linux-kernel+bounces-834560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD56BA4F15
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 21:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C6916A8B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 19:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EABC1FDA8E;
	Fri, 26 Sep 2025 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvkUy7jw"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208017260A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 19:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758913510; cv=none; b=T1HbDBL43Ku6fPOp+xzZfJlsmn26eNklNvid/4ulT9dQb7qkX3z9bk1wrNk2blRPq7ArJalVbwF1kduu3JPYC0QhFsiKpQl1SKVpV57KJKqEsGyPseazo0QL/jKMXcVokU0CEihnbmSPtVydiOp/1SMeBJDgjgEFxYjTSXDvpWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758913510; c=relaxed/simple;
	bh=EhdMpJ1U+FHIoR7XZ/yj6clo2zTQ1p3YFH2wb3Eeqwc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYmAmSu6FHAVYqg43p6kPhEYiYM7McJYz6yg0xDTve/iyYTqRSMEjy6d43P1mNtjSVOqm/K7hXYj18hxUBSStXWAjYORoIrsk5GyyWAH7vALn0+7jWRtkvwtn/bF8bKCtvLmheMwzsVEV2kE+AGn7uG4kD90p0L0XfCeIRtNwFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvkUy7jw; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-743ba48eb71so43471027b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 12:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758913508; x=1759518308; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TbJGmaLk3OZjl0R3kvAisn3ETboX9rQ1mi9qiGLk548=;
        b=EvkUy7jwEW5tK4FzbAXRdSvu5qm8M4nR/2vX/TKSEpo0UtfLu4OTewafGLRqCTfl+0
         EP3aEK4riTv7fITBbdpJ2ptCYjXVqnnFWKTYs94Gr9xd8G7rTRG5RhfB9qFNufuv4D26
         rP2niXgWw/DhraDIS1EcjyI81aA7uA1uIVQfYCO4E3cXYGI6ZPCCiHJgAMKE0mMUl5DV
         ar2eDSrdi25riL/rcL1n6B2TXd8cEG8RRnilBOMnPGBMyYI7ok8p42u/iLzfdPDJKIyh
         teF0KRfbL0zT4EUgCMCOAQH2uCVpYHMzKLGQfUqimVvvFnIdomEN5B6ry/SNrpKMkvhq
         deIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758913508; x=1759518308;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbJGmaLk3OZjl0R3kvAisn3ETboX9rQ1mi9qiGLk548=;
        b=qz45wVMrBm/+n2mCU953Z2L93nExqntM6oP3qlke06yJ444e4BQsvC3nVVyjo8XIXx
         nFgfymoRLDGbX45j6jnTPD/g8LrkfXDarpYFKrzlJmq3Km+Tc+3yeyuMFsew+2tRRJAW
         XQ77EuB+I8uezW1+e37d2pZeSh0YmPD4YPFpQxGQNePJLML1eMNbVXsYmWRG71rxpcf5
         tijXyNrk7b9Y2CaXcP104bcVI4A98BFM8nbwj4eN+CPffr+4Yv6sa3ElUr5fbfTkh+QZ
         7oGm0TiXYxj2yJMinXuxlelXdiVn8Befxblj5d8m2mZ+b/JVwJHgy64HZp9qoUsdrbZd
         5n7g==
X-Forwarded-Encrypted: i=1; AJvYcCVdo2xn2kpqLxmvlyqcx4zfqH39MB9spYYrPbrDtJHmj7eiAO+pX1K0xJp5A5Reb5d8Rf/iT7y6E8lBMZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzAvgzrRS1iDAUid22f9hLT8XTPTt4SSAkt6ixn4918F8bOcDv
	HAsF60/r+00Iql5ZfzA87Ox0SPCY2t6DgnAhDlTS6PoW9VwqtmNQD14mEjJZBY1JsNLuDCDvYkf
	ZF0mbRDxQGxlQcru65EJ9NWE3Wa4+d5k=
X-Gm-Gg: ASbGnctvK/xrf/K8LednmOYtcsPujuxv9hVr/FQwdFVENOWOgzZJC61bvDcMgIDFDZw
	HOQs7DyzDDcfOa8sqS3WDdj1xAGf4Q5a8QF+RF0YHF78FfECp3bWgk/+01Ufcfn/lLzFHEnIm7X
	Z09BJGsbMYIzmxKCoWsqOKvFPl2AkviLMJvUlN6ilp/Mi1gNGwYjg/PysAZD9xBOk5+PqDW3TWD
	oVFREseRIn8qjq45ll8edCT+CPmdg==
X-Google-Smtp-Source: AGHT+IEdkuUOLU/bW97u/TwPmWzVbg8Kn81lbFFHV1rxBnyGRe3t1U/lXJSGfVpY6D261qaGlOsT/kGC7v701jIuE+w=
X-Received: by 2002:a53:a80d:0:b0:628:9b73:4b16 with SMTP id
 956f58d0204a3-636dddb4630mr629935d50.12.1758913508118; Fri, 26 Sep 2025
 12:05:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aNUa-9HcQzyjZkvE@shikoro> <20250926154520.40583-1-chiru.cezar.89@gmail.com>
 <20250926154520.40583-2-chiru.cezar.89@gmail.com> <aNbWejNZLYGuNvCI@ninjato>
In-Reply-To: <aNbWejNZLYGuNvCI@ninjato>
From: Cezar Chiru <chiru.cezar.89@gmail.com>
Date: Fri, 26 Sep 2025 22:05:19 +0300
X-Gm-Features: AS18NWB7zbZy6bRGc81-m4r9ucklfKIphtIWuq3OYuTt2vqQbhgiLEr2b2OjL3I
Message-ID: <CANvS2vXT5HMKmyHMnJ6sAc9s5b5PJcFGcW_qrcNLtJtLOvsmNQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] i2c: pcf8584: Remove debug macros from i2c-algo-pcf.c
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: andi.shyti@kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm a newbie to kernel hacking. this is my first set of changes i'm
working on that I wish to go into
the kernel.

> > -     DEBPROTO(printk(KERN_DEBUG "S "));
> > +     printk(KERN_DEBUG "S ");
>
> Now you print the former debug printouts unconditionally? Why is that?
>

I thought I should get rid of DEB2 DEB3 and DEBPROTO macros. That was my
original understanding.
Should everything with printk be deleted also?

/Cezar Chiru

