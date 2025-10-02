Return-Path: <linux-kernel+bounces-840518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE35CBB497F
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 18:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90D8E16663E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 16:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B41264F9F;
	Thu,  2 Oct 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gUhrz9Ub"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02B186284
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759423780; cv=none; b=gMF//oIDvIQaA5ngzFa+6s4eV4C3hsnlolTBM1j0XmJjqFCPNVR5GIzz8bMBwq1HPjq0ETaxTj3VdoKH7+6VPY6IKhZzscos8rqD8vJPW4+e0mKb6gYayewm1RPJi9JOROhgU0T4pwfShHXT8EznNmZrTGg/uGo3zRlXsTm92AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759423780; c=relaxed/simple;
	bh=GPNKqk2IjCezt+iOiIGHZBvYwRYM9eI/at8SyT0aJvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dhv2SKs4HyGzo+oEFUHNXUsR+vUG8XzbC1R+GybU88owL9R3zUNCMNNumjA6SEcwYKmyq//3us+wP+/B87zF2MKuv6UhHyJYJ2BYRhyZtZWoQO17yH/w8SNls7sHg6yMwivz2KUJRNf21V8Q/e126ASAPuzDkujaDSzZA/FoC4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gUhrz9Ub; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b256c8ca246so312354366b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759423776; x=1760028576; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ri4QyfvFryudbRTr4zjJak2/cwqBuXGVPepccBH1HNc=;
        b=gUhrz9UbfOdDJBrCyPUJRPx3zM+SAT9D9jE3dSCVTyDEIYB9tZXsih8O+cyEc5sYgc
         jgpoIoviizQHxyH5NsX1UJ/NSPFTlx6mkMb3ecJKBYL2cWz1egAfZfbGm0KJyQ+JNQLS
         umkEo4+Z8Urgdew7nbyf3I4qhSkqPWeFuYN6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759423776; x=1760028576;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ri4QyfvFryudbRTr4zjJak2/cwqBuXGVPepccBH1HNc=;
        b=p0rgVOxUEYIX9V6P6+45DJK6cxFKw5bEuCGGJ6/xqZlNnQoX+vUSm8KgG0qBliRJX4
         jLirI+wjWcLr1anF8CT6eTNXLFUh7n+ULdlS7o+bNnebjw3H7Ol6rGMktR0BMD6Mm4ph
         TqOrW92CdXr6iwzzxYwG4p+2BBNgY5zMPELr3Yhm1k4jCyt6+JvRYDinLu1Fy9Iz2GA+
         gOhzMW0ZyGrPfRBmyQaf7fQvksorzfi/sf8mEE8WMS+bShz0p4OSl+d5/VIFVpwudGYr
         KGV4AXuj88DMu3ZaEJ/c3RRVIHwZhE3+cZgAFO3nIgVkzIlVuwlrKNdYs5K6YC6vn5Ur
         E56g==
X-Forwarded-Encrypted: i=1; AJvYcCUM54cxwR0XmzFlB+dGw3VVCpW3OdcqDKN27gNhVe001r5NGruoq59fTiV8ynWOUAY6lW861mU0hQmbknE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWm77Za9GfP9zT5ndZTXcUJQQFamONV4aslunOB+Tkow0aXBr+
	kW1gPd/YAfyPB2ZCCRVRRtC8qE7PIDqIpcIjUy2itVczvIcENlMm3eOiTC1Vb5SDVmul/TmLfCS
	/rlCWEkg=
X-Gm-Gg: ASbGncuZS0ESFV9FCabN4u1SLnJw+rz595vZKpOXJFPq3DktiLHBDFHZ46NaSqq2rtj
	aA4yPXKMANe46nnjr/RJYnEJjYqWJgXt8kMJm2FGly5QS6uLCf4If+R3C3hB5CgH7gKueiyBffp
	0+iqesOmDgqc2ZQ+k01PAQbA7jOlNnIDdjZLX9BLJaYbR3nDGt8dk9SusJLbVkS+4jeV2UKpbo4
	eEgKlVTY1SS5yBM2lhTzydAjbTOdCwvYgsd5/jfrvNu53lbddHPIF9hBKMx+AgC9ckQBFUqnu2C
	3Gf8Y5yhzlLTB/e1TPHIJL6CeEMRsyw2X361TCj8kFM35vLsyuSxZyAI6V7AvEDsPIjwszGIX55
	wsKR8nQrsCB55HDVCmbye2GFwpCnvzUI3dmemMqyBodlps21AxcyfxKhwtojWTOOydU+wUAhnYd
	WfsbmKTKGna8qcVAeW37QQ
X-Google-Smtp-Source: AGHT+IHDtuobgJ1DndCTpwl6wzhNvovgM0hRECmQu116kPqpTP7hNszEBfsOa9L6ExRTHaEq6Oq6+g==
X-Received: by 2002:a17:907:6d0d:b0:b43:b7ec:b89a with SMTP id a640c23a62f3a-b49c214bb24mr12886866b.26.1759423776330;
        Thu, 02 Oct 2025 09:49:36 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b486970b37bsm245189966b.53.2025.10.02.09.49.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Oct 2025 09:49:35 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b256c8ca246so312343266b.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 09:49:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbPtVQAFcyALAW2HcrDFTODDU835ZFfD2iLFxTFV1WxkNjS6vzJc1DRDDb+hnGyPgjTnQonIo7Xqe/YF4=@vger.kernel.org
X-Received: by 2002:a17:906:6a25:b0:b3e:c7d5:4cc2 with SMTP id
 a640c23a62f3a-b49c39360f6mr14187866b.38.1759423774528; Thu, 02 Oct 2025
 09:49:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730074614.2537382-1-nilay@linux.ibm.com> <20250730074614.2537382-3-nilay@linux.ibm.com>
 <25a87311-70fd-4248-86e4-dd5fecf6cc99@gmail.com> <bfba2ef9-ecb7-4917-a7db-01b252d7be04@gmail.com>
 <05b105b8-1382-4ef3-aaaa-51b7b1927036@linux.ibm.com> <1b952f48-2808-4da8-ada2-84a62ae1b124@kernel.dk>
In-Reply-To: <1b952f48-2808-4da8-ada2-84a62ae1b124@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Oct 2025 09:49:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjf1HX1WwREHPs7V_1Hg_54sqOVSr9rNObudEpT9VgQDw@mail.gmail.com>
X-Gm-Features: AS18NWAX_XbsCSn1cSvTBt8Jd93mNINtxqs7sE9J-usQvnLgAAKgdff6fAuW3Hk
Message-ID: <CAHk-=wjf1HX1WwREHPs7V_1Hg_54sqOVSr9rNObudEpT9VgQDw@mail.gmail.com>
Subject: Re: [6.16.9 / 6.17.0 PANIC REGRESSION] block: fix lockdep warning
 caused by lock dependency in elv_iosched_store
To: Jens Axboe <axboe@kernel.dk>
Cc: Nilay Shroff <nilay@linux.ibm.com>, Kyle Sanderson <kyle.leet@gmail.com>, 
	linux-block@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, hch@lst.de, 
	ming.lei@redhat.com, hare@suse.de, sth@linux.ibm.com, gjoyce@ibm.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 2 Oct 2025 at 08:58, Jens Axboe <axboe@kernel.dk> wrote:
>
> Sorry missed thit - yes that should be enough, and agree we should get
> it into stable. Still waiting on Linus to actually pull my trees though,
> so we'll have to wait for that to happen first.

Literally next in my queue, so that will happen in minutes..

           Linus

