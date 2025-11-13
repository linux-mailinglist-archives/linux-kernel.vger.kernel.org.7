Return-Path: <linux-kernel+bounces-899122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37887C56DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 11:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 81BFF4E8EFB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 10:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D78F2E11D7;
	Thu, 13 Nov 2025 10:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2dtIEjpw"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7510A2857F6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763029586; cv=none; b=TeNSfBpvA52ePvvKKchxcugqtN7i2ckQMARN67qZF/XUrsvkmMtZ5aBaJvKMFXF/I5dqGZ93YY7a2gvTf3zdskr+z3t71ApIpVTGcNNnNSxsRwELpA8+8TjdamaluBeXv2rHxgpMoczMuRi0lyKp7sLQGxjoSDFl7SBvncVoSk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763029586; c=relaxed/simple;
	bh=y6pEkKmQUrDvPxt44l7tHq8+XpLO4nw6MEi1Gb1kcGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W/CvB4nKUyp7XT/ggXU7hWnbwMArcfEY5rt19dMzGdTK/Q7PpeWjZxsZTGHLtSkkUSRSX1LrACAz+zUAtuFHse323x5vQ7peULIbd6NuZIYuvF9mskqHbHP97zWcj7WJnxqcWsFp+jHHqgZRoXBpGgbW+juovKcKqjGa77Z09tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2dtIEjpw; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-59583505988so19677e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 02:26:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763029584; x=1763634384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y6pEkKmQUrDvPxt44l7tHq8+XpLO4nw6MEi1Gb1kcGw=;
        b=2dtIEjpwiNbMUp8AZbKJSgnT9yMeRacX4NcpcYG81Oa5M5Nnvd7rnwNiGv+mZJwACP
         RMEGaVQ/0+Np3BEXipQt2op57p+v5B6cAUqD1jQLnFrjG6bWfwvFZwSvekAnfpdE5DuR
         a3l8Rcrph4uec9OhuV/JYYPKCjsq3nAayFwBur8/sTMBnHTxAtf2l+g+fOLt0adkPrNL
         biegb8Jqhw7C8XS5QBaGyQD7Mc6ZPe72IFXyZPOZidjVZ1kqKzBx6lzMjX0mjMWBK66L
         bRPXWTJEGUQMI6TynH0pv/9wurwU0C5j7II7sHJJ+J7OtFU+i3Yv5GMSYtU+FFVrLvnX
         yOIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763029584; x=1763634384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y6pEkKmQUrDvPxt44l7tHq8+XpLO4nw6MEi1Gb1kcGw=;
        b=ieUn3IjWW1dJ5SDXnYMyia+bZczpG7V8Hn5khvIUYBVJ5un2vL+hW6ED4TX39s4FtH
         yKAUARPqrWiEOcBwBpee+e+Q6oYVix7ntpjjhdj2uW0+QQQiSoGhL49KQI7ajHaHx9kI
         JwXS1DFr2a7tgOJ6lOYBvzk5cKC4ttDXFKOzzO5XI56qN6Ch4L7fozgE3RcwVfhA6fzD
         9uaq18e2BmDansGzVMrBxn2eGTWmViCt/lImdSHozcaJQqFONNFQIND4MjcyobFMonUd
         4HW0Wkk81K4CUvuU/8bRlPeHYr/Rf0owDeitRZ9Yp4B0tHSWUHlys4WCjLvS7arAdNLS
         I1dg==
X-Forwarded-Encrypted: i=1; AJvYcCWFY6E9mZYQ0TuPIIRIqrj7RJAiUxdzBZV2Hk+DHqGjpb3JM3qYBcri/oSgoUvdRXiPdGsRuIFrY6cwzQY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2TSmib2NNB2Z+pB/jmyIeWce5mPeBgLD/Vaqd+naXeGEGASXl
	6EgnCif75SFBFAoeahYENOpJVu4YiPPSB6LpJl5yEmOv4LBa/YjR8oLXCql7aXCJ1zVbhgYL/cy
	27qLiW2eMnP2crzfbrSF3V6GpGcR7vMTJP/uKTakiQw==
X-Gm-Gg: ASbGncuMreAyoIsIsDFboJRfOYO1sllEfSNuytMFUeHiEdaV1dl4hiX6yFZxVZoLYkp
	CrK8YNrJC8pE9/6Wa8R5CfW5VFEAt8mpZZ1e5MJI2ccMqBS6nBKBnE48aHaq7P2RyCsqNCTpAE3
	V4n+bT+zg7+CeHWIW6xByTIMoZHzXA4iXIHB3O5nloRYx0Macmbu7azmqAILscRN2s6u+ZjwLvy
	nnc4/fXZdAg4U3KrEvyYA0mUny4zfjm5EF/jiwFIwvKTgP4HmyS5oh54MbwDYBmcPBkk1R/xk5T
	vERc+JplROZ45SSM
X-Google-Smtp-Source: AGHT+IEWBz0+be0FB+wLbE+7QTcc/OUWq0TgJqUkR7RRmlidFEPDPpiNSaVnc53Ovz4tW1nSH3J0cHCpYlG2Y5YBezE=
X-Received: by 2002:a05:6512:ba3:b0:594:1279:dfc0 with SMTP id
 2adb3069b0e04-5957ecc4170mr718381e87.18.1763029583635; Thu, 13 Nov 2025
 02:26:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251106-qcom-bam-dma-refactor-v1-0-0e2baaf3d81a@linaro.org>
 <20251106-qcom-bam-dma-refactor-v1-3-0e2baaf3d81a@linaro.org> <rrw7q7cmkaykng5mnyqk5oxsjednptx3yvjilh3tf5uub4nxzh@p5a4sbgbaha2>
In-Reply-To: <rrw7q7cmkaykng5mnyqk5oxsjednptx3yvjilh3tf5uub4nxzh@p5a4sbgbaha2>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 13 Nov 2025 11:26:11 +0100
X-Gm-Features: AWmQ_bkPrLo5fkHZmAca_a3y1ZYvX0iZcUyH4co_j7LpID1i-okvegYKSrVQn6Y
Message-ID: <CAMRc=Me1DA8ajey++S6_gTP38oDfJKv5CzZbgL5trDC=zT0NYA@mail.gmail.com>
Subject: Re: [PATCH 3/3] dmaengine: qcom: bam_dma: convert tasklet to a workqueue
To: Bjorn Andersson <andersson@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 5:15=E2=80=AFPM Bjorn Andersson <andersson@kernel.o=
rg> wrote:
>
> On Thu, Nov 06, 2025 at 04:44:52PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > There is nothing in the interrupt handling that requires us to run in
> > atomic context so convert the tasklet to a workqueue.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
>
> I like the patch, getting off the tasklet is nice. But reading the
> patch/driver spawned some additional questions (not (necessarily)
> feedback to this patch).
>

Thanks, I can look into it once the locking and these changes are in next.

Bart

