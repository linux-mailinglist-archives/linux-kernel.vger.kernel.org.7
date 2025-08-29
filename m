Return-Path: <linux-kernel+bounces-791979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6965CB3BF03
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 17:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E123E3BE093
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 15:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4B2322A1B;
	Fri, 29 Aug 2025 15:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="UMYzNZlH"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D92313529
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480588; cv=none; b=qSlE0pXjq63zn1ZowGeDQadJmmQo4J9tmN9dHvN4H2wtap69K8gjNlEa0EKQUdNkLBau4E1rjDnkb2CyIyDgO67hu2bPif9+5WZWrYGhYTCMXe2UpSk1LFS8AyDI/oP+jah98FNbiDE9fHNAgIYfIyzA1DB6Hljqk6ViPC/2eEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480588; c=relaxed/simple;
	bh=EFiNNK5RLh6CaKMv6azk8AkQH2szrXNmreIareS2Fz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cYjJOFu+yc+9PwbFAxW8df+pQVnTh/uI3QpMC7UZUJGKdau+FuzR5W3qOlNnylfthJMoCb+EoNTOv18CCb3JUT6tH27dHvEUvT3GNBumXufOCcWx/d5shoQoQuRp9LW1PpVMZdn/qfwDY3X9RyJ9/CMhIpFMI6hHxmEl6fiBp2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=UMYzNZlH; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7f7edf7621dso185873185a.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 08:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1756480586; x=1757085386; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lOUf78kJC5CeFRX+36nx9b9SoyYDtPWwiSrTZqImx4M=;
        b=UMYzNZlHaQL5SJ9/dbNdN8p17JMu+rwJYD7sFCI0/iA2TSFHJcqfxWBMbojIHSZcuq
         8WC2kc3BZzA8iWObPNtz1eXCH6mKJ+pTittS7enacHpOeRNMDZJrdhIkwQvDdFAEW//f
         A0m4ktEXp7CCAEZnxsTPYDraZf2vzBhBlTxmUdgqUKcqdfEzutAuFlznQowL1X0pH8Dl
         rSa21XI+D/gpYSwaGIDR4/6gqz8BoL9sQksHNZVKSoYklRFEr+yWN4cRLdADhOJrCsyO
         wtKiJzzahfIWjeF3TUGJ8ZWdEfU2V86fBGPLbaJal+stJY1e6o2u+vRUfQ5Fgr07gH1G
         XC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756480586; x=1757085386;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lOUf78kJC5CeFRX+36nx9b9SoyYDtPWwiSrTZqImx4M=;
        b=H4wRnuUm6WLHT41bQaPLPSYJ/6MbwkGIxeK46kRpB34mb9S+R3KaICwwPiDUVfRjsL
         CamhmNzNyoAHzb7MSZx5tGqC91wMZCCHPfkV23Bgn/brZ/gt8NhCrYfavTl25caiZw9u
         n1MRFmcvOSg+Qd5IpSxVYS6d5JPcMlXGqRJFN1mfoYqOMf97ELbYEj+b62+bTCyga4Oy
         l4DjTwTKB25sB3TkFft8dFQe+UX7OJ/OBcu/JgFO2Fng1W8/LIegIZDVeJIgRs3+V4Da
         q1xn7bHkS6p5aFOwipkHbk4nVnZlg9hTQQUOtyzaQSFcd5jiy1on8eITLU18PChKCLI+
         7abw==
X-Forwarded-Encrypted: i=1; AJvYcCVRqz1mq+tyL21BHUhICoHErOvtphYlYHAl2DgxsZy/rFV9vagf7vYkGu4GpcPc6SK0iB4cuEcxG86Y0Zw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKarAy/TCuJDFtQop76bk4cFq+vndrBq0x3G90FMD5qI58ZrYW
	iHh+I/otMCHYHwn45IFAFwrlfJYLuwfkjd1+NnUXphJb6Ji81ELRZfJtnE630qIv33YouLZX5ja
	xLfNq6aPHBVPXT6DUlCGnCyf0fYEN47oYSaYo0yoP1w==
X-Gm-Gg: ASbGncup9pmEox87+9h+WabWgvrH1E4B/LMDUqsofbmBd115aDCBh0kd4Kpf8erUuuW
	ANu6Z/cpqGzmDtvpsmrQNepVkz0CQUYYZxOE6J5uoKKC9YqVuwEMHG62caTc5C58B0cXurDC9ks
	HGfEd+nDXTtPKb/ct3eeI3cYwg9TA59AyEa25hPb87lAxrRXOmPyfB7TkW9QF3kAAuogCYpJLfR
	Ft/Rw==
X-Google-Smtp-Source: AGHT+IGnzlI20hD81QuCUxmiLx/CLn49uqNE3sl8frDh4fjPDY8YZMBAvQbF0rOj2AAQybUTZBlLQymUJBEgeOnVx3g=
X-Received: by 2002:a05:620a:4053:b0:7f4:5aba:d966 with SMTP id
 af79cd13be357-7f45abadb98mr1590732385a.60.1756480586040; Fri, 29 Aug 2025
 08:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825-rk3588-hdmi-cec-v3-0-95324fb22592@collabora.com> <20250825-rk3588-hdmi-cec-v3-1-95324fb22592@collabora.com>
In-Reply-To: <20250825-rk3588-hdmi-cec-v3-1-95324fb22592@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Fri, 29 Aug 2025 17:16:14 +0200
X-Gm-Features: Ac12FXzpMvL7DIJopMIso2mzGRacTGimE8ocHlW5RhJ-2PuaDc4LbG8M9GuvEHk
Message-ID: <CAPj87rN7gHj2jyAa20hJXHscauupUcEzYxfgH8-9ykuVcETOpQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] drm/bridge: dw-hdmi-qp: Add CEC support
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Sandy Huang <hjc@rock-chips.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
	Andy Yan <andy.yan@rock-chips.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, kernel@collabora.com, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Algea Cao <algea.cao@rock-chips.com>, 
	Derek Foreman <derek.foreman@collabora.com>
Content-Type: text/plain; charset="UTF-8"

Hi Cristian,

On Mon, 25 Aug 2025 at 10:57, Cristian Ciocaltea
<cristian.ciocaltea@collabora.com> wrote:

> +static int dw_hdmi_qp_cec_init(struct drm_bridge *bridge,
> +                              struct drm_connector *connector)
> +{
> +       struct dw_hdmi_qp *hdmi = dw_hdmi_qp_from_bridge(bridge);
> +       struct dw_hdmi_qp_cec *cec = hdmi->cec;
> +       int ret;
> +
> +       if (cec->irq < 0) {
> +               dev_err(hdmi->dev, "Invalid cec irq: %d\n", cec->irq);
> +               return -EINVAL;
> +       }

There is a bisect break here until patch 4/6 as nothing provides the
CEC IRQ, so the whole connector init will fail.

You should either plumb the IRQ through first, or just make it
optional to retain compatibility.

Cheers,
Daniel

