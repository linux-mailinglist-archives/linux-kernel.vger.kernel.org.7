Return-Path: <linux-kernel+bounces-888259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9683FC3A558
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8603B324F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D592DF131;
	Thu,  6 Nov 2025 10:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J7fSLwVg"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E392D9EEA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 10:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762425666; cv=none; b=DM7HuDoupnGQU15KMKsUH7yRAPWvFuSB6E8ksmPbY9Xq+6jr6YtgCWLY4x84WOytlX01iljU3wgJhPVCLVz4fJQTxPXto3dR9PpfHlP81rVpf8gsIbyQyn2N5h3iAzFkRWCwYwF18jFrHiSmiE/a1Nj9i6x5SNPyc7aV79Ive9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762425666; c=relaxed/simple;
	bh=6gEsH+luGD0b4Sn5LNm8FkmN4nubeyVKxdIlp8HfmLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M2aQ0+vG6aqeb2foFBXsPy5DTJtNYpJDyMaqdGESiCElZl1oZS0mXvsafcBmUXoOJYlptpPWT6g57d37oYUXP3Pv9QmoogtabDI5gB6XFZUjDzTozNJ9tc7Pll+ZSH+o6yQI87tTb3QSiywBt3Od+0n8lWYF34/hzkoO1YqJgok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J7fSLwVg; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4ed0d6d3144so8142401cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 02:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762425664; x=1763030464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6gEsH+luGD0b4Sn5LNm8FkmN4nubeyVKxdIlp8HfmLs=;
        b=J7fSLwVgcdgqNighfhszmyiy3U8XC0YvVbqf5ZWdr9JC8W9GpGuouG4G8Gv6S5T9M/
         lOlAIRVAV8ottwME7cHUU8dx/Cui9iUxJI/HxH92ZnACfxOLRCdBgA+CJpXUj8b1yOmZ
         WLWlK2RTbJsMf7Vc2oTmxiJoF8Q7DOjztlduWu+PqsxrUunEKRWnTZ3j777fjNtfaE2Z
         aJucj5MprMG+su/b7HPZX1DLB4ewhexVCaFC8pOSfrowwi+lqFN5EaoGk0BHnADyw+d8
         RLLiDW33SJ2tElW/LSzHeDYBDZlKClSqKYNkbldQvFD891XRWHMijGTvYKUb7z1wRkI1
         Df0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762425664; x=1763030464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6gEsH+luGD0b4Sn5LNm8FkmN4nubeyVKxdIlp8HfmLs=;
        b=xKc8AkR96i/eq9Opp26uOQFKqQhpYQOrtct8C6j9yZFfU8coBCvM5pL1gI4wLzrun9
         g+ySW/H0awOCnUQIRUzx4MD3wkTP3XaZAAYNEF98HvIHgg/6dWAZzvOFbmoGutqj7tcv
         ws+76KGW9ILAte4ypXxfV+bDn60SBOmePLgqDJBXpYlmjZIY6CHzV0Pg/R7wZq5qRExo
         GBA4sl0cNT77SaNXYdHLwVXjvDjTIa4dH95Kc7k2KHnxl9OuX1jexUzCzx7lN4vOXmhD
         w3HImSMmrNZVWe8VyAdQPsnR+DlclpRkKQDHS/uB2ssyjrGEzRTaaZ5eZ/8cjc4IfStx
         9FiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw0EhelxKJ3Q7WJPKAiEPAnXzx50teDBWFrwxpkhNySEEe5KZcxx0o8Jj7wjp9QRX7VuUBMHkyagL2fVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YySUQNgvlO0qj95LTtmOxoKulOdQSYBQ1b5/DhjeJN2k6VxVlQ8
	F+ab/oN+r6h6hkWZ7syCbVpOT4gPiY3kcCiQqo5FtlDQ7um2vItvWC+CU0DlgubV+eqNOeKwdSi
	10tx/ZVo2yseqRpjpP6xyzOQ52AsExJ0a1a04A20H
X-Gm-Gg: ASbGncuBzovvO9l1Fl7uK8dOjcVBJkdBszdOtBEDToalydzWrEcY3NSdTsTUeuqPEKa
	qh4FHayXDfSkf8q7nt50v3VGZgDRcBjbcH0fDcuPQlsT31HS0ux97DegLlGWWLdJ3IGdtIqMMtU
	77Z8QXwj8deMIw3Xw9Vx7Fvl+vRoptZUw5pLtvYBRbffwlMw5Q4MJC21oCIq9NtNxwPCm6jJfrf
	HmyjVwwMwWoFpjs5pfybWiLU6CZ/lrfdvx1C7YE/n3qXr8CmeMEdvaHlkUeKu632sQ6JN4=
X-Google-Smtp-Source: AGHT+IGw4QTWrNAeDwKQA3mseTWaldl/aBYFiJzlYb7bl8eG84BmiMGOLAD768QMPwKw9sPjZXv4X2Sk2G4u9UmgwGU=
X-Received: by 2002:ac8:7d82:0:b0:4ec:f09a:4faa with SMTP id
 d75a77b69052e-4ed7234f780mr76123641cf.19.1762425663934; Thu, 06 Nov 2025
 02:41:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104161327.41004-1-simon.schippers@tu-dortmund.de>
 <20251104161327.41004-2-simon.schippers@tu-dortmund.de> <CANn89iL6MjvOc8qEQpeQJPLX0Y3X0HmqNcmgHL4RzfcijPim5w@mail.gmail.com>
 <66d22955-bb20-44cf-8ad3-743ae272fec7@tu-dortmund.de> <CANn89i+oGnt=Gpo1hZh+8uaEoK3mKLQY-gszzHWC+A2enXa7Tw@mail.gmail.com>
 <be77736d-6fde-4f48-b774-f7067a826656@tu-dortmund.de> <CANn89iJVW-_qLbUehhJNJO70PRuw1SZVQX0towgZ4K-JvsPKkw@mail.gmail.com>
 <c01c12a8-c19c-4b9f-94d1-2a106e65a074@tu-dortmund.de> <CANn89iJpXwmvg0MOvLo8+hVAhaMTL_1_62Afk_6dG1ZEL3tORQ@mail.gmail.com>
 <9ebd72d0-5ae9-4844-b0be-5629c52e6df8@tu-dortmund.de> <64a963ed-400e-4bd2-a4e3-6357f3480367@tu-dortmund.de>
In-Reply-To: <64a963ed-400e-4bd2-a4e3-6357f3480367@tu-dortmund.de>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Nov 2025 02:40:52 -0800
X-Gm-Features: AWmQ_blmcXmxEskv0hK08fp1Pm62Xthwvodkvx571QVJ7EF0DaCgwYh2halYhmA
Message-ID: <CANn89iKt+OYAfQoZxkqO+gECRx_oAecCRTVcf1Kumtpc9u+n0w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 1/1] usbnet: Add support for Byte Queue Limits (BQL)
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> I compiled it with CONFIG_PROVE_LOCKING and ran iperf3 TCP tests on my
> USB2 to Gbit Ethernet adapter I had at hand. dmesg shows no lockdep
> warnings. What else should I test?

That should be fine, please send a V2

