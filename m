Return-Path: <linux-kernel+bounces-842385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 384EDBB9A95
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 20:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1DA14E5661
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 18:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1EA1D0DEE;
	Sun,  5 Oct 2025 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="C44eZCFA"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727A26ACB
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759687231; cv=none; b=Oq3RWOREGd3T5Cz0zRe2opeJUvPCiiWDgoEnKYzyc3tebMorvu37rhLvYDxxRz806feWcaDMMPfxS5fz5RTLCDObFbYMlcC3V1mR4MndoN9Z63qErkm+W6FBDrSMIUPOacU90iLQAP3HonLZNo+voR4i+hkF6jmaW7YDmdt49zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759687231; c=relaxed/simple;
	bh=fKyPY1KZysFZ6cZzrqe2PdDw/KCTwAYy8HlI7aP3w8Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kEX4C9aC5sALVZdQB+HJuBxvpQIFnCRjVM3rStMU20mmCZ6QJyDvN9mXmnF2EJ6BU3W0RPRescPFwISFBSfq7W9Sf46afo/36sRfZB9/5HXsEf4x8UvrIvleK/plE2lTfnqjVtAkyZLBjN4wo2tLh00khcpkjNsUj1AZH8KsXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=C44eZCFA; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee12a63af1so2564931f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 11:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1759687227; x=1760292027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImS6cY8Oyyo6Mf0eUI3NEiNc+CmuQNP1hByNntsU02A=;
        b=C44eZCFACUl9etQfK8QfRUBV9VmIp7NXmwJqBWxS2VLueFx5h/ywTuC2oKG6mJREQy
         dDZS+6txrHCEiMU7zevwncgHcaByUSYlcYBg0yLTh3PZUyzxVu3Z+SmiA1/4KTu/h+dL
         xE7l8N+uTEm1Fa8pjuEpV3KNmAIBCOUJKpz1E34mO7BhLR4qGqRE/HScAU32Fl7vDVfE
         UOEhkdtd0vXEw5JwJa9ocpdfL9OTdz5W5dn0wf5RuxNtu8I/28auedZ2DF1zIW/dKFHD
         wh3e3+tF8M/8gcT21e+DS8B1XIydMScxXudowmH4r9lzAL4e9c9bJOQJlXLFnjQK1uEi
         xdCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759687227; x=1760292027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImS6cY8Oyyo6Mf0eUI3NEiNc+CmuQNP1hByNntsU02A=;
        b=WOdSg/q5+ygSwHNBn9LkruHCICjdOr2W+GMK+XzCFMJlfv8gZrN7fbJ7ugEMEML7wb
         zaUHBD2nCVm+xALJdBvBDhxV+L9VZPd3dvaO4gkDODt8ePzi9W/8+8XSFLBQIUVQyvuU
         BkMJSVGbt3Qr/gAWStCmYT9K0T9ufHbkzibNB+jmLGfHliQ1sUJTD6pBbYvljQSkifRQ
         u9EOB1VV3A62l4dWDHMwpVZHmGKCEOzty6sHQJF/95jJb+MeAiDeA/nusA7t9pDGrkri
         eozNh1xb+kVq+6l/G5BXoKfGhdSO4er6QejS7tosL0WftU/17peOozMSXPwz4hvVRj0J
         NtKw==
X-Forwarded-Encrypted: i=1; AJvYcCUQxgeEEuHV3lKJ3WyA6NGrMsDOxLiLeo47YEw/pRz8NT12grQYGr+C7euYJt5KKbf6MfuBObn+ueIfCKc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpTFg+doS99suZd8nozJcUSNh2x1AAWXTchLFt2W7lqSLxUvfo
	8Vw1DGV1ySPvdATlPhc3hnCiGNoydYYvTzkEbLyD9pfFkfsA32Pn8iNThOjRDAsq0lM=
X-Gm-Gg: ASbGncu6n80XP8EaGWu+pziaEAhdWkQUIe+zID75zDMbRV/uUl2MioixgJqNkQX3L8e
	Nv+EgH+b+RzXwDvu+nIjlHYOFqAsPbgSU0Gn0yeXTOSHr3baFMn+h8uR1LYhlEl0YnN1zG8m9Zu
	ogCenbDbsAVbKKehtOBVJNuOY9Uw6A4i0wTIhT3WV5Pv5mQgzOmJGWNywlz0RyorZ+iwXzv2vOJ
	WrGCdUIgBkaNdjQquXQcIjipDDAjZunQOPmiFFab3tCENxSCGg4msRuBC5NDzkp6U59neI+bzjr
	YfmVNJLgBZdP1ZXye4rjk7Afi3MuR3aKyCT7e2ptPggi72OBq8QBKv7JZnJOs+itkLrRRSvzx+/
	8EpcyvkqmQ0urnkI6EpAlBcMczBi1/oJ116ya5xKorRQRlbbWBONWOj+ohmHHDhjK7MkCBWmmK+
	3Mq92eQPzLYw==
X-Google-Smtp-Source: AGHT+IFWxa8m+ckSyktnNkfyPCaCU6hWeXvfY1vsF6A0Jc2CJ1yz8Stkwlt1eU1k8lr3R9WkWsBSUg==
X-Received: by 2002:a5d:5d11:0:b0:3e3:5951:95ff with SMTP id ffacd0b85a97d-425671c75e6mr5787975f8f.62.1759687227260;
        Sun, 05 Oct 2025 11:00:27 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:33bb:4d0:68e8:89b8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8f083asm17260792f8f.43.2025.10.05.11.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 11:00:26 -0700 (PDT)
From: Aliaksandr Smirnou <asmirnou@pinefeat.co.uk>
To: kieran.bingham@ideasonboard.com
Cc: asmirnou@pinefeat.co.uk,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	hverkuil@xs4all.nl,
	jacopo.mondi@ideasonboard.com,
	krzk+dt@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mchehab@kernel.org,
	robh@kernel.org
Subject: Re: [PATCH v5 2/2] media: i2c: Pinefeat cef168 lens control board driver
Date: Sun,  5 Oct 2025 19:00:25 +0100
Message-Id: <20251005180025.69602-1-asmirnou@pinefeat.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <175967476560.756374.10666787102940352317@ping.linuxembedded.co.uk>
References: <175967476560.756374.10666787102940352317@ping.linuxembedded.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kieran,

On Sun, 05 Oct 2025 15:32:45 +0100, Kieran Bingham wrote:
> I'm really looking forward to trying this device out sometime. Very
> interesting piece of kit - Thank you for working directly to upstream
> the support! That's really awesome.

Thanks! I appreciate that. It's been interesting work, and it's great
to see the device getting some attention. I'm looking forward to hearing
your impressions once you get a chance to try it out.

> > +  rx_data->focus_distance_min = le16_to_cpup((__le16 *)&rx_data->focus_distance_min);
> > +  rx_data->focus_distance_max = le16_to_cpup((__le16 *)&rx_data->focus_distance_max);
>
> What is the focus distance in this case? Is it a measured distance that
> could be applied to focus?

The focus distance reported by the lens is the distance between the
camera's sensor and the subject currently in focus, measured in meters.
It correlates with the focus position - higher positions correspond to
greater distances - but the relationship is non-linear.

Libcamera's autofocus algorithm works in dioptres, which are the inverse
of distance. In the driver, reading the distance from the lens allows
the creation of a piecewise linear (PWL) function that maps inverse
distance to the hardware lens setting.

> > +       case CEF168_V4L2_CID_CUSTOM(calibrate):
> > +               return cef168_i2c_write(dev, INP_CALIBRATE, 0);
> 
> Is there any documentation on how to use this control?

The control performs a calibration action operated by the controller
to determine the total number of focus steps. The action is invoked
by the calibration utility, which moves the lens, reads the changing
focus distance, and finally generates a PWL function to be included
in the Libcamera tuning file.

End users are not expected to trigger this control manually through
the V4L2 API, as it is intended for use by the calibration tool during
system setup. For this reason, separate user-facing documentation for
the control has not been added.

In other use cases, calibration can be performed simply by toggling
the AF/MF switch on the lens three times within 15 seconds.

> > +       case CEF168_V4L2_CID_CUSTOM(focus_range):
> > +               ctrl->p_new.p_u32[0] = ((u32)data.focus_position_min << 16) |
> > +                                      (u32)data.focus_position_max;
> 
> Is this really a custom control ? Is there any way to convey this
> through the min/max of the FOCUS_ABSOLUTE control ?

We aimed to minimize the use of custom controls, but in this case one
is necessary.

When the driver is already loaded and initialized, the focus range of
the lens may vary depending on the lens state and configuration
options. Because the control's operational range is defined during
driver probe, the Linux V4L2 API does not allow the minimum and
maximum values to be changed while the driver is running.

The maximum focus position is not known until calibration is
performed, so initially the position is set to zero. The focus range
may vary slightly between calibration runs, as it is derived from
counting motor steps, and its precision depends on the lens's focusing
mechanics.

Additionally, some lenses provide a two-position switch that changes
the minimum focusing distance, significantly reducing the focus range
 - for example, from 2100 to 800.

> > +       case CEF168_V4L2_CID_CUSTOM(lens_id):
> > +               ctrl->p_new.p_u8[0] = data.lens_id;
> > +               return 0;
> 
> Is this a specific individual ID value for the connected lens (i.e.
> every lens has a custom id?) or is it a reference to the lens
> model/type?
> 
> Is this something we could use in libcamera for instance to select an
> appropriate tuning file per lens (type) ?

It represents the ID of the lens model/type. Correct, it's purpose to
assist in selecting the appropriate autofocus algorithm settings.

For calibrated lenses, the controller stores the focus range in EEPROM,
allowing lenses to be swapped without repeating calibration. The
Libcamera tuning file includes an autofocus algorithm section that is
linked to the lens's focus range, focus distance, and focusing speed.
Therefore, reading the lens ID when loading the corresponding tuning
file after a lens swap is both convenient and necessary.

It can be read as follows:

v4l2-ctl -d /dev/v4l-subdev3 -C lens_id

