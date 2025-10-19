Return-Path: <linux-kernel+bounces-859601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ABECABEE13A
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 10:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C97754E6CAC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 08:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363DF29DB65;
	Sun, 19 Oct 2025 08:51:43 +0000 (UTC)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B875526F296
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 08:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863902; cv=none; b=Eg8mj+0FEx4S87noz4D/SHaT9NQ50K3n+uyaTy4spt+YxEbWuw+p92GR7tahT9DThLBhTnZkTFloKEQAGxjQNVuUX0RcHId4d0MmmZ6Z35XVOznx6n8tYSAIQ0uxMItBxUcmOOQiqpkx6hW83D9t60w1/HZFz+daK1MmHbELZ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863902; c=relaxed/simple;
	bh=XqqRnamX48XVhgy/cSJowCbYmZ8Q51GIp96qBAj+mSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gE22z8d66Few06X4+uUTzywj9Njct7lbY2UP0GKnexEPkj9S8FqqkPqwPyKHaOtDRL59YcWdzlXWU8cSD4bQnKVRJRC5q29iFhLxp/T/KZDsflotX1KH0DSifA7/xlU0IYvnJ53E3MDI4rbz17Iu4ODE/zK+k+w5lXlYY5zuNeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-58b025fce96so2975705e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:51:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760863897; x=1761468697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XqqRnamX48XVhgy/cSJowCbYmZ8Q51GIp96qBAj+mSU=;
        b=OXxPqluWNZt1oB2P7RYwdQaGoGru2kqnzYJulaPFGCAWBrvepiUkc8tDtMNE4UQdXD
         Noz+Rg/cPbSUX8QEsb30fm5q9NJ1gKPEJz48vPb1u/Fagr+Jk0DnduMcmFNF7IyzuOOt
         JoOtHUuJtk2z1EWIfjPS1/MoI7O7ZPXEKU9QMAEt6XfzGeUTPXidpXco8gZeZ9bU6UrW
         U/0/Sbnwl1L61eLTOekk6KOGTPWZd0MrgU4OLT8Qoi7JpyFilQQ4TjUSjUpLwz2YuZG0
         zGMjrkpaL6aMPuiDEbiId/gFkNh5o73mLCfjFJa5KQ//tT7ysWt0WNIul1KO6nDbDrld
         qzeA==
X-Forwarded-Encrypted: i=1; AJvYcCVh/fXt8Q93R1PmR/i3pUeMsqhCDZQuv7dPe55lXqyTq/AgWuDObQLgPiXl/prGnGdldRGlfP/NoEMYaCA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz15MrHS4CtFZiuqDQosYMY1EgAqeMTvOcVAUePTRrYKwYqpCXe
	kr0fMr0n6jLp3El8fI31kStLWh5cpDDtBmSeZF+eykG47fP9imDHEjujQEZ68/4J
X-Gm-Gg: ASbGncsyVqccruxuZUQCLsOMNEdMMcTqhiSk3+r/IokUe4rwf/33iemW5YRFyPTuq6Q
	IgH7m5Z7d8iBqEiCSZWF4K7vQXxulAxMzSVtz466emCGrdgv6tKpbBsINKhk0TDpL8oweGSJGxc
	L6OPHDEqo3WlhjOFqEvbx0p5LwbIsIbnufbE0bQf9qKwEDGrRqI+i4NPMN5Oq89Xiy0C5gXYOvd
	9qDdtdEjg8BLK8Im9X/MT7t6+tEivFejkPhorI9gxHa3jsvz/pA4Z5+Ng9QeuPx8+Lcjs3CvewB
	2WBZrQvGQTUyaDndRacKnP1d2V10tMjWBdYzm3Un7AZ1bu6CuBnZeC1XQvkM6sLHi7w9nbHeT1r
	ytnFUUij8JVnKAYV599z8Lct7+hjy4r99FkaKMzUfIUeynDJiSdUR9RZBjel5shT7t5gsqfS061
	vmPl0LsyrF9HSi7eXX/2NHOY4xTg2JGPbE
X-Google-Smtp-Source: AGHT+IHHu84O3sFT3D4gsWUm3XvJ8yBpRg2ljJucKNAt6y6vynlU4K6xJrfA+ucPwLH0rnFrfIrK9A==
X-Received: by 2002:a05:6512:3e10:b0:57b:66c1:3a48 with SMTP id 2adb3069b0e04-591d8552b74mr2796479e87.34.1760863897238;
        Sun, 19 Oct 2025 01:51:37 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-591def1b763sm1393096e87.88.2025.10.19.01.51.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 01:51:37 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-36a6a3974fdso35234841fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 01:51:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWlR1DX9V5ljb1clu+lS48G5FOrVs2jlqxM6FCAQ9v6wE31SrUrrtOxuHmqN9cJIRTSZAUfLgirRiJ+K4I=@vger.kernel.org
X-Received: by 2002:a05:651c:988:b0:337:e0e1:d11e with SMTP id
 38308e7fff4ca-377978ab8d6mr27450931fa.18.1760863896800; Sun, 19 Oct 2025
 01:51:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251012192330.6903-1-jernej.skrabec@gmail.com> <20251012192330.6903-7-jernej.skrabec@gmail.com>
In-Reply-To: <20251012192330.6903-7-jernej.skrabec@gmail.com>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Sun, 19 Oct 2025 16:51:23 +0800
X-Gmail-Original-Message-ID: <CAGb2v661kowYSSNYJ5Bb05mRFJR7pZFym95Oyj7-R5kkPrzNzw@mail.gmail.com>
X-Gm-Features: AS18NWDXIVTjeyhWFEjy65wFSPD-aqsq49LxTr6pJCNafi4Ajfc1OGiZzxQr0Ms
Message-ID: <CAGb2v661kowYSSNYJ5Bb05mRFJR7pZFym95Oyj7-R5kkPrzNzw@mail.gmail.com>
Subject: Re: [PATCH 06/30] drm/sun4i: layers: Make atomic commit functions void
To: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	airlied@gmail.com, simona@ffwll.ch, samuel@sholland.org, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:23=E2=80=AFAM Jernej Skrabec <jernej.skrabec@gmai=
l.com> wrote:
>
> Functions called by atomic_commit callback should not fail. None of them
> actually returns error, so make them void.
>
> No functional change.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

