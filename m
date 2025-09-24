Return-Path: <linux-kernel+bounces-831156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6905B9BB71
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9E816B2CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 19:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F44264A76;
	Wed, 24 Sep 2025 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2PxfX+n"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8458A2571CD
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 19:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758742293; cv=none; b=pv7QueXsTSFWPWm42ORJeIK2CDC0RYEtbpBPH8KPce4jpyjGN8nZN30XUYQPAcBgL8z1/L2LipEQgss2pB5ZQQG32E/Jsuk0Bsm+ccGcR++52zO6w1wqg3JYuePhHXj+Ifv65Xu2gi5ZzEmAsQqi48UApTG4cK3gBXUjAFDc0E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758742293; c=relaxed/simple;
	bh=USTPbmjc7larzUfmJLTr1dEREs8PNqu/Af6hD/JnsLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EipOiKv6n3IDRRz/aU9h76irvD1A7iW0i48A9RscSNKKe9uJL/Y5Ooky994O4tuqBuY19mGOJ5yI/9b0Lj1/+arjaO8e3gZv8XE2wFgR2ALDeMr8Ll9fDZWo41uTgEC0zQ8FRsTx2oQiIh3wDTOI6ZUcnux+r+L0uPpLq+IEHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2PxfX+n; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-330b4739538so184259a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 12:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758742291; x=1759347091; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YA3h5oB7JadoxHehwa5NeGVTyzJoF+sGhLuexgW7Bm4=;
        b=A2PxfX+nk0WkmX1JYbDnYTaWpZAm0+isLhmyD2bi9ChvnRuAfG06O7uI9ewKwmJbup
         CGwlOuKFnX2dMYU/TAj67X1tLzIZ6GXwDVEXwzBO2lYRV6hWtCnz1piOKoUzRSGgmZ9T
         m45TQE4R9OtXvy2X04po5uwRnaNKFLiIutFI6Z/cIpz8Te5AQL5q0jsgtKxCQuAlaEgd
         v5lqkGeFFZmhX+gOEM+cjTfgXq61BwFg/+vXTOqn5NIWF1k+k766b7A+0/RmirV9PJbC
         m4ClbXjvjtV77RJbYkisp0Pxyu2YDktj1ahgzcRIm1hXroUg7FP9s071xJgtAVtss/lB
         x1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758742291; x=1759347091;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YA3h5oB7JadoxHehwa5NeGVTyzJoF+sGhLuexgW7Bm4=;
        b=qTJWOybmpUBaly+s9AznTkGiythcD9tI4ZHn7hZ3YHKyRX4UvITFCr6m4KFbfDh+du
         OdNi1kWPeOUJCfjxE6T2Cxs/oofRz855a4V8dgZMPYSv9XlsjJ8uFOEZ2I03ZIbfXQoV
         +Tr/ZC9ikxOg2MRSTyGms5ZbhRQlhcJ6IBAqz1j/RR6QAqpM1oAl+EBlEVKESsoJWQp8
         eag23mwUxSwVMZ4Zao5XphKomGHOijnfyROnK5XUTin4Xtzt/Lw4r10pl9CWHVEggoIe
         zzoy+Evi99GS74Tp9/rZ8dmRlO3UrmWdksVwfo1VV5i9Z0Ar62IsDHZiGATc7P6T+JdH
         qO0g==
X-Forwarded-Encrypted: i=1; AJvYcCVjL9Ul2RJWQxFNDj8ZYmCpJK5ZZAAwKBAIlhymFC0ETTncWFecLPNb7BpePAm7EY1gBP/tAxGxQxpshVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQxr7xRj47O1DL3PUVsi+Tcm8H1wg1icrMmbNpRBx67IPKCUf
	jeuH6fj035AVd32z6kZBD46Yj6xCaQfezg/gU4fpHv1VUbRngZ4bbUtv
X-Gm-Gg: ASbGncsHS8Q6IoPmfOeP4FKaE+b+ZEHapGHKcXeP+LGac7Jq9CgN0yKgLo04gZ92BZM
	4Q5BiBg8sAoA/UtQXWituFJbwUqV7Gv9P+bhyTG4Je5eSCokoklA2FqZTctcB1TS0JBYehitl60
	BqA0VTgPmXQrPfpdipPK2OYRFs9uQoASfXiawqYVsbFSZ3OfpGk67mQQ+UwBSS+jL0UOWiOOu22
	98T6ylOOV7OAt1psmrvgxXLjpjnQZLRwqMq1gyarXC7fQFVLX3HrdxSz1l/X+aCTXa5us57P19R
	uv/ttCdVOxglcIWevD/AJ3UYvUXkjm4kNffy+8K/QQASSuTUOqFB3cdQFw3nBHYtSN6ky5R4ETT
	2c2jnIPxZrRkfYF3ogJmoCA1lE+cBTTTkzTI=
X-Google-Smtp-Source: AGHT+IGf79Ctst2lzMknAqjXUhWGTlNDl/Rp/nJBOnuaOSO/Vxp7PZh8N9WTKkOOb7wF5fRUDXamvA==
X-Received: by 2002:a17:90b:4acc:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-3342a22bf2emr746435a91.7.1758742290588;
        Wed, 24 Sep 2025 12:31:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bdd63c1sm3208982a91.26.2025.09.24.12.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 12:31:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Wed, 24 Sep 2025 12:31:29 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Sung-Chi Li <lschyi@google.com>
Cc: Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Jonathan Corbet <corbet@lwn.net>, chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, Sung-Chi Li <lschyi@chromium.org>
Subject: Re: [PATCH v6 3/3] hwmon: (cros_ec) register fans into thermal
 framework cooling devices
Message-ID: <c2dc1970-386f-4e4f-b1cd-ca849d002aa6@roeck-us.net>
References: <20250911-cros_ec_fan-v6-0-a1446cc098af@google.com>
 <20250911-cros_ec_fan-v6-3-a1446cc098af@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250911-cros_ec_fan-v6-3-a1446cc098af@google.com>

On Thu, Sep 11, 2025 at 06:56:36AM +0000, Sung-Chi Li wrote:
> From: Sung-Chi Li <lschyi@chromium.org>
> 
> Register fans connected under EC as thermal cooling devices as well, so
> these fans can then work with the thermal framework.
> 
> During the driver probing phase, we will also try to register each fan
> as a thermal cooling device based on previous probe result (whether the
> there are fans connected on that channel, and whether EC supports fan
> control). The basic get max state, get current state, and set current
> state methods are then implemented as well.
> 
> Signed-off-by: Sung-Chi Li <lschyi@chromium.org>
> Acked-by: Thomas Weiﬂschuh <linux@weissschuh.net>

Applied.

Guenter

