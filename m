Return-Path: <linux-kernel+bounces-837349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E65BAC1AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 10:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C3671926C31
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 08:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2E8B2F4A06;
	Tue, 30 Sep 2025 08:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RgxLDkOG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992272F3C2D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759221932; cv=none; b=a2NHMuAxeWkRKAXXpXW6/AIjpUz+mrnbRX7GXUuMnx89wGI2q32ow97cmjvjobty2QGiGs3nf4U7t22gcLiDO8ZiIcM3DjX5iXXY/PSNFOwgx3Sc3PenxgbLNYBmUeTbTPV8CrLDL6X4uhSCEzjHeEvP34zLL68FRqeEsmHkwGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759221932; c=relaxed/simple;
	bh=akTONfhlc6noSXEuTwrjzlpLffmAM+CkZ+vcVOLFT7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S3utbAZtdnyeu+SxaFCwDyNmBMMUY6xs9T9p7s8f363QsY7RE8MqQ36Y+B98W25qvSt5KldKDTvTe38MckE7L0sWuE6eTAxq1a1XG/QPjSuKsxs44bCf8ZKc+Jl+13/6zI43n7H1pOr0cjit8N/lgnlC/lsULiFtvDrXwMN3DM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RgxLDkOG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759221929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0eGafpXn10hIE2BMjDxL8LFlIDcwprmVgIo5sjkkOc=;
	b=RgxLDkOGzvv3CWnvjMluJuP9yWgUoHiWjoIalke864VdN9x35Qdc6CaF9CdYWotiNnW/ZZ
	hcx0zFXqXuJKWdliIN6o54AMgBDRdso2wObBaYaRxuruuAFk8yLQn0ghW2ZaEDGqMikI1f
	MDI4t57z0NmXkXxlVKzUYj6ILHN81Rs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-yh5RPdzXPWGyu8Ur_BsoTA-1; Tue, 30 Sep 2025 04:45:28 -0400
X-MC-Unique: yh5RPdzXPWGyu8Ur_BsoTA-1
X-Mimecast-MFC-AGG-ID: yh5RPdzXPWGyu8Ur_BsoTA_1759221927
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3f44000639fso4186565f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 01:45:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759221927; x=1759826727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I0eGafpXn10hIE2BMjDxL8LFlIDcwprmVgIo5sjkkOc=;
        b=pxrQJQZNVGfKK3bYtXXCmmWysa7hKxrNz/F3YL1T9HcmNNlEP2GxjX/v0wlddfdmYe
         VmAZrt2MQST/sbsZrXL7XgzUTUXciH66Gzv5Oth0xRaUNeKTmcYTR+KaKl4CvzsBnfFH
         SC/P7yknHT53wU3qlVccHKlcOMNvqSicXkh/uGC/f25po1G6in2TktTnN1UklMPPkeb8
         w32tnaZxXch3NZsk/Mne3RJohaNrBG4DRO9DBx1IGRRA4nnk0Rm6an8rJ703uzyjwJmM
         sNQIC+Ka6KR/AMdMha4IUfs5V0evZtcHUb2e9p5J2yI5rMtJX7AcCboJvEnixDSaleRJ
         LRmA==
X-Forwarded-Encrypted: i=1; AJvYcCWjnv1xSsEGuxs2D9d9T7YbrDEmRzC6Jzy7C/WJl0iNN8ZSu9rqeJADYPsaJF9yxuj/r7JSdlZ9NjopZ7E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBXlCEPpHIxEBw0Ms8I/AVJydkmTjS2lMsv3O4B6sO9yrrjk+V
	xFtI0g25P7yV/k4wg5LJ+vNbJxNckKl/Jlq2WMbGeK7kAy1xGfPwWDEJy86Gl3MXKYg7SPoSE4w
	F0ae2HFbScYT5ARnil/AKVoOPXBBq1Nqd+zb/X61WDSXIBfPDgeL8oLloltN4UQNXGw==
X-Gm-Gg: ASbGnct19ZFKW/xU/FrAlEEXS6q9/A63N3dybQnTA3do35oGvYVsoWbwufTPLUt++8j
	QbGsL9QEsZR0ZqT9iA67q3XaVClrauEy6II3h2jN0TfuxEf7Gtj8uNbocRYPf0n29SHb/+LUP5u
	CDqyfQhfjpBuxDeligk8sdY4PWzunVcQ7O2h5kwNtnn7gYqajmulFyvVsnN4TF+3mRlWG86u0Py
	n52JDfuCSiGUz7BSp1+utHRgLTFK47WeFUS8Zc9tpxlsItUE6YcupPF0Au+GkLMAiBOd8ruQEH0
	BH4pv+U/KtB9RqxU3Hby4oewjuygORwYN4IFk5FNHnO7fx5E+6WBgi+gFw58egeoI8C9R8a6epK
	jTJ8ZPYt2azRSmyje3A==
X-Received: by 2002:a05:6000:288a:b0:3ea:c893:95c6 with SMTP id ffacd0b85a97d-40e43b08daemr16176945f8f.18.1759221926866;
        Tue, 30 Sep 2025 01:45:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGRKeCg7YnGTHgNrPoON/pDG0wzo+V+MgKB/0TsB17QowrUPCybnWt3H7zBthCuTUQFXwPeXQ==
X-Received: by 2002:a05:6000:288a:b0:3ea:c893:95c6 with SMTP id ffacd0b85a97d-40e43b08daemr16176925f8f.18.1759221926486;
        Tue, 30 Sep 2025 01:45:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc7e2bf35sm21915958f8f.53.2025.09.30.01.45.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 01:45:25 -0700 (PDT)
Message-ID: <54234daf-ace1-4369-baea-eab94fcea74b@redhat.com>
Date: Tue, 30 Sep 2025 10:45:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] atm: Fix the cleanup on alloc_mpc failure in
 atm_mpoa_mpoad_attach
To: Deepak Sharma <deepak.sharma.472935@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, pwn9uin@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
 skhan@linuxfoundation.org,
 syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com,
 syzbot+07b635b9c111c566af8b@syzkaller.appspotmail.com
References: <20250925204251.232473-1-deepak.sharma.472935@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250925204251.232473-1-deepak.sharma.472935@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/25 10:42 PM, Deepak Sharma wrote:
> diff --git a/net/atm/mpc.c b/net/atm/mpc.c
> index f6b447bba329..4f67ad1d6bef 100644
> --- a/net/atm/mpc.c
> +++ b/net/atm/mpc.c
> @@ -804,7 +804,7 @@ static int atm_mpoa_mpoad_attach(struct atm_vcc *vcc, int arg)
>  		/* This lets us now how our LECs are doing */
>  		err = register_netdevice_notifier(&mpoa_notifier);
>  		if (err < 0) {
> -			timer_delete(&mpc_timer);
> +			timer_delete_sync(&mpc_timer);

AFAICS the mpc_timer can rearm itself, so this the above is not enough
and you should use timer_shutdown_sync() instead.

Thanks,

Paolo


