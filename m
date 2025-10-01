Return-Path: <linux-kernel+bounces-839378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175FEBB1830
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 20:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD04D178A4A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 18:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B382D595B;
	Wed,  1 Oct 2025 18:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PjI8gWsx"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9C52D3A86
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 18:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759343786; cv=none; b=IW1jYUKT4j+GCX+GvT7ZgAuzd2joJhJ9qmtSLFvuw4JsnmJzFrgZJ/xoOqpt6hm97cGD2emBBArGCYYohboatVrQNrxWE0UsJ0rOnHVRGtbPgBrXBEfoHV6Gy5vht9MqSGOa4/SWGWkHu/ZqAe5XczV+J6WmSanKqvPMMQ0Vpmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759343786; c=relaxed/simple;
	bh=UIxAQDQJMbN9Nt33/FwttLDE3FgEeI/xim5z6CvYRRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PZzo2wayTed8d5aDXxQl+ZLd+PL1R5Bs7roLcYj8aXSbxUBCOoMJ8jgeah9iKxkVRBytjtwDGBkzXvnd32tbjGfBxTusVAMWLCQynY7eodyXF9mn2S6/mYlHdjCTN/qRfXJjev1O8xPltXEevrwuNv+xZWjI4CVl69RdoVXqS7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=PjI8gWsx; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-634cef434beso2565419a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759343781; x=1759948581; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4i25jEK4dntxz2BKGOtfgS0CLdgFA+0hjJfJ87nVXJE=;
        b=PjI8gWsx+x7HVUVpDSYFrxALirqcJQFqf7XVCXGVAr7SBd2q2Ui12xUMrcBq/0t/ID
         /wRNmT8xEmks1Pb2YURnVDHgbRlRoNeiPee4aogiyuhLbIvGjRj346AjPYG576QZOWT4
         Hh2ATD5XTYe6NZfbLwyNBFnHzV0UAWT1ILK7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759343781; x=1759948581;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4i25jEK4dntxz2BKGOtfgS0CLdgFA+0hjJfJ87nVXJE=;
        b=padI/YI+PCnni5nwBKuzHUlt39LIH5ZbQ3/rIb8y/tDVhM9yxFwpQl3odU2DB11MoR
         DDBMp1uZ+srzjxkb4ifMxeStVaW4AHQnuIX8jmcKdRds6GruvTQ+/+DypYFBiXAqbn9A
         WARGJ2QQgLC7qG6x+avZhs67vVi0jDdXQsxjJ6nQ6y0z/zFz9EvEIpYa2irzj/yEhL2B
         GhtvYWCYobwR5cgVb+RClx9ll7NrTDEFv4OPaRaRc9akAVATj+PtdcLJ9bfqmNodLg3h
         55BWCYe4cUOGcCaYkaMTQwIPcgLT9AVIDSKhx55bbW3K904rRFV3S+Cb35/kB/6W8pQg
         mecQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqtS/8YX2TppgKNNWftV9zkY6swNoEZDRoMrBj8wAqOkByc9xzbm3Yz5+tQClU32iTRh22LtwVFC/Tjl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6WGNCrtxCLN3DcfRfHjhj5nravwkjjTaC3sIbPgRxO4yD4qlV
	3rhDnq3e0FFIfXCKwrQWO0poYlKsMJg+rXGKYHT3xgyKqpsWAV6bPP1ogPsAArmqIRVZpCqCtSw
	jM3kUfy0=
X-Gm-Gg: ASbGncuxhHHaYke0JCb3Lrxria6PSxb+YeFEgwdw8S3aKxrjlliET/5XXMkn4Y/ZCNH
	t6chPaTLv89Nrl0KYEZEMy1g2Fj9FTzi6Kyb5EpSDKJ6BmJ9s+lFxDRFdwQaHNjy7XVIx8AENTB
	Q0cLRmXAVNxw6vf9z+IvFbjgG81WsaxFjvGviZafNl1N8T/a2yCzV96hhoJGZeuCvtgh9RnDO8d
	34WIKhJ5ZediYSfGXb5PEVFyMx/Eu7+T2AtvZjZfiy9UrjFfpo4aJY8PEptYdxx9BzJDq9zcvMW
	MsjWuQ/Z/DXHis8xQ5YR3g1Ei19mLav60ZJsWJvEQcZr3RxhtzLdhOlT5sALB+qpJgyuUC0PoCY
	YjAoqJV92rkGw7QEIWzCMcJgAgi+DMYtQbpWs4aOwkenxMVeXeiCZPfHF4w3oTj/qNcwmh8cMIu
	sVUzoF9wmHx6z1pBWgZapk
X-Google-Smtp-Source: AGHT+IEErGcfMG1KjKE3Z0oRcoHJkkWALyXipAjZEEntWgm9p5W+Nh+uIc+KxnxIl3BoExWm6iqaXg==
X-Received: by 2002:a17:907:3ea4:b0:b2a:657:e733 with SMTP id a640c23a62f3a-b485b39ada6mr78099566b.15.1759343780726;
        Wed, 01 Oct 2025 11:36:20 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b48652a9f11sm22223866b.4.2025.10.01.11.36.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 11:36:19 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3d80891c6cso224345466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 11:36:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW0uSgeShDZTeCk1W9gdo+NiKVom143WCEYkCVIrVQ7jSLgpzI+uC4eBSd5XvchSwNRH/vqq7PWJdiEiB0=@vger.kernel.org
X-Received: by 2002:a17:906:c10a:b0:afe:159:14b1 with SMTP id
 a640c23a62f3a-b4859e7d413mr78539466b.9.1759343779157; Wed, 01 Oct 2025
 11:36:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929094107.34633-1-brgl@bgdev.pl>
In-Reply-To: <20250929094107.34633-1-brgl@bgdev.pl>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 1 Oct 2025 11:36:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whnmvjsan9Y=LcV0encJungD451VkdqYAKrRpk6YyA6-w@mail.gmail.com>
X-Gm-Features: AS18NWCnkZF8pjj6PmEycUScBzOCrNuVV1Up2k2QPgdQ6BQ6UKmqAtm2ll7h4oI
Message-ID: <CAHk-=whnmvjsan9Y=LcV0encJungD451VkdqYAKrRpk6YyA6-w@mail.gmail.com>
Subject: Re: [GIT PULL] gpio updates for v6.18-rc1
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Sept 2025 at 02:41, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> Here's the PR containing the GPIO updates for this merge window. There are
> two new drivers and support for more models in existing ones.

This appears to not have been build-tested AT ALL.

> - allow building gpio-stmpe as a module

This causes build errors:

  ERROR: modpost: missing MODULE_LICENSE() in drivers/mfd/stmpe-i2c.o
  ERROR: modpost: missing MODULE_LICENSE() in drivers/mfd/stmpe-spi.o

because while the main core stmpe.c driver got an added

  MODULE_LICENSE("GPL");

when it was turned into a modular build, the SPI and i2c modules did not.

It's trivial to fix, but I should not be in the situation where I have
to fix it, and I should not be getting pull requests that don't even
build under trivial configurations.

How the hell did this happen? Where was the basic build testing?

                            Linus

