Return-Path: <linux-kernel+bounces-734407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AD0B08131
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 01:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C10FB581BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 23:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729222E62AB;
	Wed, 16 Jul 2025 23:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ghvX4P+t"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7908829AB01;
	Wed, 16 Jul 2025 23:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752710362; cv=none; b=OH1z+5qi5ynylEnR89yV2KlBoue6QgyEMpmwXFrDp9/tYsK5tvLP517ficMr8HyZoj+XDZbnpiRxes2VDqV8PGqbxx4zjQaRq9GZiGgs/ElygV0GbO11JUYdHxsF3TIokfCCsQU+EvoJIDUbGyo0GdPSJgIAtxUqsq0sdPbr2MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752710362; c=relaxed/simple;
	bh=6y9a+l/XQaojXIrKW+ab5aq9WDMMK73JMWW7yPE85V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGTpjsm6xVzpD1dXFW+V66qty4VJJa/d2/WTP/xU1koqp/ddvkE3toVKm7Hd50R6PyvGak5FV280pUw9OBY+ol6zrVMiYxXAqBht52L5FTmCWtE/XETfbNRDKrjBt/KRdSz4GrmJLwlr8tx/QaCaT1jdTSU/nhbJ3ytcnKXhQTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ghvX4P+t; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b31d489a76dso295184a12.1;
        Wed, 16 Jul 2025 16:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752710361; x=1753315161; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2S5eMLw9uQ0ySw8KP/ZOHT+KFFuQg4GIcgB7Vydc+Sc=;
        b=ghvX4P+tuPBu/ABIdIAFDewpOl7akmeiXhZr1hDMtew6kUmSfc89OQTLDlK2DpD99F
         b2hGkDREpqPjcVEF9/uhiZVkeG/EfB4xxtjgMyNalS/Y8yeP0XdpeJAU40ej4Uzw3xVU
         WYYAA8n25wBmq6aaTdCnKUCpaLQ3Z5WTPhfPGMxToHKOiEoTFZ9uWoA5wA3UlcB3O47w
         TXF4yXOnOVFXbnLrwuIFTawACMP2qR6Ne8ebom1Xf5asNyjGZU2PazTshG+tPExf0sOZ
         TFmXxdoYs9MjXESWtpzd20rtzq13e+DdHSAmWV7vfvyLzAzFff9nALf6eFrrhbxMP1KX
         2pxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752710361; x=1753315161;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2S5eMLw9uQ0ySw8KP/ZOHT+KFFuQg4GIcgB7Vydc+Sc=;
        b=CM9MQuABudUSxmbQPiPGkE9Bwy6HCy5zoq30S4SusmuRbjzjtFQz0Pn1RFLCCY3ERN
         cMgIgqS2iBlyRJvsNjJ6PKI+wqnkg81HFOTcV2zPcYeNqDAnx2GPHKIY95kCgE5MO5cu
         DCV+FWsIlZY6qIR/mur45v0/bA7E0aYfwNCw+A+FDl6dCnlrON1XZA9Y1YSaiiVlwGCa
         +L88Ka2rpf+EHRei6OyTgdLTi4/aK/U2HALl9NH518edfZnHpD0C4DF7rD75oLvbvEty
         FeHsBygbtRgvNxL9eVz1OE94eIk+aIHgd6Nb50cZhVdgN8yZrHoIRIHKDdFUGBJ6v53s
         tREQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrVWcRgRKcMw6HILgjVPy/Ji6HCFY0UkNC9GBwqpgEbSp0ENwOh5l+vrX54qmwcq25+L2xL7EGmCs=@vger.kernel.org, AJvYcCW/oIcJFgxbvcVn+q9/8FOffUvhcnh7cdRgiDP6+ZSTZcsjrRYiAu2gesezMfRloYUQOEsp2k8BC6IiYqs=@vger.kernel.org, AJvYcCXx0UqWBer/+z5w1HcLvlt55L2F9vI9S9SQrogs4/offoi9w7BtWX+w3I7/N27QqmSkG8XdWyAkFbSTuW9E@vger.kernel.org
X-Gm-Message-State: AOJu0YzzSQrFRc+R0FGS9RRbQqY5p3yU5B/cpOHtNHdVFvaaGFICFs5H
	y3yfCOFbkoemkP05yxhomzadXtYguJ2sHZkd7ghG86oroNy2MXQFyOPh
X-Gm-Gg: ASbGncvPewuN6lmP0o6FjshYyiQqxdMklRFTE14C369mh4yxKhzw/10GCx5tR/TKR5l
	pvaPEHFwNtmAIvk8+0SyykC5ggacTRQ/PsMeQ3gOBPcKxKZoLe6n1ZkGZrxOpW8EUCL6XBduo2e
	SX6t79MI0mp4RMDp4jM0Eeyzp/gbEtju0gs7T1/39nMFYk7G9QcBeAhUneczSVNYd8SaT8kN2B3
	pB0E/kE/KllcBhlZoxligKsStfkHwC96ZguI3r5gsLqIFrFf5xRMCsrdpVkT8yDz455bvtQU7IS
	RuLgG/CiSBa+dbUw9msAdLGhQq/jh33Z9FABLphZQr9dzLu/ISb3iEFjGuLKA6d/4NQpB1vT77H
	7YowzGO5kiDhqy4Vc7XRTwBWGtb/BSclRBfr2YAP0fhL/xg==
X-Google-Smtp-Source: AGHT+IGEqNh9D03iPQ8quMHgQIGgMrUR2i8dWb9uWRCCr4HyrV7qhDcogx0sw9ePeqLApgKSm8l4MA==
X-Received: by 2002:a17:90b:3909:b0:311:e305:4e97 with SMTP id 98e67ed59e1d1-31c9f4a6b52mr5533427a91.19.1752710360663;
        Wed, 16 Jul 2025 16:59:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c9f1e684csm2164598a91.12.2025.07.16.16.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 16:59:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 16 Jul 2025 16:59:19 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sung-Chi Li <lschyi@chromium.org>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@weissschuh.net>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
	Sung-Chi Li <lschyi@google.com>
Subject: Re: [PATCH v5 2/3] hwmon: (cros_ec) add PWM control over fans
Message-ID: <d6286473-31a1-4f16-9c2f-8a39534c22bb@roeck-us.net>
References: <20250620-cros_ec_fan-v5-0-5979ea1abb31@chromium.org>
 <20250620-cros_ec_fan-v5-2-5979ea1abb31@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250620-cros_ec_fan-v5-2-5979ea1abb31@chromium.org>

On Fri, Jun 20, 2025 at 02:49:13PM +0800, Sung-Chi Li wrote:
> From: Sung-Chi Li <lschyi@chromium.org>
> 
> Newer EC firmware supports controlling fans through host commands, so
> adding corresponding implementations for controlling these fans in the
> driver for other kernel services and userspace to control them.
> 
> The driver will first probe the supported host command versions (get and
> set of fan PWM values, get and set of fan control mode) to see if the
> connected EC fulfills the requirements of controlling the fan, then
> exposes corresponding sysfs nodes for userspace to control the fan with
> corresponding read and write implementations.
> As EC will automatically change the fan mode to auto when the device is
> suspended, the power management hooks are added as well to keep the fan
> control mode and fan PWM value consistent during suspend and resume. As
> we need to access the hwmon device in the power management hook, update
> the driver by storing the hwmon device in the driver data as well.
> 
> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> Acked-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Please run checkpatch --strict on your patches and fix what it reports.

Guenter

