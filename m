Return-Path: <linux-kernel+bounces-849636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36218BD08E7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 19:50:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F0784E7DD2
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 17:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1322ED860;
	Sun, 12 Oct 2025 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZfUimi7H"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4663722097
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760291414; cv=none; b=NFKqXPHVQj3xAQ8OjmsGf+B7rFt5+GIhzS7r6UjvgXQcELoN1jTIDFHbipV99osBFs+lcQx+O3tGdK/1K76IyxMsb7DmWmP/a16qAaQrkiXoCdZIJhi8oSv5A2/99Q0OP2XARn3AfyUXt3R709SZUzXa+wBgheGigjoBxnLAtow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760291414; c=relaxed/simple;
	bh=0XtKuLa8UiwNtFQOHtGYSF9Ae5RbWbAtQVc8rTPpTUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rEaPRSNfHkNHgXaI722edBlS9aS7JKtVaJAZnGSx+YAiuDLdvc0UiGNAze+veBqJxgvnhRRntkY476akSn7xLh/U0TX9zLw8e54p4NPJXGu+sQlNd3X3dfYxr5AHcCLleNuwdEY8EEte6e3M18GymQUCN/d4Wz3w+nivOO0vyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZfUimi7H; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-33255011eafso3659779a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 10:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760291411; x=1760896211; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KG7cZkr2V/oLoitCh7Ph/07kt3ygxpCQRJaIzYce2jQ=;
        b=ZfUimi7Hpkun05Xe/cPHRo5tfzkZtNzLlFfCUj1gbO6OQRuCrlmqakPJ6ZfEI9aB/X
         E/tDQCRiyYyLgtY6SBDyTjTa9XY0h/jWTbb8NG5v/27gIBXCniKp3zhpPko6Dma+Nfsh
         ts044QQnOEIxhfj865cGBLxnxDmfFYl7GCr73fas6YYhp+7lKzqQVXOjXl5deuhad7kD
         Vw1832uipXDofqs/97kbGLcHvDvNSRHNEXI0MFdoRR0UK6YKyNDpfJ0Epm4+dsWmGZRe
         ypm+u24hapuyY8stJu3+aec50PJOAtY0AvPp5U+olSq4TevAmQWnC60R4dZtcbA1Jfp+
         e13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760291411; x=1760896211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KG7cZkr2V/oLoitCh7Ph/07kt3ygxpCQRJaIzYce2jQ=;
        b=RC2fhkxzjPbBqVWtKt25a2uzyxvBvmyQ/NJQqtfl+LS3PxEhnqzpWYUoL2wqu/UXbj
         AdzvVkMBcZ1satN17afcalGjFqsH1VcGPIISLkAWnRZX6oJKHQ09DSevufAKqK46BFGK
         8sY9y5MwLzBPRvjdoOsOFXSVTmOiOo1/jtPTWksSsuPnjOvvHO8HQY2TAG38JJ37ah70
         IYO21IjNQNZTUC9MHK6qXijG2kEKlCqH0vTvDSvL3ZBqz78DzKD9ZQLgufz30WMEq0gv
         7BOw4M18Q0v+ZkMHteiyBJKGrOROmshcDA8Es0Hec0oE5hlmkeYKfL0Frl9TYTJ5XgFk
         SKvg==
X-Forwarded-Encrypted: i=1; AJvYcCU7wP78R6/Dcxiz/97vy5c73pt3TFhN9AJHCWx+XpUfyDJ7W2YmpchczWrj+AS72xMeZy6ztLq0hl2QICE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAPoBBQM1alX2i9YA8yTkdkCVoQdRwLLxBvNV3p0vNO83sJURW
	a6Q90LTbzVAou+1I8hw/PeRa4bUGG0TbV0Ti+LjHTa9O8H0Pq2eEMWr2
X-Gm-Gg: ASbGncusMlGvweuEsyZWhCxAB16J8dv7xmYQjyb34azA42sUDtNObrdbY9CpgdFdiFU
	ryBzZcXzvkuKsU+arqtxRwbcSmHf0nWSO0RSLcxOYCXDj3hXFZHzGZTYtjPGeWjaUYq2udj3/gs
	DjZGsO1gCHaLE0hXJGSCKGs8fg10yu2OK4eEYtDg3A+EZxiRwEm7ulxMsqKoYhxjLAcOc8xEUPL
	D8nd3BTBx2G/kMbjdZ7zE/FNCgGOaou+Tz3liHNyw2PnN1nkMBH9UbbFPZJ8V7RoQaBCOlwSLi9
	Szr1BdHl1vxpOncpzOy0cqY9gRcpx1aCoqsX9xftUZCqFD1g7cOXgULfnrlprDEUhxb/JrVD9FK
	9oX75dlkC2zemZtPSPiXUXrEGk5yavT0Nsox62vuHkGUcecnsJq7BRqIXpjYTK3HX
X-Google-Smtp-Source: AGHT+IFPUnweijrn2pOw98DIoWtnaMWpi9PLMftd6tmmurmdLN2gURd0KnujjCj0/eqqy8Ofu8hbtQ==
X-Received: by 2002:a17:90b:1d89:b0:330:797a:f504 with SMTP id 98e67ed59e1d1-33b5114d664mr25165948a91.3.1760291411356;
        Sun, 12 Oct 2025 10:50:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626d15e2sm9407269a91.21.2025.10.12.10.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 10:50:10 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sun, 12 Oct 2025 10:50:08 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Cryolitia PukNgae <cryolitia@uniontech.com>,
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH] hwmon: gpd-fan: Fix return value when
 platform_get_resource() fails
Message-ID: <917278e0-cb6b-481b-8d1f-04b693668273@roeck-us.net>
References: <20251010204359.94300-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010204359.94300-1-harshit.m.mogalapalli@oracle.com>

On Fri, Oct 10, 2025 at 01:43:59PM -0700, Harshit Mogalapalli wrote:
> When platform_get_resource() fails it returns NULL and not an error
> pointer, accordingly change the error handling.
> 
> Fixes: 0ab88e239439 ("hwmon: add GPD devices sensor driver")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Applied.

Guenter

