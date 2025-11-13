Return-Path: <linux-kernel+bounces-899700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CD82C58C83
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 17:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 41BB84EC3AA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 15:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D53E2F39A4;
	Thu, 13 Nov 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHqyo7Gs"
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B352F39A6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 15:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763049016; cv=none; b=ILmyzcsWwZwt8wffdaHI0WPrV7QGf6ozE8qmU25xrwhoDyVUPB4LTteIvl6mVz8moRHv5bN6n/ExBLlaFlizcKuZ58dgSY3zhT+Zr8fTqVEW8wtyzmNxfrWiastG64JQVVILbA+Qrm3DIEdpXFxhpHVlRoaKSvTOFx9ZAGPoiCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763049016; c=relaxed/simple;
	bh=e/g/kq3Nck5IXBvV/fLusQI7HpTR9rDijWMYcL4091c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lj3LG+YbHgx+R89PvCJ7raTSVEBT08MnzcbqkvLcEn8h8yOg0X8oy0ep41ecIBmIopl9NfJAkCHgTXmfvPLh+06i996OapFb9GysvXENEJCLWL2Id0PivVZULZ0KyYFhKZPU63N45DREKk0DWPfQ6IXi/9jpGpUHTM5AVVE9yj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cHqyo7Gs; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-640daf41b19so1290670d50.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 07:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763049014; x=1763653814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/g/kq3Nck5IXBvV/fLusQI7HpTR9rDijWMYcL4091c=;
        b=cHqyo7GsIet4qSG1YJc5H3nAx2hIpvcSkpH5AN0Gqlps/BV8J/gqOphbP/P9OtIJ3c
         i2kPdGcuFGqZSDLzIvPwJWOWsWd4qsrScJfVDA1QhphR6NMQTqDVDngL7UEIFLLxUXUo
         MY68MjoWzT7N/hJLEZ5YU7/fEH4BMXNDNMtE84maxGLBHKqb9uuPDAnbOjoGmpP0scXe
         SCBUzQJew0NTDeqjXU3qxPybGwTHoiLNzXmaq1cEo1hXDI2MTIxF4qfiu07qRrwOvmng
         bbYhlVd6Zo5LpDokhu9y6S8mlISt9QwvEWnfgrb6Pzd65sfC8qEzQOJXtwFB8D4eDAQu
         +hVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763049014; x=1763653814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e/g/kq3Nck5IXBvV/fLusQI7HpTR9rDijWMYcL4091c=;
        b=YazSqPSpwipCzZ6WaqVN7KcYWF1oE59HB2s3atPhKBNjS6h6EYZxhYddBMyuMQXXNH
         nsMeuY0ZNfNtlGVut617vkymGHKDGkkF/JwbnZrKacG3n0Q8bt9wmGuTjulHY1DZznOZ
         bdn92noIDH2COEarY88XflZNOzRbpbRwUeE76nv5q4Gnc0l+53LBMCh8hmeCaXsdc74y
         RpSDWxjpokWtH6jfa2mlczhtooZpbdTudaYO/RBRIZ0v/uuWehTuTfhk1SmCqd/ACPwH
         0a10V9ODZoyea4gpxDi9UpYsc8ATSrR/r+8P7XSi+gZ2T+QFrBArvXnmmTwu+3sKD5GY
         5w+A==
X-Forwarded-Encrypted: i=1; AJvYcCWKebFX86azAnp407qrClU1zrYgQd3i+/pp5sewI11fg+OWJ+gib1o65qcarjqM/Pm2OIxF5tJeQ8ORxn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTqo1BqKxrvDdSiNLQzPw9T2fFT69R6CfLUbNJHBtpj2iew9rf
	Q3LBFyumV3Q73RAIcUUSUnZn+q7UHowp9VBmJSVyiYzjheWiMZbvzzmyYuTHukOFMXly5b5iAbI
	nXIlxHgvxFhkUbkL2gUeC4VbvCNvE0HE=
X-Gm-Gg: ASbGncvC8MEXecl3bdCynNfAe2voxHL7l7cYb0D8azBin85bOi6knKXX2q3K91hmzgz
	19RWllKruTen38znxghPjVP7GUnKlW+0qDYohJ86mY55imWvraq5GaU53HQreV8B38ZQNAM2LSa
	e17ZHZrktbGzpkzGCUT9rMuNWuSmSBTxDcTaDag47BPuCjWymZNRSW41by6EgoZRfmIWw3zr2jV
	/vFJwEuao8P2P7v/uChBsYZPtPRuBBA9yHqfxxtL+p5fYSN36DHdCjOxfU=
X-Google-Smtp-Source: AGHT+IFi/zAEELJO/3R6qd0HvfeGGUdpF5ODZ4t8i7CJBYr5kTmxU/6O9AhNBZ73mSgo0D9Lwg3QIDKxLq24WpPdgWE=
X-Received: by 2002:a05:690e:144b:b0:636:2079:1879 with SMTP id
 956f58d0204a3-6410d093881mr2996819d50.10.1763049013913; Thu, 13 Nov 2025
 07:50:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAN2Y7hwttMyUn0qsEcSBbrQ1h+aSzNpHMhgAxEbqJZn4vf5hBw@mail.gmail.com>
 <aROfRBGmglPgcPVf@slm.duckdns.org> <CAN2Y7hwUmdFMM=mwYq7gsBpbSEBq6n0nXzmES4_=p3fDV=S+Ag@mail.gmail.com>
 <aRSvxyoWiqzcBj-N@slm.duckdns.org>
In-Reply-To: <aRSvxyoWiqzcBj-N@slm.duckdns.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Thu, 13 Nov 2025 23:50:02 +0800
X-Gm-Features: AWmQ_bkGWycCd9UO7WUF3m5FJ-u_FWqqL07EMSClAsd8MtirMTCKJwM2ofzKbj4
Message-ID: <CAJhGHyApLt6AAHUPrYuKUeKiX9de59fou=aPYL5B2QcEmACjAA@mail.gmail.com>
Subject: Re: [PATCH] workqueue: add workqueue.mayday_initial_timeout
To: Tejun Heo <tj@kernel.org>
Cc: ying chen <yc1082463@gmail.com>, corbet@lwn.net, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, laoar.shao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello.

On Thu, Nov 13, 2025 at 12:03=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

>
>
> Ah, I see what you mean. The slurping is to avoid potentially O(N^2)
> scanning but that probably the wrong trade-off to make here. I think the
> right solution is making it break out after finding the first matching wo=
rk
> item and loop outside so that it processes work item one by one.
>

I'm implementing it. A positional dummy work item is added to mark the
position for the next scan after processing the previous one.

I=E2=80=99ll send it soon.

Still, I suggest that the workqueue user eliminate any dependencies among
the work items when using a rescuer. If the memory pressure is not relieved
and no normal workers come to help, it simply won=E2=80=99t work.


thanks
Lai

