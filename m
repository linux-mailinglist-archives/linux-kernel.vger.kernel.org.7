Return-Path: <linux-kernel+bounces-877944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 37598C1F677
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 680484E6035
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E75C34D915;
	Thu, 30 Oct 2025 09:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u2xhgvTo"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7F037A3D9
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761818292; cv=none; b=o7lwldC0Twc/BYWg+QyfH93W7ZznGu/0OxC5GYdbbO+r2kYtJ3dKs2ow7ffv6Xjbmtnm4aSChD3lXwk9Oj/NG1wWIkixsDRnGGSwbDuTo/6D34ptFXVh9VEqPZEQGUIz3awr6RbsL07/GEeG2ARIlFJkiYqmDyz5IGTM6NH6Ok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761818292; c=relaxed/simple;
	bh=vEuMI4/ON3NZyuWh5rcNsxAt6a2t5pFcXOevn3lKjV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=frQSsWK9nbkOopW54Q7saiZwGTQr3EWhq/xbUalIF2UDBLrw+5Dob5HhYZ3yTWGc/Tb5lxfUgI6qRQGE7DgYMTE6glK85iQUW8mSKgPT+nK8Q81LelWL8kavOLV5SLwb8kcd4wUi8riXUv1ILY926Ehv3bSZmnQ7bE2PRiCu75s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com; spf=pass smtp.mailfrom=compal.corp-partner.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u2xhgvTo; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=compal.corp-partner.google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=compal.corp-partner.google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-880255e7e4aso1647056d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761818290; x=1762423090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEL7UWndy/pGNe3nAwOeMI48IY8s4YpyPq3MFk8WULY=;
        b=u2xhgvTo5Enn2PlOjlseXlAmFaiF6EZsspS3mu3Y2pN+chI0mpnbGZXH8UnxleXNFP
         Bd7htzw6djgnOF1XaGzbdkPwwAHykqP6asbQa3MUktUUNHskzTh0HliY4eKtNc8AREze
         jseZWWc6yI94LQ44yJqrin/tV87IO346OW8LB2hX7W2eTpFNprXocYVmGleDs1OxaYr/
         +VCy+gsuHQd5vTF63/cP4YdODdkIr/psduWRU2fM0ED1STLZXT/L8m6RVUCecMg37kny
         yZWJQFZawIplUDMLCh8kAYcdfoeL201mQRrGFs5TnomxD8nH+fQTQiRmaYzHn5tcOi67
         J9Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761818290; x=1762423090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEL7UWndy/pGNe3nAwOeMI48IY8s4YpyPq3MFk8WULY=;
        b=RWpyGuUjy6YvOpyKcBVxTQZNZu1TdmiofWsim+E/hnJr79vZrMe3npcVTe+t8Wno3x
         x0gwvljkfVAZxuIY1X9S5pR0VPj5xJz/EuXGmWX9g9+kyIba4QK6nwhoIQeJrRpdRlAO
         dBsNjyf1xpi8CvfbqaOTofGOf2aygmYkEQRDnE6bd2s3jB/FCwGlhaUUgHYnFyiNLA5q
         6ZrrU7fksSDjr0oWLyhh0LXd5n9xqFNIxXad3YRaIyx+pVa3/AFheoLahbyfPfUYl7ml
         4XokVn0SvUjn4iaXvDyXHUW2su8Mk5xJpEMKD1SrKqguERd0n1AnbaIcmfzYujbK8CYZ
         C4dQ==
X-Gm-Message-State: AOJu0Yz+SewtRRRv5IRKXS2hBDEgtBeLxkB3F9Qh/CsLJRa6NFV3xA59
	6D/TF07QR0//cY8H9zsDQb2J1tAZSgfo/E6W76fCJ318DmPFNSRRBferN2wtRoSKS6mi8O6c6F6
	rcqqY0+lKYSllE9Xxt9xcELr5i0bsVm/eIIUwDMFY3Wx0qy/E8Jr44NE2OX+I
X-Gm-Gg: ASbGncvU8Awya1s0WJgStAoiZ64b3ZJkKbeLCJ4sYCbIBHsvH+UdG1YinHpushwoIV4
	jkp8oRuXM+3GoTggplKNPdzXLfEau/+UUSdudLKHNmfppe0QHatDX2z/K+TE1HOCTufGkdzb1u4
	B/RTzdX6efMXTL+2Zfjzmk5wkPaHyJuMWs1NvCu6AVLMmgPQ/tudLArALU4VO/EOw4mTH++e3jJ
	hHJVCNCuqRDlRlqURQ6h2qqpVIIV70JHCCFuAl89YZQGfPl3r9sVzUktUJDSA==
X-Google-Smtp-Source: AGHT+IHIsI+4/h6KAHaH2OWaQbqcbxRUmhlsknjp7KUacPPetetFpCZtsE+4lda40dB4ndnWBIwuBhhs7osXnHSczJc=
X-Received: by 2002:a05:6214:2e47:b0:880:1b8a:9917 with SMTP id
 6a1803df08f44-8801b8aa667mr29220446d6.18.1761818289961; Thu, 30 Oct 2025
 02:58:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029081048.162374-1-ajye_huang@compal.corp-partner.google.com>
 <20251029081048.162374-3-ajye_huang@compal.corp-partner.google.com> <CAD=FV=WbR0u_a7S1pcL-6C+sj9Kt=GOLUwJmwt8ANJbyV4JYFQ@mail.gmail.com>
In-Reply-To: <CAD=FV=WbR0u_a7S1pcL-6C+sj9Kt=GOLUwJmwt8ANJbyV4JYFQ@mail.gmail.com>
From: Ajye Huang <ajye_huang@compal.corp-partner.google.com>
Date: Thu, 30 Oct 2025 17:57:59 +0800
X-Gm-Features: AWmQ_blMVCc12qswU2ebRXhGRocvvLNHUm_Z5F-w-j6Nwq4rqm49JiPQdsIsUzI
Message-ID: <CALprXBb=_HuwskwFP0nRKH=3zwoGbig4fWY+Q4g53Jhn985TsA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] drm/panel-edp: Modify LQ116M1JW10 panel's bpc to 6
To: Doug Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <jesszhan0024@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, jazhan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Doug,

On Thu, Oct 30, 2025 at 7:25=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:

>
> Unless folks end up preferring EDID_QUIRK_FORCE_6BPC:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

After following your suggestion with the following, the issue goes
away during YouTube playback.
I will send a new patch for drm_edid.c, thank you so much

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index e2e85345aa9a..a73d37fe7ea1 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -250,6 +250,9 @@ static const struct edid_quirk {
     EDID_QUIRK('S', 'V', 'R', 0x1019, BIT(EDID_QUIRK_NON_DESKTOP)),
     EDID_QUIRK('A', 'U', 'O', 0x1111, BIT(EDID_QUIRK_NON_DESKTOP)),

+    /* LQ116M1JW10 displays noise when 8 bpc, but display fine as 6 bpc */
+    EDID_QUIRK('S', 'H', 'P', 0x154c, EDID_QUIRK_FORCE_6BPC),
+
     /*
      * @drm_edid_internal_quirk entries end here, following with the
      * @drm_edid_quirk entries.

