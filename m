Return-Path: <linux-kernel+bounces-852955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584FDBDA48A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A62FD19A5B59
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C9F7255F22;
	Tue, 14 Oct 2025 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcS0sOjc"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C532FF66D
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760454904; cv=none; b=WFEBbTXpOX9G3TO9jgR5tBhveNFLVByS2kWsGYgwbw8xaD6MvexPCGDo21CDNZgB0AhVxc6OHvkUfsQhmdWibdG6t91wjM/dHMYNXH3Kpv9tQEbIL9VhFk7NILhrUUMcPuDoMeB0o4KKsx1FTHgA7gQXnpZ85IwEKN0OS8YXXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760454904; c=relaxed/simple;
	bh=2EO7+Mw86jTZ32ILWnabkRyWDVKXtGXa/OUDfDpKJjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5FkbHt0CUelA/kvIJTGg3taeOVKi2slRQcBqwtGqnQ+YuIexs8EI4m9s4YG3lTL1K+3bF/rg2HBBO52RTWBNDrIODOLSXa64y8lqtwciuPNsy1wF4AjZOBoHNdCRbFxev0/dTNpKZwrliOcJH+sZh0KQEsXA5C3gwgLlo6oyIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcS0sOjc; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-78af9ebe337so4353899b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760454903; x=1761059703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tsJaopK5XFjKmHQfNpGpFGBdSNc9d5lFVOS9F95Qcqo=;
        b=lcS0sOjcFwUPvH5ObTKys9yu8YkYKFDxDG6ghazz69iYBpx9NpTdDvibQ8y4LwWpID
         ACysjduopTaku7ke3zF+Kof/SpDoFrCrvyJay2omlvoOB3QLyj0Rr7jpLo9+i3Rj5Xv4
         eGVzF6ilUyXZhn6tnsq+TUuUzfokbdKFjsdU7Yz9AJyHEZayUdEEIB1/sx0rXb6l+Wmf
         t30wF3+RexFgzfn13h5yUYAhXjl9QI4sDF6t/TqmLo+IOJ4FJR84dCxQoShl9TO/C7Lr
         mgvCtrxbFhKhACJ9cLu1UlzmLqzpYTyLwUu2YtzwQ4/LdtTweJ77FHWsxMk2MY0ORoh7
         AKeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760454903; x=1761059703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsJaopK5XFjKmHQfNpGpFGBdSNc9d5lFVOS9F95Qcqo=;
        b=jc4QvVvHq+RbM8QCQgFPyWVG1+DlYHy60VZqeHIGeg2FzSZ6bJlCQwoiQyqpV0b7DQ
         MdcXwF/gXkFfdf4AOJihEfxxAUpBy6jD8i07E/wxT3RgKSI/mk4DzI7NMhgvFIL5UcNP
         5t69Mj32stT6PSopCl4o/vzoU/J6FeMhZMKhW6yqyTp+PFNA9sBGyoOpcyU9NaPt3i05
         2lcL5c/46NiTlKldYBpP50b5tqScPR9pKNWM4UjxIzbcyWQCSyOSw2DvPQ7LO3gA51Rt
         YuYZ7eZQlfHdEVLeG/T647Z0pYXnoUl0VU+GaiHrGOdxGQuleCyzw+SYMovZFVEXiGhU
         a5Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXB5U+HydSkqhF9xZpmn6+rT4gj/LYp3vq59+yPBRIE24POlCV8s4GTbiP9I478KoUG9DjfKhL1lTotGqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvuL3u0BvhIVh7IhzvDgDkOf2p7p74Ll5LHm8/cRHxAHz9QSWA
	KieSys4bgj56HILDcvefhug7xKaMsLFQEhExmXFXhAlKPx2dD18ct4oi
X-Gm-Gg: ASbGncsiu/ttIqbc1+D4sURGC+f5W00+Za8ACFeqtZHbvZ6kpmA4U4Dy/V06o+slkSO
	ij7CCDJqFQ4zbzJHs6YhBX6vLQPzWsHHtV1C4xysULmMHjYAXwN03QLfAO4yb5qVhaiptFQs+FM
	FWrPN5bmJTbi6YISGSbfcrp4EimDHcMc8XTl8ZbITpJcy//aT2WMewBIwN/RCIk/sPg0p79MCpH
	B3H7tPypBUNB9EvcQwfrGeFaN9I4mSTTy+HLbh9rqw3RLAK+ybGZdCGkb5CCvq0jSy3vE4GJ9Q3
	/yVKi7RWVM8txh8gPLrLHdlBFT5D3d5MFenwQ2RL70nIDGNFVW6JL4G2FJmqnZM1YBgrz24F1jI
	3VS5K3UM69zMgpWp9d7AiBrlo862xx+zZvKFu4WIX74lYKlOi9v2hI8dijgyN1PCy
X-Google-Smtp-Source: AGHT+IGWguCBLqbqbMAjLBee+il9521eo9UWOowPf5VuIX+2bcsg+HZx1vn/fioij512M/cXcjIt3Q==
X-Received: by 2002:a05:6a00:98a:b0:77f:45fc:9619 with SMTP id d2e1a72fcca58-79385703e36mr28873914b3a.2.1760454902520;
        Tue, 14 Oct 2025 08:15:02 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b0604cfsm15625842b3a.9.2025.10.14.08.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:15:01 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 14 Oct 2025 08:15:00 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Marcelo Schmitt <marcelo.schmitt@analog.com>
Subject: Re: [PATCH] dt-bindings: hwmon: pmbus/max17616: Add SMBALERT
 interrupt property
Message-ID: <bed87459-d395-4517-9ea7-ef155c9af126@roeck-us.net>
References: <20251013-upstream-max17616-v1-1-0e15002479c3@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-upstream-max17616-v1-1-0e15002479c3@analog.com>

On Mon, Oct 13, 2025 at 01:00:47PM +0800, Kim Seer Paller wrote:
> Add interrupt property to document the SMBALERT pin functionality for
> fault condition signal.
> 
> Suggested-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

Thanks,
Guenter

