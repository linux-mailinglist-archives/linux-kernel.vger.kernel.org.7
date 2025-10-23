Return-Path: <linux-kernel+bounces-867878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF694C03B69
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 00:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA0611AA463D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 22:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D48285C9F;
	Thu, 23 Oct 2025 22:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXQvAqp5"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814FE26E71B
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761259929; cv=none; b=Lfd6dwI7TaeGG9XY/tb1UZ1WAp66IpPOq8LQFDE/7SPQjaYNwmbq89M949IBWgpCWnhwWdanK8mrcL3bVfpiLQYI9jlK31zRLJ1MaRp4LUsrgcmOpW62jiIoqdFsDn6pp9pgbfOt7CfrNatno3nSNWuBvb5PqGlXJSs/QZpCXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761259929; c=relaxed/simple;
	bh=z8c97v2FzlJqksKStZur7yQhA54L3dtHYHDj7wuDLks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJn+EkvpEcl+Di2j2zr2RZvPfTBQ/6oI5G8Y/6QWYrZmpbCNkMS8S1PriZ/bbbbYqdXnKYhdZZViEjJrHh/1Nou+y5DnMnrViVvBmqO5s2BUCDqmxLbKzWCk6tbr3rG884at93rw+xEpMVzCD3++KUjzPqBvS0t1a3uSrGrnrwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXQvAqp5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4710683a644so11690195e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 15:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761259925; x=1761864725; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XvICiLCYjVIzxqwfMbpW7cUOHCHB4n9EBKEB8bcdLHM=;
        b=aXQvAqp5SruTizobkYULv3nYHjsf40tVA/dTLnjOI6Key+ww6WfMie/mmYdgjPpm2l
         XhioznZPbPCWiltqkS+eruqq7IP3qArIb3wYjlQ8nFLQVZtLhqaZYXKAadoP4KY8GbhB
         hqdVVl+XCTwCv6qVaGlRQziP/uKKdajNv+IJFChGyNJ/QJOZzM6pKq93ExzeinpOnPbk
         MHYcG4i1Du8IL56NX+u9Vefv9DS0FjJAV1eycXU1g6Eva/wX38ytcXcWdPEq4h2MIqV4
         YgH0sAQI47u0gtRzTbGKEFESSY7h3wQ1QBEHTO1AM6F+M0S7Gz7jDnVEVLqcQcPH5RMA
         hv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761259925; x=1761864725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XvICiLCYjVIzxqwfMbpW7cUOHCHB4n9EBKEB8bcdLHM=;
        b=awWHi1i6jcDAIVyuMzsnwIfxKsEWeX8Py0Oycw0WT48Xu3sg21dpYgcrdfi3VQopdc
         h+gpjAoXb/NevOcyP2AOPWwK5gSmyxlOp+SSIEyYJT16aCTy6netoRWUyqZx6Y9hPMqN
         lhf+BE/YCo4271TIoLL5U7hyEuoNjHm9UvBxAt/Sacda/q99pHGkh0czQb0p4GTN8w3d
         nle+zjwWG5vSewPY7p2+5FNyXqsrFO8n4td4WI/T9ZJsL1MFxws7Ig+Apm/2oCLqSYTt
         9ZfADi0GzfCDjw52DZXVt0Ch/HBKCv0wFd8BEgKPEQakyJcKFQRtUMwawnRLoj4S36VG
         NTTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5B+rDjjnBKgUW0hjaGCZ+c8K2eLdP2g6b74YxxIH95U1hwClFzgn/ftnmGkRhU5guW3A7x2EJCB3STi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNrABdcHXc/fq9QrqS0F5cTv947Ua1Lqu+06CnMX1uAZzWrVvO
	T9RwuPKiF+19zHH85ijiF49bVxByW6Kqp5X5yF3IFMiDa+Ph3JkBNnaU
X-Gm-Gg: ASbGncsXp1ATmZf0YKDsaq1Jm6QumLELCCsldoFvQoAwAmePlBFCq8q03nF/hp1Wy5Z
	hOZba0DWkGvrEUabw4rS3syywVul2TGt+WGttAijEvyclRWFdp//lujC4DO0YTf3tMXDTdO7L9/
	J35l0DbAw8t+UDRP/vaKKKIDMgCR+GTHx2c1m1Y/cqxXEJ4HH1BB8RxaGIzOuCAyKlD8zSpbZEE
	6ugSpXFlNvYP96QB8s0zWbpxG6hQbvYraVYOH/7BUE84lODnUBabIUu48zDLyIqQ24/w7KLFK/z
	eSqcGUImFzloxKtuboDR1WhMGXZpgbVWLcciROo3ns+Z+UTXgwS96Vyk7nuQBGBOyOnTODxfcaa
	oBk49fKKrGhBoymt6JariwGRWbUc7+cMIR8WSox9czl3LuPkqayF/wZ3Pr6tvJItLOuZhGOOXFG
	vJjdf3YVKYCzXG
X-Google-Smtp-Source: AGHT+IFDN9CDEai0nHIXHDamVFDpcG3qN9fKmbfWLZ3vs/6A8JkpllKtcK/66U+4vz++r10f35OkLw==
X-Received: by 2002:a05:600c:4ed0:b0:46e:59bd:f7e2 with SMTP id 5b1f17b1804b1-475d2426e58mr3285645e9.11.1761259924490;
        Thu, 23 Oct 2025 15:52:04 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47494b365adsm70379265e9.6.2025.10.23.15.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 15:52:03 -0700 (PDT)
Date: Fri, 24 Oct 2025 00:51:57 +0200
From: =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Chu Guangqing <chuguangqing@inspur.com>, alain.volmat@foss.st.com,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] drm/sti: hdmi: call drm_edid_connector_update
 when edid is NULL
Message-ID: <aPqxjUh91I4G4bOm@thinkstation>
References: <20251020013039.1800-1-chuguangqing@inspur.com>
 <20251020013039.1800-2-chuguangqing@inspur.com>
 <4cf3050675a7090a87c80d525601b226e5e70f06@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4cf3050675a7090a87c80d525601b226e5e70f06@intel.com>

Le Tue, Oct 21, 2025 at 11:55:01AM +0300, Jani Nikula a écrit :
> On Mon, 20 Oct 2025, Chu Guangqing <chuguangqing@inspur.com> wrote:
> > call drm_edid_connector_update to reset the information when edid is NULL.
> > We can see the following comments in drm_edid.c
> > If EDID is NULL, reset the information.
> >
> > Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
> > ---
> >  drivers/gpu/drm/sti/sti_hdmi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
> > index 4e7c3d78b2b9..e0be1be8bcdd 100644
> > --- a/drivers/gpu/drm/sti/sti_hdmi.c
> > +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> > @@ -1008,7 +1008,7 @@ static int sti_hdmi_connector_get_modes(struct drm_connector *connector)
> >  	return count;
> >  
> >  fail:
> > -	DRM_ERROR("Can't read HDMI EDID\n");
> > +	drm_edid_connector_update(connector, NULL);
> 
> The context above has:
> 
> 	drm_edid = drm_edid_read(connector);
> 
> 	drm_edid_connector_update(connector, drm_edid);
> 
> 	cec_notifier_set_phys_addr(hdmi->notifier,
> 				   connector->display_info.source_physical_address);
> 
> 	if (!drm_edid)
> 		goto fail;
> 
> i.e. drm_edid_connector_update() already gets called regardless of
> whether drm_edid is NULL or not. Precisely as intended in commit
> f7945d9fa8b7 ("drm/sti/sti_hdmi: convert to struct drm_edid").

Woops indeed you are right.  Looks like I was distracted during the
review.

Sorry but looking at it again this patch has no mean to be.  Regarding
the noisy message, I'll send one removing it, but it is not pressing
IMHO.  It only appears if the driver probe with connector plugged.

Thanks for your reply Jani,

Best regards,
Raphaël
> 
> 
> BR,
> Jani.
> 
> 
> >  	return 0;
> >  }
> 
> -- 
> Jani Nikula, Intel

