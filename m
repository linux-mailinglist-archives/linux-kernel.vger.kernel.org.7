Return-Path: <linux-kernel+bounces-807866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C57B4AA8B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 12:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 530A41C605E8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 10:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCBD309EEA;
	Tue,  9 Sep 2025 10:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qxsb0EwL"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A282C0F60
	for <linux-kernel@vger.kernel.org>; Tue,  9 Sep 2025 10:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757413551; cv=none; b=FmEMAPxV3gZDWpFu3Ju6BXRG3ExJ5fmzMgEDpchhKXN/j5kkAsI2+A7icnFq9UV++Ijw9ayqcPjfsc3u4/f4f6S+sjMAnXnldwXUco8gGEbOpBhmfWdHcrWpkEivbTIeA4iWMYV7ff7H8gJJmq8ck8CH5D/btA2EUweROFbjt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757413551; c=relaxed/simple;
	bh=gSDQPe+Vye9dZddc/l8dCv/A1nlfX91Tsh1IT3JvOzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jLaqY5lSbrQGn3LNuVAaCz2vo3lBve1LMmBweq1pHm9pnBNqus/QjAL19W7/GC65VykIWlSmsRI9j1nsAaB0djdT1Ge2GFBRHPkeQRmA0UlIvpe/Sm8Wnfc181k6gFnqAM8ROhxV1pgyt0U2fYKlXzesCiEcRRdYeF3mY4yIrl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qxsb0EwL; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-33c9f2bcdceso21587711fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Sep 2025 03:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757413547; x=1758018347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSDQPe+Vye9dZddc/l8dCv/A1nlfX91Tsh1IT3JvOzI=;
        b=Qxsb0EwLKosVe7bul5jTHfTzdMSMD3TlwQMmzeEhZCCsK8swPe8CftdW9FFNXCz0Qq
         y0wIfw9io64svJZlbykNzuimHEHinP+foGtGJblBwbvulQwr4XbHrIoDUe4aWEfxS3tH
         d39jdhvCjHuBsmZ/rtgAOG8WqhXgdRyGT05te5X50JVrAh9AnUpCplt3OrPuk7nF8DcM
         IcZjdQlFnuz07yUD2qP0HdWpVzdTP+XJH2w8/V3cuJ9CgZlnAD2soROSbBpYv97b5tcC
         CpUFb+vnGqJ11GuTfYuzFlOHgfpVFMLafHoyg7sAB++Cohu2p0h5U1bDYB/7X81Xi271
         /yYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757413547; x=1758018347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gSDQPe+Vye9dZddc/l8dCv/A1nlfX91Tsh1IT3JvOzI=;
        b=lE0ivW0LzEUtocgkJ4XeoVrAdEwg9Sp+ial1vjUGgIN1MuV6tjY9L44btHr2l4jstC
         X4UOMSd3EQkqwlqZmDYpRzN/x29Qp3saJ6hoNrItktZiLX6N3xb2UFY1LjV9/Btqg64R
         GqnW4tWqp9rDFVicvanMvg8NK2DH8wT4Y3kiixu1oQdUN6tAArsiPakWfg2DSQnZjxdr
         LtHxLmhVtT0lct6nrhatyRwR5oqVhKYws9Xv0QyzZwBWSYm93al49xPymvPBZsKESf8X
         D9ao7RA3GR33b96/elBCc8oRefsUq/pxnlTB4DmtN3sZp64wCu9nwVBdKvijiIPVgzYm
         22kw==
X-Gm-Message-State: AOJu0Yw5H5dfIy6Cp3opyaLbSrMwsRpHLEs7jZfrv+nd/2JezrTv+MR0
	CKOu0szhkYcYL36mLS1ahtnw6JzqIPN9W52w6DVdf87xcTzNVRd3Et12S0WT1JUDVXSsADjE/6G
	XU5hqkMEWXytVqrgybF/kOJXPSFvCnajC/ss06E/YgA==
X-Gm-Gg: ASbGnctwogWn4z7BkgVkYnXS9m1leJ9MaWsHqdqtxbBb5QITBTZgtxtSvzcsNvP143j
	TJTrSDt8JIBrQGHgigkMRq7SrWbex4qgTcxx63WMlBjULhvWRFZQ90bZ+tyZr2fG4XWmVtekb5T
	fQnHfl8b9eRfhoOc3Wo4ZyqaTZYU538Y+eFDq74OZ/eG2s7eMu4P3ZenyNNwwWgSuSU+2dT3FGh
	hO+TCQoGq6m62S+qK5/aaMNNaMY+frZGA6lRORZ
X-Google-Smtp-Source: AGHT+IH2uLu5X4voee3Nhh9+pRobuZbW7uWCCwrkdjJHmDCSuxy+M4/9SiPd41HO76kZPpHgH4fZaNCSqcVe8HUx8N8=
X-Received: by 2002:a05:651c:199e:b0:332:3a1c:beca with SMTP id
 38308e7fff4ca-33b4edf0692mr35911761fa.7.1757413547248; Tue, 09 Sep 2025
 03:25:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250905091325.112168-1-marco.crivellari@suse.com>
 <20250905091325.112168-3-marco.crivellari@suse.com> <aLscu4p7hU8HJRkK@slm.duckdns.org>
In-Reply-To: <aLscu4p7hU8HJRkK@slm.duckdns.org>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Tue, 9 Sep 2025 12:25:36 +0200
X-Gm-Features: Ac12FXyoM0Ti11lHnVZMWdhNKyMEcGu0DIavbCfjRQioKPKtXuKHE18BH1peXH0
Message-ID: <CAAofZF7DjaLoND21rNk9T=nVMBesUYZb6xfV_V1hdj0kJACBvA@mail.gmail.com>
Subject: Re: [PATCH 2/3] workqueue: replace use of system_wq with system_percpu_wq
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 7:24=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> Applied 1-2 to wq/for-6.18.

Many thanks, Tejun!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product

marco.crivellari@suse.com

