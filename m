Return-Path: <linux-kernel+bounces-727521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A5CB01B45
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 13:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959771C84418
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FAC28C86D;
	Fri, 11 Jul 2025 11:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="VpGS5zlQ"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEDD28AB03
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235001; cv=none; b=Q/EOMkX2FkLYayieyeAzQqgcn6lb30UjkzJ7p/XH4KzNyJRjp+6ZaBIJIwy152KEnkhXNslcdrM2qMF4EncIBOHc3TmqXsTw1YUsptQHLDkxA1F7HqQa44b7tmYURSDFMBd24DeMcO/Ipb/UMpDxez4W9ThAk8BQrgyc3sTpkEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235001; c=relaxed/simple;
	bh=sUjypECAV9l7HpwETK+19weztSxnrqfSlI7t2+qKBTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fpVhHdcO+AannM8um4sKSsAeF9jfVp+O3fYe7jrWnWVY29cFfCpxGXVdzmdfYftYQKavOTm+tg/RTGLOoeofmctGkTTjoqyiTACzhrUVBJ0hWWoWvhr0H4yKbMHVT2qZJt/6JwsFtjWlNOrm8m7nCRZbYCAHOkR16uYY7QDB68g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=VpGS5zlQ; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-553bcf41440so2125250e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 04:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1752234997; x=1752839797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUjypECAV9l7HpwETK+19weztSxnrqfSlI7t2+qKBTU=;
        b=VpGS5zlQCzQN5ju5TJ38Gnsirj9NMAsPo+LELpIaL6V+TvAIAlOq3dWAQ3k6IAnm4Y
         DotV2sV+28vZE/c9hpJqTwJwy31ipWe0m9e3fZmi8BlOxzKF1J61ipXsIDgRaTzHvlkw
         UlRxy7N3yywTjQqxF0G83aw0bNv+wX8F+xD0YnKJyO+rMry5NbX82WAee245R5Bd34ut
         lWvFe/JGyF9RDkl9vwV6dmAmuQNbkrhg14IpDYFOp+ZfSGZFgQKNnSs5JbfA960FxH5D
         DYQQxtkE6V0C4i7K8M6FxP7GD3PZKXewe7eo9FiZIJ7gVIjWy0EPVyS+AoRY7HEGlJAz
         M4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752234997; x=1752839797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sUjypECAV9l7HpwETK+19weztSxnrqfSlI7t2+qKBTU=;
        b=g3KOrIY8ZH+kLZzHwjp5PVoclON5hmI3By6VAqlxudCDA7vEWIWyNT6M10Z5oLTUhm
         7Kf29Uje3YOXfAJF4ig4RqAOg5GilXMsUTWB2PQXTdj4uYR+4pzsOLWeMKXp2yfHTEX9
         6yjtN2wBwbie9nnFtVf+733wsFBqvr4yYyDnaYqtCuUq8vR5DxmkN9gvOCp6W8RSnc2+
         rE8P24oOoyJ7B17KADnGQsKRnRwBpQB1uJrlMcvafve6m45exa/u6OWij5+wLDe896xl
         NWbnfFemAFFUPEQo6GeC990mqqtpV0D/sQldH9khV6V3hfxTsyGHrJ18EL8pD6lOqpsh
         QfBw==
X-Forwarded-Encrypted: i=1; AJvYcCVDa/qaL4Z0EbUZaezSfgISC71usWDjtxQDBi0Vpj48OXjKop0akfMjthdhhqqFo7IbL/vuCdmjhCXsd5M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ06Ozf51ocl5NwMrcbPPEL8PHT45b/7LJZICxg+9r11okubAw
	GhgbH6ynlW2VM5jDBnJonoV2mIKxcGmw+mANQyvdG9+MYveJtL165NY7RPaOsFdpIMs5TzImtVC
	NNsZnJ8qHispO7qluJK4nH6BtR5lYt5y3w8pUJJG34g==
X-Gm-Gg: ASbGncv/wrolP7RQO4uo2jhbyPs7PK1SOHKPiIiF9Uvo9YV85fo2mab4KheWdADJRdT
	PLTM1X2LtQsNY+69UHPEjyBPUm7BE8Y4cxFfPzGxAw5Qkkwa/KAP0Z26Lp05YWsS4Q/2Eg/jz8v
	ckPmA7MsS2jRdhhPLBoGI5XmT0oGUROdqWCFH6SLgcw4dO/z+44QmtuRa7cEOHeRXW5fSP2h6O7
	+X90YNmO4deVUj398RVmWOaf0hMNDkfaC90AQ==
X-Google-Smtp-Source: AGHT+IEq/UMmHtvEHFjTV6aqr3rU75dwqokAcLaMPs1BUYiKg+1Kq8VdjmrOwCdpOwDBf43jQwfn1dVNnQvJg4H/+Mw=
X-Received: by 2002:a05:6512:238a:b0:553:adf2:38bb with SMTP id
 2adb3069b0e04-55a0464b123mr839180e87.46.1752234997377; Fri, 11 Jul 2025
 04:56:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709091542.968968-1-marcos@orca.pet> <aHD40TD8MLug0C6b@black.fi.intel.com>
In-Reply-To: <aHD40TD8MLug0C6b@black.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 11 Jul 2025 13:56:26 +0200
X-Gm-Features: Ac12FXwotDotbAAEV4ByRT27hF9yk5c_eYziBFRiS0eSLdauf0mtxz0b2w6G-is
Message-ID: <CAMRc=MeNo8sBToDu_P7SahMQcW1xGARgOyQdgJBf7LdtvoYduQ@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: vortex: add new GPIO device driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcos Del Sol Vives <marcos@orca.pet>, William Breathitt Gray <wbg@kernel.org>, linux-kernel@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 1:43=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> +Cc: William,
> who is an expert in embedded industrial x86 platforms and might help with=
 this.
>
> Bart, thanks for Cc'ing me. I have tons of questions and comments regardi=
ng this.
>

FYI: I haven't given it a thorough review yet as I wanted to clarify
the way the driver is registered first so thanks for looking into it.

Bart

