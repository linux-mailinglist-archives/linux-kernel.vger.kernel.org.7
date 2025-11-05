Return-Path: <linux-kernel+bounces-887450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D70AC38478
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC7B3B5A1B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 22:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 523322F0690;
	Wed,  5 Nov 2025 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL0FbEEv"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA2A2E7F25
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 22:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383556; cv=none; b=BMAhSi+QlDf1ss9spaQpI5BrTzNdITfWE4C4qB2CB8S3jwSUv/AdB6/d2YuVzkA4JEYKLcS1HJ97WACheoKGB2A4GanpqqsZJHbNiJdWfXB8xBkNjLAbKZgQyXU2eFLXk9+D1DzfIkDey56LkBHM7eQARf0BNu+KtMYWAA2Q/tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383556; c=relaxed/simple;
	bh=7o4gklFKgw28N/dVqpBVUUA3tE6+AIDPwGnxJE5MArU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOLHzrNqO35fvqipHUzIZt6FrJUPJXxxypvol0XP9+sIF7x5C2o28W/MH82r0CJy7e/5MTKsOPCnxQjhN24A7l5DhhRmdAAQTAtry+zQta/rZqUn6ojKJc0hmVnIAYob+Wkc2Tl5brbBZ0HzQS70wj5QEJMK46TZ6bexW2u0GII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aL0FbEEv; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29633fdb2bcso3351205ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 14:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762383553; x=1762988353; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HQiotgLAs4MrXnB3VRmkq1wlWPqo2nwCq+tDH85GcKw=;
        b=aL0FbEEvg4WU4iPT2FxSlQVbTV/pHIgWZnParEY8dWfG5HkCYkp6TOZHKJqHcgfGj+
         X7mwRQjCM7GHSUq2VKaknM5sUGNMZ1DhLi7KC/oNf3QfvVWu+ieFpNxAuVd/e2dlNg1s
         Gw+XhxRMSIYSdzHkFRbx3DLqfrvPagTpK+VEyNsPYsK92P58rJ5XbZAW5v+J0ig1Kfho
         xzO6YAs8RbPZP9IDDpxtnm0O27i/3oGvtE8b4L1cC7vio9ut2x2CZ8YfcpCblez/CR22
         K7lf0zOSf+j+lTsNLdy5Cd4djupvnlg7a+bjVe7fwBaV5laD3AuguXPbvuwwCVF1ut0A
         x2Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762383553; x=1762988353;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQiotgLAs4MrXnB3VRmkq1wlWPqo2nwCq+tDH85GcKw=;
        b=qMkh20yWtfMAicaSP/I9PwI6v/7yT9yvEzWQPxNQSdO0TLYdLmKE+ObhDVyTd07EEJ
         +zjqdR7uCY/OYv2kYYWkQHqHDz7BS9/R8k4o1+l61K+9VBfnrZD+ytLcpZqRUC5dED7n
         gzbMAObnqBOD+nhg9ELfe0r13K0rG5txH1BYuxa+XoT5hbe1OW4Rvh6KNL09N0UCKf0+
         7XmuUeekcCapc2IdCCPh5nMDCiAGpAenEhzBK5ZkJjMWlBRPtfRL4dupOzEGmbpSUP9T
         dxtzO4qjXn1FD/msHE92+z7nySS+Q9EuaorVAaxZZl2rDvzGHqT07HiyMUq48aq5S5S4
         QjsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsEAC8ihgNQnMk3EoejVEQO8km34WAC+RXsbg5zp92rVeQMw2FIuemC82H0ir2eJSKogB8w50fJtyMsmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIejmkA2JJJHUr7b/djgEtPsZ1MBrq9XvwgR+ZzNrZ8Zl4cl/f
	+uxOh7GKdVGfPUPGj/s+JM+/FCd4SP5lxFVuASXYsVZdxAwD0zGHR0jE
X-Gm-Gg: ASbGnct4+h26jisRaqtFxIhSok+S9YDUE50vcNNkWppxxbfFiaB+GplX6dyneEn9Wv0
	J9D25zYXlych3D2xl/PtKiPjkYRR2alx9rbgbXGxDWndfWGeleLXMbggqPzOWk/c7c61eIZCT3p
	JG3iiERJTN0ZcEdzVp3gZSBlr81Yd6VeX2C89zlIlTEXDptL0iY9GhzeSNQS+QqP6XyuI2WoUhP
	jdVh93RZQHOFGK9D6UOJuZMzh+l4+FJY6REcUc4J7/mJSxOKSPNZkZAUBGivkKfBYANgOxGt8j/
	wqBRPr3QciZpRDR/ktAhJXGLqEXgWhakWM6+9iV+w4XtFyuYX2DPfAY8YZrkV6YeSVtkZAd3Fm5
	/aGlfaJEMztGxj0qSp30i99RuIHVFEJHIlgSkHaZen0DMjWwd/XJHjEUSHBImn4asaEHJuDzS58
	RRZC3GLkEVm2sL3OvYyMG2iAcSdHmapQm+J3/IiwiMSQ==
X-Google-Smtp-Source: AGHT+IFTIY5OSw2SJzl+Lc+/ugAeApcqWxgLSu0PU/TlO81MTYbE7Gh60ilrKYJ2KHuXdZUzvJKI9Q==
X-Received: by 2002:a17:903:1a8f:b0:295:b7a3:30e6 with SMTP id d9443c01a7336-2962ad1a9c0mr66312205ad.18.1762383553239;
        Wed, 05 Nov 2025 14:59:13 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:35dd:7def:e1d1:adfe])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c74264sm6056065ad.68.2025.11.05.14.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 14:59:12 -0800 (PST)
Date: Wed, 5 Nov 2025 14:59:09 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jonathan Denose <jdenose@google.com>
Cc: Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <bentiss@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: Create input notifier chain in input.c
Message-ID: <h6nfc5amtqsfbka5n36i4hldcpomyped66xbvtaes3y6p3dctv@3j5iiyky6o44>
References: <20251030-lid-switch-notifier-v1-0-c58dc9b1439d@google.com>
 <20251030-lid-switch-notifier-v1-1-c58dc9b1439d@google.com>
 <a4zd7uzo3aigyrhturbpgtcsm2slmtqefivky2bfhqiupcc5aj@iorbkwz6ief4>
 <CAMCVhVP+LW27iLXttyFegRj_HMHheYrZtj4uuERLN0uqUjkR6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMCVhVP+LW27iLXttyFegRj_HMHheYrZtj4uuERLN0uqUjkR6Q@mail.gmail.com>

On Wed, Nov 05, 2025 at 04:40:29PM -0600, Jonathan Denose wrote:
> Hi Dmitry,
> 
> Thanks for your feedback.
> 
> On Wed, Nov 5, 2025 at 3:55 PM Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> >
> > Hi Jonathan,
> >
> > On Thu, Oct 30, 2025 at 02:10:40PM +0000, Jonathan Denose wrote:
> > > To expose input events to other kernel modules, add a blocking notifier
> > > chain. Publish LID_SWITCH_OPEN/LID_SWITCH_CLOSE events through this
> > > notifier chain when input_handle_event detects events signaling the lid
> > > switch has opened or closed.
> > >
> > > Additionally, export a function which allows other kernel modules to
> > > register notifier_block structs against this notifier chain.
> > >
> > > Signed-off-by: Jonathan Denose <jdenose@google.com>
> > > ---
> > >  drivers/input/input.c | 13 +++++++++++++
> > >  include/linux/input.h |  7 +++++++
> > >  2 files changed, 20 insertions(+)
> > >
> > > diff --git a/drivers/input/input.c b/drivers/input/input.c
> > > index a500e1e276c211d1146dbfea421a3402084007f8..b342b1ff138ccc58d4623edcf1152bd85d7054bf 100644
> > > --- a/drivers/input/input.c
> > > +++ b/drivers/input/input.c
> > > @@ -26,6 +26,7 @@
> > >  #include <linux/kstrtox.h>
> > >  #include <linux/mutex.h>
> > >  #include <linux/rcupdate.h>
> > > +#include <linux/notifier.h>
> > >  #include "input-compat.h"
> > >  #include "input-core-private.h"
> > >  #include "input-poller.h"
> > > @@ -62,6 +63,8 @@ static const unsigned int input_max_code[EV_CNT] = {
> > >       [EV_FF] = FF_MAX,
> > >  };
> > >
> > > +static struct blocking_notifier_head input_notifier_head;
> > > +
> > >  static inline int is_event_supported(unsigned int code,
> > >                                    unsigned long *bm, unsigned int max)
> > >  {
> > > @@ -367,10 +370,20 @@ void input_handle_event(struct input_dev *dev,
> > >               if (type != EV_SYN)
> > >                       add_input_randomness(type, code, value);
> > >
> > > +             if (type == EV_SW && code == SW_LID && !value)
> > > +                     blocking_notifier_call_chain(&input_notifier_head, value ?
> > > +                             LID_SWITCH_CLOSE : LID_SWITCH_OPEN, dev);
> >
> > I would prefer not having this directly in the input core but rather
> > have a lid handler that can then use notifier chain to forward the
> > events further.
> 
> Ok, that makes sense to me. In that case, do you have a recommendation
> for where the lid handler should go?
> 
> It looks like drivers/acpi/button.c initializes and handles the lid switch, so
> would it make sense for it to go there?

drivers/acpi/button.c is not the only source of SW_LID events (we also
have cros-ec-keyb.c and others), so I'd recommend putting it into
drivers/input, maybe as lid-notifier.c

> 
> > Also, here you are running in atomic context, so you need atomic
> > notifier, not blocking (or you need to involve a workqueue).
> 
> I'll use an atomic notifier in the next version.

Another option would be to schedule work and then use blocking notifier.

Thanks.

-- 
Dmitry

