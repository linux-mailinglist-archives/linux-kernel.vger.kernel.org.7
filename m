Return-Path: <linux-kernel+bounces-848898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C20BCEC62
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Oct 2025 01:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB63C4F8F6D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Oct 2025 23:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DCE2D1F7E;
	Fri, 10 Oct 2025 23:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="08jTALD2"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D422D1931
	for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760139774; cv=none; b=YpRSkWTu1JFKF1Hg2un0kF9sxjbzejIvdF6ObjY+AVvHuj4Y42Kbbta98jO/adU1IgYMOqFmq7Wpe7RLZfvo14CBeY2HHbRa8w0TNGV90cDGaeo1XTXNhlCONpdxZk1OGlTgBru53JCTSfPjegGHp25+VxoxZ2Wp8mrGnplXoo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760139774; c=relaxed/simple;
	bh=1DHRMQqIywXJrr6QTGXP6duk0tt6J5QON/Qjub4crf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m+qVqG8fSCn1/SXi69P139dcEMERj55TSGdt0P2Qwx+My0wpxx3mY/zG6UAeJqL/n9OvwZN/d0r9dVIU5i8XiPhBuwObY7/Xn9VTvkP8B0AD4GWIG303LjIxq+SUvJBTFa0W0oGUFjQ3gJD53xi5920Nb6sZ9Zi+PoWG4cctfCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=08jTALD2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so1556525f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Oct 2025 16:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760139771; x=1760744571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qjgmlS/nwdme/rqi8+Zl0mMzFEWA0WaAZGElUraE+oY=;
        b=08jTALD27JrtJOANd7g3q0Q/bboL+rjTie/jvR4byY1apN6kr269mfn7dKjWFOCn/P
         OFvzak+pK90w1hRRSo2T0TFyYFgHz1wWTSNylclVcKy5vRpE9UdLBQp4CyXoPwmvex+5
         eVHc6s4yfSxm57vIo45H5iuo8IJCsTciHNZTeAPXxzds4Pi7PWpGnub2QhyUOiQ/qBTx
         dj5zNskkkPXvzoNvjWUX4wjMrtYxjX8hBecNAlkykyTjTUjEyCWsXEo/mVU5j+rfa0iQ
         7wpMZP/jYDVvWJpDifp7yyN8pXOiAtNTy9ntK3rv1WL/30dMuUA7Mh6qghgJSVV+L9Z1
         eY0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760139771; x=1760744571;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qjgmlS/nwdme/rqi8+Zl0mMzFEWA0WaAZGElUraE+oY=;
        b=AXrbszRRruQxlZpATO/Y3qH7XybbbNGr7JjdoIFlPxAQU3x9X2XdCq5YidwZcW8QXl
         wqdtncovC4Ip8zy9fJUtBl6T0UXtIOnIbXOKuJ6aK+uVCaMajcg/Ebc/qW6VHsG4Nvom
         dVR3BAigJCUrHFA7i02OCAwUm0f3jP5dsGCchUsex1AoJ9a4J9lekEdjCLTeqSGpt1o+
         0W+oemlsoaJX/J6jh8qb+wAZk/k2dsck9jPu/d+hvBMn4Tzl4uRqE3q/l9bz8bNziXGk
         /USBMMC2n304C7VjW+NYDO1+WTkyYPLfB7IosL5OUK8oZfDN2+xkkculk1l6fhFFoWky
         AXKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYItAXwXhpHfJ1ir9X9AKQeLlBD4U4Oej18082VcJHeVVMWJI/WCR0tn6h+4xUmPfTx5mHmE533Iy7cJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7VaXrQg8jcIO7kkLkN5gFmpTvOQgdf6nsus3bv0vyvTCYvh3Z
	J+fwP1DSCh1F1QhuYuyTUnVtVnuWpZ1eUJY/fo9ZdtvgvRxrE+L6qnDyUx+26/wMRHHB9wAIhsG
	qKiPlnPwQeoqMLQzcCQAqmbUIS03BoB7iWh2bwAhY
X-Gm-Gg: ASbGnctAC5s5RZhuKd9MzFdRY0i40/6Du2jnbi29dp2Wwu7nt7eB2gPSS7s8NjBCuMA
	60NRpIpIZYw0Ok+5hlSMcVrBREzstmP0boXwP2oBEW8vZcN5wJs8FEtTBdNNBzgrW7Q9gY2Ij3z
	UOXmmtEtqQBby/KYQNRZlMM8bC182Xbr+RyBdhD/9gaxsWtfHtMrN2PzWeoU0A7pc7AfqqfJbt/
	R9b0BpoEsYkJFEiUZrg1ZVEkRklMjsH2QgVLgcA8/CsACpr9WPZDUqunN5xZXBJF9hvD9mtjw==
X-Google-Smtp-Source: AGHT+IHwk0C8u8+BGJMJhnPgtDgiHfihQd43A30Zms6p211AfNBUz2Fb03qCPj3iq3U+g5DYO0xAbnnUFf3zJMfbsts=
X-Received: by 2002:a05:6000:1a8f:b0:3fb:aca3:d5d9 with SMTP id
 ffacd0b85a97d-42666ac39c0mr7811026f8f.1.1760139771103; Fri, 10 Oct 2025
 16:42:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251009010312.2203812-1-jthies@google.com> <20251009010312.2203812-4-jthies@google.com>
 <zcs3utvlaac336ezw2y7mzbbjsqocbls3e4nx5sc4tufiig475@cekebowcrpmz>
In-Reply-To: <zcs3utvlaac336ezw2y7mzbbjsqocbls3e4nx5sc4tufiig475@cekebowcrpmz>
From: Jameson Thies <jthies@google.com>
Date: Fri, 10 Oct 2025 16:42:38 -0700
X-Gm-Features: AS18NWAbdJz1C0NgiYf1yQNoHH17CeGVC6GnFq4ht1hoOI5sdcoyeMHRLCTzf2I
Message-ID: <CAMFSAReOGgXAKsTPiGi55t2Xt=FsKu9FAznmYzDU=i71N-GTyA@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mfd: cros_ec: Don't add cros_ec_ucsi if it is
 defined in OF or ACPI
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: akuchynski@chromium.org, abhishekpandit@chromium.org, krzk+dt@kernel.org, 
	robh@kernel.org, bleung@chromium.org, heikki.krogerus@linux.intel.com, 
	ukaszb@chromium.org, tzungbi@kernel.org, devicetree@vger.kernel.org, 
	chrome-platform@lists.linux.dev, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> It still can be a subdevice of the EC, if it has a correct DT node.

That's correct. What I meant to say in the commit message is that it
does not need to be added as  a subdevice of the cros_ec_dev mfd. I'll
clarify the commit message in the v4 series.

