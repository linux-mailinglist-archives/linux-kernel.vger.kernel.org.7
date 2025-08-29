Return-Path: <linux-kernel+bounces-792173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A8AB3C10E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 18:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06EF27BD0FD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 16:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523CC334369;
	Fri, 29 Aug 2025 16:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Su4J5oEv"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3524633471D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485654; cv=none; b=TdKEc3UqLdKY9d65rfdxhnzk9vvfruLXqltkbRneNr3uwv24BIuwhL1EaVZ2SYbMQEIliHU0lyCIbUenlXAFTSIWrp3A3juP/6ut+DUYJPakUjh4H7yvf7jUjni9D7l4cZx3P42ybcrEByeEA3vqJCJ1AbPiFRHSMtm+7yN5OMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485654; c=relaxed/simple;
	bh=zOCXE1DubQ5HAVT08S9Rmw5blwEjk22sY+lTtRHgL4I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JXLRTd4O6Wfrf1wgT21kGHIuwCyg+HmzaqyF4WWSOjMuj/otAaI5b6cYXyY0pYQ6fZRcckg/Lfhv3TvI3eXQLz81Qee49QLdLUVpj8dES/nuYjDtIoM1/j9Ys1g2bM81U0xe/UeXDUsZD8GxfyUwIFp1q0QtbzckBMafCo5Emy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Su4J5oEv; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4c6fee41c9so1539294a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1756485647; x=1757090447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fz4tksacw/4xBuqyAP2+l68JOuUmAfZLQKxwsqSVUE=;
        b=Su4J5oEvnvCoUt+66WpS7QeMyGm6xMrSoP8onYwHhjXt8HekYtIukBmrhNnTEsjhlS
         vvWGoVhbrQRVeiZrqJ69dnXcbu4ssPjCCN7PF70IHtd0gYWX1A9IPMTaiM16Jiw9tiBd
         eiGu5ExZqDFbMXZ3X8lFTFLYgz1Z5+5wEzA84=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756485647; x=1757090447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fz4tksacw/4xBuqyAP2+l68JOuUmAfZLQKxwsqSVUE=;
        b=j1ubTi/c7DaaGmLMH7sawIUw0nYkWj6ecwVjQ66Wmj4NcMIVqZQUnx42uDfO/k3527
         dy2liYNMcR4/KBGHGtvE1apPcimdQxHRBhFJ3TkQNNY9BFw++wEyfNafABp443OVG7I4
         6wcb5Xc6GndOLdfdDFbZ2zKd/nsuSQ0rjw2CJO1HH9kkeo0ebOcdb1JHRiA3ft4cJcmw
         3es+lX3BXce2lhNjdPYBSz1W6ha3qXdqyufd++qGI8jLY/kcv6H2cP5p3llWvguupm+D
         aYtzqvDWlstgOBWIVZZ6qL6sOxwPWvpUiLcGLc4tY7EO25+TAP1/LKN4oyW89+Gw3/wv
         0Kww==
X-Forwarded-Encrypted: i=1; AJvYcCVVXI1eJT56ymMA8+00mauKehkdfxAETqbpqDQ8A8ZeOIA6pzrfI5UMJ8+fvs2smtAyQfHX6XbkbGBcpZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2gumfgNy8M9N1OJyMu5MCfTCtNyIUUTaVbNHj8GzPtzKibrOA
	lcFAAJ4p9Qw1QMvX9COOTNtUXbatAw/OFyVhVQdZ8LbMdz4uztzKAlxwRqrjDtG43lcv2TVfw3J
	6Iyk=
X-Gm-Gg: ASbGncuebGQ+Rido/i/NfqsJvj4P1W0WP4pKQ65RWuFzXwU2e9iHOn9n8i7jpx/yR1M
	w9VYCD1Uw5HuB+InAdMi7R7apF9LQTyyFcLo3oDQ9dFwNbo2/1jNNNY02E9+yzItcvVXtYzqXZV
	QPB4aycz7BllL3BjqABfaqa+EZ0oRHOYO/BbMZrPgsSILQqE7X9pgDtdlrfyiDDhDHCcOhJ1U9M
	pwtvSyPA/zIS9rfNgZPzr6rFmJ6Kx9jzOs8mfaOAdNPhPCh0Fl46VZDuSkuvS+AApRXnQDTkHdl
	WXVb37kk2pt/7GreQVdbSr85fQSUJtw7xZwoFEVUTR8T2yg6M4VvvPp25ZqcPKkdH45Vk0DI6lY
	+SvrSuON5q0eQ05zIiSeqUYF63QX+VUvuxRVMCsYKtHJIrQav1Z1BGDbklNIqSH7l6xvQCgTtvq
	Rr
X-Google-Smtp-Source: AGHT+IFM3HpVL3H9S3ILSNrNPZDme+cVuhLyWDRNtk0LL3Oj3RFjU9oQRt9in2cJVbP8bXwnDMTkWQ==
X-Received: by 2002:a17:903:3546:b0:246:d703:cf83 with SMTP id d9443c01a7336-246d703e19fmr278689155ad.17.1756485647523;
        Fri, 29 Aug 2025 09:40:47 -0700 (PDT)
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com. [209.85.215.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249037023b0sm30106405ad.10.2025.08.29.09.40.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:40:43 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b4df220483fso162201a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:40:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU+EdLQSSS8fnQOn7ypNaCgdAMDRgqzih/PLUZCncBgo3rLUQjlUEU16r2J9aSdhz9fc/0vUXxt+Ix7cfA=@vger.kernel.org
X-Received: by 2002:a17:902:d2d0:b0:249:3027:bdbb with SMTP id
 d9443c01a7336-249302838c0mr15491195ad.0.1756485642821; Fri, 29 Aug 2025
 09:40:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250820152407.2788495-1-john.ripple@keysight.com> <20250820152407.2788495-2-john.ripple@keysight.com>
In-Reply-To: <20250820152407.2788495-2-john.ripple@keysight.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 29 Aug 2025 09:40:30 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VfCWFViDE1a5-_KtH0Pfo2EnCJeo2k8MaWuRHhmMPMMA@mail.gmail.com>
X-Gm-Features: Ac12FXzH9d02U9lFxI5VRyuDKW_pjuvPCwYTO6NavU-RzNP2_mnL2seCn59eOxw
Message-ID: <CAD=FV=VfCWFViDE1a5-_KtH0Pfo2EnCJeo2k8MaWuRHhmMPMMA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/bridge: ti-sn65dsi86: break probe dependency loop
To: John Ripple <john.ripple@keysight.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, Laurent.pinchart@ideasonboard.com, 
	jonas@kwiboo.se, jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 20, 2025 at 8:24=E2=80=AFAM John Ripple <john.ripple@keysight.c=
om> wrote:
>
> The commit c3b75d4734cb ("drm/bridge: sn65dsi86: Register and attach our
> DSI device at probe") was intended to prevent probe ordering issues and
> created the ti_sn_attach_host function.
>
> In practice, I found the following when using the nwl-dsi driver:
>  - ti_sn_bridge_probe happens and it adds the i2c bridge. Then
>    ti_sn_attach_host runs (in the ti_sn_bridge_probe function) and fails =
to
>    find the dsi host which then returns to ti_sn_bridge_probe and removes
>    the i2c bridge because of the failure.
>  - The nwl_dsi_probe then runs and adds dsi host to the host list and the=
n
>    looks for the i2c bridge, which is now gone, so it fails. This loop
>    continues for the entire boot sequence.

Which i2c bridge are you talking about? You mean the one created by
i2c_add_adapter() in drm_dp_aux_register()? I guess I'm confused about
why the DSI probe routine would even be looking for that adapter.

In any case, I don't _think_ your patch is valid. Specifically, if you
notice ti_sn_attach_host() can return "-EPROBE_DEFER". That's a valid
error code to return from a probe routine but I don't think it's a
valid error code to return from a bridge attach function, is it?

