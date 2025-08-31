Return-Path: <linux-kernel+bounces-793589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD9EB3D5A5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 00:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90E9D3B242E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Aug 2025 22:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A94E4258ED6;
	Sun, 31 Aug 2025 22:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQUzDdBF"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD30C233D7B;
	Sun, 31 Aug 2025 22:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756679717; cv=none; b=dHvJY6PSDdlVeWOqI+u19lZV1l1C9+jUFXiy9h5/AbUhhYmNH4It/nTC5eE0kqBnngvJenKxaXiNKKDU2NX7x0ZHmCPAY/GPQbxJMQHHM4F/6EOfO10jW+jm9Dw0njK2difRMiBLoahV1Fwxp3GUdqzDiPzG3cOPxMTO5YT+SUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756679717; c=relaxed/simple;
	bh=iKTTgo5wvHOl2l2r0yLo4Z1R1mzYOho2++dbPYKcOHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmw3t6vHTiAblv2r0qwrPNp6wxINyVkU79GGaK2a2R7epd33UNRFF4xa8GNJrpJNAKQJXyMC7w7vNNfrtwaHe94x4ZqZYl6fR73w6+uhbsVyQvhG32wnGtH6hsbobeDCyx9VRVRYQoe/zgGNh44aE3P3onx2FwEfLWiRcPz9Tuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQUzDdBF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-248ff5cabe0so17487895ad.0;
        Sun, 31 Aug 2025 15:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756679713; x=1757284513; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2JycsttBvJQ5yrE5zY4AC1tJ2ZuUT34RLYgvGl9w5M=;
        b=nQUzDdBFU6YNuUS1Fs1W9gOxCBpFdEmJdsPBU43NFIn+SDCdygoQaZBNcwUDLGE7TZ
         XCVCk6hkdI6IrOZmEthIaW+kMdPWExiAoQGYrptXX4v0/SIqe59ml2PjW1YRLgZbJzPS
         hjcOIyOQyAxP4l75oAL47DcKWa6cc1h77SAU+f8h5I5wTf/FL59H7SQUfUZgIkQilwJm
         VT47K8Ifh9edkR4PTIiwGUP5F9G+7i6CkXCd68ASHyIkrwVG429IBGXW+IKI93wiU3m7
         d7+ibBMQqtlbIToAIjlvyu+SiXOiIacnx9WPHLwpOjrITyJ/E2CguX+s0OUA04pjcF9w
         EsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756679713; x=1757284513;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2JycsttBvJQ5yrE5zY4AC1tJ2ZuUT34RLYgvGl9w5M=;
        b=IyuT2SiYcjApD2FBLij0hGzKoVz63TJDkM/AfZuBaujaxZi0rp2jary9Yj0BnizNtK
         cgnJ1eWVHjj+2rIcZCH0Z3RISA5NuLs3yzG37FxJSpWZzzyhEewcoUCONnx0m4Cp6450
         1TO3P799OBbaaGKn/InjRbchDCCAhrOljucrsxtWerPsGwEigDewlOLrQd8vCTsjxTbn
         ZUL0OdEWz+GxFzcpK9iP40bdLTnxk/1WjjxMsr+3zx24x9lmL2i8mQhxz3lPmL4Dqbwu
         C/VFdMwzbYP7rLrlsDQIIWFgrTOFeUiYweypsBJ7qyJY3hbi4R08soNyPXRmBLWgsqv9
         VPGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4EZbBBHmTACjhhs13xgQGU7gsedNb0ArbmM0s5/4+zS3L5+RBmIcisHQToRTWVS7eJJOJeB/WYVDB3cHR@vger.kernel.org, AJvYcCUAlPDmEDGy/OMGoi5b6vgMNyrfSeic3bucBPxATqbRJhslqnN4R07yHc1ZTvNkE8/6K03S9hngr5vt5z0=@vger.kernel.org, AJvYcCUWWyAEpuRZBcG3gCpsn7C2boTTZIuwFgOnSs7zUu/31UYwmQhiHwEMRpes10kMp8R58LiFUdJU6wRc@vger.kernel.org, AJvYcCVp2uSeWXBddcQn0e0JROiLv8fnQrx3N2crzit4FR7wi7/FichKY21Q0DXWUb87jsTKS9ZZsC3iCtOk@vger.kernel.org
X-Gm-Message-State: AOJu0YzLvgUawaQEr2LBfpbXwVpqrLm/qTX4OKdPRDpMP6YCOdAw7YMu
	ac3jmePVR9QCfLVYLqL6kLQhkCVzEhbc8BK+/6bnLWey2dTMHKjQUUop
X-Gm-Gg: ASbGncsqu9YJRZD/URGySjAq7gIT/I4kAG/pf8p5KNeVC68HefNRe+fjaTNXuYnlyvh
	Uq4HBqvyYSo1FOtX9/73rf7LqS83Bdq6a7oSHojw2lHKImGaAz3D032iYdvVXj9M6wxJoBNH5x0
	gudCu/ZwqecCPtXxiExKX5qutcbmIh8pxvyqARG9snHg+ksk4yk7LbxoZLxI8+0L7uHCxOL6Db+
	YDj3zyE6YBPj65+bnszc6TPC9I1T/Z/jnr9Hq8sSKIK0yO9urm1NDvyEFPy+sLN8eVmmmiN0nMb
	EUYUvPHCVnDPPHiyOL0EMQ44oOjiXSQqrys15SgK/tsOcGpEIwx5qbquXX4nUniK3ekKuldDY9R
	I2HtWIZLCqESgGhrdGBBaz+B9oX19uEasU+s=
X-Google-Smtp-Source: AGHT+IEp+KlFvii0FmV8Lx8IQo/Wbh/Qn73lPRXznztDuhoUDlsm3j54cmdLPjYsvKFP38AODo56tA==
X-Received: by 2002:a17:902:f652:b0:234:a734:4ab1 with SMTP id d9443c01a7336-2494488a6d2mr91537625ad.3.1756679712840;
        Sun, 31 Aug 2025 15:35:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24905da2f20sm85771985ad.82.2025.08.31.15.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Aug 2025 15:35:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 31 Aug 2025 15:35:11 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: jdelvare@suse.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, corbet@lwn.net, wenliang202407@163.com,
	jre@pengutronix.de, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/4] dt-bindings: hwmon: ti,ina2xx: Add INA780 device
Message-ID: <a526023e-a16d-4763-a189-c52740461429@roeck-us.net>
References: <20250829030512.1179998-1-chris.packham@alliedtelesis.co.nz>
 <20250829030512.1179998-2-chris.packham@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829030512.1179998-2-chris.packham@alliedtelesis.co.nz>

On Fri, Aug 29, 2025 at 03:05:09PM +1200, Chris Packham wrote:
> Add a compatible string for the INA780 device.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Guenter

