Return-Path: <linux-kernel+bounces-765747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F65B23DC0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 03:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131EB5673C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 01:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1F319A288;
	Wed, 13 Aug 2025 01:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="fs244+1q"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B202C0F8F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 01:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049107; cv=none; b=uhoVAalXybJX+yG/T+41/kq8GHN725SjZ31c7FY8Ah2939rMx3BXYkmmyEri37BSMyTMt4D/GPbbqg/ffGM0N/mcmcDwlvEAHYZ84vh9OhXRgLlH90P9MqxW5Lr8JbzrLsEfa7qhXairCgX4gM0OfqTRe2q18bpdkUtUOlLj4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049107; c=relaxed/simple;
	bh=avQTEeDafSyhCSMD6MZeCRj3kg+eXD4fd3LS9e3ITyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j1mQEqJlC6OcfBBiA/quqKTh7kHNBvtX4YSp0/srQJ1t5nV32TLvQ1h5a6v53tvIHMVsW3IGlRiRaFYstHe7syYtCUdmwzQXFwgx3amF3WuJ4i0RQ5kvRp245RYRbrQvZbFq0Mn/+sV0Xi7vg5oJ5hMVMixdRbH3uPllXdghBTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=fs244+1q; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-7074710a90bso52490036d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 18:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755049104; x=1755653904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xf1ks6JUZ1IFFm+2x9B7TBmLSYkbRnh2E4KrA/6BMZ4=;
        b=fs244+1qnyRm1qIZqwQcPpjk+RsIreXF5lOHdIq42Gq3r/EOyPU9LggtaTFoxGJIm/
         RyHpbdAB2lPa0YOhzA47RR3uyuoS6OEV/dORknbvTfjt+b5vOuezbwecrHuVxd/XT9AF
         XlhgMcf+22ipAzOh3U1zhtilOuOWb0CuylN2zG8U9UsyTVK3F4T2ucXXXK1/phZ8jlT6
         9PHuow48+gJZsCw9y5jVnF13/QBKVDK/m2m9030+DDE0tMFPw/4x3MmflrvSlC5JwYDv
         RxEwcrCpHifO9xu3UqlrIRB43Gjc/o09+ocazLI7oVNATAYmYr/Nn2D1JJ6RGMiQOxvx
         7qVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755049104; x=1755653904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xf1ks6JUZ1IFFm+2x9B7TBmLSYkbRnh2E4KrA/6BMZ4=;
        b=t2FTsrEoN9IUDvUxEnr2/CvZb/nE2xu8EpPnjrXioU828gAY9XOnVWE6tdy0EkCNrc
         21Wg2CjKG51cGpNQrXpeuOtg8rNrwkU0Y4uUEb54blvhjPe4s7Pcsonm3Qeoa8AlXdlF
         4k+Mv0WL5JVNl4vHX6ugqwcPGra8iSGpbBTKF24DztKZNWiDcVuaOcTHoRkuZsGdKARz
         JRtP0MSkgh9HDKVu8t4XMobRLMcYli/Xobs4mh/Gwxwgvv1nkVOZrxlPZmjltqmiepgr
         JbtEIUbwlw74WHLGqCEgTL3LIewodzrah3dr8Z1BL5LJ/dTVLF5LkbRy0y0vQe3AZEIb
         UR7g==
X-Forwarded-Encrypted: i=1; AJvYcCUfxW1NndkY97t13S0sNZqb9st5hzHopd0G/U5XbG/4v0wp4hgy8gF7TYcBA+rLitPMyoB8tvO3FzFlVRc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJUmzmQWdFNoZ9SeNw5HMgEyLo5uC+/wdsQ3gu80O5usADFpNt
	a04KzmdEDO2RxxS9kkMGcLi9dZu+jiJUMb4Fg3mKIZERF2s7SAhFDcO9wwvOOCAzGw==
X-Gm-Gg: ASbGncsXNs30Ri7V76VgeoMP4/bY00QV4jYYg8eqclf5W8rZPflzRalMjopsRNW7nvY
	tJrsD3pD5/gAF8aXZk/yQAPyhTfxRnR9Mg2FQT+oSJpxVOQt/ABHXSsp/EQ0F7X+Pu+OBxemOD5
	JyYxty0qsxaml3SQpyceeqyDao6x0VWRAo1UsNwiWjouqJwtNjIM9EcvFgqcLEMVWc7doVnmUE+
	UbZeJhPKnYHmaKpXBMRAFQz66PpjJdP7t1YLs2A2xbCjnM7JaQL09FuXXiGnJNGnZ7NCO4qpkiw
	q1bIhYGjqQoZx76skgTqfRAxXPK0OIWWwmyC8tQmrb4RFxb/kWljJNKZCng+axBQF6YzwYin2GQ
	JJ2c40745l77stfbRrqT3EXo=
X-Google-Smtp-Source: AGHT+IFxLiXaFFD0/y9Ma0z0+T0y1/ZnYdoI8nKVbc4lPZ5ngJrX1uRpLH/2uUXlst7kCQpz8X72nw==
X-Received: by 2002:a05:6214:21c2:b0:707:5ca4:baa5 with SMTP id 6a1803df08f44-709e85868ebmr17221766d6.0.1755049104308;
        Tue, 12 Aug 2025 18:38:24 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::fa48])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077ce39fb3sm186698816d6.82.2025.08.12.18.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 18:38:23 -0700 (PDT)
Date: Tue, 12 Aug 2025 21:38:20 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: Re: [usb-storage] Re: [PATCH] usb: storage: realtek_cr: Simplify
 rts51x_bulk_transport()
Message-ID: <49559415-4493-4b90-a9bc-c6b9074a61f6@rowland.harvard.edu>
References: <20250812144358.122154-1-thorsten.blum@linux.dev>
 <b11a19b6-9fb3-4fdc-b94e-33ff01a634b3@rowland.harvard.edu>
 <19E72C72-AFD3-4D13-8F14-9A1F96B971D3@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19E72C72-AFD3-4D13-8F14-9A1F96B971D3@linux.dev>

On Tue, Aug 12, 2025 at 11:28:56PM +0200, Thorsten Blum wrote:
> Hi Alan,
> 
> On 12. Aug 2025, at 22:06, Alan Stern wrote:
> > On Tue, Aug 12, 2025 at 04:43:58PM +0200, Thorsten Blum wrote:
> >> Change the function parameter 'buf_len' from 'int' to 'unsigned int' and
> >> only update the local variable 'residue' if needed.
> >> 
> >> Update the rts51x_read_status() function signature accordingly.
> > 
> > That last part isn't really necessary, is it?  It doesn't make the code 
> > any clearer, less buggy, or quicker to execute.
> 
> It's mostly for consistency because the parameter 'len' is used to call
> rts51x_bulk_transport() which now expects an unsigned integer. I'd still
> argue that it makes the code and the function signature a bit clearer
> because now the type communicates that 'len' cannot be negative.
> 
> >> 	- if (residue)
> >> 		- residue = residue < buf_len ? residue : buf_len;
> >> 	+ if (residue > buf_len)
> >> 		+ residue = buf_len;
> > 
> > This really has nothing at all to do with whether buf_len is a signed 
> > quantity -- it should never be negative.  (And I have no idea why the 
> > original code includes that test for residue being nonzero.)
> 
> I agree with "it should never be negative" and ideally the type should
> reflect this if possible.
> 
> It's also easier to reason about the code when comparing two unsigned
> integers than having to think about implicit type conversion.
> 
> > Much more serious is something you didn't change: Just above these lines 
> > it says:
> > 
> > 	residue = bcs->Residue;
> > 
> > It should say:
> > 
> > 	residue = le32_to_cpu(bcs->Residue);
> 
> That should probably be another patch, no?

So we're really talking about three separate things:

	Making buf_len and len unsigned;

	Simplifying the calculation of residue;

	Using the correct byte order for bcs->Residue.

The last one fixes a real bug; the other two are very minor by 
comparison.  Regardless, they should be in three separate patches.

If you would like to submit three new patches, please do.

Alan Stern

