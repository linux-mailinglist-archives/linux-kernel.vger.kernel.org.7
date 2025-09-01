Return-Path: <linux-kernel+bounces-794587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CF6B3E392
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E8C04447A3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2171B322DD5;
	Mon,  1 Sep 2025 12:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fkGDBqbw"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE0C33CE8F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756730530; cv=none; b=RnlhHDd6VTa0O1PyEGjNz/bvcmCpRHmk4gwMKqySOOZLKnMaprt3KhAActczyQnMLaeIQYcvKI/SJcJ68xfqQvtVC+R2kzVG0TxTc7PjfTffzhj/0f64LJ5S6irIarOtDwlNRKuobfBgnMl8oq3IYVHnKVXkZ4HlTHl10Q9pywY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756730530; c=relaxed/simple;
	bh=gOY5Dw0yIneTkFl1rkItoGut8jnz7U2o1MHv+e5ti3A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQ5EBHBsaIg1J5HBzez4KwTq6WI8F36FRmFO6TexRrULEXjAwdFKU8fifSQEMjfMw7G/AzUYgL/v8Y5eaQ+raeySsSKLvp/rXCDCSXK981DMpxrA30lEieqoq9fziMnNVM3Q1cpcuhK1R/xIO7NveNneA0t0HfFks0qa80OmEF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fkGDBqbw; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-32810c57437so167390a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756730528; x=1757335328; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gOY5Dw0yIneTkFl1rkItoGut8jnz7U2o1MHv+e5ti3A=;
        b=fkGDBqbwbVx1jqYUUbvKxG2knvXhOppSurcXZL1FIvXkppVLUmKmLNZ6ZNpP+RUg4i
         rhHp28hKESTfa4Cv4t/QwXJfzzblA04/fnZ5tYdq5EWoY1+Ck77gpYwGJ0wlI/RNt0J7
         TBi7Vem42Xg+aWoj99j0tNx6GTap0iGAz8RfdwmTedMxEDharK7k4+2/lXBc1WexBEJP
         YYFIx97AEDrtV/Qf2J+B8Dh0xQIkPCVt2GjnK5MgOD0MiH9wmSNXeAre+VL4fsZpg6p2
         2CQ7u5g8Z93vgzC1hztwdAZ8GmaCZkH5gwVQTs2+hP/5BTpqHB4N0GpfXpA5r0qzHd9l
         COQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756730528; x=1757335328;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOY5Dw0yIneTkFl1rkItoGut8jnz7U2o1MHv+e5ti3A=;
        b=S5Famh2v+X2NC0KpbeBkcbr6e7H4mkqx/lxZesRt5cZiUMOrNqu4291F3SHKX82U9U
         XHzmn7zvYVCI8whGGcHH/+wR0kGCpm2UL0+CuSRCKSAkccnsd9dAx5v/YSiF2KHhfsfr
         8j1Gz3ocV2YplL7TlhWT2jbuo+SnWu151bh8Tiz7EJNpsYFmWx5Fld8UdmVB0m1RFkVg
         utGBynaKO3QLyPIv5mxluRhazibqpOtpXfLlXU1yCgPNPkX2uCnupEp5lH4efI22fn34
         cSB8KgypTDQeq1GZoydITyYhiA/CZAMdGLchwmSbpjtl6xlHuLTLGcBrilZV3jqKDtL9
         NCdA==
X-Forwarded-Encrypted: i=1; AJvYcCXgwui9GhhsDDS3MxQpX82HlyACCWp96oKYENhAdT/aE2aKvh56wPTp708nPQPTeael3lrX0feYINl9PIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Rf+Ph31bpZWSzILVNnirX48cqRQWirSfiUwQorQgJXxWLJIR
	xw3O6L8SpCbzqJxg3da9bPVzJgzTna4grLD2uaD0MNu0izFcME1j6WEV
X-Gm-Gg: ASbGncvU15XdWbGtnhBdnF5LHAJdXOPy5k1MXaj/LR8E7DZ3ohNQSUak6P7USQ265oM
	IqaYs9pHA5j10SPbtZ++KWrW5uKnnJh/WDVuDxBUIDONOJiraeluocNbFejKWqKmEygmLdGN5pZ
	tqWxzE2liMuES391q6mZD6Ul53KBTJn2GvXLhtnRU6P4VDkqcaIxTl31eswKsbrgEQDjC/F/fzj
	f58qJXDGpuunBzIBrQX58+fvLAI0wcmyFzCMFql2Hoo55g7tI02fWoW7y1Lk39EDPCfG/Pjnz31
	6BpoNjwnv+PunR/rQFnKFmYY/8QSrIhVApI53gk3gyXzxMwiTissd8iHJqAiJJOIuz9eRBBRYv9
	cbZY1uekRhzhfddq9
X-Google-Smtp-Source: AGHT+IHUn0SC6xICje1UUoFTPSuAjVvF3tBb8TKjXdcRcJR9Br1XsPEsEJrd5UjL8hvq4o4e6MFvaA==
X-Received: by 2002:a17:90b:4c4a:b0:327:e781:3d37 with SMTP id 98e67ed59e1d1-327f5be1809mr8219063a91.6.1756730528211;
        Mon, 01 Sep 2025 05:42:08 -0700 (PDT)
Received: from fedora ([2400:4050:d860:9700:8e8a:52de:86af:cfe3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fce0c5dsm16686640a91.21.2025.09.01.05.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:42:07 -0700 (PDT)
Date: Mon, 1 Sep 2025 21:42:00 +0900
From: Masaharu Noguchi <nogunix@gmail.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
	elder@kernel.org, greybus-dev@lists.linaro.org,
	florian.fainelli@broadcom.com, rjui@broadcom.com,
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	dave.stevenson@raspberrypi.com, laurent.pinchart@ideasonboard.com,
	hverkuil@kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: greybus: audio_topology: avoid
 -Wformat-truncation
Message-ID: <aLWUmF2fDUyerjps@fedora>
References: <20250830173850.323897-1-nogunix@gmail.com>
 <20250830173850.323897-2-nogunix@gmail.com>
 <aLWEm2sQpmoNYLAC@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLWEm2sQpmoNYLAC@stanley.mountain>

Thanks for the detailed explanation. I understand your point regarding W=1 warnings and string truncation.
Based on this, I will drop the previous patch and leave the code as is.

Best regards,
Masaharu Noguchi

