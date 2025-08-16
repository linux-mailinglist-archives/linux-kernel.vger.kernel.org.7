Return-Path: <linux-kernel+bounces-771632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6781BB289BA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 03:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E448AC304E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 01:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C19518DB01;
	Sat, 16 Aug 2025 01:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b="Um1uXUfv"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BD02B2DA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 01:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755309403; cv=none; b=OIn++E2Rsys6/Tc+gET0ILzc8macLxwfgPrBERwwefuIRMLjUZAfC2RmlLIbx83uVwUm8/7YQcBfInK4WXv6ykUUnVOVF8Q+cHKoB/44e/pRR8eYD8FG865wI1TSc207O4jVNTgt8mZwis3hHdzq4M2cemP/p3aC/VUi3GbC5oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755309403; c=relaxed/simple;
	bh=aPHE4+j2Xn6T67Rd1NzXaikrS96g/PXgXAZLqgG4Y0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P3Vzh5X3s64AWbPOqst9FRVS9hB2MTuFFKQMRzHL9+60hlq98WbK6w9lOEl38OkGsTXx1LG96dK7BHR+xA7Y+xLkO60XJ9O9yXJgEFOLyXiLpP09DWplH/JwNeEIhVKO0FCuY8Msuz8TYbPjiYpvAhL3IQ8SwFmVDc19CfUjtBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net; spf=none smtp.mailfrom=minyard.net; dkim=pass (2048-bit key) header.d=minyard-net.20230601.gappssmtp.com header.i=@minyard-net.20230601.gappssmtp.com header.b=Um1uXUfv; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=minyard.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=minyard.net
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-61bf9ef4ee3so111879eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 18:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=minyard-net.20230601.gappssmtp.com; s=20230601; t=1755309400; x=1755914200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jP1W19LjLSkvrRoe2qDVizyJ7MFWz2WXooHFP4rj+9E=;
        b=Um1uXUfvDKR+XBzrkdH22t/u6OEDIJ5xHPYAbw0RT/xlhNcvloQQquWqDBs+LGmFCR
         UV/6IpIL6tjwMPm8hKSGoLUcL6vODgGx/oKGC8zuAjQrPyHq2j8WC73r27O/vyP6ZXpS
         Rk7HywSbswT5KRN008zhdkHhPwzKXukXovWm8msDdoMS6toC2QYTFpOFuNYVesDhIOcG
         vUWWM791k6b6je8cEndi7c2e66ma3F/HCQ03wqmZnaR2zSWwlVU0R9ayHdbmyg+FQHNX
         XCHGH/h8/aPzgNiUN5E/RZhmAXo/kutP07UWiS0BgHlSJQyRub43Yvlhcwx92LknKt3d
         GExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755309400; x=1755914200;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jP1W19LjLSkvrRoe2qDVizyJ7MFWz2WXooHFP4rj+9E=;
        b=BbD1DhsO/Ri5IcdLr93+LaqUR/p2TIa0xCHsNPIa99rWslv7NY64OcouOd0DbxjMsb
         Hg9sE4Sk26krv4IVsnfVFgBF9YrZk0/O4FyrMVZm6yGFF5iy8Yjep6GqAUOaVJ+1CfYY
         tIr97r91AdHctAinihOOpCwI9JWAPlCW4i8KJqQM+TRQ0Fl1cV83DyzsDHg8L/I+91xs
         oPuDF5bF1Z+9xljfPpPG3/6a8G716QyNtC/9BkEB3eYT5vwn03ssn1Z/dOLGdxCqj8e0
         aB1f1iDN0+irmLTcfG765I5lJIcxXNHYRFTBvB4p6AByr5xFwOucXzepj9jFIKdp449q
         aoMw==
X-Forwarded-Encrypted: i=1; AJvYcCV3BRzICn2FurBc+i3N27nwT1WzuE6YZclkhUbGeqol4D3jRa+DKFcueFjdmQezrncc0NVEIB7g31Kg28E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH8388WhXDVRfE3LyFu7LsVHlhrxxa7HcwJNS55tVLMwKLyW1v
	kHd6ZC+kugt07kgwvZu2laQDONjYzJRQV7br9/iayOeqgF/hCIC05IFbn5NE4zN5vxYcSIWwAhH
	udn9Z
X-Gm-Gg: ASbGncsfTDfMOJVDfb+yxvGradO92B5/iIw3OILS+8gsrc6ayxT0wVoa9Cjhkt4pvTe
	5yhXxUks4rMqDC2BFh510qeek9MndOtwclLUBNIhWrE8hhT1w4UhAYrQFT6xJnuuDDVjC2BbGRJ
	pr9tG+SM9vYr9A9vwcz8R26mQQvKTtxBbEItOVH4NiD/uq1nqNxCd8cHIq00+WT6sEKXWXHTc8s
	Lc+u0XRjSzEMTs9v7MLFba9kaQHEDij2QUZ4kFEJrT2zHkXTUHd6ttoofo+U9+WQqYTzeA1X3hh
	HOhRJxUrYnniXzFY0x08kdmwgeyc4s4J+Z2/Ly+r2vUlcX0xInt0Q93qXstap2b/8F5ylZFvMGy
	Pgm2lOqUZhquBN7p16haDm0mjUw==
X-Google-Smtp-Source: AGHT+IFU8iO56aObahNDHhvpR8cX3ydX0AhknrZWZalCNi8QAT4mM1Bfx8pbUZ3kDzm7L3D8FVl9Ag==
X-Received: by 2002:a05:6808:30a5:b0:433:fa92:69e9 with SMTP id 5614622812f47-435ec53125dmr2455248b6e.34.1755309400441;
        Fri, 15 Aug 2025 18:56:40 -0700 (PDT)
Received: from mail.minyard.net ([2001:470:b8f6:1b:e32c:c52b:6661:b446])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-435ed1af894sm532720b6e.20.2025.08.15.18.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 18:56:38 -0700 (PDT)
Date: Fri, 15 Aug 2025 20:56:33 -0500
From: Corey Minyard <corey@minyard.net>
To: Frederick Lawler <fred@cloudflare.com>
Cc: openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [RFC] Patches to disable messages during BMC reset
Message-ID: <aJ_lUYTlrzYnRD-5@mail.minyard.net>
Reply-To: corey@minyard.net
References: <20250807230648.1112569-1-corey@minyard.net>
 <aJ-lPAc2bLlvHNa3@CMGLRV3>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJ-lPAc2bLlvHNa3@CMGLRV3>

On Fri, Aug 15, 2025 at 04:23:08PM -0500, Frederick Lawler wrote:
> Hi Corey,
> 
> On Thu, Aug 07, 2025 at 06:02:31PM -0500, Corey Minyard wrote:
> > I went ahead and did some patches for this, since it was on my mind.
> > 
> > With these, if a reset is sent to the BMC, the driver will disable
> > messages to the BMC for a time, defaulting to 30 seconds.  Don't
> > modify message timing, since no messages are allowed, anyway.
> > 
> > If a firmware update command is sent to the BMC, then just reject
> > sysfs commands that query the BMC.  Modify message timing and
> > allow direct messages through the driver interface.
> > 
> > Hopefully this will work around the problem, and it's a good idea,
> > anyway.
> > 
> > -corey
> > 
> 
> Thanks for the patches, and sorry for the delay in response.
> It's one of _those weeks_. Anyway, I backported the patch series
> to 6.12, and the changes seem reasonable to me overall. Ran it
> through our infra on a single node, and nothing seemed to break.
> 
> I did observe with testing that resetting BMC via ipmitool on the host
> did kick out sysfs reads as expected.

Ok, I took the liberty of adding a "Tested-by" line with your name.  If
that's not ok, I can pull it out.

> 
> Resetting the BMC remotely, was not handled (this seems obvious given the state
> changes are handled via ipmi_msg handler). Would the BMC send an event
> to the kernel letting it know its resetting so that case could be
> handled?

Unfortunately not.  It's one of the many things that would be nice to
have...

In general, dealing with a BMC being reset is a real pain.  They tend to
do all kinds of different things.  The worst is when they sort of act
like they are operational, but then do strange things.

I haven't thought of a good general purpose way to handle this.  I'm
toying with the idea of making it so if the BMC gets an error, just shut
things down for a second or so and then test it to see if it's working.
During this time just return errors, like the new patches do during
reset.

Thanks for testing these.

-corey

> 
> Best,
> Fred

