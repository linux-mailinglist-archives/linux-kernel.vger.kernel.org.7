Return-Path: <linux-kernel+bounces-839616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9421ABB2058
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 00:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3504D188AA65
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 22:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9984C311975;
	Wed,  1 Oct 2025 22:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqVhDSWa"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438121EDA0E
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 22:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759359093; cv=none; b=oVV+bFkHBQbWZl1VaB4pmRY7N/D0JURiNBZWoaQkJZyJ+CIZHp8H6NBTe2+XswgVb+O6xdFYiimNfCyx32l1AsW3Hlc/Ch9FkKhoq6StdiavSozqTlIk9UuK0n/GxDr5sAy3YNxsSDI0yeAD8ovMopel/mxDJ3gizSJjXTwBS64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759359093; c=relaxed/simple;
	bh=08pLA6uxYNg9rbeHvjBsye3PWUrBRwmKepxA6EJcxe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F20wMZYI4jAsWgNcYL1ZphBgj4V66GmZ3JxWvWvmZc7tfhBpkqqf37qawaG7c8OhkLHtPwrWWhocF0jPUwy0WU+HYCbR8e3OYHQpy53QAVJu2/jAuLaFER/6Raat5sOR0oqs5hEOkJrK9s90RaRGrFTQ4OOveXH17mifCXpb804=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oqVhDSWa; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-57f1b88354eso342045e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759359089; x=1759963889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/El6nTOEVq1mgmvqeb9mwzaWUPYnE1qtwgZZVfI7LtE=;
        b=oqVhDSWanj1MivadP6yuezxtfX73NYGCVxq9aFl5+NAbjwO76GIKllEZPMxUAspbRN
         SmuttDj+bdmXNgdlBeCvcNFCD8cpFzZeY9cbDceB3QUuMLS5z3ucXpEW6ukJI0k6ItE8
         3wc+fD/8JXWwRRDsqS0gX/af6jZRgepzOc3LwHgCkMhW9HsD1qsCJ7XpPyVG082KdugT
         uRTqAPL2q48WFmJXI3lCUxbCRxRCPjWWaZuWHUneetf8ql1djuUvJW+061Q1fRlJc0jS
         tVrhRpN2jTovH5ytQCaahAZJXhyW8GsEf59Mwg0jGY6Gh0/vGOc4V+a2PH2cTC7rJQeO
         I6qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759359089; x=1759963889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/El6nTOEVq1mgmvqeb9mwzaWUPYnE1qtwgZZVfI7LtE=;
        b=qLYQ+CimEc6ZDObhRH3kzsTbVYzc28OivhetMnCXudWhrxBQYgQF8UiZMCx75bukDh
         EGDw1jTm+wb4WiBzv0jc5w0sy5UNy3fpnmci+L3f+coAE7skubRt57JUp1x2nsHZ3/27
         kwdHPAWnXExTaevPqFrViw0wuwlwbREprclrXbhMuRqYt8z9/+bMic7MX6hJs5pARcqW
         P0Y7ohkrUUsC7uEozVZMPHVbJnHOCgymYFhvrK+wEkZasmqgakhkbOxX2aCd6lz+mqzF
         2oqpYYzcx8dzEJ9pIoASUIQIrVXkgYYqfMVh57HGlI1SdjNwfSV8AT8BPJ8h9B6C1SYZ
         jrkw==
X-Gm-Message-State: AOJu0YwT4IPrf8MX51rQyXkdD6k7eO0EyEO9Dw6EwILH0TjgVlcynN8F
	lAaiD990a09so8BkfivDmYJjdESxtnxA2mKKBFTJUmeTGESwhKzHQHcuuqcu4RpNNjsd/vrFdFr
	r+VHLAO5GtRMP/Liz2FLA/hS3UIgB70MlkbTlpBmd3A==
X-Gm-Gg: ASbGncvlPPwdP9IWrqdECYfw4TAV+6vB1XXOyFmXGo4GOhIGjTW7wOcXza6EA52/Wc0
	ajYMeWyoYYoRqtFFb8C7VduonV3dRWmf+2vGwOFEc+5Y7E1xEAMdHC7beTJxIlsqOir5KFNGaob
	lE4DzGdK6TkL7gZy0WmPINehROJzTAVGtYm+/gQueO+RKJ/Omyo6o+XxdJkimeKSfLRdtpzKptV
	keQXJ5TawwiYFOisv+j6VCyRpoh4aU=
X-Google-Smtp-Source: AGHT+IG2EoJMbtOR1ucq5piwVhESl5CoUICqBHxFOFrJm/XK8+UWh8f7SohCCH7p+awKgIV85Zu3ozKF7W8Y9/Mpv7w=
X-Received: by 2002:ac2:4e0c:0:b0:58b:27b:ed30 with SMTP id
 2adb3069b0e04-58b027bef54mr44123e87.22.1759359089374; Wed, 01 Oct 2025
 15:51:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250923133304.273529-1-mstrodl@csh.rit.edu> <20250923133304.273529-2-mstrodl@csh.rit.edu>
 <CACRpkdZ6_YkUsCNRFfRM1v68fpvAJcdqPRtAKTGqLqHf1geJog@mail.gmail.com> <aN1DlPjbQgzfmpUl@ada.csh.rit.edu>
In-Reply-To: <aN1DlPjbQgzfmpUl@ada.csh.rit.edu>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 2 Oct 2025 00:51:17 +0200
X-Gm-Features: AS18NWDJdyJJcLa_Ae7lK3Nrlr8RU3QkKiJmc2BQNRUNE99-LTxcVXK-WDjcBmM
Message-ID: <CACRpkdY+r_u12iLg2-niMmw1M1Wdtm3yckbby_Wo2L+_BvDuZQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] gpio: mpsse: use rcu to ensure worker is torn down
To: Mary Strodl <mstrodl@csh.rit.edu>
Cc: linux-kernel@vger.kernel.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	"Paul E. McKenney" <paulmck@kernel.org>, Tzung-Bi Shih <tzungbi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 5:07=E2=80=AFPM Mary Strodl <mstrodl@csh.rit.edu> wr=
ote:

> With that said, I think now that I've found spinlocks work, I could use t=
hose
> to gate access to the list everywhere, and use the standard lists api rat=
her
> than the RCU lists api. Obviously teardown of the workers would happen ou=
tside
> the spin lock critical section, guarded by a proper mutex.

Yeah RCU is for massive parallelism where you have a lot of (performance
sensitive) readers and a  few writers to the struct.

If this isn't performance-sensitive and doesn't have a *lot* of simultaneou=
s
readers, try to use simpler locking mechanisms if you can.

But if performance hampers, RCU is surely the way to go!

Yours,
Linus Walleij

