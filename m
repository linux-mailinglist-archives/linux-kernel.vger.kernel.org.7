Return-Path: <linux-kernel+bounces-878016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 987BDC1F923
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 11:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4D63188CE35
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0592A34D91B;
	Thu, 30 Oct 2025 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yUezNkgI"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED5E33B95D
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820388; cv=none; b=ep7SFop/FYBX2EIR4jN4486g0are5sAe02G3/Ss/cD2ZIVxvzJXMY0vPRY5Bf5BxqXjnvSQjZCn3ZC4BZh4dX2ayocsYZpyQEliOM+UBz4I2IWbl8/vCBZUpEjKk0X3Djq9rRE0nGO8YSb7GfkK5GujkSBYm0myQHugofGGOmKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820388; c=relaxed/simple;
	bh=fkQuN4M9OXZln5Gas2xs5QTY9sm7gG9MAV/63TxPaoQ=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TM5q7O6DwHFxJXm9UbBYEZw1CHwBI7taBx3hZ8BRlUeDahPMK9zJNtGx7EcJIGjxcBarf927foXZqjrU2lH9IcfvzK37sv5PExllGkOtufK3Hp2uG29uzM1POxC2MrtENypWwDLSisT0LsBSCkCifZ0GDRlPi3mMVkMfURjg5BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=yUezNkgI; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-37a0d3d2e8aso9431981fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 03:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1761820385; x=1762425185; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=MWaZZTU8/qNu3sUrivVmXo8XF2FXNMsT2t8CXXY/7N8=;
        b=yUezNkgIYlZTrlfwOJtks2Z8PFebp31FfT6WnJVyTz63o8qDRM4UoMwfx3xYphtYGt
         +3dXpXT3p8YfNPZtkzZG7o7PwD7Awp8tvRF/2NHm4rrGfjy6Pt9oM+fFWt4RSWSZDzX5
         DDlWsD+XHIaG6aG9gB8W9dVqYJdTfraeHjUH3CCM3g/ON9vaeuFY3Zk95AHo+iZOTPu7
         gxmQmEajv5TVBlnLn+23dCw9kHBdB/I96ffgAh0MzJMXZ3qOvsr9Cw49drRaUBM5eo/T
         vTGTlSSdcj628fzo++H5NNWxfYAG/9pgXCj8oBhje1dxO8PWH/MNoUIOssWLpD5G5ukE
         Q1Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761820385; x=1762425185;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWaZZTU8/qNu3sUrivVmXo8XF2FXNMsT2t8CXXY/7N8=;
        b=xPhIo/L28QNblcmRjkQv/EXtWTydHQxoNKDr4liXtc6klK83UmjpDwGbZFpjv9RSCo
         g/yq3yx17I6Sg+UG9GKJ8ajjmjViUr6PpokUw6uG1+Sez2/NpmM4FH/xuaPWoruee+Yx
         mei1XaENC9VrMHeR9+aGvlTKo8UljvtCsOLqK9nFNiuTWlq5vSHeyak885Ficg7TdPt7
         f1ciBx1LrzDHJQzibz351U/XIAcJZZsisK4rrEKGBbqV5VbLL3jcyHbq8/5wmRrXQLGO
         lADYPgP4zPMnYuRdjyDy/hZOEG8BXjlKdVu/H9m6EA5kJ7V2pl4Jw7AkoA1AKH2tQli5
         tZsw==
X-Forwarded-Encrypted: i=1; AJvYcCVufqtOorg8ctFsW7Bo6QzcIsAxbmdeDJcOSfHXPewQTNdBjEpYmT5dqOYcAZqBZ3PdPVHgTk2JORklvTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2ISIa9kWJnztkuHeuDK2gjqWuURTwYlrPpdTIO32k6W3ZXJG4
	OGtW4Ukff2Ukz3lNazknQ5gFdJj1QXyxLZ47WD8BBco0WyGRo56GlF8bIBPwwlSYimAN8WpL+EZ
	UMatSuZZQvSsTMbTbtZ/c4vSur36JbGn7dzTxTx/kUw==
X-Gm-Gg: ASbGnctLN2XXbtARt7kNPNpAtv4ep81WavqxRp8rCxux16gNZ7CTjHiXusvew1e2+tx
	JcsWrZACX+0EE0k4/Xue+U6tjoQclkD/ZgqDb0EiadPhcKVggD/7ajskWdx42hrvawcilP7g17E
	Gh5AtNxHhcOWogtrToAhHgp0qnziBZuIbmCPVaBbZY9W7CqGo1eEqXOuOPo7mMRnxw7o1Q+2wOm
	guJ8aMSGJDVgFq1O5RZIki9mCAQu3NeCAzu9rJ/cw5DcSByWHu783+UoH04gSR1cmgq9LC2p4L+
	EqIsGZxGwGESd9s3G3pKx/7UPQ==
X-Google-Smtp-Source: AGHT+IFhFWN/4OudZAxtgLsuvFOZccyNoMyjpf90aD3ueT+mFrZ+QXd3pkXKsskOxyxG+MbzSMsmqJjiGUh6n54vjzA=
X-Received: by 2002:a05:6512:3d0f:b0:592:f115:2949 with SMTP id
 2adb3069b0e04-594128e5f03mr1975919e87.40.1761820384668; Thu, 30 Oct 2025
 03:33:04 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Oct 2025 03:33:02 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 30 Oct 2025 03:33:02 -0700
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <aQMxNgC9SWQp-yUy@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-reset-gpios-swnodes-v3-0-638a4cb33201@linaro.org>
 <20251029-reset-gpios-swnodes-v3-2-638a4cb33201@linaro.org> <aQMxNgC9SWQp-yUy@smile.fi.intel.com>
Date: Thu, 30 Oct 2025 03:33:02 -0700
X-Gm-Features: AWmQ_bnzqCfSjLPQSQJvj5qhc2Ow1ivS1ZlAVQqDeOtxRUXYZLAdKO4EXPlIarE
Message-ID: <CAMRc=Md=Dcwj0qDu5ysDafjuV0Ud9z2Ky3PQpDzfiKRt2L-HgQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] software node: increase the reference of the
 swnode by its fwnode
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Oct 2025 10:34:46 +0100, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Wed, Oct 29, 2025 at 01:28:36PM +0100, Bartosz Golaszewski wrote:
>>
>> Once we allow software nodes to reference other kinds of firmware nodes,
>> the node in args will no longer necessarily be a software node so bump
>> its reference count using its fwnode interface.
>
> Same, a short comment (or an update of a kernel-doc if present, I don't
> remember).
>

Andy: the resulting code after patch 3/10 looks like this:

struct fwnode_handle *refnode;

(...)

if (ref->swnode)
	refnode = software_node_fwnode(ref->swnode);
else if (ref->fwnode)
	refnode = ref->fwnode;
else
	return -EINVAL;

if (!refnode)
	return -ENOENT;

if (nargs_prop) {
	error = fwnode_property_read_u32(refnode, nargs_prop,
					 &nargs_prop_val);
	if (error)
		return error;

		nargs = nargs_prop_val;
}

(...)

args->fwnode = fwnode_handle_get(refnode);

I'm typically all for comments but this code really is self-commenting.
There's nothing ambiguous about the above. We know the refnode is an fwnode,
we assign it and we pass it to the fwnode_ routines. What exactly would you
add here that would make it clearer?

Bartosz

