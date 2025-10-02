Return-Path: <linux-kernel+bounces-840814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 47519BB57A8
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 23:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 237E64E743C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 21:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D5E1B4153;
	Thu,  2 Oct 2025 21:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lfcQQzeR"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE66B29A1
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 21:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759440857; cv=none; b=Lhi6GT1fHWVKvEh/MXrxUMVMn2afvc9cxDYUrnQHqH7/wtIsHIkT2eFU8yhhoTQWEpsUYVKVIwZCMkDUSlLGSgqQDsA8RSvhpP0J9bvI0zCHrYDgmUQmmS1NSkeJ0znZ4mt2k76M+60OwZcj0zu4hHLS0jeiWLEdSP2aApKM9xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759440857; c=relaxed/simple;
	bh=7iSxhUwFdayMNkBWqhX/46UeqkWg3MxAUcCsOEZ/TwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1eUGDg0rgRkNi+vHL665rfaogC50qpEL/r/J0gLp3dAq+9TNuHHjMo6ieI3zsFFmozVZxkCpWNlsF9iXUMsRSTrapxgpc2ero0JLcBXJGE+RltIPqtL7U0XPXFCffzqpctJ4XKCmS0We3JW1955uJtaT1f6xS6vaQXZZjuLGHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lfcQQzeR; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-781206cce18so1367509b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 14:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759440855; x=1760045655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z1PrJRpi1vH5GxKwZlWbhM3YXHmClyIGjsFkroyXTL4=;
        b=lfcQQzeRu9CjFTaBbxpvB2eeRykW50cBni0HeRqgq+J8HSKgDX03wzcv4IsarnycsE
         whmNkCvsEVA317ilzRdgwvOXrq0YhLzxV0joclNiQY707arzlnA11ilIJZKt9/4p3v/K
         VrHLWT26LpVTKC9j132SSYYacvpQqNN7Cukx7M3dG/LchHdcEJo/OtZneRbQJPDBS3E1
         2KCOJnU3Jg1HkwpWb835Ort4Qx9v/jFSmMwylEBEeIW9TnX7Yb4Kz7PY6pLGho6mnP1m
         YXdisIX7KARxsVHSUnSSLRlfvOCqGRgPK2VKJOS0cIyMOUVPEtzA1NrDJVSgT7DJYWTL
         OHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759440855; x=1760045655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z1PrJRpi1vH5GxKwZlWbhM3YXHmClyIGjsFkroyXTL4=;
        b=TrS384XLuA7m2FDhAhbpB2g12RIUdkRkLry7jLnoUULwIY8fvVNla5hEqthLH4mATQ
         VIr1lbmW3hf1qiJfe5qFEO23qPA23gfF1ooeX/T7YIRBOsONoJg5jVi0/eId4s7URrYD
         UMg1D2Ah6fsNpVWvOImswBXvxkQH6KQ+47VZsHNNudNBQf8wP56da5svSD0DQ4uZeyDr
         zGy5UVYGkGFwYK+52zp1k9YrtASf11LpSQoTd2Qc0N0XBFtuY9l4ZmXSfrX1KjXZw6Es
         UORzaShoMPlq6+FCgbdlRZHf8ip089+cNWqofG7xqtIzIAlXYgigQSiIu+nhT/dwtMrc
         0DIw==
X-Forwarded-Encrypted: i=1; AJvYcCVnSP7MEyZdthLSZg+2bkVdjcGNF47+Yj9J3merciR3IJ6OYtgdNxY9DgN1iWila9y1Yk2FzNZkx0yPVLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnLTbIZctGBhshyAs/W56QHn/kEhdtbzvzsPmp3hfp1D+Zp02e
	LxflU4+oDkvMyheZcRYqpM7O9HShl39sumRbsK+waqXlsikzRiFPjy5+
X-Gm-Gg: ASbGnct7aZ33Fb3XUWb+ybs6GYLyD+Q98EKKHAPna49sG8AT3C7UyheDjJd4qDs6AqE
	W8DVsqvzBtY35FFnl/48M9P8xa628MdnvLyc1QrYlvBKWbZE7x8axRS123cZVt8yPD8wFjttXiN
	t5S4AzotfVArrYuf/UHyD82Qj5SdGvRRMF455d2iBVKpYYHeI+luFdTv0Hdb67af7x63jI2zZtg
	Wyu1IU2AfgSkUotMaRUoAXvHAG6CfldxPyA02elbngtWhAXUAnb9d5D2z+hoFo9qvYOEkv/vD0j
	XUj1AkiTyIJlzl5svq47AsNyrbX3Ea4VSxjDCvqdFoUEGOZJVcLfqv3ff2nJatQp9jhhOVEoKJ1
	a155lKi07KMzT5oeBvvtM1VSNv29BTA/mV7hk6aSsHekKTIURf2z5YIoDCW0=
X-Google-Smtp-Source: AGHT+IEeOUf9stYiH4A1VxaI8NkZFOnx8BChpkifOeNgOd1G+kYcSz65i3l+MHbiV/bwjRo4Ir5TvA==
X-Received: by 2002:a05:6a20:72a6:b0:327:957:f915 with SMTP id adf61e73a8af0-32b61d9daa6mr932098637.24.1759440854923;
        Thu, 02 Oct 2025 14:34:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01f9daffsm2947915b3a.17.2025.10.02.14.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 14:34:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 2 Oct 2025 14:34:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: ntc-thermistor: Add Murata
 ncp18wm474 NTC
Message-ID: <f33219df-2b2c-4edb-bcb6-bad189c25348@roeck-us.net>
References: <20251001-ntc-thermistor-ncp18wm474-v1-0-2c64b9b509ff@pengutronix.de>
 <20251001-ntc-thermistor-ncp18wm474-v1-2-2c64b9b509ff@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251001-ntc-thermistor-ncp18wm474-v1-2-2c64b9b509ff@pengutronix.de>

On Wed, Oct 01, 2025 at 01:45:28PM +0200, Sascha Hauer wrote:
> Add Murata ncp18wm474 [1] NTC to the ntc-thermistor binding.
> 
> [1] https://www.murata.com/en-eu/api/pdfdownloadapi?cate=&partno=NCP18WM474E03RB
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied to hwmon-next.

Thanks,
Guenter

