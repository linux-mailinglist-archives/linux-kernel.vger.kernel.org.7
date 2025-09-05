Return-Path: <linux-kernel+bounces-802865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E275B457B4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4205DA608E4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A45134AB0F;
	Fri,  5 Sep 2025 12:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ZcDZfvg9"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C9F39FF3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757074975; cv=none; b=JF0joBSh/ppFCxBjukY80+0m4lU6uDl/PP7k2jy0AQ4Sq8Ue5/XldMn7p8QJSJZAOgWIj78blU39bNYYcfPVW11FH+zXhZtbg/bi8cLs90iqWuR8Ja/7BQzjG4Bypx6ISLgkqIA1vlPY+YDvqMPIxf59oEmpkjeDZ7BvgfB7ecE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757074975; c=relaxed/simple;
	bh=f88gDGGRbMwX7i/jLItg/xSlOYP4VRiz0z3DVlv7lp8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DTLNxVT4XtSJGiO+F+GmYoOhbD2eLlxd2GnZakejw5DTb8rw1rCgGdD7CEo+EmzOC+EQoWC3RbwRVt++EtobGdX+j454kUm+P3Cn3h6261EbljCd5LiMO5l4+5ZsmKaS4wPOD8aBunRs5/Rx38BIunFoYCNav8GD1RAGV4HxNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ZcDZfvg9; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-323267b98a4so1907305a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757074973; x=1757679773; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6lxWl4V7y/wDq+LroI79aYAazd8UwfuBLrDZ9Wkh6o=;
        b=ZcDZfvg9I2bRfVaxkaMhG0zdzk0xKSkjiJDrY9+xoL0FwGP4vDoF8q8F59cypTym0i
         ysBQ8mUX94CVFz0toM4fmacAXH5A9p/ooUS7WjY+2OwljbDt/oaZM8hU+sa/vZXjwBQq
         ngfpTcmIhdOG9jOuljJC2aB9o1bgRyOeJ3w+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757074973; x=1757679773;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6lxWl4V7y/wDq+LroI79aYAazd8UwfuBLrDZ9Wkh6o=;
        b=vLn5rIkgx/MDA7tq0SFDTZL4CXdPfdLxvY7OCdolFgikPBQH75XHKOUzsbLbFCr1VP
         l3ZDMcfCir4hhaF308R34mxUVK5+G+5hZ9rLcop5pCHOt5vAZAJW9DxP/R4itOCd1iK4
         eN9vj0aotYt/0uO+GKVZpI97v1oLN6x5ZGMd9jf33fRmmGRqPtvZdc7LCeWok2g/QVNf
         yQKwgYf3HKAPC3LjdIPtSX1KMaedJ4FsKA6g0vwbhvZsM+WV6+6BWnp2aQYpGXFjQ9gh
         ovpcjx5KTd3JyCdTMqPrb3v4vr0Q9pvrVuxUTeJvbI5XdnLyoA6lLX7LzlUNmvCJ0yR+
         NXLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXB0YxEeZM/FAshvL5FjdkWSz3U6sjbd3zigrHINR7xNOZtV95Kx7O3mi2K3p94bvh/gakELJ5giVEfh98=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Qbv9ats8xdLVGCeHQ/eWprFgK9SrBphEJM4D+/ehTjcocc5K
	QQFKt78fRTur0/ribeX1F/hg94bxj4UnWStTUQ4j4slO5vcsvqtm2hp3GAkJhiGA5+uO9xp2wcN
	RpkL0wDZSfHrRcWsbOMW3rxAk0AaY9hUvSc1yJoPo
X-Gm-Gg: ASbGncupsz4plzo/Lb+mQ0UGbyZt6rSyXpGqyv9hcX5ekas24lvyP70kaFG3TtsrKcV
	mJ3MbJC8vFzCn5hcZrWKD2+jBTRqEVBJbt2NheFOg7yjHYaE6pvR0ejr8HK3l2rfBxQiRrRBGML
	lD2SZ0acZVHde351+jPlyCQ8FXbv2ZDEzWJFDORv3XxS8ZQy5AbMYBNVEvOwN8J2CGImq2eRzYY
	uI2VrEdwnMn1i/3plzSWhBnChJvDqIz6P/6AxpTkgle
X-Google-Smtp-Source: AGHT+IGUt0+NPYxAOfpcTKsdIZgMD/2aTOnjQauBXAsedoGoDooyWb+qeKpbfOZSEHR/boIOsnXxSpzklV+PIcXMqPQ=
X-Received: by 2002:a17:90b:3f8f:b0:32b:be39:7804 with SMTP id
 98e67ed59e1d1-32bbe3978aemr3553401a91.8.1757074973067; Fri, 05 Sep 2025
 05:22:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825145750.58820-1-akuchynski@chromium.org>
 <20250825145750.58820-6-akuchynski@chromium.org> <aLq8tUogl67VptRC@kuha.fi.intel.com>
In-Reply-To: <aLq8tUogl67VptRC@kuha.fi.intel.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Fri, 5 Sep 2025 14:22:39 +0200
X-Gm-Features: Ac12FXyeappBWW9ObA85nA1cNYhj4olXtKb4gTth6JkKRBs9zpklMmd4xbjPsrc
Message-ID: <CAMMMRMf1g+EwYfRmygCYiJGJd_XEeHrt-jrQaqKk1_SPyoRhXg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] usb: typec: Expose alternate mode priority via sysfs
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, "Christian A. Ehrhardt" <lk@c--e.de>, 
	Venkat Jayaraman <venkat.jayaraman@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 12:34=E2=80=AFPM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Aug 25, 2025 at 02:57:50PM +0000, Andrei Kuchynski wrote:
> > This patch introduces a priority sysfs attribute to the USB Type-C
> > alternate mode port interface. This new attribute allows user-space to
> > configure the numeric priority of alternate modes managing their prefer=
red
> > order of operation.
> >
> > Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>
> > ---
> >  Documentation/ABI/testing/sysfs-class-typec | 11 +++++++
> >  drivers/usb/typec/class.c                   | 32 ++++++++++++++++++++-
>
> Maybe patch 4/5 could be squashed into this patch, and I'm wondering
> would it make sense to just keep the typec_mode_set_priority() in this
> file (drivers/usb/typec/class.c).
>
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>
> --
> heikki

You're right, mode_selection.c is quite empty now. However, in the next
series, it will be the only user of the priority variable. So I'd prefer to
keep it there, if you don=E2=80=99t mind.
I think putting it in class.c would create a mess.

Thank you for the review!

Andrei

