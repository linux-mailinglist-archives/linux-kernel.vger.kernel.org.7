Return-Path: <linux-kernel+bounces-859198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76ECEBECFE5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 14:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31AA73A3879
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 12:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ABC1E5B64;
	Sat, 18 Oct 2025 12:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HuvH1QPM"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189E5274B23
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760791866; cv=none; b=eo0tKPv9xsGH6eJSjyI7/ymvBDsFg2VUBLoPJAr51YBk5kZAxzf9fWDu02GVGoPg0RHBPZcbRGFiEJmHWjrFh9vHvJL45FXClV6Lmz/xZLsKRhKSoE8dT/YL6CBpTjtV6RcbN7nZYF0iEk6t3Yq6piT1cF6ZLyk7PjaIP4Xd2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760791866; c=relaxed/simple;
	bh=V0ieA2RnANTRzHxRShpkIoitBOjKt+gysoH7B0foc4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbeqyvNHDaz5466HpiE1Fp5bqMn2oW4pHfOu/AKyPAgb1R77Z+YJpcLGvB2jPWeP/MqQL+NXG+fTpU8W/1PiFBtHbWhfsaYNxRFfRjB65rMT7Fc0Zm4jQRwKlCQtT9cpMt3AtFEUlx9FxvvkhPxtILX5NwJ+6QFHvOlwhwad6ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HuvH1QPM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-290aaff555eso26758145ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 05:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760791864; x=1761396664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vexsKddPKfSOzGf6IKpuorb0FSpK13m//qSzSr6o0Qo=;
        b=HuvH1QPMGhHX0xbDbQ8i4BNDkZKnK5KqQqQnc2cErr/QpeYi4JzgaE04MEy11fcHId
         NTFwTCqG3kVTOGv4gzKPBLwTOIpsZ7uDehCgNEIF5FH3Ee8bHNXUbWUrrGrUZlIoZMXt
         8k95xRu0ysJCX86tzd3diN8b27En8vbu6pl4vgEQgivespG/VsTSOfb4itZ+q3paeVr6
         g3SmEItZ/YkeKIIrJwZTbySmTrRKWQ3ZF7wr8miAD7gOsKw+LiKcqmyFkOfUzMLlVryK
         gw5NXQJnuTfjAcE4SNUbuXR6Y3jzPOkRFX+w4l3TTZwd1BhAsHsA3leEbxZUaeq2ayKZ
         BhBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760791864; x=1761396664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vexsKddPKfSOzGf6IKpuorb0FSpK13m//qSzSr6o0Qo=;
        b=SMTS4w+LqF23mkSp/Id5UXnXinhYd88LUPQ4MCgAjnqLsichoOjMdWrrRwLvO8HzDB
         6I9yLlld4IenV3gTHSBARqe646hXku9TJaTns/TiwNIpbOuYfxSW1g6bxA96kIc4q31J
         HVNAKERaa3HInxX2hbrtBlucwKATjoTyl6vcFEY3D2QXNwIvJVHS/sbt5np5+gGRAVw2
         zFIb/swGaNqkz2Eyh0Ik08gnvwa5+P8p5lLtcpP0zWd/D2rkhHbQvAoDBX26ErzJY5wp
         QFVZObil7CnF66W012Wd/pwQnqui/LP3sWeTfyfPRnnlLGkzjS3MGV7jvcKQx3knhYBz
         CfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWjLB4eswmwp+vZ6/FL6HaJ7jcDf7GWtmleBHXzCN2J2JJ9tp8y58xs6hQmQxA560+EHa+9xznnUnpoQEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsuX4/YjylgTDVt9DBaXDyIgHWmIXAV0txF7Xv4KN6/nk6Kam8
	cTSci52Yd5U59I6cbLdoZabSSjaSrJbYsY7USNslsZBbZ8D6gp92+Q5g
X-Gm-Gg: ASbGncuzhkO7he2TEZyqSRPBAgobJbANbjdtpUC6WaY3yBA+BEfLPPIZzg9NWMqrgSM
	YvNaotIUAgHLhefmSEN0LhpWDIHOU9OLqx3daajnudvhf9hj1zv+ged0sS2mLBkPn2XGNkzmIMN
	ewrxju6lzfVwfEjrYjbynjqQ2zvSLbc7ND/Hylj4tKDDGVjWbiUiNxDSQnrmHZyKSwiukb1uow7
	KTKjkbbSPJxGm52kk0cw5MYQ16vrtnshWr7IUliitEnvnEIp/vXBG+bCqDpUQY0WObv71dmsFVW
	4zy0OubnPHA9rAqc/95H13jrqwiMZh8PR9n5vqLhydtxwp/tMtCNFFS6tNJ1fB/nLAiNBQdHYp9
	/URLPINvMocDuxHBrrqEBCHeBETxWtjiC76kfu9AdbkBf/6Tz+/oqBur/47NG90j4qUDHe8wvUE
	sjfTRSgUzN4dgvz5uHECtbuMk=
X-Google-Smtp-Source: AGHT+IGSMaPLmNa5+i+Ae8ZNz30JQlwuaKA6ceTbDUL3cL8yRFO4+dERw6BWu9+r+C/GQRQnRay3tw==
X-Received: by 2002:a17:902:f70b:b0:283:c950:a76f with SMTP id d9443c01a7336-290cc2f91d2mr93086815ad.43.1760791864324;
        Sat, 18 Oct 2025 05:51:04 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fed21sm25570345ad.80.2025.10.18.05.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Oct 2025 05:51:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Sat, 18 Oct 2025 05:51:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ankan Biswas <spyjetfayed@gmail.com>
Cc: corbet@lwn.net, skhan@linuxfoundation.org, khalid@kernel.org,
	david.hunter.linux@gmail.com, linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 3/3] Update maxim-ic.com links to analog.com
Message-ID: <245e439a-7077-45b0-bd34-78ed0a573a07@roeck-us.net>
References: <20251017105740.17646-1-spyjetfayed@gmail.com>
 <20251017163501.11285-1-spyjetfayed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017163501.11285-1-spyjetfayed@gmail.com>

On Fri, Oct 17, 2025 at 10:04:31PM +0530, Ankan Biswas wrote:
> In 2021, Maxim Integrated was acquired by Analog Devices.
> maxim-ic.com & maximintegrated.com links redirect to analog.com.
> 
> Update maxim-ic.com & maximintegrated.com links to analog.com links.
> 
> Signed-off-by: Ankan Biswas <spyjetfayed@gmail.com>

Applied.

Thanks,
Guenter

