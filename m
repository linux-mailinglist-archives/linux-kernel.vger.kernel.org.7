Return-Path: <linux-kernel+bounces-862667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 734E5BF5E10
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 12:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81B318C33AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FAE32AAD2;
	Tue, 21 Oct 2025 10:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NN1V080M"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE712F0C7F
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761043794; cv=none; b=GqyqzY5E1/ErOcBcuqjcquw6VewoeMhtbX+jxiWRNN6VJRk5GQRCbWoYeBFk0EZwfJ+ulJ4FG4b5TIEUU4jb00brjhPTaGNf32crV2viqcrIQQKc48aU1TmwZINKmYi2UFYnHbaTBS7M+tXz2c/d9HYYaPED2GObODCiY7NJGnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761043794; c=relaxed/simple;
	bh=tibOHuElsdn98IyG9GdCHJwfonoWwofOLVF9QyGZnAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HR7fAnNtIboOU7pMzPLcqBVRRa2DXsX9vYxBIxN8j/dE9JshexVPk7fkBro+WYBIWrMV0ntOCaFk7kmusSh6yEHHavWsS53TD8gXMmMICryPONtcoYtaYYsCZPGIk8Nsa44FakkRFDDD1xnX5KK11/zyliyUSosqWw0QWUAEJCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NN1V080M; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-591ebf841ddso631865e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1761043790; x=1761648590; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5mx/neDnkeSOkePEkm6VBEHII9lIyY01G34R6H9ZvHM=;
        b=NN1V080MvgfvUgCw4iMvVPVFlhUh1UsQKu39jqYzNyNVTXRad+qO4dibOIdUtGsSKq
         RV8RB5l2HufHgvnxiL4UgqwoVzC5R+O/ahYOgOoT7v+r5aYUhOw95/zkE8d1dadLM85b
         6BDjGpNGJFMdjAnydVVVz0Bql8xBSGa841O5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761043790; x=1761648590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5mx/neDnkeSOkePEkm6VBEHII9lIyY01G34R6H9ZvHM=;
        b=uShEMdYRNyTUUajm91lVHgE3WA7qlZDHQ7udqiYaeZgMd7PGrQswYsqLJ7VPybk7/G
         95Ki6oS2PulBYj8zXj163rQd2Kh/rZTfZ1ojiaqV8Mmin4tFn0fX8t8zbesc0izMXN1M
         pkU4Js6SZ0OhmXW0SW/fBFrYOq2/op3W9HzxeBPXLUtoX2S6rhoZnd2Tuu7/dJfuOpat
         s0NinPmjh6RI3471W+1wXRHDrmvUrbEzareM+xJ3C4SIwgLv4Oq1l7fk9MfiTw66/Bv2
         L0bWEK2bKnMAAVOhgJFnCBXu4G8dYgA1L7+vLhgFt0/Y97bHYhQMRNxBcV+KjyYHdJg8
         Tr4g==
X-Forwarded-Encrypted: i=1; AJvYcCXwdZNhKKpLxAFBuFrY+1pOD0txepmJQb4Qdyw1fPeyTvAgbmfl5+IPYtsPfhxVrmr0VsjG0gE+h8r5tzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6RuI0hL23WGPuOLpBT4EaI4XOS4f5jRxe2SOV3cipubKrje64
	6zUtFeylt1kZbKEgm4ICsaExrBEtki5jrrcRgJ6N8TgudScd/61tuN5BK/4M/98V5ksRJob8qEw
	6sQo=
X-Gm-Gg: ASbGncsNZz51JL7kb0bszT2dxFy1dVPHSYy93P1lHeDUEB/z1s3dAU8IUrZN2tCCmjV
	+PWL/f885Nyi8hGuVyH478gNchr65853r4SzXkc6XDmzkMGZN/xFSFQ8EpwTMYhxwsQx08HYq12
	vteD8ZI7Mv60pr0IOQF4z8uuu128Wc5VzbxHOx2b2MyZRH9VKifgyFbJ5s13i4uHIyXOsHgDc+i
	jLls9dxWQB1MLabNEzfeVHKSLKbf107y25m/l0+94wOoZsT0zcbElb+A4Kv1rfE7KTs0eieHhms
	mPVP8v8aix/INYnIfh+wwJ6cpG5HG52aotVDykfKl6O6acmqGDaDwKWJ25f004GcNIOTyypqJEC
	8LCAmaPsyn906/XJi3iAakh2oh5U2pXkhhOvmBD7KhcTtVLg4WSSHn0YHMjCR2SFMHVTvJSI7HB
	A+BbDlZ0SAD17TnOl1jpSrOj4rcT1654wwHJBDlQ==
X-Google-Smtp-Source: AGHT+IELRzhb9+DhwxNvz++1e4SQ54qKvUTvtWNnSbiv9f715ktgLtX5pvcer6BzGVdIgEzPL4Vj1g==
X-Received: by 2002:a05:6512:2209:b0:590:9a11:9c24 with SMTP id 2adb3069b0e04-591d854a564mr5369233e87.13.1761043790337;
        Tue, 21 Oct 2025 03:49:50 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def1ece8sm3523096e87.96.2025.10.21.03.49.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 03:49:49 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-57b8fc6097fso4995858e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 03:49:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWTC4mBBInuUrYuDWXG3aT1Gq5xcdryrVcLuvkNwOgvl3Kzxai1NWR8ELXWhlWg3r0TWjK5ztBXSR2J9nU=@vger.kernel.org
X-Received: by 2002:a05:6512:3e0d:b0:58b:151:bbff with SMTP id
 2adb3069b0e04-591d85aa15amr5272096e87.53.1761043789249; Tue, 21 Oct 2025
 03:49:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251020-imx214-smatch-v3-1-2c9999efc97c@chromium.org> <aPdPyc6Lasmp3EzC@kekkonen.localdomain>
In-Reply-To: <aPdPyc6Lasmp3EzC@kekkonen.localdomain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 21 Oct 2025 12:49:36 +0200
X-Gmail-Original-Message-ID: <CANiDSCukjH51Gi5S3ra6Jm_kPWhkrsTPGf42DurC1Mvrd3XMnA@mail.gmail.com>
X-Gm-Features: AS18NWAABhg8E6YVAmQ2J8L5-lvGKrjzv37vA3BgSueW2qvvpDq7brmdJGeLTbs
Message-ID: <CANiDSCukjH51Gi5S3ra6Jm_kPWhkrsTPGf42DurC1Mvrd3XMnA@mail.gmail.com>
Subject: Re: [PATCH v3] media: i2c: imx214: Rearrange control initialization
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Ricardo Ribalda <ribalda@kernel.org>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Sakari

On Tue, 21 Oct 2025 at 11:18, Sakari Ailus <sakari.ailus@linux.intel.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the update.
Thanks for the prompt review


>
> On Mon, Oct 20, 2025 at 08:18:13PM +0000, Ricardo Ribalda wrote:
> > Smatch is confused by the control initialization logic. It assumes that
> > there can be a case where imx214->link_freq can be NULL and ctrls_init
> > returns 0.
> >
> > Re-arrage the function to make smatch happy.
Re-arrange the function to make Sakari and Smatch happy :P

Best regards!

> xhci_hcd 0000:09:00.0: HC died; cleaning up
> usb 13-2: USB disconnect, device number 2
> >
> > This patch fixes this smatch error:
> > drivers/media/i2c/imx214.c:1109 imx214_ctrls_init() error: we previously assumed 'imx214->link_freq' could be null (see line 1017)
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
>
> --
> Sakari Ailus



-- 
Ricardo Ribalda

