Return-Path: <linux-kernel+bounces-744596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507AFB10EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 17:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D371757E0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 15:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C2D2EA47C;
	Thu, 24 Jul 2025 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NVWx+2e/"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410E62E8E19
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753371854; cv=none; b=ip4/XX5ICbxPXUHoyWEbjhh82T0cG7LUdbLfHLW736sTIeMS6Z+D7mn2RKv0Rv5PYbwG1JuYWBQ8J62M4x7Hdk0x3WrzfMt+/sXZcCVAX46rSzSXcVN+C+Bcldf2M15D9QIEGBqpfQdwt6aLUlDimu9YJDxli7kHkJL7NHKrbe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753371854; c=relaxed/simple;
	bh=936cSQQM11n8NL/eExtMp5wHeqBYTBipaec4HObrLUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVZTYQI8bx87LIe6aInMUGBri9kOzKAN8AUqHeW8s9s4hxx3I8HTZcVmJBlqq2ZK9ByTMXN2Dvn3iLyER4zIFvhC1MnEWcBb9eO3I7QLsDAj9hTXZOFcl41bve9KpW7ZfepMS33/InUnhkTho8DSQYsabVog7TZLcgF/bo/Gm6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NVWx+2e/; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-612b34ef0c2so2321884a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1753371850; x=1753976650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Mjpmrfxd/v0JpwF7YUxdgp+tuUqNPC5F1qAamn0lqqk=;
        b=NVWx+2e/ArpaWJphuHG0meJqnslM9wqj9We0n0QBBHbzG+wc7WHL3Q/YtZRZ8kkN1U
         5Ia00nDIsdzYMy2v/20GuyQAsSsFtsHija+tKR1lIpdmIk5wEI+DR1CoOgov4lQystTV
         q17VFoitK3cx3xqz141AY8VyRIl4bjGvH5uns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753371850; x=1753976650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mjpmrfxd/v0JpwF7YUxdgp+tuUqNPC5F1qAamn0lqqk=;
        b=NUD7lylgOeH0vFJwcLxXZsncXM6kKBONN561SiQcbnwn9bETlv5V3cEJm1tdVxU9Z9
         ZHCvah7iXJEam0vr4bUqDmqAps0dfn9X1glKdAXhnFFj0g0Ef8AvTz7YmmNlxkBK4UEO
         gHDfeMV1/BIaVzVqVBOu1gSM01nt3cU+8Tt9m/j+c6l29EylV+OEWAnP3qJq51cKNUFg
         tpFt10MSjs1ecQQpWO6a1Fae2Dy9p8laMoxsVrpKaM52txddv18/6Xh/ByZuJTWIB2yL
         4qFCxScpLxSfuaX+VQM9Sa1V+PmYHrdnd5fvqKHPIgvMX9ZYVJOLhdt7z+p9Iw9Bc1Wl
         j5nw==
X-Forwarded-Encrypted: i=1; AJvYcCXECiF9/Bq705cH8it4/AWI3DkflEyn4DoGTrJJwS53K4vxZI6LC+a0s/o6Zj72eURbKkZCwyuypxkGABM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/nJ+lVqdepjUTqrLOM1z0Pn7BnCIicG3WMGFkrEWuPW2pjlFq
	ZrecjvVL54sEiKsa6qJ3wdCabmEJLd2HRoVVYKZbqvcPx+Kz+aUZoGfHPwfZnr0Tg0tOfx1GgH8
	QQQh+xtM=
X-Gm-Gg: ASbGnctYK2w+o/rDoOweF3Se5yJQZHxI8dDVhABPXEDUyy4EsufTZwHjJXGEvyREoom
	c20tb4YI2//Ghr2mpAEvCqfSxf+rkSAJRPJMTpU9CcV+NfBZXBVcmtDmqVa3POi+nIZ56sMWC10
	PEane0aPlhFkDD6d8YRW9rZ5GRuZgpNMFLr2cCbErrNHpQe2QlntXAbvqrcIyNWlbksHgUvuffc
	WvrfptuAQiPyAspG765FbRR0pCQLq3mRt3J5YOrXKckkJx3H3FfRJIvqq5LNL541b7dsyudKSve
	OZybK4dqwu4hrTRXW2QiwUYb31X07juWBFsHNRG9zrQ034xf9+sg9X2rauQJ4Cd8BJn79adk4vu
	NwezUrm78iRLaTArzqjqiopGezoIPV9rKfvglKMVDV4zITti1SNoBCNiDanSuvw/UqYjfLOSQ
X-Google-Smtp-Source: AGHT+IGRm4rXRwxW52AoNjznN3kRL8BGLcMcA8oxzPmj/1gOXPo5+TOBMmJia3rylk3T0C3ol0I7cg==
X-Received: by 2002:a17:907:7211:b0:ae3:bd96:78cd with SMTP id a640c23a62f3a-af2f66c0a0amr827990366b.7.1753371850193;
        Thu, 24 Jul 2025 08:44:10 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af47cc6bca8sm125773266b.36.2025.07.24.08.44.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 08:44:09 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-612b34ef0c2so2321801a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:44:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCx0CbrTPCiyzP3Hnsk/rG2Gn6YR2v6JSD8cdKUCJPRg8lgZSytOrUxTEwkxbGRV/vom/QWpHKi+r0RzA=@vger.kernel.org
X-Received: by 2002:a05:6402:5244:b0:60c:4521:aa54 with SMTP id
 4fb4d7f45d1cf-6149b5902c3mr6837921a12.17.1753371849006; Thu, 24 Jul 2025
 08:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPM=9twUCJj4X-2jf0VG5+A2YN9Gk8hjOAhJ2hxq4SdgZfvtMA@mail.gmail.com>
 <CAHk-=wgLQ+EPeV+JzrvkPWt2jeteqwsRkf-X61jjfV8pefgXeg@mail.gmail.com> <73d6e78c-a360-40d7-9123-e00d47ee2a7a@linux.intel.com>
In-Reply-To: <73d6e78c-a360-40d7-9123-e00d47ee2a7a@linux.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 24 Jul 2025 08:43:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8t_0By0LOCa_sJ_BPhvdBg3SuQPgkBYWycxeh9DNipg@mail.gmail.com>
X-Gm-Features: Ac12FXydeKBt6S9LzXamLxkh9jnQ3kcsPJ5_fVc9HQF90V33v-OymCtO9Q6ha0w
Message-ID: <CAHk-=wj8t_0By0LOCa_sJ_BPhvdBg3SuQPgkBYWycxeh9DNipg@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 6.16-rc8/final (resend in txt for sure)
To: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Cc: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 24 Jul 2025 at 01:50, Jacek Lawrynowicz
<jacek.lawrynowicz@linux.intel.com> wrote:
>
> Such behavior propagates down and makes the community miserable.

Google "friendly ribbing".

               Linus

