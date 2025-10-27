Return-Path: <linux-kernel+bounces-872190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC43C0F7E0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 17:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9CE819A3945
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 16:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3D5311C27;
	Mon, 27 Oct 2025 16:59:22 +0000 (UTC)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575E4302153
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 16:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761584362; cv=none; b=pETiYCPKR+jPCq1gkypN9Wp+mYWyPUjpO29HZv/W9ddEWTqgm7bKXWNGBv/r1QQucYJrmf5Eo+Hh5mco3+UCqzvBpL6ODsDpAOe30mwADOIVwGIzOXClHD8n8iOfKQS1TrhGtCc+LZENVcAVV3SBmKesMZOOSCLPypOBeRCOhwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761584362; c=relaxed/simple;
	bh=iyqxH4hxbPgxvQElXkdgiIeZ0ywNFegx6MYkB5gAcoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QDWhjIeDAIJLPyocXtw5AT5hWy0J4NHPSB95R6orVHu/x6jqspn5h8j1GhZTbEfunfv6+1Fv7AcKURlIRczPtnZsHBLtZuR3p/pJ1lQ/vn/7ftGLt1Dkssuu5Ux6GtWdlufoY9zl4bWiTXmBzY2QAwWEGKy/RcOjlx+klnN87uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-378e622e9e3so43394281fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:59:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761584358; x=1762189158;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iyqxH4hxbPgxvQElXkdgiIeZ0ywNFegx6MYkB5gAcoA=;
        b=NQBS8LaOjWj8A3dKJilIxawNOYy0wt/V6EW3IEisDZ86D3T5MbWW86kVpNfBhGHs9j
         8avb23Hi+hQwF2g2keICQfQwNKa/B5l+CaAm1EEATm4rek7ZczuDUs0xU97HVxhVt3Mv
         XknLJ1Zrk7l7suwyNkVUjHSkK4nN4ljBC0EWpGjk4H+JiOaNzTQcpaxcAdj3UURbyEfR
         C1etiZhdNOnowlD4FiolmDpj0pjSwcRlU3AtmOvda8OZkfNjJF4NfiTn/OmojvjDDfoh
         GiwIv+L3Gt+AGpFfj08bUT86opqkb52As/IG/Om4DuaOqTn7xEviiAuREdMMGruZIZsk
         U4KA==
X-Forwarded-Encrypted: i=1; AJvYcCWkbm3f5xrHZq+0uSunCPNP+BHVx+JdYjZgtesTjc2fjswhYibz3uqVzHC/jrGMDTBK9FISwC0xmaTG1do=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZIYs30VkNKeRN4Q934x6PJ+BdejsJCUALo+VOKAAyElXANkuA
	yEYq8J5WMtsdREP2/TEcA1uCcvYi/0K5NUGsQHCwGGH6TaIaut3BagItGb1bh3ReGns=
X-Gm-Gg: ASbGncs/hqR0t9iHoV2gP6GYyMxWy1IR0QY87y4Jd6tvwxiSqSd14ktFtagcuckCUzO
	f7+ifh+XQrvdO+3oaBcfcvqt4dP3rMP/d5EZb+CyBn/ZseQ/MaL3rcMiUXp4hLW/lGrPVAk2Ql2
	E2DoX7i4bB9MbFbWZit/eA2h97Vq27tP4hzyNZL8dMeZI6k50wbQ0CfOH9yd66i1Qo5sTTHfORa
	zAeVwnueppeG2TaEo+zTR+sWOv07tHUQPr8fI9TRrTrYOeI2AtU9ViVLjbYGWIYALXvurgveUQO
	QAo0lcZnhjkwYGwDw06MpY86+1gKH4JaXfO1N72QyPgfzN/dOrtbzuUsQuQFAKvtkrv9vT2e6ea
	WUXey53nzE2tS6Nwh1wEQ0j1aXks07Cek4xBcnucyjdgJbKN4gw+fQ0SwMv2muukxnL/ornohVT
	U9jTbPrYqamkCbmh38l5gIf8ZBbwpFiEAQjycPnLjfdX8=
X-Google-Smtp-Source: AGHT+IF0Wv1TUZsy+6omTUSEC+A89szqe4sZiuTFPDns3Lx68543EwRRTGzU5F90uXHUxCfVPuvimw==
X-Received: by 2002:a2e:a917:0:b0:377:c556:68b7 with SMTP id 38308e7fff4ca-37907c99b06mr659401fa.17.1761584357570;
        Mon, 27 Oct 2025 09:59:17 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-378ee09cc0fsm22162211fa.12.2025.10.27.09.59.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 09:59:17 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-378d61ce75aso45378231fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 09:59:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUdATk95gB60t4h5V194yxLX/ZJp3C1NafjFMbZbjZGcyH6UY34aOk3JuOOYteNkwddaQaYJPhaeRcYIqI=@vger.kernel.org
X-Received: by 2002:a05:651c:19ab:b0:378:e912:74b0 with SMTP id
 38308e7fff4ca-37907ced9d2mr462481fa.23.1761584357146; Mon, 27 Oct 2025
 09:59:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-15-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-15-jernej.skrabec@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Tue, 28 Oct 2025 00:59:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v67tF5f-dgqXMZFbSMbctmpkM0mZGYVAA2gyOx-GY1cSbw@mail.gmail.com>
X-Gm-Features: AWmQ_bl-KpqEJmmAdB5ZTKNvkIm9zEnVpIzMtZYC06hw3Dn_VXdqxOKWZ6n-OCc
Message-ID: <CAGb2v67tF5f-dgqXMZFbSMbctmpkM0mZGYVAA2gyOx-GY1cSbw@mail.gmail.com>
Subject: Re: [PATCH 14/30] drm/sun4i: ui_layer: Change index meaning
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:24=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> In the pursuit of making UI/VI layer code independent of DE version,
> change meaning of UI index to index of the plane within mixer. DE33 can
> split amount of VI and UI planes between multiple mixer in whatever way
> it deems acceptable, so simple calculation VI num + UI index won't be
> meaningful anymore.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@kernel.org>

