Return-Path: <linux-kernel+bounces-752582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84426B1776F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606245A7283
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E6626656D;
	Thu, 31 Jul 2025 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhL8/MxF"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFAF266B6C
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995123; cv=none; b=opK2G6krYZHUDtiM2vZB1R+U5QTmwfRJj+Z5fe50O2tmT5f8P4yLtDDhka9tEdJnvXmQPgAmLG+sletICZHGwHcUkzh3qpuBW0gQmN8qdA/pmdOpXPj7+9AlKnwo8a164cp2GniZNk9p/W3sd6uGWXIXVad7+WqDfzV8vbd0mV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995123; c=relaxed/simple;
	bh=G1+dDN5VbHS/uTTFU90pGQKqcs/KquRWkv7p+axvbkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TVwmDy3KO1B3FdE7eY4h3aXFZiPfJbLlYIkRJTECajw/z/BJxtU3/sz22rXgWyneGZZMxkN6DwlicStIvThnBbsWeMubwX3AvLbghBa9xTiuKuEmsedXw8FZNqFuX3Y/p9KKiVJn0v9hHOY1HGjK6K2zubKJ1Y8eUh3VYZ4v63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KhL8/MxF; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b782cca9a0so131708f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 13:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753995120; x=1754599920; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RRHNd2ZCWezMU8sh7ndHGqZnx2BwmZPaqx0vp8vaTJ0=;
        b=KhL8/MxFeLcQMPr1++g+Oj/W20tkXG4Wi6QYeqpZf8pIYkCtw8anLz7H/ydcv5oP0O
         9UQaeXYBuoApjraxOagrg6WtqVCFA4VVk4zd3PuVXDgbLXB7B+Bo2P1wKgozhuXiV11E
         EWwD+OutrpZew/p21xLDwFfli4dCoAC+8MG4/wV1ovjqWBt9vHfwKFLar6nyjlDQU8ZS
         oygMXTU2I6WLejdM8AxZqQMy7ZXY+qDEf5znA5kLLarpYo/jExs6LJCxbgJpfvCE4mJu
         bMcOnmWLVYV0/z2x8ybjaHEvTnR5Z6YLzhYwIr/oLOAie4K7XAn6/ZlLErdLA6ev6ZDc
         dxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753995120; x=1754599920;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRHNd2ZCWezMU8sh7ndHGqZnx2BwmZPaqx0vp8vaTJ0=;
        b=BjWDA7O+6SukCUiTprz2m4XbXctQ+uo/I8AgHa2xRvKWN4rRlU/qBc09f5nW/wZ22R
         Qt/m+I80omer8jnsUMjYsuHLYeGtMFMf+734tX+yakkyqe5RydGR0baNKeSrzZZQUU28
         b0IfmLyLzHVbnYAQwzSz400T1tityMZR1boVKckJwaXzluuMkGFJFjECFUEj5aFSrc/K
         mS6T3k3EsDw094Xk953MZIiFnZAkhmcUpJOblwc9JY/DD8+UxcORw0FrDSlH/tpZYQCS
         xA+kPqwjuDJRlE5Aiq8TB8agv63lkrQ4jkTAUbWvAHsIeVIYGKD3x64U4cgcFBwRafuy
         XxIg==
X-Forwarded-Encrypted: i=1; AJvYcCUpSJ6Gt7d2GM95C6aqCy9ifSepDpWBP7JZZQl7NG94HCJ5VzVTrJUWvxk9T36FyFdrdd8Zudp7FpYnQT8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZaep6lrqJxnDVM8B5+q76k2mXCsUcWbmJqIYfGMBKgH1m79tq
	3h4SJwj98gMZEfjvIpYuF/+Kd+gY7mxh0tRuSXkUbict78jPkTHBVchQ0PZzMuL53k8M6LHDuF9
	S4cv5pe2oLoDA42GQ5osmuz3vacNReqDjaB7DQy6cCg==
X-Gm-Gg: ASbGnctnJw+tC6tnlOlhcKi8LBya6kzP1SSW8Z+culTaN9xhg3RihfOsjTqX1obiYhk
	Q/S4XIK1kVh629e3TLBNzXPgVKX3MpIJgIPd7EwR8hOnI4nSqbvU4rjt3Oz7UKji5mRLl9RXU/M
	T5MXowwSkcoWmIDTqAjkPy4Y+vZuFEl3mpQn9KRhumFvYt4GhWw8xEotpM+iQgRSduI5CI9G5MR
	OrmV3ArGDFT+LPaAT54
X-Google-Smtp-Source: AGHT+IEwyDoX4uF/9YMToh0+WSQVrRidsSvYeXgHSGPP5jTwBijhyndShZR9merunu1Sixh2RwmDPnVM6baMrGA3w50=
X-Received: by 2002:a05:6000:2085:b0:3b7:9b4d:710e with SMTP id
 ffacd0b85a97d-3b79b4d72c9mr3914484f8f.38.1753995119691; Thu, 31 Jul 2025
 13:51:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402-wip-obbardc-qcom-t14s-oled-panel-v5-0-ff33f4d0020f@linaro.org>
 <aCw9pYehCdfXXeiR@hovoldconsulting.com> <aG-QyF12rGY55gcG@hovoldconsulting.com>
 <d431435b-4ac0-44aa-922d-0bde126ca563@linaro.org> <DBIMQO2CS0I3.17XLZPKPCVW2S@linaro.com>
 <e9c63414-8434-4e35-a159-66df1864f9f3@linaro.org>
In-Reply-To: <e9c63414-8434-4e35-a159-66df1864f9f3@linaro.org>
From: Christopher Obbard <christopher.obbard@linaro.org>
Date: Thu, 31 Jul 2025 21:51:49 +0100
X-Gm-Features: Ac12FXzd0YutQBM4VsTZ7ybOvRaAxugnGXJ2Kg3XZRdEMOsxc-OgmLq-KhYmTLw
Message-ID: <CACr-zFC+WcSYDZ8SEYO211sBVN_=oEXmSw_X6i6zdk6Y+prHFw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Add support for OLED panel used on Snapdragon
 Lenovo T14s Gen6
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rui Miguel Silva <rmfrfs@gmail.com>, Johan Hovold <johan@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Rui Miguel Silva <rui.silva@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Neil, Johan,


On Wed, 23 Jul 2025 at 07:51, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 22/07/2025 15:48, Rui Miguel Silva wrote:
> > Hey Neil,
> >
> > On Tue Jul 22, 2025 at 2:01 PM WEST, Neil Armstrong wrote:
> >
> >> On 10/07/2025 12:07, Johan Hovold wrote:
> >>> Hi Chris (and Neil),
> >>>
> >>> On Tue, May 20, 2025 at 10:30:29AM +0200, Johan Hovold wrote:
> >>>
> >>>> On Wed, Apr 02, 2025 at 03:36:31PM +0100, Christopher Obbard wrote:
> >>>>> The Snapdragon Lenovo T14s Gen6 can be bought with a number of different
> >>>>> panels. This patch series adds support for the OLED model which has a
> >>>>> Samsung ATNA40YK20 panel.
> >>>>>
> >>>>> With this patch series the backlight of the OLED eDP panel does not
> >>>>> illuminate since the brightness is incorrectly read from the eDP panel
> >>>>> as (to be clear this is not a regression). This is fixed in [0].
> >>>>>
> >>>>> [0]: https://lore.kernel.org/all/20250330-wip-obbardc-qcom-t14s-oled-panel-brightness-v6-1-84ad1cd1078a@linaro.org/
> >>>>
> >>>> It would be good to get OLED support for the T14s merged. Are you
> >>>> planning on sending another revision of this series?
> >>>
> >>> No reply for over a month. Do you intend to respin these or should
> >>> someone else take over?
> >>>
> >>> Neil, do you have the OLED version now?
> >>
> >> I'm not sure, how do I determine that ? Is there something specific in the type number ?
> >
> > Yes, yours is the OLED version, the exact models stated above.
>
> Ack thx, I'll test and re-spin this patchset then.

Sorry for the delay. I've just sent a v5 of this patch. I will look at
the eDP brightness patch next...


> Neil
>
> >
> > Cheers,
> >       Rui
> >
> >>
> >> Neil
> >>
> >>>
> >>>>> Christopher Obbard (3):
> >>>>>         arm64: dts: qcom: x1e80100: add epd hpd pinctrl
> >>>>>         arm64: dts: qcom: x1e78100-t14s: add hpd gpio to dp controller
> >>>>
> >>>>>         arm64: dts: qcom: x1e78100-t14s-oled: add edp panel
> >>>>
> >>>> Strictly speaking you could have posted this last patch on it's own as
> >>>> it doesn't depend on adding the hpd pinctrl.
> >>>
> >>> Johan
> >
> >
> >
>

