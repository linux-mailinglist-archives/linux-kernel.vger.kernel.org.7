Return-Path: <linux-kernel+bounces-794556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C4DB3E341
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 14:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 351E01A82C86
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABF535083F;
	Mon,  1 Sep 2025 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oc2ZllkY"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B3A350833
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 12:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729867; cv=none; b=DsTv+Dhl3JF8VH++B+UYvHnMqTirwADNryTJpnhqjcZ1C3x2CEOag9lzpau/0VUv5Scc/cqX7FkkuB66jvpmwmVwFH9kpNMwfwME+xyUoXVIfR/9Hbnnz8I3dSBGV9OVGBpO3U/0x6Q4vwm1i0zFN61Mefc5WR/pEqDxEmA7ZkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729867; c=relaxed/simple;
	bh=QdiPPLZWJJB7/3u42OQnI20Eaqu3AwluA7etN42m9mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KaWoYysGD5pDdZ40Kikv7NBnD16CufbAhv0pr7xb4DKwEA/yLbgB0wrPjPPXRd8Vc3fHXGhEIDc+KuyGi0YM7vls97mq23eaH6XvRz901H1q0aVBSXtR8XBuppxqji55XRt/TNn/LRZ7Y8XaEljT/DE4pQq9qA2tFO+UjsibKMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oc2ZllkY; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-323266cd073so416382a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 05:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756729865; x=1757334665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QdiPPLZWJJB7/3u42OQnI20Eaqu3AwluA7etN42m9mo=;
        b=Oc2ZllkYUsNBKeeckqKOwTcFQCvfjYKDqoiAkwv45nwtPbba2xqJWqzlydGh0GWjiY
         MsRujOO5DcB4AGdwigrWbhcAqhHHBp9GZdeW9FhznBx4lFHU6zyvw9ORiplIF/fAceEk
         5ozA0tM6VqbIvRovyP75HMV6gWm0UxADRiqG9i4fJHY2T8DuTDtA2zST6d3ZUDJSGYWs
         lujtTAvfE6ZK63r2ZyOepd87cNmqrhZtVMtdGvF6XYwNjewZHsJZcrhHFw0k/IqjEuMK
         Cf8leHvsonWXgw8WP2rpV+cMCFtoTNwbSDYkDhYFiFzK5h3QMXssIBBgc0GVXIFcB7Yf
         KzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756729865; x=1757334665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QdiPPLZWJJB7/3u42OQnI20Eaqu3AwluA7etN42m9mo=;
        b=oZhqfHqQQyYJcEr9lRNzifBUCZP3KPqyOZK3Q7UjobN2VTg8bZ4MQCFaZJt/n1Yaop
         EOd6bHdR7hYFXLJ4ATUn/Ked5M2dbjNfvB9dVln8o7Lyvz9BrDszr+/vGET1w1nv9KBe
         o1UIjEB63bE+3KUzHofq0EhUCt4ujZHBfURppZeDPdrS6e0bzazXRub6I/FaAfjdHz9Z
         YfEazYNLPX9l/BixiyIh6nuwP2Pa3C/QD5dJfTyzzof3jSIaaeiUva/ozqaTMAkoJpOX
         IhsaG+UhCwY3qXbmPob5Usbt88OkrYbmruV4xSN9w3CVGkJMYA/FEUuMZt6/hJyPqhzZ
         IQwA==
X-Forwarded-Encrypted: i=1; AJvYcCU0+eMJFktBh/hvsCa2fLtwH5TbmsofbF5FMM83W8+jRcJM8MtkWeAeMQtc02X72dTAbllDZCj5r5abqNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyasFGf9TQ43qkU5vumPy6qjUU4qdkAYDpicUK6+w1vMxgzQr6b
	52MHAuBysXCbiS586/tbgmFd5GXmIVsMlCvkphwOWr/+8G7adLMYyu37
X-Gm-Gg: ASbGncvuPqYPN3i9Ky9JSBYwZtC/MBfASaNdKFFOmHUJVwKHKm6PExlrRZVmvYojreD
	+xW7wYZvdGiYLjlotcRzQ6on1V6RMXvpMsM8oPhWU4Za2ynJli1e1r8WkKmNjALn8b1xbmkeSw4
	22yqHg4Gkh9JzTk0OO5b+TZesk8OMpyPw+dg764ByNF4+OMKlaQBS021MzkmTTws/idPCApx/ML
	gJKLn9irH4AlM5DfumeU5JESK8l0QSZkDLnZfN1ZFFxnSqfKq3QUv85MwIZsZCIXLYxPxSedhXS
	crX/SjAcVAyUS+fh/0xms2U1RbmAA0nM/BqdYMuCKh+6iCKhqSSlvdxJxhBF7sof+LDaW+8mbcK
	JyJZMJMmqNejGM+Xn
X-Google-Smtp-Source: AGHT+IHuPeIgSdm25HDXIhjWczun9s0SrO4hSzN9HThHTxxeNAPcVKH5+g+uW+k/rl8zuQL2W/L6jA==
X-Received: by 2002:a17:90b:1e11:b0:31f:11d6:ce9c with SMTP id 98e67ed59e1d1-327e666d073mr7238986a91.7.1756729864986;
        Mon, 01 Sep 2025 05:31:04 -0700 (PDT)
Received: from fedora ([2400:4050:d860:9700:8e8a:52de:86af:cfe3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd28ade38sm9252219a12.34.2025.09.01.05.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 05:31:04 -0700 (PDT)
Date: Mon, 1 Sep 2025 21:30:58 +0900
From: Masaharu Noguchi <nogunix@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	vaibhav.sr@gmail.com, mgreer@animalcreek.com, johan@kernel.org,
	elder@kernel.org, greybus-dev@lists.linaro.org,
	florian.fainelli@broadcom.com, rjui@broadcom.com,
	sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
	dave.stevenson@raspberrypi.com, hverkuil@kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vc04_services: bcm2835-camera: avoid
 -Wformat-truncation
Message-ID: <aLWSAiAA8Ombi0WB@fedora>
References: <20250830173850.323897-1-nogunix@gmail.com>
 <20250830173850.323897-3-nogunix@gmail.com>
 <20250830212923.GB16364@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250830212923.GB16364@pendragon.ideasonboard.com>

Thanks for the explanation. I understand now that this patch is not needed.
Please drop it.

Best regards,
Masaharu Noguchi

