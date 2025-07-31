Return-Path: <linux-kernel+bounces-751585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6E36B16B27
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 06:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B735B622AB2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 04:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 776B323B601;
	Thu, 31 Jul 2025 04:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eZqFOyR4"
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B91FA921
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753935985; cv=none; b=jiAQ6zKZJa1XYiq74uOSxndG07wb0zd97c//uMvq/lTtIRQP1T7oziyO5l7Pp1Cs5TEXB+id9/l5i/moQs0OjY901s2rlPkwzpOssr83xtnyn+E9VlOHtnnxYoiiUU+Gae8qYjF1TJfafNFYTKQfkU9eaNnGhj9xVTuVtJ7Jduc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753935985; c=relaxed/simple;
	bh=e5Pt2D+lJivBS28/plTuvgaI+t3rSje6fmXy3hZeQKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IqHPgpLaFfqfQXSMUYCqKdTvhY4SifJzh16sTA1grdljYMGQ0nbvXjzVktsWYFAOMB4HeL0N/wlXHKn5hugaRrdPGLxdpdO8iCnZ1MwN5DgcJETeP+z6OMkyXCSD42FgII4ar+hk3WO91FCo3b5TyQuDtDwVvPORg1Ge4ejZmN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eZqFOyR4; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-532de49b7e2so213009e0c.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1753935983; x=1754540783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e5Pt2D+lJivBS28/plTuvgaI+t3rSje6fmXy3hZeQKs=;
        b=eZqFOyR4SQC/VG8WWBcCrGbqnddD3J6vHSyZKiLH1nWn7FKYShFk4JMNkfWB6O31Gq
         hxz4NXwjH82RRpy/nC88IiLcOtIVl1rksN2XvSuWl5ia6c9qu8dhrH6qXhitnhLYsoXH
         IHNWuRZzSyG0rYkAPzbVFFyz5gWXMwJqzLmZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753935983; x=1754540783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e5Pt2D+lJivBS28/plTuvgaI+t3rSje6fmXy3hZeQKs=;
        b=a8c/w53hAKyhwFXYsjin/gMuge63O8YhHeC2IGw292fCdprkQz/sDrM6re4Dy+JMow
         PRMKZJMt4rwniAVt+WOYMpxqMhnsJa9dghtkf3fyaKAm3KNEvtrNv9b5lQnrV1GrJG+0
         Q6ost1/zMHKGz6ZnNvv1549M3cgfcwtQgeVB4uPaIxUtD3mAXM/AwWTiY5bpdsl1trQZ
         LBdzNkkfQS3q2zzMUPph0w6BFGZaUpm/d/9c2ueXzuTzIrvp4gHb4DPqfa/kxa7jC+o/
         50vSQuVWYU2Vw+fbomUr6+V0N9Jg0QcocSgusO2FHchzTZUM5Td6CMcYHmLn2r1dLaXr
         L7tQ==
X-Forwarded-Encrypted: i=1; AJvYcCXV3RmEJfIJyG2jRjYv3ncrvCZx+erY9SkjW7PT2F015J5F8yXA/BgcSnFrOAkgrCls1qfN3y29RlUZqIE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSvVqFLx12EphXoQfqOzEF76bi3BDW2pA+acLJ60rEVL61obo
	S++FadxemoaLcePAvahUGKiGcHV7lUHPRsMAlHTbQhlr2fHjHJ4UHI6IEe2a2xQphdfV+nTMjOx
	pwm4=
X-Gm-Gg: ASbGncvkd1bL4bwdAZBc/hW+P+ib1Q1tCiR7E3G5/U66rO5EXNiyGeZMW273lJnc+yb
	2nAB9YAfZ0MaHOOPHHe90et4fHJAgWxwNg9TD2zTibGSyHdkpHlwpkP1WfT0X+Xir3PUcckmfTZ
	zLBXRc+y0CD9k9KerGa7GoH16Gxbx6NsRh0+BmI1BPJQY/XKinxnvWLaAuOSuCedD9J2Eaqufgb
	vvdQOs14ED4jZHuaGYPS2Brkqmmkx2Yv6OqRUAYHsNe0SVhco7nHMcko5PjtMNO+iBhAZXEH5gS
	5E3AZ53T76pywxmVltwiVNBqrgw1QJoPfXIajkaykKQE5KbYlWwpZFBnltXh3QpegE7jitDcRMM
	oWsVOToA1HQwf+NQMNGDt9wMLQGIZABvlkKtb7s4zA8nEMChw9mOY+q0EpdIFtl5Tulm0dZS+
X-Google-Smtp-Source: AGHT+IF/1gP7B2vNFRJkLeUN5CQ3i2Y1Vy/prwXolqOzH93oSr5SNZ5lfzrY/3UowSbY08AaH2Nkdg==
X-Received: by 2002:a05:6122:829e:b0:530:5996:63a2 with SMTP id 71dfb90a1353d-5391cff7e91mr3280889e0c.7.1753935983298;
        Wed, 30 Jul 2025 21:26:23 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-53936b9a5a2sm201362e0c.15.2025.07.30.21.26.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 21:26:23 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5314b486207so201846e0c.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 21:26:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/qKpUhegqdoSGynDtT+EEYvTsJ0KAZrMIelXxmPkYiVzTuCZ2DNkFZ04lorrHIbaHPivaDvEnFuAu3sI=@vger.kernel.org
X-Received: by 2002:a05:6102:3c84:b0:4e2:ecd8:a27 with SMTP id
 ada2fe7eead31-4fbe7efb067mr3218583137.4.1753935982767; Wed, 30 Jul 2025
 21:26:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250730152128.311109-1-laura.nao@collabora.com> <20250730152128.311109-7-laura.nao@collabora.com>
In-Reply-To: <20250730152128.311109-7-laura.nao@collabora.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 31 Jul 2025 12:25:46 +0800
X-Gmail-Original-Message-ID: <CAC=S1njcFhyY6+dT2MHU02ZsLDq+k_vAVv==bWuoGt3KA18PHg@mail.gmail.com>
X-Gm-Features: Ac12FXzpMbFxjUu23GFYxUNlitLi6oNpjwDf0fTbw3kLbAuwV_H195C3EX5jG7A
Message-ID: <CAC=S1njcFhyY6+dT2MHU02ZsLDq+k_vAVv==bWuoGt3KA18PHg@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] thermal/drivers/mediatek/lvts: Add support for ATP mode
To: Laura Nao <laura.nao@collabora.com>
Cc: srini@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com, 
	lukasz.luba@arm.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, andrew-ct.chen@mediatek.com, 
	kernel@collabora.com, nfraprado@collabora.com, arnd@arndb.de, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, u.kleine-koenig@baylibre.com, 
	linux-arm-kernel@lists.infradead.org, wenst@chromium.org, 
	linux-mediatek@lists.infradead.org, bchihi@baylibre.com, 
	colin.i.king@gmail.com, lala.lin@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 11:40=E2=80=AFPM Laura Nao <laura.nao@collabora.com=
> wrote:
>
> MT8196/MT6991 uses ATP (Abnormal Temperature Prevention) mode to detect
> abnormal temperature conditions, which involves reading temperature data
> from a dedicated set of registers separate from the ones used for
> immediate and filtered modes.
>
> Add support for ATP mode and its relative registers to ensure accurate
> temperature readings and proper thermal management on MT8196/MT6991
> devices.
>
> While at it, convert mode defines to enum.
>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Laura Nao <laura.nao@collabora.com>

It's not visible in this patch, but a heads-up that I see
lvts_ctrl_start() also depends on whether lvts is in immediate mode. I
wonder if anything is needed there for ATP mode e.g. a new
sensor_atp_bitmap.
Feel free to ignore if this is a false alarm.

Regards,
Fei

