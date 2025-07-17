Return-Path: <linux-kernel+bounces-735889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6133EB094E7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:22:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC6E3BA152
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C20B2FEE3A;
	Thu, 17 Jul 2025 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="sbAp6+nn"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514A2FBFEB
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 19:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752780029; cv=none; b=UJY85n7kOF/q2TYM5pkIrnvim5XqB4HN7gMMTLbN4RciKlVxd/pfeTBwgxOvsTnSPq+VwOUz68gdB9NXsYuHRJnmuUq9MPxGAIyIqCCTtQxLBrLHHlwitQdmWsexZ7RBSU3IPWeENa3rDBB4zCH/lfiT5AAmt3Gr7DW9QrDU3mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752780029; c=relaxed/simple;
	bh=TMKaD2jDZftv2KL4usKq/1tWi4qHNmQsjmx7ZcR3kqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXRSKSUej9QdkUOiv+yH8lZoHSWrvGDJNgz2Q1Ygr7ZZEj2VD69Sn65rfbR5DSu8SdGwJSG7J50PQhR8MRj1XjVfLcdON/CeB35wvdtSJPcYee26DpDCEdGRXSsUJylrljqfXUdmdJt+7c0nRAEJ4EaSuttQgIr4b6CUr3tLuXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=sbAp6+nn; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5561d41fc96so1574534e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752780025; x=1753384825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWmeJ/AYffWPF+7aeLi3O1CN5eBnowfZ5iJlSoV66Ok=;
        b=sbAp6+nnq/u3USPVZGW4iwlInFi/C6FH7dCTKS+TGYR8Ktl6ip1qvyFh4cVWF1MBh5
         +UxnpU3bByWpfu7Z5HI2uXaCjUAciqAA8RpG2jobpVAkikxFlaIceW7yyDfeolkUCIGg
         e3TVDWFFTvLMUdECYuJOA1lY3FW8XLnXyXVm7FmntEAvRuaAqHQ4AiGOLDpblwWQQmlX
         TkQ7lBqvHbQM0xmZDnjO2yzJxFWxeUG44IlfiIFeJTJTkRjsWBC8ys8sNSP7SnGw9GDP
         r0w27hsLxzvhT/E7iMBSuAuuHnijRhroUpyVotwy4V6jZs0WrBGn1T9xYRb4k/mrSozB
         ONZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752780025; x=1753384825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWmeJ/AYffWPF+7aeLi3O1CN5eBnowfZ5iJlSoV66Ok=;
        b=ZCDYaOIh9SX6tkAN41C82HCBdU9uvJ9/p/E8fSkVE0smc1y/3sW1NVVhpq7HxGwuUP
         0E7L54eETbi2FA22+0LozQ/ynJklY+9/zoUOaseIW3C/Zxx5NmnX/0O0uvFKht1ssmi8
         JsB+b5FsJOUmBSAgfAGD4tQ7gNjba2MbVmrfdArjg5u+sOBRbQ1b+DvestzCjD3WGBZa
         zK4hCbN/0EoKYg6rfTdz3jUbFQR17mV4e4OPjLQZ/ASfG4d8haQsWAuEhfsjzvfOqtSw
         Fjh891jeA2EHwe8Udf08yUhMPPclW/oRRNWCKGWglaDkiDMa1xADuntznNAFOkFGJqHl
         1NZw==
X-Forwarded-Encrypted: i=1; AJvYcCUnqV8aMmYcdwYxi0HTQ5fFQZOt3hwCmlj9J9dWFMaH0IFPaS6pG5QZhxtDtnQ9acQAJ5vRGWwGtnBMDnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw2Yfeh+H5jPyrVxwfu2er2xhMOJi1oeCZGYz1HKB7mq4Npv69
	VxT/cROmB5XndbwA81SSEysbutQHLl6sea+Miwe+gTfHSso1g84Z5xTKHzlsn+bL+g/oaYPJAos
	mYh5JATbs/I1U/xGv0K02nPK9rCvY6huzofyyq5z2LcFq888Sw1MBu8Y=
X-Gm-Gg: ASbGncvTLuc8zvtliry7Q5GPeB5uPvfGjs9kM9nXH9XB9uGprLNWz7wFu5GWxZm24pa
	n5qUmtrPhc0up0nvEhXwZMnP2bP4SwDWFg4lr34Ey2K30Mhcty+Y4JqtYTb1zqBOq879cIKReGD
	R61W0lnCNIpCHZBUca0SigEd5dTAYscyMCj1NtxCAGPcqPQjfmLAn5D/J3U8RYad9QyPp/zPuPb
	7VuErOl7UzkkSAm4pQFcBWccK2SsYgN9CjclsY=
X-Google-Smtp-Source: AGHT+IHBqWiNsRs7vWuJdEggEGVd2H9f8DdxvzoK+Bh6RPSuDwvhNgHoglZoAw8m1co7xPnKhEzvtoGChRKZ44lXf5U=
X-Received: by 2002:a05:6512:6184:b0:553:3178:2928 with SMTP id
 2adb3069b0e04-55a23f1eb8fmr2611071e87.16.1752780025333; Thu, 17 Jul 2025
 12:20:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250711174332.1.I623f788178c1e4c5b1a41dbfc8c7fa55966373c0@changeid>
 <xg45pqki76l4v7lgdqsnv34agh5hxqscoabrkexnk2zbzewho5@5dmmk46yebua>
 <aHbGax-7CiRmnKs7@google.com> <cnbtk5ziotlksmmledv6hyugpn6zpvyrjlogtkg6sspaw5qcas@humkwz6o5xf6>
 <aHfXrT_rU0JAjnVD@google.com> <aHgmzpNzMTL2alhp@google.com>
In-Reply-To: <aHgmzpNzMTL2alhp@google.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 17 Jul 2025 21:20:14 +0200
X-Gm-Features: Ac12FXzeMHloLpoxCo2SJb7cHfTgSTnMXV5KQxSGs3TLk0VL7h8ZlOyW2yje9eY
Message-ID: <CAMRc=Meepp_5WS2Tdu2gevUbv-_D_Xb-NfAneP5UBYJNck22Vw@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: Only destroy alongside host bridge
To: Brian Norris <briannorris@chromium.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 12:25=E2=80=AFAM Brian Norris <briannorris@chromium=
.org> wrote:
>
> On Wed, Jul 16, 2025 at 09:47:41AM -0700, Brian Norris wrote:
> > (2) Even after resolving 1, I'm seeing pci_free_host_bridge() exit with
> >     a bridge->dev.kboj.kref refcount of 1 in some cases. I don't yet
> >     have an explanation of that one.
>
> Ah, well now I have an explanation:
> One should always be skeptical of out-of-tree drivers.
>
> In this case, one of my endpoint drivers was mismanaging a pci_dev_put()
> reference count, and that cascades to all its children and links,
> including the host bridge.
>
> Once I fix that (and the aforementioned problem (1)), it seems my
> problems go away.
>
> I'll let a v2 soak in my local environment, and unless I hear some news
> from Bartosz about OF_POPULATED to change my mind, I'll send it out
> eventually.
>
> Brian

Hi! Sorry for the late reply, I would really like to be able to assist
with these changes (although Mani is doing a great job!) I'm currently
really busy with other stuff. :( FWIW I just spent 30 minutes looking
at the tree as of commit f1536585588b~1 and I am no longer sure what
exactly did I refer to when I said that the PCI core clears the
OF_POPULATED flag but I'm 100% sure I was facing this issue and seeing
OF nodes associated with a device that's registered without this flag.

Looking at it again now, it's no longer obvious, I wish I had been
more verbose in the commit message. Feel free to try and revert this
change, maybe over a year later it's no longer needed (or never was).
If it is, we should quickly see some issues triggered by it.

Bartosz

