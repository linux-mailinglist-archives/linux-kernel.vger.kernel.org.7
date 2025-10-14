Return-Path: <linux-kernel+bounces-852959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4792DBDA4C8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FBC8188FBBA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02D52FB962;
	Tue, 14 Oct 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PF4M0m0o"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0EE2C1786
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760455005; cv=none; b=khxkJF4zu8zDsUZsjR8TpOHZkfQ4rNjY1qKVLNz4FYyOf+2hTcP/WORFWjcwWlrra2VXBfeRggSb1qhs6Y8V7wvNz0fqVJJqts/4gQ440flba71zu9g2lzky/TaqIlEUUvHCWFSSae56uGeC73tcfK2h1PwZ30fuav5GXwCpgeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760455005; c=relaxed/simple;
	bh=jTNDcxqogKVaZtvPP9YOb8ee/Iyh6X79+4lxjhYUQz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJWDJhjoUOLO0Rvc7kwcRMaBUBrOeyCpHiRPvPUWrCqLtVLXrka30rVFjIAtpayoRqHfqEQeE49pNiqXdN9VbQJrOuwNfdxY8pwGKz5hs5L1kB2ki2UarOAlTuhW14hhFg7B49xa4L1ddCkCdBbnPZGNVTOSFbGYekaVx+4vVAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PF4M0m0o; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-781ea2cee3fso5247862b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760455003; x=1761059803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Aftt5GDndW+QmwWYyCYRVm3iyK5ExICkKwljxAsMHQ=;
        b=PF4M0m0oKH0NTF++WbMmCI08mVlAkrwy17vAlBqnhVZaukdF0Bg34TCX5/QTZnq29d
         3P1WH50SdOV5c7Z7oyS1yiHAC1fnW1vCwCGhlVVPz8GPNiP80RWbmwK0ZhOQ+vUlhcLb
         q1EWAHWRAftTbkmgG8s6zBOLZbF2AsRlKKAlUOp+kL/pXSRGwH9G9AgcrTbUgT2eH/UX
         VLkNayRVkL2KMNEtbPhy8f8UW1HEar7JQLx10G946ovCDT4Fl0lemdxAgSqXJFc1OXkm
         daY7xDbrnO854MYm0GY3HxlsjKsckTYU1MHjitWqCZ4WSS1GIa1JYLx9kbUfHqYG54GR
         r6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760455003; x=1761059803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Aftt5GDndW+QmwWYyCYRVm3iyK5ExICkKwljxAsMHQ=;
        b=Is6jYG1/jRXD5OR4avaCwiKCWD7TaM14EvpjDTxS2MSp+XwdazXUSooTha4JfBhfJK
         EcL6JE2UnkdoHIjopRwDkgy9HU1E4cbjRdxhty1vGjtD4l37XmYBK5G2xqqQcW/nVXec
         J1OWXFFN+xrYOVwtflCiGepU3BILZ+ht72LMrlc/kv9n+PwzwmcuSN80vqtia0iHVUJ7
         Ru/WTyA9oCkGCGEn8OJNnStWmWZUfgvgaQy1ad8hsGLfuG2AyOnmIfoT0ClIKTSq9Fbv
         98VH1jGyGwpnj7uNUalYa1eMuuNFNEALd9j3e99jA2Sc9oVFRPfiArAWhTXmA8dvuFNZ
         dtyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX83UaL3qHV5p+CPMG47neYPbMrYEP1gVSNXWINvaYz29T7+QxQQken84cDzL5pEb/AsP9OuRZgJcL+RZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBcIyEOgGmQc20wNI2+A/Z07erwqj/f9hcnKM/vf2BZLP5CRCJ
	UEL6x47eoW+JjamO7TN36uXfCMJu56l41GsyaObZVDsjL0k+F+MeCMWS
X-Gm-Gg: ASbGnctN33adwlOb8pnHuF0NbhShLUetXybGuOpBMnnUSXJ1PPunaqfyhwLtvBCTfgq
	ZECmF25gFmfrFZe+Xi7CMW8K3JLnbD9Bo2UH2u4RgMm74LK66dSZSVbHvTIap+H7SrWKW/hFeLE
	9R6UTxt3IPtV+A7p+DjZIvvqpd+wvNs+ZZ53stCroDe9qCP16N3mASouO1K0elDEOcF1YEgIhvy
	VnPh6Nb7xQ/RJHV0Q3dUCNFTqKN3gsvy2OutHWwREknjQgHOM7+/bRqNKl4otAj5sx+1jo704Xb
	pLiCNzRnyFcZFdJ+ckSkrM7pbN2IKVwm4CWDOjcmYidSa+PuuSsE3QSGWe660y+FiKGgHkwgGZV
	wR9xxM/kaua27+fNKk5X7wzSTZPkb+s9RqI5Ngom4UKl7hyrZOJnXOxYtaic8lA8TgHL6aKGDOW
	k=
X-Google-Smtp-Source: AGHT+IHcO0k1gdRh9Ik7VrSifzpnxsBG8UUPfwEIqiLV67RhkTa/m4Z90iP6pclDPdHI+s5aAf32eQ==
X-Received: by 2002:a17:903:11cf:b0:269:96db:939 with SMTP id d9443c01a7336-2902741f404mr296208995ad.58.1760455002711;
        Tue, 14 Oct 2025 08:16:42 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08e2dsm166399205ad.74.2025.10.14.08.16.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:16:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Tue, 14 Oct 2025 08:16:41 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Cosmo Chou <chou.cosmo@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, cosmo.chou@quantatw.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: trivial-devices: add mps,mp9945
Message-ID: <9ea2885a-0b86-4166-9a24-e7aa7918be23@roeck-us.net>
References: <20251009205458.396368-1-chou.cosmo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009205458.396368-1-chou.cosmo@gmail.com>

On Fri, Oct 10, 2025 at 04:54:57AM +0800, Cosmo Chou wrote:
> Add dt-bindings for MPS mp9945 controller.
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Cosmo Chou <chou.cosmo@gmail.com>

Applied.

Thanks,
Guenter

