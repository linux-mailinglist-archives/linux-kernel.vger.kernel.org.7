Return-Path: <linux-kernel+bounces-803457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D92D9B46002
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A41BCB614A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 17:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9357B37289F;
	Fri,  5 Sep 2025 17:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZceW/fl"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3789F306B00;
	Fri,  5 Sep 2025 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092986; cv=none; b=k8iIfk17vGe+I7a7L/dIH1dRlw7Om5R2doXeeHkJrWqDIhQonq421NZekP9avywFdOYD8coBHwSkOTcliI+kWHI+2M98/cgJEkFwr6Wsmn2S4SDI6qtqYg0By+ZRw/RiXwZ8MC+HkwKqjM6txr21boxsGH0lPIXkbSxV8tx3u1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092986; c=relaxed/simple;
	bh=mGWiWaE6I6hKE2f/4EzWDzmc6s/u3BxagDNUzVCSctk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FHE1KPZl0ISIxnaWsL9bWzn5HOd/N5p2uXAKVRHAhTNcTHAAbzifcTA5hjpEgGQU1KMNxFdk8muhSUO69GYE/EHNCjNAwQSXJEgYmkIJKnCJ2ciSp4hLZOGja++adtuRrT4ApTCWfXNRWwOigemMDXXLtzaKfPAyOHDM4sk38Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZceW/fl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad681so3564661a12.0;
        Fri, 05 Sep 2025 10:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757092983; x=1757697783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGWiWaE6I6hKE2f/4EzWDzmc6s/u3BxagDNUzVCSctk=;
        b=RZceW/flPWaq9/xpqIXDHMHhXheo5Ta/QW10ch8R7f0ovfRyXCGfOQIZgIyzbRjXwj
         s7VLnmL9IT4/Uet+9kndWzmJpcIly5tJ39WyeKBYCLM1ceoGDSw1HcSN1DxGyQpb1RmY
         hVC4xyAJlv0+W+skW6L3/NLl+vYi2/9lsWo2OZLPwPiovGiH5BA8HXcd14Xtf6NHoTT5
         nV5boyye/zgsFHQau0YJML0LJzMY+ODb2zwrKbW4EvY2+l4pKQ7yMjAdaXPrB6wNsQE6
         a0Uh5lHvE7o8T9j3FDAQKEWm+Mjg0uzoJIR671SFVX6pWzXze//4xVPrPfBlX3oKh3TQ
         oCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092983; x=1757697783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGWiWaE6I6hKE2f/4EzWDzmc6s/u3BxagDNUzVCSctk=;
        b=nuUIsUKFr+jhLlZolSWUJoA4iSNsVb9W+yiVUZBLNO3d3vD0Am/7Nxa10kgdy88qUS
         kPMeOyHWzuh13vbbGToAPRnFggVt5f6dds+wCttZr0LpPMro4qQBdxlvnzAqZde1IFTb
         BE+Ueye4L0DNM45Fyoq0wDM8F8yQSxCxhOpFiopVd0jtpn+3Dpzx/wTlXLpvHFJr+5Y5
         mDpA4PIj4CFrafy6mpQ5r3cBAwweJF689U2JxD+md656cTg+y7/+JV+gnYIQ6NHmridS
         C9RUUMAGhpCXMrukFF/9Id1egy3etLpw2bbFgjuLkj/VSokhXC5gXf7eK6HeLhpQ8cfu
         mQcA==
X-Forwarded-Encrypted: i=1; AJvYcCUPOm/LZAdw9R3YggUTAGHZqR9PK3Yrt9r7VpLwc4WZ+twnYu6ZjrhXHfqNYgmlijMY5rF65WBTiAK2r1DQ@vger.kernel.org, AJvYcCWMUb/XEW+lp7W+CKMGCe3lrMhEbrU85ERM81bHSBsFiwO7iJ7Ubtqun0vFjVcoa/0CDu50mhc5SuHWvko=@vger.kernel.org, AJvYcCXDyJKze4MHrnFIERwqjNeyi3Vfh+3VDja402QhVIkN5say2U3+jnKBUUcZU8Am78xhhNHEIxQtcME7@vger.kernel.org, AJvYcCXic3r5JqxZUl5GM7riA+v3Xl+MGeA5d6ktCwC6rZxZNG6xkcMduH/plQdtBH+byMafoCNCeFseSLu1@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6oAjkrRCwx3+V4iTf8xRYpZ6CgXc1+DNvZPSpZ0F7hExu/m3W
	oJ7cbCX3ffmtge+iIqWwhMoPYrsSOFIfGyJS9se3hqHaPTtsOGp8CYFWMbiy/vgbNqPQYqaDC7l
	dIGnticvFlNEdXB5F+exr3uUv1+ZUatIKm09FPT6U
X-Gm-Gg: ASbGncsbMHT0BJMg7V6d7T0sscrnJlyYvhff8iRCawR/sMkkjIDSSUydH9+kB7GU3CV
	h4hoYuToz35OJubG0N6spDlf1Z1MzP250sNXQOdYL3I4czdPID/CySGiWo5rAybpgQ4GNp/dQAO
	6qsbpXSxaaE//GjpA2OQGBUd6l6w/0Nv59zGxHvWgLO3sx7Y3cirh3iBZ23yhDq2G1EvMuCZg6M
	9oTWWBLCp7LCqobyzM=
X-Google-Smtp-Source: AGHT+IG1EevZl5gNe7tD3U6dF+X3O4BzPpBn2tmPP3k+dNUVDqX/Q568jdKn1EyPG+pq749qDdlVfF5qm6ykFFbEqB8=
X-Received: by 2002:a05:6402:3881:b0:61c:5b3f:4d69 with SMTP id
 4fb4d7f45d1cf-61d2688c061mr19821874a12.11.1757092983140; Fri, 05 Sep 2025
 10:23:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250904-hwmon-tps23861-add-class-restrictions-v3-0-b4e33e6d066c@gmail.com>
 <20250904-hwmon-tps23861-add-class-restrictions-v3-1-b4e33e6d066c@gmail.com> <20250905-deft-porcelain-teal-a3bdbf@kuoka>
In-Reply-To: <20250905-deft-porcelain-teal-a3bdbf@kuoka>
From: Gregory Fuchedgi <gfuchedgi@gmail.com>
Date: Fri, 5 Sep 2025 10:22:26 -0700
X-Gm-Features: Ac12FXyU_zPmF4j8ZQQX0_c8Sixq8TzhVGirncT8O8xrCsAjMiL2w60zjFD_UMk
Message-ID: <CAAcybutsMdXmqrA6kG9L5OTP9ZPyLzYrXTGUGLAkWs5+MH9ifA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: update TI TPS23861 with
 per-port schema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Robert Marko <robert.marko@sartura.hr>, Luka Perkov <luka.perkov@sartura.hr>, 
	Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Jonathan Corbet <corbet@lwn.net>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 5, 2025 at 1:10=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
> On Thu, Sep 04, 2025 at 10:33:44AM -0700, Gregory Fuchedgi wrote:
> What's the meaning of values? There are no other generic properties like
> that? Last time it was a generic property, but maybe the answer to my
> question should be that there is or should be such generic one?
>
> Also, why exactly wouldn't you want to accept here always the highest
> power class? What makes it a board-level property?
poe class (values from 0 to 8, this chip only supports 0 to 4) defines maxi=
mum
power of a poe session. The higher the class the higher the power (with an
exception of 0 for historical reasons).

A board may have a power budget of let's say 7W allocated for a poe device.=
 In
that case the board should only provide power to devices which ask/negotiat=
e poe
class 1 (up to 4W) or class 2 (up to 7W). Devices that ask for more should =
be
rejected to prevent brown out issues.

I think some of my questions last time got lost in the noise. Given the inf=
o
above, should this be a generic property? And if yes where do I put it?
I haven't found an existing one.

> I fail to see how this is property of a board... unless you wanted to
> figure out which ports are not connected, but status=3Ddisabled could be
> used for that.
yes, status=3Ddisabled is used for ports that are not connected at all.
off-by-default property is different.

Most boards want simple automatic operation, no userspace involved. E.g. en=
able
power as soon as acceptable class was negotiated.

For some boards, however, it is critical to have control of poe from the
userspace. Without this property the driver may enable power before userspa=
ce is
ready.

> Sorry, but device has FIXED reset values for registers, so whether
> something is off or on by default is defined by compatible.
yes, but it is also defined by ports-shutdown pin state.

Here's our board startup sequence (see 2/2 patch):
reset pin has pull resistor keeping reset active until driver takes over th=
e
pin. The driver activates ports-shutdown pin first and only then deactivate=
s
reset. Then configuration over i2c happens, while ports are shut down. Then=
 the
driver either enables a port based on off-by-default property or
doesn't, leaving
this up to the userspace.

This setup guarantees that from soc reset until userspace is ready there's =
no
poe activity on the ports. This implementation is also flexible and backwar=
ds
compatible.

