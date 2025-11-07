Return-Path: <linux-kernel+bounces-890052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9168CC3F26F
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 10:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3D974348D7E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 09:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348EE2F5A2D;
	Fri,  7 Nov 2025 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cc+q2iTY"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85782F39DA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 09:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507629; cv=none; b=Wpj0qxAkDWgVHeUen8vcb7hP0c/oqrhoG+PkG1vYgYQIg4OWSPahc/BKACXfHYvwzrbpoyZwR2sbs/uNPeCTe6sX2YXV/cJ1XpVZJC+Kpc/e56i6N/QJm50k0YaONHNh1Ga3I/Y011DKm0yxvIIXtdikrrS8jueWx6ypmeXZ3bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507629; c=relaxed/simple;
	bh=kDAyi9ioMc/rzuwTBPGk8+ebQ5bgGc7bdn52u50c0fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eAEz2J+CciQ5fcwLuDwvGWYUkDoiCZL3XsxneShCAfIQWBVmsH+HGfNHm6Mi4at8C+LJjShOfcrSX45dbRd461a2axL5T2ou2w3I1l57BUwev4b8GQxmLX+scE/I8xUvTOcJ/3AlxqJVhLi1dnXgt6r4H/ITfL2hZkrX0pXY5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cc+q2iTY; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-429c48e05aeso291292f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 01:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762507626; x=1763112426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=geTnwrqDK13fknylndNDrxsZhVlDgoBw/RlgWBbQVGk=;
        b=cc+q2iTY7BCdrO/UDtugvs/5XQt2hTUlEOOcVDDJy2MTcywH+bCzO1YwJnkUk+g4/D
         AT5gKDAv7DC9va9b2V0je/2EdiTp0OLan4C2y4pifBtUa+fnzVbsTAPypBRES2P2wwzv
         R0cbHJDrKY9NT2o+AY89Z6vZbjOCDioau/ToNkkcL/atTCtIRICu9zICXWmyQ58ZUguy
         wWpXR6g2h/PdgI3W6TAfFMhKjNag/YZYdD2hqq4CKcRBlgoF94J6jRVYPxFMt1ALd8/1
         nPBF+JQ8XLuaiPulpA3G5mbtKFkX0ZTz+1wMjIzSWj0IohTzy7z6LZoMWcNDvisF/ll6
         2KZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762507626; x=1763112426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=geTnwrqDK13fknylndNDrxsZhVlDgoBw/RlgWBbQVGk=;
        b=gVGoG1jEGIom6ls5YLL6FEzdUPaJmXpfqnCOcKQtgQRpCO0qBH26lyioyzvoUEd/vn
         Yi0M5N3y029ETiGIxm/aUTCmC85hdeACrCPPmNoto3VY1iLCYpE9w4ScGUL3uj3fJK2p
         e/p0euVOyece2URd2szn70m5YvpAaEj1ovQ9r06bsCGKYrk7D36EvgH1NuM7Cfxs0efD
         1dzPG1W8jH+l+X21WGg/83YUR5U/IRU6wqN1lFlm0VHULgFLwD6ilLsDp+7BhxqpM+nn
         iee5T6da3XjdLEnxeeCsEK5czw1BACttx0OGD8XxlMgh1OxQzf3bt+/qV8P6HPQT1WFk
         2rrw==
X-Forwarded-Encrypted: i=1; AJvYcCURZiUz0Nh+6L1VsFzxoRZ4SaMC27SuqgzVBT7k/MBaBuJ9uaXddcjBVZGZ9mK4tiFHCPUeRXfRIBTocQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFUO6GmJ5IgYJQuKWGVD49t6Dn/D6l6/Pyt8bEjG+0lxLdgIAo
	O769jBsn/yaJZm6YUXp3vM5mvcN03ZRSejWBwXwCS7QRN8BvahE0jS/6s+49BPiz
X-Gm-Gg: ASbGncv3BiLQ7x0Qi1i59LO28l9C8LXT9KNGHKUIHKtwmmAcTrtOo/kYkZtdt+fZXIo
	d2UxhvMyBedVIhhavHTrg4nMtmQ+L0PsFm05msl72vHnRZMWpJhdw5TMY8fvU3xKqLeBgiQ1S5h
	2iNRxiaPilKUzuEfOTJSOyBbkgfx/Ka/35OzIfuC1ktDiDbOCxjUsvklMcQMTgTWE/yE2fv4M+z
	WYfaNaP6rhDvrsilGhx1ccBkVLcpeR3a01TWo6SqemnUM3atbLmnHPMqPBGDpnpYo9upvO6RSDT
	jt8ZMSlyA87Me3n/2fUH6oOQImkTbvDL6J75FAikY45/zQ/P62BHddoSXzoSh/4lJ+aWc7W6FHx
	P3DkKS9/YmBn40v8R17DinB1hZEuD/rF9d5UjQemg1PyvuXXnBXXlAvyYdo2eI3bVnQw6JFRU/4
	ZaYtIbTgkVhzrb8ZW8zYMHNFOLGatoom7WyRX+nymFt08=
X-Google-Smtp-Source: AGHT+IGyQU5w/jXirb835rluq2NuRTlYaAkODeiLEa1G2akDocz91dbrmmPOmGY260WwpC+esGaMPA==
X-Received: by 2002:a5d:5850:0:b0:429:bb77:5deb with SMTP id ffacd0b85a97d-42b26fcfe3cmr1102328f8f.31.1762507625992;
        Fri, 07 Nov 2025 01:27:05 -0800 (PST)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([78.212.142.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67845ccsm4047020f8f.36.2025.11.07.01.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 01:27:05 -0800 (PST)
Date: Fri, 7 Nov 2025 10:26:46 +0100
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: ABI: document pressure event attributes
Message-ID: <20251107092646.qaeocpvux4kjfu3i@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20251105095615.4310-1-apokusinski01@gmail.com>
 <20251105095615.4310-4-apokusinski01@gmail.com>
 <aQ1aJ2RNMXp9TXzY@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQ1aJ2RNMXp9TXzY@debian-BULLSEYE-live-builder-AMD64>

On Thu, Nov 06, 2025 at 11:32:07PM -0300, Marcelo Schmitt wrote:
> On 11/05, Antoni Pokusinski wrote:
> > Add sysfs pressure event attributes exposed by the mpl3115 driver. These
> > allow controlling the threshold value and the enable state.
> > 
> > Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index 352ab7b8476c..5f87dcee78f7 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -898,6 +898,7 @@ What:		/sys/.../iio:deviceX/events/in_tempY_thresh_rising_en
> >  What:		/sys/.../iio:deviceX/events/in_tempY_thresh_falling_en
> >  What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_rising_en
> >  What:		/sys/.../iio:deviceX/events/in_capacitanceY_thresh_falling_en
> > +What:		/sys/.../iio:deviceX/events/in_pressure_thresh_rising_en
> >  KernelVersion:	2.6.37
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> > @@ -1047,6 +1048,7 @@ What:		/sys/.../events/in_capacitanceY_thresh_rising_value
> >  What:		/sys/.../events/in_capacitanceY_thresh_falling_value
> >  What:		/sys/.../events/in_capacitanceY_thresh_adaptive_rising_value
> >  What:		/sys/.../events/in_capacitanceY_thresh_falling_rising_value
> > +What:		/sys/.../events/in_pressure_thresh_rising_value
> This is how it's currently appearing in sysfs, right?
Yes, that's right.

> If so, IIO event sysfs entry generation might need a tweak.
> 
> For what matters to mpl3115 event support patch set, I think this is okay.
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> 
> >  KernelVersion:	2.6.37
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> > -- 
> > 2.25.1
> > 
Kind regards,
Antoni Pokusinski

