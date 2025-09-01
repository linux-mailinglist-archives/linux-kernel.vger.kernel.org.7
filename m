Return-Path: <linux-kernel+bounces-794060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5FCB3DC48
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C7C3BFCF9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 08:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04AA32F362B;
	Mon,  1 Sep 2025 08:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dz8uyAzg"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EEA2ED868
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756714999; cv=none; b=MBlpMhd8+S6hJgjzRa4YoqoPWj5M97igbaIN+7eTiOgZroQ23NF9hdvKGj1dO4iPbZQCWUTmb3BEV1rcx/Xxo6QvVS465cPq8MtKoSR+Ab1uiSPdsypzVK5bZ6h18+23AeSwbq+op/7R03KMHlnedDH9EhYiIkA5OXWGMnLRqoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756714999; c=relaxed/simple;
	bh=1GRc8xrxN9zGX5wz5BhvKOO2j5zrzx4fFnKG/lVnDdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J8cb4qLXhrNTEVCHF7TJEIJSB2I4nhSSm2olwqWV+Vvr350zT6SJYhIfNPL/Md2JTbGPnEJ6SeRXOW9sZyvJUHrAtyoJNmqQn6e/jX9iNBJjgH56Z9c2Evw977OrPWH9eQSqeOaKBTZXdrcDvD5oDOoCq2IpDnA/ula63RgIyyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dz8uyAzg; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-55f6aef1a7dso2422508e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 01:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756714995; x=1757319795; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6bOX31TOnXa3mSpUgWZIksoOSQJIo6oigebcMiGpVk=;
        b=Dz8uyAzgarZvRBDqWWnP+o0U86ka5hRrkwgV0NlTvB1H4KaavPr9OXtifRWGyBpZhd
         4RTS1Ii3q9rZPzEXv7pjrIuX0WiyIwNmB0j8UYGYKgzC0kYLccqV3fHDCbNXMZDtQjmo
         gQiwpG28ZWd1RO5BUKErdyIHmeplvRsTKAfX4KMeT2vNdi35UdCczvAp47o6gXIuRrEW
         4hAH1yjoEa5fO48bu4rAIl6QTIJptC9r251HxtiEPzW5fHQXTJ+LPtnTCykdnAqZLHG/
         cu9lewA9vJ5uQ6U/VqsrNIjybREuo4VgvovYZorEknE1YhCNECxrNloex32z6/yU791v
         /f6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756714995; x=1757319795;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6bOX31TOnXa3mSpUgWZIksoOSQJIo6oigebcMiGpVk=;
        b=PEh9daASmlcjyYvxcDzD/Y+PgI7ForNAF08YNL6YeIgHXeNJjSkrH9jdeCxIzCIpMV
         yysoek8WgK6fnp399/dyuwEc4Fy9arnO1XlrYTRfKolUiVlBt1yoyXF7HF4BIMvIUsAb
         6KuKLMDbYp2KI9CD/OqMn/DaW/vnro8BzjvcoooC/twH9nNU55xjRFP3j9mjvZDMukVn
         hjTS2jZOLf5kBxtNhUEuoLLpetDMpraMM00X3jIgUlblhLv+QGonH7qAuk5OFxRTXGXn
         XfrfiadxLvCwOnJ76lygDLFER/AYZWltnYvwI73Ix4P46QIAwHUaYrpOf2gh7P6EM9Op
         Iqbg==
X-Forwarded-Encrypted: i=1; AJvYcCW/xtE/keXEqldtVxf2TsMFPaTR7j1Mu02ddjRED1nTHH5EcisjvLzPsxh+Y3nks7m71kshzctyYE035E0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu2GGsfIAzyxrPmD+1lYk9QoGhTmgRp4eNff1N5CLkjfKaZciQ
	o9rq1PIEG+UR3QnzZTJ68ld79hS97mi+AVV+mEYhoADKVaRFJszY/dzp3tZVvYZFSifOH0ueuaB
	HHlSMbC15AKnoOXYhKDmWk5+WYhG2G/4CoDa0Igmfmg==
X-Gm-Gg: ASbGncv3SwOURWwJ5vLSQCNc6ODNDapC1lputh+l2woEekIgCkcoOV5jNHjjn3njk80
	iYXAnL+EU2IQSXxRegDG7ub714dkvqKVll+xV2H1rXHVYIuMQAOtKhXRN+kP90+8cr386ZLghfL
	2U47A5gG8f6RB3EL9cGtmbglSCWQIu8RwuiceH0RXW9x9pbdJARVTKaQES2HbnZobC9VQEcqTnr
	uVoynsYrjlj7uzNmw==
X-Google-Smtp-Source: AGHT+IHVwIASRqXdiBtabwQpeTaLvx/MwfpuhWhcvrvqvY8VLXWEY8BeiyfCJbCTfLb/GJ7BJFbdc5bUK1izSWZcw90=
X-Received: by 2002:ac2:4c47:0:b0:55f:6186:c161 with SMTP id
 2adb3069b0e04-55f70a0081cmr1669470e87.49.1756714995167; Mon, 01 Sep 2025
 01:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250901073224.2273103-1-linmq006@gmail.com>
In-Reply-To: <20250901073224.2273103-1-linmq006@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 1 Sep 2025 10:23:04 +0200
X-Gm-Features: Ac12FXwOPFvcHfnOB3USWBMbhSfcVlBY0l39KH-IS_467sKxEs3coXt0xb6oRRE
Message-ID: <CACRpkdYVCU3Pb2u3r_G0BY19mbF8m1je696RNP_49rU7G4PvUw@mail.gmail.com>
Subject: Re: [PATCH v2] net: dsa: mv88e6xxx: Fix fwnode reference leaks in mv88e6xxx_port_setup_leds
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 1, 2025 at 9:32=E2=80=AFAM Miaoqian Lin <linmq006@gmail.com> wr=
ote:

> Fix multiple fwnode reference leaks:
>
> 1. The function calls fwnode_get_named_child_node() to get the "leds" nod=
e,
>    but never calls fwnode_handle_put(leds) to release this reference.
>
> 2. Within the fwnode_for_each_child_node() loop, the early return
>    paths that don't properly release the "led" fwnode reference.
>
> This fix follows the same pattern as commit d029edefed39
> ("net dsa: qca8k: fix usages of device_get_named_child_node()")
>
> Fixes: 94a2a84f5e9e ("net: dsa: mv88e6xxx: Support LED control")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
> changes in v2:
> - use goto for cleanup in error paths
> - v1: https://lore.kernel.org/all/20250830085508.2107507-1-linmq006@gmail=
.com/

When I coded it I honestly believed fwnode_get_named_child_node()
also released the children after use but apparently not, my bad :(

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

