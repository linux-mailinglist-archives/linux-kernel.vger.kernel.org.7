Return-Path: <linux-kernel+bounces-888449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37848C3ADBC
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 13:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65C8B500B07
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 12:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FA5329C48;
	Thu,  6 Nov 2025 12:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="egRwicAD"
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA8B30EF9A
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 12:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762430989; cv=none; b=nK8UuhnCKxUmIC5tYbGxHT1Usj2Ktk/NLhRlBDX7cLEJ/SOlThqkAZqFAGNSxIySMnqXQ7vWTdlPKvlkFqZMGc0oWLpUg4h1HRwUMmyelXP2ewxckIo52g8YmKE6FKl9wT+GEg3F9Pu8c3Hg+LnLZhf22oKhooL30PEYzz6n6Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762430989; c=relaxed/simple;
	bh=C6Ce+ZO0mEsaE7Cx8L/wuA58M14xZS8f3ErBI+eFEXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f1YY4S0JvQ9L0f8m0PfOQIttMqw3u4g6xFfPVkHDJf2vUOIdJHscOrJcTbIZWPnoPWOl9w8qzw56vkfwjLNlDQJQ2ICspoFoq8kNvd/xP4SCvwxTwNXYtbEid53WU27acjQoyaD7kj5GTqu40ykO7IZWMSPSDB0LIpksl12wqMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=egRwicAD; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-63e393c4a8aso803274d50.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 04:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1762430986; x=1763035786; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5fAHYO0vznT0g25EBXqXD1U+0GlQUbOGzQ5hpcCb/nM=;
        b=egRwicADegU/4mr0h3/9OtI/hRKx7Um6pd80At7DUeLrimiy/KqKjgc3ZZ3C3YVJO+
         KZo1f5OVs1ygnv99mbs64qd/VNLLbX6Ubbu4NTnDMpKJ1BD8JIVSXtlI3eadFIFr5quZ
         Ac0d5cx3FIFDDlmIq3wBjivf7TQ+eSJ/rmxP8Vn1pxQr3WbfwdWUTM+XUvKKIoWUVCTi
         /bSFhfofUi53P8q/8V3W5+lwVTWsmX8KK63w3/upB2D0NEk1xfAGNbVd1HDDmn3/yqQQ
         W646OaiGmAxuopRQzwN2BX7VWGDmoGPXbtPISmF2kcVvtKAWhnq+5/DKlplx8f18DFbv
         GReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762430986; x=1763035786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5fAHYO0vznT0g25EBXqXD1U+0GlQUbOGzQ5hpcCb/nM=;
        b=qviN6UH4HA8REUM8qG7bezQor1rooJcsIOa+3rQoNLv9XF62TL+jZjHPOAVrRL42Gl
         0h77DKWZ8uJVXtPeaJMzQnv3+0eucrKe3Y+hVkz4aOT9zpwXwTVw0kGJSQ2v6/+M6STa
         Y6W4rJU1XcCou+8s08syhZE/5ZnOUuCEGsq7/qHS9gYT1HTK/bqh+Z8fib4GanTE2tjG
         jaUSm3mgg2kfZC98Eb2L01l2AOvVDOTAnyR0tP8EXQdJnRCIh79Os+rrnLQza/nVa3Ur
         hBPCWRRFNDhZzr0JmdKkvTgnIC4GE81hd99vLyyUgr1H0pxVKv0gTcOSGSA/4ezFrvh9
         Vmkg==
X-Forwarded-Encrypted: i=1; AJvYcCVpvv0HL+Cpb7vakf1dXG/zJ8VC2McXeqAosTjKHrUeqLW3rc35akmla7EpBQantRZEu3FFeCDR/jjM70Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQNJMNxjTsUsXC+AveTlyNNaMZvDnn7T99L6ZwQqs+0rjsOly
	qilOSCSNeSyfcDmBjfF+Nh9SnbfE7VA15dtk+UF5J0sGe+ts8GduwWHsogOiv+vFXdsOwgYHEam
	P5YZlU+TKFR3Qsz4HUMvb0P59O3YQw6VvsfjVH7LSEgRs7iHbJY7E7lQ=
X-Gm-Gg: ASbGncvmcg66ZgS7B/LGvQVePiaMjoS7i6Q2aJ+8b8iqC3b0hd1gVoKWh8ScWYGfbpa
	SHgRiRSaRlffoIOMfRk8yakOvAOUJUoi3wPCAXD6ipuG2AbHXGtYL157iGZrTeFi3/gGmiyAjQl
	DAdXdXoMzHtwtMc3bePgiTWWjO5Jf4jYrFOdg0EPba3PGcZASECm2hMAROnEVV9jfq8c3+urHGS
	MUrfOaHXVqcIbgvB9LrYS4C5JNAMpK4Trnf74vg0cAVzqakXDE1M4Ui15KHCNhf6uW4DmnfnZS2
	TZidsfArXDjVexmvUWTAQUtbxMLcbzxW+HFfzA==
X-Google-Smtp-Source: AGHT+IGsB8/DdmCBES3V2GJ1bELwAktTLnUBCboM5BIAi0lovOyj9pkaUxrDLh6s1hkCmU80s0JWmGjvGxLEutcjjLw=
X-Received: by 2002:a05:690e:1599:20b0:63f:a7c0:cdab with SMTP id
 956f58d0204a3-63fd3572a89mr4655581d50.31.1762430985989; Thu, 06 Nov 2025
 04:09:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251028-b4-rpi-ov5647-v1-0-098413454f5e@ideasonboard.com>
 <20251028-b4-rpi-ov5647-v1-2-098413454f5e@ideasonboard.com> <qoqzelkspgqg5nuwyklsukhxq56noa5hnecp3f6r4xu2y3tuhy@n2to2wxwldqp>
In-Reply-To: <qoqzelkspgqg5nuwyklsukhxq56noa5hnecp3f6r4xu2y3tuhy@n2to2wxwldqp>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Thu, 6 Nov 2025 12:09:28 +0000
X-Gm-Features: AWmQ_blJYJ_1Nl8qR1pcdTc3_05ydgJmZ015Ax7E4TaWJGDmFY_EyjElgysqOaY
Message-ID: <CAPY8ntCVQh-oQyU7Q5AcLrD=1M8kq=S=JFde4d3krtM64DhMJg@mail.gmail.com>
Subject: Re: [PATCH 02/13] media: i2c: ov5647: Correct pixel array offset
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Jai Luthra <jai.luthra@ideasonboard.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Jacopo Mondi <jacopo@jmondi.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	David Plowman <david.plowman@raspberrypi.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Peter Robinson <pbrobinson@gmail.com>, 
	Stefan Wahren <wahrenst@gmx.net>, "Ivan T. Ivanov" <iivanov@suse.de>
Content-Type: text/plain; charset="UTF-8"

Hi Jacopo

On Sun, 2 Nov 2025 at 10:29, Jacopo Mondi <jacopo.mondi@ideasonboard.com> wrote:
>
> Hi Jai
>
> On Tue, Oct 28, 2025 at 12:57:13PM +0530, Jai Luthra wrote:
> > From: David Plowman <david.plowman@raspberrypi.com>
> >
> > The top offset in the pixel array is actually 6 (see page 3-1 of the
> > OV5647 data sheet).
> >
> > Fixes: 14f70a3232aa ("media: ov5647: Add support for get_selection()")
> > Signed-off-by: David Plowman <david.plowman@raspberrypi.com>
> > Signed-off-by: Jai Luthra <jai.luthra@ideasonboard.com>
>
> The patch is correct and match the datasheet, but I wonder what the
> implications of having a wrong top were..
>
> I see the full 2592x1944 mode declaring 1944 lines but, as the top row
> was set to 16, it means the mode should read 10 lines past the end of
> the sensor's pixel array..

It's not used in computing the register settings, only reported via
get_selection.

A user of the information from get_selection may get confused by
OV5647_PIXEL_ARRAY_TOP + OV5647_PIXEL_ARRAY_HEIGHT being greater than
OV5647_NATIVE_HEIGHT, but you'd still get images.

  Dave

> Anyway, on the patch
> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
>
> Thanks
>   j
>
> > ---
> >  drivers/media/i2c/ov5647.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
> > index 985a8e81529d2f88cb38ccb8c94f8605026a28a9..4fed655f5a11c38e76d1ccc9ae9155cf945684ab 100644
> > --- a/drivers/media/i2c/ov5647.c
> > +++ b/drivers/media/i2c/ov5647.c
> > @@ -69,7 +69,7 @@
> >  #define OV5647_NATIVE_HEIGHT         1956U
> >
> >  #define OV5647_PIXEL_ARRAY_LEFT              16U
> > -#define OV5647_PIXEL_ARRAY_TOP               16U
> > +#define OV5647_PIXEL_ARRAY_TOP               6U
> >  #define OV5647_PIXEL_ARRAY_WIDTH     2592U
> >  #define OV5647_PIXEL_ARRAY_HEIGHT    1944U
> >
> >
> > --
> > 2.51.0
> >
> >

