Return-Path: <linux-kernel+bounces-727690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E00B01E22
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 15:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70900167F04
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230A22222D6;
	Fri, 11 Jul 2025 13:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="qDDA7Kl9"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60B52882B6
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 13:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241570; cv=none; b=MZY9/u5JGXgm0dUPhOUTxri7WDTwTg1eTZIbz1hLFH+sy0YXV6pJPDzw/qqGYCrEgV6SJmJHcYmT+qzFYV+xeeiHB5BIl4ZCMmnP4Eu/U4gAlJ42Zw2N8cAdLfj1aR9uKmINpO6dxB9HDoWkDlGs6PgpdC3PxfaQa/isecZy7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241570; c=relaxed/simple;
	bh=RS6rqzmv5+SQCY5vDmlk5PNSTu8xO6Zd7fN/Jo0ORGE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEBnqb4y1DbqEBAHscN2zW0gxgPlzNmskKxOPPTCeY3lMUnF+Xi7ec2vvIBOLK4/NT00/WxOhxEearf97BDvZI75WaEfcgo+tDivmbGLy9/xVyhxQJnw3ekana2em6K2oCvt48saLnISaIsrobdqiq6UNosLxetfyeW39EsVqJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=qDDA7Kl9; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-32b7113ed6bso18157981fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 06:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752241567; x=1752846367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RS6rqzmv5+SQCY5vDmlk5PNSTu8xO6Zd7fN/Jo0ORGE=;
        b=qDDA7Kl99MIRkuCwaoiHq5LCmKUhosMbYLojn/mVatUIZQtlui8AiDc0YMrg1wsKr+
         cLYSKjg1zhZ2Qi5E1btN9sA85PL6UWKyG5/0fBsMAk4fXo+CSHPBchJV79yaKLCcPbda
         qkllj5/iHthsWkNXstFRturg/3TS7SJ2BeXKIMOSxQAzE1OhQr1Y2hJV1IIqwIQZZKaj
         Uyxuwa+0wKElZsHDuowCni5/W01CDXQBx2HnlkRuPmpp+YfPdFMRayQJxz31C49JUoqX
         NJKybXn5Wy1PFv9bpxgQJDRQiFojbQIDWadHG1Zivg1knNkxrC01QUqBf+odeqvWViQI
         7nbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752241567; x=1752846367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RS6rqzmv5+SQCY5vDmlk5PNSTu8xO6Zd7fN/Jo0ORGE=;
        b=CviUlgOszdXlQOuOQffGiG+qzTdgzoS3O0rbKfcPsj8HuQtqfXcWjBgacJ4VHlE4yg
         c+Yvy+StyKOhdq6rjYS9v0h8WYzJCNQolRthSj3SF6CNIQ9nlPuOveCM0sEgNAJJfKng
         PuqtTUB3peYciZbR2xF6s2fa6K9O2eQ3poeHPbtsmHuz5LTLSsRQJX4VLZAwidqLkHM3
         2FKWpAqpWBQdRdhwFVuPU+z/NlCmJB4HChEQXwAS0rlPTmMVxdlauj0Vhyw1o4p0SI5z
         w0Ymi8ui9/E7RUnLXiYhi6SbWVvqH9lSbFFCnvEkiK4QxMLKhek89myBw15thzH4G/9V
         8rdw==
X-Forwarded-Encrypted: i=1; AJvYcCUH41rxfcEz3ucaGa/aC1UCrsVAi5WCUlpd/f1yUG1ojuwWAZZYiFlfhDZpKjlr7cfI2jWOV6snA29XWKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/TPR/gFXcT93Ev5oaZUnd4Lf9ckFWtL9i7m1uCXrmN2Qx6xEk
	orUoEB2nLJGPTcFmVZwKeatYZeS8pLj190Z1OQRvilvS8UsldwHLp1sG8FnGUFcP+C0/0au7VDk
	bs352fCZ6D4JadzTnYZPhDb7pMBz9KpJm61ZFBZknRg==
X-Gm-Gg: ASbGncuJKA0a9wk6R+BnLuqDKbXlKFBODEVgl2hAECl5hBqcZGmhhFR/nGBqDthCvRE
	IrOjzV+Rc40bgMNiYvIHS4KcPTpoiF2axJ5K/1L48dnc2qy6cMs6DJgnQ28CmyEtzTpsiDi4qyv
	5IGL5ucCBg9+u468Ba9SPHCPehL+QU+s6gElfH5e9x5cMu5L8zrvYP/WjfJ++0M5O1Z5NUfhuCo
	kdm3W8xK4Nhx3qainQ87U+7ee+DEEWg9pUWKQ==
X-Google-Smtp-Source: AGHT+IHEGaw8tTnlp6CdLR1SRLYnHtpW9Tqiv8Bmjbybq/YFpqHC8SrsIenAMtBVvvwRmkHzXm0r7d0/ZJz6EJ7QiBw=
X-Received: by 2002:a2e:be89:0:b0:32a:864a:46eb with SMTP id
 38308e7fff4ca-33052f808aamr11555081fa.0.1752241566646; Fri, 11 Jul 2025
 06:46:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709144728.43313-1-brgl@bgdev.pl> <141abf1f-2739-4ccf-8a2b-3451c299ef49@oss.qualcomm.com>
 <CAMRc=McYqNm4gVgDir=Er_TdOCFUknapFx8a7q4cdyY63sb-0A@mail.gmail.com> <CABBYNZJQrHEWGBaNy77NqTbNn8jU=iRi0wsnvPqDb6rA9E5-7g@mail.gmail.com>
In-Reply-To: <CABBYNZJQrHEWGBaNy77NqTbNn8jU=iRi0wsnvPqDb6rA9E5-7g@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Jul 2025 15:45:55 +0200
X-Gm-Features: Ac12FXwhzHd3z42_4j5xIwbpjRzvBPpx5E2MsjZkS61xbXOEn8EPEdDvT2JOmZI
Message-ID: <CAMRc=Md0FCfqAxqLN98QbMFeACbq8DU6o9k6j+bnF6jPY=KGdQ@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: add a sub-entry for the Qualcomm
 bluetooth driver
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
	Shuai Zhang <quic_shuaz@quicinc.com>, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-bluetooth@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 3:42=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Bartosz,
>
> On Thu, Jul 10, 2025 at 10:22=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> >
> > On Wed, Jul 9, 2025 at 7:06=E2=80=AFPM Konrad Dybcio
> > <konrad.dybcio@oss.qualcomm.com> wrote:
> > >
> > > On 7/9/25 4:47 PM, Bartosz Golaszewski wrote:
> > > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > > >
> > > > Patches modifying drivers/bluetooth/hci_qca.c should be Cc'ed to th=
e
> > > > linux-arm-msm mailing list so that Qualcomm maintainers and reviewe=
rs
> > > > can get notified about proposed changes to it. Add a sub-entry that=
 adds
> > > > the mailing list to the list of addresses returned by get_maintaine=
r.pl.
>
> Should this go via bluetooth-next or arm-msm has its own dedicated
> tree? If we continue using bluetooth-next let's agree to have someone
> from linux-arm-msm signing-off the patches for these drivers before we
> merge them in bluetooth-next, including this change.
>

I think this should go through bluetooth-next. Let's wait for Konrad
or Bjorn to Ack this then.

Bart

