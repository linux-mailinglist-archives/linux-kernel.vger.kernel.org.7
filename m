Return-Path: <linux-kernel+bounces-888114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 29909C39E10
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 10:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3C9894FF77B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 09:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0093830DEAC;
	Thu,  6 Nov 2025 09:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5EsMDxD"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0DE30C61F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762422074; cv=none; b=KvSngK0vs7qtstj1UKRyfyhYbBKqCidkyVWldhoN2EtMyI1BKUFzW6rrwv+7VrvOzeTqYWOgI8GxQaQSqsiGPRAa1RKgoRKGctMcY/jeSbTZzsUQ9pn+at7t5MAbyLmK5WQIk0nt3oTulBFq86nNslSkcXdMBwtc0/h87X1TgFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762422074; c=relaxed/simple;
	bh=RKJbS+3Og1qBZgNICKzI7bLri5edv7amSAm4JK5iL44=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Fcr5jkqr2x4ZyMTCiN7DJPNkTTGlPB8GChXDKM5Q1NqPnG1DoMvNEzMgGJfsE+5egmyPVbAcB0r5iO6xmUwGTZDrBbzqsBjIxp6I9Nr5ZVaWtlFHiRfS2tvb00SmY2gr1b9AZbF/b7ne14zIhpnIQwL4FFwP2/bfcQNdcTXNUnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5EsMDxD; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429bf011e6cso727471f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 01:41:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762422068; x=1763026868; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=RKJbS+3Og1qBZgNICKzI7bLri5edv7amSAm4JK5iL44=;
        b=e5EsMDxDROfFj7UL/LncIzUA3+J/nWnCLVlJe72koYYD/9GjGXkmQqy6FM3RqF0uXi
         +NdZ1Jr/Znzg+zurhKIkPAqgwDsJ7mNXm67jH82vtk7AZ3cB+r9j+xGqEdZASlGStkGI
         4rPz5frJKOP0xHyAJxT9hRIBJR87EvWKFkw30xqt+N1xi3uBEgktj5ywWVOQA3trP7Os
         3AqCH91YLeTdRlNTgqqq4253cXVAeUQbB6aBdJnMT9+PmURBkOH2O8iuVmpXceyU+XEi
         krsyc86AbmqEJnIQHdjK41mxEzu5UdL7cQMeWY4ZY1I21p6XS4wQ3M+sL8CUrj2vFJIn
         au7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762422068; x=1763026868;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKJbS+3Og1qBZgNICKzI7bLri5edv7amSAm4JK5iL44=;
        b=NPHBP9vZQn+J7ulZYo8/zmdWFH8bnHMp3XwrCa8KZn1lYNaT+p3TknMkNca2QyBUri
         LwOy3gZUgH8fTfwUAyIMzgs8g0PHmacjnP5XGadbZhkapxa3dMS11ogEjIw+6eVXq7fF
         JmsDM6CVMHi4FxMcoitXwmLIW554DZmRD9RLwBWVGoalzx0Z2UTCx9gjGNWiGb9D2b8D
         aKx4tmYWvOxPLo7jzGme9mnjf70j32MsrDyOs8YVZB/5wqcb0ZUPXAlEnKbGvNYryfWF
         o4YDD6Q+7GRS1XNYxTGO4wlCs8quWCAMLLO9p6bnovtmwFFSE8bwcd28Vjnx20qVlx2z
         EhaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWj46ji6aCjJs3UJtJkG9vdWkQEQ4OYNIn/BsVGtUKGuGOf9VaghHX967gR22+g/sJXVg6KrlMt8iLgkL0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRuSsYcVxBUCDvA/yTUjUPqRghYEZtZejLz4vIiiRS2+RjYxUC
	abwjCwjhZuA5tciuJ8DXq/22VnByMI9tQcjNY7ApshlKFYnf8vbU9czI
X-Gm-Gg: ASbGncsAO8cioeuFKf4Fem2oIyEnIegQftDp6qz1kBOP0LF72sdD4cI5Lz5Qg2jg5KY
	Robah9vvabiBsB8S1Idn4pSI5qmpwfzJaqd4GWgncDW/ssdnZodmHSJa7XcWq/Ta1X9nT9nRuSL
	df62MvnnJLTPPpAX7Sd8xK/f4YNoZV8UO4ZG5hp4b95a4EDe4XM41WE1KH0YKVxUDVnYW6PYB/4
	BYHTnWLRmkasaGX1ZYU2yWf3Fu0aJIlfBOVQO7KzS3qckc2tTw+SZrKXVrg/J2uMELTsl6Ws5IL
	GPUOKvfilGlrdQ1OqS6a7Z22+D1i9UGXwwbhvzNA84YojwoO0WumUPf1oTHWo/KR3U9/1oVwFkq
	htDRSR9JOeo0cghxQzaiSyC/hcFPPOoCEtOoZQILf85HrVL2oFv2Y8fNV/sIpydvLpawMgTfmfK
	sO5ucC
X-Google-Smtp-Source: AGHT+IF21ozos7qDutZAt/g/NvKo+hXW9YgEZlmxLNCbCy/dsSjMoZqB47HL5w20yrKmfk7J5t7S6Q==
X-Received: by 2002:a05:600c:474f:b0:477:59f0:5b61 with SMTP id 5b1f17b1804b1-4775cdf455bmr64248505e9.2.1762422067762;
        Thu, 06 Nov 2025 01:41:07 -0800 (PST)
Received: from [172.23.94.183] ([136.226.168.195])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ef2d58c2sm1990984f8f.16.2025.11.06.01.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 01:41:07 -0800 (PST)
From: HariKrishna Sagala <hariconscious@gmail.com>
X-Google-Original-From: HariKrishna Sagala <hkrishna@gmail.com>
Date: Thu, 6 Nov 2025 15:10:33 +0530 (IST)
To: Mark Brown <broonie@kernel.org>, hariconscious@gmail.com
cc: lgirdwood@gmail.com, peter.ujfalusi@linux.intel.com, 
    yung-chuan.liao@linux.intel.com, ranjani.sridharan@linux.intel.com, 
    daniel.baluta@nxp.com, kai.vehmanen@linux.intel.com, 
    pierre-louis.bossart@linux.dev, shuah@kernel.org, perex@perex.cz, 
    tiwai@suse.com, sound-open-firmware@alsa-project.org, 
    linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sound/soc/sof:Use kmalloc_array instead of kmalloc
In-Reply-To: <fad32f5c-f9a4-4cf2-9082-845deff309ea@sirena.org.uk>
Message-ID: <9e808d38-c720-fd59-8bc1-d1da6255c59b@gmail.com>
References: <20250923142513.11005-1-hariconscious@gmail.com> <fad32f5c-f9a4-4cf2-9082-845deff309ea@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 15 Oct 2025, Mark Brown wrote:

> On Tue, Sep 23, 2025 at 07:55:13PM +0530, hariconscious@gmail.com wrote:
> > From: HariKrishna Sagala <hariconscious@gmail.com>
> >
> > Documentation/process/deprecated.rst recommends to avoid the use of
> > kmalloc with dynamic size calculations due to the risk of them
> > overflowing. This could lead to values wrapping around and a
>
> Please submit patches using subject lines reflecting the style for the
> subsystem, this makes it easier for people to identify relevant patches.
> Look at what existing commits in the area you're changing are doing and
> make sure your subject lines visually resemble what they're doing.
> There's no need to resubmit to fix this alone.
>
Just reminding for an opportunity to check this patch.
Thank you.

