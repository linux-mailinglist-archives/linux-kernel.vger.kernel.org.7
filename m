Return-Path: <linux-kernel+bounces-896565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEE4C50B07
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C84BF4E948F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1842D6409;
	Wed, 12 Nov 2025 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0Qhc4Ge"
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8ED4A35
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762928449; cv=none; b=ovXfOWioWXay1puVKMbP8mx27YCYXct26/hFXU3sJQFTlyD4Qdu2GphsyqMjTLieQ/auJ/ekpiU6rJC2/BiLd/sCOMVcEnNeTnNx2x9G+LQ2+5xkw9tt5sspOqOPELAgU+Cbr7ZCHoyIdGWzha0W93Lenh/lEBEjAaWqCaom3ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762928449; c=relaxed/simple;
	bh=l6/Yg2TiR/T4ErsHWBR3/ccAesa5qWuOq/0jwSBFVRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RauZjndyJ6XMgaOwuxB61Ip1Px7AYNRq3dIwkxZrTwJU3affgVywyfBcE0EztEk3iiEvM+hjhGOAizsNu8vBCwqz7/DwaTEl5qvNvcBQPFwR0cKw/+S8QPe+c+unOvjW6FfQgqAjK89kAcDcxiUE9bI/iGqfP/5BC5LkV9i6Cko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0Qhc4Ge; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-63fc6d9fde5so479106d50.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762928447; x=1763533247; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l6/Yg2TiR/T4ErsHWBR3/ccAesa5qWuOq/0jwSBFVRs=;
        b=N0Qhc4Ge9nQw4/GchLmAm76/gS1Pyrh9kW2gLEPsVFH1DW1g+vNUrJf+OLjAHEB7hB
         V6bEvEkApfZT1snFxFwxflSktELoOTxH2ges+uajYnO6DjGdHznu/Hi1ef+RFwKZMi4L
         uV2taaC5Chh/Kn4hhLshcptP/Orr2Ee2dKMrr3XoywEPQ09ntJfi3a/w3aljmULiAKhf
         KP3HaZFtAP3LAvrKX+vLyEp3nWGuQnKn5g4n8IMn73gOzJXFtoW7tDE/7O6XE4JHtJkI
         mLlMkF7rMbvwYZqOho549WWAMn+JFTQ8DrSPEi+Ql9yuxjsXzcVxXDrQFMY+Z73cHHb4
         DQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762928447; x=1763533247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l6/Yg2TiR/T4ErsHWBR3/ccAesa5qWuOq/0jwSBFVRs=;
        b=BvP7MWVrNYWNqorDyR+P49ZtrH4yQyLtCGQlB/zZFjvkO+VQ4yhFOaxZOqa3+9pmLi
         2kzj7X+ZEMoRpVVtwP3rRYWvXoILzNqBlbO9K4gsZd3Z8O+xvzZHy2oAVPaXYJbcGG8z
         0wEgXzfgncgk9QGD4CgCGwPkveYLv+WusZU5rRy5olvQnhDcYtl9RDW+kSu/O6OK0/Vg
         WJg3tLk9I4kpmYPHdWno6wvxjpuYMNmjlWYgsf5rzOzv2M8CJD4j8Nr5Y2ofqWaTELyo
         zi/+Pj+o7AKN+u2PXTHIYU1L6meQPzojXuexeSnzaVkuSK3DEP+epVewwjKJ5OQoWJn1
         buVA==
X-Gm-Message-State: AOJu0YyCEaWUtZRxxIcTupjQZShsq+TM54mPIK3kBOXGE9xuO4E2dVEF
	51qS2DIOmiu98iOp1nC1MKP4BcS1k7VzvXHU/FVDVS/NvcZGRZJkyT0J3ZvoFkaLBTQeGKDzOWt
	GD+EqaY9EbGQco6tCrAbFOXxm1DxC+lXypQ==
X-Gm-Gg: ASbGnct428wyVs/+jQ8eBHWlRAICC7HyXzaRPUANLcpADD2RkqA+/WWdLMoC4OZ6Uln
	n1RZhJiXzbOpe6R+/SYoCtba8+njImXiBlf7dLhKaunNtYF/VSheJRByZQIMGdKWxu65lhn4cCh
	kF1lVwhy3YRwCUTmojybOF+IQU/72sNG4dv4TNBAuNgA0dyPOaQS00AHvGKhnCJ8HzOCWvXAHUz
	HlNEjLoF3THzpCBfEUyPcyq8OjPo6G5EdPWheeADlR0TBNrm4GlXhgkOoFBfb58/DrgEATc4A==
X-Google-Smtp-Source: AGHT+IHhc3M2buddmSMFCFvMb9QmiYHhj1Yp2vQgkXxo2X/+/bGNIeGDzAIq5sTC5I58QmUyDfa9lANbkz9oeSiJvUY=
X-Received: by 2002:a05:690e:d02:b0:63f:b6a4:bd24 with SMTP id
 956f58d0204a3-64101b377a7mr1661180d50.48.1762928447064; Tue, 11 Nov 2025
 22:20:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251110212400.282952-1-rosenp@gmail.com> <20251110212400.282952-3-rosenp@gmail.com>
 <2943cf05-78a2-41dc-91b9-74cf959586b0@kernel.org>
In-Reply-To: <2943cf05-78a2-41dc-91b9-74cf959586b0@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 11 Nov 2025 22:20:36 -0800
X-Gm-Features: AWmQ_bmuIzlVKh-0YdxFo0cOSn7JYaSP77htWjkbR-2_HPDsSz7Z2lxUFWAXQ1g
Message-ID: <CAKxU2N9hfZP3K8_g5DXhevqfKBqUGAxFZLi1s_=-FBcpoeR5Fg@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: stratix10-rsu: add COMPILE_TEST support
To: Dinh Nguyen <dinguyen@kernel.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 7:44=E2=80=AFPM Dinh Nguyen <dinguyen@kernel.org> w=
rote:
>
> Hi Rosen,
>
> On 11/10/25 15:24, Rosen Penev wrote:
> > Helps the buildbots catch potential issues.
> >
> > Remove ARM64 dependency. ARM32 can build this now.
> >
>
> This driver will not run on an ARM32, so why are we trying to build for i=
t?
I was mostly trying to get COMPILE_TEST working and compiled on ARM32
to make sure nothing blows up. I'll add back ARM64.
>
> Dinh

