Return-Path: <linux-kernel+bounces-877167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BD1E5C1D5C4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C20C4E3F80
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E6C31984C;
	Wed, 29 Oct 2025 21:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dsnfyfkg"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C019E3161AD
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761771942; cv=none; b=QOrlQOmmHlPok2XgPxpICl1K7rfiLclD0UuyVRZmrX7GqLtYr05v62KlYqc/298Yl345IWrJk02KzOIwYy6NMAAzEYCcKPLsH856Wv+tSHvc0eopEqfdjMBJfY8FbtvaCsolue5kLC16+gy3GgRHF2erd3X1sJqZXVbjw+kzDoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761771942; c=relaxed/simple;
	bh=uJ4ecdVVM1k105aqK4/ui370dV5EO8SGRN7iga9es04=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=jvLl46VAmdJnbKgJg2jtNhsnH4nnZZEN176VDOd6kgOyRzzznUseyiQFlJS4i7DoA2JSmuG1uCzaMh5VNXwD+e1GVuHS8H9uWUnL33Rg2H4KENdEdbZHDBFDjBMoAWUlR4I442cUxYGotUTYO661AniZC2/VvvyeYJLYwyf46jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dsnfyfkg; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3ee64bc6b90so248669f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761771939; x=1762376739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTofcu4fJBU+wnClkDXXNYpcQQPdGA2T8MS/AzVhf3s=;
        b=Dsnfyfkg4xL6d6DSAhhfHSv4KYz4hFnbrq5NMal/+uaWk9U9ukZO7JYTGiil9UgM29
         RCmw/yKXUZxGoI5bqawjfSqN5CRthAXPevvkpq4zmaR9Z+1sksAGmdim9g6fLXbsa3OT
         HayslZDB4G3EECYnrqmg/KIOXm5Q0koa8EP/eCLKHWXeL7QLPKAdb4DjbD/+/N3IMIYz
         zC5TAPTAi/3dLMSwE05CR957L2426KHpShQU5jc7DWXyrZxHx+G/qOjlnqqdgsGvO8Sn
         d99dqTjpJPHSP0hO4Hz2EANFDBPAAebFAT8gtYxeDDqf7vImFbSuNf/u11OXJLeQj+BP
         b1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761771939; x=1762376739;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XTofcu4fJBU+wnClkDXXNYpcQQPdGA2T8MS/AzVhf3s=;
        b=O9gTPUd6HwWQQctnGsB6uMCHJN9P1oO3DYjqlzFfwOHJA3ngE5aXVj9EnKIen7FdbK
         HiS4CkzJ+GfCSjx/HcCQ1fWHE8qplbhEWben2EEkkyQbs6z+yZKd6QjCZX74laYTrLkb
         0uIhzePM1l9Ss4XNGmMdJIR2GgGCx/vh/LmA6Os7MKGiQIDoHQzcO3eyeMsonKGPDD+f
         2gvyLdDMPVPaXBTTkBYKxYBze6can2UT4SVqd4UY+9GWgs3C/7I/JRKLAokTbN/gSCuR
         7ddXso0ce7RD+iIU6k/rkR6mP7dZR/EfdVFnpK3TIt0HaQ97D3VnxhM8Jv+3gnRQeYYI
         gKoA==
X-Forwarded-Encrypted: i=1; AJvYcCU/H5mqA7IihEgDu9PszvsJafT6iiA2iL8a3DyUrda9OFj6c7WVgfucnR7A1gNwHkeamHJr7hV6BUB9lVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLLWdoqwKotCCCFeQ2ZOzjeSMba6L8iKC/iOm/GswnBDxiTk3e
	PO6qnJOjV7RTwrqHt7BHeGoIfjJPRP+teTb5x6+8GeR2qZk8t8gWb7IScl3kEz5mgYo=
X-Gm-Gg: ASbGncul4vT/0JOKUtL0wlqicKbjXcVn43rd8MB1z8xSErSIv9aN5KcJFI4iajDCQP2
	YVJWhK/TXD6duckQFU4G5IglelcQpeP+/YrO8I60Vx1dKlhWb6X245wxI3dced8cowaxbm1G4Z6
	mzo1W5oVnjCDINJSgDAJnHITdXw5XoC0Dhd8h2fMSeJ/Ibwu2omMDmDkfuFSQN3ItrElRiBwtwu
	cUPlgKwFu61ljmxrUrvj7EkfcZ1UvZ+f1TOeEa4/sWfXErQO/YAwSn7VSnndR3STkr118Vj3daa
	TQcmHHqA+ouT8T6WOj15jnJaZzaqUBIPqMF8BZ5ITF5cJDNzP5fP8ttJa6yOHweIoLsabLGepG1
	3G8qKVLAl66cFaiY6OwpEYWv1KHVfrdIYHWnm23+5ReGv02wIdurR4Vg7yBHrFHJtkA4FvUzFPi
	nOBHwM/6+nNQgKpMUDunH7/pFK74x8uiM=
X-Google-Smtp-Source: AGHT+IEXesMK4yi3aw7WNkX0LUl8o2qwDZkqC9YReAIB/Znsz0lE3UE+zV3f3Lh5yILl8ityWjzuTw==
X-Received: by 2002:a05:6000:24c1:b0:427:492:79cd with SMTP id ffacd0b85a97d-429aefd6a64mr3010887f8f.41.1761771938978;
        Wed, 29 Oct 2025 14:05:38 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952de971sm27815109f8f.39.2025.10.29.14.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:05:38 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, Abel Vesa <abel.vesa@linaro.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20251028-drm-panel-samsung-add-atna60cl08-v1-1-73123789fcdb@linaro.org>
References: <20251028-drm-panel-samsung-add-atna60cl08-v1-1-73123789fcdb@linaro.org>
Subject: Re: [PATCH] dt-bindings: display: panel: samsung,atna33xc20:
 Document ATNA60CL08
Message-Id: <176177193834.2073083.4758126268960108187.b4-ty@linaro.org>
Date: Wed, 29 Oct 2025 22:05:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3

Hi,

On Tue, 28 Oct 2025 14:22:48 +0200, Abel Vesa wrote:
> The Samsung ATNA40CT06 panel is a 16" AMOLED eDP panel. It is similar to
> the ATNA33XC20 except that it is larger and has a different resolution.
> It is found on Qualcomm Glymur CRD platform.
> 
> Raw panel edid:
> 
> 00 ff ff ff ff ff ff 00 4c 83 a6 41 00 00 00 00
> 00 20 01 04 b5 22 16 78 03 0b d1 af 51 3d b6 23
> 0b 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
> 01 01 01 01 01 01 cb fe 40 64 b0 08 18 70 20 08
> 88 00 58 d7 10 00 00 1b cb fe 40 64 b0 08 c8 7a
> 20 08 88 00 58 d7 10 00 00 1b 00 00 00 fd 00 30
> 78 da da 42 01 00 00 00 00 00 00 00 00 00 00 02
> 00 00 00 00 19 96 c8 46 1c 5e c8 00 00 00 01 4c
> 
> [...]

Thanks, Applied to https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)

[1/1] dt-bindings: display: panel: samsung,atna33xc20: Document ATNA60CL08
      https://gitlab.freedesktop.org/drm/misc/kernel/-/commit/2a6550191adfa20c6f63044531fe21202cfa03e0

-- 
Neil


