Return-Path: <linux-kernel+bounces-782487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D737B32104
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 19:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC4FAE7B26
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A22312826;
	Fri, 22 Aug 2025 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="XfQbI8zU"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F2A285050
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 17:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755882281; cv=none; b=qfOBKwJWKiyDaHbZStFmO7wjmGIKY1WE58GqoY6dFZhUe53ElvyzeeGWWcoxfcGD/HkvMLU8gJg7xcyqK7CRZvJRLJUqGJ53PqSrMssDgucxSNgjNZwn0foLwfPXFGOAVmn4Fl1Tz9ufGL3Tr2+jQYzgZET/SWVTYW74yJjZ7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755882281; c=relaxed/simple;
	bh=5dfaUAllvYL9ZgEKiJLevm9at1ZnpgDDAmK6vElqIsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ajMmvgP6x6wV6gGnVyKNOYRULESUDmvuwZfEgORJuHM6YkK/JIn+jaynHgZ1QaxfoBw51FVnXsRdi4/U3n8z8P9zHdvJBbtG+c/nmbVap/krRWQRq8YXKD3D48LgWTGSFrD12lhXQz3I2NztWRulvQFDbHJGe6PhsceoeS3c5i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=XfQbI8zU; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45b4d892175so10652735e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 10:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1755882278; x=1756487078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6ruBVDj+qOB6imevgf8x/SkAW4nSEvcagJ8QJX1Gamo=;
        b=XfQbI8zUxpgJTmv8XIbtSrpY/gSYzvuX61lI4/gG+UoOzBmjy6my1WpBoBgDq//WtY
         W1PBTSsbmV3g4KMzoNnpf9bupmiIA+AeQ7UD0slkykC1YGd6D40Mh6csEo0XGfVBjMjA
         VjDSwje7qCTuvWT+FUupzSrzYOeIxIfmubg/AMO1Os9HhtC18flnanpVOZ+shOuoS62Z
         fefgoaI5ex/YAdE8PySN/WAi0VKhU5NkDqmFOTXc2KnYb1fZCp3RHTBlzyfRHJi/plvl
         c/brlce7+Ko/7tASUAF7IZLoimHbXVRyKVdYaRlZVQfq1k+rkUBU118+rTNmAWSqyW9m
         SD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755882278; x=1756487078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6ruBVDj+qOB6imevgf8x/SkAW4nSEvcagJ8QJX1Gamo=;
        b=pXtqZSyboB8g1lRpYqrjgew0G58SHdXFlegXRG5l50yqUomilz20nefuXY1jCOjFNG
         rxZLw20H8WNfnvyL1xH1QS7qfM6WdX8qGf3bjMfh7ouEvQUeXAE7f9A1GjtchgvpQ6U+
         eBXW3VnvUc2q6tJRpmEJWmHzJsFLkHKxYqawbVlboYleWv1Q1Hm6e+h52Zk7xSy1Ta59
         MzQtSe5IV0K28yL2aeBjGsUzXznRuvDU/KP7/WC0s2hFsieLrs8wpKQ4/cc5KfDlGnTF
         TBA9/9Ku12T/7gk21EeCrDudnvaODeX5lFO0uEh94GOKja2PBD/VMNdKQGXVTHAOBmHx
         xnGg==
X-Forwarded-Encrypted: i=1; AJvYcCV9plq5rRmPDK+6RGshabDZ+jkMGljIWcFwwsxnn8adsVrkULtzqugnw8uK42Oq+Fj3n+aaDcdKqkA/dMU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+7LkI2KdyZSCDKREVr6FiJhBfug+/bV6aG45x3XAToZenWrvm
	cs8GovtVlzN/0kAz1mk8VXwwFh+kd5CDjeOUJnWePWs0/PAhfGmy7cYyn4QTSySSIHs=
X-Gm-Gg: ASbGnctYMH8J3wB2/aL+A5FeueHaeFmFW5uY+OK9e3y9L4ZBX/BQr6HtuNE6qErjc+W
	jzHKU3AD9urd5fTluLSyRkQGrBnDtBdx4PhzKknfYdSqqlsElyHPfMELOi/4TZobEmN8hNasdkI
	XD5gAx/wHyK45kdCSWoBYwWbDKHbgo6TJrhbDs69lcAUOmxmE5EJpecEZhSPZdeWEvVEnfiZuWZ
	qdvK0FJgkvXht3xwMSLgaf6Wc0mlAEYqRvl5Va2qPdBm7uSydd3egGnbYL1LP54go8TjKcrLfJD
	9gxsM1OIPjCLkuETCR9JIwZkJbHeGzPF6Xmmmlb5qYRQfvZIackYa1z15B62KWtUo6kRGIFlnY6
	1iRpDVGLpck3MK1qL43gHlIoL+CSnytmF2jPIivN4
X-Google-Smtp-Source: AGHT+IGJm120I2fO6Ejvhyi0cL/lXZlUxGg0+XxiLpAUXgJGj5+mlfzbh56yVxIwk9g2fimpHbnuYg==
X-Received: by 2002:a05:600c:4586:b0:45b:47e1:ef6b with SMTP id 5b1f17b1804b1-45b517e0104mr29338505e9.34.1755882277427;
        Fri, 22 Aug 2025 10:04:37 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:c77a:e59e:20e0:4966])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c711ca61d8sm160312f8f.61.2025.08.22.10.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 10:04:37 -0700 (PDT)
From: Aliaksandr Smirnou <support@pinefeat.co.uk>
To: jacopo.mondi@ideasonboard.com
Cc: conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	hverkuil@xs4all.nl,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	robh@kernel.org,
	support@pinefeat.co.uk
Subject: Re: [PATCH v3 2/2] media: i2c: Pinefeat cef168 lens control board driver
Date: Fri, 22 Aug 2025 18:04:35 +0100
Message-Id: <20250822170435.7057-1-support@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <d2ka3glpjiisjs7ydx7knzzfb2dzi2lyc2r7d4hppqor33xate@2evtuolz6wah>
References: <d2ka3glpjiisjs7ydx7knzzfb2dzi2lyc2r7d4hppqor33xate@2evtuolz6wah>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 20 Aug 2025 14:56:38 +0200, Jacopo Mondi wrote:
> > > > +	    ctrl->id != CEF168_V4L2_CID_CUSTOM(data) &&
> > > > +	    ctrl->id != CEF168_V4L2_CID_CUSTOM(focus_range) &&
> > > > +	    ctrl->id != CEF168_V4L2_CID_CUSTOM(lens_id))
> > > > +		return -EINVAL;
> > >
> > > If you mark them WRITE_ONLY wouldn't the core take care of this ?
> >
> > These controls are read-only. The data they return depens on the lens.
> >
>
> Sorry, I wasn't clear.
> 
> If you mark as WO the controls you don't accept here, will the core
> handle this for you ?

I see what you mean now. Indeed, the other controls are alredy WO, so the
core will not let them pass here. I'll remove this check as redundant.

> > > > +#define CEF168_V4L2_CID_CUSTOM(ctrl) \
> > > > +	((V4L2_CID_USER_BASE | 168) + custom_##ctrl)
> > >
> > > I think you need to reserve space for your controls in
> > > include/uapi/linux/v4l2-controls.h
> > >
> > > otherwise this will never be visible to applications ?
> >
> > I found there is no need for that. Custom control become available
> > automatically by name via the v4l2-ctl utility. For example, the focus
> > range can be read directly in the terminal as follows:
> >
> > v4l2-ctl -d $DEV_LENS -C focus_range
> >
> 
> Yes the driver enuemrates them, but you need to add them to the main
> header, otherwise USER_BASE | 168 will be take by someone else.
> 

I see, ok, I'll reserve 16 controls for this driver in v4l2-controls.h.

Thank you for your help.

Kind regards,
  Aliaksandr

