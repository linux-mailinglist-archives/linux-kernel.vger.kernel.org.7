Return-Path: <linux-kernel+bounces-830565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD43CB99FD7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 15:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48521B2521E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 13:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7109F2E0B73;
	Wed, 24 Sep 2025 13:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ScK3mCTe"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B4C502BE
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 13:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719679; cv=none; b=iqzgRr1ETOZm4BHufNeOJ0xQGI0hRGZqCJ717xKufuM5cZ1X7ivylsMB5p8Y+3Rn21THjwiZ1LZd1ZdXT4vT1dchzZykbjtSfiWlaTYoJAETSV2jj3zVDUmBLmWVlWJ3/bS1Y70CB3mC6deRwF2Lc+Kk0IqFSdcddBSDvAhVR4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719679; c=relaxed/simple;
	bh=VZv/R+Lydiru7NXai3Ae10i1fqpu1CG63+EFMARw2z4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hg50q70R00QrMd2RMnrybA2LkWk9J9kG62r+vd8ukrn50GRI/++SFp5uZ1xUu5jfS2WoT+2IpIoH8ZzaXmAR7CGXLKPPu3Sdeoo/kTYho1iXabNCkuxBKlQAPg0A7Fl7zZN2WjdUx2UA76jhJQMkcf6SKToj9tfhXz5Tt9QSVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ScK3mCTe; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8276e579242so586164585a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758719677; x=1759324477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VZv/R+Lydiru7NXai3Ae10i1fqpu1CG63+EFMARw2z4=;
        b=ScK3mCTe+VprXhahFbYzMHqB5KcDauoxynO3vtOkpovgORSM+X34DQXz/P5GGmieY3
         mursmtaEitgq1nUwju5w74m9TWo1S4leSiCkuNDy4pYODwj34dWTneHBsA0Ym5DvGXdI
         iFRGp84pfYohzcAscR46WHHVTjxQcbE4Dl/wMwpm5auNPMdhWhKv1jbHITNl2OUXfHyO
         qKZG5xn3Cn7UAKKgGebK6iBWgyjqu1KTF5gKOm2MQopnDJwxFXdsoiTE9XJ8YqBYxTfs
         9Qtf8kUWItUq6wCxy8Yonu1Wv4G44zOW4dotbM7fclPWKftTDAuBsv2TFphm8Io0yVUF
         a+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758719677; x=1759324477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VZv/R+Lydiru7NXai3Ae10i1fqpu1CG63+EFMARw2z4=;
        b=P0l0F+2OHR6XPLYRqlHYyVCKwDVm61yJ7C9VQ2tX/h04wt9H15VGlQSj+1O/i/zf1/
         359mD9Mra7Kb+c2xmRPSUxyhlly7ScGzhS89rYhgAPZNinzgJaHQ0ISpjuCK0p6bPamO
         1sdNbWeoDSqNUVb2nlBHgUrV85741bpAS5OZ8hYDD0YK2AVYfpXJb6L6o/e3xDygPONL
         IS8OOMqY2jhQgL5uX6K5y1V3Zk3/lxWAx3GYOrYXzm4Aw5yUYQcoCRpdzBQG86N3gf8d
         l7wzbm49TKpYC3Ql+iUYpbzjROqSfoRycFOPLp1yXUY9ghwbVjq5uCJ1OAiI5yKtifH2
         DOKw==
X-Forwarded-Encrypted: i=1; AJvYcCWUssYPAQQCQs12BoXiPiysONPiIIBHg9RcTDytdqHNX5S2jZmGYlKIxx7Y/9h3i2ziqt40YMlfQvM2LcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNjbaj1ps4q8KSjumFXe74vda3gwVnMNbFapqL+GNkq5IH0JQP
	/JG07Z9aVDQC8xcNt76eckUqdCYdEnMTEzODfYIyMciGO/yYRMWSy36mt1Awe8f4TOLmCdWMLQz
	yP5yL/QwGVNmUhk6Fjpox9NNYscxZihM=
X-Gm-Gg: ASbGnct2+m61GjzrUdXtnO09svCWds/4ZMKsQMZEYDmRPz8X+zAnQ+PbjFCXwcKJQtM
	5Msfpu6so3G5MMG+GEd+PRuwVWB9772eRM9NH6jmtHIv3qDo7Jb2AzRRPaf5N43sB4alZHzSioV
	Kwxng5hg/zcLWNbYgvNzsiA6xOPXbLphpQRrRE/SuTlTMGjqcxVLN57xI9GjXLUuB8zbnQsQhaI
	VQHx/A+BKAQEtZ0GH3MX2Tr+YS7ZXsW8JGcbLGPpIxGxTs9C5Kh
X-Google-Smtp-Source: AGHT+IFW5ydJGJomVZSTmzV+enpMyryQsOja9EMJNFRBeWC/1HSTHy/94zFyhyeJUzCqfTu1dgMklmb7QbHYZ8VrMBg=
X-Received: by 2002:a05:620a:d95:b0:82c:b307:bce9 with SMTP id
 af79cd13be357-851760476eamr770911085a.66.1758719677227; Wed, 24 Sep 2025
 06:14:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEU-x4=Zs22b5LX_rsBVMu4BxvDfO+CZkkuWuVNaxv8mqvh9Gw@mail.gmail.com>
 <bjtev7sgmcafoysd53xrxih4nawn2dbq4odylwdglbub6td2a3@nhoxenprhjvy>
 <CAEU-x4kL45DAddmNahjR2C97+43jchpmXep++LbeP8cXLEWN-w@mail.gmail.com>
 <CAEU-x4nv3XnXchevtwN5mkVcxqnpgBobhavxZc7BjS7EgYG8Ng@mail.gmail.com>
 <c3plpgl2zsx4do2odwdeowodkkdnfqpexlwqg5a5mckyibxlge@qai35f5yeswy>
 <CAEU-x4mJiBM_zKg1DaeJkKB3W3Ay08bUTc-D3QjFjDxNiZGd0g@mail.gmail.com>
 <iav7hzeaarxifwxk7zlfnt6vipqkp4h4ldt634exlvcswz62gj@a7ongaeduylz>
 <CAEU-x4k_56w17y0DOKG2TRtegGvzVKS9USAERMa1MtO+3wZivA@mail.gmail.com> <jm3z5dcgw66lzh5bbhnitnchbvgnvuvrzxltghrsmwtmbg76jw@rcvcyjevjrmq>
In-Reply-To: <jm3z5dcgw66lzh5bbhnitnchbvgnvuvrzxltghrsmwtmbg76jw@rcvcyjevjrmq>
From: Yinon Burgansky <yinonburgansky@gmail.com>
Date: Wed, 24 Sep 2025 16:14:25 +0300
X-Gm-Features: AS18NWCPMv2tgalE6efXx36Z9UYxW7tQoHsVEql15JYZ8XgpNe4cJCRv-ZgfGTY
Message-ID: <CAEU-x4=NvWYPUas5e-V-uLOHiHu9Wc3CHGLwTbKPTM1r3+U1Ng@mail.gmail.com>
Subject: Re: Touchpad multitouch leaves ghost fingers
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: jikos@kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 11:44=E2=80=AFAM Benjamin Tissoires <bentiss@kernel=
.org> wrote:
> oops, yes, my bad. I forgot to put the correct group on the device
> (multitouch_win_8 instead of generic). I've force pushed a new version,
> so please redownload and reinstall it.
Yes, now it works, thank you :)

> Now I need to make the kernel patch. Ideally I'd like you to test it,
> but worse case I can just replay the recording as it seems to be enough.
Sure, I can try, if you give me instructions to follow.
This is my current kernel:
```
$ uname -a
Linux fedora 6.16.7-200.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Sep 11
17:46:54 UTC 2025 x86_64 GNU/Linux
```
After installing, do I wait until Fedora catches up to the new version
and then reinstall the kernel from dnf?
Do I need to watch out when doing `dnf update` that it won't override
the kernel?

Thanks,
Yinon

