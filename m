Return-Path: <linux-kernel+bounces-799412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C91DB42B47
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 22:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C829545587
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 20:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDD92E0927;
	Wed,  3 Sep 2025 20:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="C1N71Y6+"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB2C285053
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 20:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756932456; cv=none; b=DqsP2Oe/iX2JW3J7RIfENx95uIGqfcPKkxQmgmPty068WYEJQooFTl88vwgwPWfGvDC+pU2djaOv33Q+2ofGrnC+PeBRdd5iiPnn1EOTjluSS4ftZiKv4mf1unlW00yWx0nhWvNs9BX2q46B4BDMrVfLg+isj5LmEyq1dS+Nh4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756932456; c=relaxed/simple;
	bh=xOX3t1tNI835fQlZszqsBPrAw0emLRXFXBi/KdgVw70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RAWwEzINfY7U43pZ9T8PtODX1Xpam15brBanvWK2IuHXRaOdH1DtFYJh1lvcL8YydhfvO1MhL+tVq5sbTbC/A7e7T5AG/8pkdA12QY6ITBVsUVUsRaCV7Izw0G05LR4atHEDmRcU0ujl0YOpjEZq7yV37Toig+lH4l9ltzjNPGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=C1N71Y6+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-329e1c8e079so211343a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 13:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756932454; x=1757537254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOX3t1tNI835fQlZszqsBPrAw0emLRXFXBi/KdgVw70=;
        b=C1N71Y6+eLpqZ5S3RMeBIKzkGLZ0XQRxsplDdvpKyUQ++ak1N0Xp3YH/E+ovePURuP
         +cS4zVIQBxHdkFxymI6oWmdMLmzq0mwYy8muL1v1k0REFlOsU+Ut68txVQbSrLjSXb/8
         T6StVh53IHsgu0mBwK9XZ7f6q/BxtP9mpp3im4CLcZOE4bdLBE03qnznkl+YIaTCjFwF
         y0AAO4j1oonCYYtKLV44teSxkTMteiz5JY+fC+0RyjmLupeAV4sNgqLiFb7k2sSKK/3G
         a2a5vJ33lg82/KqsHJ0hIM37BRVy8l0s9isEpuIs0lA36UYxPFKsLKh4mPFZ8I8qS3Aq
         JTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756932454; x=1757537254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xOX3t1tNI835fQlZszqsBPrAw0emLRXFXBi/KdgVw70=;
        b=n4SkrZhXXq7Bos3Tn+LytBTVHKnIL3xICugU0gQGLLQgf5Vf/37qciGSIlpSwZY+Vg
         j2SVe4gbQLzZAac8oOD2Zv1P0xljwNkP4NT7Mc/WnwfL3DBf7TPk9ZI8CWNXvyDFQIWS
         yigThE9t8OSvxs5nNlmbGXsyqqTQyRlFdRjHoi48TCvXLjoyRz9kZTVfz3T43cJb8MfT
         mHeU3Kh91X5EiMQoPZ0ZR2gNtsasIKfKRBeoNDZ8RucWIeVa9jxaJKxyo2QtglpYVBgw
         hlBE1wGeKtb52YcA6yt4vHujqxYFbNdNmnlXex7L40y10OYQBiuZoktpHS3UKMUA8wxK
         M7+A==
X-Forwarded-Encrypted: i=1; AJvYcCVsN4tqJkL8jcrhfR+C9fbbjh4aVtMw8Br1LLeaMZFLVCy3TqbQLv5Sr/sEsO84zGDyaTbbN/oD8KucKMc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp1h6wXtI/yopLj1SkW/hg8IDXpC0d6qmEwOkubrYri3CXrzmy
	DDW7Jz4NiDFQxfaQNQ5XQWjq1tK77o3ZfYdSkZKtgCv5DJYuStvGKIEazHNITv+1ELh5sdE+zfI
	Mg8SsIZd45v2mE+KtFAq6iQyb5HZMeFVXq/bE3lMA
X-Gm-Gg: ASbGncuD/GsuNNKpVXgilwXqP+LvV09CdzCjYD+RWj9EJ+F/9kbKbNQqhi0/TrSO9OQ
	HEvr/t/hgZO9X/Q21AcjJhehi3Gl1JSdZg8gZ6Th1ltlLBcetf8yWjiSqUP2eNnGiJIq5aVpYGr
	Q7qKS0TpOWuq1ZBlGqoX09DBpOTI4pg1G7hMfQt/AlbinSlDWEfJCoSPMNBvttNLizHI8X61EZj
	rDELc0=
X-Google-Smtp-Source: AGHT+IGkMQJVBqRXSGU922Gw2SQoYESmtMZntOQt802KtRgput2nM13fgy1GouC7w5vlqACo5BZPxtKEyiF/nxMIIPM=
X-Received: by 2002:a17:90b:48cb:b0:323:28ac:4594 with SMTP id
 98e67ed59e1d1-32815414089mr18348545a91.5.1756932454352; Wed, 03 Sep 2025
 13:47:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250902110049.4437-1-disclosure@aisle.com> <CAHC9VhQsmaGPM7+6HX9vqjPjG7fXwV+F19+U052qaT4DYrwnFA@mail.gmail.com>
 <CAHC9VhRtXzSGafaqLm_EDq=rj4BhDaOkaS0uJ89W-Scw2Zyxuw@mail.gmail.com>
 <CAHC9VhS7PyKsGnoT17WojZmUEqYh-HgP2TS-DQdct0yv2BfZqg@mail.gmail.com> <8e395d8a-2875-4f78-9118-facd5de09a30n@aisle.com>
In-Reply-To: <8e395d8a-2875-4f78-9118-facd5de09a30n@aisle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 3 Sep 2025 16:47:22 -0400
X-Gm-Features: Ac12FXzsE6wqWc2GfQx0HjiRC03KXQ2G9UrGjNyJ4MGKThk3ZmUlEY1kfxw0aqE
Message-ID: <CAHC9VhShXiHnyN-Q0tWJ9o8advmJ_FKXCCOHb1sKF_noz-JW5Q@mail.gmail.com>
Subject: Re: [PATCH] audit: fix out-of-bounds read in audit_compare_dname_path
To: Disclosure <disclosure@aisle.com>
Cc: "audit@vger.kernel.org" <audit@vger.kernel.org>, 
	"torvalds@linuxfoundation.org" <torvalds@linuxfoundation.org>, "eparis@redhat.com" <eparis@redhat.com>, 
	"security@kernel.org" <security@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stanislav Fort <stanislav.fort@aisle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 3, 2025 at 2:03=E2=80=AFPM Disclosure <disclosure@aisle.com> wr=
ote:
>
> Hi Paul,
>
> Yes, please go ahead and change the Signed-off-by to:
> Signed-off-by: Stanislav Fort <stanislav.fort@aisle.com>
>
> Sorry for the slight delay and thanks for the quick review, testing, and =
for adding the Fixes tag.

No worries, thanks for the fix :)

I'm merging this into audit/stable-6.17 and I'll plan to send this up
to Linus later this week.

--=20
paul-moore.com

