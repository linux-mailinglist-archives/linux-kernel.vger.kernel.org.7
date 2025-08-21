Return-Path: <linux-kernel+bounces-780069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E646DB2FD19
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:43:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D216B00482
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348BF239E69;
	Thu, 21 Aug 2025 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gsHB2Rdv"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC7414AD2D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 14:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786993; cv=none; b=Hop8xYB5kaRBlQSxYWyi6pUDaRFH1S9a60Ayba4iKdN1UlJm1yIX88NquP1OwnSfndBlBcCbUbMnhnFYC+iUGkwbufOXN4zYv4XITN9uOlQkaQ4pq8CA2UVcJtslLOV63ritea+yIv0XsNdyxgEKKcNtpkxA6gVYnF90DDzPRnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786993; c=relaxed/simple;
	bh=K8cmv9czLeVlg58F3GSNDuhb/BDPEleBjhB2Fb2fPFo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouoZdcpfhl6+nm4ect8NSgMEoCTrsO7HQdrARP5KhuAKmhGTQvDt+uPh6BVMBvg6WtkYrfew8fjQcVFFuC/Rx4hHfQL0M12QCaPqkH4HGomGVhp2FVyoFhRTuLlc09K+13giqvIq+lmZpJQu5kY78Stmm015EEFzveoojWoqTho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gsHB2Rdv; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so1093286b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755786988; x=1756391788; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8cmv9czLeVlg58F3GSNDuhb/BDPEleBjhB2Fb2fPFo=;
        b=gsHB2RdvF03lE7vz/4QoEpqPCslgEtxxRxR5F1UpsuMr6fQ8Kfxd1LluoXgIOsYDpV
         qywfd6782eUBYbX2q3vRua2B513+nxWVhJvFwEbm7iNcRF1kMSJcyfnCg3vF8wcHJESI
         ZUlqmX6EonggHIbzdhJZ71InpVqdZu2MdtaBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755786988; x=1756391788;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8cmv9czLeVlg58F3GSNDuhb/BDPEleBjhB2Fb2fPFo=;
        b=Y+TB+7Z5Yzfy8H4UgCW+JxNbagW8OV2cqw0fvW9aB7aQGmwNzW1OyJxIdlOse8SyH6
         AMhxqJJF8RvCi7HdVgiNdULDQibt4zPn8vjHrUC0KQgTj/aoz5nwwFASYmRhl4g4kTa8
         SY9anx2anm3aRz1pYg60vraD8HIf4Hiz2klqp2gmN9N1+yNOdE/RCMEOg2aMeHznS0Zd
         8J4T/ropcnuhkW9Ki3OKHCtzQUac8/bCuR9xqzzoAkhYCHOkaA2xb4AHLNgAhl8rCpwO
         PRONF3+z9+HnRkNr1aW1BiT635pjpA4UtS0UmkBYgfd1Wueg3arN+A4kbVMlFyyBuBpm
         IFFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUaeOPTlKp89521JyHNHcS416Bo+KjcgZJBa3JRSosENx3YTdi8VCJV+MqKLMb5wBjYb8TsGnkBi+r4Whg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYKVCaO8+2tVVbFgNvMomI+BSwz/zgJ5b94P2nAZniJvaqPDjr
	0TGoCnBiNLDg4HyAdJUuywUALwbS5KgSjpFReAlc31gADTKH8QLot9uD6cgK6lsnpkebxCzNj2C
	PjtxgZg==
X-Gm-Gg: ASbGncsEzI4WsWPf5yTS8JNshbnFjy7d6Dbsz/Z6KCqEoNoCanTlabpoBuQABLza3VB
	Cgu5oWj1tC1VxKGyGiETJLzAaeDtqH/rL8ETISozUWRpDVklfiou5Ki5FQmu5V2Ik/vZe8CgUds
	Sp1jar+2C1gTNQduuZQLiGz1wxB13NIJwL0XBWkljjdxwL1d01K58PsyGV0uTMUJp82aNKxWZ4S
	72+yEnbB10lSad3u5Rs/8DF3vdoR0IIqhCkplAL14gsPX7bkjBt89F7bNb6AvwwEj9cFaZM2vX8
	jVy0dPsTdPhlRe0GV+fqXGD0I7VDrKeOAY2Ba+Kpe6nS0g6VgqNy/T7y0CQDNC/kfelTZPP/1zs
	KMFnXQ4z3am7ly3stDv8BEo3gvfc8JAltwcV82y2/Mt6kO9ciWxAnSHViNE43yPgEj3yduV1sNV
	qw
X-Google-Smtp-Source: AGHT+IFris/4LeqkPt6E8kGHPBPhNLv2GmJ8VdVHYx8bghRtr9Ve84Nsnhxf3LNLCT7EAxszCL2gNQ==
X-Received: by 2002:a05:6a20:42a3:b0:243:78a:82a3 with SMTP id adf61e73a8af0-24330b9389emr3965536637.60.1755786988337;
        Thu, 21 Aug 2025 07:36:28 -0700 (PDT)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com. [209.85.215.180])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d22b8sm8646968b3a.4.2025.08.21.07.36.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Aug 2025 07:36:27 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4761f281a7so705694a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 07:36:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWr/Hh0y6P/RGeaJQZxo5kDK4Qj0kXczvWsOLsXsn/bb9RHpHayxt9s8Jef0T8WvvYClrF5G4IX8Gpa8g8=@vger.kernel.org
X-Received: by 2002:a17:902:e552:b0:23f:d8e4:ded2 with SMTP id
 d9443c01a7336-245ff874a23mr34912575ad.53.1755786986016; Thu, 21 Aug 2025
 07:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821122341.1257286-1-mwalle@kernel.org>
In-Reply-To: <20250821122341.1257286-1-mwalle@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 21 Aug 2025 07:36:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xt-DPHRddZM=t-KTWiGouNfm_QpPps3MA6csd+j=YO+A@mail.gmail.com>
X-Gm-Features: Ac12FXz0PEJ45hqfCs9LuKR4ewCkPpjYJIMIE3QF_A72fNR8_xEf-0dzYkP_9Kw
Message-ID: <CAD=FV=Xt-DPHRddZM=t-KTWiGouNfm_QpPps3MA6csd+j=YO+A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: ti-sn65dsi86: fix REFCLK setting
To: Michael Walle <mwalle@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Jayesh Choudhary <j-choudhary@ti.com>, Devarsh Thakkar <devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Aug 21, 2025 at 5:23=E2=80=AFAM Michael Walle <mwalle@kernel.org> w=
rote:
>
> The bridge has three bootstrap pins which are sampled to determine the
> frequency of the external reference clock. The driver will also
> (over)write that setting. But it seems this is racy after the bridge is
> enabled. It was observed that although the driver write the correct
> value (by sniffing on the I2C bus), the register has the wrong value.
> The datasheet states that the GPIO lines have to be stable for at least
> 5us after asserting the EN signal. Thus, there seems to be some logic
> which samples the GPIO lines and this logic appears to overwrite the
> register value which was set by the driver. Waiting 20us after
> asserting the EN line resolves this issue.
>
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

nit: officially you're supposed to move your Signed-off-by all the way
at the bottom of all the other tags any time you post a patch. I don't
think it's important enough to re-send, though.

In any case, thanks for re-posting. I guess it kinda stagnated. I'll
give this another week on the list and then plan to apply to
drm-misc-fixes unless there are any other comments.

-Doug

