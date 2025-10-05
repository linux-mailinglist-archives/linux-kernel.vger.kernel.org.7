Return-Path: <linux-kernel+bounces-842271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE600BB962E
	for <lists+linux-kernel@lfdr.de>; Sun, 05 Oct 2025 14:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E0BF1893A56
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Oct 2025 12:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CF72877D8;
	Sun,  5 Oct 2025 12:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCGfqsdE"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3812877C3
	for <linux-kernel@vger.kernel.org>; Sun,  5 Oct 2025 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759666972; cv=none; b=Oj5GpgcVTVYJ8D6KDEl8AFvB2ZMfNFVCX0FKHNotf1zH0BSXGPlIY382TMo32tgg3Vx6IT6hFwgbWux2nZ/2Izn5ST88XaSGoMd25Ux8yASzSffznmdMFxPWkWEDmO1xxm+DjKn3J/7oOaURCrQBCdbd/uhgbYGrj0Q+Xhfyl9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759666972; c=relaxed/simple;
	bh=xCCjpTo0Xm1Q6VB/DT5XzgQNr1xoL4KQI3MIBUtOwKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJifaQcHJHEWxC+RB+KKPkpS/mfBf3Xysu6PRfskAKG0VSY5uKg5pld9h+DToHd+5/KMfAz5KvVTji8hRXStMMkgTUOxmEmixyuOUUEHevJ1DJi6obER/0FERNoBfWvjuCNEws9bP793wRlq6UWPNdngcHhN45jywp0jk8HEwkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCGfqsdE; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e6c8bc46eso24319045e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Oct 2025 05:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759666969; x=1760271769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xCCjpTo0Xm1Q6VB/DT5XzgQNr1xoL4KQI3MIBUtOwKg=;
        b=HCGfqsdEJ/LCuaffupzO+CcDo2KGtRFVizTbjDObMH7DVR4QnedTMWbyck0aXBoJgF
         dIFUzENFFwtE5Zce4nCAvsWuWjco9YtZDKwXf9+yOUQ/cYlUadu5k53QzwfizapydOZz
         +fQCWzRH2zxEFKOPFYYxBk0D1vbuG1sx5bQdG9ylgs8X34clpd8DspROafLwUt3s7R/5
         L6BKidS4lJopSF6OIUvTi29LazN6YPWgg8TcpR4/R4oW1M0kcZnuYpHtTxSIVs6oOUAD
         1Uy1Mn6daeo/tiaLfiyLw1XMK6+aOH0v41hfARjhQno9aBCGdb1wlJWp+uRf0gzxdaEw
         Pzcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759666969; x=1760271769;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xCCjpTo0Xm1Q6VB/DT5XzgQNr1xoL4KQI3MIBUtOwKg=;
        b=HG7Wb/fkQVr68Dd4IBG7PaxCdAbRF2E5oJXokms6sH3CXm2+h2uP4cHkicBzeU2saC
         seqw4BRIW6Z6dkig02ueNveptp+15GBzU2t41/kNL595iT2YNdu2a4pWZ367wqADhAGg
         tFtKQBUFlRqFXDzigbSstejMivGqbY6SmibKPpBnzPr7I47cYawUF0qxl8yv5ot8Uc8O
         NWFNlNTAxxJd0l9Iqdcy8EKiHA4pH/frAfe2b38rc3mFcg//CAgb2flTHk75OCgRhVGw
         i8fYKKdK8H2cKCE9WgE2NFes+ip6bUANJgwY3EoOzPGnU96gZ8NPJ11aRWntCQE2/OWI
         QHtw==
X-Forwarded-Encrypted: i=1; AJvYcCUIemphBevO66AgJ9L++wqB0d3Z/K3QRaY/k9uByDfRWcSeQNL2wOM2b6bVPfM0mOKEReq4NQpBiziumNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlwWDs7yYCxMRtJbaT5taSjWuiGMpRQok/0hwqyGR+mi/hsv/f
	IZOCyvcBMlKce7aLTgcOXBGSl0Obrgwx7rvptZluZUyJjJWfhKqZu2xr
X-Gm-Gg: ASbGncsFavH4mxIFuMy/Tdh9MvhDvD+af4vMoz1orJbYV4eKqte/8ysKUnaRwHnkolv
	f2xB9HbmV1R2bTCCm1KA6OKBPY/+Lb9Ds0rFDZxBPtVeWNLIGKa4UHDFJAnc7fgfJx76tyHtsH3
	kHlGIhKfzkONK4LV/nn80c2fBhIG42SdzZLiLsBXJFNp4ACgN3Z8FgMgC5bjr+3zG++/RkC1GWT
	85ENNIdOxcwbK/ps1xMBfdowXgcMJJC2yrvy1SIc/0n8XTl0wrBFMljt+QF8vJl5z0rZfEqnTGl
	/Ej5S2Rmoka44xey0IvuB/Nh6PLd1uBceh52AoNKK2jltS3QPpMa3O/yXhVqwCBPKpIR07qM/Z+
	/U2DMVinJjm4jTL5plg2jG4btIXMgskjLSdzVxwwKRGMWmfiKajvzMTxSFh2T
X-Google-Smtp-Source: AGHT+IFauZYrcWKdkKAjjqjKwWod79ljqaANmBQBFKDSTbXLK/2mmthdIJvXaFH9DzC9ZGpdamDCBQ==
X-Received: by 2002:a05:600c:c4a3:b0:46e:3dcb:35b0 with SMTP id 5b1f17b1804b1-46e7110401cmr46951695e9.2.1759666969244;
        Sun, 05 Oct 2025 05:22:49 -0700 (PDT)
Received: from [192.168.1.121] ([176.206.100.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e619b86e1sm204632165e9.5.2025.10.05.05.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Oct 2025 05:22:48 -0700 (PDT)
Message-ID: <34852b92-a859-4e18-ba2a-c3cab814c2b8@gmail.com>
Date: Sun, 5 Oct 2025 14:22:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v12 8/8] platform/x86: asus-armoury: add
 ppt_* and nv_* tuning knobs
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 "Limonciello, Mario" <mario.limonciello@amd.com>,
 "Luke D . Jones" <luke@ljones.dev>,
 Derek John Clark <derekjohn.clark@gmail.com>
References: <20251003185520.1083875-1-benato.denis96@gmail.com>
 <20251003185520.1083875-9-benato.denis96@gmail.com>
 <86282444-f489-49e8-892f-46ce655030b5@oracle.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <86282444-f489-49e8-892f-46ce655030b5@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 10/4/25 13:42, ALOK TIWARI wrote:
>
>
> On 10/4/2025 12:25 AM, Denis Benato wrote:
>> +struct power_data {
>> +        const struct power_limits *ac_data;
>> +        const struct power_limits *dc_data;
>> +        bool requires_fan_curve;
>> +};
>> +
>> +/*
>> + * For each avilable attribute there must be a min and a max.
>
> typo  avilable > + * _def is not required and will be assumed to be default == max if missing. 
Hello and thanks for your suggestions!
I am not understanding if you are suggesting of just fixing the typo or changing the phrasing.

Thanks,
Denis
>> + */
>
> Thanks,
> Alok

