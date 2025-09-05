Return-Path: <linux-kernel+bounces-802888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E70B45801
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 14:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769C9A03CAA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0A34F482;
	Fri,  5 Sep 2025 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RsdeZiHP"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0517B1F1513
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 12:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757076076; cv=none; b=lzvaFPhJlZmnlwxB8rZWJgIr0u+leI3ArdqJfe+VRf7eQ9PstQfKgsaoWysSmXwiNXJ+a487cdCtoJZKJZOvl6Y1PY3IY7ahZ2chDRV5ccECJSrtkYeoFYvAPnKL1ATqfM6NZPNxIaJZoUVmYOKuy2QaMhO+hOmiyDT8NjU0GLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757076076; c=relaxed/simple;
	bh=oBXHKrWN/b8xEphfOBxvMXuoVFvsOyyVX+52kY7ZBjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrJEUjHqFgaw+aUns8VyCtsoLpaM2aQS5yCtKro2fR4BgffKPvu4WM1EyZ99arMKgy2sSNfnemi/sj0vPz26T2epoZzOrvBmE1UzZvdbAdJkP2zjrnuv4cQjnET0cwdXj6+p4zNxdMZ/EauBh3J614r5Tt7tE/s8i2ywbMpWUNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RsdeZiHP; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b4c53892a56so1829913a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 05:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757076073; x=1757680873; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CDIiR34iXezMR7BHEFFCv6iSUlhvz1mav6TCgrGlsTQ=;
        b=RsdeZiHPpHq0LgG1fPIuYRZOQ1TgGLw+legfSIYFUisEzOVuZOyPPmpViTDn16AGqj
         aOfr57mpsU6y5hKF2L0XSqFBPVU0+LtzeL5MUaYeLDiQUCVIqpm1fgTRZtactURtMHVx
         0HqxcUqhCl7w0PUv687i96Abswp1MapFMgGAQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757076073; x=1757680873;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CDIiR34iXezMR7BHEFFCv6iSUlhvz1mav6TCgrGlsTQ=;
        b=kWc7ugfIZ1u2jOMl2/sX7am4c883KrQau3RRQssKtjXWss2bpKIRze3xx08M3E3/nU
         qjPYSOCU4831WF+bfUgqgZG7eOTCMqzUNEHh4c4+hmvCbihrrxqT1PipDUgrUq2EePTp
         90AVSEBfb2HQp6XOUltTue5NJfyKgFpASsD65RyIiJTXXTwwud8mD18EpNviTkNQMKsr
         CjUoGX/CLVE6ltdWYQWjj5Q4XKmzaY9YdqYqEdBeP8KTy3WvMaojDnShfxMmW2F3F35Y
         7c0gDJ5Ves4Zc5wE9Y4nvDarLPfQIDReXOBUjkuTySK17N1tc+t+C+yfCME/pAofnQsb
         08hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUk91hTXxjkP8eWxStdNO6HtdyhbDCCiJ1yk4/Gvk2d/1vzvNHviw9JMOwee3seCARQsiyX+Fb6pHEawbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxkWqlWfLjbW7XzYS569tJNnkJzVVxbrPd0xacSppe+38OiqWC
	UVTVijuXHwKO9bCBFY8a3tOOKCrdfAnAgrhM64+NCETjEI+RL2dfAdEFfnHJDUF7bV19BbFl5Jl
	XR6h9JULntiyBx49JRnUAc5iRWdd64G+D+ds/7Aek
X-Gm-Gg: ASbGncteNCdT95NBbVlSn/dHexPW6OeMjMRFl5K8hsmS8eCGbA5t3PKMapPj075u7D5
	yx8oDEaQJ2WY20IKMpBUolfyz5PXAGxTSQwhBdlH6iuttI1Tyv0eIHzKc1fD6pC6yMKM7mWjgR7
	Hed5PR1vBslmFsOKbkgpfewpc6iniZCFNDuc0LjbyEXZGXQdvwlLbcAk6ini8q/nmZMhfXRyFIV
	j0mwimENcDTHxUXPxAoVpvg+nskM40DMQ==
X-Google-Smtp-Source: AGHT+IE1e9GdET1HkJdnTcqNZ6pmew3/GoNUVVNslDsopYdaiOZRiWcX4ix6U/VN/o6VHJOiC5A+QLarYg2TUdmWIjE=
X-Received: by 2002:a17:90b:3d48:b0:32b:70a7:16da with SMTP id
 98e67ed59e1d1-32b70a71b2fmr11961610a91.20.1757076073274; Fri, 05 Sep 2025
 05:41:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825145750.58820-1-akuchynski@chromium.org> <aLrQKurGZkbCkjlw@kuha.fi.intel.com>
In-Reply-To: <aLrQKurGZkbCkjlw@kuha.fi.intel.com>
From: Andrei Kuchynski <akuchynski@chromium.org>
Date: Fri, 5 Sep 2025 14:41:01 +0200
X-Gm-Features: Ac12FXyxvfhy8ARaoEcCu19f2V-MoHQ9ApY5WO6r6Z4u1iuoDkWCmEuJxuSbxjQ
Message-ID: <CAMMMRMcYiB8Sb5sjjdH_TcX8b2kGZFcM=r8L_txpZtyBGZt4Gg@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] USB Type-C alternate mode priorities
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Tzung-Bi Shih <tzungbi@kernel.org>, linux-usb@vger.kernel.org, 
	chrome-platform@lists.linux.dev, Guenter Roeck <groeck@chromium.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, "Christian A. Ehrhardt" <lk@c--e.de>, 
	Venkat Jayaraman <venkat.jayaraman@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 1:57=E2=80=AFPM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> Hi Andrei,
>
> On Mon, Aug 25, 2025 at 02:57:45PM +0000, Andrei Kuchynski wrote:
> > This patch series introduces a mechanism for setting USB Type-C alterna=
te
> > mode priorities. It allows the user to specify their preferred order fo=
r
> > mode selection, such as USB4, Thunderbolt, or DisplayPort.
> >
> > A new sysfs attribute named 'priority' is exposed to provide user-space
> > control over the mode selection process.
> >
> > This series was tested on a Android OS device running kernel 6.16.
> >
> > Changes in v2:
> > - The priority variable is now a member of the typec_altmode struct
> > - typec_altmode2port is used to obtain the typec_port struct pointer
> > - Default priorities are now set based on the order of registration
> > - The mode_control capability is enabled by default
> > - The mode_selection_state struct will be introduced in a separate seri=
es
> > - svid will be used instead of the typec_mode_type enum
> >
> > Andrei Kuchynski (5):
> >   usb: typec: Add alt_mode_override field to port property
> >   platform/chrome: cros_ec_typec: Set alt_mode_override flag
> >   usb: typec: ucsi: Set alt_mode_override flag
> >   usb: typec: Implement alternate mode priority handling
> >   usb: typec: Expose alternate mode priority via sysfs
>
> I'm sorry for keeping you waiting. I think these are okay - although,
> I had to put a few nitpicks :) but they are minor - but can you
> include a patch where you use the priority member in a driver (maybe
> cros_ec_typec.c)?
>
> thanks,
>
> --
> heikki

Thank you for your review and feedback! I appreciate you taking the time to
provide these notes.

The patch using the priority member is part of a subsequent series that I
have ready. I will send it shortly. This functionality is implemented in
mode_selection.c to determine the mode order, and we plan to use it for
both the cros_ec_typec and UCSI implementations.

I will send a new v3 patch set shortly with the minor changes you suggested=
.

Thanks!
Andrei

