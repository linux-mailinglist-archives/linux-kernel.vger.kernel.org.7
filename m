Return-Path: <linux-kernel+bounces-898988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6A1C568BC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 66ACF4EC78A
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 09:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2311A2C2343;
	Thu, 13 Nov 2025 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="XIfAo3Dn"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5A3286A4
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 09:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763024574; cv=none; b=bqomqZ5JOnonk+4b2qTrGY9X5ElEdSoifduhfgqPuRn3RpMqVbataMOcCug2YApUsyqmwHDJeuHwT+brNKF1g5UOXEyoUU81zvpOOCkHAh4cPSxWW++nXfNs70iKjM8ReR2f6hhT9obiKAKRnsDuPj/l3QHA8eKVt+6+7Ap80Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763024574; c=relaxed/simple;
	bh=+2aYOVpOS5bBgpP7Z5YXww2cJhfLh4MenTeNlSJM53g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X8b9g6E8nzm+CIFG+ZjSiZPfGjFosdy6iYLFr4p+c6ddWJY9o6kFixu6d8NFl0v7ycpRHteo8MK9HCsRV9f5M8s6FJneW7YSgFJTsb+cN8OpNLpKMTH7nHfpDtyBD096tSCx1l6Z0R/pHc2Jigu+VrNzkiU/Iryn1RHUJnlUBtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=XIfAo3Dn; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4edade7d5baso19365751cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 01:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1763024571; x=1763629371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TWvOwrM4EIFLxWTAr9N2lYCmaASWWMPDLvVsazXwlAU=;
        b=XIfAo3DnQbdgRZ533BrkbyDd6ceYsOHsMztLiOcA4ibD11yYlXplJM5IdOhFjnyMyM
         catAXak8nPRgDPdygw4thx+SfVVbVc802MrpPYkGM5OFcWTIF3rtjETH9NQeVFxhUAE7
         zZ2bAIkO7mUZVgidSAhb8GV+y9nhjDPLsjmWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763024571; x=1763629371;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWvOwrM4EIFLxWTAr9N2lYCmaASWWMPDLvVsazXwlAU=;
        b=sGlJ5GpXsWffAi6K4ZuBO5SBz9i2XbxTvONiBxMz8GKfhLoqL1JUtyquQzHcjsauDY
         ekTbmSKM2vMj6s0Q3hVoOoMAsUOKFfr6IDwFm2hYQw5Wn4Sv04VBUpkpAOEDY/qzzhYR
         q1VACPa6CDVm6NGisbGweiEcNkTyXoHwiFiHbkx3SY1KGRtGj3DDEctDh9HRxk5AjVAO
         jAvn6uWRA3xgYkY5ikqp5mbzaVHALiE8APyWKfC6QDd+oORTRXp73muY2bwgi90bi9aJ
         f+RJ92SCiU0cFHH4oMzLHqqeqs12T11ALj7Tld2vVwFTkk9lB6KZIYyCf3tXeaejSfKJ
         sVzA==
X-Forwarded-Encrypted: i=1; AJvYcCX7jOUKy6GZ3dtwQ7WQmElaKZvaDI9W2YvQ5bmm3/5okaFSTee+hvgqSJAmLsLnHpBbr7fLC5aD4bSZVs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNzXTHgqzxSxc6yBuN37POwUBMr7hX5ZHlwm+PZLiEaT+Q9Ypm
	owPbqm2ZNB7KTVh53l8UPM6Q89L2zebtFjfGsY+ILy9+Zfr/LI5Z3zg9Pw9GZ/aUZpUSeYFoYJR
	rdqnufhcjwgeb75ZIefDy/BJDgYjNLpH6BSrd3+fUCw==
X-Gm-Gg: ASbGncvfHpu5r2XCX7bZaP1w9mXuTDb5VM6HDBemBnsOInggoqJfKnrg8Dat6tvg0fr
	EQUcjbHihwjsExyNgQa+8LV8uIKDe4/nE6e3eIiM/Ua9ync6rjhtKpK++HLjyPcna4KSLSx77dN
	jDYtPvpxlFTuWQX6C9RXs5G4kf03skByNSw+Eada8ZHXUMOYreWEk4j0PcQpHd13IrERx+3iHEa
	y69uX3UUHNyk+oBBYcdZ4RRa+eSi2jZmanGd3UOeuMI4SkQalBX56zvPv7H
X-Google-Smtp-Source: AGHT+IEo1Nrj0O5OxCHbv8cWBfGc+J13Y2GimQJ/FIKMlV9fnh+jQ1vE/xUUtYsbyn/r3EbawVBwW5rbh8Q55a/XjSI=
X-Received: by 2002:ac8:7f50:0:b0:4ed:ac1d:42f1 with SMTP id
 d75a77b69052e-4ede700fea0mr40311301cf.16.1763024570563; Thu, 13 Nov 2025
 01:02:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916135310.51177-1-luis@igalia.com>
In-Reply-To: <20250916135310.51177-1-luis@igalia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 13 Nov 2025 10:02:39 +0100
X-Gm-Features: AWmQ_bmGnANqif2wG0mv6prd2r-EgODLdtrh0KU2w2tK4xhsFaImIUtLHlAvyxo
Message-ID: <CAJfpegsy78ZMkodX2+1Y9UiPZwY8dixstPtdcK0A3XphXxGbcw@mail.gmail.com>
Subject: Re: [RFC PATCH v6 0/4] fuse: work queues to invalided dentries
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert <bernd@bsbernd.com>, Laura Promberger <laura.promberger@cern.ch>, 
	Dave Chinner <david@fromorbit.com>, Matt Harvey <mharvey@jumptrading.com>, 
	linux-fsdevel@vger.kernel.org, kernel-dev@igalia.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Sept 2025 at 15:53, Luis Henriques <luis@igalia.com> wrote:
>
> Hi Miklos,
>
> Here's a new version of the patchset to invalidate expired dentries.  Most
> of the changes (and there are a lot of them!) result from the v5 review.
> See below for details.

Applied, thanks.

Miklos

