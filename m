Return-Path: <linux-kernel+bounces-819594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A49F2B5A382
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06CC92A77E5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C883283145;
	Tue, 16 Sep 2025 21:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj4HcfEa"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B64131BCBE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056614; cv=none; b=Ns3kB3Gr7PVK4eTyRblHc7DanM61Xz58ll94yWQLSmO7F4pXCvctAE8lfveNkQlxKwUNeoETy7hgA9nux5NHYrYLEUb5t5v6bwPxWXivzMKQ1E1M00Vl7VinOtoMyKVCPZBo10emsbYAmqXxoOMib4jC1MSTEVwhRgBHMRyqo68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056614; c=relaxed/simple;
	bh=Hv7Vr+4DmF1NAynwqYk0R8yOmTu+jrbIsDyVpEsF+QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XeM+mcIkO/Z5KJbuUi1RGco54pNBx+ZROpVgSy35fGPRq1YERlkrXIEnbBz6uyC9wHfM9t8ZJlIvNnpcFYbUfd8cV+OxpLteGUX6GBZnlCJOcqdTpKwqh+B81QqD9cVm2TDhqssd9z8upt4Cw1Gb8LE/YxRxFS1oF081kicKo1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj4HcfEa; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-8a967f3a873so1725809241.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758056612; x=1758661412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0dXITVgbCSbxBrfxo6QtCTx6YlY24kmhjJHsjw5K1k=;
        b=hj4HcfEaXOvVG0vNntMttS0ksfjViIyajT5xkMo1GV89Kkg98A6sf6mSyEqgDfDAyA
         9pdQhswmT9wWGr2+gjKJT/0ywVRCE8bJoEX5lZHO6lhqn8EFM/UaD3AEU2eiSmuGc3L3
         dVclXaFhQfzxkOqZTYuym5F867eYIgPrCrM4gf8LVSfH20+B/NkVz4YOWX1MxHA+yyWi
         YHmoRYuWn/AeMlVk/hoAGEDr9lX0I7Jv03ElCX+gtYItBboLe216Qyuc0H645Gg6NGQQ
         jKn+5WwH4QUe3ZNYJ4ma/pIvtk7KrcB87m1UAJqSDMKwnBh7V90X2S9MINt6TQnqvJIc
         XG5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056612; x=1758661412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E0dXITVgbCSbxBrfxo6QtCTx6YlY24kmhjJHsjw5K1k=;
        b=gBookEG9+UsVPZfjOihYUhR7W83kuM4H6ZmLarpDttvlUjVSU1I4vphoQ+CRMJRem6
         qhWm4+SpQDMXprOVgQI0UycjU7N33Q/WFhEMBg3RBJ7TAkmjXfbkCJImQOojKVTyuFF7
         w3KPRAi+m8JKQ8hSiO18vmN4zg1d/GLtQiGYOjWGKheBwEHJRmKefOdNAyYaJBS5oncY
         W1RUJXsbndUOuVfarpbs6NPs4D0FNK/OlYRWc9uuth0Z9h5HfK3VM9gVnpx3U20IfKcZ
         XukTk3D4V9G3Lvn5XaK5eXlTv9ZqLp0tITva4+k09du4aN/XSQtXNGvfQ2ym4xudnlsr
         zzLA==
X-Forwarded-Encrypted: i=1; AJvYcCWLG84RJGeQMFlRy/Asyk2KELLQSc1vtJ72gZAuKBm9kblioYe53uYcNnRMqCfe3chl1ZzOSJH3WnMXhSU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi3gnMnyORDBkErU4BWZhvaIZHIPEdodJgvcVR0ApbGaxAXTfR
	4Dw0JvLzFdqPc7wBjc5gRGoAffNM57mfuOQNa/PfDwE1Z+IY1KVqKsqCRDGf5iHzMVq7UBFO6vq
	n4Pyq3csVRolS/Hf+NSXZlA+yUw/xTjk=
X-Gm-Gg: ASbGncvkuehlXSB4q5G5UznMs5edRXh6sxCWPNHvj7IPNbJOcYXvm8tusKvM03ChwKp
	bGcUKse5PZW8AefaCWhr5BUNpnT0Jvo8Ei5X8sKh95lyzNFfLtp4qxqblLwjJbUwc/0Nt7Jsusw
	MtdQuRjOhZlCbTyFPgVFngOHjISuwesHxeamtL8dW/agkJYIsIT0VRp8rSH2rJ2dkwIK5mVPDNY
	mOo/2502w9+BqcMzCH0Nq/Q2jgClg==
X-Google-Smtp-Source: AGHT+IFQtjDJJdg2xNwseUwhQKihM75rYX5/lCi3hKIPAIZQBMmRrQBLb8fGXO8jJX1XhSuHopiQoo6saypXCd3uzMM=
X-Received: by 2002:a05:6122:8cd:b0:53f:e51a:9a4b with SMTP id
 71dfb90a1353d-54a16cc2c38mr5877681e0c.10.1758056612104; Tue, 16 Sep 2025
 14:03:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-chuwi-panel-quirk-v1-1-ec5c6aa5a663@gmail.com>
In-Reply-To: <20250916-chuwi-panel-quirk-v1-1-ec5c6aa5a663@gmail.com>
From: Brett Mastbergen <brett.mastbergen@gmail.com>
Date: Tue, 16 Sep 2025 17:03:21 -0400
X-Gm-Features: AS18NWBeu3sYs4iEYelY4vI74bfAl6r_9rqmoGBXDaecCR4uSp61RCjbC0Dv8NU
Message-ID: <CAOcC6hK++jyPGhTww1CjF+Kf_d_WN3-odDuuHcRzU6z6-YwkeA@mail.gmail.com>
Subject: Re: [PATCH] drm: panel-orientation-quirks: Add quirk for Chuwi
 MiniBook X
To: brett.mastbergen@gmail.com
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:25=E2=80=AFPM Brett Mastbergen via B4 Relay
<devnull+brett.mastbergen.gmail.com@kernel.org> wrote:
>
> From: Brett Mastbergen <brett.mastbergen@gmail.com>
>
> This adds a DMI orientation quirk for the Chuwi MiniBook X which
> has a display mounted 90 degrees rotated.
>
> Signed-off-by: Brett Mastbergen <brett.mastbergen@gmail.com>
> ---
>  drivers/gpu/drm/drm_panel_orientation_quirks.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
Ah, I see a similar patch was sent for this device about a month ago.
Only difference is I look for the exact vendor string.  Take whichever
is preferable.
https://lore.kernel.org/dri-devel/20250809111200.10086-1-iburaky.dev@gmail.=
com/

Thanks!

