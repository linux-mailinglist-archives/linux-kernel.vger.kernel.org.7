Return-Path: <linux-kernel+bounces-852444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8C0BD8FF7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 13:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 792354F1661
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 11:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EA530C61C;
	Tue, 14 Oct 2025 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XhNkAY+D"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E1730C34F
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441158; cv=none; b=oTQECOk3lv4uCMC13H16lMqR4P8WN9MCL1bFt0gL8liH8tC8+pczL/qh+LL5xjgPCi96BlJMDco3zIthaNfQXgoNjAgRLSG0UZaIOiFMjbm3tlJhb2k+nI6pMiXKlKDSNpat1W8DcQBpQGQOdbUGhpD1Lp/i5Mt0nHbuSLQpxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441158; c=relaxed/simple;
	bh=iQmTbrHUexc232Nhf3QX3VZFHuse7k+IcjM2fAe1ig4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=us+UAVgkQWLmwUmX3ABCXfcSZKGlSKLlnD2mdACNeaqUbhGlbdCsYu6wShvjM3dHr7ZqjGxHXKNwBRY7UVusPREer1KgYYdvOZFEqZwQqOEVj+//WVPAqXcmkwv2QWrxV8tMpJ3IoxbL9tnL38/csRj/n/uKSvJa69qZpp6pqIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XhNkAY+D; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-4257aafab98so4412395f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441155; x=1761045955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uiSHBqGlXIEAZvcjTP0Y/hDCrVSuK2ils+FnYn9ERgY=;
        b=XhNkAY+D/tKbyUEfjzqJNffL066aOrtU2r5x9bqGbg4eq7/82MWKqRZj3QRIYcpWhG
         nw8VsssuIC/4zyfwpNbafMpPxoDHX4l2qbuvprZ7/kMiDzMeh/4wi9tLB1X2m4TQ13bo
         +hoDQUf3QzYdwthNxi3zAWQ2ZG+A5qXjdgIW3pMB9XPFrkldNLZ6AIFSD5SkYkBVNfdE
         pMPsNcmBrN2jKyMXQbRe/fyXBAqbSgqnqq4spwENA4E8wPkY5XLZ4LNrWaK7P7PBhfeM
         1gavIL+L27dbVJE54GQaIFgYZ1LcqHplAsfLdzuIlrMZmkI/p28Ib8OaGtAB/WqVXF9h
         qoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441155; x=1761045955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uiSHBqGlXIEAZvcjTP0Y/hDCrVSuK2ils+FnYn9ERgY=;
        b=i06EyFb5Nr/8+L3EV+Eu8/iPbKqf/ri3IImozDQtbi9xYU1uIJ2wfc/aR/aG04UZvq
         dp+SPHrIKNUNMx+YFT00gjjC3JGEyNGHPIOFNqD7XWezYFnvc3/R10GLDHihAmSMNqbO
         PW1p+VwWscdtpi2/0Voace/Eyhp1JsUEDfDwfYUJWet8XqCn3Pdgn7YsdDCanOSz0NJb
         McM5HnG8GFNHrLMxYLF+8YPcYfceFiK4gs7rHPvFxKHmIhIG4bt7r2aJo6a7iTbSFn9l
         GGTu7Cu/pFhlR7S+mSLn4/SgkZ05PDjXey2lp8sk/+OdrCImD83NZir7ix57WBglKFv6
         8qrg==
X-Forwarded-Encrypted: i=1; AJvYcCUQILSiyvSuyNQ2pcQLGBI2fi9LgLe3qloZdRoKjtMIx/0JlOghbHCaJXQvp6hzzfacaGwurVXK4jH9rVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1f7B22eNLWXy/BXbAgs2LWtG70CUWELcppAhIpNoxdXvKLEpO
	wPsUVP0DU1lFKh81s9qUFz/6wktz6DVSkDobwwQ6+SAJJa3h/6bVyi1e
X-Gm-Gg: ASbGncuf9AvYaO9eXID8u+/MxZ/1OWlHynFmt6XLYnxNzg6TFqvmzAPrgk5mrh5WCjy
	6C64ySvWYs5/oBsM4jTYf0CJxuRsi08rMto4omNpIKb5/JlM/i1KwRuARaZqOtKxuuqVywjRwlW
	bAzmcpw8lRSsJYmKrszuQ9lMyWMZBj1C83bjkGwca8dg1utuMxH+zyi4gGe7JAH4qHtLRaxD4Ls
	TvC03eA/Iu1AgNw/4gCxHY7PYVsacwob7NZzorTbjCjCeBw/KaoJrCJDw2WmhXXjqCRY3iqgbzx
	LxfJaG7dXFcmLYFtulTQ+LUMjial+PVdJOrseKYYkJQj6hQGKL6nqOX3BUL11OFjXsEelFKOxHf
	+TQZtwDHffHm829/x18yAUhrUlM/t806uMYMetnOddbcnn9/EZKjF1OLMWHLe6EJFW3aHAXrY3x
	xqgDdArF/b5hXzb2IfxfG/0Va3jt/JE9VgD1dd/r0G1Z3pYK2NGMY=
X-Google-Smtp-Source: AGHT+IEqaf50xViFqcGYgiRoMt4dwJ2xrUn7bmjBXs3Kk/pC18UdQvc3UcQNURWNwY1ZJ/f0754E/Q==
X-Received: by 2002:a05:6000:3111:b0:3ce:9872:fd3 with SMTP id ffacd0b85a97d-4266e7d92eemr13663773f8f.34.1760441154531;
        Tue, 14 Oct 2025 04:25:54 -0700 (PDT)
Received: from ernest.hoecke-nb (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5e1024sm23047515f8f.42.2025.10.14.04.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:25:54 -0700 (PDT)
Date: Tue, 14 Oct 2025 13:25:53 +0200
From: Ernest Van Hoecke <ernestvanhoecke@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Anusha Srivatsa <asrivats@redhat.com>, 
	Maxime Ripard <mripard@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Robert Foss <rfoss@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Hui Pu <Hui.Pu@gehealthcare.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	imx@lists.linux.dev, regressions@lists.linux.dev
Subject: Re: [REGRESSION] drm/panel/panel-simple v6.17 WARNING regression
Message-ID: <kcunz2b2usmvadgrnnu65op5oi5ttblrc463twgxp5gqhnufav@eze53y23avel>
References: <hlf4wdopapxnh4rekl5s3kvoi6egaga3lrjfbx6r223ar3txri@3ik53xw5idyh>
 <DDHZ5GO9MPF0.CGYTVBI74FOZ@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DDHZ5GO9MPF0.CGYTVBI74FOZ@bootlin.com>

Hi Luca,

Thanks for your fast reply and all your work here.

On Tue, Oct 14, 2025 at 12:31:35PM +0200, Luca Ceresoli wrote:
> Let me have a look at the DRM_IMX driver, I'll try to send a series
> converting it to the new API within today.

I will gladly test, thanks!

> I recently sent a series proposing to make drm_bridge_add() mandatory
> before drm_bridge_attach() in the docs and warn if that is violated [1]. If
> you apply patch 4 of that series you should see the warning.

I gave it a quick try and did not see the warning. Some printk debugging
told me that `list_empty(&bridge->list)`, inside drm_bridge_attach, is
returning 0. 

> > However, later on, another regression seems to be introduced by
> > commit 8fa5909400f3 ("drm/bridge: get the bridge returned by drm_bridge_chain_get_first_bridge()")
> > so reverting 94d50c1a2ca3 on top of drm-misc-next does not solve
> > everything. This was tested by rebasing drm-misc-next onto (260f6f4fda93
> > plus the revert of 94d50c1a2ca3) and then bisecting.
> >
> > So in v6.18-rc1, both regressions are present.
> >
> > There, I get the following additional warnings:
> >
> > [    9.732278] ------------[ cut here ]------------
> > [    9.732336] WARNING: CPU: 0 PID: 38 at lib/refcount.c:22 drm_bridge_get+0x10/0x18
> > [    9.744608] refcount_t: saturated; leaking memory.
> 
> Not sure here, but it may well be another symptom of the same bug: the
> refcount was not initialized correctly, so it is found inconsistent later
> when trying to increase it. Let's fix the known issue and then we'll see.

Makes sense to me.

Kind regards,
Ernest

