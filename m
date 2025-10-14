Return-Path: <linux-kernel+bounces-852801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 021C4BD9F52
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 16:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 157A1501D62
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 14:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CCB26E158;
	Tue, 14 Oct 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qTZFJ8h3"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A40265606
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760451326; cv=none; b=Zo0q+FWKAmWE3vCQXzbYtNenFa+ZQb1z5UNgVn6JSay9QNMzFNCtmPRcNQwsmkB3H9N1NEv5ulJ1qAhdrgn7u+sMR8LjUqHAID3IWeQrj28u21/EYhaXxW/kHkbEG+PwR97uQm81f2Ch5ziUPiV+MQELyINV5X/JU/HcWAn+LSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760451326; c=relaxed/simple;
	bh=JJEvsdx2EKYhgF4ioQ2Hnp5mKA4ie/BqmPFrQ95ZZmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZRh/GuyCX+oFgVUq8gywezTMUP9oOIjEJkOcsmkHGiXRmzFeQv4gS8sFX1XSJPJrSfxgEBDlJ/3C2Ic+5MvQjrm6EOHUvEVBMVX1L/Rc7vjlexkBetRzpFA7GtT3tPxHozyQNQ0oCQmBbGeOKehjNiHuEoKRLIZUECH8tC3ug4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qTZFJ8h3; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-426ed6f4db5so523931f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 07:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760451323; x=1761056123; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5vRSRvvpcXw0lckahk40k2dwuwYW2dWayzhYRmO9OLk=;
        b=qTZFJ8h30nWtcQeZIqoS/Pj1Qn8RQwBbUT4GjdEauR//MDLmVWd7+JrSnqhHDcOlOl
         xqUqosN1InOTR3SLEoP16c03alJG0Z/O7TfG7cmENIhC8KIUrfSq5EyKBvtxblAJs9Zr
         NBkxmMtErerSKKEo5QwC3fh+pnXQu0hU1UvJUYLDGBpYDgQbpwZUYib2mgZEQM0avq8I
         wfyL8ErvSg4pV9LEoxGZVcGEXWMnqEOwltY4uhMezW0ESN/q8csYPKawK58s77r1JAM/
         j3gqwG8G485G2QImPoELPj2xvwBhQcyM4Tx8T+J72DhpAAG5KXCRqobyGDaVIxNcXHtl
         l9TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760451323; x=1761056123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vRSRvvpcXw0lckahk40k2dwuwYW2dWayzhYRmO9OLk=;
        b=vVNdR5Q2qGsCO+zwd6fC/Oqfy4GEcBoEuvmjKg7s5YDqrr1CcjP33gXNr8/O7dyXH6
         QUU9jH3R8tB/fZzMJVSaluZPBPtSCDOzlRge6ppReFiYIXVCaZf10h0GddA4HNpnVi5u
         rmR2S2A0ChL6mqp0+M4WsZQLDrZgouTiSTzICZLXlUhVEuhrOkDZz49n2WXD7g9wBe0r
         GTHB2uooi1F0crkv1WH875FVVfIW61Sz85wMaBYUn6JlJb3NV+Xv9lHNgkg9Qog65rR9
         6YceewuO6/6BpykKhnEegpTxj2ohtcZv57UtLGoBATjv9/nfc2M9blSIuIYuzs6YCyPk
         3Qww==
X-Forwarded-Encrypted: i=1; AJvYcCVsyPxl/QfjM9wvBizvNE7pTxBpAcGkTTUhqo+uxCEo+nQtB1I46GrTzmwlaALmpIc8QTasvJ0vyKaW6aE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzivLIaxkvFlOQyFHFapnGHMY08PqzmKUiNRwvH/a/t8KhdsyLg
	xxLgHJw+3RXtxvpWgAeNBl8YrspjbHn6sdZ2uzM+FVZbHugbwLgBm4PfMrXebd1A/h8=
X-Gm-Gg: ASbGnctbIX6vER5sBfheM94DWmOM2peZUh2KxWLi3KMmUfiHhK7CTf98VICDfizFYD+
	FqOKB8w3v3QIWqCMPVydyBQ4odOwViGZXCtL6TWhr5dgtytyxujbq7CIwXk1cBEMV2u65I2Xlro
	meuGIKR6plnZ1x6L8uq32/TreRkHgUIlTvPRlBe6jnnFT/P2ZNLy7v1wyhcYu1O4Z0Tv4rtaw6X
	lEU+0qe/RIqmurlVXcdx34J3kBJeWQNJYlOkCeKJEoeQgoxuWnr3x6NQrjZLHDSD001yikBMFDI
	rCxU4rjuesiXfcFY2ahPHbOVbtCh79Pfotr0/dIU8+z+ROFrIaQlb0KK/dUs8F/jnli4VRgamec
	v/mX+Ah3TJZJBGZbuEdtAaZmQnvm5PkZYncBldmatdXbWoKOrTEEjqx4Y5FA+zQ==
X-Google-Smtp-Source: AGHT+IGWbodeDpSgzFoLY8qVHoIv4GluIBqFgtel/+kqrsa8p0+/YdDB49sS6YR0/0Tn+4xOCMMzQQ==
X-Received: by 2002:a05:6000:26c9:b0:425:57dd:58ca with SMTP id ffacd0b85a97d-42666aa6384mr15765996f8f.8.1760451323183;
        Tue, 14 Oct 2025 07:15:23 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-426ce582b39sm23589081f8f.15.2025.10.14.07.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 07:15:22 -0700 (PDT)
Date: Tue, 14 Oct 2025 17:15:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: gregkh@linuxfoundation.org, johan@kernel.org, elder@kernel.org,
	schopin@ubuntu.com, me@abhy.me, greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: documentation: replace strncpy() with
 strscpy_pad()
Message-ID: <aO5a9izAISpCDJrc@stanley.mountain>
References: <20251014134148.2597178-1-vivek.balachandhar@gmail.com>
 <aO5VvrKTswmfO-n9@stanley.mountain>
 <8918310c-d0aa-4e02-b9d4-9aac98b0a48f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8918310c-d0aa-4e02-b9d4-9aac98b0a48f@gmail.com>

On Tue, Oct 14, 2025 at 10:01:28AM -0400, Vivek BalachandharTN wrote:
> Yes, Dan. Nice catch. Building it with below sample change:
> 
> memset(&intf_load.firmware_tag, 0, GB_FIRMWARE_U_TAG_MAX_SIZE);
> strncpy((char *)&intf_load.firmware_tag, firmware_tag,
>         GB_FIRMWARE_U_TAG_MAX_SIZE - 1);

There isn't a need to doing the memset()...

regards,
dan carpenter


