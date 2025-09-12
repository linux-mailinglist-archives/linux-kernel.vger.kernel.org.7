Return-Path: <linux-kernel+bounces-813733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 917F1B54A14
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E562585A03
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 10:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CCB2EBBB3;
	Fri, 12 Sep 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wpec/RD9"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA4A279DDD
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673627; cv=none; b=L4ojDngO1ANu6Jjz6xGLnb8RmeErHGtyPaCMjYV2c1Og8Yb6eUPy4iylhz51OrvDVyOoclXKYEFsnknyPoFsprK1sFj4tzXzvtXw0kyFOvowfvyOEvrobf0XdwFhUAjKo++suJ/CGBVkdiiGCC/wlabCcrwdj/gA4U6AHUixoVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673627; c=relaxed/simple;
	bh=3e0QDJ5KbEQSENJLgEWoOKXZbyZ1RrVyN7WOTZvbwFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lt9QlSPhpCLvNSh2DjVSS7OPBBKJ5nyCqyxrYc+ABj1sZySXUIKUW2Md53jNxav+DXGd8fc5Sr6b6dVYbNC87fGyZFAU7OABcrmRKjE3EyFG+yDM2XWNelmSphHr48j4RDGMw8sWOuYiUZP4ch2jRsoBmmKHGFDC/4t1CIAtCWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wpec/RD9; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-621ad48bb2dso579894eaf.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 03:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757673624; x=1758278424; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3e0QDJ5KbEQSENJLgEWoOKXZbyZ1RrVyN7WOTZvbwFo=;
        b=Wpec/RD9qi4TbGQy3FJL1NA95+USMHmuMtbEHsw7oAhhUEYMS4urGz5OrcIxeEIrAn
         2a/BibT7iJtbHbxMYqn2i5IlUC2aXIVx7OaMabZzZw6kEil0SMpXoXfSX+H3iw0JJzL+
         9luibtddZn9SwB4f3Poqzhvh6pgbGlvOzwfG9iF2d38mqL4vw5sdnX6yFrQYXz5bBDD4
         hF33YdF64eDbjEF0ly0m+Zd5tl3NtDbkzpCAYlDyURiyrfnBG5bFo1Jv6/vrCqvvBMSH
         IdKT40H4Zwg5ynbNmByiOm0tuA0354YVoHkt/mHI2Lg0eIxoOD91uulP9i881j+EXp9M
         3SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757673624; x=1758278424;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3e0QDJ5KbEQSENJLgEWoOKXZbyZ1RrVyN7WOTZvbwFo=;
        b=cQ9rXmuqDW1i43SoeyZX2dmBbFujn0WtKN2qLvhP1ZQNkfQNnFKx2fb0lJn16Bkb5y
         O6+QsKvmuoIkABt7jryPEGm7YRWGSo2jOHd0Ggui4CnzqFtPQKbARiB9ih0I1jVgaAzp
         imh85iwJsMyjCo/sRmiL1UWqL1zXfftp/kVHuqEDX9VdlaicEr5CcO9YGodNxt67dq1l
         xcAEGKe3AMxwxkivCikvAk4SrlVQSI01ZyF0oywIsE9J9h0SUENa1ppEz8GcoptGe5vE
         D77xTvXkhKsaqb2/KH8Rf03LSyTSEyON9Mim1InNK+WG/OjVufrvuNIACE72V9YrvarR
         dJXA==
X-Forwarded-Encrypted: i=1; AJvYcCVp6/Gf3Xbb99Tz2VZ4H12pvefunWWzCUh9LS1BzWjHZ4RQTa9AzyYhUfo1wYiVh40PElXiepMxupYSvVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV/5WOskXDzUHdyQG/e8D1ZN4FMT5/gh54hPKx0vh+zj+lo2hZ
	T8M/lMzFazI6XtZKOkLcHN0i2R54YZdkKhIeF1zESXnjgKcNLYVNbSJWfUnOx1auz0gI5gmgyUc
	Z3Z1Q1707Jd6kuIuHslEvY7dOUWC+jtYgOqdqcuqvbQ==
X-Gm-Gg: ASbGnctj97u47lz1YrlKiBFilsTe5V7rrwu18/hMYCop3/aqbkpFynCuHf9k4/8M6Kn
	IUWoXYb1OBNnT4fvW3kIvnf7lGfP/+C2blg1ZBweTNNd3IT0VcBlJ6Dojq52L8OxQBoI75hlvpX
	3jJL5kqcKEB2DBGDB5rJ76NDqjnmk0pTRZK8VV2MhxB++/QuTlxAmCJu+judc3EXFTTB+3ry6Mi
	5J6ZV6M2VriI+HKWQ==
X-Google-Smtp-Source: AGHT+IF6PYieNgXpIa6hYHoBPz39MBN51Z0tSk5VpF01b/bxMjrI+5a5IB+fKLhWJ9leyknO44l7JDgMdXYIXbH0W9U=
X-Received: by 2002:a05:6820:553:b0:61e:154c:5b01 with SMTP id
 006d021491bc7-621bedb8f94mr1279631eaf.6.1757673624624; Fri, 12 Sep 2025
 03:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804-b4-gs101_max77759_fg-v5-0-03a40e6c0e3d@uclouvain.be> <20250804-b4-gs101_max77759_fg-v5-3-03a40e6c0e3d@uclouvain.be>
In-Reply-To: <20250804-b4-gs101_max77759_fg-v5-3-03a40e6c0e3d@uclouvain.be>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Fri, 12 Sep 2025 11:40:13 +0100
X-Gm-Features: Ac12FXyvumHdbJffBuyBixni6c5DHFCVdSez0KdSftksCT_bGFTh8Q4itCgi8Pg
Message-ID: <CADrjBPoA939OwErqjV4OT04hgAfDNgmG2o582Q_P6CN6iWQgCw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] arm64: defconfig: enable Maxim MAX77759 fuel-gauge driver
To: t.antoine@uclouvain.be
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dimitri Fedrau <dima.fedrau@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
	Tudor Ambarus <tudor.ambarus@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Aug 2025 at 15:25, Thomas Antoine via B4 Relay
<devnull+t.antoine.uclouvain.be@kernel.org> wrote:
>
> From: Thomas Antoine <t.antoine@uclouvain.be>
>
> Enable the Maxim MAX77759 fuel gauge as it is used by the gs101-oriole
> (Google Pixel 6) and gs101-raven (Google Pixe 6 Pro) boards.
>
> Signed-off-by: Thomas Antoine <t.antoine@uclouvain.be>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

