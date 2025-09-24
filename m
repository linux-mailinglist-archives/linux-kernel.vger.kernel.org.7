Return-Path: <linux-kernel+bounces-830716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0920B9A5DD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28391B272DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 14:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DE7311C17;
	Wed, 24 Sep 2025 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBSRMagp"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A883101DF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758725424; cv=none; b=QJkHSBmHZx10OtMNvN/sNmu2OZRkd518Lxfmwf6HwzNGTOXgwSiWXART7IqqTH/52oa77Rmw5TZHkK4P+PeuI/V/4seBLteQvaq1zi0cX3DAjyGnuPbj61mcQ6tsXGZMssH0Gs8EGAxfYRiGUGihGB3iw15mNmztxlqYcSKN8f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758725424; c=relaxed/simple;
	bh=BviqeMCj6xbZG75A9MR/UccuPgQG4y3Yp4Fdc2CDqkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuRFh0QSIIjSz1YcVlKXOarCm13HPFYDmcZR07yW/+KZrERtZ1TLai+j19EtnF41kufTseDmunBOnRsLlzui/C80Pb2Wz5S97mtboYzEjxD5fQym3u4jpzQoH9OSFcQWgV7TLpTPsUsxzjLU4A0k1QJRfGewrts20VeEZFFo7EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBSRMagp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26983b5411aso49513015ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 07:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758725422; x=1759330222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zs6XTUkXRg23M8XSxTfnEtSzvo14dogaq4qf3KBzUtI=;
        b=iBSRMagpnwwVM/fp51aan1J1lxdIc8wj+QbY3EHsTE9RZse72h1yjlsgHrSJAyfiD3
         09A/HNdWCdEZPnwd+ost06FXF0/574d4EzZzW+0O9tTGq/OUTesvckc4E8OlQvTdJX38
         dcn5FXxaf0thht5nWrBiMzY+uE97QmsSyOHWMP1QvJy1IoTmKZNXaSIEqEzy86cAA/QN
         3LhlOeGCJOAEQokL/9EuK1h7OhTd220WwQYCPPeybxtMDFPm7h5YZ5WTWMVdOQECdwMn
         eBTvQW2jZVXn4/DsRqO1SMfXLVjEZ1jL6cxSNvxujCc2T48YOkTVHloXAvgnp7Wp1o+/
         hFJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758725422; x=1759330222;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zs6XTUkXRg23M8XSxTfnEtSzvo14dogaq4qf3KBzUtI=;
        b=cQtMEop8c7vTGuuY/cJWOqW+YILBWItDeYc+jRISfNTz1S10XUYfT11Ihb7HIOAMXx
         HUqkyuwgRab/qpmD32FkJRIZ63PHg/D3WUqTSgWyT+g4MItI6viWZgTAsnK0+PC1/jke
         Eudm9iKYs+igwLh9mlTM415N9yb6MiMFJYvErBQKKXKoAzOR9ZBjIp7h8KvAZIy6etuv
         4uGdqpcXqQzgYB1ZzdbOrN6HRcAhsAQpwVWZeNhdq8/bmQbkWoWdjPreQRizHMocTxVx
         QERWh5NL5MZ1SCg86dv4q6NWs7F7PpGNutrGRTTrD9eE2y77A8cw8p9JOZ+9VqZ8fSAf
         vZ+A==
X-Forwarded-Encrypted: i=1; AJvYcCXtCVUioVHgXXUBQZLTvB+4YdLuwzzHBAFcRtsPUrQI/4j2Go9Z7X5Ln1bKmJT5nN9d7DpaEUTRqf4j01o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSPWYCSbFmyzR82BuVSgHDaba+6fxIbzp+0RrAPibwEy93l/Dr
	caCYRivPcCoG6Nz2ARnW7O3HzlSgDq2LQLJIUhYPzhpG5Ell2RDGLriu
X-Gm-Gg: ASbGncsOLbqW2V46Eqq2LcokJu/w5fBlK0qVg1yMSivWnWMrrkazXRdWnpLB4KDt2tk
	hCpbhMR4eu0ITAhR4YvWghXv6cpySrKCCwtSQTLe/9vaf5IjmOdEkXBNAgnkG1PUQyhOsnFeCHc
	3dyKetAKpHLD3YKSIqHMd2KqpvVX0+kQ3EReb8NIZbK1QyTNdJ8JVVVOfc3lamD7gBs1PfUMvzr
	TM1xjYH/9luCpzD0OlSWf1n9DurH/rGcmQR6DN+QOUbdsEYV/apGD9Endbth/tHKQJcwOul8w1k
	xD5Chv/12GuarqBfzF6G3B+ebd1FJ71VrCMlYn8PFfuUcjeUg7Y2SAzRk7gHTDB0tHEOSxgr9OZ
	G5HxMMNytXF+e5bVdu+dnOgKQh4AnEKttM9M=
X-Google-Smtp-Source: AGHT+IFEVnMa+0Q7jFaXrSZSYdDF4WKGGwUE7RTEdlQrcVFTWGs7m29QTuWyQ8Z3+X+c9JfrngtzKQ==
X-Received: by 2002:a17:903:8c6:b0:25c:ae94:f49e with SMTP id d9443c01a7336-27cc5bf416cmr79852045ad.37.1758725422109;
        Wed, 24 Sep 2025 07:50:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26b59d6538bsm158340465ad.82.2025.09.24.07.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 07:50:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 07:50:21 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: pali@kernel.org, linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] hwmon: (dell-smm) Add support for automatic fan mode
Message-ID: <fe494bc6-1e4e-4a81-8a6a-c6fb95160a65@roeck-us.net>
References: <20250917181036.10972-1-W_Armin@gmx.de>
 <20250917181036.10972-4-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917181036.10972-4-W_Armin@gmx.de>

On Wed, Sep 17, 2025 at 08:10:35PM +0200, Armin Wolf wrote:
> Many machines treat fan state 3 as some sort of automatic mode,
> which is superior to the separate SMM calls for switching to
> automatic fan mode for two reasons:
> 
> - the fan control mode can be controlled for each fan separately
> - the current fan control mode can be retrieved from the BIOS
> 
> On some machines however, this special fan state does not exist.
> Fan state 3 acts like a regular fan state on such machines or
> does not exist at all. Such machines usually use separate SMM calls
> for enabling/disabling automatic fan control.
> 
> Add support for it. If the machine supports separate SMM calls
> for changing the fan control mode, then the other interface is
> ignored.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Applied.

Guenter

