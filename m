Return-Path: <linux-kernel+bounces-788442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B3CFB38474
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 16:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B6AF1B65E02
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 14:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CA2735A290;
	Wed, 27 Aug 2025 14:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj5NMgJO"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C252EBDCF;
	Wed, 27 Aug 2025 14:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303764; cv=none; b=UMNV28du+8E5M/b9wvP8S8P97vV5cMeXK0mpdmClfDQoxLRj+Egwifdp6sL34efIYwd6JYx6XDDxu4go2Uw733z+GeVz5S//FJYpK07AldRux/6tcMysiOXuFbwAYg9EK1cz6dg/AlLBTeAIzHDGHQ7LamWVv4kchIdBQrz+Huk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303764; c=relaxed/simple;
	bh=lw/ewX5G9BRbmm4WjkDHiNTtRtMqaUqiqwaQ6Fn7fsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QAJD7Ic5g4QoG2r99PNdgikoRcNWI8nUYToaeoKZT+aBNAnyZwa4doMAsonWDLLC4xKf+ktDG66zkakxuqx3dwyfMtdiwIeNGoPpSBn6AtQKdjSVjcvYLjeeAsUYmQVfm02dJpO9+NEdnE8MT7naHrQergpuJJh5SKVszchCVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lj5NMgJO; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-520c0e267bcso1236702137.1;
        Wed, 27 Aug 2025 07:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756303762; x=1756908562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw/ewX5G9BRbmm4WjkDHiNTtRtMqaUqiqwaQ6Fn7fsc=;
        b=Lj5NMgJOxc0NvXe02uSTqgA4VIqNfrENO57DI13J0rZdduSQsBw7zsPtEee9azvlAc
         CHFFSm85nxK5uw9bd0kZSm1krbe9iUV7dwRkgywixOtrpmxtHSNyizspcEypL9qRUZu0
         HdNsOn6McUB3KW5b8+YabprnBQ/gFziI6mnQQo5IqkL9crs16bslzVqI8E4xI7SdHfv1
         U0A9fVPDlXRy9QVxjxtg+VXxhl0RzTw6K5rDUk4+T86+veBtKIPfgOp+WmWMVrbFXOjy
         JlkkWg9Y9YWwhcYO/SfQtqYiHlk8vFDPQtPyB7NDAZ61CUHInpnYiNfI+5welovswwKf
         vMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756303762; x=1756908562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lw/ewX5G9BRbmm4WjkDHiNTtRtMqaUqiqwaQ6Fn7fsc=;
        b=K8xpUmfwXitjFj4wmT5z1ZcPxnC7TZwJGSYLzvFeh9ofQ/ffBu1JLmw4ysXWO/CbaC
         FCLVXjha4qelmjt93zI47MCEEkc8GkNFZe+BHjMkSBaH0eBN+cLC5uZu8fA0psctbJXy
         CPDVma+IW3WhLrA33ETKxzqlpOStvGjQy2qP7SCV7G8ChGRgDldtxg2rjpK/nvKVJ6Qx
         q31rYgcwldTb6G3ILbQS/1LxQW4FiowZ7OBkLX7EeDbLVcYwCaR7Rvq2HC0ZdyfLuBQY
         HUb7btmm1xwgsOvbUwJxzw6gjY9IXUd97192yt1zZJvCxPnRJp5Vis0BgQVdZ8ul2f5f
         U2vg==
X-Forwarded-Encrypted: i=1; AJvYcCWK0RRd4D2fbFUi9mgwvlHh1EXDOmWJNRqoE7sENRW2HA8RwmxbGFOjYS7izy8yQ0BB9ftN3+hFws37nIY=@vger.kernel.org, AJvYcCXHvuiDAb8LPirGaqgs1P7fTNs6AmePGJbwaQhoTeQX80XlNbO9uotIsboNRq2N+AX+yIqNzIpTeq8m@vger.kernel.org
X-Gm-Message-State: AOJu0YyBaq6/w7EmQA2ftYPM3+NGhE+ZonL6TRc4xBIR/9PZZFVdg3tQ
	GD/qAJMRssmMAgsyN7ABYAqbyBK38Z0H4WqXV7R869UnLdnFlbpMOXYGs+xtvHyrWZBvFl996rV
	+K21vq+sQS+zxuGiDaWk/bf+T+MxdzRc=
X-Gm-Gg: ASbGncsnPVFxt/gIXFFFUC3ea7v2JWieqEW6+1fQlALBJ7advJxJVhfA9CGnjnTU3ht
	kfIAjCkGxjcNTnpm15ns21T6Ls3JTviNzwysR06MB7NwaEgwvAooqJbU7syX2jw69tafTVCGHCe
	lyb571z4imyyJrz7tDxGBtuSVqt58gjK8reH7RmI/Qt4ECmy8RsYIr+ivWscNntGAwZDP99C1YA
	XxsBQtHNgXDDkDh7NjNnQt2cOhT4FPFBg==
X-Google-Smtp-Source: AGHT+IEsHqORETtcRAqgaEWBcvCh4LHCsnL8g9LYpLirejx7dyaIzf7+44UuXaRbms0Hlagzl1uMpfcD3HDhSjx8Q1w=
X-Received: by 2002:a05:6102:809e:b0:51a:4906:f194 with SMTP id
 ada2fe7eead31-51d0f2f9a6cmr6143334137.28.1756303761898; Wed, 27 Aug 2025
 07:09:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826150826.11096-1-ryanzhou54@gmail.com> <CA+zupgwnbt=5Oh28Chco=YNt9WwKzi2J+0hQ04nqyZG_7WUAYg@mail.gmail.com>
In-Reply-To: <CA+zupgwnbt=5Oh28Chco=YNt9WwKzi2J+0hQ04nqyZG_7WUAYg@mail.gmail.com>
From: ryan zhou <ryanzhou54@gmail.com>
Date: Wed, 27 Aug 2025 22:09:10 +0800
X-Gm-Features: Ac12FXwQ-ThUrJUqJwXUGkI_6xk5qW_tdN4AELgG8XuFDbYTWP_0wCw7B03cV0I
Message-ID: <CAPwe5RMpdG1ziRAwDhqkxuzHX0x=SdFQRFUbPCVuir1OgE90YQ@mail.gmail.com>
Subject: Re: [PATCH] drvier: usb: dwc3: Fix runtime PM trying to activate
 child device xxx.dwc3 but parent is not active
To: Roy Luo <royluo@google.com>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Roy,
Thank you for reviewing my patch.
>
> Wouldn't the parent glue dev already resume before resuming the child dwc=
3?
>
No, in the following case, the parent device will not be reviewed
before resuming the child device.
Taking the 'imx8mp-dwc3' driver as an example.
Step 1.usb disconnect trigger: the child device dwc3 enter runtime
suspend state firstly, followed by
the parent device imx8mp-dwc3 enters runtime suspend
flow:dwc3_runtime_suspend->dwc3_imx8mp_runtime_suspend
Step2.system deep trigger:consistent with the runtime suspend flow,
child enters pm suspend and followed
by parent
flow: dwc3_pm_suspend->dwc3_imx8mp_pm_suspend
Step3: After dwc3_pm_suspend, and before dwc3_imx8mp_pm_suspend, a
task terminated the system suspend process
. The system will resume from the checkpoint, and resume devices in
the suspended state in the reverse
of pm suspend, but excluding the parent device imx8mp-dwc3 since it
did not execute the suspend process.

>
>Why would 'runtime PM trying to activate child device xxx.dwc3 but parent =
is not active' happen in the first place?
>
Following the above analysis, dwc3_resume calls
pm_runtime_set_active(dev), it checks the
parent.power->runtime_status is not RPM_ACTIVE and outputs the error log.

>
>What is the glue driver that's being used here? Knowing what's being done =
in the glue driver pm callbacks
>would help in understanding the issue.
>
Refer to the driver 'dwc3-imx8mp.c' please, maybe you could help me
find a better solution.


Thanks,
ryan

Roy Luo <royluo@google.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=8827=E6=97=A5=E5=
=91=A8=E4=B8=89 02:38=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Aug 26, 2025 at 8:12=E2=80=AFAM Ryan Zhou <ryanzhou54@gmail.com> =
wrote:
> >
> > Issue description:
> > The parent device dwc3_glue has runtime PM enabled and is in the
> > runtime suspended state. The system enters the deep sleep process
> > but is interrupted by another task. When resuming dwc3,
> > console outputs the log 'runtime PM trying to activate child device
> > xxx.dwc3 but parent is not active'.
> >
>
> Wouldn't the parent glue dev already resume before resuming the child dwc=
3?
> Why would 'runtime PM trying to activate child device xxx.dwc3 but parent=
 is
> not active' happen in the first place?
> What is the glue driver that's being used here? Knowing what's being done=
 in
> the glue driver pm callbacks would help in understanding the issue.
>
> Regards,
> Roy

