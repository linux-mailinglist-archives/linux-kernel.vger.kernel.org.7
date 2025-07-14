Return-Path: <linux-kernel+bounces-730780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D14B049BA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 23:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CF551A6130E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 21:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520AA27603C;
	Mon, 14 Jul 2025 21:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DA9yG1kF"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B07024679C
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 21:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752529677; cv=none; b=r14VL9oDNal+KrzSKbroIzyhyBIjayZpnlo2RpnC6EZ0NlKrgM7DrEAnV8o0qoa6uh8buAqeKN13KEtT1q+oOJehJsHobANxBJnjrB3yf/xIQLe+ugp2UZfXv5z/suSsaf6uic0ZBTIJ6lxEEsmw+Q6WrgtW3Dn9rRhRhTHl8dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752529677; c=relaxed/simple;
	bh=V9Y2NIs0QY+zYv8H9yC29XGZyfNuVxgSGOBvL77XYk4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOVncMPQOunNEGRfEnHn+AD1/G1W9gQVB6n5Xbr4XxSgpGbpsqru7ZFCuEjOsHPqSuLzkGJoCqR28sioTdrVv5lsV6+BMqNJqoHCLZgY26Q2E0yRaGsir6z4WP8wsP7+yfhfHudzJkG4fzNRQWOwGR04wlWnjN6aDHm3X2IUKWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DA9yG1kF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-23c8a5053c2so46868985ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752529672; x=1753134472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHUobGGDL83F/rNDnQcpYA+2CpRw+ILTCJaorukvyyU=;
        b=DA9yG1kFPrAZESQ3fn+cHI6fSd7LVZ0B/+X9YsZb4qR69JXTHB5IOYCuktbd5JWEJb
         ufrjtKbTql9m2bj1mLaFpRWlq7d2gE7asVkvqpUTG/CzRZNTGP+5So3gbo8nOUXl+Yj7
         d30xDCgo+gwLJFk2AX/j7pil8l59Y+2cFt4+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752529672; x=1753134472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fHUobGGDL83F/rNDnQcpYA+2CpRw+ILTCJaorukvyyU=;
        b=q5DC/+aOdSy9h07HYfvEOCE+MDrB0mBO/1xRyOGtl3WlfAtR6T54rE8AcsEFRyaTRS
         DI0ezZo3zLkxCsrf3wWtCMTfXsoxQ1U+FY+UL1FWDzAGy5LrhggDkOrSUdpJHBZd9gz6
         bOUKmKjix+/FHOc5HtpO2c0AlXCNlNXvztdSgTqiiFUlkqtgx+szKV8DLWA4h6fJiQXA
         ih41YYk/vrHXFLuDt8SiGu4ywj9TZaBgqCzhSNoiwkGY5gQwLpDqovQzQAKVCUczrjhE
         Cxl+fvDOghCG703F9TyvPeGTQ6kIpfQGKUzWG1QnIkePxrEJGfXH02BD/2YIquLGj62e
         aupw==
X-Forwarded-Encrypted: i=1; AJvYcCWULEgg+goSr1gGzPVmadyJH/N6c0ILb+jg3UXLHrloAMhBAqEkV5UVaQQEHjx17WpZyAa99b1dAtzYJsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZlq61J2z0iKIiD/TtuAaseb99YKpjuAivnmUAmz1QlKPxF+LO
	VDDYYxS1d8hUCRxM3D3JbY3zq6p3ag/SecS6Zs7K6/Dh3ps2hVk4/scKitX3z/3PEfGEpLAWBHM
	JUz4=
X-Gm-Gg: ASbGncsKBoAEkHWsiCgzaMl9ijch3rCdfQwls3fH5IkUkFvtQIKN6yVr0uR/xPCUtX9
	s1Oy5q/ap49dYSzhDDbsicGp+8OHvW/0v/P9Nc2plzlY30x8sr8Oi5wf1olDdFAbnJ754c8iHuS
	vtUsmdsfabbJ9u6VZtMWopRw+43kMg3aJbKMOJQnMU2W1kHnOjw+aeU7lQY1R04+AvWR3CyBsAQ
	PTLEonY59DZe7p2N1o1c3Xqr04kMqJNqovNJbUge/aV9Twik0N0GHbuXx+0Z0KJMPvn+0kJ+CI2
	Uz2Ta01QPK0hF8L/EkO+qUrFdn0boBApjrFbYD8TElOJOg2wzNM7jsZJJV82GNGiPCrns5Ew9zF
	QGBCSEYNUqSDyMKX3pJBSAYfJTc2+gJIEj4utwrLbu7DxkaCy6hR0ZcaufJmutg==
X-Google-Smtp-Source: AGHT+IFV6r2XWFX5UG0dTOzS/YT0EzuvCy+rzf8tyKGTx7OVvyzt+c+0oPJQdfpM9wS+MlmHKFym/w==
X-Received: by 2002:a17:902:dace:b0:224:910:23f6 with SMTP id d9443c01a7336-23df0961d6cmr227312145ad.45.1752529672006;
        Mon, 14 Jul 2025 14:47:52 -0700 (PDT)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com. [209.85.216.42])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de4359aa9sm103376895ad.208.2025.07.14.14.47.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 14:47:48 -0700 (PDT)
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3122368d7c4so3960629a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:47:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU5Ug3QQY1XPRC8DFL4WXIoIfWPgzpiBkl6QsDwiQxo0xyW9bZuLt7yKSHmOL6DpVhOhCNPwm7oYEG+/q0=@vger.kernel.org
X-Received: by 2002:a17:90b:2f03:b0:312:e90b:419e with SMTP id
 98e67ed59e1d1-31c50d7b487mr22879682a91.12.1752529663338; Mon, 14 Jul 2025
 14:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250708073901.90027-1-me@brighamcampbell.com> <20250708073901.90027-4-me@brighamcampbell.com>
In-Reply-To: <20250708073901.90027-4-me@brighamcampbell.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 14 Jul 2025 14:47:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XJ8yqzyivLTrVCzjtNOH1Y8BUOS_U80es8vJGBt3AdCg@mail.gmail.com>
X-Gm-Features: Ac12FXwFl16Z6-RJd6zYJ2xS_PM42hpyLDaAqwQv40cOctjOMerkyA2E6guYjpo
Message-ID: <CAD=FV=XJ8yqzyivLTrVCzjtNOH1Y8BUOS_U80es8vJGBt3AdCg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm: docs: Update task from drm TODO list
To: Brigham Campbell <me@brighamcampbell.com>
Cc: tejasvipin76@gmail.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, dri-devel@lists.freedesktop.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jul 8, 2025 at 12:39=E2=80=AFAM Brigham Campbell <me@brighamcampbel=
l.com> wrote:
>
> Update TODO item from drm documentation to contain more applicable
> information regarding the removal of deprecated MIPI DSI functions and
> no longer reference functions which have already been removed from the
> kernel.
>
> Signed-off-by: Brigham Campbell <me@brighamcampbell.com>
> ---
>  Documentation/gpu/todo.rst | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

