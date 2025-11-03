Return-Path: <linux-kernel+bounces-883565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAB1C2DC4B
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 19:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5ED494E43E5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 18:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C131D747;
	Mon,  3 Nov 2025 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blTULnaF"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C15286352
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196234; cv=none; b=jtWL4qc8LXYBjXaEf/AZ9R+uWQ7usgvaQhEgo22CrSM1+LhtHvWhym2e9nVq79PjzfMLgTr8Oyhb/JRlglDHiGpobx6wdbfTUIIEIyrpaj0wMKnUZxRXjzdK5lcDRAR3zSTuDVDJkX979NnbVIS9LVoZfltyGJgR2+idNLCG3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196234; c=relaxed/simple;
	bh=Z/xD2z+2YSUXqgcAz/IHOKt8zMT+ItoaZxlJAM3lWW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5v596uod7UKAvofgZ3Om5tJhbbeQuZYbS5n+SyO9F35Z7ClhRrQncwjoKuVlRnKD02cgFbY84Z65uivFzy1q/GnT4s7rcbnRC+4HQBnFU5C24FwmA6tuLH7NzvDLSiY3ISdKMqw37bEtJRDe9UjgHUfisTWueiPrnjmnEnx+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blTULnaF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso64151515e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 10:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196230; x=1762801030; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8+eN+6lfnONIl6DhyaJPvMKjY4jky2Hy+ffm+J1z/H4=;
        b=blTULnaFqvUBBSBcMhJJ8lScuXmmnF6U7ItPR07z8gg3E+MPRp6c20ky1qqTu/Q7oR
         iKx6CtTNaJ+b6CQOgNFntTqG7TlxdTWRG7/UDwIDrSYwfkdWAJjfkYjPA9ZnQ78rB7O+
         TxJ8OwtRXqNcSLrpekVGAYxbWitbvBOkdIuZEp5BJWn4P6q3UQ4ksO6tK0L9vZPH0wm9
         l+swc8XTZwsEr2OMGT/FKQWTXB1lTdxPrGacXjL057zcZaaBy1LLo9pk7jBrSII39fG/
         VrXUZso8bB+b6inAkiXEuFPjNRKbAmsZKDqDbomBLrLKeYod8zOVV4ZquqTt0HPGOc2R
         cCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196230; x=1762801030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+eN+6lfnONIl6DhyaJPvMKjY4jky2Hy+ffm+J1z/H4=;
        b=YGVoeX1I/hCA6PofmrQC5h7sZqVxk7pqz4UZ2UfbyG7WsyP/OOHa6nOmGupiTIE6RF
         r1td1zfBd+6XH1Z4/n5TG+UrQqug0hRIEg4Mf2oMY/8qejwwz4Ws1N9vPYiZUNVZ8sEs
         DnbHIQjGscTBzeOYZW5seuMm4uzP8vDnJbqNmOq7F+SpLrKAVO37BC96aAYVZklMbkNk
         4SvlDi0NXF+RT7PnoATk4alwiEMwREd4JtxDZkN8jitIXImnNh1EGTMCdw/2da4jlKbN
         iuJgHHEevBLO66Qf9MfkB1s60Htm495TySU/FuoRLv4bBlajNdstpWjsPH++Cn1hL26N
         0YGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVC9oIqvURgO8JghMlsU3a/W1STpM58pJ8pCVGSUoVIyjvYYDMB1tUrEm7CA8/2CM/eNH8KtuOFRHY18Jc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn/V9xpo1PoGNi5Rnnvwk5legKQYxANcy41j+YIsYyTVEpiz3S
	pEK6zMWx2Z3x3OkTB+vWDxAUUQW7/1SPfFoDk4uDo2vNnXY4mbjrGtXS
X-Gm-Gg: ASbGncvxFOWEHj+6wxCTwa4pwo6gxwmPZqg7H5lp7vuhRJAutalr5+ahpoP0QgE9vHX
	FmXdVexMKb3JNo2SC3l8AfBGOmERQdkSwLUtsVkwkGIp6K9QzGuIM7kA+b1sxTsVVml0mqqrpXV
	AVMN1oOybo/P3uYOdg6pKsmACJ7gySxH+eTBqUPx/OdMPHf3/MgwPayXRv4Kc3qGqA2aqGu3Zza
	eEhmo+CDpsdI8xHJvok1/asRe57OqHKJFHMvENgpoy5uzXGROLAPijr4h5KSAC27T+Lmialpsxf
	fHgCuR25rEbv/lyC6vQ7JFhO6x1+6FoP9RoTkpaa+v2eKNTl/BTOzaC/Gcr9208mS6uXTNVFFN6
	IGVJsVTzb/xaWQGWrto7E6piYg4mZoZ4D0XANZT1ateuLs7s1uwJWJ375PvhrOzMwDAAc61bwq8
	CTRA==
X-Google-Smtp-Source: AGHT+IEK2+4nBd40SRJ0qYnaqIkscu36w0iUBumg+gWmVgTn8vW7aAbSUdB2E3eeUqZt28T5ziAh9A==
X-Received: by 2002:a05:600c:a08:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-477308c9355mr115909985e9.27.1762196230208;
        Mon, 03 Nov 2025 10:57:10 -0800 (PST)
Received: from localhost ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773d81cb03sm162334735e9.13.2025.11.03.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:57:07 -0800 (PST)
Date: Mon, 3 Nov 2025 19:56:55 +0100
From: =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm: sti: fix device leaks at component probe
Message-ID: <aQj69wzTceDklx2Y@thinkstation>
References: <20250922122012.27407-1-johan@kernel.org>
 <d1c2e56b-2ef9-4ab1-a4f8-3834d1857386@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1c2e56b-2ef9-4ab1-a4f8-3834d1857386@web.de>

Le Mon, Sep 22, 2025 at 06:16:47PM +0200, Markus Elfring a écrit :
> > Make sure to drop the references taken to the vtg devices by
> 
>                                                 VTG device?

Video Timing Generator.  This IP creates a vsync pulse and synchonize
the components together.

> 
> 
> > of_find_device_by_node() when looking up their driver data during
> > component probe.
> …
> 
> How do you think about to increase the application of scope-based resource management?
> https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/device.h#L1180

Oh... I wasn't aware of this.  FWIU it is a way to directly free an
allocated memory whenever a variable goes out of scope using the cleanup
attribute.

IMO this is also a clever solution to prevent the memory leak, and it
would be a shorter patch.  So basically, instead of calling put_device()
as Johan did, you would suggest something like this ?

diff --git i/drivers/gpu/drm/sti/sti_vtg.c w/drivers/gpu/drm/sti/sti_vtg.c
index ee81691b3203..5193196d9291 100644
--- i/drivers/gpu/drm/sti/sti_vtg.c
+++ w/drivers/gpu/drm/sti/sti_vtg.c
@@ -142,7 +142,7 @@ struct sti_vtg {

 struct sti_vtg *of_vtg_find(struct device_node *np)
 {
-       struct platform_device *pdev;
+       struct platform_device *pdev __free(put_device) = NULL;

Best regards,
Raphaël


> 
> Can a summary phrase like “Prevent device leak in of_vtg_find()” be nicer?
> 
> Regards,
> Markus

