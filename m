Return-Path: <linux-kernel+bounces-866933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C1BC01149
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 14:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E26973AC0DD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 12:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F302313551;
	Thu, 23 Oct 2025 12:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DBpogQtZ"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAC2313539
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 12:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761222070; cv=none; b=I3JhX54L8m8M5aOEtPk2vaZpaLHBckzngO52WuKcvw0HapipLpH+VEY8BMqwi5HsKxyK83gvVURWACciuaxBJT6Dg7klptIt/3GkH/Q9tnMpxbbmC4PU9nJO72gPFeeAzZqiLXPzDqCpBiHauxAltLgxsWlVf97kGW70aab3/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761222070; c=relaxed/simple;
	bh=IsrehhMvsrqu9lFsyjvZapoUoNadoOE7Ma0wSKKAINM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWJ0MpZVYpw4QGTyk060v8nH6voPKmgFaTDguC3RQFDw3bE83ZlMQmLO5q4TDO+JUQqGuBKUhlnn3gEXlTf3qAkiHdlovD0vnLn+rXN90rv4EO0daMxC44G8y+Kv8IJyPIERiUUJXGA5s2esgsIou/UTr8lZ5k5TIvPSqkvUd6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DBpogQtZ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3737d09d123so10192241fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 05:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761222064; x=1761826864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IsrehhMvsrqu9lFsyjvZapoUoNadoOE7Ma0wSKKAINM=;
        b=DBpogQtZSrqHb091qyZ58R0nqddiwVu0K6bdVFB6tyFArMXqjxU7Zxuz72OOg3PfsZ
         7vIwQ0MIUj+CbbXxg5b8/9fW2aKxlcR+XGQ45WCKqa743Idcu3wKINZQHLWVFn04tHx5
         naLgQv/WP2C8k8NF6yhb888loyOgklt6N7NoYSbrwa0zckGg2P0ve1bKzZ9SOKWTYUWM
         exmzga/ylC2LkzetZ7GBV+jqYjgUCt5UZlgAXUobh3pUxsfbWFzPN0qF8v1iipwqNvnn
         m6ZCXFEcKk+Z86C5ZcguSDuNmF6vWjrHf/CeBseyLpbLY6Oy70rHdnAOQtkDbgpbS/xO
         SYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761222064; x=1761826864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsrehhMvsrqu9lFsyjvZapoUoNadoOE7Ma0wSKKAINM=;
        b=TUyWmY1dwkKM9cfkkNlxlLAwSBY1XS4jafyHKzh/SU8sxpyBZ5RNsnXtDCBq+pDfvN
         rmm0NEwg+LNWU/KGWDJCIYcsX0uaFHovK2XtYIJbog68N9trFsYsaqZEidsvNKhzXi0G
         cqNO9e71+qGUMG8+uxI5usCdlfNQN7SeuxA1+VLQbcmQz/VgDHiWMUBtwvS+2IesJDh4
         +H1NePZI+M4qa5UK7fhp3NCdK0nIkaxWYopWuR66rvTB5vkyUhQ9ajGg3ZoqYB5v8tWw
         QTNLQC+oOANXClNAnGYqY+MbMUlkEDA4y8VVSBLc+i4SUXgLchmxYV4k4SxhqJbRMXQx
         2P2w==
X-Forwarded-Encrypted: i=1; AJvYcCWs2DzbEC7cYDr3Acn3YItOAtUqm+MNqR/q4h0GMkIEbkqI+tala2K39wnMsg49AlHllLv1inffrKzspek=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQc3AjEXUOtKwFYqkhgkgNJYkzHXak8TedYcDkJKMC6WCF9JkX
	i3IT8qpnWStrjDzoG4Dmm44e/aW1d3dTphdzVOtTHbXzeP+Z1YU84rQYG9P0orxHzfjkiAfBKDg
	GMmxHxOEbVd2r8p4Iok8vbVsyV22Ha74cpgg5r/lpRw==
X-Gm-Gg: ASbGnctb4Hxb0BOj9rK8BTx00C6uHAseA/rSF0GUiH3/P+iVJlrvGBtE8+PsQixAzJX
	4Rd7vD/rBSCZkliRFohZpis3fN5qNSk1PqeNl4yzjV7RNJWtwsPHG5W7YpUs+FydYapkAaVfet+
	YsJ3lBMgUqgPcXD4AL7Goo+6vN3+jXml38szXWE4z6gxbdtguYQ3WOuRkMvmJXCXVARi17jckaT
	+tpmIbWURKfL2eY5y2Hzd/vdAwK5BZgExhUx1PViFCx9cQRnfv107Y7/Y1u/bmlNlRCoNM=
X-Google-Smtp-Source: AGHT+IGJDKf1Uen//0RZcCPTXktSRMtt1HNpyZJcWUOPP0zlmgwvqRWYrmfkUyl6vNlHZ5TMcW7bpMrzIgjpQW6J08I=
X-Received: by 2002:a05:651c:1595:b0:364:f7e2:3908 with SMTP id
 38308e7fff4ca-37797a1439bmr69500261fa.26.1761222063730; Thu, 23 Oct 2025
 05:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
In-Reply-To: <20251022-reset-gpios-swnodes-v2-0-69088530291b@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 23 Oct 2025 14:20:51 +0200
X-Gm-Features: AS18NWDVMpeecJjv0cRW3F7qI1uaG9BjtPpGzNd6sonk6qBJU-hrZwRAkfMZn8E
Message-ID: <CACRpkdbwnzLT5jNtVCLUmadNt0FBaihg8VRGECdht-Ystpqd5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] reset: rework reset-gpios handling
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Krzysztof Kozlowski <krzk@kernel.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:41=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> This series does three things: extends the software node implementation,
> allowing its properties to reference not only static software nodes but
> also existing firmware nodes, updates the GPIO property interface to use
> the reworked swnode macros and finally makes the reset-gpio code the
> first user by converting the GPIO lookup from machine to swnode.

This series as a whole look completely sound to me!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

