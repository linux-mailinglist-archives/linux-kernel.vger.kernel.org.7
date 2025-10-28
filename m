Return-Path: <linux-kernel+bounces-873027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE23C12DAD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 05:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E271893E71
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 04:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C7A2882D0;
	Tue, 28 Oct 2025 04:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LPtqnHqM"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D0928002B
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 04:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761625324; cv=none; b=r9xYw3G3iTNRBHpYrkw3kdi61MMvO2DonAeD4N5zfe1S2tpRqPs+DqfWeLWw9zqMq1RUTlFmRFTTvI8TbANwpYT3ISO9wOHFkjFc5g3YLUMBoZtP0pfYdIEO8AZrQMM+UrSAEY/N9ULZ/7c22fCge0G9WepsA4Ja7Xjr+oD4GU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761625324; c=relaxed/simple;
	bh=9+EoAbr01F6ROd3ypwDMT0beFvOipyIxdcEfFRsVw7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uugJPbwqNDlJ+O5po3naWpP/LjmfzvdwNSoTu2Kegutc9BkHtHH4tGsmHOuY7UlRVAYgo3w5T9rw7XgD9ko2DrzduJARbtm96kRLF4FwgLH/2BOh2uLgpOWxKDiTZcYPW66ETl1bOf3CBKg3au1fsHhbTHjmjEQnK0xJtO+lZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LPtqnHqM; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-781014f4e12so68008387b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761625321; x=1762230121; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9+EoAbr01F6ROd3ypwDMT0beFvOipyIxdcEfFRsVw7M=;
        b=LPtqnHqMmiEcyD5mEvkcVAlknJIBsenu9sdIZr6YAU/2Odi4guTInwm3L+E/jVvs2Q
         Ov9Zy6XRfFETg20YumnPWKwY0i8gc8UwlIO9Na7FzebESL7pniDCfXJKPdPnlO/CSLBK
         SodESFpJVyBN22BVPbBCAyLkN81lYfBYRIJGzPhGvnqjYwXuGHjE+18yaiN+C7PFMIKD
         L/4xNgK7M5n3Kab9mxHwsefW68QMTwEJGVHoOhMyYoHBd0rqb/MwtOAhIyQhplUrnewt
         U2bUcI24ZKIBEm5rlk6zJqDZwFfQ/UN2RrOvQQh+oiW+A7Xz9DdkdGeITJBflxwCZ5kx
         56cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761625321; x=1762230121;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9+EoAbr01F6ROd3ypwDMT0beFvOipyIxdcEfFRsVw7M=;
        b=RQ1TstJoqxoOxELe2MlZ7qtJEZ3kOd8Zrqg7NM6Tg6SOPEdD6JZJ+SxM95mgmJdjmH
         0agvTftu4uVkMM7ffPTa0K6vw/H3dtQtWbmB4E8dw7TEuiQBvAmU9gTtepGZYoDMgLs/
         G9C2RiIRh1GKaXQNqTb8ZM0MOsbX8Hj5BsHZEfkfez+ABeusGo93JTGqiR4udllogZ/k
         PNIPuNTUpza7CRA3mVwa8fihrjuOZHb6oxdkilZ9aqWzzLKLRa7VehNSpDUDD4XoDQYM
         tGaO3raoTaQFa0txrpwKyogsgzwaKT3Fv9Mh128W/Kg+AH19XqhM99deUBPv+pW8kbfI
         GbTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWyUvzn1jmQbdkDmKCCBZ6JNNewh/T7hSbhPh0x13IiAO14CPowRVHgmrR+YwXS1WFaaXaJYfrEA9SohOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0Lc2ovqppPfDWPOGBLtmKnUl59vPWm50DHeV5ahRU5b43EebJ
	LDmzIBGvNbzkeOnCklaeuKF0X7C+GoKWysDTxqB5io2/HeM6JdXZKE7FOd/TwxMQBv9mnvC17RE
	XvMLXEzcNMyIxKxTTKso7hvy9YyXpons=
X-Gm-Gg: ASbGncuMLFh3uz7AXAc0Lm9Gkrap1Opa2iORHAOrsE5XjCIkYVTW3JvHpcal6RGzeAc
	z4tEQlIoq25kacupCjhMkCvwzIei35yg9vnCx9OO8+TuCx3qXZP+44auuIS/UeoN09tySoPmvQm
	OyQMBN5EQFIxWbmtWIsiGSFrbRTgmcmjbjC4+tvsFMgoajSgJaVHjojvvvtWAKOQcvUU/FrjiiO
	iIlDZTfWhAs+BmSumSyAqDibOUHfxCut4tbCBvffF+hR235Jf0eu+fXGRoI0TWxkKpI+uHV/2ke
	+iyx7USZ04vOawn+
X-Google-Smtp-Source: AGHT+IGMTXOSH+1otoOmPpgppIzojzxMHCoPoNd3/E1I8BSrUGiO+jquir/tS1M6i1lmHcTBFrd98tiEcY1rENFzwIg=
X-Received: by 2002:a05:690e:160c:b0:63c:e837:5d89 with SMTP id
 956f58d0204a3-63f6ba4025cmr1640634d50.31.1761625321649; Mon, 27 Oct 2025
 21:22:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251027124131.10002-1-kartikey406@gmail.com> <ba3241ff-d2ef-478a-ae75-c670cd40015e@linux.alibaba.com>
In-Reply-To: <ba3241ff-d2ef-478a-ae75-c670cd40015e@linux.alibaba.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 28 Oct 2025 09:51:48 +0530
X-Gm-Features: AWmQ_bmV8z18noL75ZLv6WTQIQEKPBPgLzKcGX0FLlBP186fDheuTDAzSMrGNOI
Message-ID: <CADhLXY7iAWVD390=A2A=mjABi+rS0Da1HUb7DHXfPvg696gJeg@mail.gmail.com>
Subject: Re: [PATCH v2] ocfs2: validate cl_bpc in allocator inodes to prevent divide-by-zero
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: mark@fasheh.com, jlbec@evilplan.org, heming.zhao@suse.com, 
	ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org, 
	syzbot+fd8af97c7227fe605d95@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Joseph,

Thank you for the review! I'll make those changes:
- Remove local osb variable and use OCFS2_SB(sb) directly
- Add blank line before rc = 0

I'll send v3 shortly.

Thanks,
Deepanshu

