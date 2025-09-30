Return-Path: <linux-kernel+bounces-837748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C87BAD190
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 15:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837E53C7B8F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Sep 2025 13:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9ABF1E5B63;
	Tue, 30 Sep 2025 13:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkyG+3Lb"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6631D9A54
	for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759240010; cv=none; b=mGKTznYwtU3PQSia8ycaY3fpnygtgfOujnXp/ay+WUyDimJvFwFvSIz8EX4jXazBx9x2dnVgG95RLiBpPOK+eWY6+bRWRU3/KctFdMb9zCzF77vOupHJ9EfA8CrfpUgaUXn/mHWf1pdFZrLwctZf4Tahq5hNjl3qpxPnUXLmBSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759240010; c=relaxed/simple;
	bh=YlStPwqNZ4oWC4pGA2dvTo0+R+SqBxsrbV3mpimCF3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekNQjgOSj9tzwrepd4mDFO5LIlHYFUJiw0duvvFolzjqpyYGYEY0tI9FocImHBDLynZcbuu8rrvJEiqEWqmDf2cdz14CvmhJ+R8BOJcA2F1+zMZxV8sL26hYrCI4HbFj9o4eqL2TfWK2OVYGkWW2eyORDzbxG5HTKNxsTEG4ihs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkyG+3Lb; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27ee41e0798so74237305ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Sep 2025 06:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759240007; x=1759844807; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jqBeS8DsUEmSCXznbj/dxds17JMLW1MF4WQuWheFD+s=;
        b=YkyG+3LbCzkGMP+Qs9tqKHTmME/yHNu8G6B30sXUK+b0+8PP8HaQc3wn5Gfs0aWSjc
         rjJyPZuOSPL8TY7608p6nat0/d2hTnZFERIANstiLx+kiGef0PG+ARPPzPpifhcLPmr+
         DBaftYC2CSycgWvFVfQP/0iwph8lrB9SH038UuDo8BTQT382Udim3DLwdySM7Qj2bCbS
         i6o0Lc54/oh5A9zlx/TK456MCTwxMd2Fs69ZP7MNs10KGaJTL2ys16y+yQSVahGoBDMW
         5NzubPW0cGhmyG6TTt7YPbHn4QJMKxs6FkA/sbmJ3vTmYuPxJ8b0h570qLhqW1d7khGN
         /rGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759240007; x=1759844807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jqBeS8DsUEmSCXznbj/dxds17JMLW1MF4WQuWheFD+s=;
        b=VJn3eWyYbqSLFXsDeY/G5/XF3omWHObaVOwHKcau5pNAd3mHw4/6SIZ5l67DVTC5Dp
         hQ6D33ZHcqTjBHWaFnL3n8CprNf+3eJ5dchIW4nunV1JnhOVuvPWuJKeGO0d+mKX4Jsv
         PRcNArRY2z5vMn1em+wSeNk1YvVX5s69FrU2rQ5SQy1IYpXcTVqkDj4HBjvPdpgdGtb2
         e/7CIFsXJ79fwlV+LDTEJs9vJreQgb6PqNGTiSibPmrowD5R/2IOZSPXkgS7aY4GS9nc
         rbSvDqibtwsCTsnvi9Aw8U+JrJPCP00thRsASWo6tj6jYFGQN63U/mKxvaPRxfqpW/LV
         xRfA==
X-Forwarded-Encrypted: i=1; AJvYcCUXwBXZFB9H/g3H2hz3jk0ailq/IDnzALn6HHN+E7PnM3CUDcWEjKzKNarTV0lYSCbc1Ivxy9JqOVEkrsI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy06bYb3KU4aWTtoa539jlCCdKtAAHmyUMQIrIR4hqwcyMP1x4
	3k19CTNEyOdWbF+wmWZPnzKSm8kYXfDy9ZyXvuUzqZcR0Ea62AH0dlDQLg3NGzIgVZPWu1EkbiV
	URy96WdZ3HTlEU5KErF81gh7cH5Nd9S66qZDR
X-Gm-Gg: ASbGnctgJ2rriORw9ehO0VCdsb1Pldz1FKKx/Fh+bZ8i1qMQVMfu79DkI97yjhM5yf6
	41IkZ2cO8FGtGn/wwuO9KqjZDMCI+SXi4RbJ/1Y2ORgvP3t8j2qoa4UMdYZEFUuTBhehKS2LYto
	H/OYT3i/p/qgTpYtHp9rdy9Q/ZfEaGVaHRciS78sn/FprENIwWcFMRMqzUwEgvDYJhKiTG3ZCHl
	TL8Yc0vzEdGjoh+cjeePLx0fq6Rceyumnx1n7hWDfOVnGWp1SgcEi5tfcUzTtZRM+HP/LM/Jneg
X-Google-Smtp-Source: AGHT+IGhjy6Ww2FYMoSsIzm1JAs0fFsr+Cq1rs8o9HJCNO8rElUTkiUNDOuA4xzAvcy982PmHLW7KiEcwrxcKTrjzXg=
X-Received: by 2002:a17:903:4b07:b0:286:d3c5:4d15 with SMTP id
 d9443c01a7336-286d3c5548amr104887435ad.36.1759240007002; Tue, 30 Sep 2025
 06:46:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250929133752.31847-1-sidharthseela@gmail.com> <87bjmtmgis.wl-tiwai@suse.de>
In-Reply-To: <87bjmtmgis.wl-tiwai@suse.de>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Tue, 30 Sep 2025 19:16:32 +0530
X-Gm-Features: AS18NWBf-tvZ0c7w_qRCR1tGIEM-sOtTfgSUYGymXk8Dpi7__37mC7Xze8xDi9s
Message-ID: <CAJE-K+AFBeEtK_e66r2VkeeayQW_H9H69uDQvtbAEKgQZ1QVHA@mail.gmail.com>
Subject: Re: [RFC]sound:usb:mixer.c: Solving 'Generic AB13X USB Audio'
 Unlikely volume range.
To: Takashi Iwai <tiwai@suse.de>
Cc: perex@perex.cz, tiwai@suse.com, zhujun2@cmss.chinamobile.com, 
	kuninori.morimoto.gx@renesas.com, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thankyou Takashi for your reply,

On Mon, Sep 29, 2025 at 8:51=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
> An oft-seen firmware bug is that it provides the wrong mixer range
> that confuses the driver.  USB audio firmware should provide the above
> volume range in 1/256 dB level.

If possible, could you explain/ point me to a doc regarding cval->max,
cval->min,
and cval->res and its meanings, its relation to power and dB.


> Try to figure out the volume level and you'd need to hard-code the
> actual volume range there for your device
.
I am able to change the values and load in the module. But unable to exactl=
y
understand how the values are related.

--=20
Thanks,
Sidharth Seela
www.realtimedesign.org

