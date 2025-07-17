Return-Path: <linux-kernel+bounces-735773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AC1B093B3
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 20:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD1C3B162B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 18:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBA81F0992;
	Thu, 17 Jul 2025 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M59+Fa9H"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC266191F6A
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752775320; cv=none; b=LywnjdEPyEH5iSHddN1osB6ZFthu/rkxWe3L+Tblbcm/5ht24XzHlv8Onfn7fCKRYdEKM0tlpY+iXJJcXM+uI4V01RgMR07A5PDGw2RGCPcac2q/4O2k6Tt4ppuu0xyBc6gNc5illmcpw5HpyLuMnTHjQ+TQGqnRSHOaXyJqhC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752775320; c=relaxed/simple;
	bh=Ux/XUbZrjrZ5icvEfMb+fRvCSfaTQPzstHhwyeYefq4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dwdVI3z3S2eDEked4fNdNNOkW1A42cVqxb+OzRlpFJ9uMEYBvT6FeIYkFZxFNo9NLe1u9bch2bmuVUhAGllxIQcLh+cOuE0rBk/KrxOpZszIEGwpC6SAZsUstBfOV3NFUyJrlfMCGdaEI4twmA6cvv78da4UYu6cR8XxbhH0m2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M59+Fa9H; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3a6d77b43c9so1021323f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 11:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752775317; x=1753380117; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aBHXt0ewopLcuu1qBHUicsTua/XNcGgsEZR3E71VE8g=;
        b=M59+Fa9HJRmQ/DEtd2piR/E4hIriRVg/Ze64YYML6HvPitdnOOpxdRGSRPtjOPVRuM
         mVvQKJDYCghROsKsJFPyjIOd3y7G0Df3gBf0irwd2UdU2VfyMfKXKVDZk27Q0sfYj8FF
         16D8eVWZrlGG9Wf12jOv3YMlOiZ0BJky/smHP3tMW+c5lPewsE6UGYoQqcGdwCdl/nIH
         Sxb4cudncOQKEkzPLrnjzn/57SwIOnrwDnDXRjimbFjpZ3Vg3W35fSiyVjHJ9fElYRNC
         HBQTJvSvxCqv4l719axBuO0mw+Cgd0s1In28SbY5M0WrlRpczfBSMaJ+qW5dfe1zGcPN
         t8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752775317; x=1753380117;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBHXt0ewopLcuu1qBHUicsTua/XNcGgsEZR3E71VE8g=;
        b=nCUJb7VcQQh7cZRRgJjiDi5YJgqxrArPNUUIukLe4tPouS1hsF0Nkh5/cM5Q1GKSrk
         /LrOqQug12t8ZDWLgbdaKkjg720kc/v6MjKOr554sqy5cNQOnI8eeJCWMTtynM9jxsC0
         NqIVKJIMzvMk9Y00t9HXw/mXSovePfbOXUpfEpFTv5OzU451I2EJMGoRRJD41R9+KDKH
         QVRzJcxXiK5psFAVuTEqpxcjeq34EfypSui7yNDe1qVqyKJssQAK8tO+LmG56v/aKkGp
         ul0ZZrr24xOHCDbt9EHpYSdinU7CVWPT2E9BQ5RrIU/HvOYAIDIjHhMzIINi/VkH6AHD
         BlQw==
X-Forwarded-Encrypted: i=1; AJvYcCUZcXVTmH7UrWes43GkzcEMxxyAZYGEkIxfzAGv4d1wZ8PWFAI04fHPr+pvhC7wsCkuRhz53tqn0LftIPg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1DjlUs+MM6Xo/cYuTo7pDuhD9prj/PK508xsLmoeusXp340Eo
	fE4tcwEeIK+yPTyi8IgWm9OiRDE/FCzpmuzqTUrHD+D585EYf1Kh0oOC/IrO6eLnMabTUB6iMj2
	GzcP+edW+QM/qnzyKX8/pIIqlid2tST6j/IMpNGBl
X-Gm-Gg: ASbGncveTBm3Hkj1G4zPNV78d6MKebDtNt1VgY1e71Gh3g+ZqMlHzhr/MGz2FlUyrtL
	8icw+AMImhT4qyrw1fedZtJnfzHw0NXYFGwKeEiKwkA/zWFHLXq0mv0xz+3pryZhOH7SmUU5Kab
	HT3QpUSjANpAzycWVECxrzZuS5twyPhokxuQPCo4+ilxwOESroDaFn0Mu3tOLuTfOJfXyQzkOI8
	K+JbgeTu5Aa+lHNPB2lgR1VbpAzEvK1+5Tw
X-Google-Smtp-Source: AGHT+IFvdTmOg7+pD8vUlVLGeBk+gkiShFoTqBolUzcUuAZVYGcA2GEEZQjKbBBwFkJrV05rGR/ulq+Fp7cVEtgOWOs=
X-Received: by 2002:a05:6000:144b:b0:3a5:2599:4178 with SMTP id
 ffacd0b85a97d-3b60e4c8f5fmr5842168f8f.19.1752775316854; Thu, 17 Jul 2025
 11:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Gwendal Grignou <gwendal@google.com>
Date: Thu, 17 Jul 2025 11:01:45 -0700
X-Gm-Features: Ac12FXyerUkpgZcEecxDOI40_wwidC4JV1skvAnOQOx7azFT3BQlFHJ5VXbZRqA
Message-ID: <CAMHSBOWue5bwysERvoZQjSG8h32me06wwcSQGteTN=aX=5OXYg@mail.gmail.com>
Subject: Re: [PATCH] misc: rtsx: usb: Ensure mmc child device is active when
 card is present
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>, gfl3162@gmail.com, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kai.heng.feng@canonical.com, 
	Linux Kernel <linux-kernel@vger.kernel.org>, mingo@kernel.org, ricky_wu@realtek.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> ---
>  drivers/misc/cardreader/rtsx_usb.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
> index 148107a4547c..d007a4455ce5 100644
> --- a/drivers/misc/cardreader/rtsx_usb.c
> +++ b/drivers/misc/cardreader/rtsx_usb.c
> @@ -698,6 +698,12 @@ static void rtsx_usb_disconnect(struct usb_interface *intf)
>  }
>
>  #ifdef CONFIG_PM
> +static int rtsx_usb_resume_child(struct device *dev, void *data)
> +{
> +       pm_request_resume(dev);
> +       return 0;
> +}
> +
>  static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
>  {
>         struct rtsx_ucr *ucr =
> @@ -713,8 +719,10 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
>                         mutex_unlock(&ucr->dev_mutex);
>
>                         /* Defer the autosuspend if card exists */
> -                       if (val & (SD_CD | MS_CD))
> +                       if (val & (SD_CD | MS_CD)) {
> +                               device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
Why not calling rtsx_usb_resume() here?
>                                 return -EAGAIN;
> +                       }
>                 } else {
>                         /* There is an ongoing operation*/
>                         return -EAGAIN;
> @@ -724,12 +732,6 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
>         return 0;
>  }
>
> -static int rtsx_usb_resume_child(struct device *dev, void *data)
> -{
> -       pm_request_resume(dev);
> -       return 0;
> -}
> -
>  static int rtsx_usb_resume(struct usb_interface *intf)
>  {
>         device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
> --
> 2.25.1
>

